Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A0F7BB7AD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjJFMcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjJFMca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:32:30 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2100.outbound.protection.outlook.com [40.107.24.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61393CE;
        Fri,  6 Oct 2023 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyOxEgIQk94IsLqfrqCzNTMslupgm9WSAsCpweIezsE=;
 b=fQSj3YFMROW2W8dIqUhM0piK3v3YOIbGXM3LEAQPBdX4Icoxl1TaniFTYaE0T/JZifG7C03HZi9NRj0fC+LfUKRUFqnlxDweVyBKNfFINBxuxg0v9zTXZn9opqYWHOtHvxTsRrjLRDGB/IUTpDlHLkjONe6GA+uVKWyNR3/kENM=
Received: from AM6P192CA0106.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::47)
 by ZR0P278MB0942.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 12:32:24 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:209:8d:cafe::55) by AM6P192CA0106.outlook.office365.com
 (2603:10a6:209:8d::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.30 via Frontend
 Transport; Fri, 6 Oct 2023 12:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 12:32:24 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4S279M53bVzxpF;
        Fri,  6 Oct 2023 14:32:23 +0200 (CEST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Fri,  6 Oct 2023 14:32:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyOxEgIQk94IsLqfrqCzNTMslupgm9WSAsCpweIezsE=;
 b=fQSj3YFMROW2W8dIqUhM0piK3v3YOIbGXM3LEAQPBdX4Icoxl1TaniFTYaE0T/JZifG7C03HZi9NRj0fC+LfUKRUFqnlxDweVyBKNfFINBxuxg0v9zTXZn9opqYWHOtHvxTsRrjLRDGB/IUTpDlHLkjONe6GA+uVKWyNR3/kENM=
Received: from DUZPR01CA0209.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::22) by ZR0P278MB1154.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:55::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 12:32:21 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:4b6:cafe::b0) by DUZPR01CA0209.outlook.office365.com
 (2603:10a6:10:4b6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Fri, 6 Oct 2023 12:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 12:32:20 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.40) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 06 Oct 2023 12:32:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKKQs/i2bT3Od4tlNz2yE2xfOuIrywNPKGDA/Yz9vXFD95DEMiCCQqWgpBJCeT3enAHt4EAU2h3LQg05bTV1Wx0o6wqEAghluUc99tXuRLgrbie41ZHGQWxE0MmTUOuLRVfvOATkb4wxzsBP5jvhHcaKDHVLatR01Sm0LwKA7qD6P7wnUT++C4CIE8gRFC9uc/HqSvdxj6Mb2zjGfIhy8nYRUUgLx/QbxyAvqxCxM49EQl/UcRtYro+lBb6Xf9DOsPR7tfI818m96NH5UvW2/t/y5dU3pWSKq0SrD6A8vpyRPVxP+ebtbh5CWsQc8Jn7vh1Qr0bDmqKhxR+l4+BRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyOxEgIQk94IsLqfrqCzNTMslupgm9WSAsCpweIezsE=;
 b=lfGsoZ4cpg4p20m2SPJyxKGTpdElKu6PM1HFDj2UTnc6fB41+kegXSx45bpbkV0WTL4BtSKxsgsCg1hVsCx4VJ6zpwP+B++7NBkvxKAe9Qjsmd2Y4BfZOMif0Sed8322u8If7Ka+C20OqfbI325xX03xUn8q3dFH8g9pDNxqYnSvzMSU5OxK1a70UbzMvXTVlKdfeKyqWLwKiaPlKzR+VfyWM64wcPiazLTGAq6lSwHCnKkeb8ya6AOiGjFrOyd9p591o6Z3PXjjUSpUmLHk/bg7n6cW9ZFYtJWwo+lH3ie865OALyhtrrrimbeshxgvIy+7sANEPfE7C4+Om0bByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyOxEgIQk94IsLqfrqCzNTMslupgm9WSAsCpweIezsE=;
 b=fQSj3YFMROW2W8dIqUhM0piK3v3YOIbGXM3LEAQPBdX4Icoxl1TaniFTYaE0T/JZifG7C03HZi9NRj0fC+LfUKRUFqnlxDweVyBKNfFINBxuxg0v9zTXZn9opqYWHOtHvxTsRrjLRDGB/IUTpDlHLkjONe6GA+uVKWyNR3/kENM=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZRAP278MB0061.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:14::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 12:32:13 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7d66:dac9:a13:b207]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7d66:dac9:a13:b207%5]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 12:32:13 +0000
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
Thread-Index: AQHZ4LgxiyYmw8Q6ZUKWOFwaI/GpA7AjyI2AgAMWhICAFB+TgIAB4i4A
Date:   Fri, 6 Oct 2023 12:32:13 +0000
Message-ID: <4374befb2cb49d953c9c3d0f142f6b8794b80843.camel@duagon.com>
References: <20230906114901.63174-1-JoseJavier.Rodriguez@duagon.com>
         <20230906114901.63174-3-JoseJavier.Rodriguez@duagon.com>
         <2023092000-overprice-guileless-e1a3@gregkh>
         <352fb63a17943b974f5bf6eebb4d861ae8307b24.camel@duagon.com>
         <2023100557-mournful-veto-64a2@gregkh>
In-Reply-To: <2023100557-mournful-veto-64a2@gregkh>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZRAP278MB0061:EE_|DU2PEPF0001E9BF:EE_|ZR0P278MB1154:EE_|AMS1EPF0000003F:EE_|ZR0P278MB0942:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e4f7ea-42e0-4435-11b7-08dbc6684b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: xH/r/lZPhAi5p1Be8vV22deTIVpRnlVA2nn6xGCpGVVdymGbe/8yZfhlYY2FhVF35HtQXBzHJM+2FUrkqPWG8QpP2PInFNoTQ/4p45tOfWhbJABnaCK+0ZT+cYLBL1KHV0nPvaMa4TAWT1im8PonDdLMdjXy/L3WKhBsVr4ybkxQA8922qOfVSDrch9nZcQTxcebxEoxNeBy7PvGlBqLo7qUsHzYMwcsqqV+5XIDh9TeDzJuEwpJaMKyiDvAGcEwLwoNhoq1WX3pPTiV8X4s8Al2u/QngDi1Tp4EBM3ZFo2TOuR+5TzfHLwUeZRo2egnNimn0DRjEsIVAcv/Z4C6i8hLwwCdGHZwVWo9GETX6aIhxlX/y5f7zDhe6Qz71Blm7qYgqVPxj+WFF+UK0amLqSzlwsP0YhKFWuQVVdqZcYqtONvsjk5YXKllP4BovMbtt+t5Za19l2V1mzJ3FfQZFYZYDCVd5EVBd2UT39uDaOxbGyJR02CSePxuVPhT1iWYaOz0NkZfvZv0ysLX9BMlY55doHxd6QONJFgoFWy/fqhR5tA8DQIDKnc1M5Af7lN9/4UzbPp8lgjz6xpBoAy6i7bVCXxwyE9mDBgdcUQzfEOrLxWV/U+P//qwxlnDwclOcsjjDgIu95WYxwbStis8Vw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(396003)(376002)(136003)(346002)(230922051799003)(1800799009)(1590799021)(186009)(451199024)(64100799003)(2906002)(38070700005)(1580799018)(38100700002)(5660300002)(85202003)(86362001)(36756003)(85182001)(122000001)(6486002)(66574015)(478600001)(26005)(83380400001)(2616005)(71200400001)(6916009)(6506007)(316002)(76116006)(41300700001)(91956017)(6512007)(66446008)(66946007)(8676002)(4326008)(64756008)(66556008)(54906003)(8936002)(66476007);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CD0B67F0FDB3341A0EBC22D70A2BD52@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0061
X-CodeTwo-MessageID: 8611e849-f2c0-48c3-b310-a01c7a649158.20231006123219@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5e931a3a-d125-44bf-7646-08dbc6684492
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /5poNzCsYQsbU81GfEoytZIPR6EW5x3AiJOQqixS5C/xyjrT3AJkfP4/WbzUMy84a5KMM+DAyiTRlA8M/Ac12nLID5re78rPJyjkwQZhTZah6ZkrdlGIrnj4VkIzoHaVcdHJu48hJa0ihNVt0tDyV536oF1j2gf35Rlj0XR8S+TTsEC54VxrLgwEdBnH2ukU/zCQHOGEMATETwsHF/TQsPxYxyrxP29xnPK6w4rgYqPzl24dYKDKhHxF5BGxt1/2qaSV9Ja/RVf+ayMWPpe9kdhIthKS3eWkdOVAJ73/3HUCIMimvNiV8qcnj1FVLj9YankfAQIQNLU1qz+p7NWdlZP0RKEeshNEDd7FBAvMeGzToj7CIcM3JPxiWXvmD+wrL4uNJ9WXt/PulBmiHsSHFAQM0uw/PWhZaay+LrA8P7rDNo2YjoYn13oI7gxpaxssl5yifGiFTlRRXwaKv/DEJX6VYJTMy28Gq7LoWsCdCcx1FmcXjR/y96h4DA/FfC7RpQFN0pHWr5pnrJxTzvtvC9/XFEElP5j1yMLOkq+amcnAB8ToKXmYi1HMrC4jZG0aeWpGfNW+4AYLKxXilpsb+BOKc/iLesw3mtcnhjIaMbycTHX4t9Oo22Qt1CTDMWK1WRIvfTE5CL5FgUbRpo/RfaMIwlunP+S1QDvOz2CpbZiP9k4pxnU3y5xRzhLfiE4j0GVKPAM9eHVcRmmHfSKzf9jNWP9hGo7HyIiZ9/HAfptDakxlrkrlhutaJjtF1L2L
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(39850400004)(346002)(136003)(396003)(376002)(230922051799003)(1590799021)(451199024)(64100799003)(186009)(1800799009)(82310400011)(36840700001)(46966006)(47076005)(6512007)(1580799018)(85202003)(5660300002)(85182001)(36756003)(8676002)(6486002)(6506007)(478600001)(6916009)(316002)(41300700001)(54906003)(86362001)(70586007)(70206006)(8936002)(7596003)(82740400003)(7636003)(356005)(4326008)(40480700001)(36860700001)(2906002)(83380400001)(66574015)(2616005)(336012)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1154
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3033da0e-e0d1-41bf-bcdd-08dbc6684931
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwjFyYRahoV115ygk/f+Nf5wGhIphPHUZqeX0eSeyyRMx5/J2Gc2iH7vYcomh5YqFVRAt5ZnC4RzegJWaS98F4bMKwO7R1GtQS4Twnk6umItDBcCvsNyd+KGtgij1J1h624Ff1UXeAvgc7IQm3iNXFfHlfZIBlfMNHKDP8cM+8Li30EiqJFHabZLVIZnhdNAP+K47qvVYOu0CX7ALoBQMUheQzDW3PrB/khZH8XhcyX0YvOa8cTsJsKPAU262e+L7Z26nEIQuiNIWutZ1WmNNluNR/m4IHT+v2EWhPv4aQ4pFPyHfOVBgJzEFoq7/Tz1XhY57UFEKbvZwyPNf2qevgyjHVvVUFO65/mDqGLE3QSNBZ3RqZ3i0m6wa5f5vBw7tDjzyAspzic55RIrWsA6WESkv9uJOqUSKIpAVrO//q4uU+NvM2vU/J+OyE2ShuHyeksnPY8oK+gZTueabc433lC1LDoybEzBzOOUlB1w1Fvqjab0vNzro0tsJPnE7VimtLQ8Su0alZnVlHccrR3M5ExY3u9oyphhXW5pY1F/IL3rMaDWtzv90FI24IpApppdMF26nyBOsOFrp0OA5fk908CXVcywfI64CrJ2Cr+qFH9zDAWtuspWkU+ZNo2r0DUZC50mQKOmnk6IKylEGzDgWehtlz5r+cX54zl/8k+prpAzfL2s82NsO3Chv1Ze2j1HUBFDPEXZ31FkpRL5uYZF/px43/weQ9spGyTXC1EVtK9XbsSrikAFXnlzP6JA0kjlFk8pr2VlmvSzJJVb2F5Ebw==
X-Forefront-Antispam-Report: CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39850400004)(230922051799003)(82310400011)(1800799009)(451199024)(1590799021)(64100799003)(186009)(46966006)(36840700001)(2906002)(8676002)(5660300002)(8936002)(4326008)(1580799018)(41300700001)(54906003)(6506007)(2616005)(316002)(6916009)(70206006)(40480700001)(70586007)(26005)(66574015)(336012)(36756003)(85202003)(85182001)(6512007)(47076005)(81166007)(86362001)(478600001)(6486002)(82740400003)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 12:32:24.0070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e4f7ea-42e0-4435-11b7-08dbc6684b21
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0942
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTA1IGF0IDA5OjQ2ICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gT24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMTI6Mjg6MTRQTSArMDAwMCwg
Um9kcsOtZ3VleiBCYXJiYXJpbiwgSm9zw6kNCj4gSmF2aWVyIHdyb3RlOg0KPiA+IE9uIFdlZCwg
MjAyMy0wOS0yMCBhdCAxNToxOCArMDIwMCwNCj4gPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Z8Kgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIFNlcCAwNiwgMjAyMyBhdCAxMTo0OToyOEFNICswMDAw
LCBSb2Ryw61ndWV6IEJhcmJhcmluLA0KPiA+ID4gSm9zw6kNCj4gPiA+IEphdmllciB3cm90ZToN
Cj4gPiA+ID4gRnJvbTogSm9yZ2UgU2FuanVhbiBHYXJjaWEgPGpvcmdlLnNhbmp1YW5nYXJjaWFA
ZHVhZ29uLmNvbT4NCj4gPiA+ID4gDQo+ID4gPiA+IEp1c3QgYSBzdHlsZSBjaGFuZ2Ugc28gdGhh
dCB0aGUgZGV2aWNlIHJlbGVhc2UgY2FsbGJhY2tzIGFyZQ0KPiA+ID4gPiBkZWZpbmVkDQo+ID4g
PiA+IGluIHRoZSBzYW1lIHdheSBmb3IgZGV2aWNlcyBpbiBtY2JfYnVzIGFuZCBtY2JfZGV2aWNl
Lg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSm9yZ2UgU2FuanVhbiBHYXJjaWEN
Cj4gPiA+ID4gPGpvcmdlLnNhbmp1YW5nYXJjaWFAZHVhZ29uLmNvbT4NCj4gPiA+ID4gQ28tZGV2
ZWxvcGVkLWJ5OiBKb3NlIEphdmllciBSb2RyaWd1ZXogQmFyYmFyaW4NCj4gPiA+ID4gPEpvc2VK
YXZpZXIuUm9kcmlndWV6QGR1YWdvbi5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEpvc2Ug
SmF2aWVyIFJvZHJpZ3VleiBCYXJiYXJpbg0KPiA+ID4gPiA8Sm9zZUphdmllci5Sb2RyaWd1ZXpA
ZHVhZ29uLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IMKgZHJpdmVycy9tY2IvbWNiLWNvcmUu
YyB8IDIgKy0NCj4gPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21jYi9tY2It
Y29yZS5jIGIvZHJpdmVycy9tY2IvbWNiLWNvcmUuYw0KPiA+ID4gPiBpbmRleCAwY2FjNWJlYWQ4
NGYuLjVjNjE1N2IwZGI3NSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9tY2IvbWNiLWNv
cmUuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL21jYi9tY2ItY29yZS5jDQo+ID4gPiA+IEBAIC0y
ODgsNyArMjg4LDcgQEAgc3RydWN0IG1jYl9idXMgKm1jYl9hbGxvY19idXMoc3RydWN0IGRldmlj
ZQ0KPiA+ID4gPiAqY2FycmllcikNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGJ1cy0+ZGV2LnBh
cmVudCA9IGNhcnJpZXI7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqBidXMtPmRldi5idXMgPSAm
bWNiX2J1c190eXBlOw0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgYnVzLT5kZXYudHlwZSA9ICZt
Y2JfY2Fycmllcl9kZXZpY2VfdHlwZTsNCj4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgYnVzLT5kZXYu
cmVsZWFzZSA9ICZtY2JfZnJlZV9idXM7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoGJ1cy0+ZGV2
LnJlbGVhc2UgPSBtY2JfZnJlZV9idXM7DQo+ID4gPiANCj4gPiA+IEJ1dCB5b3UgYXJlbid0IGZp
eGluZyB0aGUgcm9vdCBjYXVzZSBoZXJlIG9mIGFuIGluY29ycmVjdCBwb2ludGVyDQo+ID4gPiBi
ZWluZw0KPiA+ID4gcGFzc2VkIHRvIHRoaXMgZnVuY3Rpb24sIHJpZ2h0Pw0KPiA+ID4gDQo+ID4g
PiBZZXMsIHJlbW92aW5nIHRoZSBzaW5nbGUgdmFyaWFibGUgaXMgbmljZXIsIHNvIHRoZSBjcmFz
aCBkb2Vzbid0DQo+ID4gPiBoYXBwZW4sDQo+ID4gPiBidXQgeW91IGFyZSBzdGlsbCBwYXNzaW5n
IHRoZSB3cm9uZyBwb2ludGVyIGFyb3VuZCwgc28gd2h5IG5vdA0KPiA+ID4gZml4DQo+ID4gPiB0
aGF0Pw0KPiA+ID4gDQo+ID4gDQo+ID4gPiB0aGFua3MsDQo+ID4gPiANCj4gPiA+IGdyZWcgay1o
DQo+ID4gDQo+ID4gVGhlIHBvaW50ZXIgdG8gc3RydWN0IGRldmljZSBpbiBmdW5jdGlvbiBfX21j
Yl9idXNfYWRkX2RldmljZXMoKQ0KPiA+IGFsd2F5cw0KPiA+IHdhcyB0aGUgY29ycmVjdCBvbmUu
IFRoZSBwcm9ibGVtIGNhbWUgd2hlbiBjYWxsaW5nIHRvIGZ1bmN0aW9uDQo+ID4gdG9fbWNiX2Rl
dmljZSgpIHdoaWNoIHdhcyBoYXBlbm5pbmcgZXZlbiBmb3IgdGhlIGNhc2Ugb2Ygc3RydWN0DQo+
ID4gZGV2aWNlDQo+ID4gcG9pbnRlciBiZWluZyBhIG1lbWJlciBvZiBzdHJ1Y3QgbWNiX2J1cy4N
Cj4gPiANCj4gPiBSZW1vdmluZyB0aGUgbmVlZCBmb3IgdGhpcyBjb252ZXJzaW9uIG1ha2VzIHRo
ZSBmdW5jdGlvbiBnZW5lcmljIHNvDQo+ID4gdGhhdCBpdCB3aWxsIHdvcmsgZm9yIGJvdGggbWNi
X2RldmljZSBhbmQgbWNiX2J1cyBzdHJ1Y3RzLiBUaGlzDQo+ID4gYWxyZWFkeQ0KPiA+IGZpeGVz
IHRoZSBjcmFzaCBhcyBubyBtZW1iZXIgb3ZlcmxhcHBpbmcgd2lsbCBvY2N1ciAoaXNfYWRkZWQg
aW4NCj4gPiBtY2JfZGV2aWNlIHN0cnVjdCBhbmQgYnVzX25yIGluIG1jYl9idXMgc3RydWN0KS4N
Cj4gPiANCj4gPiBXZSBiZWxpdmUgdGhlIHBvaW50ZXIgaXMgdGhlIGNvcnJlY3Qgb25lIGFuZCB0
aGlzIHBhdGNoIHNlcmllcyB3YXMNCj4gPiBhY3R1YWxseSBmaXhpbmcgdGhlIHJvb3QgY2F1c2Ug
b2YgdGhlIGNyYXNoLiBXaGF0IGRvIHlvdSBtZWFuIGJ5DQo+ID4gInBhc3NpbmcgdGhlIHdyb25n
IHBvaW50ZXIgYXJvdW5kIj8gYXJlIHdlIG1pc3Npbmcgc29tZXRoaW5nPw0KPiANCj4gT2ssIEkg
dW5kZXJzdGFuZCBub3csIHllcywgdGhpcyBsb29rcyBjb3JyZWN0Lg0KPiANCj4gQnV0LCB0aGUg
ZnVuY3Rpb24gbWNiX2J1c19hZGRfZGV2aWNlcygpIHNlZW1zIG9kZCB0byBtZS7CoCBZb3UgYXJl
DQo+IHBhc3NpbmcgaW4gYSBwYXJhbWV0ZXIgdGhhdCB5b3UgYXJlIG5ldmVyIHVzaW5nLCBzbyB3
aHkgaGF2ZSBpdCBhdA0KPiBhbGw/DQo+IFlvdSBhcmUgaW1wbHlpbmcgdGhhdCB5b3Ugb25seSBo
YXZlIG9uZSBidXMsIHlldCB5b3UgYXJlIGlnbm9yaW5nIHRoZQ0KPiBidXMgc2VudCB0byB5b3U/
DQo+IA0KPiBUaGlzIHN0aWxsIHNlZW1zIHdyb25nLg0KPiANCj4gSSdsbCBxdWV1ZSB1cCB0aGlz
IHNlcmllcyBhcyBpdCBvYnZpb3VzbHkgZml4ZXMgYSBidWcsIGJ1dCBtb3JlIG5lZWRzDQo+IHRv
DQo+IGJlIGRvbmUgaGVyZS4NCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQoNClRoYW5r
IHlvdSBHcmVnLCBJIHdpbGwgdGhpbmsgYWJvdXQgeW91ciBzdWdnZXN0aW9ucyBhbmQgYXMgc29v
biBhcyBJDQpoYXZlIGEgbmV3IHBhdGNoIHRoYXQgZml4ZXMgaXQsIEkgd2lsbCBzZW5kIGl0IHRv
IHlvdS4NCg0KUmVnYXJkcyANCg==
