Return-Path: <linux-kernel+bounces-92965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8DD8728B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56811B23CE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A21A129A86;
	Tue,  5 Mar 2024 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gueulsu5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="L3f+lf4m"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8DF9460;
	Tue,  5 Mar 2024 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670484; cv=fail; b=MMoar7d6g5a2/DVaP7HavJd+DGbvW/9UAH8RHLQSZULnLoXU4dBE8eDG9TOnodVvEBAs6BV4RZu9trrWHxa3EUWgePIDCcaO4/jYXhYkbDyceWhKofNV18D2z28EI1utjlFVTNFPfUYxgZTYgRaSLMtMgnbiIJG1ZzxZFrbVrII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670484; c=relaxed/simple;
	bh=5yRhIB7TmOw8weJOCblgeWvb0QZ2Via/S9bZ8EmJYzE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HUAxiOl6F5gdqrRTAJ/IKWi1S+8HLDDyOazuraf+VVPvsyhbO4+KAjnL9RZFpbcNF0V9LB50EodQYDuPGD+nVHoWipLRoG28ns4EXWZ/w2H2z9GoaKoFgdgM2hraVkBzSTSlSHGGyqWSj+vepldawLJ4+JVf1u4b6KTGXLTk1zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gueulsu5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=L3f+lf4m; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709670482; x=1741206482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5yRhIB7TmOw8weJOCblgeWvb0QZ2Via/S9bZ8EmJYzE=;
  b=gueulsu5sOVqsfy2LrCmEbYtDAnDaIKM6h85LTcSBFr0F5BP3Egq8HKH
   wJP9ycx5hs6p9RnYnFNToEywW9whJ369WY8R7DVI0e6mKLu8WahH6GapR
   oUF8eeE3kOJFxfznztfJ311AJFfgeCyEUNNuv+1eE2KKMu9WYFQYmp9MU
   1+GrXEAeGXg+FOsWHri1Q1LX868nYafwjhG7E20Qyb8384p0CMMCyeEAp
   m5fguaJGVl8f/dqXqHoEnR77F47wtSRODydixEILufdqYH71cKV/JaTqW
   wT8ffZtRTA5pkUaGQDxM+7rX8fBhAsQGlKTcdl6I9ZypbMIuUA0lKNBxx
   Q==;
X-CSE-ConnectionGUID: AIqbEkpNSSi1GLv6hR4uXw==
X-CSE-MsgGUID: 9bOu/3cxS5S49Lhfu4/rgQ==
X-IronPort-AV: E=Sophos;i="6.06,206,1705334400"; 
   d="scan'208";a="11118912"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 04:28:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9El99xPzOUB2zsy19QP48X13z+0d28XSMI4UPZLQPif5fzFAYpdUtkN8SjECJWqlPRDPzuw3vaC5XWKy3TauM7soW798G470IqP5KQyOzo94kg2PcxRUA9mpIey/kdcFGkhNrbpn1HSjicoPFyjsJjmvushQzpv0EBKJ6cZ69e+szyA3WNQZPQXIWwtKkwP3h2USzYZKY1jqb71uhZyaxBwNkuenqyvPB/Sxgkepmsoi1q9szMXg6gdlqlfClQ+VBJK5UJlK70J194HvP7SX5qY/oal8kwZWn2bb5i5dGYVQwHVV059C+ywAf+KtW+Vqh0NX53iRygVDROGMKSd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yRhIB7TmOw8weJOCblgeWvb0QZ2Via/S9bZ8EmJYzE=;
 b=Gs3fZkycxYygs3/NZMU6HZbatw/ql0hwxQabAgNRuvgSgCYNoyg8Lbav0eeYUqeyFjQbfxUW342KUkMgMZoFwkd4WtNBd7Y7OYNvh+wu14atWaMwp/TXiN+OxzWom/ok1/2hsRfO8Mz/XY48uu+CqX2XdWiwkH4ozLVFX7OqdGwdVleQ9EArnv5wKjYnnfl2m7tHsqCLuRSoMEfxRMYX+Bak/94WneI1D82u2Gsqy2o5vHkp+IrfIRM7wIMqyq15UV+7Pw/OsBmEyYzA1QtjF9Mnz/zrqwV+LiPiSbDHIW9kvVHl+BYsqPBo9b3MJ68mA6E3Ye4axYj/Xn60TVmOmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yRhIB7TmOw8weJOCblgeWvb0QZ2Via/S9bZ8EmJYzE=;
 b=L3f+lf4mci/k1nSfeJXgT2CL9Ng4BsGu7a0Ap1zQP4WOsxh+zJPwwDp5VxXnglj0SjVq6ZubH1optMqgkRP/VPvbbY8RHxqj0Kv9aoVMXWIDEeA6mOBssYzr0g2uBBVnVWvdHkNB5GAiu9v5VNtHkNkqvyLFCkmRBmUCUytNVDY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB7248.namprd04.prod.outlook.com (2603:10b6:a03:290::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 20:27:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 20:27:59 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, "James E . J . Bottomley"
	<jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
CC: Bean Huo <beanhuo@micron.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] scsi: ufs: Re-use exec_dev_cmd
Thread-Topic: [PATCH 2/4] scsi: ufs: Re-use exec_dev_cmd
Thread-Index: AQHabhW5jyV//9miXkC5d2tkHZoCC7EphUIAgAALvJCAAAVWAIAABKSA
Date: Tue, 5 Mar 2024 20:27:59 +0000
Message-ID:
 <DM6PR04MB6575A22B6916B16C2E8CBF74FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240304092346.654-1-avri.altman@wdc.com>
 <20240304092346.654-3-avri.altman@wdc.com>
 <4f766df0-b1df-4e5f-8acd-31710ed4399b@acm.org>
 <DM6PR04MB65756C6716317F7E1E47FF50FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
 <74445ebe-15b9-408a-9d5a-9d03d28d836a@acm.org>
In-Reply-To: <74445ebe-15b9-408a-9d5a-9d03d28d836a@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB7248:EE_
x-ms-office365-filtering-correlation-id: 4cdd643d-2f06-411c-6227-08dc3d52bfcc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hZcL3DsIfDgHbpmSX3VKIJPEsqmsEVLJx9yuuvly05isnOYm5ZxdhVWjrkExrsBmQSEmQsqtU9z/49gZAIm49MBje34UFFn1YRFKGnWClwOuRNI8pJq7rzhyqqm9gTmzQN0HCGaFwAvEc60k+wdhkTeQjccRcxfUuANjeBQOnDKAlbbTAznwMsa1zmqknORR7opnPwoZauKRtDzXqvcaB7gys5a5ybS+LIC54zIenL5rlBl20B4imu50uMNeg5CDd7wRUyT6ZTROH1J6AWRqArx9O6uWxb3CIX8eAgXbDFKxNnEG359SxEjBs9IRzxbQ+lRkwwCCqMnlFczJ9muk/w5fxEQbh9z2LLE6oKfWG1w0sTc0rGcYQQMVkJl+OgiqtrQaqTcPQ65U9OJSUtsQ3mMEk3/vDgQ9rKJ6CBu5sX6rcqdmZXjPZPmNTkaJqD1WJICcQ87qSj2aJVAtJ4S8kXHmWfFp+f8TVy83L/dNMH7Y0Kzx0PghIJD5K7vt0OEIVZtxXPKY06z6tAZetBuNsFuDDRwrsJ6N7z8gCG9oFFh/tu9cAmzopfuEdmCtI61IWDJ3IFNh8rm1kJmtnkgcRTAOwRpaxOY7R3jzH6t/pqQOS3D3JMGx3s45Rc3h3Pf1aLIFDIwrgYgpHcFNFWvRFAcwxYBFGqD0deJmrvbP48vWYqvzYpSnZNXDrLn7BrdvpSBLiVulaC4bZv8mAL0JUw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWVVdjdaOWs4dCsxUWkrTHNZTFp4dFFkUVoweG5DM2VrbmFHNFpLNUZCVEZ0?=
 =?utf-8?B?T3NSYzA0ZzhzcDFMWktqUE0yTTBzR0wxMjU3SjQ2dXRPNmYwNis2Q2pLTzN4?=
 =?utf-8?B?cUREcUFsOURYZzVtUFZZUEZ6UjBQY3Q2K2Yza1Z1RWZIeUdoY1dLUnlrKzJ2?=
 =?utf-8?B?ell2WHBvMnBkTVNJSHJQdFdrSTI3dGZ2bnVuaG5BMGM0ODAyOTVnbk5oZ0xE?=
 =?utf-8?B?eU1HUVZmWnQyQk5lUFp5QytiRkl0aUN5UEtZZ3V3Um4zaWxrbWNwNlpBcjJk?=
 =?utf-8?B?Nm1WWnNLOFh2am9UYkZhM0U1K2JPWmlxZTZ1empNUExzeGNYRTl4Y1A5WGZu?=
 =?utf-8?B?djFRdUlnU0RnTUE1TGgvQTE5TnlvVHpBL2lNQ2JVMTJBeTNHU05pNjVwUGlB?=
 =?utf-8?B?ZnRlelR6cmsxRDczd1FDZ3FhWUpJSW9iY3hmREI0d2dMVCtLV1hvSHZzUFZ1?=
 =?utf-8?B?Y0p1RjVxY1FwYm9EaG01ZWFId1JMRFRYa25CUENNSW5zaG00M1pVL3pUU0w2?=
 =?utf-8?B?ZDloT0k0b2lyRmYydHFMSVczOEVPYmZHKzJrSVhjdk5BQ1c2azZmUkM4aHhj?=
 =?utf-8?B?cU03Y3RZSlJtUkpzMVBBcytSSC9qL2dBODF1RWpnNVFVMzZBdy9pMEx3b3pN?=
 =?utf-8?B?ejBFV0ZGVjdJUWdjVEY3VnVZeFJkT3ZQNEFXUEF6RDVoK2txbi9kTTdUM1dz?=
 =?utf-8?B?Y3BGc0pITVpCVkJYNDB0a1UwMUoyL1N1MmJKQnp0VERuU3hocDVyQVFVOTlY?=
 =?utf-8?B?cXRxMVV4eldUMmlvMERTOHhIYU1LNnlSbkVab3lwNzV3dW84MXIwSDluSEps?=
 =?utf-8?B?RXMrUkF6emU5TXQ2UjB5TUhMSWlOZ1FrMmEzcGVBbllCd0tYbi9NNVpXcElI?=
 =?utf-8?B?N2RJVlhLNXptem9PZ2l6WUM2VkxydkVKTytxNGVRcWZGR3RydzduNDQvdVJY?=
 =?utf-8?B?Znl4cmc0cjVMaGdzTmxlckp6b0VyT2VuN2ZXaDFzZ1VPVGhSZmdPUlpyWXdS?=
 =?utf-8?B?R1dTeTVlUUFJdElESVVOdDhwUlhGZXBmWmljU1ljb29tZ3BZUnh4R3hWcnlQ?=
 =?utf-8?B?TVgyRUVyazNGK040RStkTitaN21tZnB3NDFxSzIwalJiOGNIRUxDZmYyeHN0?=
 =?utf-8?B?SFZ1d3NlK3RPRksrdXRsMjdoM3hjTU1BbTZtMjJRQ1hxY0oxTDE1VEErNFJG?=
 =?utf-8?B?RldCb1lMbjhpNWNBcmtSdS9kNnNrOXhSS0tPM2dWdEczdWU2ME1VNlQ0V3BE?=
 =?utf-8?B?QjI3RU81OTlLK0M3czd4VTFOdUtqV0piTXNnek5CMzJhNWdNM3hOM2VZV3RU?=
 =?utf-8?B?bFRaaWdLdWJxd3N0L0FhaTkzSTFFNEx0WExTRFpOUWRTaUI0V0dTTHJWd2dS?=
 =?utf-8?B?Zy9QWFhrRzdwZmR6ejViVnBSR3dlVlJWYXdaamY3YlVPTnRlOExPdXZLTHQ5?=
 =?utf-8?B?OUhYRk9za2ZzRTN3NFJyeDZZUVpCV05VVVNUZm1QQjEwMzdqVXRaSFNRdnNT?=
 =?utf-8?B?ZHVpVXliL3VqTFVTK0lNQWQxa1NDdERucXB6UE41ZzFndzZXdi8vckZXdGll?=
 =?utf-8?B?NWxpUFZKTkI0T1FjNDRUMjJGdFVRUnp5Rnd1Q243Q1lBZjMwSWtBei8rVVJV?=
 =?utf-8?B?blFhSTlJUlA0NGFjcFl3MUwxMHl6cC9aN1U4bWpCcVdHZTF4Q25XRUphNUNN?=
 =?utf-8?B?eHllai8wMzZLbzhMRkhGQWt5Q3NyWk5XUHI2eHo1ZmM5NE9BU3ZBeTMzOGl0?=
 =?utf-8?B?T3JMbFFudnJwNy85M1pndjNTaUJIS2QwcGZ4NnM0aTY4S2hSUDRsN0p3cmE2?=
 =?utf-8?B?M2huNEp0MXpOVm9uSDZVblc3Q2x5S0twNW12NlphejZZSU1wMW1qbTZhaDd3?=
 =?utf-8?B?QUljWWgxcWltUTJBWm1qMWJNZU05bm0raVc5QlAwQkR1dFJzeWNxU2QyMkd1?=
 =?utf-8?B?REJXWFNGWFlSVnJuV0lIZDRleFB1V2dDWkY1dm1iY0xhVm1xM0lVMFFTRlJW?=
 =?utf-8?B?L3R6VGkxeGcyWGVoTWRiYWxsOEZBUmJ5T0x1STNObGhpUFFUL1RGRHM5dDdw?=
 =?utf-8?B?UnJvRjArN1BuTzdwS1pUWWg2Y0tmdWZ1aVdrU1liWDdjbkNzVVM5cGVhRUNM?=
 =?utf-8?Q?nTkHKi+JR8//T9gzPVuvordtf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F+w0wHiMHT9xxqCxDi+4gKln6aTC7OJFrv4MshA03ReELuQa6vwLyvbPBUGbruam9/bcAGOv5b7tmSYhyDCQJtJwg7vbXfw7xBO2twiPP/c+GYR/gWkiXC8BFpztGAYGjfi12rSa0Waby31H0KuKyWDX3+QWf6xLSASwonYHPBiFwgUb2i0v/GP/OV33QoCYle3qB7A5KNCYyzPLBAFZsZKsxrG5RhJAOqm2jWjMj3yiFuu/ImV+a/4i8WHhJGWDMmi1WW3u1XxOMKwIEHRMYtTvgEkI+1Rj06uyGWQJjE1hVFAP2J0/1WmAEWx5foAf1ZYAF7nS5cgHw83a97jyYOVDvEZCO65ils2WnnT+F9fvJBBsAdAeKFjl1lb4R6zA7rhay3QnzW9DdCZvwjpOfYIUt8rmopgVqSqCBKAo2HH8uvjeRUmOUmxZuSKcxZ1vnekjQEGIF/SWv+88EARIGfQU6i9RrN8wry42CJhKIWBTzHPD3qzwa6nyGxMb/LA8LeemlZh0cDq39xplWgQpGxo4uOu+9BhZBBBvPZlff+7wHagqoOJvP6y4IYuJLTnAMSz+CzkhaMwpZJzubvUx/MfCL175ap3cEzBYd6JP499TpodVt1IceED/xlKeYDNN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdd643d-2f06-411c-6227-08dc3d52bfcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 20:27:59.3999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RL8DFYiUFoFHWbnuO2yXOi46cMpsJGe7YU9dJKu6isIlgk0ga5DGZhB+iqASl/PWv7i/HnZ2TAdXnVDPhUGpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7248

PiANCj4gT24gMy81LzI0IDExOjU0LCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiBCYXJ0IFZhbiBB
c3NjaGUgd3JvdGU6DQo+ID4+IFBsZWFzZSByZXN0b3JlIHRoZSAibHJicC0+Y21kID0gTlVMTCIg
YXNzaWdubWVudC4gSSBkb24ndCB0aGluayB0aGF0DQo+ID4+IGl0IGlzIHNhZmUgdG8gcmVtb3Zl
IHRoYXQgYXNzaWdubWVudC4NCj4gID4NCj4gPiBUaGlzIGlzIGEgcmVkdW5kYW50IGFzc2lnbm1l
bnQgLSBiZWluZyBzZXQgdG8gbnVsbCBpbg0KPiB1ZnNoY2RfY29tcG9zZV9kZXZfY21kLg0KPiAN
Cj4gU2hvdWxkbid0IHRoaXMgYmUgbWVudGlvbmVkIGluIHRoZSBwYXRjaCBkZXNjcmlwdGlvbj8N
CldpbGwgYWRkLg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEJhcnQu
DQoNCg==

