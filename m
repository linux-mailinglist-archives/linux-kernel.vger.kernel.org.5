Return-Path: <linux-kernel+bounces-120680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D6C88DB60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA6029F615
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C874F1F2;
	Wed, 27 Mar 2024 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P4EAJe10";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QnfWsEu4"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B5837710;
	Wed, 27 Mar 2024 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535997; cv=fail; b=SbDk/AZ3QcROd1vHU5fOascAmHhshxPbP98EPEyCZHEGhS4UsTz3iPomCbGe8xsjy90B3oF3hL2xSeZAMRQ2Y+RLNYIg0WBNvkWFyjxrQi3h8jS//+aPzZcAZY0XQguSCVW/r0yWxMf/OlINNNwQ/kJKRW7bwpm5Ez4BQRuuh7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535997; c=relaxed/simple;
	bh=jLUsRxu4zNIkMzxIAPgIy5AqmK4NTI97YxunYxXcck0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C9+yYBlLKVXevNfw4Pbr+BhhJPu23tDj1nXIYhh+JiMqlVXTugJOzavJoEzEebiESUqbwE1LHsUa9Tks/Xg0koWwog16ktEQ9xqc7H2TUala7qqBSxawIr+PZL2uqO+2JQbmx/iokoqL+9P9GCpzPkdZTQSF45edszEDN3iWhcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=P4EAJe10; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QnfWsEu4; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 55fd80f6ec2611eeb8927bc1f75efef4-20240327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jLUsRxu4zNIkMzxIAPgIy5AqmK4NTI97YxunYxXcck0=;
	b=P4EAJe10LImgh7Ajlh9vdOujDSeCQYqNwsY348W7RQHLVnSAdp6bcYk0cY1PRIEdxVcy0qRm3qXD5b0Yv4wlqcMfmBR7Q7vCza3AzRXsfFOif4NI1KVr2uaFg+cLRQ+0rVFheyD2cDdCPW1m1EMzpMvj6f9N5wkqne1L0wEVXcg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:39b902cb-7164-482e-9564-45601c0b1574,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:34b56300-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 55fd80f6ec2611eeb8927bc1f75efef4-20240327
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <yu-chang.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1072314983; Wed, 27 Mar 2024 18:39:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Mar 2024 18:39:47 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Mar 2024 18:39:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1lhp+QJLOyHJWHU3+y/XR1v/vYvHpeLATNWpTeGdkUc9od0HqKO9j7FVMmLQJmUIzD8C2tp8ye2sGjLynxVuqNxpSL9hp6NqX5hoZdc1YFlfyhv1RSBSVP0J7hsFnHfrr85Xeza3gJ2fr/i6yeYGxTd4Tes1+Zc2RnISFRtTloRAwzfHj7SmncV7a1HPuUzmMsmm0Whly5lQ4TGlvM/+tu680NDgsE1tahWrwxgZg+MB3hbQhkecRqEtEpxJhwX+FGgnw8GY6aw8uYQ6IfLH2kV5BdqUZpwwusE7Ryrwr91Og7hIJRKq2S8h7sbsYOoZj1LE1WJNma6cGl/SQW0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLUsRxu4zNIkMzxIAPgIy5AqmK4NTI97YxunYxXcck0=;
 b=gnjyXRdDeAWRxvE4J0mDm4oG1D1eqsuGuoqMsbKmXMVZSNjhHPzxzbgDxNsYIR8/Wj0gW7h4j6c0wW/EiQ6/Y81QOpM3N/a/McXIX5KhXL5990Q6OU6l/tCD7+rIqSisBGPLDZb/xZ0H/Sy4NX7aPEL1XnNFlbLS3OoJiv0+p6VnXFrxQ1L00W83C5gb5K738l0tk4CAo7pRpH4kv0pv3gbWPsVAwVL2A8HaDGhH225rSSlfF9RqFX8oZe+L50knMz3cWuepkTtlaYrf9md4RizlU6jFbM/WZxEukliZ+wtAUDvloWf9vDa9fVNdBap36NDFq8dMVf9LkOSaMOBsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLUsRxu4zNIkMzxIAPgIy5AqmK4NTI97YxunYxXcck0=;
 b=QnfWsEu4dRjx9jspB3CZU9R5QxEgtnsbWd0DpovBnKN2BWooElsB4rU4sDw++TqYIB/WXEv3WCZxyqdxMzGM7NlJ4FbuGnFUoC7hj8f5ApqGCBDb6g/lDWoRDX6cZxDAu0ip8vfMIjVHJCZefnssRTH+Y9xqrRuk/5zpg2chw68=
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com (2603:1096:820:ea::9)
 by TYSPR03MB8425.apcprd03.prod.outlook.com (2603:1096:405:50::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Wed, 27 Mar
 2024 10:39:45 +0000
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::5b3e:6643:14ad:cee7]) by KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::5b3e:6643:14ad:cee7%7]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 10:39:44 +0000
From: =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>
To: "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	=?utf-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?= <MandyJH.Liu@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	=?utf-8?B?WGl1ZmVuZyBMaSAo5p2O56eA5bOwKQ==?= <Xiufeng.Li@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, =?utf-8?B?RmFuIENoZW4gKOmZs+WHoSk=?=
	<fan.chen@mediatek.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb definition
Thread-Topic: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb definition
Thread-Index: AQHagAvP+Z8t0weqY0+w3yus4EYRpLFLRI6AgAAMHwCAAAMVAIAABykAgAALJYA=
Date: Wed, 27 Mar 2024 10:39:44 +0000
Message-ID: <b957b072d5d88ed315982e914a7f700e0ccafb83.camel@mediatek.com>
References: <20240327055732.28198-1-yu-chang.lee@mediatek.com>
	 <20240327055732.28198-3-yu-chang.lee@mediatek.com>
	 <6dd9959e-f741-47af-b10a-1894f72ae78f@linaro.org>
	 <c3ca3d90-898e-44b0-ad0f-dd78c09c5fcd@linaro.org>
	 <f3eedfb3495bb9c28b5cbf466387c24822c5b6f6.camel@mediatek.com>
	 <7ff9c4c7-3b56-4a5b-95b7-c37cbf8bcd6d@linaro.org>
In-Reply-To: <7ff9c4c7-3b56-4a5b-95b7-c37cbf8bcd6d@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7366:EE_|TYSPR03MB8425:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ChR9ohTK+WjYV/9epBnjNVx65wpAkxE/Xhyoixi2a86st4IAb4XaeWpxT1Ce3GkWSlfttUvcAqMhsNgDQy7k6S8lEy6MA0UnApL85jbl0LX69Yc8hF+wuhb30YsuAUU9VDY8IwNDMb8rglIE89KLIwyYZ8o8eQXm7/dlXx6rlc69ICsgJhzPnVELE9sfpLn+VcE12bLfXwVgVxTnLVaLng4o3yZFWHiDL8E+CARtcHC0iLzMPuXAw3gppqFR0gmW99xh9ZhquUWmAjNR80jVkj+y5el8CTXtnk4a5yhBSGjPr+2qxlt7Ws3n/Lc2bTDcKA1zy2q5WPA1FiZE7oe+gybH5WXF92c5qa1Z8A+PMfNHzaNOUIz2ATq+RnTj0TZX8vqk7JJQh+88xvYoNZZZacl4CqjNcYN9GXaoReshw7097ZypSYuOgv0CMPWSHKgXNdkzIOqLkT+UmhE+w62QTPHju1sy3lCaPmNYkBZUiHOxC9x4QVernhKLr6qEdNNfTserqQ0C8AAWMtcKdx4fWq2p/vHud92KehfjKa4s3QAGALzL2fnF+x6MGhFqMA69jIdKvBvVrPwDmhK5Z/kLNQagi9XK0qYKiD2rDOvBGZwvHrBrgpwtDH6o/t8ft9Blr7B6q6MB/dpLwGTr084LNGFj98xSkdRhbiitES9NWQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7366.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0tFcVpraGpYV3JEWWFZazBXNFFOZXJSb3YwNmlkUW5MYlZCVXZnOTMxQ1Q4?=
 =?utf-8?B?ZG1nUWE2clRTVCs1TmZ1TlFISUNWU0Y5WER4d2RRT0Y4TnMrdTdDbFJLUjZ0?=
 =?utf-8?B?cUVFSWxNektQL0lLaXJhekVqdmRKNEVHSHZ0a0tFekNKNno3ZTMvb1FOZjBY?=
 =?utf-8?B?dm5xQWpkTTNCWkxRWEJlelU1Zi9RTFNkc1hKNngyaXU1b1BIZCtia0taQ1li?=
 =?utf-8?B?R2ZCbnd0YUtOc3A2QlpTVUhwRDhraUdqV2RGZFI5dGw1ZDZTZGozQUNJTjFK?=
 =?utf-8?B?ZmlvRUQzZnVyelJjZnZ2eVptdU9GNE9ZUktIYjRtNWlPYXJiT2p5WlM3TWFl?=
 =?utf-8?B?VDRNM2svTFdSc0hJRlpiNDUxU0hVS1llancrSGczdkkyVVlpQzRjRnkrVUZU?=
 =?utf-8?B?VTJoVEdDbjhnUVRtK083NEE0TWcwN3JHbXdPZW80dy8wU05IOXFUS2RBRVhH?=
 =?utf-8?B?QWhlZndSWWlRdFE3cXUyMnNWUStHVTYreU9XTDk0SHBnU0JiSTFLVmo4WWNT?=
 =?utf-8?B?MjNqdGZoTy9Wb3pqeUNKOHpFMTZObXVMNGQzMG1oRnVwdjZOdWMyLzVuSHRw?=
 =?utf-8?B?eE1XWmlzTERmQkREOFJETUtySXFySUhtc1dab1RPUzU5b3ZGdnVkS2QyaS9F?=
 =?utf-8?B?ZEk1alVObXlNNGljM0tTSzlBY0VGbXBZcmpNSkJJcmx6TURaNHBTVDduZUlY?=
 =?utf-8?B?UUhpR3ArZmFjZ0VTRlNzSzlQbjV4N3pXT21JNmdkZ293ekliaVdjSGJWM2pT?=
 =?utf-8?B?TloyRmF3cmpqYnZubktJSUxkaDBaZU5URE1wZHorMjBKZURrY3FZbDRiY3ps?=
 =?utf-8?B?dTJvN2hGVHdUcGFxVWJIbWlrU1huQ0pWMDI1VWIzSUJoUDJRQVhJWUJFbTEx?=
 =?utf-8?B?NVpkby9ZMFBtSDFJblpwTmRZNy8yZFNrcjJBYTl4UDhxb1gvWC9iK2x3Ni8y?=
 =?utf-8?B?WWtNRzIzeCtoWXZiamdNMC81V2NMa0FkR01XS3gzTjRCV0pPMEI4c254Z1pl?=
 =?utf-8?B?R2dzR3lOTWhYVkFhSlZZU0xQR01Ya2JBNnlSN2E5TTNRbVhWajJ4RHVRSENJ?=
 =?utf-8?B?ZjVtVVBFSUtkRS95UVVNSFZsbzdDZzRETGlzUEJxRTdqRWVVRjhPOENHcGF1?=
 =?utf-8?B?TEVyY1VNd2xodE9WWTNFc1F3VmRwcXJwYyt1WjhBd0FJczA0WkZiOWFYOHln?=
 =?utf-8?B?ckhWbnRPdmlaWEtYU2laRmR3TGhLMWswK25WcHhqZTUyY0VZS3RoUHZtR3U1?=
 =?utf-8?B?UEpWQ0tKSUdzM20weVZDZGgrVWFicjVsQllDU2srUkh6Y2JMQlQ1MzlFbHc0?=
 =?utf-8?B?dmErMnJlZkk0SDFSaXZscVRtTWo1L3c2YUhUdE9UaDJPZTRaUHZJY3E1dWhu?=
 =?utf-8?B?Mjh5Yy9YaTJaVDc0V2FXL3ArRHVVc2t0aXZrZFVobzNBZjBwMXM3U0VPbkJF?=
 =?utf-8?B?anFjL2g5M3d0MDdoVFJrWW1pdjl1cFZsakNTUFFCQ0Q4OXh3YVBBTmZwQlc3?=
 =?utf-8?B?NGZkczZTcjlUMzNlTVg5M01WL0l4alFzTXlPTVg3b3FtQmxNTWlkbk5WNE5U?=
 =?utf-8?B?R3pIQWdqMi9NVmxKeTAzS3BkWEUyL2VaUVVRYnlEM3gxa2QrSVlZdjlDS2FH?=
 =?utf-8?B?Q1NjbVdFamY1S3ZqSmtwbWFHdXB3RHBJOG5oOEdYUkFjcEFpNTJpalpIVlNC?=
 =?utf-8?B?Zi9hZkxrckxQYzNtcFpqbGlWZ1BtU3ZlQktYbThWKzNLTXFJcUpWY0djalZ2?=
 =?utf-8?B?eGRrLzJFQzZZTkFqQnptc2g4dHV3RFRLSEpiUElhRG0zUXM1S0VmUzh4V0RJ?=
 =?utf-8?B?aEs5Ym1MbE82aHhkZjN3L01sTzA2N25VR1RGblpCaUYzckRkTElUSGgrakU2?=
 =?utf-8?B?WFNwOVJoN0tWeTY5cXdHZWQ3N1RHSE9HTlUyWWVGSkt4Z2k1RHkzaG5FYXph?=
 =?utf-8?B?MEhZd0trL0RveDdEOUpGYzZVWTBxS2d6d3dKY25LeWx6dU1IdDRWQmwwbk9o?=
 =?utf-8?B?WXR0SUhodk96b0h5Tll4OHo0WEtDWFZINzlsNisrK3R0SXRhSkRKajAwcnd0?=
 =?utf-8?B?Wk9XODdrbFovSDgwa0RobmJ5MXRocVpBWWprRUhPT0xEZEN3QUM0YkdzR0sw?=
 =?utf-8?B?ODFzMGhzR29WT0l0UXhmNWs2QjJvSXU0NFVFUGhsSzhkNWkvcjNFM25sVGJQ?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44D692CC9460384E8BB6CEC17B10886D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7366.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a09a48-40ab-473f-b460-08dc4e4a3777
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 10:39:44.4838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pgWS5Y/cYH/QETHNoBE0/SmJZCvDh7etVDAH2zNFaWknFAqM4hjrsqr622orYQhUEFJikJIJtOrXS0bHc5K2Y0LnRqc/gulzIKsXowqlJwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8425
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.526900-8.000000
X-TMASE-MatchedRID: dc8Jy61QoRrUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCifZYRtbOr2tXP5rFAucBUFMkOX0UoduuQKzHKFHzLsJySZ
	h5ZDH/3f9W4F6Nyvtfq+MC1pu6vlcyGOiXr1rOL7LtNJZxvPj1tmmHZ8J+6h3Ye1mzp7dkweSo7
	YBtVK4/OMORiBbIkHZBSzZjE6tH1/pRzKqh62z7KtWSWds/km2yeUl7aCTy8j4sp4xDuD8bDMBK
	S/l5ik3E2YAi4tcHVEfLxvfma9ooBgHZ8655DOP0gVVXNgaM0pZDL1gLmoa/PoA9r2LThYYKrau
	Xd3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.526900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	CE6FB45E13FDE441C43B41C1D64C682CBC6864BD58DAF1D43396908D5B9875E42000:8

T24gV2VkLCAyMDI0LTAzLTI3IGF0IDEwOjU5ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDI3LzAzLzIwMjQgMTA6MzQsIFl1LWNoYW5nIExlZSAo
5p2O56a555KLKSB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjQtMDMtMjcgYXQgMTA6MjMgKzAxMDAs
IEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4+ICAgDQo+ID4+IEV4dGVybmFsIGVtYWls
IDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+IHVudGls
DQo+ID4+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4+
ICBPbiAyNy8wMy8yMDI0IDA5OjM5LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+Pj4g
T24gMjcvMDMvMjAyNCAwNjo1NywgeXUtY2hhbmcubGVlIHdyb3RlOg0KPiA+Pj4+IEFkZCBTbWFy
dCBNdWx0aW1lZGlhIEludGVyZmFjZSBMb2NhbCBBcmJpdGVyIHRvIG1lZGlhdGVrDQo+ID4+Pj4g
cG93ZXIgZG9tYWluLg0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogeXUtY2hhbmcubGVl
IDx5dS1jaGFuZy5sZWVAbWVkaWF0ZWsuY29tPg0KPiA+Pj4+IC0tLQ0KPiA+Pj4+ICAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9wb3dlci9tZWRpYXRlayxwb3dlci1jb250cm9sbGVyLnlhbWwgIHwg
DQo+IDQNCj4gPj4gKysrKw0KPiA+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
DQo+ID4+Pj4NCj4gPj4+PiBkaWZmIC0tZ2l0DQo+ID4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3Bvd2VyL21lZGlhdGVrLHBvd2VyLQ0KPiA+PiBjb250cm9sbGVyLnlhbWwN
Cj4gPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvbWVkaWF0ZWss
cG93ZXItDQo+ID4+IGNvbnRyb2xsZXIueWFtbA0KPiA+Pj4+IGluZGV4IDg5ODVlMmRmOGE1Ni4u
MjI4YzBkZWM1MjUzIDEwMDY0NA0KPiA+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wb3dlci9tZWRpYXRlayxwb3dlci0NCj4gPj4gY29udHJvbGxlci55YW1sDQo+
ID4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL21lZGlh
dGVrLHBvd2VyLQ0KPiA+PiBjb250cm9sbGVyLnlhbWwNCj4gPj4+PiBAQCAtMTI1LDYgKzEyNSwx
MCBAQCAkZGVmczoNCj4gPj4+PiAgICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9k
ZWZpbml0aW9ucy9waGFuZGxlDQo+ID4+Pj4gICAgICAgICAgZGVzY3JpcHRpb246IHBoYW5kbGUg
dG8gdGhlIGRldmljZSBjb250YWluaW5nIHRoZSBTTUkNCj4gPj4gcmVnaXN0ZXIgcmFuZ2UuDQo+
ID4+Pj4gIA0KPiA+Pj4+ICsgICAgIG1lZGlhdGVrLGxhcmI6DQo+ID4+Pj4gKyAgICAgICAgJHJl
ZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+Pj4+ICsgICAg
ICAgIGRlc2NyaXB0aW9uOiBwaGFuZGxlIHRvIHRoZSBkZXZpY2UgY29udGFpbmluZyB0aGUgTEFS
Qg0KPiA+PiByZWdpc3RlciByYW5nZS4NCj4gPj4+DQo+ID4+PiBXaHkgZG8geW91IG5lZWQgaXQ/
DQo+ID4+Pg0KPiA+Pj4gUGx1cyBJIGFsc28gc2VlIG1lZGlhdGVrLGxhcmJzIGFuZCBtZWRpYXRl
ayxsYXJiLWlkLi4uIHNvIG5vdyB3ZQ0KPiA+PiBoYXZlDQo+ID4+PiB0aGlyZCBvbmUgc2ltaWxh
ci4NCj4gPj4NCj4gPj4gLi4uIGFuZCBub3QgZXZlbiB0ZXN0ZWQhDQo+ID4+DQo+ID4+IEJlc3Qg
cmVnYXJkcywNCj4gPj4gS3J6eXN6dG9mDQo+ID4+DQo+ID4gSGksDQo+ID4gDQo+ID4gSSB3aWxs
IGRvdWJsZSBjaGVjayB0aGUgZm9ybWF0IG9mIHlhbWwgZm9yIHRoZSBuZXh0IHZlcnNpb24sIHNv
cnJ5DQo+IGZvcg0KPiA+IGluY29udmVuaWVuY2UuIEJ1dCBJIGRpZCB0ZXN0IGl0IG9uIG10ODE4
OCBjaHJvbWVib29rLCB0aGUgcmVhc29uDQo+IHdoeQ0KPiANCj4gSG93IGRvIHlvdSB0ZXN0IGEg
YmluZGluZyBvbiBjaHJvbWVib29rPw0KPiANCj4gPiBwb3dlciBkb21haW4gbmVlZCBsYXJiIG5v
ZGUgaXMgdGhhdCB3aGVuIG10Y21vcyBwb3dlciBvbiwgc2lnbmFsDQo+IGdsaXRjaA0KPiA+IG1h
eSBwcm9kdWNlLiBQb3dlciBkb21haW4gZHJpdmVyIG11c3QgcmVzZXQgbGFyYiB3aGVuIHRoaXMg
aGFwcGVuDQo+IHRvIA0KPiA+IHByZXZlbnQgZHVtbXkgdHJhbnNhY3Rpb24gb24gYnVzLiBUaGF0
IHdoeSBJIG5lZWQgbGFyYiBub2RlIGluIGR0cy4NCj4gDQo+IE5vIG9uZSB0YWxrcyBoZXJlIGFi
b3V0IGxhcmIgbm9kZS4uLg0KDQpTb3JyeSwgTWF5IHlvdSBlbGFib3JhdGUgb24gd2hhdCBpbmZv
cm1hdGlvbiBJIG5lZWQgdG8gcHJvdmlkZSB0byB5b3UNCm9yIGl0IGlzIGp1c3QgYSBzeW50YXgg
cHJvYmxlbSBJIG5lZWQgdG8gZml4Pw0KDQpUaGFua3MNCkJlc3QgUmVnYXJkcywNCg0KWXUtY2hh
bmcNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0K

