Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363327EEB09
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 03:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjKQC20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 21:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQC2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 21:28:24 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2071.outbound.protection.outlook.com [40.107.13.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC6ECE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 18:28:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcpD42Zu93ATc0Ird1lWgJygpt8P9SEYFB8g4C39fUcQZ8tk0dJe+5YXYkUPfQAn5iGePdsYbQGkXYBsH2DULVRDpTxeQYLR3Z0ropmFUW9T6jx4ihial7M8f6FF5bohAdikMJrSHkwaXP4RAmCMUJ6hbfTzC3qSaBeQ0zg5lctYgvRWCvoRXTfnnAIHDRfp496OjidQt/swOGyLYn3l/BNItVQsI6ekZOYybodpXLoWBX0IpDxHrqfSmlnDLC12NFpuPMpt5cCgJdorwcCDzE4VOBZ9YKK+RlAnIH8wzQlVXPmKXzNBX40B/q6NwWU6hJGAmsIOj+894J7iovwkiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m286SBP8XufXFyksxHco0kzq6D71TYNS9hsMhnyRWDI=;
 b=WnIfT3MCXYwO6jRzxlKqOns5LrOSlYDWfyBp9qM0CyUbOSK+O7FuUjjjRzWdjIVlTPStp389muHFje0ZGZTAfQSRHKWLBHMVb+dv5YfIPsmYreG4neAfnW5nmQEQY+X3yIAGrXxL+lhctpC4iMk0LbCgaM4PO32oLAkuUnZAWCHKkOnBM7dTEJVSK+ug/8ZOuCeSKCt7beYQod2rVNmCW8z22h4mQMKzf129fcg9fuuiIfolI7kYsIkJNrxA0J9K7RrYl/d/CcgHEO8nt7IMH+kIje6VUo/sbLCvtxe0Gw2nJfx/bkCbVfdk/LCUhbBGjs71zJj63EBeuS9AqFdooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m286SBP8XufXFyksxHco0kzq6D71TYNS9hsMhnyRWDI=;
 b=xmBp5svewyWuj98N6pgAkLwd+iAKs4/4LPpP9XNjNwtiKyC0o40HyCE8pQdGnUVHJLRXJehu+BtuW0kiekQZUUZ2TNrEY0Q1EQBUmVFYaJWEgLz8xypmL0VkJgwej2a+OJw1WF8XYihHdkp9leyRd2cVq/NjsHl++cHzO8ILDeQhxXH2S0i/qAxuxYdR3BgLv1YWm/1M+uZAuxxmRCaBl629mQs0eP3/MMHH/tRog1NftsDaZExLoAiuEFHxEUbPO/8IrRtSWGhsizUZYvZ2Uo76r9SR4iUERMlKXmyz4YoI9zBLn+BmScwU14eKqwx0GJ56lay262LF9vw9su02Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AS5PR04MB9771.eurprd04.prod.outlook.com (2603:10a6:20b:650::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8; Fri, 17 Nov
 2023 02:28:18 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::eeb0:9b32:19a2:8e12]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::eeb0:9b32:19a2:8e12%7]) with mapi id 15.20.7025.010; Fri, 17 Nov 2023
 02:28:17 +0000
From:   Chester Lin <clin@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chester Lin <clin@suse.com>, Chester Lin <chester62515@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH] .mailmap: Add a new address mapping for Chester Lin
Date:   Fri, 17 Nov 2023 10:28:07 +0800
Message-Id: <20231117022807.29461-1-clin@suse.com>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0281.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::14) To AM0PR0402MB3428.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AS5PR04MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: c02109e1-b98d-4ad6-9c63-08dbe714db24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6lBf9oGLkUuthebd+o7hOLAjC9375UruBeluzlV+gWa0/gtn2CJWRsnJenjxDdXjEYz1TsV/dolF3x4RkJX+EIjuxUE2fETE6KpzUkhq9+NKxTajTC3sgQtUOIKg9C9AwMA+AW+fcvpQAw++9gw2b/ZGjtrERycD5DW8efXa0AI70tiWJUBtho/HQpIzHVj2ZhKt7dDxYrt4MbEpVFjIl9p9ati87IUb8xHs0/8cbidVmzA9dPKh/JndCqozTdaGpxQGi/4mn4R7AJS0mEfIgkiu7nV/Xkwnx8SRA+MGjcpsLMA2B1/M1yr7JMZq6s9SDReGFpJY5C1r15oKB5TPCrnieZ7FcTU2S1GLbRKNc3awTqcWOvyyrgyBFe0DfZxfuBhL9Hex87b7MzLWatYaO6EYIR398nNmwjR74FVnJByExpDXvio7ml3/ygSdwyN3Ioh4tLt1FCxLPbhV+JAI1VHoQkhiLIxkQdM3fc1HRXhRi9mHiDq51C+0q6IYTFAXkpMCSiSyl8Jb1kLzwIfpWO8Um+fPHIKDcHWSmOcnxTuuLZ4rdw4nMAF6EQEp0Fr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(7416002)(86362001)(36756003)(2906002)(38100700002)(2616005)(107886003)(478600001)(26005)(6486002)(6666004)(6506007)(6512007)(8936002)(4326008)(41300700001)(6916009)(66556008)(66476007)(54906003)(316002)(66946007)(8676002)(1076003)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BH0Q09eS24BwMB0m8TfYtGTfvChGfMS0SxC7kE7FaU0P8CPp8FH6d8OWe46p?=
 =?us-ascii?Q?KhB0kOzHCCYkodJ5rb5zO6yN6teMPcjhC967ciVwWZvFwaJZ2fHxXPlMz+JB?=
 =?us-ascii?Q?2Zeb8BwqYYcfBFBoFxo4uPNDte3PKwRID1DbJdkaEPWYrqN14qSjZpRV4IBZ?=
 =?us-ascii?Q?4BUwvZh7Z6bWhbH5P0O6BYV48ZmpM7AbwBrXpA3r8CcCXstsYUSOxH1kP4Ok?=
 =?us-ascii?Q?gYeYpcGWGNsyvGccmegLohWzA2ot5uN2szIvowN7MIzgoUNgFjw+1iJEKNbc?=
 =?us-ascii?Q?kyCzmZS8uPx0Ye6UD656nIm7ozQGnduXGUamgeeVNsrQZkq5Zv5JGb290svp?=
 =?us-ascii?Q?t0lXnreCM+Zw7nEgA8dV19DlbVqh/3gnQqfMAzWS4xXbfHa45eXUoRfTeoX7?=
 =?us-ascii?Q?Cj2ahHZmLcd4lOFYw/Y59UqdJxPMS+6e3jNCrDW5dbt4PxviH7vwi9SDgc7L?=
 =?us-ascii?Q?82teqrDhYnsyDGJdZNQl4jngDcG1GiT1ipe5mcx4PxfOORJ7n5OteRiisIBl?=
 =?us-ascii?Q?p6M8Pr/g8U3JMty+i3KwPPPeOnUZEzT3v0pRln4uZPU9ewFf4/tQnbBrQvOV?=
 =?us-ascii?Q?zRoRjeGUt99UltuYENJ8ZHVPFij/w3Pawjv/wfQEfe0y2S0Y+KvfukYx535h?=
 =?us-ascii?Q?6U8Ke7MTfP6ald5HklYAl2/rhV29LISWZXXOB6jYN16bmf5Za/1QF1ISZSiH?=
 =?us-ascii?Q?7K0n6Z6zfYOsy+0QRKGWDQf68zTiej2X4+dLC5KyP2EQve9MEP+O6kIFbATd?=
 =?us-ascii?Q?ZB8AMDZOBApXsVNJKvrUqceGLJKLBz+ptVGxtZTxmsoMCnbc18C9JWOfKe4y?=
 =?us-ascii?Q?EgFDRzcOAqoI+pFjKI0IdsNX9KAs7stPW12XU5iofcO73ILhGuQ6la7BovO0?=
 =?us-ascii?Q?p5SuaeQxHvcKVfDs5zaN3Q5VH0ueaZ2bxYVT6a9g7RbYEICjSoSP39LbTMIC?=
 =?us-ascii?Q?GIAOAQ8puIagkeA7xjZStuv3kYFZ0uCQbckSShMXLa4B93MkbCXDv6Qk6uN6?=
 =?us-ascii?Q?3Ud7cG8GOmHU7F93T5WMCkDchKqg5EOG+1AhfDiKtaoA80yka1vmDcUXhJ5Y?=
 =?us-ascii?Q?eN7g5hT5ebFGx2lQgUEPz4V19oegYybXbzWRyD9LDbu1LmvNzQ6XK8zDw6ao?=
 =?us-ascii?Q?a6bcjJ7RvQ90tYNWoh4KGBtAE9skry3eCiVyhMrNp7g/oZrW6XSOpbUfHIDO?=
 =?us-ascii?Q?EEFZ5e2oTa1iJflU52W14B22Jp5RlUAHxvaa6xCIp/TpaigP1yu8i4EiX4rA?=
 =?us-ascii?Q?ACTeSNv2zkEFWcgif0zipMLHcWtLcSS7Mk4cy4xAZXM7i82Mr+xw4Bu6eAO/?=
 =?us-ascii?Q?M9RC42MGXYc+rfWKECDK0z4Quj8CoC+FYosOB76ETs2Z4MQeeIys7Ev4ZCrn?=
 =?us-ascii?Q?lqOhmj/5grfkswqAZzjZbh8qph/+d9IRQvItPZ2kFdVSgCqmjW+MpejdcSjd?=
 =?us-ascii?Q?kHHGOREdidhJDbejynoi6NzvgZS26ykSu84WyKzx+dHXUuAFX6d2klrbzp4b?=
 =?us-ascii?Q?i/wMfWFJmK3Si2Zlei4k/TS2aAz2Sh5gMR+DmMdiJcEGy/0x1oeFss0N5AdO?=
 =?us-ascii?Q?jsT7Tv/FjvCsyZb+W2Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02109e1-b98d-4ad6-9c63-08dbe714db24
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3428.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 02:28:17.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeNSoeagvoZCvV3CW+HBWb1pYdEzajRiYet06Gdmeco6oGiOjDsHvWCqzcMdiNGi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9771
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My company email address is going to be disabled so let's create a mapping
that links to my private/community email just in case people might still
try to reach me via the old one.

Cc: Chester Lin <chester62515@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Chester Lin <clin@suse.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 43031441b2d9..19eb49e55836 100644
--- a/.mailmap
+++ b/.mailmap
@@ -117,6 +117,7 @@ Changbin Du <changbin.du@intel.com> <changbin.du@gmail.com>
 Changbin Du <changbin.du@intel.com> <changbin.du@intel.com>
 Chao Yu <chao@kernel.org> <chao2.yu@samsung.com>
 Chao Yu <chao@kernel.org> <yuchao0@huawei.com>
+Chester Lin <chester62515@gmail.com> <clin@suse.com>
 Chris Chiu <chris.chiu@canonical.com> <chiu@endlessm.com>
 Chris Chiu <chris.chiu@canonical.com> <chiu@endlessos.org>
 Chris Lew <quic_clew@quicinc.com> <clew@codeaurora.org>
-- 
2.40.0

