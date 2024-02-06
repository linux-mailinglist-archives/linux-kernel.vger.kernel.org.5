Return-Path: <linux-kernel+bounces-55267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3751284B9F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05A31F264BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E951339B6;
	Tue,  6 Feb 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="lRJqXu0F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="kVy7kHf2"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2097.outbound.protection.outlook.com [40.107.8.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B303133292;
	Tue,  6 Feb 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.97
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234259; cv=fail; b=qcaA4qYYgVnQbHu9kmq/NI74hoSHa/1EECnb+HovjE7nvYuhMUMl6Jqv5wkVh7+EFy2nCRN0xGLaLHCiu6Z9tuJH4EBHYwLPJdQPUjazuhd6ijRluzWxbdnP4zkShN6TlG789psB64ge0yv4km1qcfkGN/IfDNLlaaEhVFLSQqY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234259; c=relaxed/simple;
	bh=rr4vALDP4fKwDf3G19W9pPmqx0zieyGhu0H979rmRl0=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jw1HkDZVtUZ8NWeY1epZCJSoHmOyKxi1VBuZ1YURkbCeRBz2k3Hlrd3pedQBYWKjq8j/Y6YvC5/u33ZrNqXsArLrUbbZMsR2U+FGMa9lLqFswJsqrOo9F89JisrypGRlhBeTfHj40k+9Lx50a3icGzP5lEJ3O8w91WoZtbWtUXw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=lRJqXu0F; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=kVy7kHf2 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.8.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=lRtdeld0jaB0s/I3ETgq2P4RkNa+IwysxKXzmFKmXTj/YPDHNh1wNHpIDLVRJ6/dIXGbDlacHym23Irs2+m/6bsobR4G6hmsRtFfejcCC4uNQmEwnfpprTHDx3i1b6vg8272LsaV+RgjoytYtvj23M1YzRVcFko+Qoq/ilL5sLRwGCC7aB/Cc45BrxCBTKbMLr68yqc39U08glGOIl+EgqxGj0eOiLNG1v/UTVenetu07rHPx++rpQ3soIPmVtTJHj//RgDEKK02HkyBZbV8x1mWxoMh/eu0s001cM0geJbLCwAuXeH6ksOEhR8LtGdtxAkBXjJ5HOOo2Lz10F62cg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/d5EqWYn+SxkiFAPtkooyY1XbO+X5gmorJDO1dYhE0=;
 b=k6n5MlyWAlK2mXzA7aW9nplEbdwdS+Hmge6ea60ED7eJli8C37Nwx3tqq+3DtZRVxTr5619Di8Bs76FzbTdpGBIOws0X1tRFO9SRbwiNzAGTjWCyjgb8HKQ7QLDKnW76AhBJ5a21E8eRlBx7j6zfMBQ+y0aLrMiZtNkd/+iZ5RZLad2Aj1ajUmun8t/vU3o+2jWTFs63GhZkduQIJNli3Bs3gSkTf28hFVMU+tgNLPiTvT/Jc9M6PlyimAxJe2eEFrwnMvLj8wuMpXT5Nk78Ph4FGZINyoYbZb+NwgASpy0CPAe3wZWQtGEOBxbumtHdRmr7hTTzvpnjfySN05ru/w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=fail (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/d5EqWYn+SxkiFAPtkooyY1XbO+X5gmorJDO1dYhE0=;
 b=lRJqXu0F4NnWsZv+qU2mTEoRfR+wkPlNc6Fpus9dYqBJVsSrUhwM1dv5Kp2GPk2PKNET7ja9IEQvM9SKX6b1t6t/NpubjqOjygjh5E/63CL3z5tDKEL2liYBcSlbr3pZfuH2krHoOu6Jeovq7Ua/6f2pHfmLQa/7baUVn3jKXCUeEUgbBdWj4XwzkpMy2/6EO+NS5VDM3kFja7A948KduMcMtnAFU1Y87qEyoyd7/9vLp5O96osfUko5Ec4otGL3IzJKW0zw/lQ4/HLXEF7OsHo6AGTkhM5SR9A51tghde0+lPzvq7bMUY8ux58v0VAnP/29Vfs1nvPfo5hJkcrGZw==
Received: from AM5PR1001CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::18)
 by AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 15:44:10 +0000
Received: from AMS0EPF000001A0.eurprd05.prod.outlook.com
 (2603:10a6:206:2:cafe::b0) by AM5PR1001CA0005.outlook.office365.com
 (2603:10a6:206:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Tue, 6 Feb 2024 15:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AMS0EPF000001A0.mail.protection.outlook.com (10.167.16.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 15:44:09 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.105) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 06 Feb 2024 15:44:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf+t9xFwxm4SUsIh/MsHNEbpK4a6cELgz6YK4qjZ57L8a0pM0o4TwPQqzQOupi0UNK+h8P5KsBGyyZUUaD7bfbSYGpwqdweR0iKZAz4TeHWMP4gZNWAi90DaC1OkAOJfZJqZohW+1xO14LBdNLiFdeUJTPKj9UNaj8ZKD/2GERjsDTepr3XN3t+cEBW2kZ/06QIPmBe4WSE10Iz8VA97ZB8fHuF1DoOFmmPVdPeHW9kz0/uje6Dkj+bgpY1uOhlJfBYKiR9fUGcF1If3JXFsByPvJrdQHAwwdolGtdTGjdG1DOjYaPGjbD36I7AEYSEVG/OGBHPfuonV+pP3jPqQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRUWpqDpLER469HusgwqRdcUjYUoXORVv88NuvDBst8=;
 b=SyXl5k7OcNV0GiJgUIKWNTqJZyKrVIyXB+GKu9rDcF4ltsT4SpcWYsAxN46z+3EWB4R8g/IwlUBnVBNXjZRhhSatMEATE/N0Q6VYhHW/+kFvtYMEb+qlQ862XC61m7a7rfc0GYV0C6AKQ850d1kbMb5JTX2cFiDAycA3g+Ku3pbxco4JUUmsRUQvQowEcaxjrzHfHIKahdJxTlaCpW70RDOR5242xf2CA+sksamOXzYGRNm2OXAugLSJxKPObYQ/qLMY3L+c/Rq0i1YT91PWlGBAvfI9rdanC2LjscKtDXEr4VccCToNJ7oRsC8iQ5hha6VdwrvfzDvp8L2VH/J/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRUWpqDpLER469HusgwqRdcUjYUoXORVv88NuvDBst8=;
 b=kVy7kHf2ftD/0w/3wUFbKFcme5FfdgpTExDxU3/KqWlV7GEXPRoc7R6BEPgCMrEhbUbYEtGwP/iZD1LAiTlGW8pRbjg06FSJVICUrJy9yf9uZaxbacxJTn4ZQ5bSaU0GuKHyCT7FMi+33IfWOh0j4rj1GTrnSlCahCoR5A2p6FRY0eFqrr2LZzxoWSd4ZwgSSR72gTWr9Phgl6KALXXhrQscxBsQSyO4Uz2c7kAXmu+cvq4htCgYbWlUW7OtdO9EAvLCUFV6V0LBBB1GjN+QvP9GNIndVJBEioezbvifcNZ+tmTrOfDyU6oH5WIugWY1xUAT82he0M/fTX7NEa5paA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by GVXPR04MB9758.eurprd04.prod.outlook.com (2603:10a6:150:110::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 15:44:04 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 15:44:04 +0000
Message-ID: <e04ca010-289c-4216-95ea-2f2418613378@topic.nl>
Date: Tue, 6 Feb 2024 16:44:03 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1298: Add driver
Content-Language: en-US, nl
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Liam Beguin <liambeguin@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Mark Brown <broonie@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
References: <20240206065818.2016910-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.fd628a1a-a926-426e-a239-bfd8c9858b94@emailsignatures365.codetwo.com>
 <20240206065818.2016910-2-mike.looijmans@topic.nl>
 <ZcIsuiuisQjTIxJv@smile.fi.intel.com>
 <4c6654f5-2d9e-4c1b-a5de-7bdeacf5e99f@topic.nl>
 <ZcI5PoWojKRrdpVl@smile.fi.intel.com>
 <67387cf4-1065-4313-b4c6-054128ba8f3a@topic.nl>
 <40a3a47b-1388-4ed0-a24b-2c0bcef3be3d@topic.nl>
 <ZcJLnOiFoaABami1@smile.fi.intel.com>
Organization: Topic
In-Reply-To: <ZcJLnOiFoaABami1@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::12) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|GVXPR04MB9758:EE_|AMS0EPF000001A0:EE_|AS4PR04MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d2ef2a-1ef2-4a15-9994-08dc272a75db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 Z+B86hJEX+XeOWVo5W9PxrbTQ3O3gK+RdQnNitoHmCfD8DAN5aQB61qpduqmPF8bsMZJrI5qaXuDMOUjYV+NW9+pmaZ9l9FGET4zQIGnBtZY42wPw7iNuJrMu3xX7p+fMs6bpz0weckwswz92bffGThXDcl62jvQgTq4q7vkj0xyXm1MfbuZj3vhzMeyjJBgJkPBx6xE2sXU2vtC+i2KcvT8xjAA9otm68lZv8uT45aA6U9Eca95Zti1YTkJ2BuJ37UohBCanF/Vuhn0RnoLzuxU5PmkGyiOfcY3oYFFzJyXPh2RPFT64pDOSx5PsT1MCjTdDGwUtCp2mvAY2M5b2G9FBI3dpplxViCkRTXZhDIN5S9tIAprutP7uITlnUMXPCEq1F+H/VkKehN6mlbhSe1VlNmyz4xVR+w75H48fQWy10tjs0agVw0qsT3Q9dKpxbyaLfN088YzHL7XvUu+LILsrNjlIuOMwR+/8fmVIeHZQL/vco+KcDdt3xRCQYY6sa8JaSxp7GCl9rc1McG+dcZGkUD9iRmddiCJ+DszLNJ1Xr0/R8xIG8blEJo89lRH09xnCV0ZksFyDzs1IsfnkTm0EFT2xFr1fFhTYQwzi3/b8u6ZSUvCYeR+xnOvIPMWMLemqVW/HqKaA+fjSWC9l+0rL5QOcyQyObJnGMwThbI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(376002)(136003)(366004)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(7416002)(5660300002)(44832011)(2906002)(31686004)(86362001)(41300700001)(83380400001)(38100700002)(31696002)(26005)(2616005)(15974865002)(36916002)(6512007)(6506007)(52116002)(36756003)(66476007)(54906003)(6916009)(478600001)(6486002)(66946007)(53546011)(66556008)(4326008)(38350700005)(8676002)(8936002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9758
X-CodeTwo-MessageID: 1528df36-8057-48d1-8c11-da68809fd9f8.20240206154408@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	72804338-807c-4406-4985-08dc272a728f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YMbC4+Lu4rOMCzXUtX9izmNiY48uji5FlEIbKk3ToNd3kVaI78gypLxj+yfXGwPeue3pG0LLAhWfMwIWUbPgUH8I6A+9bX+4i78cq515CVFJUXUA135Dc3fj7pqGfefH7VS1bkhH/839Smzw1kF1xtR6Hf+Lx2i96RZTahR/l4d4aMVsY/d21dc1q4KtGM2qa2Ojwim5h7A6FI/uoORpny4xmCfQRed2nA+Z7XQppPlZfN7dCBSHoiYJowX9AkMT3rtWTcYEHkZFORhU4mqXUIAlKDZdDFMsIOPROzfbY0NMBNaC7N1HITyiq3esj/+Q8Y1yCUrJorPiVFjUPUlq6njVcRheH1QsA0NDDYAKf9MTvsQW0iOwXtHuzdK8Hk9cnI5GtBP6dyFKVWQN6bp0ZFH1OiG1/W2QCjsHENuet0rIwZlZIpAYMIGB9TGe/B2EGCO4uD1VDDFMUdyXe4DPuEEmKmZ6Joo5omYnn67Wd3iP2UGo8Xay3vOAt5b6jDaje+34S+iPMZZ0zP1D3llVOBiEO/o3tsB2wJAxHk2tpas/Ar/Ir4jxtKrVDOpkn5H7bcPh8Y3B6nTeATVhndQte8oseSrXnxUC9Ubp3E5vjmE9rJVsPuOLv1WhnFWw38t880OcB68+G8UZQYRTYI9bp8pATrnmLbvidlTA4+lwYSIBeTdJ9KGEbmThLlWaQuUIgInqGITINLwDzgLr9q4XzZGDG+OanFN5OnhMUmd5YSMgkHPh53bWVfej/iigItOXuQU43MUx2WQr44K2AH9NTA==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(39840400004)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(46966006)(36840700001)(41300700001)(31686004)(40480700001)(6506007)(53546011)(47076005)(336012)(36916002)(2616005)(6512007)(26005)(7636003)(31696002)(7596003)(36860700001)(36756003)(86362001)(15974865002)(356005)(7416002)(4326008)(2906002)(6486002)(83380400001)(44832011)(8936002)(8676002)(5660300002)(316002)(478600001)(54906003)(6916009)(70206006)(70586007)(43740500002)(18886075002);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:44:09.8578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d2ef2a-1ef2-4a15-9994-08dc272a75db
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689

On 06-02-2024 16:09, Andy Shevchenko wrote:
> On Tue, Feb 06, 2024 at 03:47:45PM +0100, Mike Looijmans wrote:
>> On 06-02-2024 15:25, Mike Looijmans wrote:
>>> On 06-02-2024 14:50, Andy Shevchenko wrote:
>>>> On Tue, Feb 06, 2024 at 02:33:47PM +0100, Mike Looijmans wrote:
>>>>> On 06-02-2024 13:57, Andy Shevchenko wrote:
>>>>>> On Tue, Feb 06, 2024 at 07:58:18AM +0100, Mike Looijmans wrote:
> ...
>
>>>>>>> +=C2=A0=C2=A0=C2=A0 wasbusy =3D --priv->rdata_xfer_busy;
>>>>>> Why preincrement? How would it be different from postincrement?
>>>>> Maybe better write this as:
>>>>>
>>>>> --priv->rdata_xfer_busy;
>>>>>
>>>>> wasbusy =3D priv->rdata_xfer_busy;
>>>>>
>>>>> I want the value after decrementing it.
>>>> Yes, looks more obvious.
>>> Having done that, and looking at it again, it's better to just eliminat=
e
>>> the local "wasbusy" altogether. More concise.
>>
>> This removes the decrement operator, so the method now looks like this:
>>
>>
>> static void ads1298_rdata_release_busy_or_restart(struct ads1298_private
>> *priv)
>> {
>>  =C2=A0=C2=A0 =C2=A0guard(spinlock_irqsave)(&priv->irq_busy_lock);
>>
>>  =C2=A0=C2=A0 =C2=A0if (priv->rdata_xfer_busy > 1) {
>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 /*
>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0* DRDY interrupt occurred b=
efore SPI completion. Start a new
>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0* SPI transaction now to re=
trieve the data that wasn't latched
>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0* into the ADS1298 chip's t=
ransfer buffer yet.
>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0*/
>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 spi_async(priv->spi, &priv->rdata=
_msg);
>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 /*
>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0* If more than one DRDY too=
k place, there was an overrun. Since
>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0* the sample is already los=
t, reset the counter to 1 so that
>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0* we will wait for a DRDY i=
nterrupt after this SPI transaction.
>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0*/
>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 priv->rdata_xfer_busy =3D 1;
>>  =C2=A0=C2=A0 =C2=A0} else {
>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 /* No pending data, wait for DRDY=
 */
>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 priv->rdata_xfer_busy =3D 0;
>>  =C2=A0=C2=A0 =C2=A0}
>> }
> Yep and it looks like you reinvented atomics :-)
>
> 	atomic_t rdata_xfer_busy;
> 	...
>
> But it's up to you what to do with that.
> Maybe Jonathan can advice something different.
>
The spinlock also protects the call to spi_async().


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




