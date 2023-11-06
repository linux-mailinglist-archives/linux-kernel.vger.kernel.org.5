Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBA17E1B79
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjKFHqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKFHqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:46:32 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D93893;
        Sun,  5 Nov 2023 23:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699256789; x=1730792789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WOCKusEOOwAqWXObvgz3KIxBt2WCiMvrE8/3FMEBBF8=;
  b=ImZnEPVP2c0OKCd42y4TG52kuS70epJs9ou6uxYIOg18YvKScXgAj+u8
   h5oVTGytfbvAlDyte8tLIAEZHjBQjCvympm/1lQRH74hjUaQSMrq+t4em
   MaQNKuyCKZogUtWpn21wj3tSyilV8rSqgFSXXA/24rDrhHit6kg4xv72G
   jBDUXEBhVlTqHXG/YCJ7loSDNVkRDyPdHCfPq43rka8Rrp53LFJqtjARE
   Lm5FvyResYpwCpvKmSpTEaUnK0KSEjFRp9MYkl4s5U0XT9RokATsNJKbS
   gIKokwcl/CVAHhAa5c3dWWmvn5eZozT2jb86xKX6vKdaK6rsXcExHAxz5
   g==;
X-CSE-ConnectionGUID: vmpfM3mDRimZXjd8fVekpA==
X-CSE-MsgGUID: nm1Y0QliSUOlx1Q8lyp+aA==
X-IronPort-AV: E=Sophos;i="6.03,280,1694707200"; 
   d="scan'208";a="1556219"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2023 15:46:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjG/EWSkwYZ6B1eeHoUyNoap/Avxvp4pbCydTz/2pllSP0RqancP96J4X8bTCSi1B1Gbofla828UY+mRvCvTSqUO24LIQ5mlzNE/D1azqXYcqVrg02aq7bi900M3gar+AIlb+Br7THmA+YUMh9zBHLXXvPmrklAK1oQexQPD6skVZ/u+23cmQ/G4JkD8SQg7WMhbTkYGKJL7OavtzA4IysCfRcZ7HpTo/40VsXDtll6COrG8FgCETyMIuxq/wgegmK9vsdKo9aSlY5pGgzZM482M8pqKYKXTxatba7cGPL/jcFo5tyVmPkz0X5rpXTMGdP6/ItP3z43+SO6Qkwmm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jqV+HkcIgVszuKVSfhIGe1l3kgiVMl6lS9v8ckMj8w=;
 b=lmeveBRAynpojX4s9kNnLkcbneiD/uu+u0KD7fHaHYcEGIK3MKvaqyZg163rD7z6orCuDwJNt+EuCFDmfu6ymp8SfxFzRh2JJXifR1mQOfTtYFD+gyOSrqaL4GPaEzyrI3MwqPZR/bGrmlojtZjy3pbH4tZ38RD/uTyHJbR6KJDOGTF9j3g9EjK/5ztPZgqgIkVFBJ7NQ/vzM1HB7ZdALBt/Mf3oMaSZGx4EGQXcF3KFG5Yn4uaX0GROsdGF4MYxgGJD0wHFPg5Uvk18ryovtogkwKgm5t7JKY1rZAfdP7jdGtA2ySgWk4k8MhVFksLkAS1tNHGqn2Gtg0DEpsNecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jqV+HkcIgVszuKVSfhIGe1l3kgiVMl6lS9v8ckMj8w=;
 b=DMh2aNeijZVIje7Ge5sOVoroR30h20NN3ZzLuY3KY889cU6mC3ligpn9PEWaYk3ZBgDJpob7YvazT4dFVEMeQ1xZaDhkKGFg9puJ/Xzr6LcnOij60POaw2e3Z8yu7yk7kKe3eGk22ed+H6oMChbmWkmxLGKwOZ4wdmwk8ZY3DhE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB6830.namprd04.prod.outlook.com (2603:10b6:208:1ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 07:46:25 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 07:46:25 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Can Guo <quic_cang@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "junwoo80.lee@samsung.com" <junwoo80.lee@samsung.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] scsi: ufs: ufs-sysfs: Expose UFS power info
Thread-Topic: [PATCH v4] scsi: ufs: ufs-sysfs: Expose UFS power info
Thread-Index: AQHaDTBL6XyFuKP7SEKHcICUy44BELBs8ChQ
Date:   Mon, 6 Nov 2023 07:46:25 +0000
Message-ID: <DM6PR04MB6575D8EFCA09C246E4A105D6FCAAA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1698890324-7374-1-git-send-email-quic_cang@quicinc.com>
In-Reply-To: <1698890324-7374-1-git-send-email-quic_cang@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MN2PR04MB6830:EE_
x-ms-office365-filtering-correlation-id: 5d1c38dc-e1d4-4e1a-525c-08dbde9c7aa9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xniStWImiHYlsIt+7G/JY17CXnb6tKRWhnbWpnLmvGeDjYiErpdWg1iULiv+rNLRvezS6SRj6f7zn59RjQiDnv4AlTROg+8M6aQcLtaeXdtmsKBTue9kYxypSictzjWkxA1iokV4W6sHXo9ZxtK4etSjSByyzWB6iUKwT7q1j7x7n/VAL+Z52ERH+ORhcvGUJuUM9R1r/VhqVBF4DXzw91td132pPQp/J0gezWS34gJAemDoZqsDXWUXT2QbBV3fmXx7HGsoWMqX5NQ0ROQ9Ep878AQOr1VH7CE+LYUtFboSgZmaiDr0JAX2lpHmDWti4wGQSbioh+symiypenyLaq1Gulh0RkwZRhFHRJtwvZQAhFIIRftIZPH30ccpA9t4KmT+439qmmVhQli3kQtgvcELzpr95dNUiBgiGOzfK6dja4E9P9HCbx5RqRPwNEagAPwnAOrYFZlazGWU3YE5elepwTocEP+ZhVAS2HjQRqnKBGkbgzxJz2Wpfg6ti+HhCBIYBMi6GojLpQfuJ0ucgjP6cecV5uyQIQ8+Spy1yfE5sqP5xe1RfAFgmqNsvn+nU7xvAHUaywIrOti4VGzBGiFyRRhE5lxckr6uQ4jz1c4U0XK7+uWWcO//nU3cl0+E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(55016003)(9686003)(7696005)(6506007)(478600001)(71200400001)(33656002)(38100700002)(82960400001)(86362001)(122000001)(66946007)(5660300002)(66476007)(316002)(66556008)(76116006)(66446008)(41300700001)(83380400001)(2906002)(110136005)(26005)(7416002)(64756008)(38070700009)(8676002)(4326008)(19627235002)(54906003)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5C26Kd58Xwwvs4ANHe8G4Q4FwdbdmVRK1eAe4h+v03PI5eRh9VdJtsqCh+3Y?=
 =?us-ascii?Q?PnIp5mUwwddP6l37Y8qhbljYhFxMeyc0g/zmIq4ETVji6/QEmXSfATZcF0C9?=
 =?us-ascii?Q?tW4+BVrfi94u9b5J/D52u/lR6UapatIYZpGQ21Z+Bg82+AHwESg1w253dJu1?=
 =?us-ascii?Q?Fh7IfLkyLmDEllkg+qAmCychwTyTxmeEzRz4liUG9IYMFCwtYAN3MM44da0V?=
 =?us-ascii?Q?va256dH43uWofEb+Z5xS3m/Kig0en4ObCMUmF794FbTy+iqO6qknci0ETnTd?=
 =?us-ascii?Q?2dq1KZcsgKT+q+Ke0z/Lws+uuSbwKvRC0fWREg/TqbB9kIZjRVkxSw/hlAH6?=
 =?us-ascii?Q?ymImDTOzB/vBdZZRNEYPm+G+p0wg8jAWsWQY7xnChxRZQMA/KTNXzlOVNWHT?=
 =?us-ascii?Q?pA2MFphE9ujr0rnVDpU/+1FwLH7q9tFIlf87LxDBbPbGaZb1094hXpLW44Nt?=
 =?us-ascii?Q?UL/4BIbz+d1TwEalrXjJeaBhomj6TLqWpbaOOkFKEZHT0EnJEV68cnuSjxTp?=
 =?us-ascii?Q?qpqxLvpsdrxE1i/slliziKP06mBWkNI3wUBgtZcuTu/pLv9hMSDpGBDxJeuV?=
 =?us-ascii?Q?24E/IO31HOES+0pZ0y8jXA4zJJhBbMbd1/qrCcAxOUCKZg9/KMyw/cLA45Og?=
 =?us-ascii?Q?MJlXH9lFzo3nNtdjwdzMFlaZwzeXvsmjcaACJFLDcXRvMMiUq5qJTMw+kNIm?=
 =?us-ascii?Q?Gkq+C8+ts4SS6ufS40Bml85b4AVxNmzDJGbqnGXSO5/KAz+LvEGXgtWWqdxW?=
 =?us-ascii?Q?WmcvDd+DDRiSrDr0S0FNpLLWvxUU+bC//atZfHdOCaWct1O2ujV3Pp4XpTcj?=
 =?us-ascii?Q?w+Y/Vn+KQlUwoSmTnBQ3CGeVJqvuLwNrhbRnfe1qhcPOAsFLfZKPym4PFv20?=
 =?us-ascii?Q?PSxYQTNVsJFR/Pne2//nlOjEcsqnzZYjq2WVdhSIuRnRHcqBt8PbZOKEY8Zf?=
 =?us-ascii?Q?yOb8P88scEeosg/OpYRAuvnok2Tnss2P0LimOCgGq10dELlsE3Z9EG4djAyy?=
 =?us-ascii?Q?FkRnrq+a+7cs4LuhjYH/DLQ8JLxwvmq0QCaPgw9Vkg0+tZYZUXWd51zNyANC?=
 =?us-ascii?Q?gALdGpGngYSnRMQT3YZBVZ4r/1cUT380PprsPm4tyO/Y4pD0IlHUkbzD7GL4?=
 =?us-ascii?Q?ehYitC7/D4rnuKqOWlXW19Q5UJpjcA4PhD9OjhRI95YVQvV8TICDVz0T5zQO?=
 =?us-ascii?Q?DtzOB6rfL1JtdIx/DhYBYujLjRCd7atpkJwOYUajanx08lGdtjNjGKr0jn5X?=
 =?us-ascii?Q?9djavHyavw1gQYN2ErKfiWmxrgTPCTZE1Fd/daeiRGh8+tvTV/PCs29DVpTT?=
 =?us-ascii?Q?1DFrXTJlzC3ZPggQwm3ORmEf/rhFOenfCAVLo6tALQ1+c6FybsDNCKa8q6MG?=
 =?us-ascii?Q?DnrK1w04qY7GFlQrCbfwLvBJXlJv59thCJdoHEDLxdavrPQrhldD+/gUZn3/?=
 =?us-ascii?Q?9EyEhaDqN98iPREdd0LpY4alw/O5GeX83MK3G4/A/3+8tx8pEFVcWiCH6zVh?=
 =?us-ascii?Q?mYMhL5tIHIL+TXA6kYnVouIntR2K7qRygRlaQJrkff1Spg/Li7ZxyOGjh5HQ?=
 =?us-ascii?Q?FeZZBSSPL/kp4ohTX/NCLxWcRZHNKKHDVLFIFhoD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?D6RgU4UJ/fVgIxTQSSJSwG+wpmgSsJL5D6rGkt2WjMmbR0Mk86V11RU8schv?=
 =?us-ascii?Q?zzukzU2XjvGjWYAOX2+Qtm6F8fjo0K9tC+hQY1GIhwMuK2vYhq5uBxpYpOo2?=
 =?us-ascii?Q?kG8AsN0qu5wL1g22GzrM/hnE6k7z7lD8KJrlHZzj9gogGAibv+uDfsnuTrN+?=
 =?us-ascii?Q?Rs4WQ0CtMA/791GGg5e2LMAB3mAj4zXIOuYu3+NgYswHhsdpshisRSMI6vJ/?=
 =?us-ascii?Q?fQMxY8RG66dlgHGzD7LYipbM3g9PHSuln9QsmZ2B0aS4YeMRgXo0qTW0mkdV?=
 =?us-ascii?Q?352ggBrpwEU9b8BCQuOYmSSkCKPMxbpBwiYjiA0owKjd51/vHvciQLexCUmP?=
 =?us-ascii?Q?jeotBv94FRvUrwUkt4bc+OYPEzvwLBIEOe/w1kxBmwXLitYp/5mnUq6Abl/z?=
 =?us-ascii?Q?2p7OtQPxWczlX7ukZX7RirtClJ5zgBpwj2h2q1LeRtugqH2fAw5d20xdNie2?=
 =?us-ascii?Q?Vz00Z5f3Wpx5M9KH4s0LhukmAgRKAo0zMqmimoGURsIKOW+PgKYG56u2xO0Z?=
 =?us-ascii?Q?njqqmzhYUyC1/zQRxhf/zVijRkZeeh2qLbXzGAofXThmStUb9Wyz1JHcsX/1?=
 =?us-ascii?Q?geBX5+rWCCSIxxEZJ7c/ht6l908UPJJBhyM5+Ac5FsiajLD4DPlSLoVGwgFW?=
 =?us-ascii?Q?y2+um+KwdHJQCACxW+dASAMMk35Gu531/Wr6H6nlsAIagIMjV7aEJc/rfHNE?=
 =?us-ascii?Q?6h/RsaNz3w2z/Ixw8MJoW5DKpEEKftmUMP4+x6uo7JD+lzbai7oRBUJr9h9+?=
 =?us-ascii?Q?0BwlhtR0mj/jcDQ4o2+sDYNpSAIJfLE3Dy3t5v6j32ADUhThOFnnrwxztxQL?=
 =?us-ascii?Q?pZOOyt79M/b8vmTEodC8GZm4QECGMkc2l/xjoavHEfOWYeK7lzC5WxyWtJMP?=
 =?us-ascii?Q?IqdAkyd2XUs8osa/jam93qXQnKPvYHqvI3cU90jo7WitnUir7x9yKxTyVwhk?=
 =?us-ascii?Q?24RlpLMMA0fbAmo92IhNx2Zwgitwr0c6s2OwXRb5AfwFLYgkoqAKGh2b0Fqe?=
 =?us-ascii?Q?k+uSjmgfOCiz+0oF+abyqgcZ6VpsA+7YSSyPnUt922ARvYbGj63tfhHaj1lU?=
 =?us-ascii?Q?X1ZGEUHr?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1c38dc-e1d4-4e1a-525c-08dbde9c7aa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 07:46:25.7135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9rmy3EXuwxLk8CmupRH/QDJQHWnchypkLyhXuIsF277uu0wUUVllRnkL9rzigs6gQj6sRIvJG+POsBym+eguQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6830
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Having UFS power info available in sysfs makes it easier to tell the stat=
e of
> the link during runtime considering we have a bunch of power saving
> features and various combinations for backward compatibility.
>=20
> Reviewed-by: Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Bean Huo <beanhuo@micron.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>=20
> v3 -> v4:
> Incorporated comments from Bart and Mani
>=20
> v2 -> v3:
> 1. For mode/gear/rate/dev_pm/link_status, print texts instead of numbers =
2.
> Removed number<->text explanations for
> mode/rate/gear/dev_pm/link_status in Documentation/ABI/testing/sysfs-
> driver-ufs
>=20
> v1 -> v2:
> 1. Incorporated comments from Bart, Nitin and Mani.
> 2. Added explanations for lane/mode/rate/gear/dev_pm/link_status in
> Documentation/ABI/testing/sysfs-driver-ufs
>=20
> ---
>=20
>  Documentation/ABI/testing/sysfs-driver-ufs |  49 ++++++++++++
>  drivers/ufs/core/ufs-sysfs.c               | 120
> +++++++++++++++++++++++++++++
>  include/ufs/unipro.h                       |   4 +-
>  3 files changed, 171 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs
> b/Documentation/ABI/testing/sysfs-driver-ufs
> index 0c7efaf..b73067b 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -1223,6 +1223,55 @@ Description:     This file shows the total latency
> (in micro seconds) of write
>=20
>                 The file is read only.
>=20
> +What:          /sys/bus/platform/drivers/ufshcd/*/power_info/lane
> +What:          /sys/bus/platform/devices/*.ufs/power_info/lane
> +Date:          September 2023
> +Contact:       Can Guo <quic_cang@quicinc.com>
> +Description:   This file shows how many lanes are enabled on the UFS lin=
k,
> +               i.e., an output 2 means UFS link is operating with 2 lane=
s.
> +
> +               The file is read only.
> +
> +What:          /sys/bus/platform/drivers/ufshcd/*/power_info/mode
> +What:          /sys/bus/platform/devices/*.ufs/power_info/mode
> +Date:          September 2023
> +Contact:       Can Guo <quic_cang@quicinc.com>
> +Description:   This file shows the PA power mode of UFS.
> +
> +               The file is read only.
> +
> +What:          /sys/bus/platform/drivers/ufshcd/*/power_info/rate
> +What:          /sys/bus/platform/devices/*.ufs/power_info/rate
> +Date:          September 2023
> +Contact:       Can Guo <quic_cang@quicinc.com>
> +Description:   This file shows the speed rate of UFS link.
> +
> +               The file is read only.
> +
> +What:          /sys/bus/platform/drivers/ufshcd/*/power_info/gear
> +What:          /sys/bus/platform/devices/*.ufs/power_info/gear
> +Date:          September 2023
> +Contact:       Can Guo <quic_cang@quicinc.com>
> +Description:   This file shows the gear of UFS link.
> +
> +               The file is read only.
> +
> +What:          /sys/bus/platform/drivers/ufshcd/*/power_info/dev_pm
> +What:          /sys/bus/platform/devices/*.ufs/power_info/dev_pm
> +Date:          September 2023
> +Contact:       Can Guo <quic_cang@quicinc.com>
> +Description:   This file shows the UFS device power mode.
> +
> +               The file is read only.
> +
> +What:          /sys/bus/platform/drivers/ufshcd/*/power_info/link_state
> +What:          /sys/bus/platform/devices/*.ufs/power_info/link_state
> +Date:          September 2023
> +Contact:       Can Guo <quic_cang@quicinc.com>
> +Description:   This file shows the state of UFS link.
> +
> +               The file is read only.
> +
>  What:
> /sys/bus/platform/drivers/ufshcd/*/device_descriptor/wb_presv_us_en
>  What:
> /sys/bus/platform/devices/*.ufs/device_descriptor/wb_presv_us_en
>  Date:          June 2020
> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c =
index
> c959064..05b10ca 100644
> --- a/drivers/ufs/core/ufs-sysfs.c
> +++ b/drivers/ufs/core/ufs-sysfs.c
> @@ -7,9 +7,56 @@
>  #include <asm/unaligned.h>
>=20
>  #include <ufs/ufs.h>
> +#include <ufs/unipro.h>
>  #include "ufs-sysfs.h"
>  #include "ufshcd-priv.h"
>=20
> +static const char *ufs_pa_pwr_mode_to_string(enum ufs_pa_pwr_mode
> mode)
> +{
> +       switch (mode) {
> +       case FAST_MODE:         return "FAST_MODE";
> +       case SLOW_MODE:         return "SLOW_MODE";
> +       case FASTAUTO_MODE:     return "FASTAUTO_MODE";
> +       case SLOWAUTO_MODE:     return "SLOWAUTO_MODE";
> +       default:                return "UNKNOWN";
> +       }
> +}
> +
> +static const char *ufs_hs_gear_rate_to_string(enum ufs_hs_gear_rate
> +rate) {
> +       switch (rate) {
> +       case PA_HS_MODE_A:      return "HS_RATE_A";
> +       case PA_HS_MODE_B:      return "HS_RATE_B";
> +       default:                return "UNKNOWN";
> +       }
> +}
> +
> +static const char *ufs_pwm_gear_to_string(enum ufs_pwm_gear_tag gear)
> {
> +       switch (gear) {
> +       case UFS_PWM_G1:        return "PWM_GEAR1";
> +       case UFS_PWM_G2:        return "PWM_GEAR2";
> +       case UFS_PWM_G3:        return "PWM_GEAR3";
> +       case UFS_PWM_G4:        return "PWM_GEAR4";
> +       case UFS_PWM_G5:        return "PWM_GEAR5";
> +       case UFS_PWM_G6:        return "PWM_GEAR6";
> +       case UFS_PWM_G7:        return "PWM_GEAR7";
> +       default:                return "UNKNOWN";
> +       }
> +}
> +
> +static const char *ufs_hs_gear_to_string(enum ufs_hs_gear_tag gear) {
> +       switch (gear) {
> +       case UFS_HS_G1: return "HS_GEAR1";
> +       case UFS_HS_G2: return "HS_GEAR2";
> +       case UFS_HS_G3: return "HS_GEAR3";
> +       case UFS_HS_G4: return "HS_GEAR4";
> +       case UFS_HS_G5: return "HS_GEAR5";
> +       default:        return "UNKNOWN";
> +       }
> +}
> +
>  static const char *ufshcd_uic_link_state_to_string(
>                         enum uic_link_state state)  { @@ -628,6 +675,78 @=
@ static
> const struct attribute_group ufs_sysfs_monitor_group =3D {
>         .attrs =3D ufs_sysfs_monitor_attrs,  };
>=20
> +static ssize_t lane_show(struct device *dev, struct device_attribute *at=
tr,
> +                        char *buf)
> +{
> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> +
> +       return sysfs_emit(buf, "%u\n", hba->pwr_info.lane_rx); }
> +
> +static ssize_t mode_show(struct device *dev, struct device_attribute *at=
tr,
> +                        char *buf)
> +{
> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> +
> +       return sysfs_emit(buf, "%s\n",
> +ufs_pa_pwr_mode_to_string(hba->pwr_info.pwr_rx));
> +}
> +
> +static ssize_t rate_show(struct device *dev, struct device_attribute *at=
tr,
> +                        char *buf)
> +{
> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> +
> +       return sysfs_emit(buf, "%s\n",
> +ufs_hs_gear_rate_to_string(hba->pwr_info.hs_rate));
> +}
> +
> +static ssize_t gear_show(struct device *dev, struct device_attribute *at=
tr,
> +                        char *buf)
> +{
> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> +
> +       return sysfs_emit(buf, "%s\n", hba->pwr_info.hs_rate ?
> +                         ufs_hs_gear_to_string(hba->pwr_info.gear_rx) :
> +
> +ufs_pwm_gear_to_string(hba->pwr_info.gear_rx));
> +}
> +
> +static ssize_t dev_pm_show(struct device *dev, struct device_attribute
> *attr,
> +                          char *buf)
> +{
> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> +
> +       return sysfs_emit(buf, "%s\n",
> +ufshcd_ufs_dev_pwr_mode_to_string(hba->curr_dev_pwr_mode));
> +}
> +
> +static ssize_t link_state_show(struct device *dev,
> +                              struct device_attribute *attr, char *buf)
> +{
> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> +
> +       return sysfs_emit(buf, "%s\n",
> +ufshcd_uic_link_state_to_string(hba->uic_link_state));
> +}
> +
> +static DEVICE_ATTR_RO(lane);
> +static DEVICE_ATTR_RO(mode);
> +static DEVICE_ATTR_RO(rate);
> +static DEVICE_ATTR_RO(gear);
> +static DEVICE_ATTR_RO(dev_pm);
> +static DEVICE_ATTR_RO(link_state);
> +
> +static struct attribute *ufs_power_info_attrs[] =3D {
> +       &dev_attr_lane.attr,
> +       &dev_attr_mode.attr,
> +       &dev_attr_rate.attr,
> +       &dev_attr_gear.attr,
> +       &dev_attr_dev_pm.attr,
> +       &dev_attr_link_state.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group ufs_sysfs_power_info_group =3D {
> +       .name =3D "power_info",
> +       .attrs =3D ufs_power_info_attrs,
> +};
> +
>  static ssize_t ufs_sysfs_read_desc_param(struct ufs_hba *hba,
>                                   enum desc_idn desc_id,
>                                   u8 desc_index, @@ -1233,6 +1352,7 @@ st=
atic const
> struct attribute_group *ufs_sysfs_groups[] =3D {
>         &ufs_sysfs_default_group,
>         &ufs_sysfs_capabilities_group,
>         &ufs_sysfs_monitor_group,
> +       &ufs_sysfs_power_info_group,
>         &ufs_sysfs_device_descriptor_group,
>         &ufs_sysfs_interconnect_descriptor_group,
>         &ufs_sysfs_geometry_descriptor_group,
> diff --git a/include/ufs/unipro.h b/include/ufs/unipro.h index
> 256eb3a..360e124 100644
> --- a/include/ufs/unipro.h
> +++ b/include/ufs/unipro.h
> @@ -193,7 +193,7 @@
>  #define DME_LocalAFC0ReqTimeOutVal             0xD043
>=20
>  /* PA power modes */
> -enum {
> +enum ufs_pa_pwr_mode {
>         FAST_MODE       =3D 1,
>         SLOW_MODE       =3D 2,
>         FASTAUTO_MODE   =3D 4,
> @@ -205,7 +205,7 @@ enum {
>  #define PWRMODE_RX_OFFSET      4
>=20
>  /* PA TX/RX Frequency Series */
> -enum {
> +enum ufs_hs_gear_rate {
>         PA_HS_MODE_A    =3D 1,
>         PA_HS_MODE_B    =3D 2,
>  };
> --
> 2.7.4

