Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F5B7D0FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377192AbjJTMon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376956AbjJTMol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:44:41 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2111.outbound.protection.outlook.com [40.107.23.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92252D41
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbrNSK4+qjtWuwTWnwAEH4+9eye2w56TT5+ugRDyxr8=;
 b=e95RDG2MN/GVyB5i5ieqIediFS9PK3JYifjyrbXSUA9PwOzmY3cZHeQYb5pxR9/rGJoskiAz3/Qm2T+HFLuia6BLXJ4sN802y1Nz4XX+o4m+/gqjrCQbeko1wtTYKJ9k6dT96am/QcvC/6SmKgooZTWnvrKy95Q8jUAUJ92uyIo=
Received: from AM6P191CA0088.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::29)
 by GVAP278MB0135.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:21::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 12:44:34 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:209:8a:cafe::62) by AM6P191CA0088.outlook.office365.com
 (2603:10a6:209:8a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 12:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Fri, 20 Oct 2023 12:44:33 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4SBkmx4CJMzxpF;
        Fri, 20 Oct 2023 14:44:33 +0200 (CEST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Fri, 20 Oct 2023 14:44:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbrNSK4+qjtWuwTWnwAEH4+9eye2w56TT5+ugRDyxr8=;
 b=e95RDG2MN/GVyB5i5ieqIediFS9PK3JYifjyrbXSUA9PwOzmY3cZHeQYb5pxR9/rGJoskiAz3/Qm2T+HFLuia6BLXJ4sN802y1Nz4XX+o4m+/gqjrCQbeko1wtTYKJ9k6dT96am/QcvC/6SmKgooZTWnvrKy95Q8jUAUJ92uyIo=
Received: from AS4P190CA0056.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::27)
 by GV0P278MB0901.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:50::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 12:44:31 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:20b:656:cafe::21) by AS4P190CA0056.outlook.office365.com
 (2603:10a6:20b:656::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 12:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21 via Frontend Transport; Fri, 20 Oct 2023 12:44:30 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.41) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 20 Oct 2023 12:44:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLn6i+jlR0+lJ5vtQ3+efzy4oc+tJQPZukXTe/MsT2/Oq9SnCdliuziTBvsxCDS6CAi3/6T+OzC5vxnVz+n3wDA30mKH/UJ0PsMvcWmkMd8MOAZ74pelEjVdr4M+FL6HPq5aWSUSAd1nQosZaOOzQrMdSMYIgJarsk5z7u27Irig27wGy5aDbk1pBqSYn5LacIGAQkiUSsZjN3Ez/6nEwi6fQAEpXtVvh9HjQJyT9Q+RzH8hrHqMPDz+3hKsdDnXNDE97BrefOaH0nYSO9j6q3gg6uemQw9IA8xbmbAqMyMvJGCVyoGaxTXfkJ6WL/oOZIhGzsPRCZmvMHeCXjFyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbrNSK4+qjtWuwTWnwAEH4+9eye2w56TT5+ugRDyxr8=;
 b=UNo4AD8Bu9KDI7/4ub48V3YxXh/EAMNcE6kEJMaaiZJ5lnNBeyeg8UPwMT31o2JJokifhEjrc3laioCjGl4hs/JUofQpcocP0zZo59wZ2/K9Pq+BH9GIuHh/8aAQXHuQJ8/kiPiqZhAxWje1WBmbE+LoP+JkLlphFJtYiYaVpA3Gfiodi/cs5kjE7/1j+KdC9JLXzYFpc7iJghVvHENtcDJhJCIjCRHrgRKDwJrRkKpTPcDGJw6exLeUM6MSycVxryF8SZ9df0uRCdsf6/7ApDMU0pxhjS5wQv2n1kE66hZNAi4QCeulLSWsgR0P7ZFPyBXmp4DOW046t81L/i6SbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbrNSK4+qjtWuwTWnwAEH4+9eye2w56TT5+ugRDyxr8=;
 b=e95RDG2MN/GVyB5i5ieqIediFS9PK3JYifjyrbXSUA9PwOzmY3cZHeQYb5pxR9/rGJoskiAz3/Qm2T+HFLuia6BLXJ4sN802y1Nz4XX+o4m+/gqjrCQbeko1wtTYKJ9k6dT96am/QcvC/6SmKgooZTWnvrKy95Q8jUAUJ92uyIo=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB0153.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:37::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 12:44:28 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7d66:dac9:a13:b207]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7d66:dac9:a13:b207%5]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 12:44:28 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <josejavier.rodriguez@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <josejavier.rodriguez@duagon.com>
Subject: [PATCH 0/1] mcb: better use of buses when registering mcb devices
Thread-Topic: [PATCH 0/1] mcb: better use of buses when registering mcb
 devices
Thread-Index: AQHaA1MpoRi1zXIzG0qhiMrXm8F5AA==
Date:   Fri, 20 Oct 2023 12:44:27 +0000
Message-ID: <20231020124324.54692-1-JoseJavier.Rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB0153:EE_|AM3PEPF00009BA1:EE_|GV0P278MB0901:EE_|AMS1EPF0000004E:EE_|GVAP278MB0135:EE_
X-MS-Office365-Filtering-Correlation-Id: 635d9c46-6a74-423c-3868-08dbd16a5004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Rmm/Y1/nGpTpuncdfa+4nlpYBYjfWp1oNP2xngX1REtzUEaD+RAt8KhTrrJfAqy5vpcgQoyBoeg/mUNGWAGOF1y/aR8rOOC0ul2/oqLDVWlZ5I6++7WOD7z93tw0B0W97h8Y2tgJY8Afg+KCDl7M7BcweNpXjIgMwfkEOtN6N7Y80tlG2aiZIKZOHOEYmlW2O0FiQzl5dAYXKMgIXzoKEbzlBOV0Tx3cEMVLeRnzR10t4f+9U2vxi04yEGxj8ySFYPNNHJG99kIIr/0rh5M+S7EbkIH/t1RoZWyfF9Rk57Iy7+ZiA7Y/pzH4SlSUBQZ28J+aZIdQ749jbQIdmQDl7vuCgOXtLm+fq384bj1WHXjtBIgGgqPVEHG1/sbPtAlGhfGWjp7o1St8DtlH5Fstqm8OsVWvWbyQkZ3PEdOc2ry2n7v6Bv8plCu4OKMolon4nVaLBC0Bwsa0e81hz2sWLJxtnPWUDYhPuJUuv3XE+wtgAFP6z2Rhk0k/nVHxYynuJqHpcb77CAsvqUeZO/JODtI2/T45AkOXJGiSSgILJrKIYuoMhUfRQ4V+Wasw+zBhXdEuY4KG4LNH7eT6zJFzA/clKXsnRGZzkAz4m+/qYG8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(396003)(346002)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(122000001)(26005)(83380400001)(2616005)(86362001)(107886003)(1076003)(6512007)(36756003)(38100700002)(38070700009)(4744005)(5660300002)(478600001)(71200400001)(6506007)(2906002)(66946007)(76116006)(41300700001)(64756008)(110136005)(66556008)(54906003)(66446008)(66476007)(316002)(91956017)(8936002)(966005)(6486002)(8676002)(4326008);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0153
X-CodeTwo-MessageID: 81fac6ab-58e4-4045-9b1a-210875f9a269.20231020124429@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 80008ff2-3f8c-468f-8f5a-08dbd16a4bfd
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: w8KRIpt5Vqyd+pWAr8Teldf4DIYhMlHvw4YtP0fVWAOokrMCNsj/ZkItNyGDzO6WBHdysGbArVjIu1V9qVgcUzEeHdQej35xV+tAgMisqv6abvJYHEAYKApjV4vzxjvZE5GLI2zZ75ZSkLDxq0MAvlj/G0AysQ/5esZ2Y0sSMpbOFz1URA46vRQMdLHjWrxe+k8bU3CSPoOARcPyugDUxUNreueAYw161B3vQ7OD1/2lP1IBOTt1FxWkfcPIDVLz6BSyVvz+sUnzTDmqvK15pq+9tZacbhXSKV4bCm2gz4QKO5qMpPMm4Iv96LnH1o0PxR5BDEAqMamuB6V4WhFqftFyKhOcjhZnP3JlJvl+hTeTjahIfkX/i3MwTlZ3OrrmE0Zei6rtJPkKxv7ZYLVEt+/eQQFW/6Gyd4OPhH9NjUwQPWjr0pYCBcXmRUPdZCmmvIyr381KgDQzQfbMc21Mx99gBbWWkb0AYYH1XCZu9GyFdlXu94Pk8kFWcuAsDoYw3fqLTUxvS9rnoZl6Cfn0wT6mRK1XPuJ4uIPCM6dOuI3nYAEMPC1AwbDHVJtcTlxuwsIzUGILWcp3Ud+L6Kn+zzG4jYvakTnFDAhI26uRSz9RfkPW2btobWu5iAJRjhEe+hhc10E/iMn+d1NK5ALSO+tbhYVG85IcbyPpeH9zrRYp3sCByvOn05zrkrSOxwlU0jkzaURBgxX9Ej9gh1nxOw==
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(39850400004)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(6506007)(47076005)(86362001)(4326008)(36756003)(41300700001)(356005)(1076003)(26005)(6512007)(7636003)(2906002)(82740400003)(7596003)(336012)(107886003)(83380400001)(2616005)(40480700001)(36860700001)(4744005)(966005)(8676002)(5660300002)(478600001)(8936002)(6486002)(70586007)(110136005)(316002)(70206006)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0901
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6dcc936e-7594-4a15-c4f7-08dbd16a4e04
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7ROhYMttvIYanr0uuuhN0yT948tfFbmhpbk+VRkCERL5eVlDSIgGyPfEYAH10QIhQDs+ok+9CD7gyY2B5vwySEvRaiKz0P+l/wJcxAlu7tYwGG9yg49e+CprmvjkmsAtef/1u+gbdQJ5SCmhcibdWzBUOvJl4MJxxfF+YOCexh5w/1KIzb/2s7xTcmdt/3osQJyqUQ3Ih2OIO4clofr09LIWZR0V9Uj0y6c3IzOcFWyUJI4PZxOxOZhllCMCUrDFtBnU97ovTWjXldRHHvTS/7b5wzj1+/OJcVdtNWvS3BfTBFRhxdvNlN7VQjh7KEyY1DvemGSk01XEb/dEiK9f6oL4ad2r8NWsgvhWk5wm5CeLAXTjhzBJqUjEaCoUk7utKLRqG3J05rm4a6NPcgSrS0FzdMRkvGfRrTyv5dco3v+rUQT8cSZtwsw5TUDoMUydDUGuxQcHsfw/ZwaH2u7rBVv5k9f4KS9265V1xlyRX/zrfVtoxp1r7lGMd7cFAAVAUWnbA3T1WqOGlekLSfmW52Or9D8byBc/wGUi+4T+N0Zs1O7nP+zeEzgL965Wp/zbxba6tWpEWUz/pGzS8vsLRP4gyOLU21VjaqKI3JRFTZFzNx9lAgS03bF+G6GYFDpR/0Y/mI3HsllG+qU+587QHpUbOtjgECQAU4sokE/TQJYQhQMTFhMQsJL4CzMovfo8T938+cthmodJ58VwDQU/js9xVq/jIiggBNh3y8BXjsbEgqRHAosx/wiPUvC9+I8rssyJB27DJEMwvmrSsx/qQ==
X-Forefront-Antispam-Report: CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376002)(39850400004)(396003)(346002)(136003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799009)(46966006)(36840700001)(40470700004)(36860700001)(26005)(83380400001)(81166007)(2616005)(86362001)(107886003)(1076003)(6512007)(336012)(36756003)(82740400003)(47076005)(4744005)(40460700003)(5660300002)(478600001)(6506007)(2906002)(40480700001)(41300700001)(110136005)(54906003)(70586007)(70206006)(316002)(8936002)(966005)(6486002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 12:44:33.9280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 635d9c46-6a74-423c-3868-08dbd16a5004
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Greg suggested in:
https://lore.kernel.org/all/2023100557-mournful-veto-64a2@gregkh/

There was an odd usage of bus_for_each_dev() where the bus used was
being assumed and the input parameter of mcb_bus_add_devices() was
ignored.

Jose Javier Rodriguez Barbarin (1):
  mcb: Use the actual bus passed to init and release functions

 drivers/mcb/mcb-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
2.34.1
