Return-Path: <linux-kernel+bounces-42084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314A583FC19
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15A51F21F66
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3A1F515;
	Mon, 29 Jan 2024 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k8ZL+DIx";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="XxbMT48h"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4341BEECC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706494662; cv=fail; b=fvz2pRCYKfXJeEFte9SA9VT61RK9allgOYGiJgiWGt9JYmQfT1Tm152K3npUWBHj0408TRtsVXL8uDvNaBJWJEHl3r7Bsaxqhx4nqJ2fLqDEIgoHdF696QL+YAVUQ2IIGJmVH+FWSNuoA/wrGWORwiBRd101K3GO14Pq3a4vdas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706494662; c=relaxed/simple;
	bh=NT75Hdd9IHUZdfEnRpuM1pO9S1tf0Duy8oTvCeAyKAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a3LTImQsmZ6RoBZ1qQNbJvzGFJhcxJRVY4lADzbQxyXauEagukUjKG+9UnHIbuQ53mMMfDN2HUxY1zBqjcSSssVVQIqVYRZzaqDx0BtuAn4eYZf5dAf8jlhJ2Fx5vtonZmbD0H3213mggEXIFdfflZJObEVfjYScuM61sckzHgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=k8ZL+DIx; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=XxbMT48h; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8d3b19e6be4c11eea2298b7352fd921d-20240129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NT75Hdd9IHUZdfEnRpuM1pO9S1tf0Duy8oTvCeAyKAo=;
	b=k8ZL+DIxyJn8Fm0afQHYV2YwfOsqwauSJi2mmCDze6E2H/EAMmx0u+HQux6J9n/6ykt0vylGRt4QCYkfDCgqH3GXCYouq26TJPQKBddHQlBRdpJqs+pS9hfMbT4g1t4myVFufS2oYcw+piWaa7ALZMZvdXyb+Ujubu1aZ/cErbc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:b1837f86-e6a1-446e-8d9e-9451d6ce9388,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:cfff5983-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8d3b19e6be4c11eea2298b7352fd921d-20240129
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <gavin.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1223820924; Mon, 29 Jan 2024 10:17:29 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 Jan 2024 10:17:27 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 29 Jan 2024 10:17:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odDNaAqQpw7Pgz2LGThLzq1XVTaHHJjbqSDbs5SFsFpihuX5rbGvqmjLJ9zPFWUfTBWoShgvhV4XqaxVIL0UuQwp8KZUko0u0k7D8OUvLqnq3DJgdg1WNsJTGBZeCoJKJP4biRIOwYZjUsOcA1oQYrwlSc0p3QamO1l2eojLKeuirWM/IEYJ2RftM62kEInt4RikQdftDDc4m67BhTeq4SjhSDJHDZQqsN6pm0ul8Hfckk7OojphP53j3mJogztjViUy51uDvHLBeskWR3GU6KCeLRJQXQ7BH4vRK7pHAMI9OtZTAfdnY7QILWTABylc/y+yzJUMp0T/PUP39LORAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NT75Hdd9IHUZdfEnRpuM1pO9S1tf0Duy8oTvCeAyKAo=;
 b=ZYVqRpjtU7oUx0Rm4wG/bRGMxnH/CX8luD3g3ezgsFxQdhRclQI1vi4Mvvqzlqm4ItJquyUML84dpcO1jPQbdvQy21MgWHGCXbxv+O20v0RiZmG1XeUszswEn94PygLQ9RuMyyuXILvhKYvZLq+xFEnzt+PDFwNVrj4pmh3sVfgXy6jt8aZJY7FYjMxbesfi/CagMtXPp2oLbxYZN0iO31YsrCYbvIZgsIdmylkEGPHstPfq/6UXaIFjs1+g0SMGA2i/DFGKZ85qiWD587aiUVVgh6djRVcdOqshtImHjPSrg/tCCc3AfZcR3kyfXA9/Kci8A8E12uUq7SsYMFhvaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NT75Hdd9IHUZdfEnRpuM1pO9S1tf0Duy8oTvCeAyKAo=;
 b=XxbMT48hyODZmR4PFCMRZ71jPdRk0mwpVtpX0Iic2kN96djegc7B1CJ/HKfUuGXatZPmzUpq+GPMm/wuheaXEJ46tZd7PnNXxG54w3NMibVEXWOt3+Bvoee1Ffpfv5FPI2JgFiWYSx0F107NfHYMT3pLblm3t03nKQitKbEr4Qc=
Received: from TYSPR03MB8836.apcprd03.prod.outlook.com (2603:1096:405:95::8)
 by PSAPR03MB5751.apcprd03.prod.outlook.com (2603:1096:301:84::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 02:17:25 +0000
Received: from TYSPR03MB8836.apcprd03.prod.outlook.com
 ([fe80::7b:b3b1:29a3:b67]) by TYSPR03MB8836.apcprd03.prod.outlook.com
 ([fe80::7b:b3b1:29a3:b67%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 02:17:25 +0000
From: =?utf-8?B?R2F2aW4gTGl1ICjlionlk7Llu7cp?= <Gavin.Liu@mediatek.com>
To: "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>
CC: "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "op-tee@lists.trustedfirmware.org"
	<op-tee@lists.trustedfirmware.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jerome.forissier@linaro.org"
	<jerome.forissier@linaro.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] optee: support wq_sleep_timeout
Thread-Topic: [PATCH] optee: support wq_sleep_timeout
Thread-Index: AQHaT09C8Fo0yXViLEeu2D+3mVonELDqoE8AgAVzpwA=
Date: Mon, 29 Jan 2024 02:17:25 +0000
Message-ID: <6541d48d39e719b801a947e0dbee8386abbbd9f6.camel@mediatek.com>
References: <20240125052744.18866-1-gavin.liu@mediatek.com>
	 <CAHUa44EcGnOno8TQ-wPE8Q_ghG8t5J5uRLqnYduAnQXx6oRATg@mail.gmail.com>
In-Reply-To: <CAHUa44EcGnOno8TQ-wPE8Q_ghG8t5J5uRLqnYduAnQXx6oRATg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYSPR03MB8836:EE_|PSAPR03MB5751:EE_
x-ms-office365-filtering-correlation-id: abbf6c5f-0275-4b25-1b7d-08dc20706f1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vl07aDEzQplFCFqJUEDpRIbotXZuBjZo4+uS4xiCJonjPIfCGEHBbKO20v1b0VwsLeINM/bXgRLcWkQXhdsTV/B5FLQtEyyUysEZhBCoAJEQa6XZhdh2hMzBdQ9vyxDI2/jamQNQQig0BNS7GybpynrJPSVmkRI5KupSfOKNakVIc0fZTTxCL7Ykomm3zlPiuIOJ8Eb6QSeyJ1xUzKzTT098nFGcd5mpDSjEUmwgrrcJD6CGLeiA3EmXNHO19aqxuVn3N0Q2Pdqn5wxUM2BLRSMUX1DHFDCE06mp91pNNBRW2C9JvxNOe0dlYHLzEwjtvjef1ASB5w5IBhczha3hykXspQvk4MX0NC8qJcv0j9rtcVkoW1cgVwGeAXopG5w4Q58JDbjgdMtqAs9/hAc4Gl7hhg6s+RTNqaxJa2TsFVDIkLaU1qVVCckyYvJMIeRio2OkQAreqvThS+ub7GYaauP6G3+7gratAU5Hgr0cZ+67z9ttKEdBb64vRjeByLVRSzuO0qHHtnG9bBXWawA9cqnFMkDaUb0INhr00wvtzebJsWqx4BsEERGcXdYnYzcvafzRACM50CkPclwEX0ZDY/xzVRLALu3yPbvIP6iAGcHr1TLCJwCqnBtSCXYcUuhrn51O7zKs8r95ZvQL6Vq94/uBGMTrSsHY+/f0QiYJzrA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR03MB8836.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(366004)(346002)(376002)(136003)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(53546011)(6506007)(6512007)(2616005)(38100700002)(122000001)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(71200400001)(6486002)(478600001)(316002)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(36756003)(85182001)(86362001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmdPODRNTysrc2w3bTViNGFqdWdhVlBPZTVrMEJJN3NQWkFYN01hSU9JVDdu?=
 =?utf-8?B?WGRITTl0NFRtT2hESytQTklJZHNMM3BMVUdsMHhuUkx1QlVNQ2UxTTA5Y0JL?=
 =?utf-8?B?Z28wYUkxeUE3VTFUUlJyVUJVVlE4U3VTaUpLeldvNHpMRnNzMUVDKysxekgw?=
 =?utf-8?B?Zm0wd1NpNHBWekp3SnBEWW9zRk9yZFVXNXk1c25VcklIMEdGNkVRNFhVclBP?=
 =?utf-8?B?UWxwZkFHbGNJbTE2ZldPelRJa09scXNRanhXTVNEck9wWklSRGFsa0RlRzcr?=
 =?utf-8?B?dnljdm1BR2ZSdExBSjc2VGJsN3VGVE9uY2xwaVg3MWdFbVdJUW1ta09YVEk1?=
 =?utf-8?B?NTZmWENoc2pBczl0K1NEYkh0dlhKV1hCcnByU2FQYi9Icm1aWHlaOHErTnVG?=
 =?utf-8?B?M0xMb040aUxuOEZGdnR5a1gwdnRnTndEa1ZRUng0ZndsSnpVSFBvaUVHUnBm?=
 =?utf-8?B?S2RpRU0xTG0zVFdqMHJVTGpwNURhV3g2TGluTkRiTks0TDM5WisvQk02Y3Jq?=
 =?utf-8?B?QTRjZVpLVjFqRFhERVpJM0JNY0w2Qld0eWNWRU1ka1pyNytjRFBBdTI4K3k4?=
 =?utf-8?B?UGpqZVNPYWhNUDdCNU9uVU1VUU1OMkg4QUVJbGQzMEp6TkYxeTFKNzFlRk9x?=
 =?utf-8?B?ZWRzSXFVV2pMQXppdTlsNnNTSjdEdUY1QlR0enoyZjhXZ1VjV24xUmtyczk5?=
 =?utf-8?B?d1VxOVEyY1UxVXBaVk5yYnJCbHZvaWNoSlBLUWtFZEE1eTRhVVpLdjNhRm13?=
 =?utf-8?B?V2NNL0ZJYlBqeVhheVRNVzJnU052K1VPNmtmRDJmb1ZzWGQzRzlhdVg0cmFh?=
 =?utf-8?B?NUNpOFQ4K0NmWXQxVGxFaHRNVGJqYVJUZm1TL0hqamFuMzNuV29MTjU2Qjdq?=
 =?utf-8?B?OVV2bGNLRHQ0citWeE1RZVBkZGxqQXFEM0hyR3lFU1YvbkNUUjk1Vk9Jd1k2?=
 =?utf-8?B?VUQwREZ0OG5uRHgyTmRQdWZCUUd2QXNCSS9oZ1VCby8rUUhnU2JHVWJCTnVG?=
 =?utf-8?B?YXl6Q0Z3bXFySTk4NjkrRFQyL0VsY2RDS0YzTVE0cEFQNXcyNFkySDltK25D?=
 =?utf-8?B?bFNudEx1R1JBSE5YMHVpM2ZNSDNCVkx1bUpkMFhvUlYycE9uVWFCMHVONW9Y?=
 =?utf-8?B?RlpjV3ZDU1ZuazA4OUIzV0o3RlFvQ2cyNTZnQWpxU3hvTW82ZGJVeGNDUG96?=
 =?utf-8?B?SGdOam81aFNDQkhCR0lrVzBYS1VEV2Q1bjVUWlhlT1hCWXF0TnRvZTc3bnpn?=
 =?utf-8?B?K3hyUkNOdEZ6L2JQem82b2JrNDY2ZGZSMjJFRk1OTnIrYmJVRVA5b2Z3YU1G?=
 =?utf-8?B?UnhvY1c0RGFsbmRpdWNrcUdlblllOUJCM0VSV3RHcyt5UktKNUdicUtzalc3?=
 =?utf-8?B?TmxOckFWVklmOXNWZjNuQnpOVHhqV25UaFB2cmsxNHphNHlJUHJyS2JYQlk3?=
 =?utf-8?B?dHZmK2wwWWNacEgzVFB6Qm1hNXBXZUh3QjZmQlJoaGplaEpJUEp0OTE2WjZK?=
 =?utf-8?B?NUwvZGEwN2VKdzF3YURGVTJYd3NFWDBxK3BtUE9WaS9VOER0SG5DM3BqRmxP?=
 =?utf-8?B?MGlrQjNHRVJnWXl5M2xNZXNEbEN6blZpaWJPdWpGRGNQcG5TWVBVNWkxeFRI?=
 =?utf-8?B?ZHROT0RtVHNwM3pQNnViMWFKdDdnZFYvVDdnWXlIREFuQXBOanoxaUw0TnhJ?=
 =?utf-8?B?czV2TWIzTkNYZjFFd3UrSmRhWjhmRFBBTXp0eGlIM20wYU43OEdDQnNRY1Nt?=
 =?utf-8?B?d25yTm5mMXRLUjdudFdjQUNVVUx1Z3NUNk5ldXlRRTMzaHNYVmxTNk1oaHdw?=
 =?utf-8?B?RmJHOTBCL3hYNnFld1piNmlnWE5ueHR4L2Z6RU4wYXVUL1NBRTZKa2pIQldB?=
 =?utf-8?B?Qmg3NC8xVE1qNHVhRk9jNDZWNloweldCSGMxVE5xWDJtRmhIL0ZtVWpJa2xY?=
 =?utf-8?B?NXJlbjVZL3BDNnVWdjNKUUUrbXVYbTNrREllb0FacE9LTjdEKy91RTlXK1lM?=
 =?utf-8?B?OVNabk5FaW02MXNucnh3YkRWa2NKMmRIV3p3akF2aUdKTENGYzdkSFdhRFJt?=
 =?utf-8?B?MWViem5Vc2JPUWErd1VTOWJNcXdwczA0WUljMlNpNlFyRHBPRlpBYytrZnYx?=
 =?utf-8?B?bTUxNTVLT1Z3bUxuTVpTbWcrRVJmdTNVbVFZRHQxRW1pT1orVFdaWWl5Wit1?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F16DB804249FD147845B1FFEECDFC30F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYSPR03MB8836.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbf6c5f-0275-4b25-1b7d-08dc20706f1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 02:17:25.1766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0EwQa5eln/Ib6ZUZLMFhcRMM8XkevfDMq+rPOZeL1sLGVL6UUfP42ebwt5mSeiXno0TooCNGVpWCrk/HQUqIDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5751
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--26.871300-8.000000
X-TMASE-MatchedRID: LVkZzMT5mErUL3YCMmnG4uYAh37ZsBDCjLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2zMXjNn4Xwe5+Mk6ACsw4JlwpnAAvAwaz9Ng
	smL8Bq9iULKbroIyd53bewgMAUhyijpWp2ocPYLHAJnGRMfFxyUyQ5fRSh265CqIJhrrDy2+7Uo
	HJ+9TgG9qmCjvjUIHry3f7HhFK1plWj3HFS14pK5A6S0SjvcYUXxT5cg8K/tcvM0Gdq0fzqcCoy
	7ZTTqQm4vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0UbslCGssfkpInQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--26.871300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0EEF4CC623AFBBBF328DA7B2E9A218D5B036CAF28E498D1595E64883ECDA49F92000:8

SGkgSmVucywNCg0KVGhhbmtzIHZlcnkgbXVjaCBmb3IgdGhlIHJldmlld2luZy4NCg0KT24gVGh1
LCAyMDI0LTAxLTI1IGF0IDE2OjAyICswMTAwLCBKZW5zIFdpa2xhbmRlciB3cm90ZToNCj4gIAkg
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+ICBPbiBUaHUsIEphbiAyNSwgMjAyNCBhdCA2OjI44oCvQU0gZ2F2aW4ubGl1IDxn
YXZpbi5saXVAbWVkaWF0ZWsuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEdhdmluIExp
dSA8Z2F2aW4ubGl1QG1lZGlhdGVrLmNvbT4NCj4gPg0KPiA+IEFkZCB3cV9zbGVlcF90aW1lb3V0
IHRvIHN1cHBvcnQgc2VsZiB3YWtpbmcgd2hlbiB0aW1lb3V0IGZvciBzZWN1cmUNCj4gPiBkcml2
ZXIgdXNhZ2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHYXZpbiBMaXUgPGdhdmluLmxpdUBt
ZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdGVlL29wdGVlL25vdGlmLmMgICAg
ICAgICB8ICA5ICsrKysrKystLQ0KPiA+ICBkcml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9wcml2YXRl
LmggfCAgMiArLQ0KPiA+ICBkcml2ZXJzL3RlZS9vcHRlZS9ycGMuYyAgICAgICAgICAgfCAxMCAr
KysrKysrKy0tDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCj4gDQo+IEknZCBsaWtlIHRvIHNlZSB0aGUgY29ycmVzcG9uZGluZyBzZWN1cmUg
d29ybGQgY2hhbmdlcyB0YWtpbmcNCj4gYWR2YW50YWdlIG9mIHRoaXMgQUJJIGNoYW5nZSBiZWZv
cmUgd2UgdGFrZSB0aGlzIGFueSBmdXJ0aGVyLg0KPiANCj4gVGhhbmtzLA0KPiBKZW5zDQo+IA0K
IEkganVzdCBzZW50IGEgUFIgZm9yIHRoZSBzZWN1cmUgd29ybGQgY2hhbmdlLg0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGVlL29wdGVlL25vdGlmLmMgYi9kcml2ZXJzL3RlZS9vcHRl
ZS9ub3RpZi5jDQo+ID4gaW5kZXggMDUyMTI4NDJiMGE1Li5kNWU1YzA2NDU2MDkgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy90ZWUvb3B0ZWUvbm90aWYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdGVl
L29wdGVlL25vdGlmLmMNCj4gPiBAQCAtMjksNyArMjksNyBAQCBzdGF0aWMgYm9vbCBoYXZlX2tl
eShzdHJ1Y3Qgb3B0ZWUgKm9wdGVlLCB1X2ludA0KPiBrZXkpDQo+ID4gICAgICAgICByZXR1cm4g
ZmFsc2U7DQo+ID4gIH0NCj4gPg0KPiA+IC1pbnQgb3B0ZWVfbm90aWZfd2FpdChzdHJ1Y3Qgb3B0
ZWUgKm9wdGVlLCB1X2ludCBrZXkpDQo+ID4gK2ludCBvcHRlZV9ub3RpZl93YWl0KHN0cnVjdCBv
cHRlZSAqb3B0ZWUsIHVfaW50IGtleSwgdTMyIHRpbWVvdXQpDQo+ID4gIHsNCj4gPiAgICAgICAg
IHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gICAgICAgICBzdHJ1Y3Qgbm90aWZfZW50cnkgKmVu
dHJ5Ow0KPiA+IEBAIC03MCw3ICs3MCwxMiBAQCBpbnQgb3B0ZWVfbm90aWZfd2FpdChzdHJ1Y3Qg
b3B0ZWUgKm9wdGVlLCB1X2ludA0KPiBrZXkpDQo+ID4gICAgICAgICAgKiBVbmxvY2sgdGVtcG9y
YXJpbHkgYW5kIHdhaXQgZm9yIGNvbXBsZXRpb24uDQo+ID4gICAgICAgICAgKi8NCj4gPiAgICAg
ICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm9wdGVlLT5ub3RpZi5sb2NrLCBmbGFncyk7DQo+
ID4gLSAgICAgICB3YWl0X2Zvcl9jb21wbGV0aW9uKCZlbnRyeS0+Yyk7DQo+ID4gKyAgICAgICBp
ZiAodGltZW91dCAhPSAwKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGlmICghd2FpdF9mb3JfY29t
cGxldGlvbl90aW1lb3V0KCZlbnRyeS0+YywNCj4gdGltZW91dCkpDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcmMgPSAtRVRJTUVET1VUOw0KPiA+ICsgICAgICAgfSBlbHNlIHsNCj4gPiAr
ICAgICAgICAgICAgICAgd2FpdF9mb3JfY29tcGxldGlvbigmZW50cnktPmMpOw0KPiA+ICsgICAg
ICAgfQ0KPiA+ICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJm9wdGVlLT5ub3RpZi5sb2NrLCBm
bGFncyk7DQo+ID4NCj4gPiAgICAgICAgIGxpc3RfZGVsKCZlbnRyeS0+bGluayk7DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdGVlL29wdGVlL29wdGVlX3ByaXZhdGUuaA0KPiBiL2RyaXZlcnMv
dGVlL29wdGVlL29wdGVlX3ByaXZhdGUuaA0KPiA+IGluZGV4IDdhNTI0M2M3OGI1NS4uZGE5OTBj
NDAxNmVjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdGVlL29wdGVlL29wdGVlX3ByaXZhdGUu
aA0KPiA+ICsrKyBiL2RyaXZlcnMvdGVlL29wdGVlL29wdGVlX3ByaXZhdGUuaA0KPiA+IEBAIC0y
NTIsNyArMjUyLDcgQEAgc3RydWN0IG9wdGVlX2NhbGxfY3R4IHsNCj4gPg0KPiA+ICBpbnQgb3B0
ZWVfbm90aWZfaW5pdChzdHJ1Y3Qgb3B0ZWUgKm9wdGVlLCB1X2ludCBtYXhfa2V5KTsNCj4gPiAg
dm9pZCBvcHRlZV9ub3RpZl91bmluaXQoc3RydWN0IG9wdGVlICpvcHRlZSk7DQo+ID4gLWludCBv
cHRlZV9ub3RpZl93YWl0KHN0cnVjdCBvcHRlZSAqb3B0ZWUsIHVfaW50IGtleSk7DQo+ID4gK2lu
dCBvcHRlZV9ub3RpZl93YWl0KHN0cnVjdCBvcHRlZSAqb3B0ZWUsIHVfaW50IGtleSwgdTMyIHRp
bWVvdXQpOw0KPiA+ICBpbnQgb3B0ZWVfbm90aWZfc2VuZChzdHJ1Y3Qgb3B0ZWUgKm9wdGVlLCB1
X2ludCBrZXkpOw0KPiA+DQo+ID4gIHUzMiBvcHRlZV9zdXBwX3RocmRfcmVxKHN0cnVjdCB0ZWVf
Y29udGV4dCAqY3R4LCB1MzIgZnVuYywgc2l6ZV90DQo+IG51bV9wYXJhbXMsDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdGVlL29wdGVlL3JwYy5jIGIvZHJpdmVycy90ZWUvb3B0ZWUvcnBjLmMN
Cj4gPiBpbmRleCBlNjliYzYzODA2ODMuLjE0ZTYyNDZhYWYwNSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL3RlZS9vcHRlZS9ycGMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdGVlL29wdGVlL3JwYy5j
DQo+ID4gQEAgLTEzMCw2ICsxMzAsOCBAQCBzdGF0aWMgdm9pZA0KPiBoYW5kbGVfcnBjX2Z1bmNf
Y21kX2kyY190cmFuc2ZlcihzdHJ1Y3QgdGVlX2NvbnRleHQgKmN0eCwNCj4gPiAgc3RhdGljIHZv
aWQgaGFuZGxlX3JwY19mdW5jX2NtZF93cShzdHJ1Y3Qgb3B0ZWUgKm9wdGVlLA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG9wdGVlX21zZ19hcmcgKmFyZykN
Cj4gPiAgew0KPiA+ICsgICAgICAgaW50IHJjID0gMDsNCj4gPiArDQo+ID4gICAgICAgICBpZiAo
YXJnLT5udW1fcGFyYW1zICE9IDEpDQo+ID4gICAgICAgICAgICAgICAgIGdvdG8gYmFkOw0KPiA+
DQo+ID4gQEAgLTEzOSw3ICsxNDEsOCBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfcnBjX2Z1bmNfY21k
X3dxKHN0cnVjdCBvcHRlZQ0KPiAqb3B0ZWUsDQo+ID4NCj4gPiAgICAgICAgIHN3aXRjaCAoYXJn
LT5wYXJhbXNbMF0udS52YWx1ZS5hKSB7DQo+ID4gICAgICAgICBjYXNlIE9QVEVFX1JQQ19OT1RJ
RklDQVRJT05fV0FJVDoNCj4gPiAtICAgICAgICAgICAgICAgaWYgKG9wdGVlX25vdGlmX3dhaXQo
b3B0ZWUsIGFyZy0NCj4gPnBhcmFtc1swXS51LnZhbHVlLmIpKQ0KPiA+ICsgICAgICAgICAgICAg
ICByYyA9IG9wdGVlX25vdGlmX3dhaXQob3B0ZWUsIGFyZy0NCj4gPnBhcmFtc1swXS51LnZhbHVl
LmIsIGFyZy0+cGFyYW1zWzBdLnUudmFsdWUuYyk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChy
YykNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGJhZDsNCj4gPiAgICAgICAgICAg
ICAgICAgYnJlYWs7DQo+ID4gICAgICAgICBjYXNlIE9QVEVFX1JQQ19OT1RJRklDQVRJT05fU0VO
RDoNCj4gPiBAQCAtMTUzLDcgKzE1NiwxMCBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfcnBjX2Z1bmNf
Y21kX3dxKHN0cnVjdA0KPiBvcHRlZSAqb3B0ZWUsDQo+ID4gICAgICAgICBhcmctPnJldCA9IFRF
RUNfU1VDQ0VTUzsNCj4gPiAgICAgICAgIHJldHVybjsNCj4gPiAgYmFkOg0KPiA+IC0gICAgICAg
YXJnLT5yZXQgPSBURUVDX0VSUk9SX0JBRF9QQVJBTUVURVJTOw0KPiA+ICsgICAgICAgaWYgKHJj
ID09IC1FVElNRURPVVQpDQo+ID4gKyAgICAgICAgICAgICAgIGFyZy0+cmV0ID0gVEVFQ19FUlJP
Ul9CVVNZOw0KPiA+ICsgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICBhcmctPnJldCA9
IFRFRUNfRVJST1JfQkFEX1BBUkFNRVRFUlM7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgdm9p
ZCBoYW5kbGVfcnBjX2Z1bmNfY21kX3dhaXQoc3RydWN0IG9wdGVlX21zZ19hcmcgKmFyZykNCj4g
PiAtLQ0KPiA+IDIuMTguMA0KPiA+DQo=

