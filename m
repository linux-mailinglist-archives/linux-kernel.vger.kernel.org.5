Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1DB793F08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbjIFOg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbjIFOgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:36:55 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2108.outbound.protection.outlook.com [40.107.24.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7AB172E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrTZ20b3uXPoprD8V/LgFVrriIngsTN8/hTY0psOqmk=;
 b=TzIhn1bi74qisKK7vgIu07DSCEjmfRrtK+hDo3HsgGHH51z9ZebzMUWgd9v6T09olnwvjInmkLKz2sBe3mnDsyZNNTrQv7GsTfBUlK6MAULDRJWSTykV8BlW14XAet4BoYbDpLBDRs1VFVdGKvsDYs4+R5u+fZLRm8SL1qkKZY4=
Received: from AS8P189CA0013.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::22)
 by ZR2P278MB1004.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 14:36:46 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:20b:31f:cafe::1d) by AS8P189CA0013.outlook.office365.com
 (2603:10a6:20b:31f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 14:36:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 AM3PEPF0000A798.mail.protection.outlook.com (10.167.16.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 14:36:45 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4RglLj4HYTzxpD;
        Wed,  6 Sep 2023 16:36:45 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2048.outbound.protection.outlook.com [104.47.22.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Wed,  6 Sep 2023 16:36:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lqn0TPdeQUyqUWFDmp+plDG3xEerXF7Dfz+DyqdRz3BO1so+MXDNh0Tl50xVQGIaK0cRU5zBmidaQi3ElX8RZUTowHeinKQp885jgrgr8sX4f2mnqi9vLDq1V1IU7xt6aMsvcoGTA/WcAhUGkEpMmRKINzpG2V7ns06R2hB95XlY9Ou8NbLsTRH4S8QTlC6arH2WHYj2c3YeTPWlWUkrfFGvrw8bzyf2giqJipRt7YT1cQbqRJZVdRda3n1UO5zl1/Wb3VDKZvVimEwyRI2O9i1jQEiuLRgnr0j6uze7AVuBFuvcHIktLnaiQxIptNPmbEq8kpIFKZrjsWbXfmVwJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrTZ20b3uXPoprD8V/LgFVrriIngsTN8/hTY0psOqmk=;
 b=RmX8YzgnwQ45hFcni7rfxcoRtTLifdd1Xij0KT0v7UXKk46ZPuirbULrnWGEhvxClPVK0stt7KiOwIUmlKcfyBpjSJK/hZHvvm52Mjw4+/Kr5iNVdeAOKhGLI4jVr1qgAmeTJJNlGNT0e7frLmrTBmcBdEyGtNb0e4V3pU8RaI8FOg/ceuTSdRP8AFjQvHsB6yFLspemAVB+Cmg6t+A9x+fk5vfnLXnu+G9XkRggSGdBIzvqlMhq8gZkvnr3IvOd4pamSO7kzKZcceeskNEmzAcDbFV3JnftRPZgTt96ncF6lBps6QTQXrccg8x7ZccZlLzutTSkk/aL9egtXaViFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrTZ20b3uXPoprD8V/LgFVrriIngsTN8/hTY0psOqmk=;
 b=TzIhn1bi74qisKK7vgIu07DSCEjmfRrtK+hDo3HsgGHH51z9ZebzMUWgd9v6T09olnwvjInmkLKz2sBe3mnDsyZNNTrQv7GsTfBUlK6MAULDRJWSTykV8BlW14XAet4BoYbDpLBDRs1VFVdGKvsDYs4+R5u+fZLRm8SL1qkKZY4=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by GV0P278MB0733.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 14:36:43 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b65e:7aa8:46f1:f3c5]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b65e:7aa8:46f1:f3c5%5]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 14:36:43 +0000
From:   =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
To:     "jirislaby@kernel.org" <jirislaby@kernel.org>
CC:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
Subject: [PATCH] mcb: fix error handling for different scenarios when parsing
Thread-Topic: [PATCH] mcb: fix error handling for different scenarios when
 parsing
Thread-Index: AQHZ4M+OD6eFP0jc6UK0TqOH0ct9HA==
Date:   Wed, 6 Sep 2023 14:36:43 +0000
Message-ID: <20230906143605.1877335-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0516:EE_|GV0P278MB0733:EE_|AM3PEPF0000A798:EE_|ZR2P278MB1004:EE_
X-MS-Office365-Filtering-Correlation-Id: fb05946b-9730-4cce-eee6-08dbaee6b25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4HYaGcbrxNQthyOeRrn/uASzcK5/oTYeAw5T9XhzWZqbt/opRyYezOfR6A4t4gn10bccDsQL0EYhKtQ0Vgiy+IXJ78aL5HOoOt7Rt6B0Tfe1/4xWfSMZmQJ8BACvJdYxdc9/bF6WnhR8sSzbubbCNOODySOscw73eA3/8ZPXP8fww3jMWzEDJIN0ReSHIp4IrOgTW+eM8VAyZZpko6esGELWW0X45OGRaH/imJrjkCk7SzFb9os2vgOAl5/e0LGLQduupRiPu4+4cMRSJAc/Q7N62FhnY+A5jvPS0QV3EsmbAS6fWB0o1HhQfpKz0B8eQmYgJMbdA+pizG+9fw1s2of2bO/NLYe2NpFdOIzEDU2LYhEV7t5w4cx2zph/6mLi63GNx5ZJA9lkhQOF4iwB9ZhXX3HnRQCOjGIw8IOyFhyvuGMtKL6h1crkmMjhsDrgDNFITmBHmyuUdC0Fsc5u298yZQ8EgU51X44et2aNpWtM9RQ1QFBGuL5oLrZJsUWFIrCrkGKN75L8SriBy7axJhNEwUhdZIbuq4Y4Qm+dtSW8PZex6dMQgPWazN6FxC1QwdqAKTK3vaXMYZjZsRlNoJSe76919c1Aiuyzz/rzXmlfNpkBwmS1YPNx4axf+V9+
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39850400004)(136003)(1800799009)(186009)(451199024)(71200400001)(6486002)(6506007)(6512007)(83380400001)(478600001)(26005)(2906002)(76116006)(1076003)(2616005)(6916009)(41300700001)(54906003)(66446008)(64756008)(66556008)(66476007)(316002)(4326008)(5660300002)(8936002)(66946007)(91956017)(8676002)(107886003)(38070700005)(36756003)(86362001)(38100700002)(122000001);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0733
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 828ba612-24db-4253-a255-08dbaee6b092
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FLFVMhvvHoWzjKMTjEsiB+CGfRCwxrJw2Mu1vOrcMpO7P7++dZakfbgMRhjRlkrKA3dppIryLm1+zyqR55FHOfPsEQ2SxCbfRJ9IA9IGvwEOv1ENs9AGPASbIhAHwkE01BJr2RfjdRFJ7Prgb8z+y77JOPFixel6pia2ZPEEXuqW+1UzXGcJRh5H/pShNA7On3Cw6JmpdvYTGSsNZmnzhoe/AHXQgfR3lPvJ9C7quzrPfGasjt8Jo7dW5UxVklCqK94VidUO06UAMhBs91NKPE3TR0hkQ2Z84hVQgwyG6sVyY1KNDxawFb9bT7tG3a7exVWM6N1A/ep5QQZYi1wd7q3rOXVQ+ECDr1Jl1m3mwVHpQj9UQrk4Ch+BJblMByFKrDgxUfoqNzXq5ziaekRKqciNwjYYHiJP+z/epGxm0uR2Uwez6PT4hzEDNvvt8cmg+1/VARQnGCV5EVUtJuVFzwhyHIkfSqICFFDq+ci6iA/6vDawmDBfJaVLDDZaRcHXcgdf+ggL2Nljad9yjdruBLli4YI1M+rXdk+ppQ4H+ynt8u47jFCg8pwttbXsoDS8HmMYM/bkZosGTyYtYBqGvDlUUKa/pB013QcPh3zWnYclAHVlXHPge3AiaG3ts8C2sZljkpsEa9LoPdl3WGVSmNgTMzRPWsrXYKLSJM7adALz4zrBreM+MdEabX7MgoCjjVBsl6QW2WSy0MvGvawLGPrHYD0DUjb2CG3vDs2aa3vdbLTAjXKvrViK7GXSnwKc
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39850400004)(396003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(83380400001)(36860700001)(40460700003)(2906002)(36756003)(47076005)(86362001)(40480700001)(81166007)(6486002)(356005)(6506007)(41300700001)(6512007)(82740400003)(316002)(2616005)(107886003)(6916009)(4326008)(70206006)(8676002)(1076003)(70586007)(8936002)(54906003)(478600001)(336012)(26005)(5660300002);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:36:45.9056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb05946b-9730-4cce-eee6-08dbaee6b25f
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chameleon_parse_gdd() may fail for different reasons and end up
in the err tag. Make sure we at least make sure we always free
the mcb_device allocated with mcb_alloc_dev().

If mcb_device_register() fails, make sure to give up the reference
in the same place the device was added.

Fixes: 728ac3389296 ("mcb: mcb-parse: fix error handing in chameleon_parse_=
gdd()")
Reviewed-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.co=
m>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
---
 drivers/mcb/mcb-core.c  | 1 +
 drivers/mcb/mcb-parse.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 2f23b9c3b751..f797d078978f 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -247,6 +247,7 @@ int mcb_device_register(struct mcb_bus *bus, struct mcb=
_device *dev)
 	return 0;
=20
 out:
+	put_device(&dev->dev);
=20
 	return ret;
 }
diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 656b6b71c768..1ae37e693de0 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -106,7 +106,7 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 	return 0;
=20
 err:
-	put_device(&mdev->dev);
+	mcb_free_dev(mdev);
=20
 	return ret;
 }
--=20
2.34.1
