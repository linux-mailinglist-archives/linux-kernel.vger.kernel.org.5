Return-Path: <linux-kernel+bounces-158610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2AD8B22ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E1528170A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CD7149C70;
	Thu, 25 Apr 2024 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="U/t2A91+"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8AB3717F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714052182; cv=fail; b=bP045KWXv15YFG3ZnCX3G3cAQBF52O81iuSOkaiUaCwVsaKqR0vUFnSDeWpUAAPyCoY3JXa6yzUTbKfoW3+z+NmitRg4WC3LIb2u+O5okygOxt1uiCFcdfniiIFp1Y2cIhmByf0UvmGixL+Jo0e/Bw1N5UdnuxYv1tFOWXbQRA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714052182; c=relaxed/simple;
	bh=p6Htv8+XxSd7oY2xCrgP2TVwb3vmi31hzL0F1s9N/L8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rGxpqFxOYq26Mosa8oO8NMPHGWgVoLpeRIgGesMYLrlZYdVvNz0k1CH9h8i9ODSNw7g6yCon3XZwgrtuw5M5TqEQEZ5lVuzk5SAYla7iXzV3VoFSehvg1hpTyvENmoapz05DsvS6A4uKolczt85Vq2o/a9GT2UaZxQ4o7U8tMp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=U/t2A91+; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PA4K87007361;
	Thu, 25 Apr 2024 06:36:10 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xqn3n926c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 06:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cP4tKDnI4snwf7BYxTJhBJuXDL5gWX7AUbq4fV0dRAVSJBaWn4S/vaqgfhWOMhmzI/4j2mq5FRIGNjKZuFrHmx6wktIRAn+9p0ZuI8iFv2QaRd3fgvdnZUD66wOjMut/lXy4na/uX50BPLRZPg5+21y+49+lqJD4ZxjnT+W5odaiHBLQmKHIkxSCG1mGBZa2gAYQ/96xkaFSzxoha7g+3TPMbZZfupng1tnDfo76zYHTaifK7zO2wLcKDiVQ01Zg0AvBlkPKsVcToght3pAdJcJuThWFyTpOwr9uhdzNGCHlYzPoVpnCFDa73Az2jiA2+LFBf8r8pq+2n2jfdzzA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKdjerNw+kCZl3WJl/x4e7e0dwlMUkPK9THH8nJ7MxE=;
 b=YvJ6/r/pOhSaYcXkGW54LkwQSl2LMoITzWuRQpqBkhojvIbOIXGP5C5JYTzAWypob1+5HgRLfuRYIdPukIQ2ILd0RlZ2x9UD/USUNS8sPy6Fg+eMWymhu0sgkqglTmq7dVsu7AnoQkPW9kzCuUUMqlluFt1IOAJnafTcxjANgZa/bkxr/rOZD6/Us2tCLtzeHNn60LJGyvy+rt6eN95dDf3Fgtv92k9MaAkyj1OocVYgaBpNVl0PcsogEnJmfeuPb2vwEW86SIx1SbVXs5ZXLjQyaNSQMQmAg+BjV+nmR34kXEKkxcwEd8XszpVsvChJ0NPo3SRKFKJn0ToXGmPh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKdjerNw+kCZl3WJl/x4e7e0dwlMUkPK9THH8nJ7MxE=;
 b=U/t2A91+4rk42KPzqzsgNY+uF0v81jzAylmpSPlGMln3vC+KbC4I6k+L1LiYv/vMSJKzlseu5sqH8h0x5lxHSAa0/MHlkXYjzu8WxGwNhJw3FRm/CUqwxx/X+VKiPGqxenV8428UkrQSQglzjZXGzn0wVC4OOfyBAf01xB3Xg7Y=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by CO1PR18MB4665.namprd18.prod.outlook.com (2603:10b6:303:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 13:36:05 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d%6]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 13:36:05 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: AQHajNJlUzRgj48oqke7eNtbl1jogrFkj7+AgAAOmwCAFG8fEA==
Date: Thu, 25 Apr 2024 13:36:05 +0000
Message-ID: 
 <MW4PR18MB5244CD9591CDE87CB062DFEAA6172@MW4PR18MB5244.namprd18.prod.outlook.com>
References: 
 <MW4PR18MB5244C76290A15737DC94FFDBA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240412121005.1825881-1-vattunuru@marvell.com>
 <2024041250-nursing-tidy-db7e@gregkh>
 <MW4PR18MB5244FA7231C64F8A7928B83EA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
In-Reply-To: 
 <MW4PR18MB5244FA7231C64F8A7928B83EA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|CO1PR18MB4665:EE_
x-ms-office365-filtering-correlation-id: 468a40d8-127f-4334-75da-08dc652ca80d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?/uxvP8vsfT0UghcFUkZm0GTZFsDLGQZBzkHPHXMf36xDVs3es+koZbuhWao8?=
 =?us-ascii?Q?Mh0zJprmPopOO2FXBcnYC2NSMF+9uBRzZ1GHb39W1ODzAiCiwiZr9QeZi8An?=
 =?us-ascii?Q?VyLTCMuKu/ELI7K1/6PNiiHnX3ICYeVQ25aNGl3b1Fco8a87O8gw4ORwav3D?=
 =?us-ascii?Q?IFjepPnDTkGmtVtk8AS6xZ05dD5PUHMFnoWORbgIgQEqVR0wazJBn4V/jwH1?=
 =?us-ascii?Q?SSGgzM5RM8jZ5QZeCrGnqwqxTSq1N5PxF5iBJHZnUUAGQaiSVM074z+sC6lX?=
 =?us-ascii?Q?Mwt5UZQc6xxfFNLH81yqj9iN7lxTgNqqxU/ESgX1f/FgjXMH5VdOAHS+TLMF?=
 =?us-ascii?Q?Y68CIJDslmfEdchYx3OXktyvhaLy+3cYnlF98Jf7Bl8vVnMVTyFbJ2w/GJE0?=
 =?us-ascii?Q?Fl+aXUfRWkbkahJBOG/bIJd08kEQf7oLleEJzY4OhML6vZ9ve4eQDpx6rR+i?=
 =?us-ascii?Q?ljOd9x0gdLOtj5qas8ytrN7KCMkN+ruuaQ3mq2D3U7p+GJRalRiSNh4qjp2O?=
 =?us-ascii?Q?36uNrvh+4VuZxsRGJ8UXfqCmmk7ss/QLsVmng1oRv/il1iAhKexFp2D/mclx?=
 =?us-ascii?Q?40OvIfbmkQx4LwBtNMGdgp/n+N5agQ62KyJoHR2hxFfOXEKSFFC+3nOCruXg?=
 =?us-ascii?Q?3JGaJKCaMrePwQrhY/IpAyxW65bNe4lU4ZkHGoVyfRDx0VO0nwKTT1hU2BFe?=
 =?us-ascii?Q?LJK3w0Cuz4Pw5IkSjOXRXouRaE5F+BU+fOJuQC4YItWjb17PBlN4tGIYv0x2?=
 =?us-ascii?Q?ErtUaIkI5AuQGzN3ChnSftuMrmCYT2IGulOGEsmGRaPIwf+A7Bbcm/5RjlHT?=
 =?us-ascii?Q?A06+dCqYtPoITm08h1vzcy94o9CbivZRPw8dqRcqDVIi80aL3WlFYGHyasMr?=
 =?us-ascii?Q?8jxXnCOZpse3uaqN6WDcKqrSEW3sbSaNH6TGikBLGMtSZMy3hlIZW/b5Icet?=
 =?us-ascii?Q?ETgNoZnWi5nIkxsHC1YRM92OHoqZkB/+kvU5E1CIuYe58iU9RFpZs1aj8cKW?=
 =?us-ascii?Q?wSMG5z+pGDlt5h55PLx4UA3SaIfE/HJXE2JHa3OnyypKVtHDV2RwzczTRT4y?=
 =?us-ascii?Q?l6ndPgCT/i/jac0JlcLGKLh0YYOa4DUldYbUEotx7jdETvCymprk/PkJVfGk?=
 =?us-ascii?Q?4xWmTE57rMA7gpZfHj/tAM7e8urFhm4C+L+pKKM0o9cBxPTY+UiCIdwlIuPp?=
 =?us-ascii?Q?Qc4k4Wi5CxXxh+fRstQKCrmcELOve2LCn1nlqBVBNAsjylOR5+1z3BN8QZfe?=
 =?us-ascii?Q?Lh7jLiLjaZSnojvkbUYza9s+MZEJ6BmYffqhPd6d1xiUDCPkTL+ktoQzpjMn?=
 =?us-ascii?Q?M+eSjFEz6nmQoX1mo5Ha4ZTkXDN1neRr1Rnvm5p63Cv/Mg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?VcVDbwcB9PyO5GMjpgrB5E0fyfZJVWN09FrEo5iJLJFgQ3/2StzniRuHUte4?=
 =?us-ascii?Q?iJ3jY1fD8EZ2DyjEb7PnjbsYOhrVUR6Cevhg2REoXmaJTAYIK9eJAfh7RZob?=
 =?us-ascii?Q?3Jus2YyeV6HmBqdC+NqnODgNHhW6jAm7w9s7sXL596L8XiXSDw/ve7xlY4Gk?=
 =?us-ascii?Q?/nxFm3l2xQdFr0kKo116HatggOd9M+jimG6BjosX27CzeqLRx/XgjQODfDHM?=
 =?us-ascii?Q?uWNVjfVQX67IHW1PWam2STJqoq4GGRRhQf2+rw7SOKTNMkyXgFmcVP9+bVfw?=
 =?us-ascii?Q?qh0eFwk67JY/Xfrk1aNdmjBGbxQM/QfjjVvmameMXGDXitf8rGelKlCd0LeS?=
 =?us-ascii?Q?LbNEHZf2r4zTG+ZJ+4UGQyJC0MoTnZnm61569b4ax4RGx8v1mYUGI/ldz95V?=
 =?us-ascii?Q?lSiEdShi/xsuYLs/GtNLeJwtmo66b6uIwPqxa9vlDGJjca07WNEpfK8vuVbb?=
 =?us-ascii?Q?wUN88QLme25/6CQxIDFzxWLim2814f1ychF0jN7T1KY56sKulwbIDscw84eA?=
 =?us-ascii?Q?3VvyK5FCZtkD1Enqj97RhwJYNJhoX2pYg0AaE5MRno90fiTyfb16hmlk7zz7?=
 =?us-ascii?Q?Q1qmeOfGDfyTRre9IiPH1eAJa07REXuVM0aoypMSeYdLlRwtdsLLmDCx04BF?=
 =?us-ascii?Q?AW6QgyPIvbjaS0Tdw+zTAXn1Nzz3C7qQwtjl/P24CO/xWZ4NiLQoqcwKgzir?=
 =?us-ascii?Q?d590z2hTtukyEsgw1PACsqRLi9kPhmrxGQn/a9hjxoxfMM3okJtWqyBzPlZJ?=
 =?us-ascii?Q?eCYZb0pL6Guwhsd+Bg2Vm4456fk1ygR2iwY1puk/CetCigfdWJ7A5W8buc7U?=
 =?us-ascii?Q?RjFW/QqjEhyv5gKDotR6bQg/mF7DI6N5LqUyENzn5SicwXXt/WFx+WB6DpLU?=
 =?us-ascii?Q?t/dHQs4Vx8c94jxNReCCq51NuLiLofvGVilO01UkiEsVOZDwPM79QSVCCFG+?=
 =?us-ascii?Q?8HbuvGYEudyYSySSK0KOSOICxzEk1GM4fXdqjDymHa4+9n6eeLkIL49NNr0x?=
 =?us-ascii?Q?nkIK6xzlrEdBzyBDzGKAq/bGbZuYDJWic2912eFmy8XkuuQEloNjswiukzxz?=
 =?us-ascii?Q?/cz/5nJZqek0QYJyFJCxbfTcGJB+zsOD1QNnlIa3eOVPlbZ1vZOLY17ScYsg?=
 =?us-ascii?Q?VZpwK5zG3gjQThFIyHxvOx1l5A9Nfhh9WZYwzPwykoUiXXqjutX4X+Aw1M8z?=
 =?us-ascii?Q?LK4Ie3v82EfwHAAllNeoGDI1oWPrwGJw01ITJSYJgdzP9JEA8FhUI2yPBZA6?=
 =?us-ascii?Q?OkelRsSnxmBJeDA7FsvZCSFaVnnalMgooC4NamA5sSVNj6Zqih+0ksPyg+lF?=
 =?us-ascii?Q?lJBRWsuskWEUmkGkaZna/IRJltEPTcms0sgLeA37TzckqPYO4zioulTnQ89k?=
 =?us-ascii?Q?BUtZslwZ7JEAGSbdWDZlGDPKoSH5bhcvU9t1f2o7bmnvzt1b2QQWjd8Qzk9e?=
 =?us-ascii?Q?EcDuHIkfF/a6ol3yJ1ehr1da0Q9vR3L6z2pCgpASI1acc4ie1MBPtOfJ19NW?=
 =?us-ascii?Q?P8OdhjIHjR2OX+OO/5iLTpp2vNi9C46qfLmg8t/c/GU6uaMgkT2xGvrkggGf?=
 =?us-ascii?Q?Y+zD1LpkaMshWILerQMCThtwZA/Zp+g3ddTXFrN5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468a40d8-127f-4334-75da-08dc652ca80d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 13:36:05.2006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IzftlybpignkCo3iGiVrQlNwBK6+B2av8yr+JDtZ7FkuUAikF/IrOq1vB8k3V8mzV+PC/SvM8OpdnHoE1ym4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4665
X-Proofpoint-ORIG-GUID: a7DeFo4rWiEGUgdXcnRUttUjmxJRvqL9
X-Proofpoint-GUID: a7DeFo4rWiEGUgdXcnRUttUjmxJRvqL9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_13,2024-04-25_01,2023-05-22_02

>=20
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, April 12, 2024 5:57 PM
> > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> > Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> > Subject: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> > Octeon CN10K DPI administrative driver
> >
> > Prioritize security for external emails: Confirm sender and content
> > safety before clicking links or opening attachments
> >
> > ----------------------------------------------------------------------
> > On Fri, Apr 12, 2024 at 05:10:05AM -0700, Vamsi Attunuru wrote:
> > > Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's
> > > physical function which initializes DPI DMA hardware's global
> > > configuration and enables hardware mailbox channels between physical
> > > function (PF) and it's virtual functions (VF). VF device drivers
> > > (User space drivers) use this hw mailbox to communicate any required
> > > device configuration on it's respective VF device. Accordingly, this
> > > DPI PF driver provisions the VF device resources.
> > >
> > > At the hardware level, the DPI physical function (PF) acts as a
> > > management interface to setup the VF device resources, VF devices
> > > are only provisioned to handle or control the actual DMA Engine's
> > > data transfer
> > capabilities.
> >
> > No pointer to the userspace code that uses this?  Why not?  How are we
> > supposed to be able to review this?
>=20
Hi Greg, please check the below files for userspace code that interact with=
 this kernel driver.
driver/roc_dpi.c provides the mailbox interface to communicate with this ke=
rnel driver.
application/main.c is the DPI DMA application which uses this misc driver t=
o configure
the device with required mps, mrrs, fifo_mask parameters.

https://github.com/VamsiKrishnaA99/dpi-dma/blob/main/driver/roc_dpi.c=20
https://github.com/VamsiKrishnaA99/dpi-dma/blob/main/application/main.c

