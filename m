Return-Path: <linux-kernel+bounces-96102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31B87571A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39109283B99
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9D62574B;
	Thu,  7 Mar 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XdSaIrJN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0K8EPosF"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BD513666D;
	Thu,  7 Mar 2024 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839609; cv=fail; b=SVrOelx6V2arV3NVAYLZZLhU5f3FJP+l41oCPGOHjDRw1fsn/4D174JViBw5743BCrjvhCS6mF/AHPNFMGFTX1t6MHAXrEdoRYnaYy9+ufcMGu+3bWyfNDO4WoqOVh8falgblXiK8fdVDeH9tJow9McTaH8m2Zq+G62l+BltzSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839609; c=relaxed/simple;
	bh=s511N7lAgimTycNgYjSpSlY5IOSTlwNHLigN/qQa5Ik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fg9Rs99u8naiAtfElA4QyQWALviKCbEbI5zz/AhzW5SZJ/htOTnTE2e7g+O7vR8hrYpUap9+ashcGVaSIa1T64QtJ6u57I6Pjn8BbkC9zaXle9mXQvtCpi2D2oDKfF0uz2FHeknP+2HJdD9eJho1TadgL35i7ctV7pO206IOU3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XdSaIrJN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=0K8EPosF; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709839607; x=1741375607;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s511N7lAgimTycNgYjSpSlY5IOSTlwNHLigN/qQa5Ik=;
  b=XdSaIrJNvZllE0Pmzy6FYbeIlxHP2qMpKD+3Qtfm5ES0wuBVwVY4LT38
   kliuh711sQLs98IHzfDG4jFL//R3dFZCnZxAstN1ltQ6ER5GxnSE8edtH
   gHRmXAd29pVAO9A+s0lIUlEm/QJBv7DKoBrP9eQ+Gkkl4fQ6JzHWGAUK3
   TUM14wpCL3TfR7xXUWm6ci0Mp1SUx2C7j+UO+S3/mfugAWGMB6GCVdgKu
   xvV2Q0EnrB67g9BRwEWqwtoifan0sPWmRA7H09cCK15MLFs0MLHf3gYrU
   pO5H49q1XF1O71t0vy+wpQLaXr42mYZU2gvIT9Jrdo3L/2cRR50iTty6O
   w==;
X-CSE-ConnectionGUID: imXLE4aOQT6CHBTaRbgkCQ==
X-CSE-MsgGUID: KrLOs3SMRfOId8AycL9s3w==
X-IronPort-AV: E=Sophos;i="6.07,107,1708358400"; 
   d="scan'208";a="11664914"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2024 03:26:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8uZ7RbsVUcAL8I3zLNhACgl/y1AQt5uH5v/AUCw86nhhNnZgyzOmsQCxr9fmNv22OAldspqwBBwIT9ZcG6HmR1xzPcC767BJ/+cNWFzPQXf93ZdbSMdnuMt+8pxY6uXRr83PqgEcVVBkW32ocR1FFRGIhUVnGmHN8/NRFGTD39FW8C633sLZoFSxNhDrD05bY4DnYcH64kBfYkv/zRPSo62ZagN+3ovUYG7DXYRDYVxKB/+5TZ7AEKuMPkvWYf4k3MyFjRbFDqAMpujbih3AE+rHbbyJgwrSZ7hvn9Y3tA3yfJlDYHVOrGM61zKxStckV66SuW8MIMi6ydarTftcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s511N7lAgimTycNgYjSpSlY5IOSTlwNHLigN/qQa5Ik=;
 b=ee1CuoKSGiryHTYTUfVIgTeoP8EXwCv9HtpTn5/i5hI0D2q2JiySqwjeA/4UF7PPaEY3Z1RT+nLegBP1oDKDgMY/PTSEHqJMhDhFd+vmqDheCQkFvO18afWTvZ9Xp1hskkdsYjECL6E7Jf7qaeBFILQfKSg0PllR/jbfWGtHuQTT81gIBu+Oks6GUj8owrhhsrNFTuIiYdJaO5GHwHXhvWR2ESkLfw68sVyMEGrIoDFiHHHv+FmjzkKj1079OV2up16ppSLzCw0PMI8vzMDJBTgBaNDU31b5e5C/A8DNkO1fDegXENkEgmYSOoBZ7iJ3NoN2v/vgFJb1O3V9ht8DDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s511N7lAgimTycNgYjSpSlY5IOSTlwNHLigN/qQa5Ik=;
 b=0K8EPosFUuN4Ml3Nslly0Q3M7RABGgjg+xXkWoB9cSGuOyZKdCb3z9bBIWwI09fO/mu6PBB3QCHE+2WDi0+3CZcXT1Fft/L0yvYN7Si9XijXyXp3+RKVVAeZu9MMefQqSxaJuDknFfVOs2tQ1OWuXt4L03VRkUidd642hvenTWk=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7683.namprd04.prod.outlook.com (2603:10b6:303:a6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.26; Thu, 7 Mar 2024 19:26:39 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 19:26:38 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bean Huo <huobean@gmail.com>, "James E . J . Bottomley"
	<jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
CC: Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] scsi: ufs: Re-use compose_devman_upiu
Thread-Topic: [PATCH v2 4/4] scsi: ufs: Re-use compose_devman_upiu
Thread-Index: AQHab0BWtBSmpJ6VkUqM3pQjbqLAkbEsQg2AgABqAjA=
Date: Thu, 7 Mar 2024 19:26:38 +0000
Message-ID:
 <DM6PR04MB6575AC3761F84B308EB0633DFC202@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240305210051.10847-1-avri.altman@wdc.com>
	 <20240305210051.10847-5-avri.altman@wdc.com>
 <6826cdb060609f81c970fc21b2050535f7c5a810.camel@gmail.com>
In-Reply-To: <6826cdb060609f81c970fc21b2050535f7c5a810.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7683:EE_
x-ms-office365-filtering-correlation-id: d9aa0408-3f18-4ad6-473f-08dc3edc82e1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ubBuvucvkzJbUJMWluiaq0oraXdQ8+20N3bhl/EOza6m+Qy0p6SOpWDeLNg70CNhPQry/jaWM8+A4eY78VtCP9kaes4xrVwUS5Ro+uXh7rqUd25oA171FvfKSYSKxS7cxOV1fQUf/PV73VMkOF9+HrSXZZf3KEE95JkcBYWUNpat7d70l+CgoYziud8kUpP9yMvVA5J86p0fv722nywG+4aYK9s7h6MqPd61eCEYX0vgwbiHvuYg9aEa6GX9fQXrtVR5p8Q6rrb8Z0DvVZ4pFJlBRRovyB8TkjKRwvGmwuv/zW0wpcE3nzNZmHxZ8/vcEY7+viLb4QKEiPOb4AukO1SAO6ZObKD4371WFCOSwQJqddE8Gee4WmKVCrjoWr+yHl1mrReOCZFsthtnbrti+BuYEhd+ElIG9JEOl2N84Hst0LGvffcqs9M8rIPA209uoINNjDuSSwWZFZQHx9UjIrJsJz2Rd0mlQX+8Wn+hX1yYBhGQhVY/BYRxFPHIQKFMN7ofzRX2woQrbv7emZe0MymBI3XWGNlttPjfOSIkimM42svoGCJVvrSXKt8Kd+sSLR5EDw8dU1SDWrJeCg/oezQMUbilXPlMHcOSz55Eyvb/BVvcM4Chp3g8vwQyslM2HN29LqVrFQVlQa3M2Vdi+VYTwAcP4NrPUIel+7Zazmwn5EKbLte1/9bWcAHJDJbAlofPppTColgty87rUFJeog==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0FESUJWa1B5K3NLaDVVRUplVTVta2lXTjh4UWoraE1wT2hvWENsOWhBbW5r?=
 =?utf-8?B?V3YwRGVwNktFbm1DVzlkeHdodUZWVy9IY0h5b2NHT3dBeDJlL1pvMDJyRjlU?=
 =?utf-8?B?VUNwT1pHc1RhaHZ5ZERMYzFOQUxDUlRXN2VBaUpaeHJSTTlWa3ZoQTkzZ3Rp?=
 =?utf-8?B?anBvMEhtWUVTSGREU3EvOEIwK0lOUW9pazl1MEg2dis1NE8zT1VZQnBsMmJL?=
 =?utf-8?B?ekhOR0JLUFV0b21WdTdiSXVMYjNySzJEUThsOWtiMmE4c0VPUGV0RlR5Q0ZR?=
 =?utf-8?B?Y1M4NC8wMitsdDBnYmwxUmphdWFmUmJsRHRBUy9GU0RkTnlRZHlzOU84bVhu?=
 =?utf-8?B?VStwYm84OVpGOHd3M0U5cFNrejN6QjcyNEU4dEh6Q3R1aDZuZFhpT2UvZm50?=
 =?utf-8?B?b3NNdmdsUVNFTlc2d0NsTFRUQzZJcEkyWVh6M2t6czVEY2xRU1ZRamE2K3Zu?=
 =?utf-8?B?R0orUjdMUlpVN0EzenRzYmQvcjdMTkdNMERmOEhWY1MwdUYxUmkwNWJQVnRB?=
 =?utf-8?B?TEJDQnRmYTd1MHliTEpYQWlmVWpRNWIyaFZlUnRCdVVrcGZQRXVPMWgvZFRO?=
 =?utf-8?B?eWdYUU9nU3FUOGIxTXVBR1kvQUdUbVdFYUdsaXZmaG9xK0VJd25QeksvREJB?=
 =?utf-8?B?TmMxY0c1RTRLdmJJMGRKakpGd2d6WWlPakhkd0JyZzlnWWN3NXQ5SXJVYlo5?=
 =?utf-8?B?dXJ3bnpPTjhUOFFZcjMxd1c0WUpOWTBWa285amJnSDJLNnRMemN4NHpUc3Bv?=
 =?utf-8?B?Rm9iTmo4NElzOWZrREpDUDBoVWlPZWVFbzlUcnJCYVhEYkprVU4vZXd0bklH?=
 =?utf-8?B?bmVnZUVudjhyNmVvSUdhbnIzR2tDTDVpV3NhNEZnSW8vLzJGNFNoYlk0Qnlm?=
 =?utf-8?B?UUdXVnRFRVE2YVluai9vZ3N5OTZ2M3dGOEJyaUdYdllyOGE3UzYvUjNwa2c5?=
 =?utf-8?B?OFR2UlRDUEdqbnFtYWhZRHJDTDNKMUozbkU4WUNZcWtMUnVjdURTbk5KUHFZ?=
 =?utf-8?B?U2p2QzJmdER0bEFPajhGVGdOZVZaTWlHbGtMU2NCOGFTMHh4eGF5RWE4ZTJN?=
 =?utf-8?B?TTFzUEJNYVI2cGpMWU9kYzAwa3M5Q3VsRjNmQWdQT05yOG81d1lNajcyWXlS?=
 =?utf-8?B?RjNDTnozSzNmeTlJVTkyRnZESlVqV0pNU05zeTVhM25RTHF5Z2crVnVITnBC?=
 =?utf-8?B?WlF4c0VpYmVxdkdYTzFiUkVrOVBHODFLZGVFVW5oMUVNY1BWNzIrZTdUZ3JM?=
 =?utf-8?B?V1A0bGNWMXFIemQxNnZsandhN0cxanl2SXd2MS9WcUJMK0hleXkyNHFJTSs0?=
 =?utf-8?B?QVptQ0kvNWNhU0xTYU1nd2ljeTh0SzBKMzBYV1hGTlQvc2NSd0ZjbnN0T1J6?=
 =?utf-8?B?S2Z2REsrcWhEOWtkS09JUnBhaU1QYUZTMnJ1M2ppSHFVYzhaa2UyVlE3VU0v?=
 =?utf-8?B?NnNISEtLQnB3Zjduamo1OUdDTVg1bWNCc0o5dnNvTGZ1U2dVMWVIL2Y5dHpC?=
 =?utf-8?B?VlpYUzd0MlJDQUpQSlBIZmQyMzJLa3p5ZWxERVFJOE8yQWgyY2NZZUhlNjNL?=
 =?utf-8?B?RklMSklBbVN6dmJBdGdrTWxUZmFIOGpYYmE1WENEbDZ0UllwcXY1cUtXZmY1?=
 =?utf-8?B?eEw2dnhuQ3lQZ01jaDNRMk9JbHNYZG9FQ3dGYVAzRFpId1lhVTBUd2NzU0hN?=
 =?utf-8?B?ZW90VG5UL095Sk5HRmVWSjhMbk5KYTJseXFVN0RNSkI4S2ZOVTQ2NWtKY1dm?=
 =?utf-8?B?QlB4Tk5ZOTlldFRDeWIrSVd6L1dqQWMzWlM4cmJyVlhYSzRIZXEzQnNmSDFv?=
 =?utf-8?B?MjJkamxBeU4xbnBSWmN3VHQ4NnVvcU1xakFUSXBUeU15bDIxTlh3NWNoUGZS?=
 =?utf-8?B?T2pNNHpVRnlLdjVvZGdrRjBqcDFsblJFOEVVZ2lVdURBZ1U0ZGlRUTQ5dndR?=
 =?utf-8?B?STJLYjF1YXB0V3hRVFVYYTFROEJZZk1ydlZXWTJEY200RTJJT21aL0x2blhW?=
 =?utf-8?B?OUZyVTlrU3lYRjNJZzJyVzJ6ZVBtRDJ3akFPOTFpMFBZNDVjbHhLQTdkRUVv?=
 =?utf-8?B?N2VDcVA5aWYzUnBwSmFrRjRrZGZIY2swQXZOMEJleGhsZGJ1YnJrWUhRV1ln?=
 =?utf-8?Q?4G61FucZjEPOWICgSOXY0M1oN?=
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
	jyxc3g5p/Xuj+JQefpdYyxR5aTZS2IoMIRPkjZlthrWFy7B/uBlSyvJEuIxAdlzX0O0MMnSzLJVGkn3mHMXt6Cc8+Tj1wit1LYsPBdqHiv7p6GCDN0X14wbWyYU7d6+np92l4g3WgZKYNm9t7lK78pC3Xf0ejcdpDIJ6rW0SRVKv4NxDQD33vyqnTrwfKQ7B+kZLlYgw/6S758/oU/k6RBfqY0oUbFoZwU7H91SxmB2s2rl3TwDIbCYJ4z8Wo0qRhjvMiMehLKAQFuhcwoYgKVewuyS1PGRzFPBoS67Eku8SA/Oz/3egCaLUOynj0c1gYluL0E8nMqMyH9ML5fO7FOtTTk1ryaYTdVJeApxk8THYdArq0rfryMlzB+skmTugS9ir6DFnGb2LDLqlh3AWY/kKmaM/09ZXUdyj8ETStXPUQyG+OI3uOPHPygREfcDWTv+qePVRtFT4RgFapfuw64nJDNEXA7kty72lauCM2EaUpVfoHXgkUk5kpZd76llhe/IgdxmKSOCKNNmJaZSeOvfiPJ1SHSlNRF3bVV9Zqq8MIWsH06Js8xW0Ht/Xrx34ff/z5fajT3eYk08vA1Kzpe9aIFDQnZzYPXtq2JTm7Aqjr05Lsi+jq8tsqeji8m1n
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9aa0408-3f18-4ad6-473f-08dc3edc82e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 19:26:38.9225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDgcG1tg0j8Q9hu7Mro2atGzTAcNHUV+F08tIpunoM4LvK5cyRAaCIJ0X/eOmlueROQv6veSts7Hoinl8SqwDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7683

PiANCj4gT24gVHVlLCAyMDI0LTAzLTA1IGF0IDIzOjAwICswMjAwLCBBdnJpIEFsdG1hbiB3cm90
ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYyBiL2RyaXZlcnMv
dWZzL2NvcmUvdWZzaGNkLmMNCj4gPiBpbmRleCBjOWMyYjdmOTk3NTguLmEzOWEyYjM0ZWUyYiAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jDQo+ID4gKysrIGIvZHJp
dmVycy91ZnMvY29yZS91ZnNoY2QuYw0KPiA+IEBAIC0yNzEwLDE4ICsyNzEwLDI3IEBAIHN0YXRp
YyB2b2lkIHVmc2hjZF9kaXNhYmxlX2ludHIoc3RydWN0IHVmc19oYmENCj4gPiAqaGJhLCB1MzIg
aW50cnMpDQo+ID4gIC8qKg0KPiA+ICAgKiB1ZnNoY2RfcHJlcGFyZV9yZXFfZGVzY19oZHIgLSBG
aWxsIFVUUCBUcmFuc2ZlciByZXF1ZXN0IGRlc2NyaXB0b3INCj4gPiBoZWFkZXIgYWNjb3JkaW5n
IHRvIHJlcXVlc3QNCj4gPiAgICogZGVzY3JpcHRvciBhY2NvcmRpbmcgdG8gcmVxdWVzdA0KPiA+
ICsgKiBAaGJhOiBwZXIgYWRhcHRlciBpbnN0YW5jZQ0KPiA+ICAgKiBAbHJicDogcG9pbnRlciB0
byBsb2NhbCByZWZlcmVuY2UgYmxvY2sNCj4gPiAgICogQHVwaXVfZmxhZ3M6IGZsYWdzIHJlcXVp
cmVkIGluIHRoZSBoZWFkZXINCj4gPiAgICogQGNtZF9kaXI6IHJlcXVlc3RzIGRhdGEgZGlyZWN0
aW9uDQo+ID4gICAqIEBlaHNfbGVuZ3RoOiBUb3RhbCBFSFMgTGVuZ3RoIChpbiAzMuKAkGJ5dGVz
IHVuaXRzIG9mIGFsbCBFeHRyYQ0KPiA+IEhlYWRlciBTZWdtZW50cykNCj4gPiArICogQHNjc2k6
IHNjc2kgb3IgZGV2aWNlIG1hbmFnZW1lbnRgDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXiAgJ2AnDQo+IA0KPiA+ICAgKi8NCj4gPiAtc3RhdGljIHZvaWQgdWZzaGNk
X3ByZXBhcmVfcmVxX2Rlc2NfaGRyKHN0cnVjdCB1ZnNoY2RfbHJiICpscmJwLCB1OA0KPiA+ICp1
cGl1X2ZsYWdzLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBl
bnVtIGRtYV9kYXRhX2RpcmVjdGlvbg0KPiA+IGNtZF9kaXIsIGludCBlaHNfbGVuZ3RoKQ0KPiA+
ICtzdGF0aWMgdm9pZA0KPiA+ICt1ZnNoY2RfcHJlcGFyZV9yZXFfZGVzY19oZHIoc3RydWN0IHVm
c19oYmEgKmhiYSwgc3RydWN0IHVmc2hjZF9scmINCj4gPiAqbHJicCwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdTggKnVwaXVfZmxhZ3MsIGVudW0gZG1hX2RhdGFfZGlyZWN0aW9u
DQo+ID4gY21kX2RpciwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGVoc19s
ZW5ndGgsIGJvb2wgc2NzaSkNCj4gDQo+IFdoeSBub3QgZGlyZWN0bHkgcGFzcyBVVFBfQ01EX1RZ
UEVfU0NTSSBvciBVVFBfQ01EX1RZUEVfREVWX01BTkFHRQ0KPiBpbnN0ZWFkIG9mIHVzaW5nIGJl
bG93ID86IGxvZ2ljPw0KVGhhbmtzLiAgV2lsbCBkbyB0aGF0Lg0KDQpUaGFua3MsDQpBdnJpDQoN
Cj4gDQo+IA0KPiA+ICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgdXRwX3RyYW5zZmVyX3JlcV9kZXNj
ICpyZXFfZGVzYyA9IGxyYnAtDQo+ID4gPnV0cl9kZXNjcmlwdG9yX3B0cjsNCj4gPiAgICAgICAg
IHN0cnVjdCByZXF1ZXN0X2Rlc2NfaGVhZGVyICpoID0gJnJlcV9kZXNjLT5oZWFkZXI7DQo+ID4g
ICAgICAgICBlbnVtIHV0cF9kYXRhX2RpcmVjdGlvbiBkYXRhX2RpcmVjdGlvbjsNCj4gPg0KPiA+
ICsgICAgICAgaWYgKGhiYS0+dWZzX3ZlcnNpb24gPD0gdWZzaGNpX3ZlcnNpb24oMSwgMSkpDQo+
ID4gKyAgICAgICAgICAgICAgIGxyYnAtPmNvbW1hbmRfdHlwZSA9IHNjc2kgPyBVVFBfQ01EX1RZ
UEVfU0NTSSA6DQo+ID4gVVRQX0NNRF9UWVBFX0RFVl9NQU5BR0U7DQo+IA0KDQo=

