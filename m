Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74078BCB0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjH2CLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbjH2CLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:11:19 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD311AD;
        Mon, 28 Aug 2023 19:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693275076; x=1724811076;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ckPwY4R0BHbjLMhHQg9f77ZuWL7Z/vMZiSwBWOzE+Sc=;
  b=CtNWebSHDTjDT3CuH7Z8Nfn+w0yXrDlDssy8ySfR7fw/zCKz+AFSGIlC
   adqqn6iEPClxBYAYC5rdJq4dxix8weDYmI5m2xUaVodfFdCw6K/AqYYi5
   9ExtAqyDEaUdIfF4DkfARtz459vEqFw7LGFNhtPsFrf3VgltGyL9D13Ap
   PvFP2gbVvKafKcPN0CHy9L/Z7OY/2VgAAfCAtYH6rR38orne+234sumJN
   nrwqgEHpOdZPD7QNTVVy+i/FfdxcEs8TeS2WMO5qKGzsddRDMczSWl6yN
   aaKAklPNURIRI+vXRX9uuN6oe3ydGDTdGI+sBCGx5DijfUrEiSL2E1dsO
   w==;
X-IronPort-AV: E=Sophos;i="6.02,208,1688400000"; 
   d="scan'208";a="242311229"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 29 Aug 2023 10:11:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWox8mM5p1cCOp4adwmIDDrxZERdvX6hTZIYN1mVJ53J4btdExwacQPg2MiRRlAfdv3wy7akPPTex0F2GYdKshD8q0FUjRmaN8Szl/t/FFb1ypNbDlpHZj3XNGTdosBcFeUd2PcuGjfV3TepexV5LyPHbkO5W4ovMtqQbLPwkUKyyhxZmnc+wztY0I/tYfZ0WTACZt1JHM0aMtESLNV61lo1WQJOjX3bEs1029Nv2nrUAzdgsgtoDIrrCoE4nB7d1lX3BAlWej8V4y51UbXh/zqCnXii6WLa4ejf8pC1ZFJKrXT2FXW88fCjVWSBA4xi3HO8GgWswfu+vLNV0lxeRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OV0seVuI2DIYdPVg5Z2nYuDr4b9KGb14XV0SgptssME=;
 b=Ay0UmORYPxmPPVdgJKQV1kYAYiwnZ3QFmPqLwK42VdAMpqMmEveG/CE/X8yx6aRlrGf6AZdnyF22cGVbrGrJ2vMTYqZTW+07rY7flS0q5rH6Dqc+4wvHxf08j7JP0i1+tynF4flzzSnh3piVzkwarJwoJAM5wApGQp5/2OXI7hVhTgSupfiyqdDgI1Ij7R9STElJllzMcbQt8aK5+Vli+I/99l2P3pH4hPfCs7PQ20/FBUSMTBQYRjqY7TKt+wwhaK7aAHHMiSmWJIwUQ5ah5deD5OTBn2T94eN2fhtULwNsUNlm2mOxT8hCxdHCE18kCaL54BVnSPRwIbzCa5mXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV0seVuI2DIYdPVg5Z2nYuDr4b9KGb14XV0SgptssME=;
 b=pdrAcQmPd+82llBV5NKt1w1vsx2RvOysQK7R17uXumyc42fTj0jIm7lz8X/IIzJ6oapnDGzdIvfDN9Pwq9XG4gQ8g4n9+9jsTN6YQUDO/+VE9XbvKZK6LAJvObjET90IHEFWEylkWBAZblVfyqJdMJhi7i7eF6re21zM7VPwulw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7594.namprd04.prod.outlook.com (2603:10b6:806:136::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.17; Tue, 29 Aug
 2023 02:11:13 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 02:11:12 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Daniel Wagner <dwagner@suse.de>,
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
Thread-Index: AQHZ1NQBelM/0wps2Uy83of5WKTqEa/4xwsAgAC/9QCAAKx0AIAAYPoAgAAPCACAAGeugIAAC3qAgAAnFQCAA+SfgIAAuLaAgAAeDwCAAB+MgIAAed2A
Date:   Tue, 29 Aug 2023 02:11:12 +0000
Message-ID: <ptqdqjo7xt5qsijmuftmboutck5bpwm2wjrwks5lr4l44ssvjy@iurtgbaxnoji>
References: <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
 <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
 <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
 <d6ec4e54-1ec9-648a-ce8c-1e08a439c3c6@acm.org>
 <ckuewnzuiejug6jbuxfw4viqwf4v43pq54mj4k4qbq7uz3zwpn@3iijcby24ujd>
 <8ffb6c2f-0836-4302-82b9-902e092e537c@acm.org>
 <txsyjpcxb3baog5fgqdnm5hh765nt5qcbcmllsto7uulyzr5kn@zirmqldhosbi>
 <ed518b56-a579-49bb-b2bb-220214ef6e2e@acm.org>
In-Reply-To: <ed518b56-a579-49bb-b2bb-220214ef6e2e@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA2PR04MB7594:EE_
x-ms-office365-filtering-correlation-id: e5779413-a859-42ec-675f-08dba83537ec
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1pZIOD5hZ7RQZ811H3NFzXYjPYo3yxI1nMgh5qGilOScspRG8x4Lq3/8q7/xRnIUUt3oinDq5/NpYpztBLp13TbKviQA5MVb+iTenffP1NL+3XGTP26Hn/iAXNbTLzpoqeSlvG1U3qYbXP25vs1L3okYaYlAq/ph0xwGHWRweczhZ3mXnXzI3hHkwrDPcNgzOZwu/6OWAF8+16MHrjGRU6KdhooINnQtPJ8MqHOfkO50W+WvVhb0Jtfd1G/vs/SDTjomaeojjprjUM6cTRHRXjU3CtSyfwT0KAVHHbzk5pg8Dqa5z6D4YZ1hs1kJGLvvvYh+3vqqerqxiLuX7mJjx9nSEDt8mQxlG5sZ7gZ0xAS1iheisiC+dQtGpKTH7pRB2CvV1RftPyIizHKqDloCtu9P7jyDCLQTmxLjLFEiJK02qe3UP61DDTuhZxp1FhfaE7ZI/lxqJTbc60Sm896SmhiaLMvFkWguao00mZBEiGVppxE/LIwnxzjRkVslmbaV7Ai1yz8WKELOHUOkNlrnJFrvC3Bcr4VlO8bB8HON2ZpX4JM9SrNLh/WldhZB/NxrWhLGC6Nv92bbOQEKcponH2e5Jx9EsKxVj33mOmCzWar/nzgdJXjoxBP+qlmTMmYG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(376002)(396003)(39860400002)(186009)(1800799009)(451199024)(41300700001)(122000001)(33716001)(38070700005)(38100700002)(86362001)(966005)(478600001)(82960400001)(71200400001)(26005)(6512007)(9686003)(6486002)(6506007)(53546011)(76116006)(66556008)(54906003)(91956017)(66446008)(2906002)(6916009)(316002)(66476007)(66946007)(64756008)(5660300002)(4326008)(8676002)(8936002)(44832011)(27256005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XkosZ0BoXUgoB9RPXl1SbdcqJpx4SGiyDJ/g8EYx/HlLAnurKO6zVdfCK9+Q?=
 =?us-ascii?Q?Nn5KkZTtMymGU7p6NauHcRFlyDjy+VyRWWPu1Umz03xqAxSgrjN8A3uDEjah?=
 =?us-ascii?Q?eXatKWsfJjShFfAtz2s2SG96Ckezye5aMqqqSGiga73E/c2BPe7ivbBPlohR?=
 =?us-ascii?Q?eb6QLSNa/83E+W4ZJKZIL4otmX6vsXcqpTfywDUoNQ7FoLBQRHoPlFHvxZuu?=
 =?us-ascii?Q?IjTMPx1aiIpqwL1gErjM2fc/Vm0YTrPBmcVqREXSyiyycLsMYpNlYvyjcqok?=
 =?us-ascii?Q?Evu35NUnfTDcdQXNYkqGwfTPMDAHQ6g8KKlliHxHtOTsubnHHh84NdWNlHJ3?=
 =?us-ascii?Q?jyHEJpKmSUGVYvVq48gP0dPQjuRPUHgrUiZB6nTnUpmvZ5WZNfI79bauKt+F?=
 =?us-ascii?Q?MP37yaHr4Se2im5x4bNXi/HBlqOb4zZW9g0ZeqIwmEd3/JyjRzYMTsjYWuCG?=
 =?us-ascii?Q?kYXWMN5qOghDmENRSlLPfGheLihwSag6ZcNFPUwAfOV0iZPIyhbNwm7rpGLo?=
 =?us-ascii?Q?dca6D4eRDDjAYGYODpslvPBOapZwVVzhmxyr1UPLqwNiKOrKvpJXPl3eVwEb?=
 =?us-ascii?Q?78k7JsA0Wy0WPY1Yuh0WziwRsLDEJbjxW/mrJv6fz3/+LrGj9Mh5z+0hdbOE?=
 =?us-ascii?Q?TjhG2DGfaTpRLexwkYVP+QaOXY9ZqYoZSU98qVvriDmPWBLfmW52aczDQxwJ?=
 =?us-ascii?Q?UsDuMZ5JMxhcYLTjNs/MD861KUQSImPAOHs4ePYLfKfIaubKvdCPtqy44OUM?=
 =?us-ascii?Q?HuP1Yu5rANToxtrqvfZRkhpy9bQjFnCucIWZhYFEaUyRWM1UjBE8Pi4fieQb?=
 =?us-ascii?Q?JGNXJg9UVyIHWqMNdJ15RoyJpFIYjIGvILSc+Dn6QX6SJwdK7NGwePmfhD6d?=
 =?us-ascii?Q?Mn7z8KBB0wUzy6RdSGNbWtkuLW5ZfFSdtOhkGSY8pHCg0XnZ7fWBrqi7RkGs?=
 =?us-ascii?Q?pjNllDk94s/DohGs8Ja38REm9eVX1jiZYjSzjADnt72bJJXi85QFINPzXImo?=
 =?us-ascii?Q?lLwZ8Fey9gDogMa6/B4rp+HKZMAAN8FAB+6AwHrdGjBzM4jrZr3HfzEGgfj3?=
 =?us-ascii?Q?Te0dD98Q0DVI+O4ZDR1Yk4fcw1HaMdFybybErQyeg+WPWOedKGvlmeCGzAx3?=
 =?us-ascii?Q?ABCJ5tiZ473pn4O5DjKiByz+L0UAqBQ9vq+WUK/0zbnT8FtTdm4HZd4w1BfE?=
 =?us-ascii?Q?I7CGIG35OAv0kZNGBmXwXzgJYZEO+ii+I08Ph7nDIgnjYe/uAuEzoyM0E+iR?=
 =?us-ascii?Q?kG2I9tdnl/w3igbOdCJNNwXhzXGjjZIbi9ExSQtr9g/5EKNF7PrcEBGMeuhs?=
 =?us-ascii?Q?UJ5EQ7peMTpL2zcicEt5cGwnhUcmEA6+A8861NB5zl0aZ4eVXwJaD8VgYR1N?=
 =?us-ascii?Q?u9Oo8/xHvSietm0IxgvtmXncBcdDp/0p45pni52euWz5FqpRPqlh2xWmU67g?=
 =?us-ascii?Q?/bnrzp1Pt7BOHg7Z5pARdbqsKcR9wiU6l8LdKUAkM4IYfnw0Mc5tc+/CqtP+?=
 =?us-ascii?Q?rpsa5bORQaY034TxSIigaTL+RVH0pl4ImVY8XhMK0wIJ+5g6tEDKMdIBYO0v?=
 =?us-ascii?Q?Ae5mEFZfokjSgk1TF8iDvsyLmoWnYVN7AUCxoAjUS15k/td4xMHMeIucLUpD?=
 =?us-ascii?Q?S7RzoZDRVZx2TaOldTEVB+Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E71F38AAFEF7424BA43BB792ABF2B2C5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?aIYMfg7ZpaWlJ3c1+pZxC+XA9CDKlqzmzfGw3y/JKdRlGqBV7mTPYBhLbmd4?=
 =?us-ascii?Q?df4Kijqv/9d1eJ92Jl59DaxWEzm3PY/szeyhMeD7UUkbT8+UDSppwhbh2w8o?=
 =?us-ascii?Q?ndxuDLilMhitwIEbBFt0QkwO78TXh0HEUS4phgf2HHW93huADoxroZMH/w94?=
 =?us-ascii?Q?+wsox91jfMbC+tWTiGzFOktdWZuQUMOGe7eqnlunkvlG9C64I9danpG8XIjm?=
 =?us-ascii?Q?PubaXh7St4jdREl99dAbGVdPdEOXS4Dcmyz3IE3t198Utsq7/6JwZOp9hViQ?=
 =?us-ascii?Q?nk1+BkKTSotCX2nstWj0VZlP38rRSL7qTLG6KTW0+APfB8GemF4HGg7L4B83?=
 =?us-ascii?Q?GU5Ngw3TG4NDTmLM0fQmcpMPg03F39QD656YlCOL5qYWWVUJHso7YwoSrWY1?=
 =?us-ascii?Q?JzIeWSp2uhmWmb4U+qjc2KJ7e0UGydAEoC0ijhguIj2ZiFolK7scTAYWhvtL?=
 =?us-ascii?Q?yIn8w67MV+A9aLgeUrcVWJOlfl05m1zdLzyZ1AbalXTCGnRGG/hgXHScKa7t?=
 =?us-ascii?Q?gcCwroiFUsEHnvRWnjFAH6wl/hCvIL0jnD666mn7zYiO3BZKBllUEr9JJgkp?=
 =?us-ascii?Q?8uTb2G/qbE8YxU5TvPTVB/iU6KZt8x8Pb/2HKKN3pYGPmjttLOZKfVeXjegP?=
 =?us-ascii?Q?rXt4zlUsYNictVK9lcIXIsyj0MwEzdMrHqRwue2RupN/kT/fzPIr73tYEOPz?=
 =?us-ascii?Q?s5hbnugoSjLvr7qSdvPu3Dz0/2CEUgQtwgaTSEuFT3fAwXmYEyjsQkmLNJVy?=
 =?us-ascii?Q?aPnXuKCPbeHmitNZK56bfoRrx8UCrqe+TjpAEcHHXGArQmg/UtWv5BqbMdpF?=
 =?us-ascii?Q?bbGbXwe6uxzOcJecsQgRv7/DQOiFtBbqMyDQYTLPv362f0gZtCW1OEfb8/fk?=
 =?us-ascii?Q?8MdfM5NifF6b+RaSEmCuqF2HW7T1c7FcCDfxqBNA58qHLbZ6vzo6v0TnDKJ9?=
 =?us-ascii?Q?14omLB/t44F1qwv8p0imyQ=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5779413-a859-42ec-675f-08dba83537ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 02:11:12.7623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yfh/9bZzEraKwvNPPiIilMCwE3dR3FXWTNiTtOQ41Gbr5DKym3I6qHl/XN7NeTsIGj9lBUW+cIBCm6lqln5XaNglV0s3CxMqkJne4z8Axvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7594
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bart, I'm getting more understanding of your view. Still I have an
unclear point.

On Aug 28, 2023 / 11:55, Bart Van Assche wrote:
> On 8/28/23 10:02, Daniel Wagner wrote:
> > I am against adding code just to make ShellCheck happy.
> Hi Daniel,
>=20
> That's not what my concern is about. My concern is about keeping
> the blktests source code maintainable and easy to read. My opinion
> is that the ability of bash to pass arguments from caller to callee
> implicitly (a) hurts readability, (b) is error prone and (c) hurts
> maintainability. This is why I think that this feature should not
> be used and hence that disabling SC2119 would be really wrong.
>=20
> Regarding (a), I think this long e-mail thread is more than enough
> evidence that it is not clear what the intention is of the
> _nvmet_target_setup calls without arguments - not pass any arguments
> or pass the argument list of the caller.

This is the unclear point for me. Does bash really pass the arguments list =
of
the caller to the callee when functions are called without arguments?

Looking back the commit 852996fea4f1, you explained that bash does, and I
agreed. But now in my environment bash doesn't. I tried the script below in=
 my
environment, and see nothing printed.

  funcA() { echo "$1" ; }
  funcB() { funcA; }
  funcB foo

Then the arguments of funcB is not passed to funcA. How does it run in your
environment?

Also, I checked bash document [*] and it says:

  "When a function is executed, the arguments to the function become the
  positional parameters during its execution".

It does not clearly state the case there is no argument, but I think this m=
eans
that the positional parameters in the function becomes a new, empty array. =
At
least, the document does not say that the positional parameters of caller i=
s
passed to callee when there is no argument.

[*] https://www.gnu.org/software/bash/manual/html_node/Shell-Functions.html

So I think we can safely assume that bash doesn't pass the argument list of
caller to callee when functions are called without arguments.

> Regarding (c): if any
> _nvmet_target_setup calls would be added in a function that accepts
> arguments, how is _nvmet_target_setup() expected to process arguments
> of which it doesn't know how to interpret these?
>=20
> Hence my proposal to change the _nvmet_target_setup calls with no
> arguments into "_nvmet_target_setup --" and also to ignore the double
> hyphen argument inside _nvmet_target_setup().=
