Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7AE7FD2D0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjK2Jdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2Jdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:33:45 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95379170B;
        Wed, 29 Nov 2023 01:33:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVdEJeqhYDAp1O6VlMpjjhnO8vbIMM4Zil95WKyu5MBfh0ssdF0oZB7uOjZLoH0x5kmYBU8XnP6cx9R2YE2ZfrD2+Pqzi+817uf+hk5Oz4aIsGbvAL+CqvEsX41ZsrSlITP6NpHC0u4jh8Z59QNMysxgafTmsUY3hiYRyTmCkTHjJ/mpEDuUwtCIVNzhG58mzH8NiPlCB4AvGDt/poeGpB/eWJrgARhPM01kJqpvNVXf9Qz6H3eQAWkbXCvTVNu3cA7MeAqlE20cGqhq7hIR8n/ibWJ5j2JfsOiNscCUxlYxR1Zbg0X2gq5TzcW5rDEQoO7J2JG54gV3JA/mUvlvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPHSL8lTD6YavRRny1Q4jFJPI+gCmt4Ok1KoKwjOIoI=;
 b=XzKUEM01nzkeIDZJvTawEH9WuvVdS8NRcZYyZGexiqRuMyE9VxlpOSciPLrXKgpdHqmX8a7y4uKXYJfLjI5VWTmY6aS36B7R9KvFwx3Zv519A17m8E3HUgk2J3zFZrzIIpuh4b1pAKHsTnpmpKxbUHzU5JrS8xz78p6a7Y3KjdRXEqEwuYVrGY2q0t68j5joAEsP84AwbKEzIGxuZ8QfwVZpXfF/tMHnKV0ntimE6SwHOnLclaTTVCtVPsYxXsfpNecIbhUkSFz1RtJnfW/DXyYwlIpttuEClKEnFFpjXylM9f6CZjjVcmdrwGPSfB+Q4GE87lm+gST4Yrs7mdS+zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPHSL8lTD6YavRRny1Q4jFJPI+gCmt4Ok1KoKwjOIoI=;
 b=iDtbiF9CXmAJ36dU5j3uqX9/5JX1WwUXpliy/8bu6ajv60CNO2vfzFY2blvnBW7Nla4N2ymAPWnOZWNF4IbSKa9i5idkxopl4tF2tWcp4fVFXEq5Pe8Hhrp7hV+0AmV3obU+Np5BNtuR6fQ63CUwp8+dAFLYY3xWQY6NgmMJZGI=
Received: from AS9PR06CA0287.eurprd06.prod.outlook.com (2603:10a6:20b:45a::21)
 by DB9PR02MB6554.eurprd02.prod.outlook.com (2603:10a6:10:218::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 09:33:48 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:20b:45a:cafe::13) by AS9PR06CA0287.outlook.office365.com
 (2603:10a6:20b:45a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Wed, 29 Nov 2023 09:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 09:33:47 +0000
Received: from pc52311-2249 (10.0.5.60) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Nov
 2023 10:33:47 +0100
References: <20231128-descriptors-iio-v1-1-da1e94755db6@linaro.org>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: proximity: irsd200: Drop unused include
Date:   Wed, 29 Nov 2023 10:31:26 +0100
In-Reply-To: <20231128-descriptors-iio-v1-1-da1e94755db6@linaro.org>
Message-ID: <pnd34woewec.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70B:EE_|DB9PR02MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5ff27c-09b4-4e5f-2744-08dbf0be4a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVF7OnlOP1FWOBwqFXmQFOf6UuYncAZzLyqg/xKl6vttfpZ1AschxjMv7eBwPHV9y2/maO+2I/9FvmFuoqXnKc2vTjeYhnDp8z21C9AfLnvCmGVLl4qWkldNc5qD5gAC2cxwsmC345ZnmjcT5r4SiSl9r76QiBQKHPPQoffzEL4U7UBcQ9exbrP0td/KW/zXbioDYOIDnmU9XccqnNGUDsqfVygQRG/ydSVP692soaLVSrWixxCoQqCb9yK4sA2wNz7iqMUaYtX4yBIO491n9QPrLXrUJyP8muTrFTaK4NVIOiWAfyOvHr/bWfiZCO8IsnuIBGueF3ww3bqP8RFv3RTdhcvKHcwt61hQ+kdTGNu+UhXRCn20Hsx1W80Z6JuvRLbBq2y1rBvrti4GecWQj/bgGaN5n2DxR5XLm1yYhQUoHPpMH3Y3ZF+ZVpSztTi2t8OdKVDicI5s0grwFEx7el8rIfEhKwCyoCBj6TSo1beIJ1om3lfKi5aDRIav3J5CvT1jaxHswyexeZOghHraIsDC6mk37T4lwQZhotCuNRUuSoJ/KwbC1bM9/2CzDaOb6qqhPScZaBN2Da2DIOF9zo60YA4dC4+djY4F4hO70AQdZt3zb7mtJ5Pr/MpY1ah/2atrmB3UV5nJJ+xbXDUE4mOqlDfFYQ3AVA4qonxoyhqlFwIGw38Fr+uXr3JM2GVytObjzTkAUKjeU4dkFbwIzLKLGRinrJpmCxIDbmz7i66SnJVSmcQxyEFOlCDQVZvz5WD861/KJdRCATvtThdNEA==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(82740400003)(2906002)(356005)(81166007)(5660300002)(44832011)(40480700001)(86362001)(47076005)(4326008)(8676002)(8936002)(41300700001)(36860700001)(6916009)(54906003)(316002)(40460700003)(70586007)(558084003)(70206006)(336012)(426003)(2616005)(16526019)(26005)(53546011)(478600001)(6666004)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 09:33:47.9537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5ff27c-09b4-4e5f-2744-08dbf0be4a16
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6554
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 23:56 +0100 Linus Walleij <linus.walleij@linaro.org> wrote:

> The driver includes the legacy GPIO header <linux/gpio.h> but doesn't
> use any symbols from it. Drop it.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Waqar Hameed <waqar.hameed@axis.com>
