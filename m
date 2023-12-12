Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6478280EE51
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376430AbjLLOFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376403AbjLLOFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:05:30 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8D9AD;
        Tue, 12 Dec 2023 06:05:36 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCBXBL2008693;
        Tue, 12 Dec 2023 06:05:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
        from:to:cc:subject:date:message-id:content-type
        :content-transfer-encoding:mime-version; s=pfptdkimsnps; bh=DSDN
        lR4UL4ZhIe31gOo6aT/tv2YuLewQ4WOMf0cMQhM=; b=rYzCVMiwPuOGT7fY/l03
        f6PEDBGggBXlQxlC2ArLdnmqBZDPmakwh6CAh18h2+gYZYtmeen7OzuPGhogUuKr
        mf9FZHE3miBUke+YqaqR2AmgGe+B20whL8J1Ug3Td5uDw25Gp9/K5sE3wocHm88g
        oTvbwqyDXE9yi0VrrxcCjMnsNZQZpRfIQQr5cQ+v7RjEs2jZz5IFZgDSuCaH/1jU
        HJCku2ihRqEP1xZ+DXx8hdZKNRUqueO0x4Oze/h8IuNKsofnMLzSUW2gs3Wx1ozk
        BdBdIltBSQGlRiRqlsbjNz/KQHuyS+OeaXGLaHCN9v0J+jRRvgXwFoN2oiFdWo/V
        pQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3uxnywryff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 06:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1702389913; bh=+edNPP4PDan3iLNDiSrCt9kyKyvXQ5wR3CAMXtokd/s=;
        h=From:To:CC:Subject:Date:From;
        b=JYU5+Rhx5cCzvTdGtxdImDIpmxoesHI37wgiEgyxR13bH9YjoUp0sX3nSonBEk+Ua
         PHW8l9Q6LjyAPYbzzN1qNvZrksCLChS0TSHaQ6SJeUsFjbvrYdVSsIaxbgL5aCx9SZ
         t/FPbovbNUq3nb89Eb1S4gTxPXxw5gF2C3aDSYDAhMClczJQJ06O3VtVftkBHDuX31
         BYEqJcbfUqkMknRX1RdPG/flvO3dzMTWygTkmOaSVZoWfi9xkahW++IAV6EXmin/Gc
         0XkzZ9Mliu8+mdqlYzZJFvsZs0T0nIRRuJsGiMZ4tx2WwH7szB48FEvNVIkDAQgutA
         q9YDCFnsukeKg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8777C4035F;
        Tue, 12 Dec 2023 14:05:12 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B1DF8A026A;
        Tue, 12 Dec 2023 14:05:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=pbBR8nGn;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 677B44041D;
        Tue, 12 Dec 2023 14:05:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCH8gEKMu15FwaDBK/hVP3g/FWNvEmwi5oiseBQZWSWdZ7jisw4z+2ZyKEyUN89ka1v00o8kSYYdxWbL2RqqvvxHsgdTRkbkauBcnBGojhEZlsZAxT1Ooaxcy5d39nM7I5gMMCHyQZxRXmvsKTOJGPhg12UcsngbuqQB1kHLoQnqZc+VrsR66Uhot/oYWjIbEHL8X3GBKqeuwDDJ4213Ps1I9ZnAd3hjXy1qL2TIpCfdDnMVkll8E66Q8VUu6f3VlMt93ng1pqSRpol/z4kJveDyQcjKd/pSU76UTMOP0Yhr05GtKCmoy38GVUoLhKae/nYQxJGfPywg9FpVSsCMdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSDNlR4UL4ZhIe31gOo6aT/tv2YuLewQ4WOMf0cMQhM=;
 b=aMACrqJv6c/uApGtf4alqgUIrnLCwQ6ZrTi7r/8puj3zvOaHlCWQduXb79BUGVkxQgW7r0x14dHeaVxX/JUHBJcUhELHTjgDH1OKUxEwc6MmpDehboGhxnfR3IvHp6TII/GuWRy7E8FVQto2NHksDu5MUbHEJdvTzkcoSGfeyh0WCCp1c8f+jt6uj+BqbmUFVw76JJ4dTVoRGRN8MRSRK6ApwgHKJuSb1cApayIAh3FpFG+HkXq8nhO8pke2ZR6TA82+pddM0D8SBHWrIGeq5t6PZDd141gQVUzk3A5teIWGdLWYq+ybPgKTs5mhF1CCsjZGgDuunrvGS/Il6WXWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSDNlR4UL4ZhIe31gOo6aT/tv2YuLewQ4WOMf0cMQhM=;
 b=pbBR8nGneUCOfwgEGdgkyeg/wJ0vDcj5R2ne6tXkb0yPTPDAQhies1inbRHbU8U7boFimtU3IYbofYSsG3VPqOm9HHS3EuspeG0jjDXOwq9KsCJdhNgLzZE7bIk9EgWrfi/rYu9z8E/Uj0CuycsDxzhw2/Iinc9eX/+6wiN2YoA=
Received: from CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) by
 PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.30; Tue, 12 Dec
 2023 14:05:02 +0000
Received: from CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a]) by CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a%3]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 14:05:02 +0000
X-SNPS-Relay: synopsys.com
From:   Jianheng Zhang <Jianheng.Zhang@synopsys.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
CC:     "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net-next] net: stmmac: xgmac3+: add FPE handshaking support
Thread-Topic: [PATCH v2 net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Thread-Index: Ados1ZhSVt+NBU4hQ6SxQlhk3wznGQ==
Date:   Tue, 12 Dec 2023 14:05:02 +0000
Message-ID: <CY5PR12MB63727C24923AE855CFF0D425BF8EA@CY5PR12MB6372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6372:EE_|PH7PR12MB5830:EE_
x-ms-office365-filtering-correlation-id: e7b44c4b-804d-4431-6d60-08dbfb1b55ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w6VSGZUOYROA3un0jzc4ToeBd2AK/M6bQUn9OqqzZNbLcFPQ23YFzLzsGC0+1d+Np1YHAvdN3dlQ/kjlS+qmIMm5OOOcwezK5CofEgv2cwUt6tVZeUDpmSsKvQAmpwC7FPl19wKoF6f7n2LHXo6S0Z6FQIqw5X+jQoiy3lCqewM/Q4CFLwbBnmg4LFNDnPTc1GW7Oew/Yg9TiH9XbrKFoLDA1FBr+7nAh86QTV16QnzpfCn0g8AsTblxK0AeDRibnS1N0QFx7W9FfePGdmJJmsS3oRAKEdA+Ldao3nGmvPBvu2irm0Pd7FQam00P4FWkQHRO3AvRmrTogqHje32j9NHe1LiWgjWZfg257rAEAJCN9kU8s3Pu1LMxUlzvDPleG8GqkMUF2bg77EVf7rSWHcRiP/7FZC5Xugbg2ofhymtv6Y/TyU4pMduG9309wwm+IKk+bWLZ+uJBQkA9zNhKAmD5nf8A93MxsqGy/HA/eD7afOu9UnDXUj5rz3lTUrkSoGlH/u1UceZbXLladmrzO0FN3pLc1M1cCx0gm0II1SIUoFoAqRHj0iHEDxY6Z7UYfnfoPV7nhrCU13lDUnWDQ/8qQLNZY+p7CCl3np2cFOY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6372.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(55016003)(45080400002)(7696005)(6506007)(966005)(26005)(71200400001)(478600001)(9686003)(38070700009)(38100700002)(33656002)(86362001)(2906002)(64756008)(66446008)(5660300002)(6636002)(66476007)(66946007)(66556008)(54906003)(41300700001)(83380400001)(7416002)(122000001)(76116006)(8676002)(52536014)(8936002)(316002)(110136005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GA48veQb395WPAEVmIDRa3SG0u577nqbn+WNcutkZ957LtDeHTrmc4wTCTXN?=
 =?us-ascii?Q?DTPFpMk+8Eeh1KDpJyllR+clSDBizFrL2skkv7AX6Y1yB/YsGBM+VvPPdilg?=
 =?us-ascii?Q?gyiLBMSDCxRMtkaWHvQPZQwJIC7xc+xuibMzA8eGLbugMDR+8IG7kjnAKIb+?=
 =?us-ascii?Q?QLqvf4kjwFgb+QosOLwR0vyYbD1bwRfkRuPtLZnTiVR7I8vHcuXxI4aqgUoG?=
 =?us-ascii?Q?ol5rkp5GLWCM6JBAh7xjrTvRlpkOhj4m/b9fwUPPcKWGYVQKSWZNTt5xIjd5?=
 =?us-ascii?Q?FrT7HQpeHTp93DW6vDnGyFtPV1XV1RXbVliC7RieCA9BEvm4y9KbQ0dXnGX+?=
 =?us-ascii?Q?D6nH27xT4fvk65SzfzmHw6gRMKU1rwDz8AXvbOJQk2bj8cwtmBr6xmkrj46I?=
 =?us-ascii?Q?E91D8c599se2rEneh3d2ba8jBi13QgpKa4b/WVfyr8ocH7aiuTUm2ZMv2kW3?=
 =?us-ascii?Q?pQPvKblXUGuxAkvIMjId87O2IesK5BlsJN7i+6zyRyGwIiL5BiFwjHeRNoIE?=
 =?us-ascii?Q?n1YrdIBTZkyLWvqGXTvrDaJTFqvfYoygblojOQh/T2RKhRzsKR7PSbdWBLeI?=
 =?us-ascii?Q?QI7/15Bpbn/lLmQu9LiTLMQWzNq1v0ksi0HYma0LVvVH4e+GqAOZ5teUMhz0?=
 =?us-ascii?Q?nPltpvIYcc8CW6mF0A2dxu+wXJWdaTEAj7AjdSd3V0EORn8LMHsZvJ2yREXn?=
 =?us-ascii?Q?jRDjTt7xZsIcuMAKMgTbdhbulNT+OjoBOjXUaDZ1mJr10eeiMUsll4IwjTjo?=
 =?us-ascii?Q?Ov6NysQEvqbNfFrPFdu8Tp2fFGsWn/wQB11+OkrGgHeJsKgKcO0AH+L/UpMK?=
 =?us-ascii?Q?3VpTUJiMEnki0WoXzVdQH+cvUaNwP5iY4MV0D/dS1EQUc9Va1E31rjITEmMW?=
 =?us-ascii?Q?ZoDSm2djVeuAY3VTP35+8QBvdeUgfK2TNw3BypsOqXsLpdLDaPPzZzp5EZX3?=
 =?us-ascii?Q?juxdy3P0u+eg7tp/YypWMUS/2o3md7FnxZTyb5sPjhbgMwb9S2vdrO54OnBr?=
 =?us-ascii?Q?Rb9v+/BUabKJgQVDs5Eu2MD2tA/DUdBrE/gHWNfLmSf8v7nkB9lDfVXEFA23?=
 =?us-ascii?Q?jeT+9FyjygkKM7XhmU/wrwgPdi8fl6LHJg8GMs9DIW2/znaFKlt0P9s9Vwpy?=
 =?us-ascii?Q?38KU5m6Qir8TvLWiEB07rv4VDKhmgUGQwKRefo1TAJf2slI6QpPHb4Cp26Hz?=
 =?us-ascii?Q?p551JiuqU9v1RcO8p0LN0vqbRt5vswUG/HK+sZkECRU2L0hSTvgZWkjXKGXT?=
 =?us-ascii?Q?Rwmv3xyUVpt5A5CGVTV3fbXg3YVIPM5pJ6EEM6bKU4orEMdyN59FAKAle/ml?=
 =?us-ascii?Q?Dm2oUUwN91QG84Z2DdL2eDEdE8jH1kHyf4bTCWU0S8jNSzi8+tb5PLcOeMGr?=
 =?us-ascii?Q?8qY6oxf2RSF4ZuJOSEkSScfuMGx6aOkgc2fGhotrcihyePDVom4AmGy/BZB5?=
 =?us-ascii?Q?kEKP2TL4VP4lFeC7+89u0dCBa5IxJI/Jsy3XEmUClXrCq7LfavZojCsuH5K7?=
 =?us-ascii?Q?/yM2Yz1tjL/tpKy7VuKdovPxfImGz8TPrx32cLaJNKdlxQXWuXshXRV374l4?=
 =?us-ascii?Q?01FtD/V0Pwx6Gz+t/UO0MZOAn2hR03FFAynvUHDS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yOdnKihKy8s2lPzk6/jPLmfNajTm/iS4PtmZwpvnUhEkime2GmYX+/fSj2Qz?=
 =?us-ascii?Q?eaxGLRqZDzim6ukT7bhq6WFQz0WU1KquaKY/3xaKNKn5jhfGcwymOrWUdMxS?=
 =?us-ascii?Q?fkafa/+g7xNPQZ3wZaZs3dV3ScrG/o/MYlsKzxmqY98aQqrrAHMqGlY+JPhS?=
 =?us-ascii?Q?fmqnL/36Zc28J70pY7TxE4P851bIvIpYW+nmF/iQenBjOXWU/xmr6kiy5UoT?=
 =?us-ascii?Q?E6fncP8c8NWhJ9y7ly/heSUwxgKd5vTRVtQglbFNwgA72pzTdP9TEIqOCT1b?=
 =?us-ascii?Q?ovuG1TLlePxkH+NSTHTvROWjuiZfprLd8iK2VPpYfz8gVb17nQKy4EBvA1rd?=
 =?us-ascii?Q?pld7v+95j+z3t/jllLIZqtHQ/9fT/4ZhsPOKJP7/20m3y8ZH4rm0h2sFbIYi?=
 =?us-ascii?Q?tGYpJzqvpiSCgv7Vvb1+B1DMedCqQLOwmvt6CcdI1BoWwR5A4XXQnTv8ppUe?=
 =?us-ascii?Q?4kFBm0aPWeUk1RQTppGYx307GNcuPrAVUZ2RzLYJRnIXkdjPYzuK2qzzJLcz?=
 =?us-ascii?Q?4fnwoOCUgGZAYW2Ypd7qGI3CptF/ymniq9WHL8TASCOkoOgpDXw7+Glv6bEl?=
 =?us-ascii?Q?hLj/Hx3cn3Avlhac5JHhjQVZk6qG6BzPuyucAXJ1nD6ucspj8B0g3/+8tOgT?=
 =?us-ascii?Q?CWhstyDfEOsrqHGkjxzZeh8+5XfUWRZGnOUJzEYuuT600WUI5wWbEsDR7Vfv?=
 =?us-ascii?Q?RQDzFL2vSxBZiCEkb8ALZROp3BlGmoJTCC0sTRx76Sgf5dW38QtQQWKmriIA?=
 =?us-ascii?Q?74CN9v+Z5U9BxHe7tSQpEI2aazZac/dTnVicSCXlSynQLLd/dODfAV1wvKRg?=
 =?us-ascii?Q?37NMnbzaclX/SWBVrqoiX/gNFEDmW92Pboiki95jTNfwcFreO8LPW/eirdGo?=
 =?us-ascii?Q?rmDn6Vi9ojgMtd5mQaI2LiWKguZrq+n4fodQNq/pBWBi8NQCtWbKD8aP7fJa?=
 =?us-ascii?Q?u0o1MFnokwUXXU+s1DEYLqzPx3rOB/c1G/qRYwXDVoHq0f1BxfflDJ7jSvdR?=
 =?us-ascii?Q?1dEMsnSv8qWyU7y9/pS+zJvh4Di0MHkg//7Y2osZYU0WpUKCWsdgFLMcfuRG?=
 =?us-ascii?Q?YIYBYqypFzUR6NJSiA86b2Qan1sU5Wt7MvD6urzu4T3vx7EU223r3K0Gupby?=
 =?us-ascii?Q?sHDjXbXi2TfU?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b44c4b-804d-4431-6d60-08dbfb1b55ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 14:05:02.2970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECAC/5HvXGvLymdI+6qXQ71ndjXw1WH6a4RQFqvRtFKi/Lysv5QjCCj3P5Cxy8sl/VpSgk4B1edTy+S6xoPNZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830
X-Proofpoint-GUID: vbIPtudyTfoQU1wdbE1WtrcT_aC2giC0
X-Proofpoint-ORIG-GUID: vbIPtudyTfoQU1wdbE1WtrcT_aC2giC0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312120107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the HW specific support for Frame Preemption handshaking on XGMAC3+
cores.

Signed-off-by: Jianheng Zhang <Jianheng.Zhang@synopsys.com>
---
v2:
  - updating the FPE debug message to use netdev_dbg()
v1: https://lore.kernel.org/all/CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5P=
R12MB6372.namprd12.prod.outlook.com/
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  6 ++
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    | 66 ++++++++++++++++++=
----
 2 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/e=
thernet/stmicro/stmmac/dwxgmac2.h
index 207ff17..306d15b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -194,6 +194,12 @@
 #define XGMAC_MDIO_DATA			0x00000204
 #define XGMAC_MDIO_C22P			0x00000220
 #define XGMAC_FPE_CTRL_STS		0x00000280
+#define XGMAC_TRSP			BIT(19)
+#define XGMAC_TVER			BIT(18)
+#define XGMAC_RRSP			BIT(17)
+#define XGMAC_RVER			BIT(16)
+#define XGMAC_SRSP			BIT(2)
+#define XGMAC_SVER			BIT(1)
 #define XGMAC_EFPE			BIT(0)
 #define XGMAC_ADDRx_HIGH(x)		(0x00000300 + (x) * 0x8)
 #define XGMAC_ADDR_MAX			32
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/=
net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index eb48211..2f14f9b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1439,22 +1439,64 @@ static void dwxgmac3_fpe_configure(void __iomem *io=
addr, struct stmmac_fpe_cfg *
 {
 	u32 value;
=20
-	if (!enable) {
-		value =3D readl(ioaddr + XGMAC_FPE_CTRL_STS);
+	if (enable) {
+		cfg->fpe_csr =3D XGMAC_EFPE;
+		value =3D readl(ioaddr + XGMAC_RXQ_CTRL1);
+		value &=3D ~XGMAC_RQ;
+		value |=3D (num_rxq - 1) << XGMAC_RQ_SHIFT;
+		writel(value, ioaddr + XGMAC_RXQ_CTRL1);
+	} else {
+		cfg->fpe_csr =3D 0;
+	}
+	writel(cfg->fpe_csr, ioaddr + XGMAC_FPE_CTRL_STS);
+}
=20
-		value &=3D ~XGMAC_EFPE;
+static int dwxgmac3_fpe_irq_status(void __iomem *ioaddr, struct net_device=
 *dev)
+{
+	u32 value;
+	int status;
=20
-		writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
-		return;
+	status =3D FPE_EVENT_UNKNOWN;
+
+	/* Reads from the XGMAC_FPE_CTRL_STS register should only be performed
+	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
+	 */
+	value =3D readl(ioaddr + XGMAC_FPE_CTRL_STS);
+
+	if (value & XGMAC_TRSP) {
+		status |=3D FPE_EVENT_TRSP;
+		netdev_dbg(dev, "FPE: Respond mPacket is transmitted\n");
 	}
=20
-	value =3D readl(ioaddr + XGMAC_RXQ_CTRL1);
-	value &=3D ~XGMAC_RQ;
-	value |=3D (num_rxq - 1) << XGMAC_RQ_SHIFT;
-	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
+	if (value & XGMAC_TVER) {
+		status |=3D FPE_EVENT_TVER;
+		netdev_dbg(dev, "FPE: Verify mPacket is transmitted\n");
+	}
+
+	if (value & XGMAC_RRSP) {
+		status |=3D FPE_EVENT_RRSP;
+		netdev_dbg(dev, "FPE: Respond mPacket is received\n");
+	}
+
+	if (value & XGMAC_RVER) {
+		status |=3D FPE_EVENT_RVER;
+		netdev_dbg(dev, "FPE: Verify mPacket is received\n");
+	}
+
+	return status;
+}
+
+static void dwxgmac3_fpe_send_mpacket(void __iomem *ioaddr,
+				      struct stmmac_fpe_cfg *cfg,
+				      enum stmmac_mpacket_type type)
+{
+	u32 value =3D cfg->fpe_csr;
+
+	if (type =3D=3D MPACKET_VERIFY)
+		value |=3D XGMAC_SVER;
+	else if (type =3D=3D MPACKET_RESPONSE)
+		value |=3D XGMAC_SRSP;
=20
-	value =3D readl(ioaddr + XGMAC_FPE_CTRL_STS);
-	value |=3D XGMAC_EFPE;
 	writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
 }
=20
@@ -1503,6 +1545,8 @@ static void dwxgmac3_fpe_configure(void __iomem *ioad=
dr, struct stmmac_fpe_cfg *
 	.config_l4_filter =3D dwxgmac2_config_l4_filter,
 	.set_arp_offload =3D dwxgmac2_set_arp_offload,
 	.fpe_configure =3D dwxgmac3_fpe_configure,
+	.fpe_send_mpacket =3D dwxgmac3_fpe_send_mpacket,
+	.fpe_irq_status =3D dwxgmac3_fpe_irq_status,
 };
=20
 static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
--=20
1.8.3.1

