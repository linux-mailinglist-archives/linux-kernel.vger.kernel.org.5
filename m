Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB35F7CA51A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjJPKQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjJPKQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:16:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148F511F;
        Mon, 16 Oct 2023 03:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckm1SG9NuxLyoTkPqU28Ie+lbRhz2+J4XbqpqbfGoFrzHkqWFF9o+vpfxL2KwXyFHw7T5XqwQxN1vjSd17vXJ7yTUommTJpsiti9140PxL91S9U44Xaa7rtG1KhQl+zYUWUFBA8ZOh4GnBTcPQxMLQ5UsA95jME3Bau46qV8iWtq//8NHpkY4lO59UkLAXGGqvuI9V5CYnFWAjadZMAH47VbCJ4OkkfTQsEx0ouGsr1ke/9YCl829pSQmS9YVRyE37gtxSWMQQtHVNthF7weXFCVzAkeH7zCqw6YYdD8L4vEsGGCL9AuYLJeJx3zDLmOFIe9lfLYZUKcZ928XwHicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTMMZz+ODqltu/P2Nz06xKOCFERt6in5j7SlRnnZSD0=;
 b=L01bAaiqWuOsqi9wfzEo1Iqkng1HRELnWku5z6ggfM/5gN5fuwm1xUqNNutoNURElnyEDqkzQ6oBXQU8OVRDc3hyeZGTCrflQa5ealSbHfIpNYYRSsSwc16GplUkroetrQyL8qTtrFRTAMgaiEtTjQ/EqGZzw7/NoDC/Yhx2PymJvl9d7YmNvN45Wx13tYl8VxNCp/F7BHxfRz15EEPu40ZXuc3y1Xf46DxPvE4GeQPQcc7ECFfa3Ryboh2zQv1lgk1tari7ss3V9WcnW7JjKkDSPfA+WNBsgm7BjZ3avjD8wUOpN0mVqiasPZCt+jKMv1ALBPcEOttql8Mz2CCQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTMMZz+ODqltu/P2Nz06xKOCFERt6in5j7SlRnnZSD0=;
 b=EPRR7weUB7QfpnPEfk9BIAbRMg1Nf0rcDpArwuQSS54N3MKjOIXc2YwMJ85a2mdU4VlBxfn/b6KXrkX66O/OQzvbs1fPr2JEs8FWgeasF9MUywC5KveS4lE7oP3XICaG7qfo3eVbxi2hVCuTX3oQeTC+OJu9xbikuDfwzPf2UKvaUpKgqOFxchF8slHiugNw81K5bx32byvVBKQDGZslCJLAcji7d6Qv9drNOWWIvtJEWEaRTRzlD07jCB7x8Wp978r/AheWlyVMRqji8/g9LtGabNeEuP34HZ76a2+i/LOefezacgo0oI+Ac4TmoVAUMImHg5WMrx+ifSDw4woI8Q==
Received: from DS7PR06CA0020.namprd06.prod.outlook.com (2603:10b6:8:2a::21) by
 IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 10:16:09 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::84) by DS7PR06CA0020.outlook.office365.com
 (2603:10b6:8:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 10:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:16:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:16:02 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:16:01 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 03:15:56 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <christophe.jaillet@wanadoo.fr>
CC:     <akpm@linux-foundation.org>, <andy@kernel.org>, <arnd@arndb.de>,
        <frank.li@vivo.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <kkartik@nvidia.com>,
        <linus.walleij@linaro.org>, <linux-hardening@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-tegra@vger.kernel.org>, <pdeschrijver@nvidia.com>,
        <petlozup@nvidia.com>, <pshete@nvidia.com>, <robh@kernel.org>,
        <stefank@nvidia.com>, <thierry.reding@gmail.com>,
        <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 4/8] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
Date:   Mon, 16 Oct 2023 15:45:51 +0530
Message-ID: <20231016101551.7308-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <998767cb-1c70-45c2-91cc-858315be1a52@wanadoo.fr>
References: <998767cb-1c70-45c2-91cc-858315be1a52@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b18cee-965d-4e58-7bdf-08dbce30ea96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKp60pzrPWD4RBGd4joc3R3UauRuTNw7RtH8Ih5i5oTIT8Fxg+jV+fSYZAyFstpsRRAh3XbeGkz4O/ImY+wtWWZ7NqLAzUOHbHjbM2687QliNI/Ab6sRjqZBBomUgoXu1g9vH0T0QJYB9xgDcqfu1ykAv2aVaTwjVxZLNANsJJAq0NRQRD4ThmTJYuLsoZH7tD+xf5ahccD9cvz0kTCuqQ9NuNSnpTq1omGr0nzq4TotsQwa+Pb3pIZ+uVwPkc2FOdWXqE1Cec3w+Jn7OA2YTfJnmKED2C70k4TF2+226IoW7428quKMdy6VWNWRPSlAIEIoowclpsyJvOEY3zB/6mug8BQDDvZMc3H2j1YsI8nUN9vBJfXgDDcyrZ0+FgUZ8uG9lyTesUGbvYlcmEL92v07m23itLwneWKlmQZmGXx46RIoY2p4Ru+t8oh7Y53Zw1JylcyUBikVyfZSMURdpZLjf3uNuCqb9qKS7IrFu2MYC9YvHTq2zTaptYWFSu8vyWkXyHdqFOcm0b/wytqglQkfUMpbQlanV+mXAZNL4xv2K4KI+FCQ/5VNyZllUYe/6sWy8kUkvUQL9P76qkRUdVO/IwUmPEblYWVrpQhdjlwsxGhcuEU94EkPicJ4ZWqKST5D8jQ1Ko4lRKX/zWbNgAi6Moz8vbCrU4okHKO1DMzfZTFjJilJ8if+asWRr1Z4cMpBIY+Ab8pQZX5PSzu3LFS/hbuXrGSHrVnfFA3dtkM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(82740400003)(36756003)(7636003)(356005)(36860700001)(47076005)(83380400001)(6666004)(26005)(70586007)(70206006)(54906003)(6916009)(316002)(478600001)(2616005)(1076003)(426003)(336012)(4001150100001)(41300700001)(4744005)(2906002)(7416002)(86362001)(5660300002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:16:09.1133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b18cee-965d-4e58-7bdf-08dbce30ea96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-16 at 07:41 +0200, Christophe JAILLET wrote:
> > +	/*
> > +	 * Get required memory resources.
> > +	 *
> > +	 * resources[0]: apbmisc.
> > +	 * resources[1]: straps.
> > +	 */
> > +	resource_list_for_each_entry_safe(rentry, tmp, &resource_list) {
> 
> Nit: Is the 'safe' version really needed here?
> 
> CJ

No, it seems like the safe version is not required. We do not expect any
modifications to resource_list here.

I've updated this in v6.

Thanks and Regards,
Kartik
