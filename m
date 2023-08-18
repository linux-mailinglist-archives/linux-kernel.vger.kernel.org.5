Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C624D780AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359860AbjHRLDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359837AbjHRLDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:03:10 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2090.outbound.protection.outlook.com [40.107.23.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198FC30C2;
        Fri, 18 Aug 2023 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIRkqPEtvzvRjIinVfHeS0e7MfR4GG83CwMMKiPC5kI=;
 b=YkG3oXDfZCMWo+Dvz8zexnwSW26WqUK7go+jw99gACiogY1NigAu6Yg7MWYuKr7jUVcwY/M10AS0Z/kjXyYH7NijC6im7FXEghk4tNuZXTz1cQRncVK842JmlsD0SsfkbR+nq0A1+iLaM9qpQA9479TJewEhCr0sMPwE0wm8UeU=
Received: from AS9PR06CA0343.eurprd06.prod.outlook.com (2603:10a6:20b:466::26)
 by ZR1P278MB1069.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:03:05 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:20b:466:cafe::9) by AS9PR06CA0343.outlook.office365.com
 (2603:10a6:20b:466::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Fri, 18 Aug 2023 11:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 11:03:04 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4RRzVk68l5zxpC;
        Fri, 18 Aug 2023 13:02:54 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2049.outbound.protection.outlook.com [104.47.22.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Fri, 18 Aug 2023 13:02:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIRkqPEtvzvRjIinVfHeS0e7MfR4GG83CwMMKiPC5kI=;
 b=YkG3oXDfZCMWo+Dvz8zexnwSW26WqUK7go+jw99gACiogY1NigAu6Yg7MWYuKr7jUVcwY/M10AS0Z/kjXyYH7NijC6im7FXEghk4tNuZXTz1cQRncVK842JmlsD0SsfkbR+nq0A1+iLaM9qpQA9479TJewEhCr0sMPwE0wm8UeU=
Received: from DB8PR06CA0038.eurprd06.prod.outlook.com (2603:10a6:10:120::12)
 by ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:03:01 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:120:cafe::44) by DB8PR06CA0038.outlook.office365.com
 (2603:10a6:10:120::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Fri, 18 Aug 2023 11:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 11:03:00 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.42) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 18 Aug 2023 11:02:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAzZe41t3KVBXNoG4UfuUeu1davmgtXm9x6Ik/a0CmlFyUDt9bhVY+hR4ojkt1dlh84swDnrfBxHucqDUqLaKnWKlJMczjam7cl2IJaujZbq8aOVS4gMXLFXJ2oDke9zMe07ug0kAa9YPqrfLKHewZRNhk40PV3i6cR/eQv4EpW/f+20IZE1wZmoICmYjXMzsFLc/U6W6VcJcZBLyKPQWTvOiw6rEKPMd4lygfqRz9jz+N253U6P4jIPZvMmYc+J12uLnANAqaxr8gVW6AKIC1dwp7FQoSdrtKR4s0cm6jtw1gGIK1jDJ8oocQADtj/0YjzPygEsracTygBragULSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIRkqPEtvzvRjIinVfHeS0e7MfR4GG83CwMMKiPC5kI=;
 b=TvjZuMxSlvwnlwT1uIg7e/hTeCcwWsTWZwnUT0Df6O/L1dxn6Hl5WCJMMhQYCN8k6pwPDB4l2E3XeAq55JXHYsOzKcGD5DEVMcdWtnENwFOeBV5O2y5cRPrjKG7SLUuiwLM+MUdK+FrN39Pkk/6ehuPbJaFrEhTSuvrGTvT2oJ8E1AzqALQY/GnUpNy5jXXdV2TsPPFulQDB9IaLFiRFkpdEruSvQcUDDVcENDOZiqQ2unGtZ7B4yhL+Z/eGrLBk88esm91Y8rSfJc0FJPMjWnYKFMymASdkDvyH1TV0GID9+Cip34gGqcu25Oq31hTmQ+LbylatLLEokJJg7msUfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIRkqPEtvzvRjIinVfHeS0e7MfR4GG83CwMMKiPC5kI=;
 b=YkG3oXDfZCMWo+Dvz8zexnwSW26WqUK7go+jw99gACiogY1NigAu6Yg7MWYuKr7jUVcwY/M10AS0Z/kjXyYH7NijC6im7FXEghk4tNuZXTz1cQRncVK842JmlsD0SsfkbR+nq0A1+iLaM9qpQA9479TJewEhCr0sMPwE0wm8UeU=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB1115.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:54::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:02:54 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ab4d:5002:7656:5d47]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ab4d:5002:7656:5d47%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 11:02:54 +0000
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
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH v2 0/1] mcb: Fix crash mcb-core module is removed
Thread-Topic: [PATCH v2 0/1] mcb: Fix crash mcb-core module is removed
Thread-Index: AQHZ0cOJpSpDJB2JdUKYfJAxwFOk3Q==
Date:   Fri, 18 Aug 2023 11:02:54 +0000
Message-ID: <20230818110230.186700-1-JoseJavier.Rodriguez@duagon.com>
References: <2023071044-deduct-cycle-a918@gregkh>
In-Reply-To: <2023071044-deduct-cycle-a918@gregkh>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB1115:EE_|DB1PEPF0003922F:EE_|ZR2P278MB1164:EE_|AM3PEPF0000A793:EE_|ZR1P278MB1069:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b541c5-dc70-489d-5c4b-08db9fdab22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: zf+596D8CKxIhl5qCPnES8ughdHjHJdV+fm1qg7OV5JDY/JB4KQW9dbqTBogqZhwNtrtaW2E+YHX/jZA5d9uNVmDwVhrrFDs2ZC8IxQS/jKLPJYel6g/vuxoQUWlo9n27tzAd1wSk9P1K+KkCzf7EWu+AXfE3B2DH4AFlFdx2IBMMxEmlct23LeRf6jfomX7vOcc9C9EBAUWM/Y4do99DQSayNXxMT9c4+CWNfCL3XNovrASHep2Z/9s60nq+IVV8fWbWd0guxGFhtpXONfZrL0HY1Djzc3E0b5sQTGbX55N+nj/TT79u+sURXLtbUYG4FJerlC6d4HC7qbPFvsjmQBncRA04XAjBw0oOA5p8vDz4UCugmqDXTVLtumWHEpzGa+wUSTJvq+vlv6KRialpULChbyTt2OUgjV8KuOaymZ3mhgJcIwGyuoYMKRmoSOVuEZx6hvyZm56bw6OoDP83W4duBR3FHaaD9k6x3fya4uaGRhLX7qvt8CI39s6bkEfJtHe13VRWoXeXGAigytySd5eNe3Rj6pQqzZdWd0UAYQsZPL02ubT+9Bihsd2C+EPr/0QJzRy7uOH3i9o5DR/LDvABsD8BiXmhwFuHdIdJe3OUA8e/+kC4fnzzTUt7X4e
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39850400004)(1800799009)(186009)(451199024)(2906002)(86362001)(38070700005)(8676002)(8936002)(41300700001)(5660300002)(36756003)(6512007)(6486002)(71200400001)(107886003)(478600001)(26005)(1076003)(6506007)(45080400002)(122000001)(83380400001)(64756008)(2616005)(76116006)(91956017)(110136005)(54906003)(66446008)(66556008)(66476007)(4326008)(66946007)(316002)(38100700002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1115
X-CodeTwo-MessageID: dd715121-b51a-46fe-9500-ee96fa742062.20230818110259@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 703cf693-4350-4ed5-fd50-08db9fdaac61
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: RzSap7fiSQ0xGCAbyloA/JnFxDcxXK+PkF/V6YohMqivE3WRT8fJEpyTggX1UVV/zOP1Z8FZNtTyTgPA8bm43nUkDJUJk/+4+mPArywI7ZXVn8yVSPqibwFFOVKTO/yTIJ7JqCO/2EyvnhBifw3t6/u/c6+rhM2oS5R8UP8FgIWTGtp77Q2kZhAoluo8ysSsJ0o28kyGu8y+4B77FhQSsLysZzU/nA3jWD/ifUFF9LVAyJXhelgHAHwO2fOAfafqMmaxdW6zmP3ab74dpq5qTvHTAD/HTHfRKS7OpPJHoXTp3imNKl6vb5RhYRgxo3wqMrlQFSM7PfnynDaZzGHqVB0zfOE4ZWoawThhPW6NxXby/P3lJfza+fCZUlA7sYCOQAGPdn2DUXGksEHFVefITIEIyAwgbb5TN4JPfbAJzAdxHKe0Pm4LyCm3v1JGY53u+XwOVaskuA103uNHEhG56MIsTcp0IMWfT/OQ8tBZJk3BbnPr1qMzCKPcMPMsoPlWHeN2prTye5RQ/5y61SW0omLu9T+v66MvvfJoF1ooZmd+XtpzJY4DML6HC67hDuwAE8VbJBGsumAdfk5653pUqqnnRuELo29cV4HBbuzGBhcshpCRGZ+Z95MW1dMbH4yRMEMx8kGlbhBz9BWe2fKqhyRB37PYnodgIm7dnx7Pq/x2zLcsaCB2CjBNDp0DPakJ42xILhHx5ZHm2jIR0cc3RQ==
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39850400004)(136003)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(2906002)(54906003)(5660300002)(316002)(6506007)(40480700001)(26005)(1076003)(336012)(4326008)(70586007)(70206006)(45080400002)(110136005)(41300700001)(8936002)(8676002)(478600001)(6486002)(6512007)(107886003)(36860700001)(47076005)(2616005)(36756003)(83380400001)(7636003)(7596003)(356005)(82740400003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1164
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b3bafae7-7cd6-4c5d-0da9-08db9fdab021
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CrNOJdG9bfNJiI0+4wUdmG95/ntwDArz4tn76SQp+sKWbnib3M2eQWpSs9+OUqsEKxRbWzCKzabfJkLOqCJfbo+49BCJZOFH88i30qrAzMz8XZCHKgBw2xzSURBvLEJxxQzp9fA9Ze0BSm17At9/6U5dasyhU4fRWkTL3Ufg4sC9kEK55x8qMeBVdFCoo/RyppW/+KteFYMWiCnYCRDP6NYaIFXS6NPTbf2WCIq/xGftXHs3FDbWrbMIODwExRHaVLD6UpwTEm7Z/NcxJ6stvTHlaZ/jk6Er/EmgqdO775rEz/AZ4S/ndaKqIYtYofVw4AanxKHXHY4JTqXpP1FzGIke1kPn/lb+D5b/NamVbVFZsGR3V5LSAko5NqX2DaPUE5UAIJ+K0wMqp2e5RfkPw52gCxi97/woaTUoRJjyjqJk5LT7VBVEj0LbPsjtRKvdX02oBxhdn2BcffSjtJ7SEaxI18PzTF2YrCm6Zbq4u9RvI2W42ElMJpzuAi4E+F99tfCfOI77hoUXpoYjHn90QDHnMdMaWHZINksC0tytIOnRGVv0xN11j2Adgu1XqFI6gfzU0nslZUWqIHwNxMRXOSb7g4uizc8+ECfgt+0FQxzAI3d4usFUleTqyExr6FcgxIk4u4aqTpExhfHMXPhoPaopgnmqIWYVbbOa7WXPLKWHZdCiBKzwfEQ1WZ84k0RofoB3pe1Vg4cykTFSlHfe1+aYc9XRNb0xVCMeO1Gepp/2Tf1r+lLhbXEFElXHwqCE
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(346002)(376002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(40470700004)(8676002)(6486002)(40460700003)(41300700001)(6506007)(8936002)(81166007)(478600001)(2906002)(40480700001)(82740400003)(70586007)(70206006)(54906003)(110136005)(86362001)(45080400002)(316002)(36756003)(2616005)(5660300002)(26005)(1076003)(107886003)(83380400001)(4326008)(336012)(36860700001)(47076005)(6512007);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 11:03:04.1586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b541c5-dc70-489d-5c4b-08db9fdab22b
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating a new mcb_bus the bus_type is added to the mcb_bus itself,
causing an issue when calling mcb_bus_add_devices(). This function is not
only called for each mcb_device under the mcb_bus but for the bus itself.

The crash happens when the mcb_core module is removed, getting
the following error:

[  286.691693] ------------[ cut here ]------------
[  286.691695] ida_free called for id=3D1 which is not allocated.
[  286.691714] WARNING: CPU: 0 PID: 1719 at lib/idr.c:523 ida_free+0xe0/0x1=
40
[  286.691715] Modules linked in: snd_hda_codec_hdmi amd64_edac_mod snd_hda=
_intel edac_mce_amd snd_intel_dspcfg kvm_amd snd_hda_codec amdgpu nls_iso88=
59_1 ccp snd_hda_core snd_hwdep amd_iommu_v2 kvm snd_pcm gpu_sched crct10di=
f_pclmul crc32_pclmul snd_seq_midi snd_seq_midi_event ghash_clmulni_intel t=
tm snd_rawmidi aesni_intel snd_seq binfmt_misc crypto_simd cryptd glue_help=
er drm_kms_helper snd_seq_device snd_timer drm snd k10temp fb_sys_fops sysc=
opyarea sysfillrect sysimgblt snd_rn_pci_acp3x mcb_pci(-) snd_pci_acp3x sou=
ndcore altera_cvp fpga_mgr mcb spi_nor mtd 8250_dw mac_hid sch_fq_codel par=
port_pc ppdev lp parport ip_tables x_tables autofs4 mmc_block nvme ahci i2c=
_piix4 libahci i2c_amd_mp2_pci igb nvme_core i2c_algo_bit dca video sdhci_a=
cpi sdhci [last unloaded: 8250_men_mcb]
[  286.691752] CPU: 0 PID: 1719 Comm: modprobe Not tainted 5.4.702+ #11
[  286.691753] Hardware name: MEN F027/n/a, BIOS 1.03 04/20/2021
[  286.691756] RIP: 0010:ida_free+0xe0/0x140
[  286.691759] Code: a8 31 f6 e8 12 f7 00 00 eb 4b 4c 0f a3 28 72 21 48 8b =
7d a8 4c 89 f6 e8 8e ad 02 00 89 de 48 c7 c7 e8 02 83 b5 e8 b0 7a 5d ff <0f=
> 0b e9 67 ff ff ff 4c 0f b3 28 48 8d 7d a8 31 f6 e8 da e0 00 00
[  286.691761] RSP: 0018:ffff9a56c38f7bd8 EFLAGS: 00010282
[  286.691763] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000000=
00006
[  286.691764] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff8d881fa=
1c8c0
[  286.691765] RBP: ffff9a56c38f7c30 R08: 0000000000000487 R09: 00000000000=
00004
[  286.691766] R10: 0000000000000000 R11: 0000000000000001 R12: 00000000000=
00001
[  286.691767] R13: 0000000000000001 R14: 0000000000000202 R15: 00000000000=
00001
[  286.691769] FS:  00007fb78e303540(0000) GS:ffff8d881fa00000(0000) knlGS:=
0000000000000000
[  286.691770] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  286.691771] CR2: 00007ffe92b2ce98 CR3: 000000079fd9c000 CR4: 00000000003=
406f0
[  286.691772] Call Trace:
[  286.691781]  mcb_free_bus+0x2b/0x40 [mcb]
[  286.691785]  device_release+0x2c/0x80
[  286.691787]  kobject_put+0xb9/0x1d0
[  286.691790]  put_device+0x13/0x20

As mcb_bus_add_devices() is called for the mcb_bus itself, the function
tries to cast the incorrectly passed struct mcb_bus to mcb_device. Both
structs have the same layout:

struct mcb_bus {
        struct device dev;
        struct device *carrier;
        int bus_nr;
...
};

struct mcb_device {
        struct device dev;
        struct mcb_bus *bus;
        bool is_added;
...
};

This incorrect casting is causing a wrong behaviour in
mcb_bus_add_devices() where the member bus_nr is casted to is_added,
meaning that when bus_nr is "0", the function continues and sets bus_nr
to "1" (is_added =3D true)

If we have 2 buses (one for each F215 board), the function ida_alloc()
will give the value "0" and "1" to each bus respectively, but as both
buses are included themselves in the devices' lists, after the call to
mcb_bus_add_devices(), the buses will have the value "1" and "1". For
this reason, when the mcb-core module is removed, the error raises as
the ida resource with value "1" is being released twice, leaking
the ida resource with value "0".

changes for V2:
* create a dedicated bus_type for mcb_bus and mcb_device structs
  instead of removing bus_type for mcb_bus.

This patch is based on linux-next (next-20230817)

Jose Javier Rodriguez Barbarin (1):
  mcb: create dedicated bus_type for mcb_bus and mcb_device

 drivers/mcb/mcb-core.c | 43 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

--=20
2.34.1
