Return-Path: <linux-kernel+bounces-96123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B632E875764
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2151F22304
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8831136995;
	Thu,  7 Mar 2024 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="JjG3xTWU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="gstAo5YY"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2132.outbound.protection.outlook.com [40.107.15.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B341A88
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.132
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840599; cv=fail; b=WR3VoQsMCNzF16hMfyQdgT9YG5RpwgeDjEBiI3fo9UFQT/tvBJP6gfVUev2MqcF4oDsoq30ig/3Ljm8tdcyCuzCV3ogbFzcbyvhByponYF6yIpZbu2JD0j2jAFDn8TQxf8HmecxjrnYOIhi7ulC+j9Ei65TcuoQ9WlXsfXQT0qY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840599; c=relaxed/simple;
	bh=iu1+1dchPjJHhq6TqA6M6HfYB11SHCET5fs3qHryX6s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iLO18zMc7IG1NQrZET0X1cnGspb8KOR8l8q9hGIsxl5+n7eoIQD22M1jYNGpVks79E01JBF6FBQ9iC9S0TOWTgFPsWoOo+XYao6ROvokORJ3Kai1dUBtpxKA/5Bu0+jXdy1Q5ClQnLkuHc+i8IuxP0alOHpeyAbJzM4FhvxGrLI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=JjG3xTWU; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=gstAo5YY reason="signature verification failed"; arc=fail smtp.client-ip=40.107.15.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=R4ATmujJcg53ysom4v0RPVXHA+GuuV6mnLUtfsXhe3490b0JRNYcq9nJWmJgIWULC8w4Hvy/HlrDU+/NNJkuxkLZGdU0u8GqZLjrXDp6s3P2U4xd+Ps0hzx8WU0RvxD9HJmRJQiPbYym69S52OPUZffuBZRrBxCgdHmQJNAHctjcP2XEJW+WU+jeffnFO5e2iCz+QtQmend5BH26u1x02SSiRx5LiCJm/GyNP3OtU4sQu6Hrz3bmk59tQXqCL9Y6/pdxQfdOzD8vVvkEsMEhW2jy/Qq3C/sTHqPhzLogM3l2g5jmM3837MNgeQzC/OS9wNnY352Yz+Xrd03CQNf3Hw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWwx13Bc7GLDTrsMKVHekDUQD0pGV1UnGlPI8JDYrN4=;
 b=TsP9PCnyYf9bi7h5UrdLvWf/vHHGFIvlfYPfqFDpgoPtO/SP4UI/ks5hA26MuRrR0uZEE8W/l9NVQDwT5Yhv9mNsbEKLjTLFk//S+/QY56p5PXS+faVOTdjPROZhpawsFcQWz4Q6YcTApIq6x3dpUQzMd/YxsfzeSI+pgYpMWlRYCdkeLsNn8k+ZBBqsBjfdKPCLXPViumYXerxPViC4mcrsBbMV3GCfF1DONhPd0J9mAjgOoRWdaaW/9ddmsprGVUftPjQA3hDShi5woUPG7nQIlh62tpExrHdKxMGtYOhsIZMWfMUG1FHTV0qtwo1uxBXvO3vtwrfk46fz1wOHHw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.80) smtp.rcpttodomain=alu.unizg.hr smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWwx13Bc7GLDTrsMKVHekDUQD0pGV1UnGlPI8JDYrN4=;
 b=JjG3xTWUi3J0ICOAKCMo/9BAq6erIjzyTAXUIktLgrfOJRBtl7aJKmglqaiCTTzhexT2vNAuP3Umq7/Ufim9raIicW1s9TToVgKlbW2b6eIWwismCByxR9uoNjr49IacHdmy5mzPbwAp631KtfrtwEoXiCSTXXuyb78XDEMyhg7h0sUZ8MpMH+GAfAAfuovxBh714LjLb7UEpn8OUMA83WG44+VnMvFljIwMAhI+SouSDNIQ9ghrgw4Bx8SaCP9pxftwdEYRboKorV7Mv90JtuwujVKdMpXibn2lfyabHFwzhDwds305A2vfU089PmATEQtTgsu5ZZLY0ESfjLNxLQ==
Received: from AS4P250CA0016.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::8)
 by DBBPR03MB7147.eurprd03.prod.outlook.com (2603:10a6:10:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 19:43:11 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::2d) by AS4P250CA0016.outlook.office365.com
 (2603:10a6:20b:5e3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Thu, 7 Mar 2024 19:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.80) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 19:43:11 +0000
Received: from outmta (unknown [192.168.82.133])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 15C122009538A;
	Thu,  7 Mar 2024 19:43:11 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (unknown [104.47.12.51])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 5E3232008006E;
	Thu,  7 Mar 2024 19:43:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HX3vLgQXeftFenaNscgLDhas+hcM6ZBzqDDpk9zewOxPGlc0Std9J/M5LSbBrWJBSmSg5xFSU67urDOqmEhEDrdX2xG81LgXcwfRBuzFI3VE8Wx5odWYFNw2ZD5ilphWOqOSOuMvY+kVgGv6FWbZc6jTAD79Hv5kkXjv52UXABs/sArAjysnQcuIY9juXnPUyH+Csno9Kxe0mfsccj1xMzgu28/BqVuzuXWKkxjs8+hc9+9NKWYOJArN+Mhldg7oZDAUecfViw6911+/XZqJvBU9FpWSgrfhbRlet35SetFlmAKrw5E9IGYS4NbsX/3Id/1j+JN7y7az2x5F8UtjEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koRaczsVNR++ZqML52jH48MU55niFZGU9STqac07Dos=;
 b=ENy36X+EcE/iG/cxXZF6wUWIKhKI9cIxSOqe6LCCaxHHQP/u9ptPxaA3TW0PcFwKU25Gwv+RYRS5C3S7Bes+kbTpAvLAhffSHGDAwrL8VM224Fmj5dOxqEEeSwYn7JVeO3HUBv61GknFNEtmn1F6mE7xeKnM3csILSpUb038hKuayIxAKzgOwHuAn36EeUry1vOXwYMD1rti6IHxobBSuoleGyeoucYUmpVZyehStOz7vIhNSQFQaqBs6a3gCkpzlECee8OZtqbchod/QCw6Gdyk3QB0ESnlg5j5nfvoUfNO3G2/XBXTI363ViXWbVfBy4x48tyjRWn/Y7x3TVCBGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koRaczsVNR++ZqML52jH48MU55niFZGU9STqac07Dos=;
 b=gstAo5YYQtBeXIiIGZwU3TL0Ul3VEYOdDXWqZ7+e57AkD/8Y4VpiJdrNJ+LAYs6h9dx47sinu7awEOuWFZRGzAvTMI4XoJ3vMXJ1ot79TNUy1io2UFvWxYPRJlWWV97v+3+npFvfHaiXuoldVtmJuD0DjUhXG5zx3KdVUb6lSAXQ3UKVGnwYVMfcruSTHnrwdYAd1c4D/gD5F1uHPQADX4xVXK0TSQ+mFqCFjP9jUD+bVax+H79bGDZj+WX78WUBDcHhehko+SgsJP0NZD6L3SFI3WvJniEPxx/x3AwaIH3qyyMKa1Yzp07oado2TVt2lZfsMqx/RN94H7jvo7UZow==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DU0PR03MB9850.eurprd03.prod.outlook.com (2603:10a6:10:449::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 19:43:08 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 19:43:08 +0000
Message-ID: <83b3c900-d4eb-457f-99e6-cb21e0eae4cb@seco.com>
Date: Thu, 7 Mar 2024 14:43:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] KCSAN: data-race in tick_nohz_idle_stop_tick /
 tick_nohz_next_event
Content-Language: en-US
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
 linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
References: <40ac9903-469a-b1ea-4339-8b06f855450e@alu.unizg.hr>
 <3993c468-fdac-2ff2-c3ee-9784c098694c@alu.unizg.hr>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <3993c468-fdac-2ff2-c3ee-9784c098694c@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0389.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::34) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|DU0PR03MB9850:EE_|AMS1EPF00000046:EE_|DBBPR03MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: ba35efe0-1acc-4caa-103f-08dc3eded25a
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 aCdjRbyvoOIcUXjurXoffDy9RhWJEeBD0lPwyWFIkJPh+371t2oM2FHLc6F/O/x6/QCwoaJachztGre3QJIYVsx5Y1L5zyP56I9CiAZX9UuSfkV1M6RG9guGC/svlR5jkjHgdtFfw1a16gDygvpH0FnBAGTw5xgTou2fx5KPvt6js8n27lrONX2+N7nNIUAxeJ0p6+DXM0jFrsiWJLfOj6q1qVe52bTxXWlshVv7BnMQePGnKN2ZWxSwWbbgBnbbo1EAohd4UuXF855QJ+i3+wwHw/oeZVToyqd9IXeZ2OJlr+EwU+ulpg9O2N6rz+af9vMX+qq3hcAXlAS/coxkWbXTkPvVIwN++QjRk0UJJPc1HSDg9VoTlTn2RqJ2dmwlcaHa2DsdE3M240AijdWkkdclkXca1LRhBvHcxXfWL0SlvH3KH8otC4tWIYYdoS3AaMygH6+LlM013Q9Kvkdcvsi5WSG/bIBkMR2hC4802eZLyO2R2FL8u77vzG0MXXdTQwZ9Or4hkACBL2lNN93SX+B5HHWna14hnC587oRHmvLsfDHjAOT3g1mcXno2gEYA4NElKJa89zEsYqSY14afcOwxRM8pWD5GshBwe+7TgkVdgHUi4tzQzTm5E1bPReKNwJ6ru6bSkLeHVSHc1v6UK17O/X/axYUmCZChyv7TTJGR8HQPiaVmnIqPiKPYV1ein1QfvALWMU8zQmiajukhBHg6eVRF/KtMJYGrL0HtGL0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9850
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3283bb43-a09a-46cc-68b4-08dc3eded03b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g9EVrESJNF0RBzOu3Ck3mhDL/ce4kuSw6MreUtbbVqdbSqZnbWl4Iccc9bxlJHlJQYeihylXjYHLA4wrmDgTxboD+PdNNfRmykKMx1x+tBXFLGq2W1px2SNAkZRsFjR1c5nhR2LGiZjhpz+nnSUz6Dzg7nJpy/l56wJm6svpbQSzXb9lNOgaDDTk+ddhgQXmN78DGcX2h2mc5uGNDYnwjYhqkyQh4nIh7xjJdlRMKswHxpsOhIJqXPzrkqslCTy6LnI1LHcNle0J77XUa0aTlEuFJDpRv+NUkuUqqbHaMOXzp9tnP3BEGfd4NKn2l6idn0uvsnB2Z7RC9WFjt28e+CFUlh3P9o6pdOxsPDLS3trmhGMnSR0az+reMk6/b+Hh65SSEyrcl7hNvfkAnzMiyN2P8xtOWWJAU7sGn6JzjDIUoOf9/+NPH4l05+PyuIhcYNyKyAQQH39aIRD+vt0NVvOVyGKkRFNfP+DsmeTukoKFenEpBWj2HuRjRje7SmHCn2ZBZo4jFu4HNPPSD/Jz38ymwp5m6uJkVD9UKtdIJzWSazgzn0gyFvfz6DDMcXKCkhVfv6+ItmfWJjm95FnoysVXoGbKJ/WsntfHirxlAAu/G+5iGF3eYLgg+buwzgoFkwSVfMp1AbAtB/55SwlQNhPVJ4lMm4897GB/2mmFzPgxf4qj1u8CnHnJg85aah9Nie6lksJXxtYweBXbGcS2ig02eZjKs1oG3nL3Up6jTmVsFrJSJiDU1suJEgoTUnzp
X-Forefront-Antispam-Report:
	CIP:20.160.56.80;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 19:43:11.2078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba35efe0-1acc-4caa-103f-08dc3eded25a
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.80];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7147

On 8/18/23 10:15, Mirsad Todorovac wrote:
>
>
> On 8/17/23 21:32, Mirsad Todorovac wrote:
>> Hi,
>>
>> This is your friendly bug reporter. :-)
>>
>> The environment is the vanilla torvalds kernel on Ubuntu 22.04 LTS and a=
 Ryzen 7950X assembled box.
>>
>> [ 7145.500079] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [ 7145.500109] BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_=
nohz_next_event
>>
>> [ 7145.500139] write to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 2=
6:
>> [ 7145.500155]  tick_nohz_idle_stop_tick+0x3b1/0x4a0
>> [ 7145.500173]  do_idle+0x1e3/0x250
>> [ 7145.500186]  cpu_startup_entry+0x20/0x30
>> [ 7145.500199]  start_secondary+0x129/0x160
>> [ 7145.500216]  secondary_startup_64_no_verify+0x17e/0x18b
>>
>> [ 7145.500245] read to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 16=
:
>> [ 7145.500261]  tick_nohz_next_event+0xe7/0x1e0
>> [ 7145.500277]  tick_nohz_get_sleep_length+0xa7/0xe0
>> [ 7145.500293]  menu_select+0x82/0xb90
>> [ 7145.500309]  cpuidle_select+0x44/0x60
>> [ 7145.500324]  do_idle+0x1c2/0x250
>> [ 7145.500336]  cpu_startup_entry+0x20/0x30
>> [ 7145.500350]  start_secondary+0x129/0x160
>> [ 7145.500367]  secondary_startup_64_no_verify+0x17e/0x18b
>>
>> [ 7145.500392] value changed: 0x0000001a -> 0xffffffff
>>
>> [ 7145.500411] Reported by Kernel Concurrency Sanitizer on:
>> [ 7145.500421] CPU: 16 PID: 0 Comm: swapper/16 Tainted: G             L =
    6.5.0-rc6-net-cfg-kcsan-00038-g16931859a650 #35
>> [ 7145.500439] Hardware name: ASRock X670E PG Lightning/X670E PG Lightni=
ng, BIOS 1.21 04/26/2023
>> [ 7145.500449] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Please find dmesg log (what was available in the ring buffer) and the ls=
hw output attached.
>>
>> NOTE: There are no proprietary drivers loaded and Canonical livepatch is=
n't working for this kernel,
>> probably previous ACPI KCSAN BUGs turn this taint on.
>>
>> Thank you very much for your time evaluating this report.
>
> P.S.
>
> According to Mr. Heo, I will add the decoded stacktrace to this bug repor=
t, which ought to have been done
> in the first place :-/
>
> [ 7145.500079] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 7145.500109] BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_n=
ohz_next_event
>
> [ 7145.500139] write to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 26=
:
> [ 7145.500155] tick_nohz_idle_stop_tick (kernel/time/tick-sched.c:904 ker=
nel/time/tick-sched.c:1130)
> [ 7145.500173] do_idle (kernel/sched/idle.c:215 kernel/sched/idle.c:282)
> [ 7145.500186] cpu_startup_entry (kernel/sched/idle.c:378 (discriminator =
1))
> [ 7145.500199] start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/ke=
rnel/smpboot.c:294)
> [ 7145.500216] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:=
441)
>
> [ 7145.500245] read to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 16:
> [ 7145.500261] tick_nohz_next_event (kernel/time/tick-sched.c:868)
> [ 7145.500277] tick_nohz_get_sleep_length (kernel/time/tick-sched.c:1250)
> [ 7145.500293] menu_select (drivers/cpuidle/governors/menu.c:283)
> [ 7145.500309] cpuidle_select (drivers/cpuidle/cpuidle.c:359)
> [ 7145.500324] do_idle (kernel/sched/idle.c:208 kernel/sched/idle.c:282)
> [ 7145.500336] cpu_startup_entry (kernel/sched/idle.c:378 (discriminator =
1))
> [ 7145.500350] start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/ke=
rnel/smpboot.c:294)
> [ 7145.500367] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:=
441)
>
> [ 7145.500392] value changed: 0x0000001a -> 0xffffffff
>
> [ 7145.500411] Reported by Kernel Concurrency Sanitizer on:
> [ 7145.500421] CPU: 16 PID: 0 Comm: swapper/16 Tainted: G             L  =
   6.5.0-rc6-net-cfg-kcsan-00038-g16931859a650 #35
> [ 7145.500439] Hardware name: ASRock X670E PG Lightning/X670E PG Lightnin=
g, BIOS 1.21 04/26/2023
> [ 7145.500449] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The code seems to be:
>
>
>     /*
>      * If this CPU is the one which updates jiffies, then give up
>      * the assignment and let it be taken by the CPU which runs
>      * the tick timer next, which might be this CPU as well. If we
>      * don't drop this here the jiffies might be stale and
>      * do_timer() never invoked. Keep track of the fact that it
>      * was the one which had the do_timer() duty last.
>      */
>     if (cpu =3D=3D tick_do_timer_cpu) {
>         tick_do_timer_cpu =3D TICK_DO_TIMER_NONE;
> =E2=86=92        ts->do_timer_last =3D 1;
>     } else if (tick_do_timer_cpu !=3D TICK_DO_TIMER_NONE) {
>         ts->do_timer_last =3D 0;
>
>     }
>
> but I am not sure why this happens.
>
> Maybe a WRITE_ONCE(ts->do_timer_last, 1) is required?
>
> Or is it another KCSAN false positive ...

I have seen a few more KCSAN reports regarding this variable:

[  153.285199] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  153.292529] BUG: KCSAN: data-race in tick_nohz_next_event+0x15c/0x29c
[  153.299118]
[  153.300685] race at unknown origin, with read to 0xffffffc082aa1048 of 4=
 bytes by task 0 on cpu 2:
[  153.309760]  tick_nohz_next_event+0x15c/0x29c
[  153.314256]  tick_nohz_get_sleep_length+0xd8/0x118
[  153.319186]  menu_select+0x1e0/0xc08
[  153.322875]  cpuidle_select+0x4c/0x60
[  153.326686]  do_idle+0x1e0/0x2b4
[  153.330062]  cpu_startup_entry+0x34/0x3c
[  153.334133]  secondary_start_kernel+0x1e8/0x21c
[  153.338821]  __secondary_switched+0xb8/0xbc
[  153.343143]
[  153.344706] no locks held by swapper/2/0.
[  153.348802] irq event stamp: 129586
[  153.352370] hardirqs last  enabled at (129585): [<ffffffc081acaa2c>] el1=
_interrupt+0x40/0x50
[  153.360964] hardirqs last disabled at (129586): [<ffffffc0800d8fec>] do_=
idle+0xc8/0x2b4
[  153.369132] softirqs last  enabled at (129560): [<ffffffc08001071c>] __d=
o_softirq+0x47c/0x500
[  153.377786] softirqs last disabled at (129549): [<ffffffc080017134>] ___=
_do_softirq+0x10/0x1c
[  153.386457]
[  153.388019] value changed: 0xffffffff -> 0x00000001
[  153.392993]
[  153.394555] Reported by Kernel Concurrency Sanitizer on:
[  153.399947] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.6.20+ #102
[  153.406595] Hardware name: xlnx,zynqmp (DT)
[  153.410866] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

and:

[   75.362055] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   75.369461] BUG: KCSAN: data-race in tick_sched_do_timer / tick_sched_do=
_timer
[   75.376854]
[   75.378426] write to 0xffffffc082aa1048 of 4 bytes by interrupt on cpu 1=
:
[   75.385335]  tick_sched_do_timer+0x124/0x168
[   75.389744]  tick_sched_timer+0x48/0xc8
[   75.393720]  __hrtimer_run_queues+0x200/0x5f0
[   75.398198]  hrtimer_interrupt+0x1b0/0x3f4
[   75.402417]  arch_timer_handler_phys+0x40/0x54
[   75.406983]  handle_percpu_devid_irq+0xf8/0x20c
[   75.411679]  generic_handle_domain_irq+0x48/0x64
[   75.416435]  gic_handle_irq+0xc4/0x100
[   75.420298]  call_on_irq_stack+0x24/0x4c
[   75.424360]  do_interrupt_handler+0xc0/0xc4
[   75.428692]  el1_interrupt+0x34/0x50
[   75.432415]  el1h_64_irq_handler+0x18/0x24
[   75.436668]  el1h_64_irq+0x64/0x68
[   75.440184]  percpu_counter_add_batch+0xd8/0x1b8
[   75.444967]  set_pte_range+0x14c/0x2c8
[   75.448838]  filemap_map_pages+0x2dc/0xa38
[   75.453091]  __handle_mm_fault+0x1304/0x17dc
[   75.457492]  handle_mm_fault+0xa0/0x374
[   75.461450]  do_page_fault+0x1f8/0x620
[   75.465365]  do_translation_fault+0x118/0x138
[   75.469887]  do_mem_abort+0x5c/0xe4
[   75.473516]  el0_da+0x5c/0xac
[   75.476623]  el0t_64_sync_handler+0xe4/0x158
[   75.481050]  el0t_64_sync+0x190/0x194
[   75.484834]
[   75.486405] 5 locks held by (d-logind)/293:
[   75.490693]  #0: ffffff88076753c0 (&vma->vm_lock->lock){++++}-{3:3}, at:=
 lock_vma_under_rcu+0x15c/0x5c0
[   75.500441]  #1: ffffffc082b042f0 (rcu_read_lock){....}-{1:2}, at: __han=
dle_mm_fault+0x1260/0x17dc
[   75.509755]  #2: ffffffc082b042f0 (rcu_read_lock){....}-{1:2}, at: filem=
ap_map_pages+0x0/0xa38
[   75.518748]  #3: ffffffc082b042f0 (rcu_read_lock){....}-{1:2}, at: __pte=
_offset_map+0x0/0x2a0
[   75.527662]  #4: ffffff880762b018 (ptlock_ptr(ptdesc)){+.+.}-{2:2}, at: =
__pte_offset_map_lock+0xa4/0x264
[   75.537488] irq event stamp: 1761
[   75.540890] hardirqs last  enabled at (1760): [<ffffffc080bc1f78>] percp=
u_counter_add_batch+0x160/0x1b8
[   75.550465] hardirqs last disabled at (1761): [<ffffffc081aca990>] el1_i=
nterrupt+0x24/0x50
[   75.558893] softirqs last  enabled at (1534): [<ffffffc08001071c>] __do_=
softirq+0x47c/0x500
[   75.567382] softirqs last disabled at (1529): [<ffffffc080017134>] ____d=
o_softirq+0x10/0x1c
[   75.575889]
[   75.577460] read to 0xffffffc082aa1048 of 4 bytes by interrupt on cpu 2:
[   75.584273]  tick_sched_do_timer+0x48/0x168
[   75.588596]  tick_sched_timer+0x48/0xc8
[   75.592572]  __hrtimer_run_queues+0x200/0x5f0
[   75.597050]  hrtimer_interrupt+0x1b0/0x3f4
[   75.601269]  arch_timer_handler_phys+0x40/0x54
[   75.605835]  handle_percpu_devid_irq+0xf8/0x20c
[   75.610531]  generic_handle_domain_irq+0x48/0x64
[   75.615287]  gic_handle_irq+0xc4/0x100
[   75.619150]  call_on_irq_stack+0x24/0x4c
[   75.623204]  do_interrupt_handler+0xc0/0xc4
[   75.627535]  el1_interrupt+0x34/0x50
[   75.631258]  el1h_64_irq_handler+0x18/0x24
[   75.635512]  el1h_64_irq+0x64/0x68
[   75.639027]  lock_acquire+0x13c/0x2f0
[   75.642820]  count_memcg_event_mm.part.0+0x70/0x2a8
[   75.647829]  handle_mm_fault+0x1d8/0x374
[   75.651874]  do_page_fault+0x1f8/0x620
[   75.655789]  do_mem_abort+0x5c/0xe4
[   75.659417]  el0_da+0x5c/0xac
[   75.662524]  el0t_64_sync_handler+0xe4/0x158
[   75.666951]  el0t_64_sync+0x190/0x194
[   75.670736]
[   75.672307] 2 locks held by systemd/1:
[   75.676152]  #0: ffffff88042627b0 (&vma->vm_lock->lock){++++}-{3:3}, at:=
 lock_vma_under_rcu+0x15c/0x5c0
[   75.685900]  #1: ffffffc082b042f0 (rcu_read_lock){....}-{1:2}, at: count=
_memcg_event_mm.part.0+0x0/0x2a8
[   75.695726] irq event stamp: 576347
[   75.699302] hardirqs last  enabled at (576346): [<ffffffc08001af70>] loc=
al_daif_restore+0x38/0x54
[   75.708338] hardirqs last disabled at (576347): [<ffffffc081aca990>] el1=
_interrupt+0x24/0x50
[   75.716940] softirqs last  enabled at (576161): [<ffffffc08001071c>] __d=
o_softirq+0x47c/0x500
[   75.725602] softirqs last disabled at (576154): [<ffffffc080017134>] ___=
_do_softirq+0x10/0x1c
[   75.734283]
[   75.735854] value changed: 0xffffffff -> 0x00000000
[   75.740836]
[   75.742407] Reported by Kernel Concurrency Sanitizer on:
[   75.747808] CPU: 2 PID: 1 Comm: systemd Not tainted 6.6.20+ #101
[   75.754290] Hardware name: xlnx,zynqmp (DT)
[   75.758563] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The justification seems to be in tick_sched_do_timer:

        /*
         * Check if the do_timer duty was dropped. We don't care about
         * concurrency: This happens only when the CPU in charge went
         * into a long sleep. If two CPUs happen to assign themselves to
         * this duty, then the jiffies update is still serialized by
         * jiffies_lock.
         *
         * If nohz_full is enabled, this should not happen because the
         * tick_do_timer_cpu never relinquishes.
         */

with the other assignment being in tick_nohz_stop_tick. I'm not familiar
enough with this code to say whether we should be using READ/WRITE_ONCE
or maybe just data_race (as would be implied by the comment above).

--Sean

[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>

