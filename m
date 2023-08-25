Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7DF7880EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241513AbjHYHe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjHYHe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:34:28 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6A11BFA;
        Fri, 25 Aug 2023 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692948866; x=1724484866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pwj6GpE3fgzy1TgIsSvRT6y5eaO8o/QlFOkdPEm6bdE=;
  b=Qv5Z5ymoOnYb/2yT71Aohj/v5kVZ87aSYqF3sA45CMICgI1P6rOojYQi
   5/vcN6hGVvOVhVgZ1flmuudEr5a2utjm1TB2WseJBUV+lSk6f2c0ek8K5
   Wxp0Wuw72rp8GDQzK7yxynhUlfGy9iZXse14PtPdNHTn+cl9qHK9a17nI
   1728qpluO7irF4N/qEhCZQzsfV1ZXpOjy5VUxR5jEclFnlkMgoSYrAiSo
   iDa21jsOzojlRXPcTy2dC0QBk8fth6PSMhy8OrDBUQ+W7RESyG5EFVwaW
   x5GrYk2Z+7lLT462ynL9xSqM4rufuev2OZ2EpuQFbdPNbjyYl3/UZuyTh
   w==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688400000"; 
   d="scan'208";a="241968735"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2023 15:34:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7+SjaySY+z7UWCbfGLWu15c3Yirecw/p5wqd+bIDYFqjvRLkC9kTts8mxSmXBHLgWsbAVlm/oQz1l+GCED/n0ecB7rwgh87U4T1LnnMajirBAGRGF1t/kd4Qu8yrPT5UVSE7+zGL0N6xf0oeXLE02fry1qe9RuLn4OqHtDsnVGiVofwYPGj70T4HGBnuYgim7NtWgEQC4dJ1SlBEzYabQGrY0QLubQCftcC9rVjP0sZjm19rgo3qkRgIHZWGvc5+bbwJDtkCwD5IXTATG1ehGO7J+iCHLW/erQafu5q9INuhzu3oyBbUv4UFj+vLUYznjBItVQ6S9Xx8r1lxsnHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbYQ+2ZUdFoPH0difqSZCkBTJsyt7YqdmClB7GMD2ZI=;
 b=Sx4s+feb+xD1cDdR0Vu80d/tKMDhXZSDjcznRzPZARTss3INh4ZJdzWYfzDPJpjSNrJMnDrcNbBAivS4e54oXGYUzUQNK8rbmeRZaCRjTpHtWfwPvVrWhDyPPuU3kfJvH/a8YYKJhGfs3lJmmHvjJynOmjmfU8JpvpfOB5QTp+W2CzBHU2VPdGCe5qlFtgg5LiSfAS55NXB6GA6S+xWz0gYWm5ACLpyD0y8ely5Pzf7U3xkX5yiqIwbbyqmgi4UmF/tibno2SlqRFywZOedfurHwM5HY8GU0i59mgEazhBG/0xtt3scaeF+fijMoafdl0AeoPIj02FiZ/lMt5eICtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbYQ+2ZUdFoPH0difqSZCkBTJsyt7YqdmClB7GMD2ZI=;
 b=XdCtd7yi88N6iaj/qEERNAAMIoYlE3Q3HsnrYHWiIvL/hvzOi9pUT0GahelLcvaUtDqI5VOFVYRCg9v/aOPemvlFxKeV35w3FbQJ707NETwc+x6IP2ykLi2DfrFcRTfeqx/WvBv+eUs1Oaws7I0jxiSMOM0ZqDN1TumRrWR+/OE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ2PR04MB8986.namprd04.prod.outlook.com (2603:10b6:a03:567::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.17; Fri, 25 Aug 2023 07:34:22 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6723.017; Fri, 25 Aug 2023
 07:34:21 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Bart Van Assche <bvanassche@acm.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Thread-Topic: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Thread-Index: AQHZ1NQBelM/0wps2Uy83of5WKTqEa/4xwsAgAC/9QCAAKx0AIAAYPoAgAAPCAA=
Date:   Fri, 25 Aug 2023 07:34:21 +0000
Message-ID: <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
 <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
In-Reply-To: <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ2PR04MB8986:EE_
x-ms-office365-filtering-correlation-id: f0cac214-39f0-442e-b1b9-08dba53db2c6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GYjwxHqR9md546cX3kxnV4r3m/sYDxD/FXWTl1u8H56hP0SizfIaIXOGjx4koA4PdyERj/YWXXUHBWDW9rz1sakRD7J2U2fnxBBJT6+pY8/aTkQgNmJ7PYeYPQuSeKU+XB2TlN7KFZTPdHTj9NKbb8GEe8xsP8I/6LZFZxxUVAy+kY+xF/BakqVymkaScq4ueJZ2zI2XAIiXJN8WLN4r5kWAmyLRXYwOYYkYl0oRZeaJhNMeNZMcrj9XLVuU8pimL9bfYUDJQdxUaO4rhnpcJzihgTDG1Gw1BhIi8f9DFFrRe0W9LfIe52j57qOGtzTF1qvNwKcsUuJO7SmyMCs03OfYHuO5xS3d9bLupuEpJvcbnOP+z5PK5EVa8kb85j8Np1IBuNEhi9YyqJNCymD+Z1K4Tu758uzuxZVHPh6J4mJT8M0+//uAwoM+h1Fc0/81fxa3WpMDfQSjdsZ78yay9lcAPYxqU3C3WTYI3vy4tQcWQXj1KdzzB10yb0N7L/Ia/KcP0g7hrTwxmn27inCsf9B8utIdc94jOuMcdUUbAysc4ZPFIHosYnJc5Mx8aWcw+1OEd2IUdojJ2J+2ZYgvJNwGnmY94flhzSSJxtmS0KIlEAdReeiN17C/ljWYsZKDU6uF+eKa87ArnZTTP4XW9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(396003)(136003)(366004)(186009)(1800799009)(451199024)(5660300002)(8936002)(4326008)(8676002)(83380400001)(44832011)(26005)(71200400001)(38070700005)(38100700002)(82960400001)(122000001)(66476007)(66556008)(6512007)(66946007)(76116006)(54906003)(64756008)(6506007)(33716001)(66446008)(316002)(6916009)(91956017)(478600001)(41300700001)(2906002)(86362001)(9686003)(6486002)(27256005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qS7pxOPT7mvic4eJK6qXOQ42Oku0dA2l8pgvlcDlhs48c5pOKzdNFfHvKzkM?=
 =?us-ascii?Q?ObX1vusq09rLdavLOJ2BkeGpvXUT+KxYeQ+PMxiKufwokJCjyR2TCbGoj8WS?=
 =?us-ascii?Q?rtZCgyuqm57bTshe6/+toclxQDWBmo52s/xt+dF7E9G/wTxEkheZIvHuqCqB?=
 =?us-ascii?Q?aA/5X73s62pm/Yx+F4EbJT5g0nHMPrZEFSgZ3jgwm25Y+HIOMDgWrwKV8w4m?=
 =?us-ascii?Q?BjtdeCkuRZxJJI+jA+QhjJy22CNvZWq9JqfESH5LzBYU10Mjn8dhOOSq7mH+?=
 =?us-ascii?Q?Nb4nOkGMzE1xgG1a0JAi1RAGwflkUSpADTzDO/+NQ+15/wid3N870px0frrU?=
 =?us-ascii?Q?HMhd8oD7ZY1gcVdwARgNKpjJjmIKFQ6uoSwpO5TaibmAs2aOzka20ltLwr+j?=
 =?us-ascii?Q?q5Zs0MlPXb3CNX4HnRj+OQcmIjDz90naHRTaDLttYr0cAtmutZQykZ68oxGr?=
 =?us-ascii?Q?e/GCxzAZ2teLqCLOcDnls5zbflkkqoR0Q12GyjHCLc+UUyDTJ+JYKoVeQjCi?=
 =?us-ascii?Q?nu8JL2HVqlHMKFV2a8fz6A+sZxcSsBpoMAzcuwDi0XCbzMaCKZp8SHMNKdmM?=
 =?us-ascii?Q?UVraYF6J2mK+TjM+hjNGI/csajQNEteDNNx3M/a/UYwp32VwYdkU4gOnf59Q?=
 =?us-ascii?Q?jOGb0ObX75njtGrjVGtMon9Q+XTrQJAkvXkUfpDbKteHU8ULUwgVneF7nZqF?=
 =?us-ascii?Q?Ys/nq5K9GLullcLSdn32XLhAq2Goe66O7mVOk9KkfVxjE0LUt9mWNQR5RWRK?=
 =?us-ascii?Q?pwCPxCQHJYpm7cxR9YSCt3eGrLWR7+b/cbzmvNnxrkVUw9efyE0hwjXq7IPN?=
 =?us-ascii?Q?/CNAxcHGE7JmnA+2ran0doWOBJQn2H+Ekr2XHH/yPWKy+zcuStHwjQ+lEVYS?=
 =?us-ascii?Q?zjlczT0ZBWYfDzVO6TcsbdJsKBkYoVKAblg+996mEpvwQOHYvEmeYoN/EUfc?=
 =?us-ascii?Q?T4Q3AvbEFPqJ9vCTtL1jpO2CO9T4zqIbeinhBOSEfWy2K6Ve3F68QqTnoq9e?=
 =?us-ascii?Q?8kFMiiUl/HREtsm2hIHbp/rtSVhoPBPyCH0/pJBDrYunfaIRbQVj/Cc1dNRb?=
 =?us-ascii?Q?SR8RF2wzhucGasII66jThyoFJoKYCknGTKIC/RWkj9U5h58o1MKtjzBhIbP6?=
 =?us-ascii?Q?HPoE2lTWOpUaCw2buch9kBXf+En1UM6rsNYNR+hPKK78wKFERTtgEDJ+2ESK?=
 =?us-ascii?Q?hWZJED7U01Ki9KN3Zhcati/BmiH/TQCjoAIaKesMxNSSfAx8kqs1bdjuEqX3?=
 =?us-ascii?Q?ZOV7S93eJGGBn63K4oclZhhgc7wGV2CQ3ZM+sFBuSaHN4y0GWewuO7uu7fSx?=
 =?us-ascii?Q?98tXT3Hzx9UsfdgK66uZcF6kiAsJLVy50OJmiR5a5wbYWQC1IjkgEbuKY5AB?=
 =?us-ascii?Q?nAPzQunodrUI9BEySbR3OR2g+Uo6qjuAVinss/5BQ+zc38FrbJo/4b0zyKp/?=
 =?us-ascii?Q?6dFegsX5OhAl/WAP4VRIlndUHk7nyuBy/v98Ys/TNH90sLjrqdaTxVVesQ+x?=
 =?us-ascii?Q?X48Eugq8+1qKAyY1OsTuv2nAy41Q3qEuNVBdXTrtl/Qlb7aEoFVZcbODo+lM?=
 =?us-ascii?Q?bqKNrgkR5KQM/rBYB9V/hY03LW/leotM4eiu3oAT7JSV5cfMt30Di3YoBPK0?=
 =?us-ascii?Q?G0l80W5MF0Vn3y51WBtnqsQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB354E0519E313448D7AF45561307E5E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?L2VuVJdMuayZ+W6ap8Ydys1jBEP/HHEuwIeipH39sOCH0guJJl5h+Sg4qPEp?=
 =?us-ascii?Q?6+vTY4IymTGBEgtmlNXSkEGw0+83zLC8BWHa9p/oWT1ChhNPUfujvFHMy55i?=
 =?us-ascii?Q?huNuYRFbJav8OBSGmUCTFIhi/K0fXESgbKH1LZBUGdVL0533XaG5VrneSv1a?=
 =?us-ascii?Q?qSEi6lRqKaattCeFUL01jtGhquxSzWMrx3U3VFVSpGaemPVKRe8tbrwS19s4?=
 =?us-ascii?Q?gjc4D0HnghNEOZGIirugWWxnGUu0sQDrPL6Fq/Od45DQiESBRvNLHKY9Jktd?=
 =?us-ascii?Q?zNSwRHwQIiR3IN/SM1bN2p5y0S+Awt126q45yCZSjZg7J3cyaKxzbb8zuJQ2?=
 =?us-ascii?Q?nsvUZc6Br5QIVe7uhqLP/DvBDtLDa7uHQynK7AOHjRUrjalgHbDad/7duRFP?=
 =?us-ascii?Q?gw/oRGeeuFWqJDmTQK2nbFTXSB72Cyx2heR4tLi7nkd84G+ICb0iSV4uqXdQ?=
 =?us-ascii?Q?UWWcFm75sGEZSzEE1YgIYQr4fOrn306ENHwjKwKi976Utf0X8nbW5la+Ldry?=
 =?us-ascii?Q?3sFXuRrbh5kZmOGBvT1hy2fWLnk2dGY08oA7u0KW/nz99luX2DFdUzw1pHDJ?=
 =?us-ascii?Q?mi5LG36cXlk3pJQNB5mIoCbmC2CaZFHgUQbH9wi9suqdwQL0/4pnQE9I4vWT?=
 =?us-ascii?Q?kWEVLfimOz4HG5ed3YQRv+v9IA6UUw1VBpvejwecNp0LdOV+cQcgPcF8AaE7?=
 =?us-ascii?Q?XNLvbybHRdrXGzFojFE2vY14K6F64GRmMIf+3liNRUNrgVz1/xqCC3enYSeq?=
 =?us-ascii?Q?/1n+pcotGeE8wjr30DdRrvtSku1qB9xOS41f7w6lTKkC5hj2tNYRU9hhlKyk?=
 =?us-ascii?Q?Ksp1buLHsvKYQMJvYoCzG1eJtOkhY6mGMe8+6AQS9lGaZlQHnqTnSWq7yPrW?=
 =?us-ascii?Q?2NNdIQW0Vdnxv71Rh8gHccjWr2KteEmqEEiHFPOs//Yv/s2uPkWyXA2853Qm?=
 =?us-ascii?Q?GMOa7ClPiLsO+rJbBtIUCg=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cac214-39f0-442e-b1b9-08dba53db2c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 07:34:21.3657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBKKDA/mAdmEgitZLHw62zHYYLtUNnRTZ05hStzV7rDet2VxU8NVWJOzZmop5xbupXB74Sz0L0rpwX7Fk4P5jRq6n900kk6C81EwBKpjhpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8986
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 25, 2023 / 08:40, Daniel Wagner wrote:
> On Fri, Aug 25, 2023 at 12:53:26AM +0000, Shinichiro Kawasaki wrote:
> > This works, but a bit ugly. Another idea is to make one of the optional
> > arguments mandatory, a positional argument. I think the option --device=
_type
> > worth making mandatory and explicit, like,
> >=20
> >     _nvmet_target_setup device
> >     _nvmet_target_setup file
>=20
> Possible but as I said in the other mail, we have a lot more of default
> arguments to functions which I would like to drop too.
>=20
> > This will make it easier for me to review which test case uses which ty=
pe.
> > (This might be against Sagi's comment, though.)
> >=20
> > Daniel, what do you think?
>=20
> I don't think it is good strategy to change blktests just to make
> ShellCheck happy, when we know it is broken. It rather have SC2119
> ignored until ShellCheck is fixed.

Thanks for the comments.

IMO, SC2119 is not broken. SC2119 (and its companion SC2120) assumes that b=
ash
functions do not have optional arguments. If any functions which refer argu=
ments
are called without arguments, it complains. With the assumption, SC2119 is
useful to detect missing arguments of function calls. (I guess Bart thinks =
this
is useful.)

However, when we implement argument parsers in bash functions so that the
arguments can be optional, the assumption for the SC2119 is wrong. Then SC2=
119
reports are useless. Until recently, blktests had few functions with such
optional arguments, such as _init_null_blk or _init_scsi_debug. But most of
calls to those functions had some arguments, and it was rare to call them
without any argument. So SC2119 reports were easy to suppress and not a pai=
n.

    I doubt Shellcheck can be improved and detect if functions have the opt=
ional
    argument parsers...

Recently, you actively cleans up tests/nvme/* (which is great!), and introd=
uced
argument parsers in test/nvme/rc. The first one is _nvme_connect_subsys, an=
d the
second one is this _nvme_target_setup. It looks for me this is a bash codin=
g
style change in blktests, from "don't use optional arguments often" to "use
optional arguments aggressively". If we apply this change, we should suppre=
ss
SC2119. If we keep the old coding style, we should keep on enabling SC2119.=
 What
I see here is the style difference between you and Bart.

Now I'm tempted to disable SC2119, and to go with the new coding style...

If I have any misunderstanding, or if anyone has more comments on this, ple=
ase
let me know.=
