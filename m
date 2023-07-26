Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E4B763E86
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjGZSbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGZSbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:31:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08EC26A6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4uU5BAWY9jUF2T5RTS8TDB3g3CZWYVildXFHLWN1qjvOdXeDs3FwHKYPQArkSwXUPs7j80eUJC8xDqy+3ah+bPVLPJE5bE7bdlpB0ZTKMRnRZSzQ/AmQUhLdr3rYZM8onVW9R9va47a+mgItT2Mx4EC0Hl/1OXPTBMrc4/2831lcm3KTQoJ3RNakDLAiTm5Ez90FjAsF3JFZqD9fuEP33vZgQ1pGBJsk7luELc9xIuhlngv0peg59JO8yezFCVxuBu4128HA60MMoy81No3iiG3WsCQkvIi9iQfyY2vfxog8zTe8UrMEKJYzuFCjZkZ1OBVRBA+vITK6YjpOyZ9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBDhaTEdc/Fry2rx+ebgRVJUiLL3MeQ0GbxBHr8Re28=;
 b=Sht14RRFKS3GVHy7w73o/dj8JG+jbLu8zxS8BBTNgg1rFPzJAMb1b8ZALjFTykXSPd25GyOnd13eC8PRsZTeTViFchkIlBwNUBqC4fgFzZVM149rDMs0UN/mwx2KDd1Cq1CqplcefIo8bTb6scUrwAfAMrWPDT3P4+KoD5h2dJazIOTmUXE8OakLajTWUySRMGHVYOtC7NAF3icfzm/w/oPJm3nlZcRgwmxzIA5+M3hWNdIoLBYR7YgwqXPfeiveejPrfhpHBFU3emgFYPVnE7n+tvGkg0no99tkbQp/oVKV5wrnNuLkfB1rtgSLEn8kh3HAwbrzl0DUriUwKtKb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBDhaTEdc/Fry2rx+ebgRVJUiLL3MeQ0GbxBHr8Re28=;
 b=poKyiJE25T/4kd7ossfLF+2VWpVbVg6AlxtI9RUajetGsE9m4PILJ9lEwRDhTpqxeTTu2zvnqUv3smTnm+zgmnr/5/iM5ncazY9gATdigGngXEGQp4ezRgNHpcIOqigSDIFft0XDssqnvAALQdyOAigKThRI1NhYq/4U4BAM+nQLJnee4e8yEU6wN8dpXeJ5AEIUCkRUIA/V7dbq4yx+mK/yMQUW0PF6omWOjTpKlM66/i24sznvfJ96kA3a5HWDxlxkD39DK2FxXfjV7+U6TjvbGyifx5eB7a28KblMeGKaRFxeYBbEpEn8BxsIeg35Zf780JdA5UF+0/QXyR4sqg==
Received: from DS7PR03CA0216.namprd03.prod.outlook.com (2603:10b6:5:3ba::11)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 18:31:16 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::bf) by DS7PR03CA0216.outlook.office365.com
 (2603:10b6:5:3ba::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 18:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 18:31:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Jul 2023
 11:31:02 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 26 Jul 2023 11:31:02 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37
 via Frontend Transport; Wed, 26 Jul 2023 11:30:59 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>, Lin Ma <linma@zju.edu.cn>,
        "Jason Wang" <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Parav Pandit" <parav@nvidia.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH 0/2] vdpa: Enable strict validation for netlink ops
Date:   Wed, 26 Jul 2023 21:30:48 +0300
Message-ID: <20230726183054.10761-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d79edc-ef0e-4a15-2a1e-08db8e067fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFX1YFsHkFr+klC1IqVt05Gev/Hox6R0cFFvi77sWUvYh7dJjx4ZtbNlt9vzfdrdl28GFSSnatKrGJCbwqDoyGVXwZKwB2ICUTu4PyLjywrBgBoyM/apE4xwnVWnx65Rjvl4iaKYdzxZrTa7KSBNjuoKtnC8pg1HNPF0XMXopM9D6LKsJ6oBfkjoZXmUjMOdG9A0lVidxChtfCfsZt2Qx5EHteiMUahFV9AKeQJdh+JjzUmmeLPwWIn2ghROny4dvYlP4ChrX7Q0d6YDHlCWACuZ0vaWEUnMV7CufYJrM31QUUggwgWkVgajxN2wv4tuUIRc0/qi6kymHEOMZ1jKodRWaDcl5WIlEV2y+N/3nJoi385u/HVIbrezHdNvaVlqBqlk4S1v0RSQb5kkKI8yo87ozTAvIrhyAI5lp+X7LFKalaCxj0BjNK58GhkXNiBjfG32wCIhuZHEerJivoNeDBTxtS/4NBZMu5Y5PbzzqmHHqh4q5NOdaO9KJ3u3WQiwHK2sWuMQ/74QakYox0pbsPfr9/QcHjeREtEcc7S8RLhowI6LAx2kGo0Z9pUpfhXIcIuPiEaDay1dCfrbUez+226Lb8Rjob6OaNyKdqJvuq4V6owdEFgOOZHI0rMAwphYb+DfbsuikGwUMF+LHAUM35CAMSrcSzP9LDzdkAFrCyA6ruQSZCzydZ0nOEKHO2BMc3auIxznZqRmaP/urkvtMdEVAX8jGspJPutCS567YssQrB9N/r0AfXYPt7gzShCtpHbagtv3OpIH8BDEe6xqAUEb/LxQCnFuyexEeH8Pxws=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(83380400001)(356005)(54906003)(2906002)(110136005)(40460700003)(5660300002)(2616005)(47076005)(6666004)(4744005)(426003)(40480700001)(1076003)(26005)(86362001)(966005)(478600001)(36860700001)(7636003)(41300700001)(336012)(70206006)(82740400003)(186003)(70586007)(316002)(8676002)(8936002)(36756003)(4326008)(6636002)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 18:31:16.7628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d79edc-ef0e-4a15-2a1e-08db8e067fd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original patch from Lin Ma enables the vdpa driver to use validation
netlink ops.

The second patch simply disables the validation skip which is no longer
neccesary. Patchset started of from this discussion [0].

[0] https://lore.kernel.org/virtualization/20230726074710-mutt-send-email-mst@kernel.org/T/#t

Dragos Tatulea (1):
  vdpa: Enable strict validation for netlinks ops

Lin Ma (1):
  vdpa: Complement vdpa_nl_policy for nlattr length check

 drivers/vdpa/vdpa.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.41.0

