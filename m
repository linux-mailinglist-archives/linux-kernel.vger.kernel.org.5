Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF67CFC48
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346036AbjJSOTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345795AbjJSOTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:19:00 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2111.outbound.protection.outlook.com [40.107.23.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A32FB0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klq8fFKpPkCU9+Tvj7oG0LolUdRulW4uoNxZ/o/rQQU=;
 b=Bf022Fx6/GQwZT9eUBH1f6Shh/pBCchRTVwXE/w6uzxQZgqanZP6ylaAmF07FoO2Rx3nR3bvwDi3AEIC9I6L/Upc6nG3sVsqm+WUZJPx9SRW9gqvN8YOQ9fHo9iefgJ7oSFSyD38n5ESgleygKIUdWmXEnFX+kbJCs5wvA93OmE=
Received: from AS4P250CA0003.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::19)
 by GV0P278MB1126.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 14:18:54 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::1) by AS4P250CA0003.outlook.office365.com
 (2603:10a6:20b:5df::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Thu, 19 Oct 2023 14:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21 via Frontend Transport; Thu, 19 Oct 2023 14:18:54 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4SB8wG0kMDzxpD;
        Thu, 19 Oct 2023 16:18:54 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Thu, 19 Oct 2023 16:18:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klq8fFKpPkCU9+Tvj7oG0LolUdRulW4uoNxZ/o/rQQU=;
 b=Bf022Fx6/GQwZT9eUBH1f6Shh/pBCchRTVwXE/w6uzxQZgqanZP6ylaAmF07FoO2Rx3nR3bvwDi3AEIC9I6L/Upc6nG3sVsqm+WUZJPx9SRW9gqvN8YOQ9fHo9iefgJ7oSFSyD38n5ESgleygKIUdWmXEnFX+kbJCs5wvA93OmE=
Received: from AM8P251CA0028.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::33)
 by GV0P278MB0036.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Thu, 19 Oct
 2023 14:18:51 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:20b:21b:cafe::c0) by AM8P251CA0028.outlook.office365.com
 (2603:10a6:20b:21b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Thu, 19 Oct 2023 14:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 14:18:50 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.40) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 19 Oct 2023 14:18:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH6s2fIZGwNTkFGThnGQrwJKU5foXD3XIpsaXhFnctvbYaIoSZ+YezzUI/SYnhLHE+7jdgLGFWoMf8dVTpnE2NLAgsVwV3bbwqktvawLhrm3HH8Ai72VyT89XyeFmcO6FAlZetp+KqhTxdC468NwiMmcK03apMR5R2mMxT+p2LW40GfF1u3+d6JU+58zexU2Ht1GCBXpZGX6VqG7uQozXWh6/W5JsjFlq2CT6RHlAzRZzYexTzMG5CSN5/cHm4Dxi99PlvWwtAUNlN6Z5n5+UY/9G17Y431UgGouOrY36/OsFPKXyrmlJQn6b0ht+UlIkN5cG/pdZwoIM0ZOgMzFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klq8fFKpPkCU9+Tvj7oG0LolUdRulW4uoNxZ/o/rQQU=;
 b=Ijww8QlhVfAfajKCwNgdnagCURjeGweEr44MXwSAP5/rJPLAvUkPw6411p/EY/CW188QyYUOcAr3CdRlAewO2Buga+IsnGqRuCrNX+bwko3ytv3vLnE/vHso06huIWOXcpkj7OPytqdG3IPuZ50sxDixMSS0gwN2J4+AQpmQ1iEpEypG/Loe7gKE+lwOldV3ZxbbSY33Xl+dUWLI4Pc+9iUFafsICLZ1QenEJba2Byays/PfZIgiUa3LqmDUgVWssD9kkKOgTI06ffbmXdC8BfvWFkhlOLJEQ7MSIgYZDOs+qEUJUxPDQ/dykYcdeu5bkow6EjAsB4OGLNuvcLxKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klq8fFKpPkCU9+Tvj7oG0LolUdRulW4uoNxZ/o/rQQU=;
 b=Bf022Fx6/GQwZT9eUBH1f6Shh/pBCchRTVwXE/w6uzxQZgqanZP6ylaAmF07FoO2Rx3nR3bvwDi3AEIC9I6L/Upc6nG3sVsqm+WUZJPx9SRW9gqvN8YOQ9fHo9iefgJ7oSFSyD38n5ESgleygKIUdWmXEnFX+kbJCs5wvA93OmE=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by GVAP278MB0038.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Thu, 19 Oct
 2023 14:18:47 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2bcc:953c:406d:24ac]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2bcc:953c:406d:24ac%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 14:18:47 +0000
From:   =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <josejavier.rodriguez@duagon.com>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
Subject: [RESEND PATCH] mcb: mcb-pci: detect IO mapped devices before
 requesting resources
Thread-Topic: [RESEND PATCH] mcb: mcb-pci: detect IO mapped devices before
 requesting resources
Thread-Index: AQHaApcsEOIlC6gSJkudMMweS8mFww==
Date:   Thu, 19 Oct 2023 14:18:47 +0000
Message-ID: <20231019141832.58288-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0516:EE_|GVAP278MB0038:EE_|AM2PEPF0001C70E:EE_|GV0P278MB0036:EE_|AM4PEPF00027A69:EE_|GV0P278MB1126:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e35cee-4141-47ea-d00b-08dbd0ae5378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: VxmwqFI/hObJP5IPanyD0X08CVP13oEz9hUP7hvGN7i5qPJeEYVIc4MJsrD2rGlaPph5XXNvDFSM5zcCvkVNCfBKDaPKxApbHEloVmy42L5YZlSUwAO5BIpyfM2jgT+/OYCoJbthYkQyHWiaOaTLYnNgqQnDGlVv3NKAenELmljjFHPlPEjTc2Xj3JPvcvuIDGcmL1ORkOdruFOHMNillgCOam12nVLG7u1OReP/vDdLJYbkfyRAd9lbHGK7Yd0uj54mAs8Sb4XaEgOb0H9TBzM3M+oBKuysir1tmAmU+n9J7DJvVlNPadIYb7E1TFkI5qkrsIAvIr07V6bRFpuP/SqfEO8yVqVFzNFWmSqDEXY0l1P3lBEQrCpogz63ZzMP9um4UaaD83absWLxcRogS9vC+uIk3Rg6gkXMcPF6u4BZreXYEhIm0jvFO3Gz52cVF9GEZnaCnQ//7CR581lghuKO58JKb4BylAMU2x7m5jXPMl6I8pNAMxumoqm44CJ1hfKI32LurBtvThoN1S5hh6F3viQbfJc1bZAmX4nB75Jd/jW+7winpd1KkbKLHKy9qIz1krUFNwvDWz6gIWnx62iUh47hJScnMfQTx6Xycf9OUqi7ZesGL6aVpkdMmpxO
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(478600001)(6486002)(71200400001)(91956017)(66946007)(66476007)(66446008)(66556008)(64756008)(54906003)(76116006)(6916009)(38070700005)(86362001)(122000001)(38100700002)(316002)(5660300002)(36756003)(41300700001)(8676002)(2906002)(8936002)(4326008)(26005)(6512007)(83380400001)(1076003)(2616005)(107886003)(6506007);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0038
X-CodeTwo-MessageID: 266c0561-9fb4-4353-bec3-ec8b8c429821.20231019141849@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: e088365e-06f1-41db-7719-08dbd0ae4f44
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: QEK/ACQQSlYNUWmCLr4wYRWY8Dr8xWkk/7aHMu2MnQXX9Z5h5369SCOcq6nu3EZLKi2TGg4Fx4phPTEMiJrzz9jOis57/EOgdOtM2aZRFVX7NrFiEmjR7vMdr4hDJJakqdoeaV9/avBkJwRTzVtmTYvEPmSoNZ3mi+OfFNSat+RDKHFrWq/BlNQgBTjcf2J+BYjHCfNYleU9s/rFXL5FYQuWee+GVr1+XyLosJmTBJhZsaPI7avFRqjlQv7jscLjNTjuLDxuXTNxazhNS/LrX4NqhT4DiLve8BJHIJOMIYJcyOgJSr+P4012jU+ABvHb+MOF80Z793XjXD+1eqjSYnjqQPcI4HWs+tXbtNzEfolyVwEs0sWjui2Fik1OAUP+AfAOE8xx96a6piE+HTVCcn22OOLId6BWgcxAr2akg0tAuHjEpz659ShPWu4+xug09pbiElaCqMOq6ddWDddbLrvtLsEozXF3i/dDQDslr+hT2VqVIZq7NwUlbiq2+0y0e/D9L0V/LSf+1N/7ZuswUlKomswGohJ3zqzzlQcPiNoBM6KbPyibPYGJCN+cHgoOyhmYxmB0xB4ZtAs3ipf1lWbNzNsLnJSPw9chrWS+3CR3NwChdfaBIEwfCNqEXQ50HE4JHzqRVyVTTZkxxjrc+JnxjgPxNVBzivItIMyncIaNiCXchlQ3Fn6eqi3Cilmmkj2sB8rBhMy8ndxXwajOFw==
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(346002)(136003)(39850400004)(396003)(376002)(230922051799003)(64100799003)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(47076005)(36860700001)(83380400001)(336012)(8936002)(1076003)(107886003)(6506007)(2616005)(6512007)(82740400003)(6486002)(478600001)(7596003)(70206006)(70586007)(7636003)(26005)(54906003)(356005)(6916009)(8676002)(316002)(4326008)(86362001)(5660300002)(36756003)(41300700001)(2906002)(40480700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0036
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 49753fed-372c-45b8-0067-08dbd0ae5133
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ea2c40oT3CqJj2P2xYPbihOahfwD4TDnpNFozYP8pj10c13Yd27sJFAEvVgWzweKlGzSpp2POmTg0YEiGf/nozccBxvfYtAGXQ+IJqZksXFzasGNlZLSdW2M0OlJjhM1+cpjaZexqvPKwnE6mbZrc4swSEG+AXbhbVOTDKwoZbqPArTkdK8qzo3Q62eYZpBZ9QmxOPxJri1VrY/1te4nGVapUI9vpds78G0OL7WavNw1/bziRZMoni/P8WWqAabV5ALj2/VelcDSHTdwSa+NYgLwY1TAT7HD8IIde/gLYsFqNYU4m8S2uHWaf9DEkjM0GvjjZO7ajiaFcCy8Eez0G7Vv1b/7kqqI5/Yx5pWBUN63gZvJD6yteKUa8YvpzAJEJZ3qvdXSZpu9bZwR5WdJmy3uBRbQ/yy8F3ITM/rC2eZT/SDFj0KoMUMJzPjU8hOcOpI3RYgt3qJXac1dPO73vEgTQDlfKUWPw0RBhKvQo1qNBQlNiBd7rxqFf08w1nZ/hFiBbguJiZLSbKSqEfMS1weqhR6gKbjnSOg56k0lIvHarSCukSJJFCjgCtOR6/v7WK7K60MieVzbqixz92phkNmPVKcTZpj7N7ugPUbn2Ax0OoimtgnzRMNnpf+A6ef7PbBLNk1xgJ8XlcnoyLibtFd9mgeyIE2CLxnJsrUOTkMbK+hw4GYsIHEn4limTAuc9+tYaoAE9lZe9QUunkYV5u7cDuW6UmgcyNXyRrp4PF3xoOqGN5xseb3yot3/e8fvhtyl0QVrI5t6Dd2rdjTWmw==
X-Forefront-Antispam-Report: CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(39850400004)(346002)(136003)(396003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(47076005)(36860700001)(83380400001)(6916009)(1076003)(2616005)(81166007)(6506007)(336012)(82740400003)(107886003)(6512007)(316002)(6486002)(478600001)(70206006)(8936002)(70586007)(26005)(54906003)(4326008)(8676002)(86362001)(5660300002)(36756003)(41300700001)(2906002)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:18:54.4026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e35cee-4141-47ea-d00b-08dbd0ae5378
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the memory region is requested with devm_request_mem_region()
for an IO mapped device it will return an error and mcb-pci will
incorrectly report it with EBUSY code.

Make sure we identify if the reosure is IO mapped and fail early
with a correct ENOTSUPP code.

Reviewed-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.co=
m>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
---
 drivers/mcb/mcb-pci.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index 53d9202ff9a7..3b634ea318c7 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -45,6 +45,14 @@ static int mcb_pci_probe(struct pci_dev *pdev, const str=
uct pci_device_id *id)
 	}
 	pci_set_master(pdev);
=20
+	flags =3D pci_resource_flags(pdev, 0);
+	if (flags & IORESOURCE_IO) {
+		ret =3D -ENOTSUPP;
+		dev_err(&pdev->dev,
+			"IO mapped PCI devices are not supported\n");
+		goto out_disable;
+	}
+
 	priv->mapbase =3D pci_resource_start(pdev, 0);
 	if (!priv->mapbase) {
 		dev_err(&pdev->dev, "No PCI resource\n");
@@ -68,14 +76,6 @@ static int mcb_pci_probe(struct pci_dev *pdev, const str=
uct pci_device_id *id)
 		goto out_disable;
 	}
=20
-	flags =3D pci_resource_flags(pdev, 0);
-	if (flags & IORESOURCE_IO) {
-		ret =3D -ENOTSUPP;
-		dev_err(&pdev->dev,
-			"IO mapped PCI devices are not supported\n");
-		goto out_disable;
-	}
-
 	pci_set_drvdata(pdev, priv);
=20
 	priv->bus =3D mcb_alloc_bus(&pdev->dev);
--=20
2.34.1
