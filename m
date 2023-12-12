Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC00D80ED15
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376608AbjLLNQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376605AbjLLNQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:16:50 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663F8ED;
        Tue, 12 Dec 2023 05:16:56 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCBAeGn029564;
        Tue, 12 Dec 2023 03:48:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:cc:subject:date:message-id:mime-version:content-type; s=
        proofpoint; bh=5QxtWJhYGaQ80qzSgkIVk4+m0D8hv8z2jXe9/cOvtJk=; b=t
        xL/nKAm++eFCZ5EN/RJGprXkxdgLM+ewkTCyWPWvmaIEwL3VMS9UD1WWGAcgceUW
        +vmE4kYBYV4jvlASVLfwhzA1uKwKAoaYwKG+IPkZ5eJQ3I5mMx8gGlVIHba1sj12
        WWTOLL3NC+ySr9/i/AWL94DGYT8sNn2wsKdG6ZAONguhP6RCuTo0o+PFV02Q/vpt
        JY0iI/Mf+SvrreGQXXjGC++5OX9ZjK3sEl7JxaJ/utfYGv6G6T9qIy3CGJH8Nonp
        gJ6BgrpAWG/BRhiLbnwOmKSAMN5UsvjvuAJ/XDs8d8A0OacjyUb0gGQdORqodyoE
        NqRrZXzGdhqoBvkdxmcjg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3uvnnx9k47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 03:48:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMNuqHg7E29rFoCU1xPLPqFTFjHwe9ePMjJnFsoVmiK/fPO0FvkB3KX0u2NT92py9UrwUpgPTvXIeRWZ0xhCEf7d6YVQab29r0GXkJd75kEaVmWLg+oiRwkI/3Uo3QWqEkhrOYzwjWTSdv8tSAPcyqpLMBr5pdJfSQ8r2S4VTeV9Wo71JM87StC+5F4OsUMdZszIEgxeHDe8BNBcXTVP4u9ihobywBES6MRqxHCw5ol+K+wj0QzAtyAbjUwuOyVwLFTVsCnDAzGTPuGySWRWRR0PMvMZw6cLuP5inPtPAIT0XRcN1HYPyPDYqHcqGHi2OHDLm2TK1MxaY9ikdDfQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QxtWJhYGaQ80qzSgkIVk4+m0D8hv8z2jXe9/cOvtJk=;
 b=lRXz6pEApoMMRnUqR64zq3cHrdUP4imVlXaCD4ikiSvP3QLZ7AlKmDlcz14Ka2kWXGDAyDre4SlrJInplwJ7JonpTEkBfTTcENyamlv59h4S0MV/yjWIIhF4EYhMTEh33+xNyB7WRCc+pATRD4H6LIUZrUO1hLKPYj5xkSGw3azinmOt8AZkDJptTddACsUqVn3cG7eNbo9CUeP36hQwa6jSJ1UNwS2n2OT97F+V1ZzoJYjWD4XZeuZOJMEFHeQQztlPDFR/APN44wE3Ysehq5YeMwkrvtcsxIVuT7kLuOLxZS3zOdGX8NIN/HFY7UB9EdZO0YpdqJXxvFlRr+hL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QxtWJhYGaQ80qzSgkIVk4+m0D8hv8z2jXe9/cOvtJk=;
 b=t4syfu80SuI+ye6GaDjyZkCWgwAD9HzoRFCSAgnbMKhF9F+NpJqWWL2i/mf6jH5Y1YRgidptYmS1Rd5CGI/P4mLQ+xGTW5SPb5iGymszLlHQoqnAGa9aBoXJHbHq1z1OIsnIaP85TE4Izk29qpk3dvWFI3A1OlpZa70fKN4zjdA=
Received: from BYAPR02CA0039.namprd02.prod.outlook.com (2603:10b6:a03:54::16)
 by SN4PR07MB9246.namprd07.prod.outlook.com (2603:10b6:806:1ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 11:48:50 +0000
Received: from DM6NAM12FT098.eop-nam12.prod.protection.outlook.com
 (2603:10b6:a03:54:cafe::e4) by BYAPR02CA0039.outlook.office365.com
 (2603:10b6:a03:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 11:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT098.mail.protection.outlook.com (10.13.178.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.23 via Frontend Transport; Tue, 12 Dec 2023 11:48:49 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 3BCBmjpl027153
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 03:48:46 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 12 Dec 2023 12:48:44 +0100
Received: from cadence.com (10.160.88.83) by maileu4.global.cadence.com
 (10.160.110.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7 via Frontend
 Transport; Tue, 12 Dec 2023 12:48:44 +0100
Received: from vleu-orange.cadence.com (localhost [127.0.0.1])
        by cadence.com (8.15.2/8.15.2) with ESMTP id 3BCBmh6l1468946;
        Tue, 12 Dec 2023 12:48:44 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.15.2/8.15.2/Submit) id 3BCBmeFo1468945;
        Tue, 12 Dec 2023 12:48:40 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 0/5] PHY: Add support for dual refclk configurations in Cadence Torrent PHY driver
Date:   Tue, 12 Dec 2023 12:48:35 +0100
Message-ID: <20231212114840.1468903-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT098:EE_|SN4PR07MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f10be5-bef0-4009-e0fa-08dbfb084e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qExctvQZXlGnaFblR9k0E07zSVYvg+mbpQ6bJenF04hmyU9on19DTAKH+FVVG1Nj9MuQ7cCNG7N2lmp8npz4MX28tUfipaEj61Atg6golK6NUZzDlIEPLKeY4Zm3Xztny8mZKiZ7eThDA8J70IlV6fZE/zgAnLsprnBMI2OY09GqiyU5OfpTQ9XqywUCjucFCl4aBgUn9iyiocSwc8sgYLxeIosQNpADJVqim5QRqXj4l1aQ/x5hTvQbpCQ5vkmt1f/RcmMSuuMSfCBawRzxNe4UKusiAifBLxF4S1Ju7Fa+KsxYNGs3fWispNy5Bcs++oPtgy6bYHbGNGDgCoiTz23kMfkZqMWe4TZk0fadwQpXStyvtPIWIvghtCdlCBZWCozdvWSATQ5F1pJGzieNQ4M1CYpqwpv9dASuGU9ZS08IkkfNrh0NGEFmyOBEIiu5mtjLXGxaWLdDRk1XpDXUQ+QhZ3mzyQ6RdXovwC6C/OLIzRTA+7aY0OzNN4coiCziHNIwT6HyfpzvbEl7elswW+jDviozCwJKv0fmEThgUwUL+QDUI6gyuBGKc3mS7gfFSpbB1JUimv/Dqo9ATk00qsGrGV750ErxAxWksDB2y54SenfAYpL4NiJKYm/rk3rPqbbfScafTDoV/7nIc7ElCLZb4mzJ3QMNMu+INcP6htT+qjVLDaHGfLjXClaVgbMR8GMVEvtWoQIOyJ1wAsXdJE/8ISmXk0mTwPcXPTRaAOdPhn38pBjyXVoOtOY5+fAI
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(426003)(40480700001)(336012)(2906002)(47076005)(40460700003)(6666004)(36860700001)(4326008)(26005)(7416002)(1076003)(5660300002)(2616005)(83380400001)(8676002)(41300700001)(7636003)(82740400003)(110136005)(70586007)(70206006)(36756003)(54906003)(356005)(966005)(478600001)(86362001)(8936002)(42186006)(316002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:48:49.2558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f10be5-bef0-4009-e0fa-08dbfb084e37
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT098.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR07MB9246
X-Proofpoint-ORIG-GUID: OLb-dTyvx5VhNpO3wxiPL8VgPTfGu_M5
X-Proofpoint-GUID: OLb-dTyvx5VhNpO3wxiPL8VgPTfGu_M5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series extends Torrent PHY driver functionality to support
dual input reference clocks.

It also adds support for following multilink configurations:
- PCIe(100MHz) + USXGMII(156.25MHz)
- USXGMII(156.25MHz) + SGMII/QSGMII(100MHz)

The changes have been validated on TI J721E and J7200 platforms.

v1 of the patch series can be found at [1].

Version History:

v2:
   - Rename refclk1 to pll1_refclk in bindings and in driver
   - Simplify clock-names as suggested by Rob

[1] https://lore.kernel.org/linux-phy/20230724150002.5645-1-sjakhade@cadence.com/

Swapnil Jakhade (5):
  dt-bindings: phy: cadence-torrent: Add optional input reference clock
    for PLL1
  phy: cadence-torrent: Add PCIe(100MHz) + USXGMII(156.25MHz) multilink
    configuration
  phy: cadence-torrent: Add USXGMII(156.25MHz) + SGMII/QSGMII(100MHz)
    multilink configuration
  dt-bindings: phy: cadence-torrent: Add a separate compatible for TI
    J7200
  phy: cadence-torrent: Add USXGMII(156.25MHz) + SGMII/QSGMII(100MHz)
    multilink config for TI J7200

 .../bindings/phy/phy-cadence-torrent.yaml     |   7 +-
 drivers/phy/cadence/phy-cadence-torrent.c     | 705 +++++++++++++++++-
 2 files changed, 706 insertions(+), 6 deletions(-)

-- 
2.25.1

