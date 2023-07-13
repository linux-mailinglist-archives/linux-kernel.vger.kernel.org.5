Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98465751DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjGMJyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjGMJxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:53:46 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8496826AD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:53:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6wzC2woOQJQafuwFQCeEteyTjjOUdhXqBu3bSm7ePeSl/qUT7VUXVwZy8rf5Veam9OYkBQb6jn66lbD8WCNide0U4AL3/K6WhM8WpYRJI9X7rLql/1d9jnNWP4qjaAQAtGJF3c5Nl777jyuvEn30rNapuETARLSKIQ6nA/X0JKn+qOTvu5rk6RFhFlwlrpdFm39R5Rz/K8ovsZrXHH/VLuPO6d2DrfqB8CVH6nJuj5tWTK7xKLz95SzUfXQGIjidd/ojt8ay/3i307roy0ucLA4GTsMeq41cZQFVjkzY+8Z+2fSVPZcdtkv4DZQAYBN++qdwajpYqXd7lAe9+JOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aB2fibnRkf9gpP0Xfogz8LqxY5FVl78xUR6gFhqv4I=;
 b=LG63bAV9KYMOvdHnyUKlZ7Gt8Cjf8kX1fubboPRNSiKVLRmQSM6dLubj+l+p/kFSC8jiXu2KrADRaNBLpelitfd9bQFVYK5nNQLTBc9kGbBRa2enT03bqVfW3Sie7Sp3Jk2lEhrqxR1FVWyTyuYiAEs8MtgjUmCu5dW6AHAkzB8RjaRsNpUz8EWn92oyuq6UUPCFyxTcvfjPS7JJli1GeR4i1qZATon7yjBgindZD7Bws0ugE9SmPxXDzd88qSuvWyJK0QMjR0gRW+q4ufyuCMQsxp9bkhT4IRf8LSow9t8avxNsm0BljxVRjeY2ZpG58yUWLZMOq9LMX/FnfYw+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aB2fibnRkf9gpP0Xfogz8LqxY5FVl78xUR6gFhqv4I=;
 b=h4+9rro67pRd9Naac8frsklDV/H6S5Sj7WHEAWjCuMuMv7m2PaZXOxKniqI7YE+ack1I7Nyx9P36r1YMunbk24ORmEhVaZYp4jadQUIeGF008Yrjiua6E8lv/4fAPSpZDdWPGQXd624XwK8d1TS7/xwK0lNp91+e0wRP18vNjYEESD26mDr7awUpQM9RZHOr9moFDc6DWrMegTcpVgBbSQpWB/Tu0sqevdktZgIcGCML6pBmVofa7x0cQOYP7b5afr3Yc3yNTe6zqNJ1nxl0rK5XaYCRiLF9iHEc+mcj1rjhNPFrq6Yp6fHuAFj57haunLCrzspMg6TFEJ//FGCdSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SEZPR06MB5592.apcprd06.prod.outlook.com (2603:1096:101:c8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 13 Jul 2023 09:53:37 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 09:53:37 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM PANEL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drm/panel: nt36523: fix parameter check in nt36523_probe()
Date:   Thu, 13 Jul 2023 17:53:27 +0800
Message-Id: <20230713095328.13823-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0190.jpnprd01.prod.outlook.com (2603:1096:403::20)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SEZPR06MB5592:EE_
X-MS-Office365-Filtering-Correlation-Id: dae7b807-2ab8-4b93-6aa6-08db83870729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EE772PW42vB5ok2InHmTr/ikWOUg+cygkaqE+nfb3dRA3fADtDnbFvYTls3X/qkcXvVNSkt/bKFh2GXaZmjEcY8XtSSkq8era9qh+op/v1jLYcaHs6VjU9Ixp214hK1pHRz/uVx/CpfvL6NkIklyNM5q8ZGlIgQKilsnQhAyZBZ+046mIgBR6tyF8zovbxNKBZgIXvnMUc092w24VF+sG77IqEIXFd51GodvktiggyRYFWv24WBnlaUWBBU1OXZkNzLa/oD1EA3zH8n8gW5PIzkkXT+5/t75Gj2DUo5Mz1H809U6wwk8gQnSt902qZuP7AZw1l5AzC+is2P63r7lZdR7+wi5QslrdVgn3A49pMwZQVWlZQKczHD2YAqcm65t0sgpW049ch4fv3n7EhkPV2Veq1gf7kiKMceDiQ1eYAcjpYxYYWOYsN6Y2xRQNIepIHHAVBHLi+4SqnCNtZCx4Zq/D4fxueIhAbLpqvHBF7RUj/cuxNMPe2pkSNXVyIhucUhVxx2oFaAdCK2UIKKhqB8vPBz4avQz1ldtSN84K2fxPJnbHvLGybUSLP8gMiQht8lJGt3UmFZGDK1g7xGT1FXrbxTIpHRZ1GM5S2b/JelxQcP2VUipOJKBZV+8/qaY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(66556008)(478600001)(4326008)(52116002)(36756003)(6486002)(6666004)(41300700001)(86362001)(66946007)(316002)(110136005)(66476007)(83380400001)(1076003)(2616005)(186003)(38350700002)(26005)(38100700002)(6512007)(2906002)(8936002)(5660300002)(8676002)(4744005)(6506007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/4C5FTMeGWTK4Pt3oy7MVu1oOH9nsEQwts4C7Z9/rGZ6OWfWvnNTNSCb46i+?=
 =?us-ascii?Q?vxANiXOQTFDM/NWqysIGc44UxtZxKamDWjBUncE1Ma4xhGRR7vCkbT5bq7zM?=
 =?us-ascii?Q?s3f5v/5lywm0Y+Tw7c5M/IOZrwVjXEPLoK0D3pZHTjDZzcyK9V1D+j+IHit9?=
 =?us-ascii?Q?Qkp3muPbeEQO9ONFSRv0CV0u4G2HL/vdACgB9C1b696Zmyv6yY0RyZLJ+ruT?=
 =?us-ascii?Q?9fkHWFH7WoEOxFNMMEcL+N5vOD2xOF4BhE0wAcaZ2KejvY98Ivh1dzYVqco6?=
 =?us-ascii?Q?DrXPKx13W/+/GLwnMOsQsYOAssuqwcRW9GBOgVLIWxBKHXeVM6c9kI6iOD+e?=
 =?us-ascii?Q?QZPtLhChQutD5a9kVVtAonK8Y8vDYFcipnMsrdvjYyfeTcTygFUmjStk3koN?=
 =?us-ascii?Q?XrMTHecDNVG7Gcz6NCcF8ZIzv7AfxS1h1Nro6eUQNOaZUHrVXIkrxgACksUM?=
 =?us-ascii?Q?dLKy/HLvFoIrE6N9ACbTiBCVGEvVC0QyIB8B5eb/FHIoBPS0j7VHC7mJavBf?=
 =?us-ascii?Q?f4SgVwJ1nLPc2vKyrUmpoym07yFnFZ3ZcBiMNURABaxV/QSi/P20NA9tnlSA?=
 =?us-ascii?Q?HiLJ7b5OC908jR3+yEpVp608pnLGT6bzWO3BUgb9aWrGYBCmXaeoE+cKE//x?=
 =?us-ascii?Q?BcSWaP5twLGpRNBF2ty2BnaMWZs1E5OMxKXRAaiB/aR/CcNWiF+eWkDQFdkC?=
 =?us-ascii?Q?ZhH9eQd9yua/ozDYanAPRivJFnFKrS9okN7cLT23HOt4KO5l/H7zKWc0NZGI?=
 =?us-ascii?Q?HOEEZxfeydtvth9Zpq/IFgUFOMETJePN+XyU2bKv0dRWAnqfUuunV38Whz+F?=
 =?us-ascii?Q?qGF7r4InZ1ov6HUnnsayzF9JSaBfqAfElTh8izLcg7z9zm4Y0JNjsf5/BU2n?=
 =?us-ascii?Q?Zd74RoVGrvWflJrJbLYpfJz7/uGMubXzcTI9xSRuct7YKfCgylJCIqkGD3hR?=
 =?us-ascii?Q?WRBQEOy4Ssp+DUM6dIOIz5LCGvc/uyUgLKo7VE5BRDsB+kKUL5Hlvt3eFH3D?=
 =?us-ascii?Q?dfsThoIESsxZKeDM1VNX20oY0AZFo/bE9d1wx/3EH7iIqA/X06eI/N/fHWPQ?=
 =?us-ascii?Q?eILXWH/SnimNFs1/mLWRz6wSQmS/PSaTgrEH5wSxQNkZrezoDjYNh2gWPg4v?=
 =?us-ascii?Q?R3BNuiAojQT4fKVFvTHyiUoJ6B4Il3ek01HzZy498GJcsfD/2WDktsbke1Z5?=
 =?us-ascii?Q?IKsvePP0wRpnHV2isTuIVHvwUxKSayUWEMYC2ICl7ZVX6QLcpPc8Oj5+s9y+?=
 =?us-ascii?Q?eR74cJkeecwxwKecgcpQwAmsqlGjEpdypqUSSgYRv0xe4mncHQHmf5r6jhv3?=
 =?us-ascii?Q?AyuK8rdxmpQNyd++/rh0dl/kWQe+fXeb7iB9t3Fmp65YzQtDHpCFIqCNcfVd?=
 =?us-ascii?Q?2NPXbsxSjaygh99uX02Tw3Sdr8o/tvPiMFBkDF5pHrvdpIDVoX+MFx7+4iH4?=
 =?us-ascii?Q?Z+AxudR1TtewlQBdLnqRFlD/1U19yP4zbW0qHliVDXWWuDlVlLIRQI0EOlEp?=
 =?us-ascii?Q?fHIjfOrEYBeiTop1wr9AxRcgE97yjRqh8PwDMnuWaBpCy998b7xc3dOiLSr0?=
 =?us-ascii?Q?R5rh9P9k8zVq9dw4K2UZbIAvoRjCePiNDeDi5Cyf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae7b807-2ab8-4b93-6aa6-08db83870729
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:53:36.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJGYWUTABOBia/Lsguwmi/+s4KzskCDm4cxnaFa5BdoMxvOqI3SKyepGWuoCyICSIGA8pgZ1BQc07d31NjYYlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5592
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR() judge the mipi_dsi_device_register_full() function return
in nt36523_probe().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt36523.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
index c3befa7f2..3823255a9 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
@@ -1266,7 +1266,7 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
 			return dev_err_probe(dev, -EPROBE_DEFER, "cannot get secondary DSI host\n");
 
 		pinfo->dsi[1] = mipi_dsi_device_register_full(dsi1_host, info);
-		if (!pinfo->dsi[1]) {
+		if (IS_ERR(pinfo->dsi[1])) {
 			dev_err(dev, "cannot get secondary DSI device\n");
 			return -ENODEV;
 		}
-- 
2.39.0

