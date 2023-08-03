Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796AB76E523
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjHCJ7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjHCJ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:59:25 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2114.outbound.protection.outlook.com [40.107.24.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE709358D;
        Thu,  3 Aug 2023 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnZc0JO+Jv8/Bs4GwTyIArh6vtewroNhMBLy/Y+bhQ8=;
 b=K3KQ+hTQVfFLlt679p6UsShUW7Ac83iLTRhNMDLgsJew56tpUrsUhiGBVGw3Xumw/pgm1I1XeG8HZunHi9kSF/YwLUlD9I4j7BARB3Zt07d465k8dIljv7FyxOaJWqIF6kYPdqeLVPvKvwmXAiorO14vol5icj28rjfRBXtbFRY=
Received: from DB7PR03CA0082.eurprd03.prod.outlook.com (2603:10a6:10:72::23)
 by ZR0P278MB0895.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 09:59:16 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:72:cafe::35) by DB7PR03CA0082.outlook.office365.com
 (2603:10a6:10:72::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 09:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.23 via Frontend Transport; Thu, 3 Aug 2023 09:59:16 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4RGknX3rvHzxpD;
        Thu,  3 Aug 2023 11:58:40 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Thu,  3 Aug 2023 11:58:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnZc0JO+Jv8/Bs4GwTyIArh6vtewroNhMBLy/Y+bhQ8=;
 b=K3KQ+hTQVfFLlt679p6UsShUW7Ac83iLTRhNMDLgsJew56tpUrsUhiGBVGw3Xumw/pgm1I1XeG8HZunHi9kSF/YwLUlD9I4j7BARB3Zt07d465k8dIljv7FyxOaJWqIF6kYPdqeLVPvKvwmXAiorO14vol5icj28rjfRBXtbFRY=
Received: from DUZPR01CA0216.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::14) by ZR0P278MB0776.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:42::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 09:59:12 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:4b4:cafe::7a) by DUZPR01CA0216.outlook.office365.com
 (2603:10a6:10:4b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 09:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.23 via Frontend Transport; Thu, 3 Aug 2023 09:59:11 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.110) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 03 Aug 2023 09:59:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHeYmZ/xWmqqXKVQzjx64XHxlq2locvTKlttyb3fmiTHsOgxKXk8luGUSsCigV32lMBsga/wCr5YHGLwzitPpSh6yx459cfQIMRH8SBtK3WsdekYfWKbqtgtcu5D+8v87UeeQFtckR/BVFHF5geYgtpWZ/dvbO/voc5egESPuZoBD1d/CV/j/h/rAwujcMbsHHrFjFYsQaatY5DvDIjDZD6UtM8Oqr1eYSgZbVietMaykSG5vmGtEirg0FQqLllDmzxqc6Av0peSRYE4r1695CgP3IRXtXkRxkiu0VF5CESxgLJJskE4CkEv8mKt9Bp1HWagN/PDqertWV7hBS7QrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnZc0JO+Jv8/Bs4GwTyIArh6vtewroNhMBLy/Y+bhQ8=;
 b=TLz0WgkgR2+S7uQBN6b2JzCE9kxl7MtNGYIbikTHDFPbE14460EVcMsYJ/FZkemPHx4ZkGrBPBRzfiSDbfC+/ePs0rvAWkirgW//OyLhtKr4t6Jve84FPqwHUys+wNRMclSeJzwDD4FiEWSYiJzabYJ0J7DEzeAipA4E3jsbBYkRfNTBFZCclVxW2g6lnQVszLnDdhSCZGqUHw3rEddTzfWmjWdPZCBggkzG6Hxqu1Icx8//sYD4SGmMdQPT7mPAqEPRTht980BzqLz4xjbHBZnaH1RwweYEuyS3oUEXWlqj6R6NPGYQ7uCZhYHYzh/yLp4atexfXFEUZmKLukKxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnZc0JO+Jv8/Bs4GwTyIArh6vtewroNhMBLy/Y+bhQ8=;
 b=K3KQ+hTQVfFLlt679p6UsShUW7Ac83iLTRhNMDLgsJew56tpUrsUhiGBVGw3Xumw/pgm1I1XeG8HZunHi9kSF/YwLUlD9I4j7BARB3Zt07d465k8dIljv7FyxOaJWqIF6kYPdqeLVPvKvwmXAiorO14vol5icj28rjfRBXtbFRY=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by GV0P278MB0967.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:50::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 09:59:07 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::4af0:da57:42f5:a6cf]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::4af0:da57:42f5:a6cf%3]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 09:59:07 +0000
From:   =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] 8250_men_mcb: remove unnecessary cast when reading register
Thread-Topic: [PATCH] 8250_men_mcb: remove unnecessary cast when reading
 register
Thread-Index: AQHZxfEkXjWzH89ZmEuJM25yB39MSA==
Date:   Thu, 3 Aug 2023 09:59:07 +0000
Message-ID: <20230803095816.110864-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0516:EE_|GV0P278MB0967:EE_|DB5PEPF00014B9C:EE_|ZR0P278MB0776:EE_|DB5PEPF00014B8D:EE_|ZR0P278MB0895:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0f315a-7853-498f-e561-08db94084c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: x2MpdVCRyZ/HJjxbR69N/NiHrTSramqny6qELGto+mj+rmzJXxdJman2NrtRFFxMx+P30EbCFXuQ1T3oKiB5ruwWFORdUuM2qjNEElg2jd4jPe3m5wcBxd1DrDMGPH+BqNVAkmHJBPxo1jCN2Ls1SiT/xeP0fbyef7l33Jal63UkVxj76/46Woy8MY4OILiUWwR2c+irgpfb5tvJ66UAZhatDemGInKmQr64ocJkLO+L1pIC5YmtaXndv6P5H7rTwQn1XZXKhfCMwHuaoBpT+XAAyH45lINSdnkoWHqx2YeXTipEYoZIuaWDBWw1HzIyVIM6q9G/hNXMKI5VEheUpny1YDeFSWgGg8ORsyOxcvnDbfejVjXYMYWxGpHhKvwgTcrMuDR8yxkNizWT183R4ZSNZpo3aHdSQ5MdsAe2iqljFtcJA10/yDBHStQbVs7NSWbf8hctkJhW2uInQHGmvHSnIac8LEH+bB3ne8IreLIf0kbpxzUbQ/ZfDzYAp8iiBzp1TTEH9UtMzx7D3Q6xOilKWNEL95XlexFuOJ+GR4qcF/T9SYzyoN4RtsqZH4bPtAq1Cme0BG7J+Y2BLhJzt+T2bigU40iv1dnll4gkbhg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(366004)(346002)(39850400004)(451199021)(83380400001)(54906003)(478600001)(8676002)(8936002)(36756003)(2906002)(41300700001)(5660300002)(91956017)(122000001)(316002)(6506007)(1076003)(186003)(26005)(86362001)(66556008)(6512007)(38100700002)(966005)(6486002)(66946007)(6916009)(4326008)(76116006)(66476007)(64756008)(66446008)(71200400001)(38070700005)(2616005);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0967
X-CodeTwo-MessageID: 62fc6aeb-559e-4e4f-a702-ee60a404f9e1.20230803095909@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: a9828e9b-add3-497b-66db-08db940846e9
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: SHGeC56LhA1RoT5xGA9Sz4Tsm9GOo+3wvsRv+Z/OfLfrUkFTPMVnGm8oMDm7a14Zcc9sw87+0X4PUMX7t00ri+VQJ+oMwA5A8xojivUaToaIcG3lFW2hgXhr4Auaw5MaWouj4ysfgCrU5yhoMMnEHoLUrjif0MhhWnSUYb5KVAoloes/z9eOiD6oHJRTghqKIa17n6nfC3IVOZiC5N17Pbp9DnHQsCsjmVRwDfc2Ap3/sXRfHQmpAXPNG2R/kf12ZaO0csbP5GySzd9+0mq35jQrbuXac+n4LgGOgCd8iVzqBjae5X1gtr2OrICFCmJj7wlh3BkybD8NAV5p8p5EpjzswIkTcChI29SkXjaHk7hd/qmIWad6N9FF+j577RHvij1W0YE+EiieFv8SGw9sbuy9zbh6zhTcRobylGMf4nV8kqJVCZjDyFSL4kTySRegDXgeFHbIDaMBh3uuomoUV1czGs0gKudRIn0wI19lGUcvUhCEMr1RXs2sL+s6mf0GFq3ngXj1A0BBcpT+TL5NNCG+qfN/1cHD+TF7hFf06xL2XK5noP80UV1QkItnu5Uo+tw+aB82w/5ILZUUimikQyMp1gH/XPO1U6EVsscTcoM3ugINYHmuXzsB5hDblAf55KYCnehwhWiFoeZNxyP+ekJk1fP/v8vBZ6lFBj31p/MNm9Ht5N2/7XseHdGyrTbE
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(136003)(39850400004)(346002)(376002)(396003)(82310400008)(451199021)(46966006)(36840700001)(40480700001)(107886003)(5660300002)(8936002)(8676002)(41300700001)(70206006)(70586007)(6916009)(316002)(2906002)(4326008)(47076005)(966005)(54906003)(6486002)(6512007)(478600001)(356005)(7596003)(7636003)(82740400003)(83380400001)(336012)(36860700001)(2616005)(1076003)(26005)(6506007)(86362001)(36756003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0776
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 874a4c77-76a9-4c64-5250-08db940849ac
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHkTOdHYpJJbXgAfjGHKJhbY5qCZ3c/ZMqpHKNNGb3Bn1On03FUcv3yuL7R2ThCtFRLDdGejKaoYPO4RA4xMqiAsoVR1JytyfSBEoF6GuZ5QICY9qTFwO4L578OrnN5sDqFFwcPqx0oEBLByqf0LYa2dPuiM5ml3lwXVkJNYSS+w8DqnZ7oxa2AG3Jvy1iHk2YxDj0Z2xFmhDirlyc55ehmgu/FsbS2+4ro5I0afV9ramFic3aAEZT+87IgSlYyaFAa6OKIHP8c/tmR43BvR06vfnRtRb3YBKjJhBHW8y3I5qk1jvdyPdV4gp/vfcUyhnEaAIRHSHRdWTAvxBB+MPi6NILD4MwZdnphOzIRJaVfaKOlKxLytHlerq/vkuvd2uh9qAqN2BoLPm81DdIDhsALceqfn6QLaPXR9HfEyl9S35PxwXnCUWtk1sOZ34GpZmkkRChNfCoSsKy7NQpsd+fRrv5YgmRglmazes4wSUGRNiH915VTB5IX7Tpqkc26GGywQTnULt009K8/NqqpoFj0VnBpi65MYGcy7KKfbvN3Kodo1c1ilMxk5398Fd6Z2n2tam3T5RZrUMZKCsN0/G2TKqpodvSBpvJyM9hScFnuDLcjWN1iE6ZzCfePZ1qhbmDCj9fc51b9Vm3oa8NisDpotCXQvgCFUGhOSwcWAdp+CDi1MbRbVWFjv7csYfywv
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230028)(39850400004)(136003)(346002)(396003)(376002)(451199021)(82310400008)(46966006)(36840700001)(82740400003)(40480700001)(336012)(2616005)(1076003)(26005)(186003)(83380400001)(47076005)(36860700001)(107886003)(70586007)(316002)(6916009)(4326008)(2906002)(5660300002)(70206006)(8936002)(41300700001)(6486002)(8676002)(966005)(6512007)(54906003)(478600001)(81166007)(6506007)(36756003)(86362001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 09:59:16.0533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0f315a-7853-498f-e561-08db94084c4c
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0895
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes following sparse warning:

drivers/tty/serial/8250/8250_men_mcb.c:92:21: sparse: cast removes
    address space '__iomem' of expression
drivers/tty/serial/8250/8250_men_mcb.c:92:21: sparse: incorrect type
    in argument 1 (different address spaces) expected void const volatile
    [noderef] __iomem *addr got void *

Fixes: 2554e6ba28a2 ("8250_men_mcb: Read num ports from register data.")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307261517.x1O9OAkd-lkp@int=
el.com/
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/82=
50/8250_men_mcb.c
index 5f301195575d..72f9ee5dd274 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -40,7 +40,7 @@
 #define MEN_UART3_OFFSET	(MEN_UART2_OFFSET + MEN_UART_MEM_SIZE)
 #define MEN_UART4_OFFSET	(MEN_UART3_OFFSET + MEN_UART_MEM_SIZE)
=20
-#define MEN_READ_REGISTER(addr)	readb((void *)addr)
+#define MEN_READ_REGISTER(addr)	readb(addr)
=20
 #define MAX_PORTS	4
=20
--=20
2.34.1
