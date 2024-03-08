Return-Path: <linux-kernel+bounces-96936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2A787635D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84463282AEE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F65255E78;
	Fri,  8 Mar 2024 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="A4FkvWSt";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ehsbH7QK"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA22219FC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897486; cv=fail; b=i5PZRf2NGcK1MMzlhD1hV4UBrZ2SEwxrR9r+JrJBoSaPxhXsEY4r40grStXqyYDLsY0VpODECMFOROdFv5PPPckaehLbiNpzJzulxv8A4rVtZrdRVSweityAE4HdZLANmrUP7Hc6RUZJGFdptwSHO27OnLYtsOQFcgzKAvWRCQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897486; c=relaxed/simple;
	bh=vqFj2VRyjMKeT104gjJGFaFncv5CUmvRc+65GL0TWOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jHEddoxykKMWQXhbUA2mGKTuhCA3UQOz3ThET+dJsEUvzAPIQBNJS6CjUn8xm7qb6aNkhb94iTQXk3f8ZxUO/5KSQ11ZSA87g0QzdgBm19dxgvb86LKxJL//0p82byj5GUrpJGFnJydIMRaPeLhYWZbzAuMNWj7g3LGZirETOSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=A4FkvWSt; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ehsbH7QK; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5d8e5da4dd3f11ee935d6952f98a51a9-20240308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vqFj2VRyjMKeT104gjJGFaFncv5CUmvRc+65GL0TWOE=;
	b=A4FkvWStFbBK15+7sJI0UVZQ21fvlIltyza8Kt6FZ4u8+SZStfI2E5iHIHCunst0pMg8uN7OSErNfFDGEiR4BQR17lLT3xmGvMwmbe5Wmzx9VnqVX2MIt/VTtSD3zC41v35awGCM7UxiRYPXNhXaemOMY3zJGGXTgO3V7SJn6Eg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:ecda77cc-9df9-41b5-aadd-8af74139caf8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:6fbfc684-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5d8e5da4dd3f11ee935d6952f98a51a9-20240308
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <flash.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2113510875; Fri, 08 Mar 2024 19:31:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Mar 2024 19:31:10 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Mar 2024 19:31:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/WGEAzUv+2lcLkrEPlDSD9bqD98IR+yL6orv2kmo17PvBpZ7CnWePeUUaHcrMhIK0y8tHk5CNPDzKEvXb/2HXJLityn6aml6PAYha/E6IbuKItjBd5joHGunDYrg4g/dmMyfd6hB7ayi98Fd5Mvz6rgxrd9pLnvnjUpBnEAYHVLmr6xx9ItW8c7YA3/tA0JlMyHIAwWes9021jw6Ao/DG67gTMqYiDqMzalAMlo3Hq2d+yvavo7gyczH3lyrblVJJFB2AXCH6e3O35j4k5APEP6IiYwWfFj4aaA82/IKoQf6BylAfnTZK5WobZAz+ZCi3A8D+Fgb30zVB8c2p1pXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqFj2VRyjMKeT104gjJGFaFncv5CUmvRc+65GL0TWOE=;
 b=iqPt1BWKJxOGESiBdLYQWAeniqapu9gHbDXXapS9pBCIoM+9AnnIeaRLLEkN52HQELmTYiC1EDOmZ1AvWB6NxDigbs5wAENSjcy1rQcceR2RsQG6JG8nTVXYTOBKp+3iI0QvXzw7FIYGUJkTBIJJsZNHM8ahINPGquW2BXcGkHgFTosGz53XmbUx0Ro8KD1bk/8VbuxOfPo4Pk+Vvsmdyv1JXOe7CjmcTA+K5OCQSWzl9uo5JvbWqyQziP2lpHzss876b1jsyGJyfmuha5jOBHmZN4p6n2Jm90nLxJi8SRAFDlL1plabvkQys7DanvvJNMPp0QWsudIb4+Y+qgxdug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqFj2VRyjMKeT104gjJGFaFncv5CUmvRc+65GL0TWOE=;
 b=ehsbH7QKpaxtysoxJHEjTeMf/j8FhH6v16TgIQOVy0Q36cbqoJ5h04BrfKLPWKzRpT052rSfK/9T2cschw9A1INd+VH8TZ9/6/LjEp1vfQBHxgb10JJCWQP2jEGafoXdgNdHbsmQIwTrbuuLk5xWNxZxB/12UjYR3JNvGEhsmZA=
Received: from SG2PR03MB7279.apcprd03.prod.outlook.com (2603:1096:4:1d4::14)
 by SEYPR03MB9160.apcprd03.prod.outlook.com (2603:1096:101:269::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 11:31:08 +0000
Received: from SG2PR03MB7279.apcprd03.prod.outlook.com
 ([fe80::9a30:9de4:c31d:2bae]) by SG2PR03MB7279.apcprd03.prod.outlook.com
 ([fe80::9a30:9de4:c31d:2bae%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 11:31:07 +0000
From: =?utf-8?B?Rmxhc2ggTGl1ICjlionngrPlgrMp?= <Flash.Liu@mediatek.com>
To: "cristian.marussi@arm.com" <cristian.marussi@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	=?utf-8?B?Q3lsZW4gWWFvICjlp5rnq4vkuIkp?= <cylen.yao@mediatek.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] firmware: arm_scmi: Avoid to call mbox_client_txdone
 on txdone_irq mode
Thread-Topic: [PATCH v2] firmware: arm_scmi: Avoid to call mbox_client_txdone
 on txdone_irq mode
Thread-Index: AQHaVPVIVsXO+7KbOka+qKoEb18oerD24yEAgAAb7gCAM3HsgIAAPC6AgABp4ICAAVWuAIAAQLAAgAFA5IA=
Date: Fri, 8 Mar 2024 11:31:07 +0000
Message-ID: <311c503006ae9f391676a826b66a316681f10ef4.camel@mediatek.com>
References: <20240201095754.25374-1-flash.liu@mediatek.com>
	 <ZbzKckIhn8HQv5pW@pluto>
	 <053cb4a2edfe576412942daed2f7055b2ba9e207.camel@mediatek.com>
	 <56e1b2f5adbca437a14b738e1c58a054f6302fcd.camel@mediatek.com>
	 <Zeg8F6VVaZtpmH8n@pluto> <ZeiU5_k7s-31A93h@pluto>
	 <c6a24e4c9b97b8a47a822fb4fcbc4b955ac5fbc5.camel@mediatek.com>
	 <ZenpykCOYjsH_sdd@pluto>
In-Reply-To: <ZenpykCOYjsH_sdd@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB7279:EE_|SEYPR03MB9160:EE_
x-ms-office365-filtering-correlation-id: 7440dd65-e086-4f0c-54c0-08dc3f633f42
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j/xTw4HdapdGewOxaPNdJlUOkPQhUeCGSxt6YMISkgIU+yNkWzTetQexXbY8lVJ+OfmmfW95U+UmU0qNUQV8W5DfL9XCC+IBVRJh1VKjyWuYktlYe7rqYW2dGp48/sHsaIFkjpSN/85AZ//cG1e2YWBhEKvCI0vnqlJM/60SXuk6RjmA5SdIfksQ1DAIX6OR0E5CzXMipicoztfQ0UJbjCco/nTxqeC/F1K6RCl0MoIE53xn5to2mjju9K+s/3Dh7mAN/KuRJPnOuMB/3xH06SxS6F79NrrlWbDt7rQHdpSXdESkYQQ9GBOEVV9APKz7aTvw7+Axll1XmdLNL+S63IE3a3vHq/n+UxIQ+uOwClq75AybKNvVy4Ik7ADxcsqiWqGOinqYg/WEG7Nxio7fOUuJxBR7baetEjNLAY48Mn6oycIFxk79zYR2HowvUWuCy7MII75SzAm+ZzMQ5mLQamHlKpzWnDQ2SfFURvMmLIdW64bMqThduTECt3i61GMUMvqtZu60N4ujkXhXjNDUh9HeucvACIz/NhmrzMVHu8YxFzBh8XC+9f53BQWyy2n1dmvzh8pc3XFaGcRdA12uRC883kU/IpUKxqYEJbWK/gWBlOnufxwNpW5BN0vSSHgaFM3zXu6581R4f+TEuwp6BFAlIQR9SggHwq3T93UbIH1/FeLrShPCGv3DtJPTM+LfCvitp4rWVsY4wvriNyZz8/pIgCY0Vq5PPVwbJXj85oo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB7279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTJWWmFUaGU4MDU4RWNNcTR1WVhwMnhiL1c2TjhBTUc3VVdsTVN6ZUx0STVC?=
 =?utf-8?B?Mmhnczg0M1VyRTRZVldOVW9lc2VXbVlYaWhJTlpzdGpnSzVWMFJLTXdERk95?=
 =?utf-8?B?LzJaZFZwU1lMdWF6ei9ldm5OVDNPdzdHMmpEUC9xZFV5Q1NhVFNYa05rcEhG?=
 =?utf-8?B?TTVOaGlKa2ZkQWJtUWFUUlR0Z1QweEhPaVpjOTZhK1g0OU1wY0U4Mk80T3NN?=
 =?utf-8?B?T29ManFmb3NrbmwyWFJPTHU5OU9GMmtaamQ2OXB1RkQ0Q1NmaUNyazJGRnRj?=
 =?utf-8?B?NEJkMlovbEFwZjgyNk8wNTZRRk56bEdmYWdRaEFiV0xWRWVoWFNVaWIrV1RH?=
 =?utf-8?B?cnFXVEtpeFpLRy9pbmV1SGdjOXE3SXRYektGM2xIWUhHQUxYUldGeWRVeDBw?=
 =?utf-8?B?VFlBU1BKekNPTjZPTTNSV0NDdmxHelJnTFFFcEVkSWhMVWFFL0VBcFNsTmhL?=
 =?utf-8?B?dlg5NmtkY2xYMk55VWxiR29QdytSWVErcHhGMGVYSkw1MkRmMG5JTjhGb2Zz?=
 =?utf-8?B?WUVjTDJIUFYrekphT1dOajVnaGg2ZVVEMlZKVlBMMjV5MFl1VUw5dkluaVFq?=
 =?utf-8?B?emlzb05mUkZnR0Izelg3RjUzREpFK09UTmo0TmhIUnFQWi9QZWI2b1lZWm9s?=
 =?utf-8?B?dXpKbE9ZKzc2alRkQ1FRTytVelIyMDdxYmlmTFF3NUdjOXN3RTd1UURiMXV3?=
 =?utf-8?B?Tlg3V1ZGRFBKbVpUQ0NSUkFrUzc5UmhhRHpCbGdzVUVESU5DYWNZOG1wbnZu?=
 =?utf-8?B?TzlFZTlvVWxVSjYvYUY3YWtPYjFpU2xnK2dJOEZjeWRWbzRUaFA5Y0FMSSsv?=
 =?utf-8?B?NFB1RlpXN1VHOWJzNjRtVTZCYVc3TXJ5N1lYNjl1eXVrYVBaMnZ4Zlc2dEFG?=
 =?utf-8?B?L3ZiRVgxZllmSmcybkEwZHJQLzNmK1l5T1BMSFVyZWpxQVJQcDJ0WEszS0RI?=
 =?utf-8?B?RzJLRm9aMTFrQ0ExckMwRnZzNnM0aTRYdEtob1ZjSEVDVWlRNWRxbjNRcHYx?=
 =?utf-8?B?WkE1SjNKMisxZ2tyMVU3eGlETzhrU05lWHVUUFQzcEYzMGZreTVGMVZocGV4?=
 =?utf-8?B?OXhVYnF2OUZXREZTUXdYYWlsQ0xpYzFJVktYQUNiQ0pJd3hJR3l5dXhFbVo1?=
 =?utf-8?B?dERlamxyRzM4L1M1L1dyYmJiVi9ibGdmcUhRVld4QUNUNk5TMDVaQkxTdHdG?=
 =?utf-8?B?NDVINTg3dkt4bTZES3hHYW1UUEpxWnI0clV5ODRnZlNQSVBpQXlNdWdWZHdh?=
 =?utf-8?B?bE9OMU5Fa0V5MTJRYS9kZ2w4RFlpSXVOQ3JhQWMwVVVGZXJ0d1UxbjFDS3FN?=
 =?utf-8?B?azdFeWRWenlDZ2hmYmFHQVJaK0E0UWRPUS9ETTVFNXJLZ0dTOXNNTFlGbzhW?=
 =?utf-8?B?YUdYK1AyWTVYd011T0pXSTVoYmthKzdsTWl5ckFSbllnQjBvTzM1c1hwRjlB?=
 =?utf-8?B?YndlSzRSNG5Gak1BK09SM2JjU09Ra1F0ajRvSmlLcmdqSFAyVFh4ZFdkdUR4?=
 =?utf-8?B?YUdhd2RLV3JOejVNYmpSMlc5ZEtnQUtwQ1dmNGdsQlhYTlpTQ3Z3azJ3ZVdI?=
 =?utf-8?B?UDZWVjJXK2p3YnFkTmpwZjl0WUVMUlVQLysvNEorUHNKUGRHOFY5bDBKM09L?=
 =?utf-8?B?RTk2eWRXazNtNnFsUVVJWDZYRDAvNmQzZEpHNi9tL0hGWHhiQ2g5Z0xZU1ZN?=
 =?utf-8?B?UEJCd2F1MzJGenE4WUtERkpSUUJveU9iYUY4R2xOcHZRTnV6eVdsdEhmUG9y?=
 =?utf-8?B?OWhLd3hFU1FoNjZCbER4TWVtVXdmaGxGSGxkTWVacGVZelJBV2N4azhNT3JL?=
 =?utf-8?B?N2Q3MElhUUs4ZERtTjMyNFNZSFhNTjViZDNzT0IvaGU3SjJrYWdXWjdsSEhz?=
 =?utf-8?B?c1FSTkpwNGwvcmkyNitac0ZNN3lPcU9jbCtlYVV6L1FMOTBhWXdKcEU4a281?=
 =?utf-8?B?US83bVZFMFd6V29JVGFSL1Z2VWFBVkdUVVhDdFlaa0N2L3FDR3BKdWhRZEFk?=
 =?utf-8?B?Q3RDdi95MnNXakZXSURTSmlyWk9VMU1wN2t0UEduL2F6eDcvWE9NcWlUejhG?=
 =?utf-8?B?RHhMMUR4VHRaaU5MWE1Udzl0dkJnRGFDenMrNUFsR1loSm5rVzU2K1IxMGw3?=
 =?utf-8?B?eU1kSWc4K01nOGcrVUVaOXRsVWlJVlhUcjVUTU1lSWdjOENTVEdISzlFdlYv?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D834A1E293B2344B7440E5C8E9D4081@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB7279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7440dd65-e086-4f0c-54c0-08dc3f633f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 11:31:07.4757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LoiPSjQFxFRqj1urAfd6GjEk800Y4rJqTfZWJ32kWpFIAFATCTIY/sWFPeENfNpIkv3toBs1JL4D+zFF9obA2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB9160
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.124300-8.000000
X-TMASE-MatchedRID: lywBov0pR43UL3YCMmnG4lIwtTtvyT1CYM9jZ5ImeacM74Nf6tTB9ig1
	DFhgvAGAnlZVZPpwOQYUAF4uBmvRkUL9tcyTZdAsgxsfzkNRlfK4RQHJd9TWWxc1VYCQdRfIPhh
	qRWZ33iTdB/CxWTRRu+rAZ8KTspSzMUDkNN5sTYQjRBz3OQQU6Syae5a31JCII+Faks4nxbtVEe
	CSVh+O6D1cZVEz9xqDuwJbEW/0O1kKGJT5z//E/xZbWJX9wv4jQwymtxuJ6y0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.124300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0A110F25CF6CB43FB6EE400769A3D4AE123EF510BF6F684F10D4ACF02A0860DF2000:8

SGkgQ3Jpc3RpYW4sIA0KDQpHb3QgaXQuIEl0IG1heSBjb250YWluIGRpZmZlcmVuY2UgYXQgTUJP
WCBkZXNpZ24sIHNob3VsZCBhY2NvbXBsaXNoIHRoZQ0KdHJhbnNhY3Rpb24gb24gU0NNSSBjbGll
bnQuIFBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaC4NCg0KVGhhbmtzLA0KUGluLUNodWFuDQo=

