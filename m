Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FD076702D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbjG1PJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbjG1PJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:09:05 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2093.outbound.protection.outlook.com [40.107.249.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873652D5B;
        Fri, 28 Jul 2023 08:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inpI/HPjl3SeYVIvrkVUYmjwUc6tBL+IBy8wZ8KAXg5MahLjvtw5LCSfBDucqUVdTn2o4VARt8tsROiI+SWciGn+dH+C5/yJevtYp4u6ka6aQwdiTyxnM8ovvKRIHW/DhEDIc6Dy+Yr9/lgGIXfhdTJju4I2rfgQkkNsAIKd7fsXf+1XLajURXq5q2cPubKhvr5lkRZXK9FmPD+bPvMBj2zzN8h4Ykj4DeB9OYhBBtu4GUDM6Qb3RfgNHTotbo58nH25IqaIZ4Y4wVdqUHgoaFYI9KeeeGQfHqSw+0EeQbIPYwz44xUuBztlZxcGUyZ2lRo2aPeKUoFav6OagpdQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L45wPkt2pR42iFMWPd95a6vpooyNseyqRicIpQOVQ3c=;
 b=PXTlFn7tqtr+ZLi2nXUIpdBXo2uxdhdDuSBPs7C4K8zKsY7Xkn8W4UU92Yi1EzAl/vwddf1T8ZlIP3h+2nU2iery7suMsifRaHdO36pFle0FcMML77mQpxYozBQQBNg9otjmNFeC89mRNQ7qRZelmpPccB40vnfgu6RV8z9JtwFBFRkPuGPFoAeDueKPAXjK7D0k7SvJGH4mXP0w6U9nM/7y3kRQg4QRWSkpwUWDtqkdts9PrFV5SXbYUtUCCR4ECUofUvdjvfMFutUx9MSRb1ouMPEUagH2HEqqXXlNd6V/XudqnMLOYvIJ3SlctoS44d3EFCXKYheIYCds/ho2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=esd.eu smtp.mailfrom=esd.eu; dmarc=none
 action=none header.from=esd.eu; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L45wPkt2pR42iFMWPd95a6vpooyNseyqRicIpQOVQ3c=;
 b=JmIKOLZtUiBwCivivx93tS2C8ivhoNz4CsVN1XX9OiofhvkjknLpo8pw++LYP6IQzpYyKKDPlNslmI91GkWxdmoQ5Mc9blPe3BoLavJvOmo0qogTWbkiUY8og6y7Ijap+3SJ/Wut4dCL9Iqw2HEh5eUvdR+Kfb/uTBdbibnX3u8=
Received: from DB8PR06CA0036.eurprd06.prod.outlook.com (2603:10a6:10:100::49)
 by DB9PR03MB8376.eurprd03.prod.outlook.com (2603:10a6:10:397::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 15:09:01 +0000
Received: from DB8EUR06FT064.eop-eur06.prod.protection.outlook.com
 (2603:10a6:10:100:cafe::1) by DB8PR06CA0036.outlook.office365.com
 (2603:10a6:10:100::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 15:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB8EUR06FT064.mail.protection.outlook.com (10.233.253.157) with Microsoft
 SMTP Server id 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023
 15:09:00 +0000
Received: from esd-s20.esd.local (debby [10.0.0.190])
        by esd-s7.esd (Postfix) with ESMTPS id 5B1ED7C16C5;
        Fri, 28 Jul 2023 17:09:00 +0200 (CEST)
Received: by esd-s20.esd.local (Postfix, from userid 2046)
        id 4B3DD2E1819; Fri, 28 Jul 2023 17:09:00 +0200 (CEST)
From:   Frank Jungclaus <frank.jungclaus@esd.eu>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Jungclaus <frank.jungclaus@esd.eu>
Subject: [PATCH 0/1] can: esd_usb: Add support for esd CAN-USB/3
Date:   Fri, 28 Jul 2023 17:08:56 +0200
Message-Id: <20230728150857.2374886-1-frank.jungclaus@esd.eu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR06FT064:EE_|DB9PR03MB8376:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 929b3343-63ea-4828-f222-08db8f7c92ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sM7azyCZcyxwyL+fQr9MaOGy1qO5OH4RTdna3EvcFZlX/NMYuszYVhcAhI4GhCqhXHG9b6feNeh2caEccvdh268govrXPd0B/5EJX6yXu9qGJUBlqEdUgG35niZ9B8iEjFv14P3BGQ247N4h6fp3lVsU1Npu2DFuEg34xMe/c+5G0tVgEkfKkvk8y+IMxd6f5m1tr/CleLXVWJfFLRAaZVswkSLirwO37VuAzueteTOzPF982shTFBurSIUL5Old6GAgq1RFdrfij50UM+CyC7rbikKhYHJylsZKNS/vkU4t9KcW2C3Bvybxe1Dm8eugUNdQvAQEFBoNNhO8+KmbCvQc3q+1iABuBFJMXns/BNunir33JaeFFcBnd1Swi+IFaJj0MLho4gr4vkU2cvJCRHDROch3zWFBlVb4+CJZN6VecTcpPTKlsqGsutUXcmMb6m6Y5FBtFcPnlYq4pwiW41csVQ6AI92tkD4nEXmPZbe+KM13O7XNFsvE4HES/fOxZ3unDOqGWzv2XfSpxJztQ97qYxjUYg98UKd+TTEJGiMzPpGVDdi+PJp8FyaKlitXAqlZ3llVzIhE+Qlc0+ckmeUAVVAYDDt1hmdGO+tEjI+XSmzVEIl0NZJf+DPD6+OmhjgWgoI4GcImJAk5Ix3Ak0KnlBh2oQxkFdbbxBDuW6UFQqCy382f1gwQgFLyVFWfvGDSVzIOeKPcMHEueBuFHA==
X-Forefront-Antispam-Report: CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(136003)(346002)(396003)(82310400008)(451199021)(36840700001)(46966006)(70206006)(70586007)(44832011)(4326008)(110136005)(54906003)(6666004)(40480700001)(356005)(41300700001)(81166007)(36756003)(83380400001)(2906002)(478600001)(2616005)(36860700001)(8936002)(5660300002)(8676002)(47076005)(6266002)(1076003)(26005)(316002)(336012)(42186006)(186003);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 15:09:00.6771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 929b3343-63ea-4828-f222-08db8f7c92ff
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR06FT064.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8376
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After having applied a vast number of improvements to the existing
CAN-USB/2 driver here now is a new attempt to add support for the esd
CAN-USB/3 CAN FD interface.

Beside this patch there are the following to-do's left for follow-up
patches:

* In principle, the esd CAN-USB/3 supports Transmitter Delay
Compensation (TDC), but currently only the automatic TDC mode is
supported by this driver. An implementation for manual TDC
configuration will follow.

* Rework the code to no longer switch directly on the USB product IDs
to handle different device setting for each supported USB
device. Instead use the driver_info member within struct usb_device_id
to hold / point to specific properties for each supported device.

* Try to switch from synchronous send usb_bulk_msg() to asynchronous
communication by means of usb_submit_urb() where it is feasible.

Frank Jungclaus (1):
  can: esd_usb: Add support for esd CAN-USB/3

 drivers/net/can/usb/esd_usb.c | 275 ++++++++++++++++++++++++++++++----
 1 file changed, 244 insertions(+), 31 deletions(-)


base-commit: 68af900072c157c0cdce0256968edd15067e1e5a
-- 
2.25.1

