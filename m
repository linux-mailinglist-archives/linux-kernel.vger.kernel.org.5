Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC33780AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376257AbjHRLDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359847AbjHRLDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:03:17 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2092.outbound.protection.outlook.com [40.107.23.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE112708;
        Fri, 18 Aug 2023 04:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AClylVH3tNID76j3MTkHHd6qQaHti9ipee7Y5/lOPb8=;
 b=Iz3qE61QELEr4jgfg/x/0R5b6/Pro9I3GtX5Nnsec+w8vx9ThImiWv+6USvI0tpo2quBN6u/vAzOQN0mTDfwnP7rH7TmRIn3M6kig07QiezGEhueDT76YYj4kSZpZCyh58qRtZNrCVjqK2Mmq9jY0CuZj2np9th1wi/MmFLzeJM=
Received: from AS8PR04CA0086.eurprd04.prod.outlook.com (2603:10a6:20b:313::31)
 by GVAP278MB0088.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:22::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:03:12 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:20b:313:cafe::e1) by AS8PR04CA0086.outlook.office365.com
 (2603:10a6:20b:313::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Fri, 18 Aug 2023 11:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 AM3PEPF0000A798.mail.protection.outlook.com (10.167.16.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 11:03:11 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4RRzVt3xkvzxpC;
        Fri, 18 Aug 2023 13:03:02 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2044.outbound.protection.outlook.com [104.47.22.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Fri, 18 Aug 2023 13:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AClylVH3tNID76j3MTkHHd6qQaHti9ipee7Y5/lOPb8=;
 b=Iz3qE61QELEr4jgfg/x/0R5b6/Pro9I3GtX5Nnsec+w8vx9ThImiWv+6USvI0tpo2quBN6u/vAzOQN0mTDfwnP7rH7TmRIn3M6kig07QiezGEhueDT76YYj4kSZpZCyh58qRtZNrCVjqK2Mmq9jY0CuZj2np9th1wi/MmFLzeJM=
Received: from DU2PR04CA0225.eurprd04.prod.outlook.com (2603:10a6:10:2b1::20)
 by GVAP278MB0088.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:22::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:03:06 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::43) by DU2PR04CA0225.outlook.office365.com
 (2603:10a6:10:2b1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Fri, 18 Aug 2023 11:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 11:03:06 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.41) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 18 Aug 2023 11:03:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqsOM0sdnaBgYubB9Yzmqn8WVoVqwC8jvxsHsYFAykF2nf5wooMHxcGFSRhELtiw7QpfPiYPZZhpsc6c9GeN2f0h83N8fb8jvC5t8R7V95Q800kmhkM9NaWBx+ndcRnkR6nAsy0vHSz2cSpO/svviqwCupSqaEOUxN5ST7u8Xqk6ShrkEcXEZNuD4UC621hCWsced5rtIu8cP1HC2I9hectoL2/4VSp6FZy8u2hSoDOwCBoX7o4HUTIB9t47KaqjaliYymVRgAxWC3YVlGdS6Lx96StkOShzNzH7Xc8CaiNiJf1ozskmiFhQQl281RqVFVxvYJxcbKWRkZMDPo/Qpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AClylVH3tNID76j3MTkHHd6qQaHti9ipee7Y5/lOPb8=;
 b=ecSHeT093zPn6Y3jPAKF8xbSfYFRg4flYdYJVcgk7cdcx9vqY3JoZmM89YyfAX8SCeF8J5xdgwtARqoRQYksI1Pif2d+WXTM9Y8d5lxsFXhtaFkHttkJQDLn17ZExuSQ8FfM5O9Xx6zRBgrZGoG20l3l6H1InNP9k+hctNEDma3GrDMLrGrGx7ap60iwKnB6/6moKBJTkB2PGcoFchU+Qp7YDpJb50tlgNbG4/pksqObY50E13M1EuPB2J48lODw0b0sMQ+SqzRp+nXeOrAoh96dNAS06EXx2Sc0i8qCt/dyZ0btSpY3fe8Y81R2z13HivdXTqo/70EqXaofJQUqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AClylVH3tNID76j3MTkHHd6qQaHti9ipee7Y5/lOPb8=;
 b=Iz3qE61QELEr4jgfg/x/0R5b6/Pro9I3GtX5Nnsec+w8vx9ThImiWv+6USvI0tpo2quBN6u/vAzOQN0mTDfwnP7rH7TmRIn3M6kig07QiezGEhueDT76YYj4kSZpZCyh58qRtZNrCVjqK2Mmq9jY0CuZj2np9th1wi/MmFLzeJM=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB1115.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:54::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:03:03 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ab4d:5002:7656:5d47]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ab4d:5002:7656:5d47%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 11:03:03 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
CC:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
Subject: [PATCH v2 1/1] mcb: create dedicated bus_type for mcb_bus and
 mcb_device
Thread-Topic: [PATCH v2 1/1] mcb: create dedicated bus_type for mcb_bus and
 mcb_device
Thread-Index: AQHZ0cOPrTgqdMsg40mjmHoI2h+IQA==
Date:   Fri, 18 Aug 2023 11:03:03 +0000
Message-ID: <20230818110230.186700-2-JoseJavier.Rodriguez@duagon.com>
References: <2023071044-deduct-cycle-a918@gregkh>
 <20230818110230.186700-1-JoseJavier.Rodriguez@duagon.com>
In-Reply-To: <20230818110230.186700-1-JoseJavier.Rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB1115:EE_|DU6PEPF0000A7E2:EE_|GVAP278MB0088:EE_|AM3PEPF0000A798:EE_|GVAP278MB0088:EE_
X-MS-Office365-Filtering-Correlation-Id: f30798e5-b9b4-4a4b-24c1-08db9fdab6c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ZMgEeEg7VvFr6Nur2gGJ5DmGZyzjudfV2rFZ97gywPiAOh774gLqvK/s5m1FP8c0VZZvJoOkRJycXzzIjyYiX9mTKsyxPhIOKmf1GouxPUy7ML+dV3hHleNR0WqEUFE3CAUOFr2qsgNANM8baKcxim10BkBjBlQm+Mpkbfnu29aDWdV9lvvM9whOzTYBAhVmcc87yYK6UOQ03sH20+rjYTQQZfQ39Xdcy6kFKVAXJDulYYMz0kSTTlNcCIgnu2fFJGIDrhKmr5e7WB2XFY+vzq5xRlkNuoHvnbS3E4A+/kyNXOJSPbEqhQTpDpoJ2YVOHRyaKAwp9jfd8UMZlfpxEJiEJq3169xyoI2Axk84ZUErysbtTZt0etE11hxY/eKgNyAk6ocMaY2/JvrPLXEhSrwOm1ncIq0w5gSchZLcqMNJCoTL3HvYpvcv0Q1aPJvkBD1GX1FL5najry+8ydOYROWVaW538RXy1EBgvIYDGZxAEVOtt+cQHguEvpBY1eYwOyB85bbDgxYFO5eSi3SV0Fcec1sSoJXgKVX60L2JlQCyAQYvuDtRBJHyPJX5Ss+Ic1GdRt9Jv8eueihqb2ARivMHm8V3YSm5kkIveNztV+9PFZLV/hbR3+6RnYrH2pS/
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39850400004)(1800799009)(186009)(451199024)(2906002)(86362001)(38070700005)(8676002)(8936002)(41300700001)(5660300002)(36756003)(6512007)(6486002)(71200400001)(107886003)(478600001)(26005)(1076003)(6506007)(122000001)(83380400001)(64756008)(2616005)(76116006)(91956017)(110136005)(54906003)(66446008)(66556008)(66476007)(4326008)(66946007)(316002)(38100700002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1115
X-CodeTwo-MessageID: 6c5a7dc3-71c4-4cad-86a9-a7fcda07e618.20230818110304@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 781e0f4c-9f8a-45c4-c018-08db9fdab18f
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: gYjLfCXClM26WLiClXmu7u2SkaePXy2xfuQKSSysV/DTA0hKmXeTX2FDAo7mRYk5tgpEqyP70+lHgRp/HY1nAwywIclk19SLpTuG75+D++xhFTix0uKibiS4F7U9aG97KjlfQ2o+Hv3R0FPgBR3lb2/YoBErcXYYfbQgWe76yASKWkYer/0GX+Q8TXF97OzYatR7h+hnKalYVydg17XM+XDSIsjMadCBV5uD/9czgfyrru4v2BDc48ma09dQvHC/fgO2IKHR3z0Yl4oCvEZMs8tu89hXbYcCv1DGKHwrURnMda4Mk9uq3SxPDz/xywlpxoAYAvVo1bSFkY1xD2kzjx70jpRmZntKewwEqyRdl6N302VlxkaM6aIRF8GdOtE4u7nbZdJ4Y0cvh25MmPcHk029n+8t+AiRH47YQA8kLeiypnl0bKWGexN8gWGAFx1D+iWKa7pn4kKJgA5y9mcTHdPmMYrTH/8NSlCy9klFH0Edre+vuuTEsFsRAJx2j2ZzbG2S+9QD6CfHzykiCmDImbEd6Tg3F7HnAsuaN3bFlkZKu828oKE1Bw4O9tdc1uCRdSxWHKCHrF6T34HPDerb26ZjpdjLlYN9aw69apSnUm9e6bxeytZsZ1KHP8SGLya1WT759S/X+UU1NJ+Fez8B2fneM54Dbc9+UbVWX+bv3qn67yN7T/5Hk1JbttqyzwFOOd3lEVcF0XSRlPPM65ihUg==
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(39850400004)(376002)(396003)(346002)(136003)(82310400011)(186009)(451199024)(1800799009)(46966006)(36840700001)(6512007)(6486002)(83380400001)(36756003)(47076005)(2616005)(7636003)(82740400003)(7596003)(356005)(86362001)(36860700001)(107886003)(336012)(1076003)(6506007)(40480700001)(26005)(4326008)(70586007)(70206006)(316002)(54906003)(2906002)(5660300002)(41300700001)(8936002)(8676002)(478600001)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0088
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e970ce32-5275-4425-b4c6-08db9fdab33d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xR9vLwkSMPWodB6iwd3lOJ1D7nuPpgOtpKlsNE8odAC4qQYi0VQrOSTxN/Ek6jlsBpy6XJrGMhVHHOfqUJ6JU5Ca76WVKvrvHkwxCz38H/rHMmfx9Gwn+4Lq34n3+FefK8Nmtnbr9X7GWTRIeZAPyrBpUNT0H9sYSESW+Wo1Up3ZL+XGIwhFeE5zqDw0Pwi79FvYwcirxIcxvYTSKiXc2TXh2eqqEhHQ+bgsBwp/Q7IHso6+z9B3IuaFnWeygX2fK1lxd83DoQHXyUrEooYo2dRBTGBulfB3xfz+Mn+MM12Sw5LJXtqnWepgLcbnsSV82aZQibXjiNcjx/K00JPzOVf05gvENuX4iW/9zSSwz3s19LWCFNuqARXMuEiMsd63GiS9gDLokUx/USlH+HfRq23eZr/HN4kLCC7ECxdlpgYh7sYAEpjlIaCDGO8x/MbAEt8dLekt7P0DIzvLBvWa2IwqyYEuKWiBe9X9rOigig5D6/PJnb5gU2p2oZu3+lpnyaKjc6e/85UHckLppzAIlNGATi9yW6juREZpk7GAdtPWBjkK78K5sSijjGZ7Z6tgaz/BDN5kpa7QlI5SLs48tEtLhN1ZnztWPwn/Euo7D06F4X3sDTDKp6EnaUlej1vQcTP27wlCJNFOj47e7hzzy9bsLXmb5qSofZShBecy40z5Gxybrc4/e+Hyc5s7B1LDTa8nNyQNcN59/svEup0G4WOkeekBywq/49ZI+WFXN0luAWg7TEXOCRIU9s103m6W
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230031)(39850400004)(376002)(396003)(346002)(136003)(82310400011)(186009)(451199024)(1800799009)(46966006)(36840700001)(40470700004)(6512007)(40460700003)(6486002)(83380400001)(36756003)(47076005)(2616005)(81166007)(82740400003)(86362001)(36860700001)(107886003)(336012)(1076003)(6506007)(40480700001)(26005)(4326008)(70586007)(70206006)(316002)(54906003)(2906002)(5660300002)(41300700001)(8936002)(8676002)(478600001)(110136005);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 11:03:11.8577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f30798e5-b9b4-4a4b-24c1-08db9fdab6c2
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating a new mcb_bus the bus_type is added to the mcb_bus
itself, causing an issue when calling mcb_bus_add_devices().
This function is not only called for each mcb_device under the
mcb_bus but for the bus itself.

This causes a crash when freeing the ida resources as the bus numbering
gets corrupted due to a wrong cast of structs mcb_bus and mcb_device.

Make the release of the mcb devices and their mcb bus explicit.

Fixes: 18d288198099 ("mcb: Correctly initialize the bus's device")
Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.=
com>
---
 drivers/mcb/mcb-core.c | 43 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 978fdfc19a06..d2ac2a12b737 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -156,7 +156,7 @@ static const struct attribute_group *mcb_carrier_groups=
[] =3D {
 };
=20
=20
-static struct bus_type mcb_bus_type =3D {
+static struct bus_type mcb_device_type =3D {
 	.name =3D "mcb",
 	.match =3D mcb_match,
 	.uevent =3D mcb_uevent,
@@ -165,6 +165,11 @@ static struct bus_type mcb_bus_type =3D {
 	.shutdown =3D mcb_shutdown,
 };
=20
+static struct bus_type mcb_bus_type =3D {
+	.name =3D "mcb-bus",
+	.dev_name =3D "mcb-bus",
+};
+
 static struct device_type mcb_carrier_device_type =3D {
 	.name =3D "mcb-carrier",
 	.groups =3D mcb_carrier_groups,
@@ -186,7 +191,7 @@ int __mcb_register_driver(struct mcb_driver *drv, struc=
t module *owner,
 		return -EINVAL;
=20
 	drv->driver.owner =3D owner;
-	drv->driver.bus =3D &mcb_bus_type;
+	drv->driver.bus =3D &mcb_device_type;
 	drv->driver.mod_name =3D mod_name;
=20
 	return driver_register(&drv->driver);
@@ -227,7 +232,7 @@ int mcb_device_register(struct mcb_bus *bus, struct mcb=
_device *dev)
=20
 	device_initialize(&dev->dev);
 	mcb_bus_get(bus);
-	dev->dev.bus =3D &mcb_bus_type;
+	dev->dev.bus =3D &mcb_device_type;
 	dev->dev.parent =3D bus->dev.parent;
 	dev->dev.release =3D mcb_release_dev;
 	dev->dma_dev =3D bus->carrier;
@@ -251,6 +256,12 @@ int mcb_device_register(struct mcb_bus *bus, struct mc=
b_device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(mcb_device_register, MCB);
=20
+
+static void mcb_bus_unregister(struct mcb_bus *bus)
+{
+	device_unregister(&bus->dev);
+}
+
 static void mcb_free_bus(struct device *dev)
 {
 	struct mcb_bus *bus =3D to_mcb_bus(dev);
@@ -311,7 +322,7 @@ static int __mcb_devices_unregister(struct device *dev,=
 void *data)
=20
 static void mcb_devices_unregister(struct mcb_bus *bus)
 {
-	bus_for_each_dev(&mcb_bus_type, NULL, NULL, __mcb_devices_unregister);
+	bus_for_each_dev(&mcb_device_type, NULL, NULL, __mcb_devices_unregister);
 }
 /**
  * mcb_release_bus() - Free a @mcb_bus
@@ -322,6 +333,7 @@ static void mcb_devices_unregister(struct mcb_bus *bus)
 void mcb_release_bus(struct mcb_bus *bus)
 {
 	mcb_devices_unregister(bus);
+	mcb_bus_unregister(bus);
 }
 EXPORT_SYMBOL_NS_GPL(mcb_release_bus, MCB);
=20
@@ -410,7 +422,7 @@ static int __mcb_bus_add_devices(struct device *dev, vo=
id *data)
  */
 void mcb_bus_add_devices(const struct mcb_bus *bus)
 {
-	bus_for_each_dev(&mcb_bus_type, NULL, NULL, __mcb_bus_add_devices);
+	bus_for_each_dev(&mcb_device_type, NULL, NULL, __mcb_bus_add_devices);
 }
 EXPORT_SYMBOL_NS_GPL(mcb_bus_add_devices, MCB);
=20
@@ -499,12 +511,31 @@ EXPORT_SYMBOL_NS_GPL(mcb_get_irq, MCB);
=20
 static int mcb_init(void)
 {
-	return bus_register(&mcb_bus_type);
+	int res;
+
+	res =3D bus_register(&mcb_bus_type);
+
+	if (res < 0)
+		goto mcb_bus_register_fail;
+
+	res =3D bus_register(&mcb_device_type);
+
+	if (res < 0)
+		goto mcb_device_register_fail;
+
+	return 0;
+
+mcb_device_register_fail:
+	bus_unregister(&mcb_bus_type);
+
+mcb_bus_register_fail:
+	return res;
 }
=20
 static void mcb_exit(void)
 {
 	ida_destroy(&mcb_ida);
+	bus_unregister(&mcb_device_type);
 	bus_unregister(&mcb_bus_type);
 }
=20
--=20
2.34.1
