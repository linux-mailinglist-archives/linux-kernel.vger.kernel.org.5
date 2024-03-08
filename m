Return-Path: <linux-kernel+bounces-97516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C0B876B4F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E771C21288
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FCB57862;
	Fri,  8 Mar 2024 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m1KXqV2I";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="o/8tgpsT"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2915756B8A;
	Fri,  8 Mar 2024 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709926984; cv=fail; b=BoGaTmTdfusgtN6mAePbPMS732VXePHYtzplGtYxZ648CiBcLgzRvSNDcYIkbFsO/IYpVpAAobYPjR75Dcav/714DZldmUzSh8OlZzLrYWJwAcKzliQG1X4DoJZipkW59msDBjVbmlRIR3mDkBtxqe91hJiTX3WFq0KlHiWH1oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709926984; c=relaxed/simple;
	bh=k/pZRTccLN6x9AwJEYc1ET00F6NQtJxk+RzTKkOurb8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eTENjSePm19uHPDpTbXLM3GtD5SHTFJfdjjc1wPPdNaRujgoZ9uh6J7ZDB4we5iGknsTFzX6QiQneCn2OziJ4UA/r/wClnHc2aAxvZ9ltPf/mjXegMLQQTaMAVYp/aRJRAaLrbEe09GbccaUQeaaq9MzlhGg6g4GSuI8FbUMN6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=m1KXqV2I; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=o/8tgpsT; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709926983; x=1741462983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k/pZRTccLN6x9AwJEYc1ET00F6NQtJxk+RzTKkOurb8=;
  b=m1KXqV2I1Ez9vM1vox9bawXD6bYJRIFqhoT954OYXszTEIveHuHfHw2K
   J/CaSSuqwvVbVlctYvyOc16edUyOVQ2impVdFAZgf0pKlfmDAWH3GVIUU
   Y8ZhxW0GtDbq867Kr28HbqtZAKj2zB9gnCrb9nkRgWfqEGxp7Pf23+2Vz
   0zAAVqcdSZyIgzQqZm66D9/gZrWjDmy67bhDgawxy9FEQTfqEUw5WNkyj
   bLlkdJz5AAYNrHKNGlyCZOs00UYVnCyH6OGIYggl/SCPE83DXlwA3vCLF
   C+U8sjhBIsFo4xAD3Jhb1+jL6vXnuAl1YwPdE14l8zNnhLsQKZYzvJKaE
   w==;
X-CSE-ConnectionGUID: +bk8LLfCQrKVggHg/7vhtw==
X-CSE-MsgGUID: B6iyMiCQR7qi83WnmYnbPg==
X-IronPort-AV: E=Sophos;i="6.07,110,1708358400"; 
   d="scan'208";a="10997106"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2024 03:42:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZm/661qklL4bh2KM0/IXuqh6EOY0d/SJ1IR2mMXHubZTRtZkOyIvYn0eQi6Zbmm9WlvUn0t7zSIX8U0T7CISIMoRN7b9QtmgqhaODmnV2jpapKJ4Qt28p76z9JVcoEhS/M9C5KuDxQ6AXaOop3q/BTTVICsqjoC5ktdYCBKIH8z/IHWBSg9vcIJCVBP+fZkMF9RitJtD8D33NRHboQSSnBBtRY5FLd5it1+0pOXtPTwNBwlylWv0s3Rh6e8ZICpdnS3rUoNw98fn3RM5JKd+C3C6Alp25ANcpSQ9/4VxnnLTObohLB3tCm1Su1AYN2FlTnJFEbCp9rTbX6oWdpy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/pZRTccLN6x9AwJEYc1ET00F6NQtJxk+RzTKkOurb8=;
 b=TcAjwt1tWVXnL1YyqbTQD0XElHvylS9KxgDxV0z3B+QEtsuV5s6xY9/7v/g7Vwo5Z9BOsVhcerbQcPM8k1sihQXtCvzYNd1eAIwu5ncuB5+wjSd21wVibWzK9nQ2NArRtliLo22nFYq1vriHHcBqTJhFpZPVvLC1cFU13LY70kIVrf+Bm8CpG4EVsRZTGi8EIgYlWhbwqmQM81oWasUxOBoXABmj2fEht7gvqgSwe4K7sP6f/x2H+Nb20q2UCfaE3R4KcZX9O+rYIl89GAoWzo2vM7qWpJkNQw1+VXrTdi8elgrVHFbvYbachLXcvuJfRt/zlysrKmVzevEmt6nqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/pZRTccLN6x9AwJEYc1ET00F6NQtJxk+RzTKkOurb8=;
 b=o/8tgpsT+F+qn6VYnCox//1a/Q+vaD27zDtWu6o14I29Wl25raiJBEWDC31p5NNfeYRTcR/5GDIAKJRg8oIWrBHoMFoFD1HkNc0QNPahWd07q9jJlxiUuOjr7a3pMCKOyEbv0oMeek8JTyjqcK7A3jlTWXIP+poKKjIEXPW1hEQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 IA0PR04MB9035.namprd04.prod.outlook.com (2603:10b6:208:48a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 19:42:52 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 19:42:51 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bean Huo <huobean@gmail.com>, "James E . J . Bottomley"
	<jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
CC: Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] scsi: ufs: Re-use exec_dev_cmd
Thread-Topic: [PATCH v2 2/4] scsi: ufs: Re-use exec_dev_cmd
Thread-Index: AQHab0BKI7cW0RmwrUWKY2Jh4C2U8bErRjmAgAFmNnCAAZMGgIAAA3xw
Date: Fri, 8 Mar 2024 19:42:51 +0000
Message-ID:
 <DM6PR04MB6575E9D617132757127D7A29FC272@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240305210051.10847-1-avri.altman@wdc.com>
	 <20240305210051.10847-3-avri.altman@wdc.com>
	 <6c75ce4cc05c6983137e954043d5ae7323a96172.camel@gmail.com>
	 <DM6PR04MB6575A5D43DF0589B480A4EA9FC202@DM6PR04MB6575.namprd04.prod.outlook.com>
 <e96bd7b0b5b6abbde6a5e2396bc5a291e4c9ddad.camel@gmail.com>
In-Reply-To: <e96bd7b0b5b6abbde6a5e2396bc5a291e4c9ddad.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|IA0PR04MB9035:EE_
x-ms-office365-filtering-correlation-id: 5f0b4226-d5cb-46b6-e29d-08dc3fa7f141
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kSKOnjHypVqnediYcE7a60kd2gwZ8HeQTYGcvyFbnAmCTwSWYP9PmWMxbhH27WwK6KxkIca2d6hhAE9QgUxbbsnGrMCFzXCEZHb/o+u6UxRNEASvlb9mlrkNMq1w+vRZIZ07S5s3gsnzlkqjRME0uYxEY1yZ9kk5DWWL/otkzcDJfkhv8QvOISRi6s8Z8EcTXmOPqi6tw9CuI3ToQOW5hKr+u9y1vbHCDY3skb+twwrtnMTvk0f3wTz1QsLTPmq45pRL6hROLZMKhvNgNwo1wz7uPfe1o7g9rnchv67CdXkZ6td/iFjOplnqAz8FRs2XwBdOD+xfxDFbx6w+XCJghnkrzj0MYhMjTZpdXRffRbOAVTjf9H3T/qZY6wM2y6U+LsiD3GmB2Dw+tt1icFsxmjiJqgoxmRlcpYcgR8bnWx5QZHAmHp9frykr4ixl74HehBw318dPie7KrydxhPE7PH++axEV0PHa6l/JjtJ2k9r+mW9Kd/bpzqrWjI1SNtLyRHxgRf7YhmcrHqlVbHpYTh7fRVSGX2fYkKWX8G6SYF1OlbGdpI6MVMP4BsBHRqgij13AOl+kGPO14Ly0IdSpiyPKg6cF6XmRg+yZEKgu8ukr6mtStGbxra1ln/dNraTapOBR70azzixhae/cFpcvj9vbSXCoKMMhA8MT5CJ0TMi+qEdxGCR73m+BdGXqrbvVAX4hn8NjAplcEfv/cnBhDw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHU4M3VQdUtRL0hvMDdZcHJFRHJ3azRiekcxMXNySjhlZm5CdkM3cXB4U0Vz?=
 =?utf-8?B?cGRCVGk3dnVRQTk5aGNVS0U4VGo5SjNaemx2Q1FnZXFkU0xqYXkwUDBDS1NM?=
 =?utf-8?B?eFdia3JFc3dDeEdsWWRYOUNGZXV1U1NDQkdXSGUzaSs5emVFRm9UZmZvZVRz?=
 =?utf-8?B?NlF0aVZVb0Y2ZFQrcmlLRldHWlNrOThqOXc2RW5WemI3MGtDRkhuRThQRVE1?=
 =?utf-8?B?eGhHd2xrQ0NkdWNqdVcrOUhEWVgyOFFYR293V1FIUllMZlo1ZlBCUU1LL2N3?=
 =?utf-8?B?OEUvZTJsazVwUEthZGpvS0paYXBVWWVtUlFGN1hsZUY0L0hlNGhjbEZ5eXp6?=
 =?utf-8?B?b1Z0cjBib0FRZ1c0RE9obEVKbDZiZWhhbnQwRWNIVjV0WmNFODFYKy9GMFJB?=
 =?utf-8?B?ZVJXQXRycE43cm9SNmt4L2pzOW9OK1BmQ3VVTS9KWlJsd2dsc2kySCthOUtK?=
 =?utf-8?B?QS84cWd5Qjl0NjUrb3lRSGNRNHkyYkNDallOUGdISWFtdjUrY3V6VW9jNU5H?=
 =?utf-8?B?OVJRUTN2L2g1SVR3bkE5b1dkckZ3VG9OeUZodlRGdU9XV0RpVU5NQy9XZWt4?=
 =?utf-8?B?Wm5XVUhzOU9BeFQvbTJNbC80R3ZUdEFUejJ3TTREUCs1UDBPd0VhNlZDeHBi?=
 =?utf-8?B?K1ZyRlRuV1BQL1ZEMzk1c2VUYWpFRmZZTGoyOFZydmNtQ1VkWWZKYzdXQkVN?=
 =?utf-8?B?bzFIbE9IZ2dDNnBsMVdDcFBvczNGOVpVQi9TTVdwOUxhMjdhazZ3b3Q4dld0?=
 =?utf-8?B?Vks0cWMxU045TXc0L1dKcS9IQldDU0hJRHRRa2F5SUY5SkRKUjR0MHYrcDhT?=
 =?utf-8?B?U2lXYnQycmJaUUI4WEtLV1ZadjdwK3pTRC9xSVprbWhmdEtxWStjN2NpdGxl?=
 =?utf-8?B?V1hOdWVrQksxUUlQcjgxZHRUWUJ6b09GRnhRMkVGTmpIUVV4QmNGWCtCRXJ5?=
 =?utf-8?B?NkpMeHRIamkwTStCRy9oWGF0dmNkaGYyU2hHelB4Yyt2QXk0N2ZMQlpwS3ZY?=
 =?utf-8?B?NzNjN25FNHU4Tm9NMXdMSTRaSU0xTzZValZzOHlWWHQzU0NxYWhYaHVoaFBD?=
 =?utf-8?B?MlJBQnkwaXFwNXRCbjFlNVJVR0hPYU1lRnU0WHVkOFB0d3h2YVQ1V1dqMVpX?=
 =?utf-8?B?QzMwdTA2V2E5ZTF1enMxK2pxY2h2YjRZNUFYMm80aGsyZzJiK2tlV1plRkg1?=
 =?utf-8?B?SVJvUDM4WHlRMjZhNmNxVkd4UGxMUkVObzU2OTNlVGNHcDR1a3RSRGF1VDdk?=
 =?utf-8?B?VGxQZ1ZkWnd4NEhBSVBtcEpJaUoyU2lUV0ZZbnVHTGFqTUpYK1VFdGZwMDl6?=
 =?utf-8?B?dlhNV0xJZVo4eldxU0lSRlRJcUsyU0VDaW9kZEdwR3hoQkdQNnpyd3ZuaWFC?=
 =?utf-8?B?ZXdZbkE0SVZlaUR3OUtjN0l6ZU5sZ3pyNVExZUJNaERTWHBKY1NmcUdMdHpM?=
 =?utf-8?B?VW9HbG56a29teTN6RWZiWlE4UWpwL2t6RFFBZS9zU2w5REdFRnZ6UHpoR0NO?=
 =?utf-8?B?Y2JNMHR0dXFFb2JKVTR5dUo4VHp5WmJzaUEzOWpxS1BGT2tLaEgwQmZsUmtt?=
 =?utf-8?B?WU93d2wyc2s4M0xuYUJ1bkdOVXRERURDMDNNN1RpdmJkOTd5NVAvMnJWeHVo?=
 =?utf-8?B?M2ZwSXlkQml6Z0pVMVZCWjhMcDNWTkp2QnNZMWk4TVp2QlludFhNMTIxanFy?=
 =?utf-8?B?Vyt2RXBSU29VNHcwUWxpZjJIYTVxT3I5eFhjV2pPa25nc2o2QjN0UFBuWU9T?=
 =?utf-8?B?M3p6U094Qmc1Q0RVdk50M0gxaHU3SUlqV2pveHRlYkVaSUZZR3NuSHdmNjFW?=
 =?utf-8?B?cTlTZnFhemQrV3lwRkl0RXg0VWZXMEpQVTJNQ2hlUFVnRnBGL0tsRlpRS01W?=
 =?utf-8?B?NjZVd0dKODN3SFoxZmtOdmRHaEVJU0tacC9UWmE1b1JKUXNlTXhPZUNuV3Fl?=
 =?utf-8?B?T2NXNTBKcmZad0ppVmlGRmVQZDVGUTNOb2U3R3pGUTcrWjMrOXcxMk43MVBC?=
 =?utf-8?B?ZkFQYUtpZDArbEpNdXdSSFl2WW1malNMZ0J3LzNhR1lDOFA3cE1xS1pUcnQ3?=
 =?utf-8?B?VVhKbVZuWTFkRWd2azBKNlJUVUhWdFltQnJJSk9DUHc3QzVabjVUKzdlZmVX?=
 =?utf-8?Q?tpnceKoPior8g19XDdv9y7MZE?=
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
	K/7dA1A1i/AI7Nxf+24d9vBoSx0YT4tz8bGAMFXDuFMDcDdF+EDM7Hwxr2/l48E05gCph6fv/WlfukNYgJ4zA8Wgkzh2krCR2Pk8+xyPHEBY1/zviTKoQCFY6rKUlrDFlP/348hC7BH044xVJJkaRkYAMfXZjwgjoTWMfujdYCx5Zgg2gPbZYkDjyD4HSNjFD0/ELUiw3fKOvcauj3rkNui65k3WtBpl4Ir+KP3GN2W7Mt7XPPN71XIqn93LC8ugWMpujL4KIPYfJgOSjgoETpBuD7k1GYTq9+2VJBUeVisUqJbnjG6f6OZFnU6XexbpuChFxPSLW50G6t7Kd+3AOu0sTBkRIE3cOuInXn3z0o4vIqcvp0hEvHwJUkHPwuqezohj9rWQEc7yUoYYyjiGP0cm2j1qceBgqV+HZ2sPGxJJz1t6i1arWscX6xcVb5cVCcLfXROOSsKr+BH6fvlMWdsMRd1vWF1G8diASfkANfJovBJngBQdHkVlaou73nwe+/2w/GFVnYCQyA4M1mAfTjukv2rvsqfvr0tEGapO9xUDh1fsF91FDVipCVYP6W32cYyOgcy7Kb1o0QCjG8NgwF7dKyJiBlaouBF6388HR30GfQ6ilQjL+vaR1OJRTTyf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0b4226-d5cb-46b6-e29d-08dc3fa7f141
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 19:42:51.9435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13uN4D/CiMOy9ctHnBn95ht8NGZ+Y46eqyEf6JWg9gvyNZMgRCGX5gW6jD8B5miXUFT2llrjVCOxrLJqZWBGBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB9035

PiBPbiBUaHUsIDIwMjQtMDMtMDcgYXQgMTk6MjggKzAwMDAsIEF2cmkgQWx0bWFuIHdyb3RlOg0K
PiA+ID4gT24gVHVlLCAyMDI0LTAzLTA1IGF0IDIzOjAwICswMjAwLCBBdnJpIEFsdG1hbiB3cm90
ZToNCj4gPiA+ID4gTW92ZSBvdXQgdGhlIGFjdHVhbCBjb21tYW5kIGlzc3VlIGZyb20gZXhlY19k
ZXZfY21kIHNvIGl0IGNhbiBiZQ0KPiA+ID4gPiB1c2VkIGVsc2V3aGVyZS4gIFdoaWxlIGF0IGl0
LCByZW1vdmUgYSByZWR1bmRhbnQgImxyYnAtPmNtZCA9DQo+ID4gPiA+IE5VTEwiDQo+ID4gPiA+
IGFzc2lnbm1lbnQuICBBbHNvLCBhcyBhIGZyZWUgYm9udXMsIGNhbGwgdGhlIHVwaXUgdHJhY2Ug
aWYgaXQNCj4gPiA+ID4gZG9lc24ndC4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gVGhpcyBzdGF0ZW1l
bnQgaXMgYSBiaXQgc3RyYW5nZSwgd2hhdCBpdCBpcyAiaWYgaXQgZG9lc24ndCI/DQo+ID4gPg0K
PiA+ID4gZnJvbSB0aGUgY2hhbmdlLCB0aGUgcGF0Y2ggcmVmYWN0b3JzIGNvbW1hbmQgaXNzdWUg
Zm9yIGJyb2FkZXIgdXNhZ2UNCj4gPiA+IGFuZCBlbmhhbmNlIFVQSVUgdHJhY2luZywgaXNvbGF0
ZSB0aGUgY29tbWFuZCBpc3N1YW5jZSBsb2dpYyBmcm9tDQo+ID4gPiBgdWZzaGNkX2V4ZWNfZGV2
X2NtZGAgdG8gYWxsb3cgcmV1c2UgYWNyb3NzIGRpZmZlcmVudCBjb250ZXh0cy4NCj4gPiBXaGF0
IEkgbWVhbnQgaXMsIHRoYXQgSSBzZWUgbm8gZG93bnNpZGUgZm9yIGluY2x1ZGluZyB0aGUgYnNn
IHBhdGggaW4NCj4gPiB0aGUgdXBpdSB0cmFjZSBldmVudC4NCj4gPiBEbyB5b3Ugb2JqZWN0IHRv
IHRoYXQ/DQo+IA0KPiBBdnJpLA0KPiANCj4gbm8sIEkgbWVhbnQgeW91ciBjb21taXQgbWVzc2Fn
ZSBpcyBub3QgY2xlYXJlci4gYW5kIHRoZW4gdW5kZXJzdG9vZCBhZnRlcg0KPiByZWFkaW5nIHlv
dXIgcGF0Y2guDQpXaWxsIHJld29yZCB0aGUgY29tbWl0IGxvZy4NCg0KVGhhbmtzLA0KQXZyaQ0K
DQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IEJlYW4NCg==

