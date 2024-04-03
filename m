Return-Path: <linux-kernel+bounces-129365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F25896985
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9B11C25EED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E716F069;
	Wed,  3 Apr 2024 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f2/sLnGl";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Xe7ipVMz"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497185C61A;
	Wed,  3 Apr 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134215; cv=fail; b=VOhY73+2hsY/S4Ibh0BzB5rTR54CDo6Lphj3tZ/r7672ImkwUyg8y/Ou2UtvcZmjkPywwgDMYTnrhTMMoO+32wTa7/4B2/U2BR7aaQxTfHm7YRLmD1GY6LBvwLwEULgf01i1rLlsjapy5837NsJ+XbUzVteiun4Ex8tplQp65QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134215; c=relaxed/simple;
	bh=l83XbpilaO7RDtxKihMifzCNM9u9JWd7343L/Rx8xAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gCKVHNcRJTxgyRxwoRAG4YTmlNrMRyEOBZfBhS+/0xyHQEbB+jt5nz+xaRo5NN9d4ckPDDu+ZAPYtAbZ9PNFqmIeaJHyEF6Hoffs+4dV0eu4cqzply7UEAx8agTdQaaHFBx4B/Cqv4SPu1d9pXYMlp/I1IDnmT8AP8CDnkZA+tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f2/sLnGl; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Xe7ipVMz; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2aff863af19711eeb8927bc1f75efef4-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=l83XbpilaO7RDtxKihMifzCNM9u9JWd7343L/Rx8xAQ=;
	b=f2/sLnGl7jhCSsGvoURqV/MKjJxktCnY2iLAyEIL4f890jupqSbOaEaD618Ahin0VFcCPp3j2l+C6KEDF6XlvPmqOajR0bgX3yODO2TdWU4Vk7oGUw4ASh0PyzMf7e1Noij6kCT9bTgq7nVVK9Z35aydsZBP+HC6RKH2xfUx50w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:ba81024a-8e47-43ea-9d36-575ce100e499,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:268e2b91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2aff863af19711eeb8927bc1f75efef4-20240403
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <yi-de.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1857856586; Wed, 03 Apr 2024 16:50:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 01:50:04 -0700
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 16:50:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExexlvfLPOquqcVGQB65BvrO+YorKpgj1QiqZMtxptlIeZp5CAI5J8IErVxIwZshgQG4qdJsHQBd3s53KX/TIB6+VnJHTulykQOUwcpwFST6XkwmlwfcoyTtvTee+BIYFHHOqjqp7SflVLyQOEJTZkCACwlnPR1Rz5fSknEq8UrMJihEQm87H8fXmaiBbp6OQ5y38IZlEkZyKo5EZRm3msWEOZxGrqZ5V+aFVcc5CoHtMLRJMDR8kOxvzIk5BCxydB979ruKl2xdxg6Jf72KDFJt2u2NYE9gbrHJkYcrKHHh0p++oN7X/Yukcx7gvXaMqv3A/vP8IXO8bS9Ux4zW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l83XbpilaO7RDtxKihMifzCNM9u9JWd7343L/Rx8xAQ=;
 b=mckNBylhcvcEyHOTqtSfavSPbO3/Cijrdr+PtkZmCSM7Aqv1AB1pSxPzKe6iTs5S//PYBLSfd/VOIp7m7xzK/lztzM/LEnnuEiGR93crSiYjERvR1KMJou0yt6OEKf+vj60GRlBf7XQQ1DbTt5pSc5k4f9/txKYlmA7CHUfidOJlzORkfvH0sVXt0u0uOPQe8rLC33zBsaJnPdr/7eefGT2HJfvCy7kKftTUeNze0RKH5acMZ+oLaJz4Aidc8NdD7MFa9jCFCb7AU59E/Wc3JgzRvxjUM3b9n4QHt8WFWgZXbzdlWHYwswD4UQyMNn2iMwt8G3AuDT7ndzIARgPbJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l83XbpilaO7RDtxKihMifzCNM9u9JWd7343L/Rx8xAQ=;
 b=Xe7ipVMz4HFHZAK1rqT+b0Ppsadt622lUHIkKXoqgF52rp+BvGqvB6XIbBqztqwHQozyiNJOWZmzAtB2rDlQkri6Kt7UlsVl4k/ea69b9D/dYVJilIBCTBe3HF9bn4az8q1qPlv8MVE1r9UDX3MzXuuBlSnQ9CIDsZnCcqvUnv8=
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com (2603:1096:4:14f::8) by
 SG2PR03MB6780.apcprd03.prod.outlook.com (2603:1096:4:1dc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 3 Apr 2024 08:50:01 +0000
Received: from SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::ac1f:8f3c:20e0:bfd]) by SI2PR03MB6167.apcprd03.prod.outlook.com
 ([fe80::ac1f:8f3c:20e0:bfd%2]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 08:50:00 +0000
From: =?utf-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>
To: "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, =?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?=
	<Yingshiuan.Pan@mediatek.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?=
	<Ze-yu.Wang@mediatek.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "will@kernel.org"
	<will@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"quic_tsoni@quicinc.com" <quic_tsoni@quicinc.com>,
	=?utf-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
	=?utf-8?B?S2V2ZW5ueSBIc2llaCAo6Kyd5a6c6Iq4KQ==?=
	<Kevenny.Hsieh@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?=
	<PeiLun.Suei@mediatek.com>, =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?=
	<Liju-clr.Chen@mediatek.com>, "dbrazdil@google.com" <dbrazdil@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, =?utf-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?=
	<shawn.hsiao@mediatek.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, =?utf-8?B?Q2hpLXNoZW4gWWVoICjokYnlpYfou5Ip?=
	<Chi-shen.Yeh@mediatek.com>
Subject: Re: [PATCH v9 07/21] virt: geniezone: Add vm capability check
Thread-Topic: [PATCH v9 07/21] virt: geniezone: Add vm capability check
Thread-Index: AQHaUo3wML57vgqVI0qXjsE4FXoM2bD1QU0AgGFhaIA=
Date: Wed, 3 Apr 2024 08:50:00 +0000
Message-ID: <27258baa96e7ff3701ee56e86dd649756da2c70c.camel@mediatek.com>
References: <20240129083302.26044-1-yi-de.wu@mediatek.com>
	 <20240129083302.26044-8-yi-de.wu@mediatek.com>
	 <c027bf67-e9b2-4eb2-9dee-a47a9c3bdd8a@collabora.com>
In-Reply-To: <c027bf67-e9b2-4eb2-9dee-a47a9c3bdd8a@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6167:EE_|SG2PR03MB6780:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZrW7NwbhwpB+q4M/OwJUMkygwUnRpQwUZwllaHtHV4TwC4esrGMGoDaE3yLKugrSnqpHscux6slcz4wE33IOQEKCBSqdIdKrn2cCp8ins2UhJBcI9qLHUy68nglPnLQp5d2HTCgduicCr9fJyaKMC89GUzDT9bGZccPCSPrR1/oX+Nzl2YDC81Gbk0o+igV6oySAezfNYh0XlMeh5jDHS6irkX+vg6LZX7rcXSkSCskP6r2vXFoNerbJ/JrD+ZWjfMEYgmHe4RYrUnMd3RQpfsc4F2T9O4cHV9P0CvN+OvBzIMO8fW6VDa4A6F8G62HHh+/oMmHgcPAyazYkIhMnX/zDu6++xrb9ivhc7MwUOp74ViMUDfFRjwfIFthRX4oV/yDD2ZZDYF3zSJ9U2KAWdLhkFTbvgu/wNaxfHrKlkgMiWUIKfQWtyJsmtcZ5n5+cxnWIQwOGGtPwsXnFjRusvG6N9PxaLW58/r3EhPeRXkiCqNRXYqF0ZaLObn53D36krgSGBxMsOyRSG1UG4UXNvwfX9oIqYmD5Yt/hrq4H/rs27Rje4xp2n6DkA0LqRmxNxy9oyZpPz4MUt5bsI6lUWv+CuXpMPTVBglEYdZIM23lUnaKEGeFRo6nu4nE+Iv3sK/q87/nM2NbaZTJWfwc+FQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6167.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?andNbjZTaGo3UEFlRmdpK0dRNVVoUC90eFM5dTBDcmh3SjhOZ1ZBM1BaV21i?=
 =?utf-8?B?dGUwVWo5aUFvWXAyZUpaRENpcFJKdWlZc1lMTCt2djcvaENQQ2pJQzJ0aFlQ?=
 =?utf-8?B?UndVY2hWdUJHSklJdnppeWJ0dFpxRTV5RSs1WUhJS1E4TU40QXZMc0piUHk5?=
 =?utf-8?B?V3M1NlIwZzhJS250cWFVZ3FDczg5emtwQ1FzRXprTFhSYWdJZTBwUEdGbmlK?=
 =?utf-8?B?Z0tWa3huYkx6NTY5TlZPTTU1dk5zV3pMK25vSFFKejlGQkFYUU5nejRBN1Rs?=
 =?utf-8?B?d1lva0k4T1UraDZPd2JlTUNzejRqR1B4ZGwxY29RcnR6UStNV1REOEU3MHhQ?=
 =?utf-8?B?UmVuV2pLdVBFZFRvV0VCNWJPaHZZaFI3UWUxUlhPdlRBSHY1TWhkWWljNnNQ?=
 =?utf-8?B?d0lqK3cvR2VHRWJ4OGdZc2pIM3gwQ0lMb3o4eTB1ek5USkhDVjRMSkJFS2FC?=
 =?utf-8?B?R0FLOEo4QUh2V0NPb25CdDFGSFhraHZ1czg4NDdqbUt3cDRPVjcxUGNod3hj?=
 =?utf-8?B?L3RENm9YK0V2SjluUG1UQmZ3RVJZNHd5dHBTZGtGUUZTTmgrN09UZWNhL0hP?=
 =?utf-8?B?TDhJNW9pVHlQMlRnZTlueWRXSEIzSUFzY0o3YmRRdm9lYXBJMG0vclhxQkxV?=
 =?utf-8?B?dEl0RUNxQTFaOTQ4bFRUNWw3QzBFOTRGT3dWeFpEVFNhZTJOcFlLdkhIanF5?=
 =?utf-8?B?VGs2VkJ2TGVMR0ZHVkx0M1plKzhEZlZMUHUwR29tUnBHeEtJejBKdm9QWmlp?=
 =?utf-8?B?WnVhQmlqTTZZeHFCTm9Sa3B6cExyRDRudDRUL3pQUmQ2QVVtWStsREJRWkkz?=
 =?utf-8?B?SytyZkE3ZmIxL2JLbkF1aTc1aDByQm50d2dRcVBlbCtBb2tKZHJxLzRiZkNq?=
 =?utf-8?B?OVNrT0JuWXprZ0NMRmV2VnB0cUg3Z2EzeWpaM2dqVDFuRnhsbjNKVE9OTWV5?=
 =?utf-8?B?QXR2UWp5ZHZ3MytHRkR5TGMxWE9BbnhaYndvV2lwN1h5akFYcWJScVFXWTI3?=
 =?utf-8?B?Z3ZURVZtT1lsMlFmZVhNNnFpM1pIbFRsQS9sajJDdEtSS25GM2xsSUxieWk5?=
 =?utf-8?B?TDhNK2wvMWFMZ09WWU5HWXR5ay9iQUJrTTRPYzFaWXlXU3A3QjVKWFFGdzBW?=
 =?utf-8?B?bHdOZ3VUc0xwT01pTlgySlpBeEd4RnBTZjdvVjdiV0g2Zm9kTkRvWGoxQTE1?=
 =?utf-8?B?UTArRDlVN3phY0ZsYUpWSWxsQVp3Z0lEVEo1cTg2Qk5xbS9kTFdhaFFoczdF?=
 =?utf-8?B?NXlnS0lBcXYzZ3FqdUc5M2I5MThOYnpTWENRVk4zUW0yNUFxQmY1SWMrdGxW?=
 =?utf-8?B?N2VnNGdxTFJCTE5pM2ExNFliUmJZKzJTZERHbUszWnYyVnIvNytqMFF5aE55?=
 =?utf-8?B?QUVnYk1VVVd2eDl5YU9QMXF3bVkySXVvbUlLRU41MlZSbS9TUjVwNlorTHJZ?=
 =?utf-8?B?VjM1MEN0MEpHRmhYMWNQeUVESmZuRWFKdGtWYXFxMFdMdWpRcEJqYnNJclZm?=
 =?utf-8?B?Vkl2UlFzcEJ1TWVFVXhKNE1Tc2RCQnl6QktYNmZ0UU1uWExtSnNqTE9SNUZs?=
 =?utf-8?B?NjdUNmlxbThlSXRESFRieG1peXJXcllXdVZQcExMUzJpMlJpSzBMUHJkY3JS?=
 =?utf-8?B?SHBZUEZpVVZnRVM1cDYycllnSU5SNnlXeXA1eXhpZE5sb2FMZFZzdVJKTFRa?=
 =?utf-8?B?YW1OTVhxWjFKZ0taK3BYZW1XTjkrbGc5R2pBenRxRmsvNnRKWExEQTl2eWFJ?=
 =?utf-8?B?dGtENnY1NjI3RzM2M3A4cjFYeWZPc0pRZFNmUVIrTzZwaVRMWE02YUw1SThp?=
 =?utf-8?B?QVRmZUhwcjVVVkJ6L3hYakg0K0tTSGFiQTlseEhPcGtZNXdLcUwvMlpCRDNL?=
 =?utf-8?B?SGNQeGw1WnRSbm00aE9mSmxDTmtmZFRwcTdmWWtyU1dGNVpLVVF5K1J0ZUIr?=
 =?utf-8?B?QnYvQm1DRlJtdHd4NExNamxpZlp3alRpWHQ5eVA2MHUxUUpOdU5sTXFzeFpQ?=
 =?utf-8?B?cWtBV3RxUm1MN2l0R3VFWHNhaWZ5cUpxSmhib1dqQTNNL1pJbTRsMmJKM1hn?=
 =?utf-8?B?WEkvSCsrVWxRajZlNjJCc0Z4dm00TUlEeHB0Z0pIM3hGL2NTeUpnRDVMeVMx?=
 =?utf-8?Q?kOoIZGwRjk5Jtz5eGWDmLTL8R?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21CF535108F59E4F8B9A122D67025100@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6167.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef1e59f-1539-4bda-e67a-08dc53bb0bd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 08:50:00.2266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrUaGzYJ1iHoS78uW+WfsXrZ+3YfvUgPI9IGyCYb9mG2B8jgCd1RFnH9rhfUnndawaBPiDhJv9sRumQyZlAZcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6780

T24gVGh1LCAyMDI0LTAyLTAxIGF0IDEwOjQ0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjkvMDEvMjQgMDk6MzIsIFlpLURlIFd1IGhhIHNjcml0dG86DQo+
ID4gRnJvbTogIllpbmdzaGl1YW4gUGFuIiA8eWluZ3NoaXVhbi5wYW5AbWVkaWF0ZWsuY29tPg0K
PiA+IA0KPiA+IElucXVpcmUgdGhlIGBjYXBhYmlsaXR5IHN1cHBvcnRgIG9uIEdlbmllWm9uZSBo
eXBlcnZpc29yLg0KPiA+IEV4YW1wbGU6DQo+ID4gYEdaVk1fQ0FQX1BST1RFQ1RFRF9WTWAgb3Ig
YEdaVk1fQ0FQX1ZNX0dQQV9TSVpFYC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZaW5nc2hp
dWFuIFBhbiA8eWluZ3NoaXVhbi5wYW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEplcnJ5IFdhbmcgPHplLXl1LndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IGtldmVubnkgaHNpZWggPGtldmVubnkuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IExpanUgQ2hlbiA8bGlqdS1jbHIuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogWWktRGUgV3UgPHlpLWRlLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IGFyY2gvYXJtNjQvZ2VuaWV6b25lL2d6dm1fYXJjaF9jb21tb24uaCB8ICAgMiArDQo+ID4gICBh
cmNoL2FybTY0L2dlbmllem9uZS92bS5jICAgICAgICAgICAgICAgfCAxMjINCj4gPiArKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgIGRyaXZlcnMvdmlydC9nZW5pZXpvbmUvZ3p2bV9tYWlu
LmMgICAgICB8ICAyNyArKysrKysNCj4gPiAgIGRyaXZlcnMvdmlydC9nZW5pZXpvbmUvZ3p2bV92
bS5jICAgICAgICB8ICAyMSArKysrDQo+ID4gICBpbmNsdWRlL2xpbnV4L2d6dm1fZHJ2LmggICAg
ICAgICAgICAgICAgfCAgIDUgKw0KPiA+ICAgaW5jbHVkZS91YXBpL2xpbnV4L2d6dm0uaCAgICAg
ICAgICAgICAgIHwgIDMxICsrKysrKw0KPiA+ICAgNiBmaWxlcyBjaGFuZ2VkLCAyMDggaW5zZXJ0
aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2dlbmllem9uZS9nenZt
X2FyY2hfY29tbW9uLmgNCj4gPiBiL2FyY2gvYXJtNjQvZ2VuaWV6b25lL2d6dm1fYXJjaF9jb21t
b24uaA0KPiA+IGluZGV4IDJmNjZlNDk2ZGZhZS4uMzgzYWYwODI5ZjExIDEwMDY0NA0KPiA+IC0t
LSBhL2FyY2gvYXJtNjQvZ2VuaWV6b25lL2d6dm1fYXJjaF9jb21tb24uaA0KPiA+ICsrKyBiL2Fy
Y2gvYXJtNjQvZ2VuaWV6b25lL2d6dm1fYXJjaF9jb21tb24uaA0KPiA+IEBAIC0xMyw2ICsxMyw3
IEBAIGVudW0gew0KPiA+ICAgCUdaVk1fRlVOQ19ERVNUUk9ZX1ZNID0gMSwNCj4gPiAgIAlHWlZN
X0ZVTkNfU0VUX01FTVJFR0lPTiA9IDQsDQo+ID4gICAJR1pWTV9GVU5DX1BST0JFID0gMTIsDQo+
ID4gKwlHWlZNX0ZVTkNfRU5BQkxFX0NBUCA9IDEzLA0KPiANCj4gR1pWTV9GVU5DX1BST0JFICA9
IDEyLA0KPiBHWlZNX0ZVTkNfRU5BQkxFX0NBUCwNCj4gDQoNCkdpdmVuIHRoYXQgdGhpcyBpcyBh
biBBUEkgZnJvbSB0aGUga2VybmVsIHRvIHRoZSBoeXBlcnZpc29yLCBpdCBtYXkgYmUNCnV0aWxp
emVkIHdpdGggdmFyaW91cyB0b29sY2hhaW5zLiBPdXIgaW50ZW50aW9uIGlzIHRvIGV4cGxpY2l0
bHkgYXNzaWduDQp2YWx1ZXMgdG8gcHJldmVudCBhbnkgdW5leHBlY3RlZCBjb21waWxlciBiZWhh
dmlvci4gRm9yIGZ1cnRoZXINCmRldGFpbHMsIHdlJ2QgbGlrZSB0byByZWZlciB0byB0aGUgZGlz
Y3Vzc2lvbiBiZWxvdy4NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjAwMzE4MTI1
MDAzLkdBMjcyNzA5NEBrcm9haC5jb20vDQoNCj4gPiAgIAlOUl9HWlZNX0ZVTkMsDQo+ID4gICB9
Ow0KPiA+ICAgDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo=

