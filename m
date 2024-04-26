Return-Path: <linux-kernel+bounces-159653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DD48B319E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F844289F10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D5113C674;
	Fri, 26 Apr 2024 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0Ys7zEif";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="p6m4qZzc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A93413AD25;
	Fri, 26 Apr 2024 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117457; cv=fail; b=BsjPfLJIsFp9sOOaEe5Olz0cesIO+qWlrdFv6AkjC3UE/JatLykvv+O+p6oO2ByOpMSIKAb+S8kH3u2KMeKN1WWpE9xcIYp2e8n0Fn5RgZCHsSEZYiiAAMyDuMFS2Y7eVBTj4U3aK/gm8eNaG118+HoYoz4FWwIKNyhva5X2LUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117457; c=relaxed/simple;
	bh=nItGw23nLZHJ4WckFxw3Pygwqu/gG2eQXRAcZl7jg1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lM+McErFhAKJeGWH+L+ekf+FoXM/gMkH0u8TXjZTHPGkNFFO/SkonEyJ7liumonluN2Hp9A6EU0tLbHiqxaVysJT3PlypKYugSlhI/GlhEiSi1DDbwUo7AmZ+Nt/J2oLx8Gf5BrTtp2G9/lzD1FUCWysQrv0kpch7tJR5oRGolk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0Ys7zEif; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=p6m4qZzc; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714117454; x=1745653454;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nItGw23nLZHJ4WckFxw3Pygwqu/gG2eQXRAcZl7jg1Q=;
  b=0Ys7zEifwcg5lJDxCFhoJuKGKauPKbSs1vklcj/NDRA+87tgFKd0sNfi
   vS5IcpK00XpDplUw19UfPvV5UW3pqM5U65uM7FDa4/nCaderA0SQpsZOR
   oLWMrXfmN95lU+9luIJDuyWYgiprPVoGj8R75ZL0Mape6+a3izyK5x6wU
   T7J802WvsvTF9e7oVIYDkPl4Fyj2wx3x3MafiM9dfG2FJzH233IXAvyP2
   amt2GDY2BCGtwW/Yv8fzAsgQw6sYvWYp1cnoN7uMBi3T75Yutyu7OUqgo
   QBjLsy1L4r7l8qVDf+KKjhFwkyYWP1T6TQzhhS8kIZI/EJhe2NiZyQcTD
   A==;
X-CSE-ConnectionGUID: XXuTBX8lTsyekX3bEufgsQ==
X-CSE-MsgGUID: lF3VNejkRlavd9tbtxu6fA==
X-IronPort-AV: E=Sophos;i="6.07,231,1708412400"; 
   d="scan'208";a="22732993"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2024 00:44:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 00:43:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 00:43:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6teiyHZheBnVz9UzGjpjoxaRnOBH4EQseTJZngz9CkHGWyLFtLNi3t6LJOWA3gZYyHrZb1ajFyegq6Hgb0jA3PxqdSB4r02witxW+nKM59h7VdyYrpAfaAz7OVhPVkDOCR4jWcmQvmrfzuFUXjlh3hdOxualKX7v/Blc8bOVnoY1T0UbEOQWW7qX126VdyS5YpkTmXH9l5DIhHXFYD7Suxodwp6NWmi9tz1lnU8ndLFrdyIrv/amIJ4v0YMFYsC4V2O/vmWMmdq3eVblQgtzIRDCWdDL9EBc9jagPBRrUdQAnr9lsrFYcKbbf08h4PB5SEstJgk7+ZBUxxZ98wpYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjnAgTHedoHgb5NtKgsfM8733Fa7+tThtz/FMBgpB/8=;
 b=DTpg9rfZ+nGNG4jcesTkQWO44exbWH3DPMNYTFDgxJsR+5t+BWAcEg6qYSNHaslXpbHrntn9HHx4lcmVziaHHbCcj1Cns4RJHogXyVRIh8BEclwk5HSdHwDm+aXt/hIkg7ubEHIEa6Et9FOv9NFnu3DlQPAD4mQsZSAHKQ35GjLcJYazC5jo3zceEv9mN0at1GDtbrEL3ZwOg4s3eaRM1yA/i4R8vj7sLmZ4oALHpyrJ+5xVxQ7yGndQbokHf5yLgbYaaVe+gRcyslkL15mirF56dZDwnmXHp9Q/xkWsQEVv9f/Z5zjGiPjZhPir71edr1ryjUU7YR8SC4L0x7R0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjnAgTHedoHgb5NtKgsfM8733Fa7+tThtz/FMBgpB/8=;
 b=p6m4qZzctxAJNqMC4Y+0x+OvSGZ3JoB9yoHcbs7dVIr8oO9GNDOtbzm6e93030DRc65xrjbw2knyNdSORbPMT4+GhfDxwzbGcaDrU4flrnoczBQCdA1JUS3BPTjY4noVxfM+YDZw1VUO1PEH/YBDFpiNWUogBvh2LP2ESCMdKqUCLJ8Qody1HhPqQ+h95dyxserYvsi7jS6QmHxHgyK/69cJtwNlZUYKwbRbZzF2OSoe+ck+iV+wjCgrZblfiOy2YFVGbRzZzCdFgFqX+HVjDE00v+OsxHg+Of9vnOypp/bIrVBjE495zPidj+1ZQ+lAIdolk25dG14WklAmsI6xAQ==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by SJ1PR11MB6106.namprd11.prod.outlook.com (2603:10b6:a03:48b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Fri, 26 Apr
 2024 07:43:36 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::1a3a:422d:1406:cd7]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::1a3a:422d:1406:cd7%5]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 07:43:36 +0000
From: <Ronnie.Kunin@microchip.com>
To: <andrew@lunn.ch>, <Raju.Lakkaraju@microchip.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <linux-kernel@vger.kernel.org>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when PHY
 does not
Thread-Topic: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when
 PHY does not
Thread-Index: AQHaen5pYcVCYAnMVEe2BSZT37paArFBPcYAgBgwmwCAAJVnAIAb45oAgACHioCAAqXqAIAAK6IAgAAtc4A=
Date: Fri, 26 Apr 2024 07:43:35 +0000
Message-ID: <PH8PR11MB7965D05E16D922C3B1F14E5E95162@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
 <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>
 <22089299-a3e2-4cbd-942a-65ea070657b8@lunn.ch>
 <LV8PR11MB87003ABBCA98F00F3EEA9AB09F032@LV8PR11MB8700.namprd11.prod.outlook.com>
 <fb5a6f19-ae4c-443e-babb-cbbcf6ba5fc6@lunn.ch>
 <LV8PR11MB8700A34520EA2521BC5F59EF9F112@LV8PR11MB8700.namprd11.prod.outlook.com>
 <9c4f8fcd-ae95-4874-b829-d381928c5f13@lunn.ch>
 <LV8PR11MB8700D54F5E03440681BF0D449F172@LV8PR11MB8700.namprd11.prod.outlook.com>
 <38718a9b-bc7b-45d1-b15e-f4fea628db3d@lunn.ch>
In-Reply-To: <38718a9b-bc7b-45d1-b15e-f4fea628db3d@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|SJ1PR11MB6106:EE_
x-ms-office365-filtering-correlation-id: 5aeac992-94ea-42f2-fb94-08dc65c49492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?ALq/6rVzwvNpRAiYp9O8Zv0+K1KM2Vybe/OjHKtMyAlV3i+6GseNGoawKTwd?=
 =?us-ascii?Q?0OSFrj+Crt7HtCn0qJvfQ575+8/P6PRI3u8rHLhp7CNVuFvdfysGRWEnWQet?=
 =?us-ascii?Q?NNJXbCg/RyUNqtp4Ue/JsBYU3ZtGM+BKggIMN/Lx07+30fLyXpTQQCiyEr/G?=
 =?us-ascii?Q?k1tb1KuBJyTZq1W64rlrjoo4x3P2N0ph4MMK4vhalvNhZl+z6+j/aY2rYHc2?=
 =?us-ascii?Q?vHNh73yzP41orJ7B1Ud8Fc6gRacMiwGSYmruiDenxFYIPiuykOUo2WAOY8dj?=
 =?us-ascii?Q?cXU0RI2P+WbYd6OAQoV3NIH37uaxojETsluEDKdmv4+NIEgMu3f/U21SdBej?=
 =?us-ascii?Q?buGREl/ntEv1xuqd3+7Q2Ki6LWn0dVfa3QP6J7BH6DFwn5C/YBcxi3I5V8IT?=
 =?us-ascii?Q?wwypZSR9GJcjHvNkX9KARSZDTwxkQz4i91YCuFOxJ414ilkL+YJeSwmFQzeN?=
 =?us-ascii?Q?v2XSsIHDzvqzv5UOnRNM0T9XFmmfBOzaEdEib9xn+wGnDP7G8PZVlCymQMPx?=
 =?us-ascii?Q?aP2HV2UFQUSZjvbljj04CJ1dVsp6yluhjhyuQmQ6njjVmPurJJN05+aCcO8U?=
 =?us-ascii?Q?JKthCvH9xo3hpfchKYQ+dUTrUuzf11u8c7tquhXvURh8Z6KPX4jIl5LiccrK?=
 =?us-ascii?Q?R3NuDpEQuon0HKnZXzGqKDcx2sNA/I2XH2d9dd0okr7i0yR8xfUByOnSiT8q?=
 =?us-ascii?Q?yJlPYbWFoZvCjqvxnfm9FqwXs9lOWgnfSdFIfM83a4ZI8GDs+4Bsu7kG83Lp?=
 =?us-ascii?Q?VElLlaFSruCJWCQMzn/O1p9J9wC690vg1kkB5OhJbYfaqrs0/9LnsQjD1iiC?=
 =?us-ascii?Q?Ec56pOdq/X13LPFal1qMmwnKlcr+V56OiAm0zrVQvzWmruue8WuTctV/tVr3?=
 =?us-ascii?Q?dZISknEWNPLvuk5kdwsilQLHuyL+JaTT7Z3bGyLRBlVD29g8gl+s69u5F+7Z?=
 =?us-ascii?Q?bGbfY0t+1ixYK1Xz90ehW/Doyi7TkWv3TenUQy6ymMMh0rbZ7IxipfPjB8py?=
 =?us-ascii?Q?TQD4Rnn07tzxP/pjKP4E+FH548vyvVaCZIYELYUrDcz1dcrt6twX42+GqSAr?=
 =?us-ascii?Q?IIclET7lhN5V6S3X+yHOJPRyHKSIpkSW7I2howGJWN6bZ/a9KTA+j6hpR/6H?=
 =?us-ascii?Q?aJUvnGXmgOtTWVndRDQGo1aqkgJxjbP98nrljg+5D32uyhnjkRttyVhngbnA?=
 =?us-ascii?Q?2wbaJC4GulJvO0xFG5P3fGLxxyA1Fyd9FpBfCpabI09F+g9XgYZfqQWlpmtn?=
 =?us-ascii?Q?rypjclI7r4neGrmHtr+On31KhTcJfIatmFqjVttsrg5c04ozcrrI8DRiqPrg?=
 =?us-ascii?Q?JtkDkFnEiPlAUnjhTtYO71FtxMRGn075peN0qbNdRm9E/A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KSkHryjkjh2Vr8tEL0DlJzA60/eiEBNlTxvMfTBo6KcAgr8OSU2M6PMo82ky?=
 =?us-ascii?Q?GaL8/TWUcu5uPF3L55Uz9NKs6L2FjiZyfkE6AvvlFf58oZflkFoz2Nzrtnrw?=
 =?us-ascii?Q?KWt0B2cvWOh+JTk297TQEKdSRunoC+jZ4zV+DYZ+xD8mnvMQb+04ulPH1cj6?=
 =?us-ascii?Q?mzj1hzzadwbPGtelC8LsTI6Jo4DgVAbbvze6v9ggqnziqVix9o1O0NJ57emL?=
 =?us-ascii?Q?F3MikPDjtrRTE6s5Y8RZFM/p6O43O/yfdkV7dsIj7RkWbNEwdiapMEvENBXD?=
 =?us-ascii?Q?AHhMlt3LZ86TOuMatDVeyAzVirMF92q1hUak9OHDwPHPw3/nAesH6VGNa9+O?=
 =?us-ascii?Q?qc0JIDl/bML1sHwz8SmJcuaJ+rKEkg+ZzviMkbYHmF9MlrMTnEUlG/ElOpMA?=
 =?us-ascii?Q?8j3WL0paxUVWN0qAHXc6upljWkJ7yVFvr5uaJHgQ7TRUtyiXizt4KgJ9gA+0?=
 =?us-ascii?Q?Vb37jEEM8oZnC3NLKbbf9ZCMP9z/i01oZM26nkaPzD3hEHl90nTc1baj+qca?=
 =?us-ascii?Q?Y513vsUKZrCGw5up6eJVX0XgWBL2WM0200qpczpgNPQxpuUM4r/LSZhzwNZw?=
 =?us-ascii?Q?phjC0YV4bc7k8c8EbRVTZGy34Kky/mLokB+ffoKOB/556F2qR+E1OX1lE7/q?=
 =?us-ascii?Q?SKClaDJjcnic9UcONTntaFvXkM+t4HWi82kmeDZFeyMQTZJtkJ00Oc5cu+6K?=
 =?us-ascii?Q?7xyhHZyeTKQZvxnl9905+obNS26utglNl+JWcHPbXRfjSHDvZh/VR+O5rnzo?=
 =?us-ascii?Q?mQfhJlhQUKdvf+exZoUk2PhIy3k/FZDdzuU22oWo6az8ITn7pCr0AdrAFdPs?=
 =?us-ascii?Q?+KkaRkyu3AhjOU4+jETzgSotr3S9eCS0ha2b0mYp68b1ctK4pzYnM8hiAEUk?=
 =?us-ascii?Q?eHjG1V9sGiKNF47XUVQGo952wfRi3M2t/QNICMswKSweBFa+LUa+Zfmj5rQ4?=
 =?us-ascii?Q?Y4hUtWYLyj+dfREKWu1EZr+ruBJoMyQx9+tEQVM06yavXVeT04td7YLeDaUs?=
 =?us-ascii?Q?15niaQY+6mVaX1+cYYggoALa0t9LzvfuJmjkqYIUWtr0nVRiReYvnF5rhDRn?=
 =?us-ascii?Q?fDGjcnOLYOfQR7cNm+Q2qE8zd+fpmgQkL/AQ46yHyhdgVxV3INUn2Wd5MqQE?=
 =?us-ascii?Q?bRoIaCocEgpngOxZZx+wEDVBiaE918NDQqhVvUwUrvcFuwGdfpg5W1eGDOHH?=
 =?us-ascii?Q?QgiNRq4YpF3/U4jTKVhkI5Flx3fjD8ad/Y5hteiDgjf36Jeuu+LAN08lSxZN?=
 =?us-ascii?Q?RyOvwArFXdas5epQwK6RP4qebEJ+GPOHfnZs4tula3oyFjMpFq4fvuBM6iVI?=
 =?us-ascii?Q?iJu/7M498xpGarZmW7902O2NZUhDGS38FSoadv8ovePp/bPGy+4HEhnfZQbL?=
 =?us-ascii?Q?oqT24jkNHec6zAtfE2EdZTUhG9ikOlWsbVCEwACvfT34NV7TaFJd6sAZBmVy?=
 =?us-ascii?Q?yJZPTxLh6xFn2Dxo4U2rgSP5+LtnTqhJ/ZAhcFKgk8AJctc3vzFpBj6DK3RA?=
 =?us-ascii?Q?TRxxwcCyBdPxQcKPpf4Wt3kazncKJ8u4YNY0k6qi2+A3CqRqWkJv7DaPTMAB?=
 =?us-ascii?Q?8miERrjvfQsFeybHLsQ29TviL0ep5S75pxTXwdfhxJGtFTzlopjx1hUoiT9E?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aeac992-94ea-42f2-fb94-08dc65c49492
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 07:43:35.9992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ge0kKGnwaLHTj/SZoJBsD0o8Ow9zNrciGi3zxoJBH+TZicvBhwZOGOdD8eWelaBMkxdOLxGdZdZN6qU8Xn1allLtqjqMoUGrQ8FqIIHM7wQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6106

Agreed about the tradeoff.=20

From your previous entry in this thread:
>Renegotiation does take a little over 1s. It maybe not worth it for suspen=
d to RAM. But for suspend to disk, a resume is probably going to take awhil=
e, so maybe 1 second is less noticeable.
With some of the partner PHYs we've used, specially when supporting higher =
speeds such as 2.5G we had seen even much longer renegotiation times, reach=
ing as much as 6-7 seconds in some cases. =20

Raju,
Due to the above and some of the other issues you mentioned you are facing =
(i.e. undesired wakes on intermediate link changes that you would need to "=
filter out" ) , I'd  rather not try to further optimize phy power consumpti=
on by down-speeding the link at this time, and keep fast resume time and ov=
erall simplicity the priority. If/when customers request it or power regula=
tory norms (EU as mentioned by Andrew) make it a must have we can always re=
visit it. That being said, after verifying wake functionality is correct as=
 the first priority, please do look into turning off anything in the LAN743=
x  and PCI11x1x devices that is not needed while asleep before completing t=
he suspend.

Thanks,
Ronnie=20

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, April 25, 2024 10:13 AM
> To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org; pabeni@=
redhat.com;
> edumazet@google.com; linux-kernel@vger.kernel.org; Bryan Whitehead - C219=
58
> <Bryan.Whitehead@microchip.com>; UNGLinuxDriver <UNGLinuxDriver@microchip=
com>
> Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even whe=
n PHY does not
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> > If PHY handles the magic packet or phy activity (i.e. WAKE_MAGIC or WAK=
E_PHY), our PCI11x1x's
> MAC will handle only interrupt (MDINT from PHY). Not MAC's magic packet.
> > In this case do we really call phy_speed_down( ) ?
>=20
> phy_speed_down() is orthogonal to who does the wake. Packets are packets.=
 phy_speed_down() does
> not change that. All it does it drop the link to a slower speed. And slow=
er speed means less power
> consumption. A PHY operating at 10Mbps uses about 1W less power than a PH=
Y operating at 1G. The
> numbers will depend on the PHY, but you get the idea. Plus the link peer =
will also save a similar amount
> out power....
>=20
> If the MAC is needed for WoL, because the PHY does not support the needed=
 modes, you probably also
> save power with the MAC running at 10Mbps. Its clocks probably tick slowe=
r, etc.
>=20
> But there is a trade off. When resuming, you want to go back to the full =
speed link. And that takes time,
> a little over 1 second. So you need to decide, do you want to prioritise =
minimum power consumption
> when suspended, or fast resume?
>=20
>      Andrew

