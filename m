Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2573F76661C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjG1IAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjG1IAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:00:07 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3C549DF;
        Fri, 28 Jul 2023 00:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690531164; x=1722067164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vtYxLkJGsbrGsJN/Ko5XGqhzkOu9mnBOjrHlphkfZ7o=;
  b=CfAvr8HwrrKVylhGjYgnsVLcRhzvXpzSYOqdKRASSL6CqGGO5VTq3lAR
   Ievn1DqKqxdt5CeYirx4MUvGXpquuVEA0vJryUXFMnEiKlvPLY6lV8wX6
   /DRRDaF0v2/ZUAfJiBvtXiRXlqEfzC+LgfuaMFfLNWO95bHxjlAwHBNtF
   AIH0g82PnPRhWechRH8akMmVgVURjlZYdAphm4rkPSYuNXX5GMUEY8PjD
   IQervFR9fxOKy2sLfrpTxEShS1X9Jh+uH5gEMbZQ4noQcm+6mHdrwJJrU
   4E5cDoMGn2IaiY56KovlrM9b9FGWA56OiBSWfE/5DYQ4mBvUot6eCBfMP
   w==;
X-IronPort-AV: E=Sophos;i="6.01,236,1684771200"; 
   d="scan'208";a="351358056"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2023 15:58:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnqoDf35JnWNA476vOdEAuZCboO5pkLlqZoghpUBlh0J6FW/NJ05ZxEnlJqOrN/DSuSd3JNIav6JyChtjvVKB0mcGga/HV3oQOzW3J0ekqdwipykTK06Rv0m2o6QIeaO0Gxqdt2csEGQcR47+CKRilL91r5F+0B/H/ReNd3xx3WG3mljJ9oI+sB+HgG8fur4XZLFbLWc4Jxm6FNSYE7bO1rVZGB3qJRNjJU+/+xX1FX4O0OjV1MJY4SE5GiZvV+c6p6jjg7IQcrVSRsx3QR+c8S+95GJejq5ycMF8YQx0hajKxJdGROUofjk8AYd5LthHoJnTTULkFsIjk7GzOadmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjiOCv8zUawaqJoVIr2YjltRYhlABDhrAzV7MVIW23w=;
 b=QUHvcR7Ni0c5SX/etu7mf7pIadbldvlt3+/0VgR1oGsSYtJHmQYV64FsAcUCDa9FAOb/ejl8ILwsdY49wBSqaTTo9Tdxofpr3q7gDj47ddOEfyQBX37I5/a4DR5841PlcBnf5RzpNbM3vPygQ/dVzRteqNHuALYyk527hI+ILIaXZTR509wmBimhpYiLveUE64aIilFSjwqx7gEo1yE0cEfrOGav7vfi+/VUFPUntXCHsqZxF5pbNf4zIwWvKSeHz5vCTAks8vRZEk0n0coLbuF9M1JJq/FQMvN05Tell6NY8TWPHPK/PYylCWoe210dE31g4wpmsW2vYlkiGAWtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjiOCv8zUawaqJoVIr2YjltRYhlABDhrAzV7MVIW23w=;
 b=NSRDkhD/LZLI8SBB+ljhryFibt/Y6RV11hx2wVrWJvUzP9v+KuJu+LD3uTcRMcmUbGvV3KD/PUH1JOnMZxHAwdGMQj9elO6Hzg827MEd1PTRQyAwNcSN5RXF2c3m3e+5rKWrR+sMnhtkQwx810/OPwNuYBpUYQC+DZ7cpwLWWQM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB7066.namprd04.prod.outlook.com (2603:10b6:5:242::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 07:58:43 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 07:58:43 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Bart Van Assche <bvanassche@acm.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v1 01/11] nvme/{003,004,005,013,046,049}: Group
 all variables declarations
Thread-Topic: [PATCH blktests v1 01/11] nvme/{003,004,005,013,046,049}: Group
 all variables declarations
Thread-Index: AQHZv79EpGj72imkKEOvomc2O06946/MIqMAgAERAgCAAIgcgIAA5zkAgAAcEACAABQLAA==
Date:   Fri, 28 Jul 2023 07:58:43 +0000
Message-ID: <k3a5yedxk2xxobv7p4ieiyzjbkz3boln3y3hi46hf6agjkd4qp@yqhjcq2moxhe>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-2-dwagner@suse.de>
 <7e4f6c51-43f4-c039-07bc-6724748a1d3e@acm.org>
 <kya2ayzcgz7iemknkx6xuef4m37f2ms7rt3uxamtxr2w7zbwfc@onladguxa7bk>
 <c3bff0d9-957a-fbb7-a433-4cab457c62bf@acm.org>
 <ky32xyzyii2c5fr7kknyx5z6fikvh674v4sw2s4yux52l4vu7w@4nqmrmyxkwmw>
 <mg3z32g6kzxhlazrq6akjdm3ggbdqswz4jfeetazwuzcdfrfug@63a7rd47q32v>
In-Reply-To: <mg3z32g6kzxhlazrq6akjdm3ggbdqswz4jfeetazwuzcdfrfug@63a7rd47q32v>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB7066:EE_
x-ms-office365-filtering-correlation-id: 88f2da57-a5d1-4e34-2c95-08db8f4076b6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LyD1zkcYGDQjIKN/s8Omvcf06qE8gVPFQbZQHV+WwoST7uSQR5mCv+W1+1xhqMHPXtLcu0heX8J/d/cd7q61XQh2KtdcFYF5/N6IN6svxGWPnKuZRGuc/eYA1UtPKkYoU6dP3/QXAICUdbgVrweQ3DFVaoS8Az8mRL/rQHovgRGrn39ofx4SYArKkf3uS9+sOHLR+NTrCLx+iRk3y2boKPsnNb8hycjW+4Hvhzaj6u5s/tBp4E/DpNhJxu+EEfTRLWtdDzOEzLWGQI1vhwjtACVCGGfc7ok1C5VMBZ8OZoamUhpoCjGd3pIvObRpnTjNjc0K0PjxzjLAhaICrf47UGECT97zyKukxgfoG5EPQ7vzuUcRjCTJeaLKvQ9pPpKeMsvtopyZKTRRrTlWVzT0HoymOrrrkyT4yTY/KAn0f/4eFmMCsddCEhe+VDoMKlnTY9UsWhNJXWMq6GuyFILX2kZO90+KM508SYUjPTTSrwzUVlGxfUjIN5ILulZ8o5T/clZf+egQU/MaXYnfK+LCfdkr2QgJsyYDXIy7hrj+8IZkP/SbvTxGqqhwR7A+DJWr2lSXyRf/6SVtmk077k5GS1EWECw245pSUxRdQOvktuw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(66446008)(41300700001)(33716001)(26005)(86362001)(66556008)(53546011)(71200400001)(38100700002)(478600001)(122000001)(91956017)(966005)(9686003)(6512007)(4326008)(8676002)(6916009)(8936002)(186003)(316002)(66946007)(64756008)(66476007)(76116006)(6506007)(5660300002)(7416002)(83380400001)(44832011)(66899021)(82960400001)(54906003)(38070700005)(6486002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K4j79MZFYF1d/xYnYAW6rytZckZGgBVa+ezVDeaCbA2oOe9JarhvHFPDoNes?=
 =?us-ascii?Q?9zKI/m7JgIBDhUX9p30H7O+8kn6RKoZgDAI19Aos916nGqCN/HguXKWxdPTS?=
 =?us-ascii?Q?3a0+N2cu6EZsD+iYfJCbsZE7lcp/qrhurfJ97zmiNjA30pk3IvBGmQHdF1uR?=
 =?us-ascii?Q?DADO6yIoK5wcBSkutqQa3aPGjUn8O5O/3B2oNzwQetOKQA6QBy/V/DF1l8FP?=
 =?us-ascii?Q?69WgIeTJ+iIztH4BDBji88iuSJLTQyfId/B/WwpSVFRVSGmybFY3hzOiSJxE?=
 =?us-ascii?Q?LlQ20F8NaTuO9mOmv+iqYwv9mUg+uK+Zia4xbjzKTeCr73BG1IW1GYpkbNNk?=
 =?us-ascii?Q?I9dSA4+alWS8LV4I4q/XKp7TBLruSLssS+hhhEK47e5KPykwic7XJnskJQFl?=
 =?us-ascii?Q?4gx6jvG+RVjFkRpsu6D8x38eRe+nkpKGaSSYed+YxotbSxpETSC7oWwlzT+z?=
 =?us-ascii?Q?Js5lnWQClj8mxf2njU0vh48gv23u2NA7Jv2o5yc9Ce797kuIZOEK+xSlwfuS?=
 =?us-ascii?Q?2fQpC+SmeCn0nCiKNJl+SfCOfZbKNh6U9lSdWWm3z17jbYp2L222RDJeWW33?=
 =?us-ascii?Q?cpyrJgOymYWkmkvAwECwHSr2X/AznoSwxE0ikWo6B2VfmdwAm4gxl89ShOBY?=
 =?us-ascii?Q?U8NHk1WFFK2rfMhW8TeYwiiBQoC5f72Zq4kUz7PNDixCOC5z2Ti5VUgB5G6A?=
 =?us-ascii?Q?LhcY1s6YtlTKjssqUImBAWR5LMTsRJGeR5qUw1DXc1xxsmrdmVFt4WEtcNNF?=
 =?us-ascii?Q?azr/ObLchz38ODXNQUOvs5MkfsgB2ASuu2IOMkGFYzDl4tTkvQbS/PKXtpb4?=
 =?us-ascii?Q?5tGG5WGLgEUEWhoCHa6kZX/26wdgrDXqZn4f2t1ked9sdB5iqbivL7SbpU5N?=
 =?us-ascii?Q?jYeqIJFRy5jLCUu+WlGJez7dOyXROq1vxPO774DyX9VYhwalpVtMBpEjy9um?=
 =?us-ascii?Q?IPcCtBjMRPLZ6o15/9vRcmdDwYlUddOH1vc/m9QhQuURLGcXEw9O7/zRULSn?=
 =?us-ascii?Q?jx88guxHFYqGvHmZnsFky1m+gjZ6xENr97TGVyzRUI7iz5SIpyZYRFeEbvsu?=
 =?us-ascii?Q?JaEHMYRBX3FBLEMvzG5EUBFRWOG0q5Jvlf/tc1EyQqOD6uyGu9BBMc4kD3nx?=
 =?us-ascii?Q?gS+IPV2TQdgo+P+5bHItA2UjUhomvEoqKuLsZTIqR06vLhCYOlEoKo9LQg57?=
 =?us-ascii?Q?kfcYP4+HWrenbkwwaJq/r3jg6/A+0STOkIoJ+rnYl+0v1zkkb8EwKO8j4/Rz?=
 =?us-ascii?Q?coa9RgdEiGl0H0q5D2w3vGwuuJalUcPZR0oxtPW2ipeing6zzqHFS4oR4i8x?=
 =?us-ascii?Q?FaMcH8XLtzRG8S8jMViFfkgfbdlSPkRi4FrlYSPjORI3NC13Vvl+XZU/tDdE?=
 =?us-ascii?Q?aPSy6vEYzBtO2dP954WvA5HiMXvhqalC9rU8qmSnHEo8DhHp7Mo4FHNgW5Um?=
 =?us-ascii?Q?OsAU01yqyTYadNc2Gkol/N318wrVBS7Z8Ob+4FKSBelFjJhaFcxcIjZVnDWf?=
 =?us-ascii?Q?X6HRG23lGqMCSNJA8SKJeT8kEy+NpqWUo/tg1lVp/rvHfdjKtY6PPT+KWld/?=
 =?us-ascii?Q?xbV1i9IR2Wu7r5M+wnXfa1YQY6/TfGNFtU7EEsW1F6Ryqclib2JPAFQnyuI3?=
 =?us-ascii?Q?TknUwH9zMvAO6/z5YqM7Tjc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98FD9B37555310468E3573FC60059E54@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wzg+z8FqL/s6SUPozC+6D7ZPLFaMFyn8vIyNqfSGsjU7CxxAeoIXjguR6wYj?=
 =?us-ascii?Q?mzGMlRcHtnacUuQ+UrFYth/671/7aDfMZNb8xZVuA5UfIv7c7UH33SBkrlkc?=
 =?us-ascii?Q?79gRGmjk5wEHt4Y5EOoCZBPUPNuoOnKiuVuMz4RyGFhrJ9SRDiRa02ZjrFKx?=
 =?us-ascii?Q?cmmFoEx1B0OWYMmw80GygifubeGvR46gvD70fuSMD3e8zGRArP+vaB0bjbfl?=
 =?us-ascii?Q?wANitk18ItwX2nLmw5WPcbOxnWsGvVCQFXZZ/JZUZbNWB3ZvnwDqrvOR5gBT?=
 =?us-ascii?Q?+sxMxZ89cDOsJ0YWNsckYObgN6H+FCEvFOIpGMeqNuA2l4JAeXHehMKxz19F?=
 =?us-ascii?Q?23ps0orrttsF1IFUd7v5c+0SoCgGBPYEQx94FlQN4KAIC0ABQvyEK3HrSLfP?=
 =?us-ascii?Q?agPpzhHGnu7TU+A4cuUmF9y7f0Pbi+WvONjakEopPcU9eoBMGeYz2avnlvGf?=
 =?us-ascii?Q?GoU8X+0r0kltGOY+2xGF0r6iK0vnrKDHD5kAbP6IXd+AFMbe4jO6NnJKyI3x?=
 =?us-ascii?Q?6c6WUttEufvOyMXTwnCJ1XKPrBQe+1B6F5vS9Me2KfXqchHaLzBgaf1ZVJWV?=
 =?us-ascii?Q?KUNpg6wYJLgkSHKqinKaywu/qZba46/L3/crAf+RtCdpGBzNdd/llgSr9D9m?=
 =?us-ascii?Q?lxkXcJ3YTf8Vfij+5KGu8zga1+4WrBZs8Tj0qtipXnoucHZfBAAHcVSZUwsz?=
 =?us-ascii?Q?cxz9zqg9sdTU+Nwtz7VhSk+KTO5YhgPSCMbEgAJr9MEtDO5LctAU85Al63lr?=
 =?us-ascii?Q?oeTS2tcY/jGRitu1I4XCeBDgZq5a7C9fWYfXQrrTyjdjqJU+LuBC85EA3pBk?=
 =?us-ascii?Q?abTsO9kNumM0ei2wUWor/RsGg+w2ZGpf2T4jlv+MNuRNMhmdT9SSfou0EWZ0?=
 =?us-ascii?Q?MgEO0p6Iv2Ot6+MyldxBZkrpNHGx1mBvfGL29ooHPJVkGkT6qLSBZW/1hVuS?=
 =?us-ascii?Q?jJYBDyIraHoA4j0K6mn5DA=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f2da57-a5d1-4e34-2c95-08db8f4076b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 07:58:43.5093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9uW3LzpvpTfna2ptguDdjcIE+7PpVHVbyOxOGJmx9GrbVqWThM0FF2QjkMv6PJCL5Bp6+0LSlWF1nLkaj5wIZ9YLuPX2ya7IlX436M9aiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7066
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 28, 2023 / 08:46, Daniel Wagner wrote:
> On Fri, Jul 28, 2023 at 05:06:34AM +0000, Shinichiro Kawasaki wrote:
> > On Jul 27, 2023 / 08:18, Bart Van Assche wrote:
> > > On 7/27/23 00:11, Daniel Wagner wrote:
> > > > On Wed, Jul 26, 2023 at 07:54:24AM -0700, Bart Van Assche wrote:
> > > > > On 7/26/23 05:46, Daniel Wagner wrote:
> > > > > > Group all variable declarations together at the beginning of th=
e
> > > > > > function.
> > > > >=20
> > > > > An explanation of why this change has been proposed is missing fr=
om the
> > > > > patch description.
> > > >=20
> > > > Sure, I'll add one. The coding style to declare all local variables=
 at the
> > > > beginning of the function.
> > >=20
> > > Isn't declaring local variables just before their first use a better =
style?
> >=20
> > IMO both styles have pros and cons. Declarations at "beginning of funct=
ions"
> > helps to understand what the function uses as its local data (pros), bu=
t the
> > declaration and the usage are separated and makes it difficult to under=
stand
> > (cons). Declarations at "just before first use" have the opposite pros =
and cons.
> > This style is easier to read especially when a function is rather long.
>=20
> FWIW, if I keep going with the refactoring (providing helper function to
> setup/cleanpup the complete target in one step), most of the tests will b=
e very
> short. Thus there are far less variables to declare anyway.

I can imagine that. Sounds good :)

>=20
> > In the past, I preferred declarations at the beginning functions and re=
quested
> > it in my review comments [1], but I learned that this guide is not so w=
idely
> > applied: xfstests scripts, or even blktests 'check' scripts have declar=
ations in
> > the middle of the functions. So I think both styles are okay at this mo=
ment.
>=20
> Okay, I wasn't aware of this.
>=20
> >   [1] https://github.com/osandov/blktests/pull/99
> >=20
> > More importantly, this discussion maybe going towards "too strict" guid=
elines,
> > which will discourage contributions. Similar topic is [[ ]] vs [ ]. Onc=
e I was
> > requesting strictly to use [[ ]], but it did not seem productive. Now I=
 no
> > longer request to replace [ ] with [[ ]]. In same manner, I suggest not=
 to be
> > strict on the local variable declaration position either.
> >=20
> > As for this patch, it is not required to follow guidelines. Does it mak=
e
> > Daniel's refactoring work easier? If so, I guess it will be valuable.
>=20
> IMO, this is the case, because you can way easier identify odd balls in t=
he
> large bulk changes where I have to touch almost all tests cases for a cha=
nge.

I think this reasoning is good enough to have this patch. So, purpose of th=
is
patch is not to follow guidelines but to "find the odd balls" and make
refactoring easier.

>=20
> So ideally, after these refactoring most of the tests will be shorter. Th=
inking
> about this, I could first introduce these helpers and update the callside=
s.
> Though I find this harder to review because all the tests look slightly
> different. But hey there are more one road to reach Rome. I suspect this
> approach would reduce the code churn a bit. Anyway, let me know what you =
prefer.

The road you chose looks the fastest way for me.=
