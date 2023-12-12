Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD7A80E4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345825AbjLLHXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjLLHW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:22:58 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F15AA6;
        Mon, 11 Dec 2023 23:23:04 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC75E8t029112;
        Mon, 11 Dec 2023 23:22:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        pfptdkimsnps; bh=gJGrunbi4GEqOjA/EsULo3yrVOeYlbR0TVHRvEJB2GM=; b=
        TpSCjfk81i5dhnTnHT2LuCKGwCFf1DPhpNi0oZFGzV/baBFYCvCr1qG/Uj6PujNh
        z/L2IENCMt9ybY5Cd5O9ms1jxD9AiHOJMuCxov2Xcwt4dqdUffIPh3EchCQMsiH6
        5YvwOxVw4HaYg7dbC/D8kY6MjRfkrGBbRX7tHdAuE2qzHFk8+aDRoeIuVkaYg/zZ
        4xBB3/st0mMVWlsBwolbgWVQw39OjQBfnwa3woxkhaXDxl4ahVlB62uA0NDCTtAd
        dk8ht6hmp8DcpGowlaheivkeCxZYbYWOeRmGGR0Vh+Mgj02NDtpgcC7Q26RA09TG
        VfzMfmhRL9zKds67V1yC9Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3uxcr3snf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 23:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1702365753; bh=p+ofkRLe3HyTmO/ar4icTmFzcgrEi2492iV1WvvfI5g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ALa3kIVhQFjxs4GSrVMWaO3Srmfi0IJ9s7EG+UEdo0ayOTCdEY5TB5ej+qQBiWg99
         2E48/Cnz6ERPgJUIoakWW1ICpb3HXP77UTE5x6h94nL2bYv0hteiBFF3NtW7XPzqHh
         3FERtYi9N8ZaBuH7jYmzdpmf+bSufzWLuaIztzEff/+PHCGnJn9MeLS1r895GkDTah
         Dt3kifTE7H2hbm/nQtLuEFb3lluydGp+vVCEe+OOvx4dMhM1MeJsKOf9uaLOXPMMWw
         rOi5uY5UMFBi6jcASETUgGGK+Rmxcn3fqO3jIEhiV8xAOivGu+8Io/YN+7CirWIZPN
         hcRpd4g/o1hNQ==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D67CA40141;
        Tue, 12 Dec 2023 07:22:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EF7CEA0257;
        Tue, 12 Dec 2023 07:22:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ONBk8PJf;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2A0CD401C8;
        Tue, 12 Dec 2023 07:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLkLpAe/2nlf29reQ43T/xvuG5mteZvcZaftNnVq7WjrIZQqAwo6VlM4i1u0qhwDEtIlQYbmTmUhef0RlmzHc4COv9fbYD4+bMf1PJvYIu4z32BoBvldtxBCZ9E5uLHUFfS5FouhdQGggFLjbEIgJ6U+tTymALe2i3pQxutD7etL1EUDIgqdDSTITWt6usPyF6qH9oO/vwQH4nliGqAB5EnanE3e3sKkjVVXksjFAnPm2Ji0gFjPPzdBasQgzGki2F3PeE4sTlUMLk7hp9oUZrry5SBC7bfyWLqU7Ar42lhXOe7QNrGLIU7qHNfc8z2U0Lb/XLT5EDq7Pq5Yd2mEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJGrunbi4GEqOjA/EsULo3yrVOeYlbR0TVHRvEJB2GM=;
 b=IIJKmDK2gOAji9mrJHOyz/6qCjhXnXEmOatOFyjEZLomnQyq0yc1IE2yKuPH8SnVYDFr4UnNk3dclsEb3e7rWcYVsh+EqBCw6RI5+1GElIM4BH/0hXTKnQRqfHGlJWknOiUUrgiEkU6Rqq3zAK0yDlzGfO2IUIhWoC45TM4SNwfNZ4BZ0hPv0F//UXeYP7BaOOEUjn0D+4JjRMHmw5OwViuIv0ZXoeX1cZ/YWjJEKWIC3lbtaNsHyP0FqI7F3/FRtXX+NKRf9OZCSULzfUxKDC1Fb7otQ1Rn+UIP2B4cWjNf921FE/lel3XpuXu9DyrA+ZEFDRVZscjhsBbRbkrFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJGrunbi4GEqOjA/EsULo3yrVOeYlbR0TVHRvEJB2GM=;
 b=ONBk8PJfdimGl4qeQZPp7C4MNgHV1tnLCwyfeVTklclg1Gs1GgIDhBSgbp/HuEpSPyIttj4vqXiIOwDf2ij8iOr7VqLQenI4StHqCZsD2mQFy8Z6lSNR0wM9FiRxws+75MTZZcwMogOCzMomPINHQA929qAv5AqzlWoLy2yYLag=
Received: from CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) by
 PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 07:22:25 +0000
Received: from CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a]) by CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a%3]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 07:22:24 +0000
X-SNPS-Relay: synopsys.com
From:   Jianheng Zhang <Jianheng.Zhang@synopsys.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
Subject: RE: [PATCH net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Thread-Topic: [PATCH net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Thread-Index: Ador+H1+Z6wgRV0bTDW+VJMmnuYc6QAdKJ0AABefjtA=
Date:   Tue, 12 Dec 2023 07:22:24 +0000
Message-ID: <CY5PR12MB6372C8770900AFF821325400BF8EA@CY5PR12MB6372.namprd12.prod.outlook.com>
References: <CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <d202770a-3a3a-4ee2-b0de-b86e2f3e83ce@lunn.ch>
In-Reply-To: <d202770a-3a3a-4ee2-b0de-b86e2f3e83ce@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6372:EE_|PH7PR12MB6905:EE_
x-ms-office365-filtering-correlation-id: 5a9284b9-ca2f-4a4d-ba56-08dbfae31670
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: egff/26Qtfs6jWEeAq96bqnapUOJfcIo/cLh5n1x/7CdG2mq3liYHkLVVRBKuaninqfYjL8xg+LcgdmirVYN0nfXZPa4KKTMd7yP6Xs9Q5yKR1p3I5vadg+ZVluiUB1JqmKo2RF/f2yq7jzfFT5JNwSzEj0Far0cAL5m4jzprdUonWebT7vomm5s6jXrz8W8KrsV8h17RHe2OpkEsLBbODckH7Hnax4wxRF4TGtb6d5gC1d1lFsCJIoEK9g+6F/vamoU1oZZ+/YX9/tyYCriAHuns2+tNVwmuOBQfCbnSgoMtwt7ZZbboGGEdPqjk/n1Zevg53uJUY4MVhFRO4ulaeiRgsiVdZmLQUNHIFhSBMolSrt53jYcnoDcYD8DYY9yc0I4gRQD+D6pPKgvnCu00WIf6/CLhuQvXQT1prT3oqi3ql8Jnd+6Y+iN1dCTrQwEaJKQxxXDh3jhjB1XhPRRdpyL1SJZBU1ipZhxLrWVN1i2UL6vMw9NvNcRKdHqT0Ohy/BuymQ2SHtN5fOV0DwMPOlM0SKcmavll3a49Q3aIyCeA2b+9FScSfewC6DppO1PsH9Jjt17PEGKiGzwGuNQWQfpmlY3Fnrmr/j7FBoTZcG29EDXKeZg9i4dqVEwerU6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6372.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(6506007)(7696005)(107886003)(9686003)(122000001)(5660300002)(8676002)(4326008)(52536014)(8936002)(41300700001)(7416002)(4744005)(2906002)(71200400001)(478600001)(38100700002)(316002)(6916009)(66556008)(54906003)(64756008)(66446008)(66476007)(66946007)(76116006)(33656002)(86362001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cOQ0FOXLoJ41cPNUp2P2X6K5ajH5YlzrtSlXqGKQIS1IxPnrOtePXf2rtKaG?=
 =?us-ascii?Q?xw560AR6u0C5WfPKnMMSixISwBoJAYGgvTTNgDMTTXmEWRggiIQLiiWbP41o?=
 =?us-ascii?Q?MOWJDYMONu//i21VIyuud+NK3RHJhAkKaVkpwbCY/4i84bSsKibRGpHQsok4?=
 =?us-ascii?Q?G23Jp+HkZctpavbsuaAfCO6VXPvgzUMEiXq2dZKor9idKKdGao6mEdL9IDBu?=
 =?us-ascii?Q?d2pb6BdIKzZNWBxre8YbgFvwpaqZ4FfluAtzdwo2xnR7tAYOY0gs+HFLWynE?=
 =?us-ascii?Q?DdKRiIdLmGMIJOgVu6cbRiegSSWWbLtGMlGjARYpKlc5iWckVlkw+TFHqmZv?=
 =?us-ascii?Q?Xo1JSzQrM4w3L2wAHkIO/HQfPdOpV4TOGqQZApDoOrzD/X2YldeItlM+mUoz?=
 =?us-ascii?Q?pJfq+v0difQKR5nxf3GQp/u9GUOsCSyUM+1wQ45I0VVyZPKVamhxQPgfyqey?=
 =?us-ascii?Q?2bYbv1B7d0GHZPoEX5MdNecdp+AQrNktkg4VPh8l4Gv048D0hMVa7ykDtehK?=
 =?us-ascii?Q?kwXBrWAtKB4Z+8Hqjw7RFvOtgTdqnqmvA4eEgwgj3MTAgLRD7RHP17vjih6d?=
 =?us-ascii?Q?r8Ggenbu6lUDB9uao8WeK/exRiXkaiGoEP3qgNGS/T7nnF7CicJy/I0ySgf7?=
 =?us-ascii?Q?I5HG0f2q/6/FO0W+4HbUoc6BeKq5l5JOczHu8YvGEOxSpc+UvFwLod1mFjRl?=
 =?us-ascii?Q?G4XDRnrd3m7LBu3RapHK3OENbkkJqNWeizidEAoQ1VcRtCsA9fbbV9grIyaj?=
 =?us-ascii?Q?N0VQ+jOfyknUeM1F0w2IWL8XdD5S8/03J2wjhq5DPYNUykgo/uSVexL2ytIw?=
 =?us-ascii?Q?xeAc2eaeZYXv6t6VODmtHF9WgMMyXbRzhyyZVrEnUDeycf9BcrlnasxkthLu?=
 =?us-ascii?Q?FE5FcFoaj6kLIQLWzIxVI0HESSrTVJn3QQT6/McMkoTeYkCQJNoWfaGJTxEu?=
 =?us-ascii?Q?MYIe+JUs27ELdI5f8g+Nt+OzM9aj1mi2ughsaFPDcAbRHD7OkPCg/HnExb+m?=
 =?us-ascii?Q?Wj1XeqVktaklBRdvlGOGg9/OfqQE74G/qltLQ9s38BPrF5qfHQflNN9hXuD9?=
 =?us-ascii?Q?v5uwEeOy9LTQBjwzYkeMEVMVjp6a1mOGxjFAL9buFNGiPd4K4m8xitn9S50y?=
 =?us-ascii?Q?kyktW4JU14WMg7kcpOuTP5vuUI17YLQi3FlB55hJcT/2Suc8UWVNQiZHRUVW?=
 =?us-ascii?Q?AH8f5mOvBbfd5xifv/IG11Pgq/g/hOhEFMX7R1CFqDwQCtsRS4Gh/PJIduOJ?=
 =?us-ascii?Q?iHVcN5Q0zn3JBHtZDyX60VaAVfKDQYXMucJlmfL3lCZOtEWnnFw6LtWq0SoW?=
 =?us-ascii?Q?Av8GvCkaVWdlv2Pvcx1hBUtEuAMwYYec7GNzuI9BPNLWJNV09poDz6enOrrw?=
 =?us-ascii?Q?SXHsDFBT1d70iS0OmNyHAdZEYyh8U0jLwUk/GyZ1rKC1R5UgNRXLZF1JCG6Y?=
 =?us-ascii?Q?87t1VNXusfU8jlQwP1DyF//TQU2+4BL8h6xvc5Kh9or8r3CPdGYuBQUnEG14?=
 =?us-ascii?Q?Fai7xJDWBdn8EXDE7CxlB6GWST5Clp/riQ41hoshDvOGnJHs1IN8LhiyrK20?=
 =?us-ascii?Q?vPbQWqXWpFwjIEYNR/jO7h/96eRkmvHwOryAcxJ9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QTT8LpiYRR4xU8q/jim0e4SmoqnrikeG4xXmrz4GtpWaCa7EuC9/n8D3gU0b?=
 =?us-ascii?Q?OReFkKZKYO4BNmtKgE1mq2Hs3tTFsAqEA5ouvWzlNMpvuRMUTxsaV9dBJTHz?=
 =?us-ascii?Q?uRiv597gkyq8nGaEfcPygz207xEHpr7A14HZWiDxZ1nCsjAemssgrK0EBAIE?=
 =?us-ascii?Q?PfIW1mdf1YGwowGFqKz0wcui+WmSNbA+/hyi5/BbGE+GCdxEAyTpFTYn+T24?=
 =?us-ascii?Q?xGjgzKn7x4RH9yjq4f0gsrJz25C5YR/vQOAdeO4yApKXTr5gbAK4ma82U7bD?=
 =?us-ascii?Q?z4ACWbdDtPrLm7Xjwt8LmiDgPrZOMKEfy09UjqrYeSavInSw4MKHh//rZCdS?=
 =?us-ascii?Q?BRQte+uqrkjJe1HBh1oUi/SyZuhYVA0t6eKbzg0ZxHsj9XfmE92hArkYz6FY?=
 =?us-ascii?Q?7xoZgwe/H2UmdKtTJ1FSAm5hziKwzEv6eTzqiB9HSmEzmuqo/Ski3xfwryj/?=
 =?us-ascii?Q?yMmfMIFQdVtyn6M55Ea/cjvNzCeWRZkflrpMOG7LotbAg1qmwuj7hOcchX9s?=
 =?us-ascii?Q?x9iEAndJQgT3LweDvzL4b7lyyX8c7c/wEVm2U9jgXmDlDEmsE849gZNVuYb6?=
 =?us-ascii?Q?ZU2SUnGLQR7kDwUMkiaRMxeo+kPTnDngXlTboskjw6MLlRLPE+Pn/QvHuM6C?=
 =?us-ascii?Q?OyvFVEfhOF+ftlMCoDWxC79/FB6eUcv4Fb8gyV5b99RE+iKLVVqHqDfVNxz6?=
 =?us-ascii?Q?Psoc+pw4GzAbyzi7SKGHHlnVw70KhcRUU9vcnc2PrgNsuhtsnePAa31RX/9T?=
 =?us-ascii?Q?OwG4FodymY7QB+ppoxGL+RTW1s/ttqNeTPDeOxde60TuLOx85kZyb1301xQw?=
 =?us-ascii?Q?MvbzwGASMnwxzWyyrh0GmrBdwAWGZgeCKA1XKjLwHGIDC/gbvCwAjDymolVM?=
 =?us-ascii?Q?z4DYiRDLm8tapyBom1OWskfzYnfiFKRtJQRPYTd+2fNgpYaEA28RElQqx+Y/?=
 =?us-ascii?Q?/gATLI8IjBd8gBKf9jddDYOodCEJc5nx2fvpKM83r3BuRYqEVnCAg2asBnjF?=
 =?us-ascii?Q?NCvETHNDHMEdyRL5VGpiKouUiKhwdaplcJwlqGhAPuBQCqJnPklu/T8kUloe?=
 =?us-ascii?Q?ZIryXonJjXA2hu8SKVac4NB/Froy6hbb+bRQgfbe4Y8/0yELyFmER/xM8isb?=
 =?us-ascii?Q?XZb7OvWTg71fbp3A4a9OilMtW3cRlfOEOQ=3D=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9284b9-ca2f-4a4d-ba56-08dbfae31670
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 07:22:24.3557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIyIrPzf+w50iY5oGJrOC0VnF/OKaSvD2lk5imWx+kZNKqawJ6DTa47UaxfAo9uDh4LGxDRAE9w7MZBlBU76xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905
X-Proofpoint-ORIG-GUID: IiDDxgEtJ20QjdUDUR16aPRV12E2Qbmz
X-Proofpoint-GUID: IiDDxgEtJ20QjdUDUR16aPRV12E2Qbmz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 suspectscore=0 mlxlogscore=762 impostorscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312120056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, =20

> > +static int dwxgmac3_fpe_irq_status(void __iomem *ioaddr, struct net_de=
vice *dev)
> > +{
> > +	u32 value;
> > +	int status;
> >
> > -		writel(value, ioaddr + XGMAC_FPE_CTRL_STS);
> > -		return;
> > +	status =3D FPE_EVENT_UNKNOWN;
> > +
> > +	/* Reads from the XGMAC_FPE_CTRL_STS register should only be performe=
d
> > +	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on rea=
d"
> > +	 */
> > +	value =3D readl(ioaddr + XGMAC_FPE_CTRL_STS);
> > +
> > +	if (value & XGMAC_TRSP) {
> > +		status |=3D FPE_EVENT_TRSP;
> > +		netdev_info(dev, "FPE: Respond mPacket is transmitted\n");
>=20
> netdev_info()?  Is this going to spam the logs? Should it be netdev_dbg()

Yes, netdev_dbg() should be better, let me fix it in the next patch.

Jianheng
>=20
> 	Andrew
