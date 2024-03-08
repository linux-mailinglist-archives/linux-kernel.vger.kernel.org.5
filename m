Return-Path: <linux-kernel+bounces-96906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4378762F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D181C21136
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3401E55E7B;
	Fri,  8 Mar 2024 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="WnKqQuP+";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="ldV1pwNG"
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [153.96.1.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE12355C15;
	Fri,  8 Mar 2024 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=153.96.1.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896679; cv=fail; b=farc0QMC5ss9xuUCStbF7GurB4ibgjJsDzWoXRoFwRYfQeS1QN5/BXPM11IuStGEMEZmgKAoYagJ3fKLSwKuxdXN0cD2OQ8enaBJSmeMeBocF4qnX6J5X5yiEoH9nxGUKGKMBKMPOZYlLiguCCUE9Clz0SQMsF1HPS9Oahv494I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896679; c=relaxed/simple;
	bh=ENGxLWOPX34Lup8xdNI091rv0zNU3CZU3rEAGcEK6/E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vGFT0qxlhOLfnNHTkHMKtDYY/OkQ3PAvSOGW2QfS+8IYZOMG5pkynpjgfTE5lFLCJr3hWros3Hwz9yg0FZSBYLaQyinB+oPyAKXvtUlr+38ez64UJ3Ju41gNMw0GkEgurpU9Dg0Xe4N10K3mzJue4y5+QiYkXMt/XOoljOVeAuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=WnKqQuP+; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=ldV1pwNG; arc=fail smtp.client-ip=153.96.1.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1709896672; x=1741432672;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ENGxLWOPX34Lup8xdNI091rv0zNU3CZU3rEAGcEK6/E=;
  b=WnKqQuP+tdx5jHFOLLZ4P7HLnH+CzmDY68uTQTZJheF41UrYa4V3qaB1
   PxDVyq4I5kcpbdvZpwpd3ckqa1JkGNOXx0fa0nCc62IykB1IKSLnbHeVF
   MbtzX0ChHezrARhAPB/zi9HQgEU4VPY/350veMsZ3b7DhM+681eOM+Urf
   6GB18mglp9MhAAB79v02lxmnUzyOQho1GkqmC48pTZ76r+jxOPqd6o5jo
   LqCTkd1Y41DUwnVMUs7o09+hSw3Mj4dyPGLFm0Bga8bxJWwofaTqTdcLs
   VsUcAuB/hgNmtYQMFI6ammjMGaaDaHosIiDvKTv0iwQNiAZDoi2lgAhxH
   w==;
X-CSE-ConnectionGUID: jqJnc02oQ6+1HSJROFyiAw==
X-CSE-MsgGUID: xjj/3I89TnuqnhfMhx0qEg==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2E5BAC48upl/xmnZsBaHgEBCxIMQIFEC4I5fIFfhFWDT?=
 =?us-ascii?q?41rLQOcMSqBLIElA1YPAQEBAQEBAQEBBwEBOwkEAQEDAQOEfwKHdyc2Bw4BA?=
 =?us-ascii?q?gEDAQEBAQMCAwEBAQEBAQEBBgEBBgEBAQEBAQYHAoEZhS89DYMQa4ElAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CDShSAQEBAQIBIw8BDQEBNwEPCw4KAgImAgIxJQYOBQIBA?=
 =?us-ascii?q?YJ8AYIrAw4jFAayXXqBMoEBggoBAQaBCD4CDAJDrg4YgSOBHwMGCQGBEC6Da?=
 =?us-ascii?q?oQiGgEFZYlHgk+BFScLA4EGgW8+gmEBAoFBM4NGgmiBQVaDO4EmgkeGL4F1A?=
 =?us-ascii?q?YJfhmOCW4URVH8cA4EFBFoNGxAeNxEQBQ4NAwhuHQIRIjoDBQMEMgoSDAsfB?=
 =?us-ascii?q?VQDQwZJCwMCGgUDAwSBLgUNGgIQGgYMJgMDEkkCEBQDOAMDBgMKMTBVQQxQA?=
 =?us-ascii?q?2cfMgk8DwwaAhsUDSQjAiw+AwkKEAIWAx0WBDARCQsmAyoGOQISDAYGBl0gB?=
 =?us-ascii?q?w8JBCUDCAQDKykDIHURAwQaBwsHcwWCCYE9BBNHEIE0gVuDXYRtDIM2KoF7G?=
 =?us-ascii?q?E8DGSsdQAIBC209NQkLGygBHQKiNwEigT0tTAGBDggBEw4Cc4E5CxECLZJaM?=
 =?us-ascii?q?4JnrzYHgjWBYIwJlSIGDwQvhAWTPDeSNJhcjSVLlRIshSUCBAIEBQIOCIFrD?=
 =?us-ascii?q?oIBMz6DNhJAGQ+OIIN6hRSKZncCOQIHAQoBAQMJgjmEFIIjLYFLAQE?=
IronPort-PHdr: A9a23:JIs9ZR23fLnPfzdmsmDO+QUyDhhOgF2JFhBAs8lvgudUaa3m5JTrZ
 hGBtr1m2UXEWYzL5v4DkefSurDtVT9lg96N5X4YeYFKVxgLhN9QmAolAcWfDlb8IuKsZCs/T
 4xZAURo+3ywLU9PQoPwfVTPpH214zMIXxL5MAt+POPuHYDOys+w0rPXmdXTNitSgz/vTbpuI
 UeNsA/Tu8IK065vMb04xRaMg1caUONQ2W5uORevjg7xtOKR2bMmzSlKoPMm8ZxwFIDBOokoR
 rxRCjsrdls44sHmrzDvZguC7XhPNwdemBodGSXfty7Re4/rlyujqfFAyWqkBpbPa+sKASuEz
 KpybkG1kno1biUA3jr6lZkj6cATqkelqyIm25HyT4KvONp5XZPNZJQdXWpIf9RgZSodWa+zQ
 6g/VuYbANxk8LDho1E3nCOwBxC8GuzoxDRNvXnc7JM0g+ArA1/J81IuPM9UvC3InvX3FYI7Y
 erq4qyU9SnhT/xG4i6hsYLyVBx8p/Guf71Bb/D87EoWSQDslgu6mY/IZW202sYGnjC0y/ZdZ
 /6AhDMnrjFQnzuU6pwwtIKOgYdMyHTvqgUg7d4NdN7tGwZrJN++F51IsDuGcpF7Wd4mXzRws
 T0hmdXu2La+dSkOjZkryBPcYqbbNYaS6w/lVOGfLC0+iH82ML68hhPn6UG70aW8Tci71l9Ws
 zBI2sfBrHED1hHfq4CHR/Jx813n2GOn2Rra9+dEJk45j+zcLZsgyaQ3jZ0drQLIGSqepQ==
X-Talos-CUID: =?us-ascii?q?9a23=3ABz6FN2gucz/84tIITnMl5jW92DJucGT/ynyIeUi?=
 =?us-ascii?q?BVyUwaIa3c3i+6aJNjJ87?=
X-Talos-MUID: 9a23:z2ERVAnE3fGcmskdnDSOdnpyNsUvuIX+WXwLjIwAu8ehNTwoIhqS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,109,1708383600"; 
   d="scan'208";a="9850025"
Received: from mail-mtadd25.fraunhofer.de ([192.102.167.25])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 12:17:40 +0100
X-CSE-ConnectionGUID: +Q9FKCsTTEu6hxALXRkLJw==
X-CSE-MsgGUID: +0a4musDRVGT3kiBOb/qdQ==
IronPort-SDR: 65eaf3d3_darhTcbzF6nDOSwKVEvnf8OWmKPIyV/TS43zRx+7Bkvn4qx
 nxTyRGU2q43fuiFsPUvTYNl646izBe1pY8LMtXQ==
X-IPAS-Result: =?us-ascii?q?A0BSAQAw8upl/3+zYZlaHQEBAQEJARIBBQUBQAkcgRgGA?=
 =?us-ascii?q?QsBgWZSBz43WIEHhFSDTQEBhS2GSQGBdC0DOAGcIoEsgSUDVg8BAwEBAQEBB?=
 =?us-ascii?q?wEBOwkEAQGFBgKHdAInNgcOAQIBAQIBAQEBAwIDAQEBAQEBAQEGAQEFAQEBA?=
 =?us-ascii?q?gEBBgWBChOFbA2GTgEBAQECARIRDwENAQEUIwEPCw4KAgImAgIxBx4GDgUCA?=
 =?us-ascii?q?QEegl4BgisDDiMCAQEQBqZ0AYFAAoooeoEygQGCCgEBBgQEgT4CDAJDrg4Yg?=
 =?us-ascii?q?SOBHwMGCQGBEC4Bg2mEIhoBBWWJR4JPgRUnCwOBBoFvPoJhAQKBQYN5gmiBQ?=
 =?us-ascii?q?VaDO4EmgkeGL4F1AYJfhmOCW4URVH8cA4EFBFoNGxAeNxEQBQ4NAwhuHQIRI?=
 =?us-ascii?q?joDBQMEMgoSDAsfBVQDQwZJCwMCGgUDAwSBLgUNGgIQGgYMJgMDEkkCEBQDO?=
 =?us-ascii?q?AMDBgMKMTBVQQxQA2cfFhwJPA8MGgIbFA0kIwIsPgMJChACFgMdFgQwEQkLJ?=
 =?us-ascii?q?gMqBjkCEgwGBgZdIAcPCQQlAwgEAyspAyB1EQMEGgcLB3MFggmBPQQTRxCBN?=
 =?us-ascii?q?IFbg12EbQyDNiqBexhPAxkrHUACAQttPTUJCxsoAR0CojcBIoE9LUwBgQ4IA?=
 =?us-ascii?q?RMOAnOBOQsRAi2SWjOCZ682B4I1gWCMCZUiBg8EL4QFkzw3kjSYXI0lS5USL?=
 =?us-ascii?q?IUlAgQCBAUCDgEBBoFrDieBWTM+gzYSPQMZD44gg3qFFIpmRDMCOQIHAQoBA?=
 =?us-ascii?q?QMJgjmEFIIjLYFKAQE?=
IronPort-PHdr: A9a23:+TbxMhbeJzVygfDw2tlifxb/LTFg0YqcDmcuAucPlecXIeyqqo75N
 QnE5fw30QGaFY6O8f9Agvrbv+f6VGgJ8ZuN4xVgOJAZWQUMlMMWmAItGoiCD0j6J+TtdCs0A
 IJJU1o2t2ruKkVRFc3iYEeI53Oo5CMUGhLxOBAwIeLwG4XIiN+w2fz38JrWMGAqzDroT6l1K
 UeapBnc5PILi4lvIbpj7xbSuXJHdqF36TFDIlSPkhDgo/uh5JMx1gV1lrcf+tRbUKL8LZR9a
 IcdISQtM2kz68CujhTFQQaVz1c3UmgdkUktYUDP7ETgc42qjQDfrvBY2HCFJvDnDo4PAg2Et
 JkzVznLhT4haWMjrVOOkfVe149E9UHExVR1lorYXtiNK9xRfZnRXdQ5dXpYGcFJVyVgELKOa
 ddUI+UtHtYBo5PAnWdRlAe6DzCdPO3t0y9WiXj41qgB1c4QLw+W2AYyQd0h7nr3sY/5bbsgc
 eKU6YD4x2rtaq9uxRXd55jza0x4q8uqUe92cejzxngxLS7gjWzOqqX9YRml1clX7UmXzeFND
 c2Ll1MVty5+/ziq9uYRibLl3Z4rwRfD8Hx75K1qBYSVEHYqYov3WIsVtjudMZNxWN9nWWxzp
 SImn6UPooXoFMBr4JEuxhqabuCOX6TSv1TtTu+MJzd/in9/Pr6y1F6+8kmln/X1TdL8kE1Lo
 SxMjsTWuzgT2gbS5MmKRro1/kqo1TuVkQGGwu9eKF0yla3VJoRnxbg1l5EJtl/EEDOwk0Lz5
 JI=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:wZH+/asZItLPzAnxfnT9SOFT7skDeNV00zEX/kB9WHVpm6uj5q
 STdZUgpHrJYVkqNE3I9eruBEDiewK/yXcW2+ks1N6ZNWGM0gaVxedZg7cKqAeQeBEWmNQ96Y
 57fOx7EtO1DVUSt7ec3DWF
X-Talos-CUID: 9a23:wodyiW/YfaWgmoF3+RyVvw0tS+4GWWbh8FrNfU+oIEJZcr6xa0DFrQ==
X-Talos-MUID: 9a23:rQ61VwjafdAU3LGT1OawnMMpd59hv6GzE2w3r7o64MqFHwt6fC6RtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,109,1708383600"; 
   d="scan'208";a="201376654"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaDD25.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 12:17:38 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 8 Mar 2024 12:17:38 +0100
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.169)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Fri, 8 Mar 2024 12:17:38 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X55k9C1cEFzx3Wf7EONx51cpeBrPyGH2Z+hfFvnz8RjZuMecEXhsci5rZgJppxaLIHQtdpyIqOlD3tzBw2OycHflEOhbLOY0Pi0dmUI/CKNYlBGX9rNNFY12HUHJ2hX2cFfK2ratnmk8nIlLMWYBKvCoH18EPP1tUd5gPZSapCEKCMqV/7yXHoeRUHGVCCbdXoKOzRjSd0u1Jq4xap+tDKDzTC+ffH7O6gRa7iBZZsncsx0Y3fHAYOIN3Rxu4yQ1c16sPbjVoZDElV4klCEP8n15GIIt+0+JSWsztERlcmZfhCkk14hwZdLcBQ3FCxsGq0IBEZiBHGCzWksMQ6/ydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEr3WCMprMh1wsUy+VS3QN3V0wNKeqN65r5Z1sQF3Ew=;
 b=fSS4MHIFU5MXTszs0+gTLTMFie2bvYOiZYHx4wEBtpySiyGXTHUxUpN+RgXe5T81d6IOLVLyASiGhQiroToeDs23pY4Xm6AUPc3I05dGnFytEfWISJeVAeTZTzqYa6qEOwg1ra3bMPYNi5gnZLkS5/4Fmb6Sb1Hlitb8iyJ0z9XPFhTB0nnfjnB5Py1csnDs6mWGpP9lb4kBhKNRvw5xOJJ5NWz0GUUyChHEQNiXGGwiqHBzThxCETFwkEu2Pi1C5By1SsyAekYSqSxgxDh3UxswEEPqQC9/KTvMDASowi1TCXPc7eDPvuYR9A0PJytVxpm6FU+RFX8Qiz/i5sKOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEr3WCMprMh1wsUy+VS3QN3V0wNKeqN65r5Z1sQF3Ew=;
 b=ldV1pwNGkRdHoKXxq/ophaIzYZn43DgDKX1drURT7QtlbQYPfjqxvgofcmSnBYVf8lbz6gG6fKu2d1tZHjIMAXb7Fm4PtJHgxSq41bRNd5nhJJgYvREMkQ6kAp6BXkE26IdJcE0GLtUZtGg5hmXIUkSD3tVc/om1jLC7H1E0P9k=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by BEYP281MB3992.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 11:17:37 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::47c2:f246:3fed:4e38]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::47c2:f246:3fed:4e38%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 11:17:37 +0000
Message-ID: <7113988d-3408-43b3-881e-1308c0904f2d@aisec.fraunhofer.de>
Date: Fri, 8 Mar 2024 12:17:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipvs: allow netlink configuration from non-initial user
 namespace
Content-Language: en-US
To: Julian Anastasov <ja@ssi.bg>
CC: Simon Horman <horms@verge.net.au>, <gyroidos@aisec.fraunhofer.de>, Pablo
 Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<lvs-devel@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <linux-kernel@vger.kernel.org>
References: <20240307203107.63815-1-michael.weiss@aisec.fraunhofer.de>
 <e1c8e477-ae59-48de-4aa8-e6df09013831@ssi.bg>
From: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
In-Reply-To: <e1c8e477-ae59-48de-4aa8-e6df09013831@ssi.bg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::19) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|BEYP281MB3992:EE_
X-MS-Office365-Filtering-Correlation-Id: 8846f207-125e-43be-bfc6-08dc3f615c33
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3Qw5rJ5hyGYhmnLIN4hiE28K2EslI+kNSQAZEkj3Y8tIHpXh0+/w0wWIboSyJjzN+/1L9TRX/wTntiN5Fbvvzjw7td0iLpnRqDEWpo0Xlb2ksc3ewRy5nI8K7ci3EBG7iTiU9V2bUgPGknjrGKy+y2/y75BDcF01Y/+Eabc6SnRL+tfMm+Myzhnll1rBZbS8DQ/kzLdtFPKASdIxOdyJqmTBqu9Q0G9mEkPt/s3xPuK4b4ht31Uv0kM5q2a9kT/JsawV0cw1ZpRXW6EVGV8JD0zDwKPDXF22FNOKn26QjcZsXaweDE1VI60RnuX36mIr8cnD0kGcpyMaNBS+JjTryBk2E6kFwqiYuFLXFoaKcau5iNqp7+e5cDZkm8LOGjhueKs1fAvf4WT868Zt7yj5ZxFzatJNS3uXR8Vft+JrWfCCfu8yE55bdVPIZ6hoHvdh/Ik+leoPFnAiRD7I2LmnNX211BI9mkr4pZcyyoKCcgQEgm0XkERnJsSj0i9GhUb2NbfJv3FcthMuO/tX70Fz4CO8DMmCZVxWDKkgszd9QT+FnLsP7QxReVeulUafk4mUXuUgJ5c0LgJCVgAcwdxT0ea5cwByTLTTmUQeH+Qt2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnZNVXhwTmgwekxPR1FweWtuc083a0Q0bnJqakVTZzlqeVd6V2tZSUFkWVdQ?=
 =?utf-8?B?NVgvaFlHZmFLbHI5Q1BOQkI0dWpPVCtzVHRlODBaWk82b0R3WDlZMXA1NERr?=
 =?utf-8?B?K0lyOHQvY3Q5TjhTWWM4YnA5VGJCenpZMm5mZHZqNThKbGZQZ3ZyeE0yTVB3?=
 =?utf-8?B?SjVaYUdPdGJiSUE2VGdVS0hURVo3TGxsQ1E4RVBYRFVxVWhaMmwxdEEvVkxC?=
 =?utf-8?B?ZTlXSlMzaHMzU3pzemtzSk13THIwN2FEV0RBdTc1OS8wYjhRbENFRC9VdVo1?=
 =?utf-8?B?K1VzMkw0bGszWkx4VEJSS1hkZ2x3VTlPbWR3MmxVcGxSUHhML0hyOGVUVzhV?=
 =?utf-8?B?SmE1K3VocWdhOW02d254cVMwS1ZrdlUvK3RVdU5UNGlhQnNXUXBoZUlQU28v?=
 =?utf-8?B?QlJUWEF2Q1o4bDlvSDBtdk91VEdBWmZhejlzWHMvN05FSjJSQTJyUHNiTFZV?=
 =?utf-8?B?OU5aNHBYa3lsK1lmeUMwNElIWGNycVhSRjh0QWg1WWJRWHBZY2N1WThlaUNv?=
 =?utf-8?B?cHk2QnJLV2FJb1Z1OFI5NklMT2VBOTRYZFByQzdMcEthMXMraExHSTdGS2NJ?=
 =?utf-8?B?dytrL1FIM2ZRbUlhNEVDdW9yRmZxM2krdzk5QkYyd052aENHZXBwdVlCdk9K?=
 =?utf-8?B?ak9Oc3FWN0wzS29LcjR1Zkg5NWg5SlZsWlhyYkdobU1MVTdXL3puNk5razB0?=
 =?utf-8?B?VVhZdFRmT3BmU1BqcWFsV0lIc0lWaHZucnBvN2V5NEZhNndLYmV4ZEpYbit0?=
 =?utf-8?B?bmVWWmxKM2tPcWpZUXBMaUV0Tll5Vno2SFpsTGRRems3dmpDaTdvRVpKTk9u?=
 =?utf-8?B?TUdzanlZZ3hqQXhFZnpZdkFMMUVmYkFqY0VVcWlYaFk2a2RLVzYvQzBMWXlJ?=
 =?utf-8?B?Rk1XVHlQb3lrZUZ3eDhWRnM1S3NVOXM3Rlc1dzhkbHR1VnlydUtZaVJrODQ1?=
 =?utf-8?B?NDFyZVNEcWc4V0lOWkwvNFA3RTZHZ2lsbTl4RFZMTmNhMDU5dXBrS1RkSXAx?=
 =?utf-8?B?S2FFL3drSjAyc1FrNGZzMEt0TFc5OHlPYjBqbVFiZEtkZEwwMXllV29mRXFy?=
 =?utf-8?B?VmVKY0QwVDZ6c1o3Q2RGVEZtM2RCeWJuYXZ4M2tIL3NQamM4ZmJnTmVTdnZr?=
 =?utf-8?B?a3VwU1NtNkVYK3RtUlQ4ZTBReS9hWmZBd1ZoWWVHbFMvblh2VWJoUGtnVXNL?=
 =?utf-8?B?emVIZnlDTnc3dFArZTQ0bE1ITmpXSGtOQmlaUGVuZ2RvcndKUktTR1RveG5m?=
 =?utf-8?B?WlBBM3hmdVVvSGV3VFc4N2k3VWdZZFlFVVZocjNOejJwcGl0M2pVSzRCSXVP?=
 =?utf-8?B?bThtY08ycmRuYWRDRUZvK0FvOXlCM3FtNUhqVjdNSS9xZFR3Qi9ILytTZ3h3?=
 =?utf-8?B?elFBMUVVVDJPM3phVGw3MG9wcFNEdjhGL0pJUU84cTAxYnlBaVIzMVFaWnJS?=
 =?utf-8?B?bHoxYnZNbXdaUGF6SC82Z1Fxb2N5MEpiOUF5V3dMMmhnait6SWhLYUVyUVYr?=
 =?utf-8?B?YWtLZHhib0dYTjMwcGNrRVlCSTZET2wya0lLOGt2Zm9PUnUzSXZyb1dvVnBk?=
 =?utf-8?B?RXVZQ21FNHdkb0VQcTRScHRvaGpZZGh5c3d2dTVJcnMxSWhSQjUxWi94MUV5?=
 =?utf-8?B?dnA3MlVaRGVPWVZEYXdxQXR1cTFWQzRjQW1GSlJLTmViUnU3QWpZWlVKMm5V?=
 =?utf-8?B?SUxvb2lmdFYrSFdveG9OTjFxMDRVdkJzSjZ3elN2d0piRlEzaGZOZlVJTUI3?=
 =?utf-8?B?TEVHMGJZUllQK0VnT001bjBMK0E3eW1WSGR0OEd6Vm9mazBpUjhKbGU0Z1N5?=
 =?utf-8?B?SWp3SzhLWlhyb2hKbENURlQ5aDN3TitEUlRGSTFnV2dvdUtjdjVLaHRZREdC?=
 =?utf-8?B?ejhJQ1ppclgvRjVTNXVlc0NwcWlzaGg1MGJQM21PcXUxSCtKd09lUklONWMx?=
 =?utf-8?B?N1lhcFFacTNjVnJuMDJOY0dtU0s2R1FOVS9na1VtMjlyVXhFNXdONE9zUXVY?=
 =?utf-8?B?M1hoT3lBZTFEcURTbUhlNWYwOFIxdVRKdURXcXFuNzZTRFl0VFU1ZFIvQzFu?=
 =?utf-8?B?S1pDZEU2QUp2TUdZbnhBa2RKVGhOYmNLcjVSSzFpWjFncEZkNjE4OHlKMXV3?=
 =?utf-8?B?YnlCd2pBYWZsa0lUekd4M2xxQk5MRHBzQ2dyMEdaVTh5bXBVUXdjWnFkVHdq?=
 =?utf-8?B?Tm1qd3VOeFNzWVZsMityRlZkL0RwZ0dQSEF6RkdRcnV3SFd5engzUFZZMlRk?=
 =?utf-8?Q?+KwaPha4ELyF9GwNxbPSBvWE9mWYnY4vbYYJvCIpj0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8846f207-125e-43be-bfc6-08dc3f615c33
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 11:17:37.3090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHGDFgR9oGSf4lrLEMX6h73DDkD13q3ifqsL3LEq+/MlTaq8DuWHaEq7QyQgKdJqkuUs8HNn81i2K9dKnvKRBlmTKbMMuozmfykFkzZaSlOGQWo8umx8x1Xx/u/ZMuKb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB3992
X-OriginatorOrg: aisec.fraunhofer.de

On 3/8/24 08:55, Julian Anastasov wrote:
> 
> 	Hello,
> 
> On Thu, 7 Mar 2024, Michael Weiß wrote:
> 
>> Configuring ipvs in a non-initial user namespace using the genl
>> netlink interface, e.g., by 'ipvsadm' is currently resulting in an
>> '-EPERM'. This is due to the use of GENL_ADMIN_PERM flag in
>> 'ip_vs_ctl.c'.
>>
>> Similarly to other genl interfaces, we switch to the use of
>> GENL_UNS_ADMIN_PERM flag which allows connection from non-initial
>> user namespace. Thus, it would be feasible to configure ipvs using
>> the genl interface also from within an unprivileged system container.
>>
>> Since adding of new services and new dests are triggered from
>> userspace, accounting for the corresponding memory allocations in
>> ip_vs_new_dest() and ip_vs_add_service() is activated.
>>
>> We tested this by simply running some samples from "man ipvsadm"
>> within an unprivileged user namespaced system container in GyroidOS.
>> Further, we successfully passed an adapted version of the ipvs
>> selftest in 'tools/testing/selftests/netfilter/ipvs.sh' using
>> preliminary created network namespaces from unprivileged GyroidOS
>> containers.
> 
> 	I planned such change but as followup patchset to other
> work which converts many structures to be per-netns.
> 
> 	There is a RFC v2 patchset for reference:
> 
> https://archive.linuxvirtualserver.org/html/lvs-devel/2023-12/index.html
> 
> 	My goal was to isolate the different namespaces as much as
> possible: different structures, different kthreads, etc. with the
> goal to reduce the security risks of giving power to unprivileged roots.
> Such isolation should help when namespaces are served from different CPUs.
> 
> 	May be I should push fresh v3 soon, so that we can later use
> GFP_KERNEL_ACCOUNT not only for services and dests but also
> for allocations by schedulers, estimators, etc. The access to
> sysctl vars should be enabled too, around comment
> "Don't export sysctls to unprivileged users",
> alloc_percpu => alloc_percpu_gfp(,GFP_KERNEL_ACCOUNT),
> SLAB_ACCOUNT for kmem_cache_create, not sure about __GFP_NOWARN and
> __GFP_NORETRY usage too.
> 
> 	Not sure about the sysctl vars: now they are cloned from
> init_net, do we give full access for writing, some can be privileged,
> etc.

Oh yes your right that I have missed. I think non-global per-netns
sysctls should be save to be allowed for unprivileged roots.
sysfs can only be mounted rw in a new private netns. Just unsharing the
userns which then does not own the netns, means that sysfs can only be
mounted read-only or the already mounted sysfs gets the overflow uids.

> 
> 	I didn't push such changes yet because I'm not sure what
> is needed: looks like, for now, what was needed is root from init_net to 
> control rules in different netns and there was no demand from the 
> virtualization world to extend this. If we can clearly define what is 
> good and what is bad from security perspective, we can go with such 
> changes after pushing the above patchset, i.e. the GENL_UNS_ADMIN_PERM
> change should follow all other changes.

Just to clarify the need to control ipvs from within non-init userns:
In GyroidOS, we have only a minimal ramdisk-based system containing a
container manager in the initial namespace. A first "core" container is
already running in an unprivileged user namespace with a private netns.
This container gets all physical network devices moved into its netns
and is responsible for routing and all other networking features,
ovs, batman, l2tp, etc... and also ipvs.
	
Nevertheless, it makes sense to wait for your changes to be merged first.

Thanx,
Michael


> 
>> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
>> ---
>>  net/netfilter/ipvs/ip_vs_ctl.c | 36 +++++++++++++++++-----------------
>>  1 file changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
>> index 143a341bbc0a..d39120c64207 100644
>> --- a/net/netfilter/ipvs/ip_vs_ctl.c
>> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
>> @@ -1080,7 +1080,7 @@ ip_vs_new_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest)
>>  			return -EINVAL;
>>  	}
>>  
>> -	dest = kzalloc(sizeof(struct ip_vs_dest), GFP_KERNEL);
>> +	dest = kzalloc(sizeof(struct ip_vs_dest), GFP_KERNEL_ACCOUNT);
>>  	if (dest == NULL)
>>  		return -ENOMEM;
>>  
>> @@ -1421,7 +1421,7 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
>>  		ret_hooks = ret;
>>  	}
>>  
>> -	svc = kzalloc(sizeof(struct ip_vs_service), GFP_KERNEL);
>> +	svc = kzalloc(sizeof(struct ip_vs_service), GFP_KERNEL_ACCOUNT);
>>  	if (svc == NULL) {
>>  		IP_VS_DBG(1, "%s(): no memory\n", __func__);
>>  		ret = -ENOMEM;
>> @@ -4139,98 +4139,98 @@ static const struct genl_small_ops ip_vs_genl_ops[] = {
>>  	{
>>  		.cmd	= IPVS_CMD_NEW_SERVICE,
>>  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>> -		.flags	= GENL_ADMIN_PERM,
>> +		.flags	= GENL_UNS_ADMIN_PERM,
>>  		.doit	= ip_vs_genl_set_cmd,
> ...
> 
> Regards
> 
> --
> Julian Anastasov <ja@ssi.bg>

