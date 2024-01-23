Return-Path: <linux-kernel+bounces-34997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F4C838A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0835828CD4D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D4E59B64;
	Tue, 23 Jan 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jKxfXWpY";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="faVtiGyf"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80758ACD;
	Tue, 23 Jan 2024 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002084; cv=fail; b=OmOvyLjezIPm0tF5dixle8GW9Lw2lsFXB8exiuyXaoNWhLQ4Isg2x5pkCpouAUaKXWCM22K83Edst3GmgzSYje5h1a/3EMyPFk92/2SemLRmAVhdkbdZopNRsMzoGE4SbgivK0MPuMgJupzNMbTVfdPKdTc4nNEaa3BdnuC/+f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002084; c=relaxed/simple;
	bh=fFvdouQ1D3uITBNPpIPEVe7y2xspVwEu17oeeBLGErU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GYEe/1ndA5rHfFFyrfp7gaBQ+TvtBYNGGyeV4e749Baz4M/9yF+K+dBg6ckiCXPXWBVeDjuXnbiODj1Y+HiS3G/eYynqlHdHHjpJcz5jjFba/5KPnUgEnsz8OUx7vKSuecZEnjC/3/R5clxlXLBJUM9SWPW9IT7Yl0vQY4ocNuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jKxfXWpY; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=faVtiGyf; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: add5ab00b9d111ee9e680517dc993faa-20240123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fFvdouQ1D3uITBNPpIPEVe7y2xspVwEu17oeeBLGErU=;
	b=jKxfXWpY1XaUUGACwSo07AeslS0p80O/JMshK1jJSIsFDh+wvfNJiZ9+O1IWDzgqqc+Atnp5MtWOYZKfOV37wJCBKAaDesVmskl0nPAXI3VAwns/Z2Jz6Iwyho+CcnOUrvDffSXhAZHGT/0c7rLT7md0OY67Nw2IYLkutcgTejQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:59275ac1-e77e-4c0e-b18e-16e0d3d208cc,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6e16cf4,CLOUDID:4ab58f8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: add5ab00b9d111ee9e680517dc993faa-20240123
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1373508995; Tue, 23 Jan 2024 17:27:51 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 23 Jan 2024 17:27:49 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 23 Jan 2024 17:27:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZLFHGk5gLhLRsGW3JESVAp6Jp9M0Zfh2hS+QF5tOKvUS8KMmr7jouKzRqF60B9T2q2xgMuDvqe6IxnrNZgiJvf5LCFU7vvh3KSVSsH0uAAdnualUsdfVxJVSVjW2aEf0tq12YutDfSc6udc4oSrETjRcxml3Yejf6uNcfBYo7BFmNGgzuK8/hk4UTAxRMwtXlm+jghhk2Ts0A77lI6qmkCFkE5+qzfG0p6mRe2vxQCsmFrEuthVqPyeL1z04S4Tu7jDG9uRJi4CWNqPXCbxX216N96+AsgD9tE6IcRKQwRRQmTynGZQbYEN1AaXTfm7x0tPYgsn7vC1pwttt1armQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFvdouQ1D3uITBNPpIPEVe7y2xspVwEu17oeeBLGErU=;
 b=jXH7HSWS6tbJE1R5JFLcO44211r4w1FpOKOOvfoLoEnkauTbib8GuW2rDH5P+s8A7GLnjvkbC6Oh6glXNG66ve5DdDiMwJxTceAsGmNGaquUZX9Jt8IH0Dmomrt5rA8ibk7n6vmggYY3C+9DyKbtVygNdSQYfzh1O3kFL/yD+DTZuiauavXT6DwB/zryhdpn4X7EXf7bZvKj9Cy2l0mfvD9Hq8YUdfXZtihn9gVMEMnssHAuXfGVR7TcRUjVJeMf1N8rK0tEW7VYL9kWGYjbIyfaaFMX8WSA1IA/+54k9gKJjBuyIBLV2QCUWQZEC8w6m4/GBGhIWIpthZj0xYJZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFvdouQ1D3uITBNPpIPEVe7y2xspVwEu17oeeBLGErU=;
 b=faVtiGyfXbSl0ccR5htrlVhvBxdxQPaao2lSqgoCAQnGk2ffit1ik+1ku1NxLEYk4aPTapMuTk4SXyrye2aocjMXVKBC6ABqJI23EfDQvzXmfmlnWNqXuMUj0cSc6BQb4PJWQYOHGe9SF3BFUKIo5UcKjRNJD+pbLB0muDaGCFg=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB5861.apcprd03.prod.outlook.com (2603:1096:820:92::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 09:21:10 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%5]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 09:21:10 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "fshao@chromium.org" <fshao@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?=
	<Johnson.Wang@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: mailbox: Add mediatek,gce-props.yaml
Thread-Topic: [PATCH v3 1/3] dt-bindings: mailbox: Add mediatek,gce-props.yaml
Thread-Index: AQHaSqF1IA9qW0PoQkym//6hgpJgy7DlNW4AgAHwToA=
Date: Tue, 23 Jan 2024 09:21:10 +0000
Message-ID: <22c9f71a7b9e72f0324c297e864cf3ff87e7b640.camel@mediatek.com>
References: <20240119063224.29671-1-jason-jh.lin@mediatek.com>
	 <20240119063224.29671-2-jason-jh.lin@mediatek.com>
	 <CAC=S1ng5v5-LSq6d-R-89N35qiKd7qa8FEo6qakWxrzibYvgSQ@mail.gmail.com>
In-Reply-To: <CAC=S1ng5v5-LSq6d-R-89N35qiKd7qa8FEo6qakWxrzibYvgSQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB5861:EE_
x-ms-office365-filtering-correlation-id: 1641a98d-e9af-4b0e-7136-08dc1bf4a34a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4+P8IKVF1ATqFQicII65tbBgccS7SJ+Iz1PddCIGuW0FjYVkh6NpAL/mXKokGtJhQcRtMF0xRvuujV5hYgYrXPvDvRQlI8Y4T4ivhUkrCeRaYUdKZVGZPHtjEjVifAooRvxaFsHfcgZFw+OOUloIWxtl74isVYganLT2WJ5HN5Hcggq812XSp2cMqvvi65NnPn+2Lg0xk7eSCmZumVHop72PqIYQHfy0dU39O+64WORnk/0yj/HZn+qd0QEVQnZR77m+OToU6oSGApnguvIIsAh0QtzvPP6WWnYPrnImetHphbF/IFQu28EGpao0a77n8iWGoUcKetKsVu3E1Ctct5nYar7W1F1GEF+/bDQKqD2JE5/b6MJhd19h/a0cHVKyysDJVPiIqAzu2s5M1PKXt39hTDJVLNB0IHEBa1MTqY2L8dnVg+mVXUBERyljSDsVvdkxSO+FLCQKLkWEn5/tozmuZR1o9Fv+zUC6mxyKzv5v35StmG//BsfQU1oMM6MCjBxNBxICY4A4YpJPPRxuPnceYmSzvziSE9tta3YaasfwtsvI7641Z2lvyzsseRlrf2IK8ecqowY64hjZ+BNCqslAh8W52u1fGUHOt4k7WVJZguKOrqW8OWRt2P/vW6g9KealMNPkGES+hSDDG8HVgy4IS+mG6/O+iMtiXt+wVdFu63FpUFg4YFh9NpfTlyil
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(26005)(6512007)(6506007)(53546011)(71200400001)(83380400001)(86362001)(36756003)(85182001)(2616005)(38070700009)(38100700002)(15650500001)(7416002)(64756008)(4326008)(5660300002)(41300700001)(66476007)(66946007)(66446008)(66556008)(54906003)(8676002)(122000001)(8936002)(91956017)(6916009)(76116006)(478600001)(316002)(6486002)(2906002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0VHSEJuYXo3bWxjZnJyUW03Njc0azVxT3haRWRzdi9tYTV0T2Z6M2RBN2cw?=
 =?utf-8?B?cEVucmp5MU5MejdNeHgzVklYVGxEV1g3WjFZSHpJV2lQVy8yODRxOXgyYWFj?=
 =?utf-8?B?V1NVa1BZK0lHc2NYR0QvdTFWRkhpL2VjSUJzZDA2YW1pYm5Gem92TjRqZHJH?=
 =?utf-8?B?RkVSRDlsampndzI0enBUYWxIcXc0dVd4b2hsL3JOWG9BMTErUjdvSFYvM0d1?=
 =?utf-8?B?Q0xiTm1RcDk4LzhJdzlxOWlSR3QwOUFwYnd1UjAwRHp5dUJOYXdWT0YwSEZu?=
 =?utf-8?B?QzYxay91TlNlSjVmQnNldXdHUUhEcVNHc1ovVnNueGFLRXlUTUlRR29yMHpN?=
 =?utf-8?B?ck1NS21NaHYwU2VLdXFlbGc5anVDVGtWRHNUb2lKTnJBa3graGFIVWt0TU1y?=
 =?utf-8?B?NWwwek52YndUODBicDFTemhZdEFrZ1cxUWZQVVMwazlpbkMwWkQwUDZTZHFP?=
 =?utf-8?B?RWJCdnk2V2dxakM0cWlBenFVLysrRHVYVk4zUmZrK1VJRGk5OStSYmdPRVZL?=
 =?utf-8?B?MTl0azZQbkZrUFcwY1VkK0NvTVM1ZWE0N2RmVmJ1aENCV2d3eTRYZWk2Y1ll?=
 =?utf-8?B?S3BRZ1ZuZWJsUnYrbFpTK0ZkTlBOanRmdDJsVlRxeEpNcEJGQXh6U1I2dm12?=
 =?utf-8?B?TllBelZBZThlT2d6L0c4eTNoa3ovQTNSTUtUdHplWGpYVnNHR1g2QmZyYVpT?=
 =?utf-8?B?UC91a2ZhWHFvb0hFbURab1VBRXlDd25DaWNMZFZkNTZwTDBhRzZiWnAydDdu?=
 =?utf-8?B?c20wRjZ6emVIUXVUUFlhdVQzTzFsazhsVURMaDV2K1E3Nk83dnQ1YXFMNmNK?=
 =?utf-8?B?aGk3a3hwQ2R2eXhOTUd5MW9neDVnNVBJM2Q2OEVlaW5QeFhkZGtBWSswZHNG?=
 =?utf-8?B?RHVVMmoxamZZbk5lejdmSU9HMWxiMzkrZWhQaHdWaDZQLzcyRmxtejg1Rkov?=
 =?utf-8?B?ZHUrZVNKUHRuN0xjZlNrMjVoTFRnZkRHQVQ5Nnkwek1yaDdJV1A1Q2krWFUw?=
 =?utf-8?B?YU55TTE1TWh3MDRrdDJhRWlGUHlSdk82eFp6aXI1QkRNODlXbVZvZGRibkNK?=
 =?utf-8?B?NDVLNkVLbGMzTmtuam1JbVAxZjBOcTBYQ0ovc0l6VlluRjU3QUNqWVR2eUJy?=
 =?utf-8?B?UkVibVp5R21QbHR1WVRsR2pWWjNTSWpGU2NMaFRwSk91OUZVZU9qWjl5blpM?=
 =?utf-8?B?M1A2eUcramQwa1ZHcytSU0FBQmFkODFrRW1STlZPREdTWGVwOWJ1MktjZXdy?=
 =?utf-8?B?NkpMbTFhaEdpWEx6UHErOVBOQjZjZVB4cDhwTThvcmt0NWZwK29xTjhYSFlH?=
 =?utf-8?B?TXkvditDc2Fmb2tpTE1qTTZxQzJIaUcydmp4TmYzcnM3OTdhRFNsSzJ2Z2x1?=
 =?utf-8?B?Ris1RHAwQWFLMEhxUTRmRGdERGFwLy9tRCtrV0hoZnBtR0lGVVo0REVtQzRj?=
 =?utf-8?B?Yi9CdlFiNDFXZ3BhYkFLbDFxOE1ZRms1WWIxYzNOWThyZi9IWVNPeFkyK2lN?=
 =?utf-8?B?WG03a2g2N0tySTJGM2g4K3FIdEFZTGtXY2dZV3R2L1lQQ2swTXZOd0J0MHdO?=
 =?utf-8?B?V3pieXN0TkJ3L3hBVyt6YnJ1ZTdVRE9lWXlBQUNXeUhFNU5aaGlKaW02SjJo?=
 =?utf-8?B?S3o2U25vZlU3VEVCaE1SdlNpd1Z0UnFCSURYdzhWRkZpZC9YNWVrUFZvS3g4?=
 =?utf-8?B?a205Uy9wRDN1eVV6NmJ6WlN0VjI1VHpSdDBlTUx6VWhveUNtczVVMXBqdm5D?=
 =?utf-8?B?ODhZRy84RWJ4N1ovSnU0TzVYR3VXdVpDRUoxUDRuMVAwUVZTaEZRK0lQd29h?=
 =?utf-8?B?T2QxZzg5RFNqWTlmUXU0TFp1b1RtbGc1OVdmM0hPaThKUmNTL2wxZmc4eTZl?=
 =?utf-8?B?L0g1NDc1VWE4NHhacnVtUUpaWTdwd01veEs1NTc4a05uS2x4TjNZTXJaMUxH?=
 =?utf-8?B?ZmVDL2xxN3hocUErZjhqNlYrMDBlOVlETTFoeEx2S0gzVldUQU1pcmZqSjBI?=
 =?utf-8?B?MzB3SjA5czJIRWZqc3RxUHdraVhKbmo2OVFaaHdrZlpGMWExeVlWVU9DU0kw?=
 =?utf-8?B?OEtEOFBBdWcxL2VtMnMyQ2pZV1BXUnpHRXJxVjNsUngrbkcxd0g4WDI5R0dl?=
 =?utf-8?B?VnhkcmVSY1I5VmppOS9TN1hPRnlyLzQxVlRuVFVMZStXRG5DVW5DaXNVYmlI?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B43CB65328C37049B3DE1F816CFDA554@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1641a98d-e9af-4b0e-7136-08dc1bf4a34a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 09:21:10.5002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRwh1rECuxZ9GVm8wt5uXvr5l6fZp7BHucA5WMqrx9wtiCrbJo+k2LtrEtqjEqnweqDWPzB4bLzo44zF0z6ca6dNTwi3HpMY94qPSFLSiWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5861

SGkgRmVpLA0KDQpUaGFua3MgZm9yIHRoZSBjb3JyZWN0aW9ucy4NCg0KT24gTW9uLCAyMDI0LTAx
LTIyIGF0IDExOjQ0ICswODAwLCBGZWkgU2hhbyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVt
YWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGls
DQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBPbiBG
cmksIEphbiAxOSwgMjAyNCBhdCAyOjMy4oCvUE0gSmFzb24tSkguTGluIDwNCj4gamFzb24tamgu
bGluQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+IEhpIEphc29uLA0KPiANCj4gSnVzdCBmZXcgbml0
cGlja3MgYWJvdXQgdHlwbzoNCj4gPg0KPiA+IEFkZCBtZWRpYXRlayxnY2UtcHJvcHMueWFtbCBm
b3IgY29tbW9uIEdDRSBwcm9wZXJ0aWVzIHRoYXQgaXMgdXNlZA0KPiBmb3INCj4gPiBib3RoIG1h
aWxib3ggcHJvdmlkZXJzIGFuZCBjb25zdW1lcnMuIFdlIHBsYWNlIHRoZSBjb21tb24gcHJvcGVy
dHkNCj4gPiAibWVkaWF0ZWssZ2NlLWV2ZW50cyIgaW4gdGhpcyBiaW5kaW5nIGN1cnJlbnRseS4N
Cj4gPg0KPiA+IFRoZSBwcm9wZXJ0eSAibWVkaWF0ZWssZ2NlLWV2ZW50cyIgaXMgdXNlZCBmb3Ig
R0NFIGV2ZW50IElEDQo+IGNvcnJlc3BvbmRpbmcNCj4gPiB0byBhIGhhcmR3YXJlIGV2ZW50IHNp
Z25hbCBzZW50IGJ5IHRoZSBoYXJkd2FyZSBvciBhIHNvZndhcmUNCj4gZHJpdmVyLg0KPiBzb2Z0
d2FyZQ0KPiANCj4gPiBJZiB0aGUgbWFpbGJveCBwcm92aWRlcnMgb3IgY29uc3VtZXJzIHdhbnQg
dG8gbWFuaXB1bGF0ZSB0aGUgdmFsdWUNCj4gb2YNCj4gPiB0aGUgZXZlbnQgSUQsIHRoZXkgbmVl
ZCB0byBrbm93IHRoZSBzcGVjaWZpYyBldmVudCBJRC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
Li4uL2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLXByb3BzLnlhbWwgIHwgNTINCj4gKysr
KysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKQ0K
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLXByb3BzLnlhbWwNCj4gPg0KPiA+IGRpZmYgLS1naXQN
Cj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxn
Y2UtcHJvcHMueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWls
Ym94L21lZGlhdGVrLGdjZS1wcm9wcy55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
PiBpbmRleCAwMDAwMDAwMDAwMDAuLjY4YjUxOWZmMDg5Zg0KPiA+IC0tLSAvZGV2L251bGwNCj4g
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tZWRpYXRl
ayxnY2UtDQo+IHByb3BzLnlhbWwNCj4gPiBAQCAtMCwwICsxLDUyIEBADQo+ID4gKyMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ICsl
WUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogDQo+IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9z
Y2hlbWFzL21haWxib3gvbWVkaWF0ZWssZ2NlLXByb3BzLnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiAr
dGl0bGU6IE1lZGlhVGVrIEdsb2JhbCBDb21tYW5kIEVuZ2luZSBDb21tb24gUHJvcGVydGVzDQo+
IFByb3BlcnRpZXMNCj4gDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIEhvdWxv
bmcgV2VpIDxob3Vsb25nLndlaUBtZWRpYXRlay5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlv
bjoNCj4gPiArICBUaGUgR2xvYmFsIENvbW1hbmQgRW5naW5lIChHQ0UpIGlzIGFuIGluc3RydWN0
aW9uIGJhc2VkLCBtdWx0aS0NCj4gdGhyZWFkZWQsDQo+ID4gKyAgc2luZ2xlLWNvcmUgY29tbWFu
ZCBkaXNwYXRjaGVyIGZvciBNZWRpYVRlayBoYXJkd2FyZS4gVGhlDQo+IENvbW1hbmQgUXVldWUN
Cj4gPiArICAoQ01EUSkgbWFpbGJveCBkcml2ZXIgaXMgYSBkcml2ZXIgZm9yIEdDRSwgaW1wbGVt
ZW50ZWQgdXNpbmcgdGhlDQo+IExpbnV4DQo+ID4gKyAgbWFpbGJveCBmcmFtZXdvcmsuIEl0IGlz
IHVzZWQgdG8gcmVjZWl2ZSBtZXNzYWdlcyBmcm9tIG1haWxib3gNCj4gY29uc3VtZXJzDQo+ID4g
KyAgYW5kIGNvbmZpZ3VyZSBHQ0UgdG8gZXhlY3V0ZSB0aGUgc3BlY2lmaWVkIGluc3RydWN0aW9u
IHNldCBpbg0KPiB0aGUgbWVzc2FnZS4NCj4gPiArICBXZSB1c2UgbWVkaWF0ZWssZ2NlLW1haWxi
b3gueWFtbCB0byBkZWZpbmUgdGhlIHByb3BlcnRpZXMgZm9yDQo+IENNRFEgbWFpbGJveA0KPiA+
ICsgIGRyaXZlci4gQSBkZXZpY2UgZHJpdmVyIHRoYXQgdXNlcyB0aGUgQ01EUSBkcml2ZXIgdG8g
Y29uZmlndXJlDQo+IGl0cyBoYXJkd2FyZQ0KPiA+ICsgIHJlZ2lzdGVycyBpcyBhIG1haWxib3gg
Y29uc3VtZXIuIFRoZSBtYWlsYm94IGNvbnN1bWVyIGNhbg0KPiByZXF1ZXN0IGEgbWFpbGJveA0K
PiA+ICsgIGNoYW5uZWwgY29ycmVzcG9uZGluZyB0byBhIEdDRSBoYXJkd2FyZSB0aHJlYWQgdG8g
c2VuZCBhDQo+IG1lc3NhZ2UsIHNwZWNpZnlpbmcNCj4gPiArICB0aGF0IHRoZSBHQ0UgdGhyZWFk
IHRvIGNvbmZpZ3VyZSBpdHMgaGFyZHdhcmUuIFRoZSBtYWlsYm94DQo+IHByb3ZpZGVyIGNhbiBh
bHNvDQo+ID4gKyAgcmVzZXJ2ZWQgYSBtYWlsYm94IGNoYW5uZWwgdG8gY29uZmlndXJlIEdDRSBo
YXJkd2FyZSByZWdpc3RlciBieQ0KPiB0aGUgc3BjaWZpYw0KPiBzL3Jlc2VydmVkL3Jlc2VydmUv
DQo+IHMvc3BjaWZpYy9zcGVjaWZpYy8NCj4gDQo+IFJlZ2FyZHMsDQo+IEZlaQ0KPiANCkknbGwg
Zml4IHRoZXNlIHR5cG8gaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KUmVnYXJkcywNCkphc29uLUpI
Lkxpbg0KDQo=

