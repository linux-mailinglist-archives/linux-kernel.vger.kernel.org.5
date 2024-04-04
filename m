Return-Path: <linux-kernel+bounces-130866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41C8897E37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D54EBB22426
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123BC20330;
	Thu,  4 Apr 2024 04:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FdvikDoO";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hgp/lNRZ"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3088184;
	Thu,  4 Apr 2024 04:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712205078; cv=fail; b=aP7eMGl3qTNZOqRPTskdtAs+ikISeX5+ntBG/EOF+RXJIMP0Nh7Z9SxVKAPmJRs8KnPS2A4eyWjfDIYu71APH47c5XNIa/Mi2oRC0zdzyUBZahcpd1FlGAWJdr4hVDIn5qvoA1rxkgqyhUJyRLewBaTOwRwHcfNEUw79ymrjopc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712205078; c=relaxed/simple;
	bh=KiklBP1pJ9fjX+SRKkobzrZNNOKIG9+hy349LL0e7EE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PdkJYaKLE7ba/jBtyycMQVqkq3vHP41yaI6fTEsjxkOJLYnrTaNE3cup2S3XH/c7tE5EQJIdZbs9oZHbsNyWWp12VyFddQjNMea5n7wdm51b+FJ+L8wTo50UDeHapEGbWXYKkLAqFqgvaeevDI6mKaOa3NFxHZVa2o6xjq5bZO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FdvikDoO; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hgp/lNRZ; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2a652decf23c11eeb8927bc1f75efef4-20240404
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KiklBP1pJ9fjX+SRKkobzrZNNOKIG9+hy349LL0e7EE=;
	b=FdvikDoOav5qJPW9wIRwFNHPgbKKhf52P/KK39gWLt6edlGBKp+SjS2V/FBax6DIGl+z7+52zYrzHxejvzfBDr34bRfyv0VTWOyh6fYxtqvS2t92XMRA9xUwCmb7RmYQ4QlPSmpfPaIYJFjQ5eWw9d7oo/F8c8rDhHcT7/57WJA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:b34dac78-dc72-4fcd-8be6-a3fb8df17511,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:d8d0cb85-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 2a652decf23c11eeb8927bc1f75efef4-20240404
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 522739606; Thu, 04 Apr 2024 12:31:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 Apr 2024 12:31:10 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Apr 2024 12:31:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmJA+WLL1OPV/yrEjgWfUcDesmLr4xKEoCBU3kq92QMSvB16IpNTZqoNq6vYwW88Fo48weMZgYDKSgHcU6/E5pJQXyxUI0fIlshS4UuAZGj1ce8qnaLBKRtDa8za0t4iwNR0H1QRJgtOhtcjb+KSL/8QCGOBOFJfyun8k4kqE7xmDfKYOWkLvVPWFJteWcGqL01BN1H6QZ6ChT9Ahoh9/73guRVnWjl5DsNk+WngddloLnN6PBGa+Cg+7uyFU4N69itnVIWcQt0x2eG/TyJtzG0DDbQdAWVMyyyoMFIE3Wqt9vqdCncq2/Wfbm4TtKzllrJgHMHd5GiNAvv8+pS01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiklBP1pJ9fjX+SRKkobzrZNNOKIG9+hy349LL0e7EE=;
 b=O0ktt1J/vWDGASZZEbiqwrxwcv/K/FfXHtU6imb4SnE0hrrdIYe9Zj4/MbxnU5ug9cn7Zd9tuDP245yopYIMvTcjfof73z+a5Jr8ndfpokJiN83Oyj+Okq1htHVF2WYaintxMfBOZAVS9HublcwydfGcJtpjWPlINU0U8lOE93tzxiFipszKtekRHk/SVg10F0Hfzu7hpBLdO8YRmalfwbNC/PZNxXl3eYnt79dTnBDHIGj689in8b6xMH6WjZV2DEES+no/jlD+IjFh3QqCTTBTEJ5ui7REtUSHNyXGKN/Mctyt+E5/Y4iGQCQU+HMmCuXnHW3H38+robKsxG0sug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiklBP1pJ9fjX+SRKkobzrZNNOKIG9+hy349LL0e7EE=;
 b=hgp/lNRZucw+ya7ZdfdZpkGFIdiN0zZMiFtVXbgcifjHZZ2bcacw+w2QuSgAi5ik0NJwqXTan+jwmVH2E6sdHeAYRwnig80CO3LVPsRTPzt2X8VeSqgNhkzp7NMlP+OHj/cu05BL/es4h4npwpJ0vkd77R5UXh3OjcIanRJvmGs=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB8535.apcprd03.prod.outlook.com (2603:1096:405:65::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 04:31:07 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 04:31:07 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"conor@kernel.org" <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SG91bG9uZyBXZWkgKOmtj+WOmum+mSk=?= <houlong.wei@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 02/10] dt-bindings: mailbox: Add mboxes property for
 CMDQ secure driver
Thread-Topic: [PATCH v5 02/10] dt-bindings: mailbox: Add mboxes property for
 CMDQ secure driver
Thread-Index: AQHahbFYn7GUjisJlUGOm/8L6IGNq7FWsNGAgADVnQA=
Date: Thu, 4 Apr 2024 04:31:06 +0000
Message-ID: <9b9707a4a0e285a12741fe4140680ad2578d8d2b.camel@mediatek.com>
References: <20240403102602.32155-1-shawn.sung@mediatek.com>
	 <20240403102602.32155-3-shawn.sung@mediatek.com>
	 <20240403-conflict-detest-717b4175a00c@spud>
In-Reply-To: <20240403-conflict-detest-717b4175a00c@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB8535:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: azf9UrUujMiNgT0vEHvNhNa2EHy3fnMIzy1pZI6oyX9E8LxsaR2jAayoQuWLi0uhJO6hulVj+a3T9QlDdM7+uCdnw77fQsTRnzd9AZZ27hoBk8AxQ71bjPFgj1kq6uHlNBshyhkqvt4ypHOSBNZdAcXUpf5fPqqb6953ykQs/0lVBfY1hjnNiDud5GPNCLIEpvXY4lS4EEqdducT9okYH6Agn018fwCww6HGsogvlZ0ZXbCzBSjwdknv5P0/CfxTlNta9cE4MCMTAS9lccvmCIXTDHKKySWjKuL+kBLdCPLnSZlBnCT8oEankMBmsn5ygRRGwNHFkAzrx6yDegSjEk83BMh+UmMiGKLUWbnEs+misVuZDiJHfNElb9hg+s6SpqGBBD5uDk3dJRVueRATrdjXDrQD6RRScEwxGlxFIEviqe15bMQ1KK5zFIihKwdlBOltrXwkXC3+8NGOlJKPc/Cg/8ys++T0MEbkzs/FH8L3EE2EwENp+cllkHvAhs1eQBT0FRfGLNfT7q4UYRASRSokx9iUWgYMJGI220toNPXmn8E3Ow3JQAxj9Xndf+tm7Ewj3aabrIzaDvBbekE9tDGCd0NtZ2ns1MKewkf37bU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3RsRnowdisxbjJqYWg5VUJCZjVBRUhxNmlFeTF0WGNkRTNWdFN1cXlwTTdJ?=
 =?utf-8?B?SW9vSWRjTWVaZVVEYjFZUFFudytZcTViMTJuWi9GS2N3NFJlWTdIZkYyMDl1?=
 =?utf-8?B?cjFreVUvQllDcVE0ajA0dDhlaGhSb3pRZ0dFWStzcDJkWVhYZ1k1QUpDSTh6?=
 =?utf-8?B?MTh3b1lrYk5POFZqUVE2SThXL3VXNlpMM0RxY0VVUFplYnY2TTJJcUdqSjE4?=
 =?utf-8?B?WGljcTcxNWc0MXVMS2phT1oxRzV0V0pvemFpVS9FNHZtNXdBdXdJdG5MUFg4?=
 =?utf-8?B?YXkrdnk1Y1d4c2xXaVNWeWcxZUc5RlRITkdyR2xuWjh4bHpjeTdPOFJDRmlk?=
 =?utf-8?B?TVpsUGRqMHlUT3NSeDMvTXV5Z01waExveW1ieXlsRHFKazZmTnNaOWY1UkJh?=
 =?utf-8?B?SWlVYW9sT3dpc2VLUnpRb1ZWMFgxNGhCVXZXdFM1YXl2azVVRDMrVmROYmlD?=
 =?utf-8?B?N3pPcE1BZWhPamF2MGFzZWNrcURLNWRqWHNyalRncWRWUC8wajNVKys4NmFQ?=
 =?utf-8?B?dll5VERwMjdaMzBZcVE3djRqZ3ZndDJwUTBLaENNS0tFa3B1SERkUjF3dHVI?=
 =?utf-8?B?VzlkU1BvUkxPUzd1RVkwMFd2K2JveGRLWGYxRVd3K0U5VmYrekI4QXFQOEY0?=
 =?utf-8?B?NHliNDYvZFNjamErYTZuTGljcXRHemRwZy9hM2RrL1k0Uk9jN05DbTFtZWRt?=
 =?utf-8?B?TW9HQ0QrcGR0N0cxWUNGdm8zSVRhaEE5cEI3a2tmbC92NTA3UU1URXU0KzE1?=
 =?utf-8?B?OXIxU2VhNmRFai9SQzVLYkxKZnNlbVAwbHNOV01MM1JHMXQ0SW1xVy92QW1Y?=
 =?utf-8?B?Sy9keEt3SFBxQ1pZVlZQdm9ka1Z3aTJ3dFh6SVhxRjJ5a0UvTkwxMm93YWR4?=
 =?utf-8?B?UkY5TkZrdmp5eHBtNUVBRVFNdGNMemh3RzZURVNPVzJpVkhYOVBRdmR4YWw1?=
 =?utf-8?B?WWNyaGNMMlhzcXJ5UUFYNGluTXl3SUozV1hXMzdNK3V1T0ZreUtSdG1xMHRq?=
 =?utf-8?B?VlJNRG44TGMvTzdCWVdqS0R5Vy9hVDMxVWs3dDRONlZBNHdWQTdlSDVmck8x?=
 =?utf-8?B?T2xYdU1POURPcW9abzcrWmhCaVhnalRpMUZiQU1EUGw4OE9naHFCUmlDMjNR?=
 =?utf-8?B?KzlYYWdtd3Z3aVVSUWQrdHFIYzJVejJ5VXBXUEVGS3RXdjJVM0huYlV2c3I1?=
 =?utf-8?B?bFUwM2RsWkUwT3JEMzRCWGFyMzhGdDNXa1lBTTVLaHhScnRuVW9RbDBoQWFH?=
 =?utf-8?B?Uk5iQjBjRC9pMk1qcHhoNnQydThHRnJOMitDbDA5UGtYcU13bk5tcHBYbGFX?=
 =?utf-8?B?VkRwL2VVU2ZERVM0bjVud2pEa25QVURScXUzOElUT2NKc2tQUWc3bzBsSVRI?=
 =?utf-8?B?UzBJQTJkS2YzSDlPYm1pdlRISEpqdGNwbFFkQUVUcHZRNy9GU3pFUXpPRUtG?=
 =?utf-8?B?TWExN2lxNmRTeWJiejB3ZHFTWmlLN2pOa3ovRzNKVDRBdHM3bUVEV1hiUWI1?=
 =?utf-8?B?ZUltbnpmalF6MmVtNndQS0J5ejduanY5dGhVOUF1WDRQbGRMSm1JVzV6K1NU?=
 =?utf-8?B?TDVPbHZGdGtuY1R0a3RQK3dMbG9BVVY1dnQweXNycy9sTW1tamo3OVFxNkRJ?=
 =?utf-8?B?VkR1VmJYUlR3MTNBMFYzR1hEYSs3Y05SUllmSk1TRmVETzJ2dTZ1dmFNMGlS?=
 =?utf-8?B?dGdYekFEK1JBcVJMMjlPT0lXd3hPLzkxTzBjWFdTbzVvTndoZkN1cTliZ3Ar?=
 =?utf-8?B?VXZjTjlzOG8yU2ZtSE9HbFdncVprL29OMHRoTjBrQjlyam5aTHd1KzhSRzk3?=
 =?utf-8?B?WXgrU0FwVm8zLzRzYWJSVk9WQW5pMUNtZlpjcnJ2ODRVQzRHMmZjMllKOEZZ?=
 =?utf-8?B?Z3g2OHhwRVBkZWNsU2hTVEQrcEkyU2JDVTJ3Z0tNMVNpd3Q3S1Y4ZWFlOGRX?=
 =?utf-8?B?SyswTFlVcXpWcHpyM2JnQmd0MjNGRU12TzN1Z2lPT3ltS1NnV0JmVEErbHNE?=
 =?utf-8?B?ZitHditla24xbEgvM3pQcjFNd2R0ekJOQU9kNHd1eWxXa0lNL1AzZktDT0I4?=
 =?utf-8?B?U2hzVDB3Rm4vUTFHUVQ4NVh4V3lZbmtBcHlMLzhadmE3NnJKZHlPS3lsTlRr?=
 =?utf-8?B?Zy9iOXJETVdVYi9vZlMrd0U3SFdBR1g0L2lBc3NtYXZ1T29XSklGOFZOWDA0?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27837A2D7AA27A48B4D63116BBA8BF5C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e118282-1a6a-4dee-289b-08dc54600b97
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 04:31:06.7673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QAHGUdLTfeGP3XLH6jwqvX/e27LkV4tJ6qW3cps5U7nEFtLzwDCLorYCqiTEc1ULpqvOYKl+0gtPnr8zfKAQnolfjoQOo+SDU7HhtDEu0N0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8535
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.480100-8.000000
X-TMASE-MatchedRID: VfovoVrt/oanykMun0J1wmjZ8q/Oc1nAjLOy13Cgb4/mNRhvDVinv6Sx
	VUPqsOdUXJHwgBAo9RpK0A62LggjSZTZ9V50RBQ7kkBrUL/4Vy5MkOX0UoduuQKzHKFHzLsJTo+
	d5kYVw/FC/9HFmT0PUY6PfzW2Y7wy0KO5SGxuaaThG1IOMb7PsMnlJe2gk8vIgrAXgr/AjP3j6f
	SiVX5Av1RKMTSTTuSA0Snp7c4pH3dUHnl2REyzzBlckvO1m+Jco4jW7zSDg9k0QmmUihPzrPO+m
	s5efpt74vM1YF6AJbY9l7H+TFQgdVUqh/e/yPQx3QfwsVk0UbvdirxFVpmK9XUSG+BWUDOILPEL
	gFROOgVaSGlN9Os+iaYB1SqdxUKH78PqMocN4VI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.480100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4B82D8AB101C196AB7A621E5AD8F5114395367931539F8B6EAD40415CD246DB32000:8

SGkgQ29ub3IsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFdlZCwgMjAyNC0wNC0w
MyBhdCAxNjo0NiArMDEwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBXZWQsIEFwciAwMywg
MjAyNCBhdCAwNjoyNTo1NFBNICswODAwLCBTaGF3biBTdW5nIHdyb3RlOg0KPiA+IEZyb206ICJK
YXNvbi1KSC5MaW4iIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEFkZCBt
Ym94ZXMgdG8gZGVmaW5lIGEgR0NFIGxvb3BwaW5nIHRocmVhZCBhcyBhIHNlY3VyZSBpcnEgaGFu
ZGxlci4NCj4gPiBUaGlzIHByb3BlcnR5IGlzIG9ubHkgcmVxdWlyZWQgaWYgQ01EUSBzZWN1cmUg
ZHJpdmVyIGlzIHN1cHBvcnRlZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5M
aW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8g
Q2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9i
aW5kaW5ncy9tYWlsYm94L21lZGlhdGVrLGdjZS1tYWlsYm94LnlhbWwgICAgICAgICB8IDEwDQo+
ID4gKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tYWlsYm94L21lZGlhdGVrLGdjZS0NCj4gPiBtYWlsYm94LnlhbWwNCj4gPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L21lZGlhdGVrLGdjZS0NCj4gPiBtYWls
Ym94LnlhbWwNCj4gPiBpbmRleCBjZWY5ZDc2MDEzOTg1Li5jMGQ4MGNjNzcwODk5IDEwMDY0NA0K
PiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L21lZGlh
dGVrLGdjZS0NCj4gPiBtYWlsYm94LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxnY2UtDQo+ID4gbWFpbGJveC55YW1sDQo+
ID4gQEAgLTQ5LDYgKzQ5LDE2IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICBpdGVtczoNCj4gPiAg
ICAgICAgLSBjb25zdDogZ2NlDQo+ID4gIA0KPiA+ICsgIG1lZGlhdGVrLGdjZS1ldmVudHM6DQo+
ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgVGhlIGV2ZW50IGlkIHdoaWNoIGlzIG1h
cHBpbmcgdG8gdGhlIHNwZWNpZmljIGhhcmR3YXJlIGV2ZW50DQo+ID4gc2lnbmFsDQo+ID4gKyAg
ICAgIHRvIGdjZS4gVGhlIGV2ZW50IGlkIGlzIGRlZmluZWQgaW4gdGhlIGdjZSBoZWFkZXINCj4g
PiArICAgICAgaW5jbHVkZS9kdC1iaW5kaW5ncy9nY2UvPGNoaXA+LWdjZS5oIG9mIGVhY2ggY2hp
cHMuDQo+IA0KPiBNaXNzaW5nIGFueSBpbmZvIGhlcmUgYWJvdXQgd2hlbiB0aGlzIHNob3VsZCBi
ZSB1c2VkLCBoaW50IC0geW91IGhhdmUNCj4gaXQNCj4gaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0K
PiANCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQz
Mi1hcnJheWkNCj4gDQo+IFdoeSBpcyB0aGUgSUQgdXNlZCBieSB0aGUgQ01EUSBzZXJ2aWNlIG5v
dCBmaXhlZCBmb3IgZWFjaCBTb0M/DQo+IA0KSSBmb3Jnb3QgdG8gc3luYyB3aXRoIFNoYXduIGFi
b3V0IHRoaXM6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDAxMjQwMTE0NTkuMTIy
MDQtMS1qYXNvbi0NCmpoLmxpbkBtZWRpYXRlay5jb20NCg0KSSdsbCBmaXggaXQgYXQgdGhlIG5l
eHQgdmVyc2lvbi4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IENoZWVycywNCj4gQ29u
b3INCg==

