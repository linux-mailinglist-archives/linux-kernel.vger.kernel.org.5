Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6837AB21B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjIVM2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIVM2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:28:39 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2121.outbound.protection.outlook.com [40.107.24.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD79F92;
        Fri, 22 Sep 2023 05:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqOqaBsKzXW09hXhpYgn7DqKYq5bSs5RWLD7DEFjV7k=;
 b=G7xnJyA/ByRzDWH+oDHOrAaF5E9c8LZJu7p/MgnL0bk7jVYD6EIt3aJvSv/p3aAGj+gMoINe31jom09nTYAPhLiWCfpBPJvw4881g/qvmuwCzHg7KB9Kpzy90s/RNDmx7e7UkO2TZ5fcd+qdrEwPfIUtKkrv1Pr3WCGYxdjpHd0=
Received: from AM6P193CA0054.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::31)
 by ZR0P278MB0012.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:19::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 12:28:23 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:209:8e:cafe::84) by AM6P193CA0054.outlook.office365.com
 (2603:10a6:209:8e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 12:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 12:28:21 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4RsWl93qmvzxpH;
        Fri, 22 Sep 2023 14:28:21 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2044.outbound.protection.outlook.com [104.47.22.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Fri, 22 Sep 2023 14:28:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqOqaBsKzXW09hXhpYgn7DqKYq5bSs5RWLD7DEFjV7k=;
 b=G7xnJyA/ByRzDWH+oDHOrAaF5E9c8LZJu7p/MgnL0bk7jVYD6EIt3aJvSv/p3aAGj+gMoINe31jom09nTYAPhLiWCfpBPJvw4881g/qvmuwCzHg7KB9Kpzy90s/RNDmx7e7UkO2TZ5fcd+qdrEwPfIUtKkrv1Pr3WCGYxdjpHd0=
Received: from AM0PR01CA0167.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::36) by GV0P278MB1128.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:4c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 12:28:19 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:208:aa:cafe::b6) by AM0PR01CA0167.outlook.office365.com
 (2603:10a6:208:aa::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 12:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.0 via Frontend Transport; Fri, 22 Sep 2023 12:28:17 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.111) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 22 Sep 2023 12:28:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXeqfn03QuhJ1xtkL9SCNquvd2sKBL+LIOFeTO4BfCqlewmeQc8KVjz6uU+Cwaw6RBRX/v9QM59ospd0JlWWagx6/hVdZ8moGxQ0vjNzMkTp9m4F6cz2eaToQ4JJ+m1hQxsCKFC8Jwe8wOmHvwY5FZjAjx4XqPuW2YQ2/4tuhHVcpXyfzemv9O6S3VbPNkRe20dTmsHL7YN61w+uXdVn/Rc63wDXdIIdCQqNqfhC/pQpGgW4jZLLTypoZrQf+3TUZkO9yp+0bOvz0QNlQnhde7sB/DINL2Jb1gpGskY1Z4MX6mbLO+Q3iIogh6ghts0+oEAuHkLEjxK6RsiFVx25OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqOqaBsKzXW09hXhpYgn7DqKYq5bSs5RWLD7DEFjV7k=;
 b=d4mwoEjoz/Bkk7wA/4FVx2D9PeFapasQ6KlgEqf4RQ0AiuacqR3j+ynFGkS5HmAonzkOXdLpwYhztvevQ7OH++PUT1ZSmtKqk0bOpzrFvRnDVxhTF8i52uqbVDKtB3XkUojEcHcYELHB0r0bDh74BXKOp5X+vOA2/kFCZAFQxatPzeB8x9uNOn4GosPLhsHRsohFhp0z4Zgf1uA4y1XcwPIOQu3QI7sQMuWzRpVvdhwJTUWT6gTayonwtEJ6PwbHLU5unmuX5hjVubLgaSQ5MlTUQNNVAKcocA+WfsH2WNd50hbWF1uShvE1SXvhEVH85EFER6ffI0sMrE9XmbgL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqOqaBsKzXW09hXhpYgn7DqKYq5bSs5RWLD7DEFjV7k=;
 b=G7xnJyA/ByRzDWH+oDHOrAaF5E9c8LZJu7p/MgnL0bk7jVYD6EIt3aJvSv/p3aAGj+gMoINe31jom09nTYAPhLiWCfpBPJvw4881g/qvmuwCzHg7KB9Kpzy90s/RNDmx7e7UkO2TZ5fcd+qdrEwPfIUtKkrv1Pr3WCGYxdjpHd0=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by GV0P278MB0162.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Fri, 22 Sep
 2023 12:28:14 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a222:6d25:1fdb:a800]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a222:6d25:1fdb:a800%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 12:28:14 +0000
From:   =?utf-8?B?Um9kcsOtZ3VleiBCYXJiYXJpbiwgSm9zw6kgSmF2aWVy?= 
        <josejavier.rodriguez@duagon.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?utf-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "morbidrsa@gmail.com" <morbidrsa@gmail.com>
Subject: Re: [PATCH v3 2/2] mcb: use short version for function pointer for
 mcb_free_bus
Thread-Topic: [PATCH v3 2/2] mcb: use short version for function pointer for
 mcb_free_bus
Thread-Index: AQHZ4LgxiyYmw8Q6ZUKWOFwaI/GpA7AjyI2AgAMWhIA=
Date:   Fri, 22 Sep 2023 12:28:14 +0000
Message-ID: <352fb63a17943b974f5bf6eebb4d861ae8307b24.camel@duagon.com>
References: <20230906114901.63174-1-JoseJavier.Rodriguez@duagon.com>
         <20230906114901.63174-3-JoseJavier.Rodriguez@duagon.com>
         <2023092000-overprice-guileless-e1a3@gregkh>
In-Reply-To: <2023092000-overprice-guileless-e1a3@gregkh>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|GV0P278MB0162:EE_|AM4PEPF00025F9C:EE_|GV0P278MB1128:EE_|AM1PEPF000252DD:EE_|ZR0P278MB0012:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5eef2b-980f-4703-da02-08dbbb676910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: a2KE0nkOqDQbSl5I4k8fQ0A9Q6sa0hpDd9VZfKpBSwN6HS0vLJkCXirT1/UIUvZAk+c4nfi/x7ltu88OlVzFUyyOc2Ns0UqfJcCsLKYRUvWVrMYG2CqGrr+o+sr2WkMcdvExjBfZwROexkdglHXeAP2oCDySkS9+1T7O8zfBj1PwD/xrrdWV6BL8uHQ1+0MUi31Br4yuxHF1az1qbgecaxJSQPhM7RRAHbaxSY7sVjNB5AOwY7Qgs87bO/u+lx5ye54HiYQMnM7VAc2eKGjnSQ+b7ItaTR1swljNF5XemMux8Gf9TbEAFm5Xy3A8OmzUk428cRyh1feXneZ806XvzYvG4DIUYz6juJTeYGfSbFC2obHL6irCps90EMT9uhXXMe7QOr1sc++xtg8rFH7PdP+UZLXgaIfMlDDWKXbd5apqPpr1uLLx+YAp15BHaKUGl971fDl1MsfLkvGCpawIxKGC3YWuF5t6ykY3AqFoqAcdbHs82SP1BnoNhy7qsKvzyoCphIIV0DREQOmjnCO2zEJYrUwl1sOfZM7OVbhY2GsOQf9otnOo1Nv56J3PFLLlLp3AdbuJeBcnPNJZ37Ja3TW9bcGWHSOkrOtyb05XxfC6iX6g1+3meNx2Qil9sUet3l/51J5FLafeOcCf4nLuMw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(346002)(366004)(396003)(186009)(1590799021)(1800799009)(451199024)(2616005)(26005)(6486002)(6506007)(1580799018)(6512007)(122000001)(38100700002)(38070700005)(36756003)(85182001)(86362001)(85202003)(66574015)(83380400001)(316002)(6916009)(8936002)(8676002)(41300700001)(54906003)(66446008)(64756008)(66556008)(66476007)(4326008)(5660300002)(91956017)(66946007)(76116006)(2906002)(478600001)(71200400001);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <26587BDCF17FFE4D99F4CBEC201DFD08@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0162
X-CodeTwo-MessageID: 4678222d-68c1-4e48-af8c-2aedf689b476.20230922122816@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 61d48301-661d-4f28-7ebd-08dbbb6764a8
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: OeXvVwF1C7bPgObQgGktijnix3g1t8pGapCHLTuZ6XRmnqidqYNU+T1c1VkM5+5HQ2uZmBb0o7uAAJHAHCb1nIi/xiheajk2Hi8INN3k81N9TXoBOHQNHdQl9PQPFhiSiqXwm6EtR3wegC0KVOtTVs0Gq8mz/+3cKL4xphixMUD3XrpZxjB57nK5mL+xlN0FCX1HqZB9EUH4s6T+1hM0qzQlo6axu6aS4FINHrjrf9jZkHtCiN64l4g2q2gOrrVXLgJ3SmNnv4rFjSuW4zTbg8lxIHDfHBu8wFFVLsGZPIwUx1B07vni1pMI7ycMe9gWIQZ4Bz16a72Qli98fpaozpowwx2zlDSy/mO9hWy8htNULJ6Lq5PlA3V9J4i7/j5gUnTqV5/VnUVnTuJfOC4bxeb4y71K68l+J0a1oNClwfGGQBwfVldkMAfXMEgGI7JDlalhdpkOATfqvKqMAYgKaBcvTfrse+g4bvJ/Je14ft93jMWPYBGeQiI0Lnf96642euGSA/26ipq7r4Q15m2tgqTxXZxJb3fXb2lMRPL8VWc376QYTSDcUPxn1UB5ntxb+PqaBByKAbjUjTlwx6Bdo0Bs2eqElrfp0ZRIobCmxjGgKWeTByUuA8DsHbkY6E6fQRGfqf4t/tCLliMsOwv9BNjsf/iE6JY4wxsGrb2k4EIRDPy8+eFWCcDz6z5lRQGT7f/DJcR84kr5lYr0cbsIevzlTxUKKhaaUuULkfTRVG31pBQZ94aCQ8KZxXa8JjFh
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(376002)(39850400004)(396003)(346002)(136003)(1800799009)(1590799021)(451199024)(82310400011)(186009)(36840700001)(46966006)(26005)(478600001)(66574015)(336012)(82740400003)(6486002)(6506007)(1580799018)(6512007)(40480700001)(7596003)(356005)(2616005)(7636003)(70206006)(70586007)(54906003)(316002)(41300700001)(8676002)(8936002)(6916009)(85182001)(36756003)(4326008)(36860700001)(47076005)(2906002)(86362001)(5660300002)(83380400001)(85202003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1128
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8cf9b471-e332-41fc-e4ce-08dbbb67664f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aStqJ5tcpNfTrbBnmN9l0XvCG8J6d0OaiQcKL6YK/tDYtn2D0LF1zlf+dGG86uxng18noxLQToZOVUPvOdagCVXazIJ3e1oGqj7it4I/5wMxS6kGL7mrJYPNnNmaEtoYPiP9SxvBr4fEpJbGMaaGqubSX/5OOO2iZCPSpdJzf1N2ezv8avMP9JMbRK/lB9VKDDCKWv//Jg5r8+v78tFLeXn1d2OLKtMJpurhzJgvKLaFjVk4zQu/9eAO5i8FYJlzfYn0V9sTCHYvf7yvS7NKoziHuRmj0dvcdWpdoBSjbByQ8I+9syTaWhKQN1g7eEZVkFk99hnY/aRbW0ilpYdYZQdS2n4JFRpD7KJJCaqsaTv0UAcQuyzL1KBfg3LmCpAcnH86yZCEAEY1JIVgf3i8NO2hdVX74xWqya+aSEae1dI0ybxq0etF1L2C8cw3H4NNYIj6ZIglSjDfQ17rsrX+LCpMY3XMgP93JVP2OpC/K7JtzGM1+s1tKqP4HPr4xp/byF3KX1DQg21880GvhjzFGC/tfRkNg4QVLDsDXa+Kcfv1NnDqGEDeuak/QmXYWbiQTTUH+zQg9DwC+ND8cC09Rz6BDO3cheKnAIN9v2Db9d97VqEoQjlA2iLJQyYHCe4HxXQJes5RwHrjshF0ewo/JKS7C03jwmY++2S3xXAV4lqj+y0+0nfVZoHjjM5FFZwvnHdWJsmvxxvMaKGspDWiiHpb1m0OtSQ1732Gvhi2LQ0vDW0rLQ1tsgNStmI7WuHV
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39850400004)(396003)(186009)(1590799021)(82310400011)(1800799009)(451199024)(36840700001)(46966006)(66574015)(6486002)(478600001)(6506007)(2616005)(336012)(6512007)(26005)(70206006)(85182001)(2906002)(36756003)(83380400001)(41300700001)(70586007)(54906003)(5660300002)(316002)(85202003)(8676002)(4326008)(8936002)(6916009)(86362001)(36860700001)(82740400003)(47076005)(81166007)(40480700001)(1580799018);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 12:28:21.8826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5eef2b-980f-4703-da02-08dbbb676910
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA5LTIwIGF0IDE1OjE4ICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gT24gV2VkLCBTZXAgMDYsIDIwMjMgYXQgMTE6NDk6MjhBTSArMDAwMCwg
Um9kcsOtZ3VleiBCYXJiYXJpbiwgSm9zw6kNCj4gSmF2aWVyIHdyb3RlOg0KPiA+IEZyb206IEpv
cmdlIFNhbmp1YW4gR2FyY2lhIDxqb3JnZS5zYW5qdWFuZ2FyY2lhQGR1YWdvbi5jb20+DQo+ID4g
DQo+ID4gSnVzdCBhIHN0eWxlIGNoYW5nZSBzbyB0aGF0IHRoZSBkZXZpY2UgcmVsZWFzZSBjYWxs
YmFja3MgYXJlDQo+ID4gZGVmaW5lZA0KPiA+IGluIHRoZSBzYW1lIHdheSBmb3IgZGV2aWNlcyBp
biBtY2JfYnVzIGFuZCBtY2JfZGV2aWNlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvcmdl
IFNhbmp1YW4gR2FyY2lhDQo+ID4gPGpvcmdlLnNhbmp1YW5nYXJjaWFAZHVhZ29uLmNvbT4NCj4g
PiBDby1kZXZlbG9wZWQtYnk6IEpvc2UgSmF2aWVyIFJvZHJpZ3VleiBCYXJiYXJpbg0KPiA+IDxK
b3NlSmF2aWVyLlJvZHJpZ3VlekBkdWFnb24uY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvc2Ug
SmF2aWVyIFJvZHJpZ3VleiBCYXJiYXJpbg0KPiA+IDxKb3NlSmF2aWVyLlJvZHJpZ3VlekBkdWFn
b24uY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9tY2IvbWNiLWNvcmUuYyB8IDIgKy0NCj4g
PiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21jYi9tY2ItY29yZS5jIGIvZHJpdmVycy9tY2IvbWNi
LWNvcmUuYw0KPiA+IGluZGV4IDBjYWM1YmVhZDg0Zi4uNWM2MTU3YjBkYjc1IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbWNiL21jYi1jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL21jYi9tY2It
Y29yZS5jDQo+ID4gQEAgLTI4OCw3ICsyODgsNyBAQCBzdHJ1Y3QgbWNiX2J1cyAqbWNiX2FsbG9j
X2J1cyhzdHJ1Y3QgZGV2aWNlDQo+ID4gKmNhcnJpZXIpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoGJ1
cy0+ZGV2LnBhcmVudCA9IGNhcnJpZXI7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGJ1cy0+ZGV2LmJ1
cyA9ICZtY2JfYnVzX3R5cGU7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGJ1cy0+ZGV2LnR5cGUgPSAm
bWNiX2NhcnJpZXJfZGV2aWNlX3R5cGU7DQo+ID4gLcKgwqDCoMKgwqDCoMKgYnVzLT5kZXYucmVs
ZWFzZSA9ICZtY2JfZnJlZV9idXM7DQo+ID4gK8KgwqDCoMKgwqDCoMKgYnVzLT5kZXYucmVsZWFz
ZSA9IG1jYl9mcmVlX2J1czsNCj4gDQo+IEJ1dCB5b3UgYXJlbid0IGZpeGluZyB0aGUgcm9vdCBj
YXVzZSBoZXJlIG9mIGFuIGluY29ycmVjdCBwb2ludGVyDQo+IGJlaW5nDQo+IHBhc3NlZCB0byB0
aGlzIGZ1bmN0aW9uLCByaWdodD8NCj4gDQo+IFllcywgcmVtb3ZpbmcgdGhlIHNpbmdsZSB2YXJp
YWJsZSBpcyBuaWNlciwgc28gdGhlIGNyYXNoIGRvZXNuJ3QNCj4gaGFwcGVuLA0KPiBidXQgeW91
IGFyZSBzdGlsbCBwYXNzaW5nIHRoZSB3cm9uZyBwb2ludGVyIGFyb3VuZCwgc28gd2h5IG5vdCBm
aXgNCj4gdGhhdD8NCj4gDQoNCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0KVGhlIHBvaW50
ZXIgdG8gc3RydWN0IGRldmljZSBpbiBmdW5jdGlvbiBfX21jYl9idXNfYWRkX2RldmljZXMoKSBh
bHdheXMNCndhcyB0aGUgY29ycmVjdCBvbmUuIFRoZSBwcm9ibGVtIGNhbWUgd2hlbiBjYWxsaW5n
IHRvIGZ1bmN0aW9uDQp0b19tY2JfZGV2aWNlKCkgd2hpY2ggd2FzIGhhcGVubmluZyBldmVuIGZv
ciB0aGUgY2FzZSBvZiBzdHJ1Y3QgZGV2aWNlDQpwb2ludGVyIGJlaW5nIGEgbWVtYmVyIG9mIHN0
cnVjdCBtY2JfYnVzLg0KDQpSZW1vdmluZyB0aGUgbmVlZCBmb3IgdGhpcyBjb252ZXJzaW9uIG1h
a2VzIHRoZSBmdW5jdGlvbiBnZW5lcmljIHNvDQp0aGF0IGl0IHdpbGwgd29yayBmb3IgYm90aCBt
Y2JfZGV2aWNlIGFuZCBtY2JfYnVzIHN0cnVjdHMuIFRoaXMgYWxyZWFkeQ0KZml4ZXMgdGhlIGNy
YXNoIGFzIG5vIG1lbWJlciBvdmVybGFwcGluZyB3aWxsIG9jY3VyIChpc19hZGRlZCBpbg0KbWNi
X2RldmljZSBzdHJ1Y3QgYW5kIGJ1c19uciBpbiBtY2JfYnVzIHN0cnVjdCkuDQoNCldlIGJlbGl2
ZSB0aGUgcG9pbnRlciBpcyB0aGUgY29ycmVjdCBvbmUgYW5kIHRoaXMgcGF0Y2ggc2VyaWVzIHdh
cw0KYWN0dWFsbHkgZml4aW5nIHRoZSByb290IGNhdXNlIG9mIHRoZSBjcmFzaC4gV2hhdCBkbyB5
b3UgbWVhbiBieQ0KInBhc3NpbmcgdGhlIHdyb25nIHBvaW50ZXIgYXJvdW5kIj8gYXJlIHdlIG1p
c3Npbmcgc29tZXRoaW5nPw0KDQp0aGFua3MsDQoNCg==
