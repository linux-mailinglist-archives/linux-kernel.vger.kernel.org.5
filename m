Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC23E75FBDA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGXQWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjGXQWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:22:19 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B094E10FD;
        Mon, 24 Jul 2023 09:22:16 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OCkHFe000861;
        Mon, 24 Jul 2023 08:00:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=bqgJds/w4CVuNNwp3QDQVOmEqkbgcc1ttbY6+n3mxQc=;
 b=F9Kl6EK/LKHS1jjnKW39VOMKO6yD7b/J9DNvsRYPryCHNXDyYEJjZb2MTQYVByNd8Pap
 Cllm7JJzlD2PAF4iiac97lFu1s5u8Wo5qoMgRRW7ctOvlAMFUPwxcHOa+H76Cqua5rfG
 PIiNURp5ct/aOtpsYItcFNDmxZQPFfQMu+Cs+v1gaLsu3AuKHVKn9dKE0nOjP5yuqynv
 BuvaQcpo4xhGECsFRtaIqfKPZwR7teP2qEtPzZCV9mSN9hfwiQSGnPKyWjy0+gMzD2XF
 EPx7wTUuTr15cqal6Plkml8nZGanMZbKvwFACBSU+JBYueNJiGNU7tt0TWpejZWmsNZD 4w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3s0bnwx66e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 08:00:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyT+/QkkF8Ub2sWsp8m1T/r9wORNn/QbAR5LO//tobV9vJuYBH5T/X9H2Bn+U0KD8xl5opaf4jqvGaPRzBhGtf1oQ7xjK2QMe0YslDGOSWIh8C9kxYY/nVYom9BVaoDzzl8ryPdZbTdzKWIz+IR63NTdIkRSiaNm+rpheXxZPLrWC5ZZuM21HbGmt9D1Yy5sPL8ANhhlXedrkvAU835cONlLXf4SNSOtT9GtROqjhhuoJxQG/UL5RhSvl2rXf9Ls58ViNw8dBXfp7Acb8ntj93b74nN6sAJNVt9GEL4GFuBuiwGVA3p+pEB4qxlJ5hRj53aW6Fb2+lMugAm2IavBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqgJds/w4CVuNNwp3QDQVOmEqkbgcc1ttbY6+n3mxQc=;
 b=VYlPQhTpMgFil8wJ7fRpBilt5BjojpVYCnXGjMuZ3VzDgyODkxYSl/sjPxMYI7KIhmAZPiCp3zLWHIx6VkzxZsNdMljAbbVewCGuqbtVCFVclVxOIT7lEBC11ARjKvUwPzl3lAKge4xkQnT3iKw2iR1QW62PETCpX+lpP4Iy/3WxpvrZsLE4a0BazTvwZ8QPUS3E9EK/Dlg/5JYAu5PqtJM/T7JwKdzydR6xFTVT9oozjFYwkHKf5lEbMVuNLBqoMEHyuckkYVxDssOSaKVkrf3QcLXFDa1HUhbeVZyqYi1TAjp7KGRXxX0F/0qBPTr4GzmbMAzTd7XwHuFfGxE6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqgJds/w4CVuNNwp3QDQVOmEqkbgcc1ttbY6+n3mxQc=;
 b=zGTVHMj2roSiKG5yWctfTqpf6e7XKJzMlRLbVGea2JFk1DUJHJW3L1SDEsuB1oHTyjOibcpN6how/LhKEsUfaNB3U//bsghEVP9OHomYXKALzka0n6vtia+MLnmkyWyvGvG8BBfiWJxWaK9DKdsGgQsXfSckJVa+DHsNk5awtvc=
Received: from BN9PR03CA0981.namprd03.prod.outlook.com (2603:10b6:408:109::26)
 by BLAPR07MB7572.namprd07.prod.outlook.com (2603:10b6:208:297::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Mon, 24 Jul
 2023 15:00:10 +0000
Received: from BN8NAM12FT054.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::c4) by BN9PR03CA0981.outlook.office365.com
 (2603:10b6:408:109::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Mon, 24 Jul 2023 15:00:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT054.mail.protection.outlook.com (10.13.183.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 15:00:10 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 36OF06HE023464
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jul 2023 08:00:09 -0700
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 24 Jul 2023 17:00:05 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Mon, 24 Jul 2023 17:00:05 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 36OF05o0005760;
        Mon, 24 Jul 2023 17:00:05 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 36OF05fI005753;
        Mon, 24 Jul 2023 17:00:05 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH 4/5] dt-bindings: phy: cadence-torrent: Add a separate compatible for TI J7200
Date:   Mon, 24 Jul 2023 17:00:01 +0200
Message-ID: <20230724150002.5645-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230724150002.5645-1-sjakhade@cadence.com>
References: <20230724150002.5645-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT054:EE_|BLAPR07MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: fba6dab4-cfa4-41ae-bc53-08db8c56ad1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3o6s6wTmsh4fsXmBD8UTvCb58azAxh8b0BTcxNzvhCdOVvNOysE1UjZJz1p8qYXaaD8nCDro7/+7SNX8i9b3+6XUAc/xbtiKQvnHk96dwhBSjmufuHQ5pwiR7iPbEFSzVTb++NUw5Qn8enz620p6QsaVKjwWU8742bgIJyRdUkfwezIm9XApbbK8vDmI4KKJjWVKBUt/hFJeSIa5rcQfnSeSq57SBN3jMFNjbg29AvKchwQM5ieRqL3fzfbZJWWg54mF1uyaN7fNYRNd6ETiO8XnLhNwMZtadYRBAm0GYB0rnFlH10fkwn51f5zc6M3QDumXzOF8cmb6ASiiEH4daqx21yH4R+RZ9YDTPhrZ4PtGr/sVNDlRQ1W1eGYDA5PNKn2Y5dWVuFnvtOJlBUuJ1IKpB9nyy+kpmzdFY565/1PyxDBsP1bhv88IjzrCtU9T/apgOwIWwIfk9MpmBewS0CQ2qUAgr1PazSSbsEyFn5K8ExJFPoumUgTQMgbCo1WfjMetzdCqwD8Csy2qc1oIfkew1BnXFv+tj4JOw9tnfdFtBh+clAAmKdzz3Q7nF42E25/lhdm70I3f680c062zZfoxFHtrQDzHXiW7uThYusBSBRxefr2WXJeS6mH+3kdoHN4hngWt9i/AH9/bBgjjXW7gi8Sc23Kryj91fHucb0nGxwlon8i+emfXO3klLiB2W1kCYDoxFI1w7TobhpcF7vIwn/SWrmFjpUTm8P2JDQRnRH9nZjqrNxHNuFTm8YaHE/wIpFENexKHjZMc2bdtA==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(36092001)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(426003)(2616005)(47076005)(26005)(336012)(1076003)(186003)(36860700001)(83380400001)(70206006)(70586007)(4326008)(42186006)(316002)(8936002)(8676002)(7416002)(5660300002)(41300700001)(6666004)(2906002)(4744005)(54906003)(478600001)(110136005)(40480700001)(7636003)(356005)(36756003)(86362001)(82740400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 15:00:10.0821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fba6dab4-cfa4-41ae-bc53-08db8c56ad1d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT054.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB7572
X-Proofpoint-ORIG-GUID: hGpj10OgFqV4XekcBgIYdTolGFliJagW
X-Proofpoint-GUID: hGpj10OgFqV4XekcBgIYdTolGFliJagW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_11,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 mlxlogscore=951 suspectscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307240133
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI J7200 uses Torrent SD0805 version which is a special version
derived from SD0801 that has an additional input reference clock.
Add a separate compatible for TI J7200 platforms.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index ddb86ee0cebf..e3a1efd61033 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     enum:
       - cdns,torrent-phy
+      - ti,j7200-serdes-10g
       - ti,j721e-serdes-10g
 
   '#address-cells':
-- 
2.34.1

