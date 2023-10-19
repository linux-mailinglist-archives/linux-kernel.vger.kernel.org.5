Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649B17CFC43
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346053AbjJSOPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346008AbjJSOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:15:47 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2135.outbound.protection.outlook.com [40.107.23.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794F413A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvGTKe62321hpk9My1c4SzRMulQuITnHboh3l/Q3es0=;
 b=k2n3YFl6zO/UWzvOvUuTq8XsT6TF9ckNu4zjfwR12qw6NxrM5r6xNtncTRn+sCIW/oMN5Khh/GSiRkEko+rWW6fi2BgaoQnicteGZhoCEPvKlTG+gF6zzNqOtGA5/RYk+ufN5vJ4EzAcjVUb/c2Lt62irM0uk4auQBSwz6l9MLo=
Received: from DUZPR01CA0300.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::24) by ZR1P278MB1102.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:5c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Thu, 19 Oct
 2023 14:15:41 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:4b7:cafe::c7) by DUZPR01CA0300.outlook.office365.com
 (2603:10a6:10:4b7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Thu, 19 Oct 2023 14:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24 via Frontend Transport; Thu, 19 Oct 2023 14:15:39 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4SB8rW3gb5zxpD;
        Thu, 19 Oct 2023 16:15:39 +0200 (CEST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Thu, 19 Oct 2023 16:15:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvGTKe62321hpk9My1c4SzRMulQuITnHboh3l/Q3es0=;
 b=k2n3YFl6zO/UWzvOvUuTq8XsT6TF9ckNu4zjfwR12qw6NxrM5r6xNtncTRn+sCIW/oMN5Khh/GSiRkEko+rWW6fi2BgaoQnicteGZhoCEPvKlTG+gF6zzNqOtGA5/RYk+ufN5vJ4EzAcjVUb/c2Lt62irM0uk4auQBSwz6l9MLo=
Received: from AS4P195CA0027.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::16)
 by GVAP278MB0038.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Thu, 19 Oct
 2023 14:15:37 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::8c) by AS4P195CA0027.outlook.office365.com
 (2603:10a6:20b:5d6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Thu, 19 Oct 2023 14:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.23 via Frontend Transport; Thu, 19 Oct 2023 14:15:37 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.105) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 19 Oct 2023 14:15:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7O7vUtFBh8wZIz47BacySTxHQbDzmfdd9sZMyzikgd4ni2SBV3ud0lcIXw3DD/7W5AP1kmmKe0wjF/LRg20FN2AUIvCuSaAgAGIpsNt6p2oZYR1/wXSk/Uan/uck/aqdlXEagtq2s5JR/85EptxBilBCxEHm0sXlnmYwI87+J66QxSUEbsrBBLyr8AvYTQ9z6b5waIQaiUPkSNSkUmIIDVmQnqoKMwmCVZSOsAGbUdOUa2K8NYTcT/GJFeCw0l9Hu8thQxc1ZNbDdEW7ulAOQb9QeiSy4xzTDBeEhzOr7AolgJMHAAtWOunT2g1u/v4OOyZ22dNAR9hRi6A2JY8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvGTKe62321hpk9My1c4SzRMulQuITnHboh3l/Q3es0=;
 b=I3e/Ue64lvTDMAOXMb9LWigqIr2BtbDTZjXV5KLR8KjsuMDO56I6vxUx9NhiWBEye4/RFIEsHyxmgwwV1dhUdIXl3Ye2KS6LZOuvhjUepxGt+lVANb0lRwXcblP4lv+D91+3JuxrJ5RtyEn4Z+Ss4owet+x30tGtOrhWiU0ro9LSqx7Nrgsa6wWXTQEP+BJKRA1AQbwqpsSzaFNsv++HrKb/1aBE9YercGzESMMoV1sUwSlM0xKmAhQ493jvjQ+3aFCOk0DLORRYp/p5AiiATxrOOulqXyuYWztqWJXWpshKEE/65YWL91Xo9mKCWX/9P+A32xhqjChQFvVM11rhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvGTKe62321hpk9My1c4SzRMulQuITnHboh3l/Q3es0=;
 b=k2n3YFl6zO/UWzvOvUuTq8XsT6TF9ckNu4zjfwR12qw6NxrM5r6xNtncTRn+sCIW/oMN5Khh/GSiRkEko+rWW6fi2BgaoQnicteGZhoCEPvKlTG+gF6zzNqOtGA5/RYk+ufN5vJ4EzAcjVUb/c2Lt62irM0uk4auQBSwz6l9MLo=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by GVAP278MB0038.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Thu, 19 Oct
 2023 14:15:32 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2bcc:953c:406d:24ac]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2bcc:953c:406d:24ac%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 14:15:31 +0000
From:   =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <josejavier.rodriguez@duagon.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
Subject: [RESEND PATCH 0/1] mcb: error for not supported devices.
Thread-Topic: [RESEND PATCH 0/1] mcb: error for not supported devices.
Thread-Index: AQHaApa3Pkkyz/gkikKK74f1zwnJQg==
Date:   Thu, 19 Oct 2023 14:15:31 +0000
Message-ID: <20231019141434.57971-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0516:EE_|GVAP278MB0038:EE_|AM4PEPF00027A63:EE_|GVAP278MB0038:EE_|DU6PEPF0000A7DF:EE_|ZR1P278MB1102:EE_
X-MS-Office365-Filtering-Correlation-Id: 3791d021-3ee8-4888-f6d5-08dbd0addf95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: wAtQPtX7TuqO24pIz7ig+0O65yCriMW052C8EZq5ijE9dhwbHEjJXbV7gJGlNqNy5VcWPIBrKWhsXtbPj7Xp634F0sC5pBikPJNUHDhpi/8JEDj0Uhxh7wba+yDo/F/6g72b3U+1XEkgW+MSg8sZmLx7V1SKcb1spy4ctHd77ISDjGd55au9VAw9277+MnOt6mqa/t5ps4S8zYFqJ7oJur2sIbB+CZb1i+DMjb+7YtGaZTYIuaSegMQqlGPKGlAtQDyVyA5oREYP8v/JXemZJ6qWtMRw1pLahyB548OdNzKrUgOpRL7rUjrWZKL3TkzndtOKMxh36UX//BDC2f9jSlmDCF5daXC9mb6y7GKMC7Jit7+VMrQZ9ji6YpZuZOyLVWlhpgXH9P+OlIciWVsf1ehfDDrEyyAIO1NWJ7CJJO6Q5iHl1M2HDXbALswTLEbZPD2f6XOaK5sTM9ePMxOmp36jZDDdNdwLCZS2ttdd9IgEYqtgUB+v7x7XITWJz8DPBu3XIbu9K7res99w6K0Ezj+vJjr23w0cgnZ1e7hGO67Y/Xus9sSKfDrJZqa7GHXXvFlCaEQUYzjoX2rl1OtDRTegcuy1WcrqwA3heQH+uuk=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(478600001)(6486002)(71200400001)(45080400002)(91956017)(66946007)(66476007)(66446008)(66556008)(64756008)(54906003)(76116006)(6916009)(38070700005)(86362001)(122000001)(38100700002)(316002)(5660300002)(36756003)(41300700001)(8676002)(2906002)(8936002)(4326008)(26005)(6512007)(83380400001)(1076003)(2616005)(107886003)(6506007);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0038
X-CodeTwo-MessageID: 024d2bfa-deca-4d9b-8f16-5d2f1877455f.20231019141533@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: e147be50-1cf9-4f7d-f4f0-08dbd0adda77
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: G5W/PsQCRl//wEpWnsI28Z4z1cKElb9DY/8H5KZQgNxAamo0FiIBWrZTlEy0DXMCE38aEtcFkhMxfDLDHVBD06lphOrpgRGMFPSTtsQ3NmHuVASIMJ0ojp6C70dHw8r/4LgA2ia2iZWHDw//ZGt7ONFTvawLjJjq/7tdbnEH8lCGgBBo1i6/7XDy6rAAZjwG+w6lgNak6wEAyqLY042DOR8JHOVhI+FnI324rdSKaDWCJf0sFRmKyRlI3Iy7eXCj5KntMfYanyDe3u/1/XXVFUQPV9itmmsqfmYiF4J0wYSu5ZmATckT2B8ADWnpKKnjGICLJn0yas0BIr1akOewKm+12khRqW32yRvDipOnUxji2En+pbzp9DZlAz3F4EJYYgc8Krq/KEVvKd+IOwy9XZ6H3R65MjP4XIgp0ry9NGgE8dow4M4W4ncSwGuieU7qu/7Dci+yM5I2Q9pk4g4ZyKREsOkWZDL0v06eCe3IWj7bES5mlHhAwL0gSwDYnCE0NLWHi9NP+TXT1FH/dZQeGFEP7QYvX/JCvBxEb37onF/zbbNYiyg7JyD2LwUgzh7IpQJSFsNAwgGmJRCUwbQdCo2UIxdDgue9nESUVqr6v9Myt+SWBDKmEg+zNlus7R1hFaNJXPILx6B0GVQ0ZNsZV90O7qxmP+PldqcIt9eHAVZlbZkJbcWKddyptkrKSW93m38kJtbOpNR5GTqHRBVFFg==
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(376002)(346002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(46966006)(36840700001)(40480700001)(36860700001)(478600001)(6486002)(47076005)(45080400002)(7636003)(70206006)(54906003)(70586007)(82740400003)(6916009)(7596003)(86362001)(356005)(316002)(5660300002)(36756003)(41300700001)(8676002)(2906002)(8936002)(4326008)(26005)(6512007)(83380400001)(1076003)(2616005)(107886003)(336012)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0038
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b24b8958-94d8-41b7-ba7a-08dbd0addde2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5fFtJ5cyuaYg9Eb9j+H03gyxb0+K3ZKLft6+sjlgikhZqZdDFOg8y1nj2HuPIDPF/rScLzQqluUdq1ZDvGo/jDAOyM8GbNvN9UmsLIRojVSHCYm92sBJmcjySf2QGJhgrmpMxcUl0+X26fiNxjhMDXsZEDo8LyfxSaJ7KS8dUTQSb+8Bec2BJvooTG2/Z1Vhdbbdsi96Mv5kk+NS5uudfDlu/pvuZ4irTRpQwnRqeOWJ+dvT900nnH82yQEotfMYxow1izbngd1S5QhmhCel4vxK7ktgA6ZhOYpPXnZEExjOZplMmz3X4JLkEJsjnmNLJRUvNxKCpTOjhu2mL10/p66ueFL5VmOujx3Qj2Ix8/+6JSpG6zv+Sd/kuS2nEaQpul0Jz1PmVUdWVd1oXN/NsccoP93+5zHcZYANQ6xvZEOudnujG6bH611zzGeDhBNqAcyLvD17zhSc2aqhzxesu2mUIL+5e9M+NYJX1c6HlBzxrX4enr17vd78wi7NLXM25Nytq5IZ0mTJ4vm4V9hhCFXOauvKsIlHCyfeBR4T2imogpL/NzXCpa93KwKA/mKNhb1QfbpacD8JTcgSuCYT1lyyaidEQwzp2L00/kqqzirgNy50Y107GdT0dR9KZCp+b7WXtHES1fJK7oZoffk00zBIBUrt/GHCykqut3Yss2XYGbcijw58Pcs9sfEf84sRoCmspzM8gjESmLBbbbVvWcbCj9R/GvlR5mLHyt2wJMAE7kf5QtRAA4i1waQrmIUih3ZBEa7/0/fsHwCzjFHbQ==
X-Forefront-Antispam-Report: CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(64100799003)(1800799009)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(86362001)(40460700003)(70206006)(70586007)(54906003)(316002)(6916009)(45080400002)(478600001)(8936002)(6486002)(8676002)(5660300002)(36756003)(41300700001)(4326008)(47076005)(2906002)(6506007)(36860700001)(2616005)(107886003)(1076003)(6512007)(83380400001)(26005)(81166007)(336012)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:15:39.9155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3791d021-3ee8-4888-f6d5-08dbd0addf95
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an issue where, if a MEN Chameleon device is not
supported, the early exit in chameleon_parse_gdd() will end up
calling put_device() when no device has been initialized yet. Because
the MCB subsystem does not support all the possible chameleon devices
listed for one FPGA, dmesg gets a few of these when parsing a Chameleon
FPGA:

[   32.974385] No BAR for 16z024
[   32.974386] ------------[ cut here ]------------
[   32.974388] kobject: '(null)' (000000002644a89d): is not initialized, ye=
t kobject_put() is being called.
[   32.974403] WARNING: CPU: 0 PID: 103 at lib/kobject.c:726 kobject_put+0x=
52/0xa0
[   32.974410] Modules linked in: mcb_pci(+) intel_cstate mcb acpi_pad mac_=
hid mxm_wmi sch_fq_codel ipmi_devintf ipmi_msghandler msr parport_pc ppdev =
lp parport pstore_blk drm ramoops pstore_zone efi_pstore reed_solomon ip_ta=
bles x_tables autofs4 uas usb_storage spi_intel_platform spi_intel gpio_ich=
 ixgbe igb i2c_i801 xhci_pci i2c_algo_bit xfrm_algo crc32_pclmul e1000e i2c=
_smbus lpc_ich xhci_pci_renesas dca mdio wmi
[   32.974455] CPU: 0 PID: 103 Comm: kworker/0:3 Tainted: G        W       =
   6.2.0-32-generic #32~22.04.1-Ubuntu
[   32.974458] Hardware name: MEN Mikro Elektronik GmbH G25A/n/a, BIOS 1.01=
 01/31/2017
[   32.974460] Workqueue: events work_for_cpu_fn
[   32.974467] RIP: 0010:kobject_put+0x52/0xa0
[   32.974472] Code: 74 39 85 c0 7e 4f 4c 8b 65 f8 c9 31 c0 31 d2 31 f6 31 =
ff c3 cc cc cc cc 48 8b 37 48 89 fa 48 c7 c7 48 69 65 98 e8 2e ae 0e ff <0f=
> 0b eb be 31 c0 31 d2 31 f6 31 ff c3 cc cc cc cc 4c 89 e7 e8 05
[   32.974475] RSP: 0000:ffff9a0600597d48 EFLAGS: 00010246
[   32.974478] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[   32.974480] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[   32.974481] RBP: ffff9a0600597d50 R08: 0000000000000000 R09: 00000000000=
00000
[   32.974483] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8bab960=
c3800
[   32.974486] R13: 0000000000000000 R14: 0000000000004000 R15: ffff8bab958=
95c00
[   32.974488] FS:  0000000000000000(0000) GS:ffff8bb2dfc00000(0000) knlGS:=
0000000000000000
[   32.974491] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.974493] CR2: 00007f7e688fdf3e CR3: 000000011007c003 CR4: 00000000003=
706f0
[   32.974496] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   32.974498] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   32.974500] Call Trace:
[   32.974501]  <TASK>
[   32.974503]  ? show_regs+0x72/0x90
[   32.974507]  ? kobject_put+0x52/0xa0
[   32.974512]  ? __warn+0x8d/0x160
[   32.974518]  ? kobject_put+0x52/0xa0
[   32.974523]  ? report_bug+0x1bb/0x1d0
[   32.974530]  ? handle_bug+0x46/0x90
[   32.974536]  ? exc_invalid_op+0x19/0x80
[   32.974542]  ? asm_exc_invalid_op+0x1b/0x20
[   32.974547]  ? kobject_put+0x52/0xa0
[   32.974552]  ? kobject_put+0x52/0xa0
[   32.974557]  put_device+0x13/0x30
[   32.974563]  chameleon_parse_gdd+0x149/0x1d0 [mcb]
[   32.974573]  ? chameleon_get_bar+0xc2/0xf0 [mcb]
[   32.974583]  chameleon_parse_cells+0x196/0x1c4 [mcb]
[   32.974593]  mcb_pci_probe+0xf5/0x280 [mcb_pci]
[   32.974602]  local_pci_probe+0x4b/0xb0
[   32.974607]  work_for_cpu_fn+0x1a/0x30
[   32.974613]  process_one_work+0x21f/0x440
[   32.974618]  worker_thread+0x200/0x3f0
[   32.974623]  ? __pfx_worker_thread+0x10/0x10
[   32.974627]  kthread+0xee/0x120
[   32.974633]  ? __pfx_kthread+0x10/0x10
[   32.974639]  ret_from_fork+0x2c/0x50
[   32.974644]  </TASK>
[   32.974646] ---[ end trace 0000000000000000 ]---

This error was introduced in commit:=20
   commit 728ac3389296 ("mcb: mcb-parse: fix error handing in chameleon_par=
se_gdd()")

Jorge Sanjuan Garcia (1):
  mcb: fix error handling for different scenarios when parsing

 drivers/mcb/mcb-core.c  | 1 +
 drivers/mcb/mcb-parse.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--=20
2.34.1
