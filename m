Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4029D810BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjLMHiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjLMHiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:38:02 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2082.outbound.protection.outlook.com [40.107.117.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F07B7;
        Tue, 12 Dec 2023 23:38:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GijaYbjdjPtVFH3qzxydJKqN53lLvab5YQM8D9vLnSqQJrtSRPpV7GC295aYFviU1azzUKauAqgJSeJGt9xsUT/N0aPD/MXBy7Qc+veBL7ng23PyPbONrmPo0fHwfyvFIFCS9Mi3jAlN21RkIZcP2dS7vq/D8Q91IBpqCWmXL1lhalFLjz9AzAMlAQDfa68sorqqgR6HYGwn+mBhaDFNt0LKKB1YqjpQdN6dCES6eF44Dd7Yv4w/jV90boj1kD+fDFB9121N24EUEFXqDXRVrLvTCV1c7Qyvo7ip3u7Llo4w6PpnbVCNmmD7IjaTif345O6gfFdqCMJub3uPRyYjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nz8LUXVttee3jBMiPnBlSzx7YaTmDcKHuF/SsbxK/UA=;
 b=MCqtw4RU7ekRH9vVL1hh/6l5EHGq4XXzO7VD5ZJxu3lY/9v+JKunyb6032Xt2jaztt4J6uiVm1eNgPZWa3dDv0R8aKhHhoKCbKPQqivWGOoA/mVFEsELz9HJ9gRC9idirihM/AzBDuepa9acv9VxGiGH3NtM7WbhdxFV6SnLRDMVcd0eD91QF8piWdw4bgFajIMxHXH+WEiahHq34Bn/0eOHbfBANkD7ubzalmhSWmMRriDutYaOt52DxjxOYbbDHFqIwfjJPOCDjc5couuQSDw53vOMK+t63ma19WDLDzy5/4LyU57A70HZvv91pF8U8SeLheic4UdHA0PQ/pMNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nz8LUXVttee3jBMiPnBlSzx7YaTmDcKHuF/SsbxK/UA=;
 b=dy/1iRvvO+DxqmSYBVkUv7QOWZlqHr36bkWLL0Foi+MXhD+6lDaB7hSV06dZUPFI0zm8P3byh+GIO4P2qDn3ToWyLuYlmy47Q6343T05x6C1cluEQsdh6RsW3aCSRH1LxmAnpztheFYwnI+KQJgYoFGhKaJA2g3aTlcjUEIHzIZCNDQBze+64kX31WpQjHOoRxqrTd+ZC65P49qh9QwLBP3w+Q+/8bHBxGah0+itIbigmbHQKwqoa1Vja+Zfi4jyqQB34PPi37xzaSt71ZsBSN7G4svKkw15gpVad2lUD7d9vHsv8DsgMzpSWYF4p7ISJPDfgX9c+zSD+axTglZ88Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by KL1PR06MB7287.apcprd06.prod.outlook.com
 (2603:1096:820:143::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 07:38:02 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::e64e:7a41:8ad0:60a0]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::e64e:7a41:8ad0:60a0%7]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 07:38:02 +0000
From:   Rex Nie <rex.nie@jaguarmicro.com>
To:     corbet@lwn.net
Cc:     rdunlap@infradead.org, gregkh@linuxfoundation.org,
        jim.cromie@gmail.com, mcgrof@kernel.org, rex.nie@jaguarmicro.com,
        linux@weissschuh.net, lists@jade.fyi, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, angus.chen@jaguarmicro.com
Subject: [PATCH] Documentation: fix typo in examples of dynamic-debug-howto.rst
Date:   Wed, 13 Dec 2023 15:37:35 +0800
Message-Id: <20231213073735.2850-1-rex.nie@jaguarmicro.com>
X-Mailer: git-send-email 2.39.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5773:EE_|KL1PR06MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc87c25-c1de-46bc-bfb2-08dbfbae6fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t91HUgoT/eGZaRe9Q0xihtnfuLW09qGdMtIM2g/b63IHqni9jH4GwtJ2BpquMe/SRk5cbxvcQpjq/8GNL04ee6VIXhOt9FhGY35uoOzWWhhJt0LijDvKips13KqHpEUVlVaAQarVm5ZVHxeuah0zDprq7Of4/cFqUSjGbyP9Elrd6onK799AjBqoRa0l6iGhA35QyWruBglBrCsCaDMgcJp5Iu+lOpFeqm6jVM4C9eLYlXU21R2IpbcwN0GsMuLFR0gKqe6hBV9nurswIHQi0rV7hG/0k6WbIR5T2u3vn4NgaeQzODclENFPwEEjCc5HdzKRylywjYWkETgMsX9Jf3uXs/kSjPcoPQG32Mm0JLsfoEXQkd7yBV74sPOm+VPqgWJmTCzVc5jWh09mx6ua0r1oomoqPgE4ehiw3InLenXNA+E2R84fKpPGP/eJWUtRTYwRXtvrmS9RV/3jh0uF5iI7OpuAMFi74C2zMiNwMDIjLM6rp67nO+yfPz0bcTpINEAqdQOaUmTtflip2MBs4WgHQiF4XqrQvAh2qFg6C11MqrZmBubhRyGJLbeYoQZsnt1Vq+cFapdscvA5NpxeqG/EgnO8iQjw/8x+51UoqcPl1gX4TH3MlKtZ1nMhFZx4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39840400004)(346002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6506007)(83380400001)(107886003)(6512007)(2616005)(26005)(1076003)(4326008)(2906002)(6666004)(316002)(8936002)(8676002)(5660300002)(44832011)(6486002)(478600001)(66556008)(66476007)(6916009)(66946007)(52116002)(41300700001)(38100700002)(38350700005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PEEwoVgcxwjFDdvdBAZc5MazROQoWriECR0COuOxO4iv9kR/IBEA0FDKFctO?=
 =?us-ascii?Q?IA2mJBIE0lvgARS3mhmGbBFWsDRetAZ9YUGxQx6MbPrC8a+J6mB9beOtPUBH?=
 =?us-ascii?Q?/sV073Fekf2oVQmSpAEEmLcgqvqiQpWd2lYZ+NyrC07hmxDOdpW8yGRP000J?=
 =?us-ascii?Q?GHN3uL042IB6o7MKJZ1a5ce4AtG3kD5WMoXaWvWJFfXXs13SUixsCexW1VD9?=
 =?us-ascii?Q?tKhUv2JXqL7q4unIokpgD+moIDGumjrDPkek3cNhI2IMONeYNwA8cHHQmlxI?=
 =?us-ascii?Q?AsvMSd37OJKH/jl7f3eJDlbUIiR+emd5gIhwjflDGmiOADgo1ZB+dSNZS9Bh?=
 =?us-ascii?Q?52VAp0wINCpUu3iCfvdF3fjp2jdEc7mNMnNb49b8DO/Jg92E1fFiRQMRn+hb?=
 =?us-ascii?Q?+kbtADmT0fLmgscnidl3Jh6qrlSzYJHwOhMmF9f7SPImy8XBw58t3OSg5Ih0?=
 =?us-ascii?Q?ter+VVQUUJOlia4d3uyaUgZZN+0D/OzvkOHW2sEnNnBJM63/wXoN1ikR9AfN?=
 =?us-ascii?Q?6dOM6UTcJUPvmfy+cIKu2PxL0ND8Nt5xdc1v59WJJImPhRsL9FF4NZTVHebn?=
 =?us-ascii?Q?8K1PtrazvGIr4+ZIyoKxCjKeM5u5gkHsvfB5sPHcRQjvaMxk2jMeucBuad34?=
 =?us-ascii?Q?0uOaxr2YLkhslhcsgexknmZLE44M0O7/Aimcwka0SD83uLARroybIN/2zigv?=
 =?us-ascii?Q?62uGPjeNSjjyrI6oENXYEQt86sglixUpShX4bef6GZ0eNZXJ1scQwlRc8eBz?=
 =?us-ascii?Q?k3M8MkE4UFi6e9hTvB5BLznSD3lv1cRm3Qi7LNG2fuMGixFjXoxgHobAyW/V?=
 =?us-ascii?Q?gNPg0pFz39lzJj1Vq0ofoTRTsAJCu6vQLyBjcuw1eFyhzWMsHwrZo8kDvzkQ?=
 =?us-ascii?Q?diU55xU3MIIy0CSZsMs2lQhsG4qH6uneaG1harOCkQ0Er1VkfRa18FiUNwBb?=
 =?us-ascii?Q?+z8rAPePDxVbasfEYXGVZI88W1fj7B1ApYz+CoJKwxXS+VEtat+2SiMtXlgd?=
 =?us-ascii?Q?tlvgtUk5Ul18G1raKSyVyhasKD589PPdHMeT4krGDMv70J0S/MxskjzUiKO7?=
 =?us-ascii?Q?X6ZVw9oUZ2IrL1kZopac7M+xJKGDvdiw8xVSs3dpGKa2JmGb45WiC82OgAie?=
 =?us-ascii?Q?YGqP3QzwOGcIvq0ob82bsbcgSJpbnagnv+KWkHRIXT6X/QfqDVj/W6HdTzzW?=
 =?us-ascii?Q?HdqKzNffkpUMKsZFtJBh4VpzD0n5uMrxAj6buFgDGt4JwKJMqlJ32wzbQElm?=
 =?us-ascii?Q?K4h/gpYu2F9fbv4xWVYevBxVSybMARMcMZgHDxUzdTXwzDh88hHe1m6zTh+U?=
 =?us-ascii?Q?5FAvwhK/gmZF/vAI7nnOjL4bFJjGKfT2N6SvifO2/K3dVPkGadvN8HgRYv3l?=
 =?us-ascii?Q?9u49PrOtMRIQrsp1Xis65W2K634NhePRDMgHwP2EG3XUayvngrPFczpm0l0T?=
 =?us-ascii?Q?e328OV99mgKx1D1NXT7e7e3vZcNFQva8GIHXlUdvtlWYwtI7IDBKbE0i4P8X?=
 =?us-ascii?Q?jj5wCKAJQU0VRHiyiPsNrVRh2x55jKpSpG6EASqvrsJCVe5VRejorfIvL5eH?=
 =?us-ascii?Q?Ed/ZnvCbib018DRRwu6qXW1mpRkiE5BxY1Rw4LkWjyGhYcPKnptGCz7HwJs+?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc87c25-c1de-46bc-bfb2-08dbfbae6fa5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 07:38:02.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpLLBL8uODTvI7Aq4DX4y8h7slw3qokP/QGHVijkJxwnQukR3gvd0bbQB6PYYFfSWuaL2VxAqAi5ZFyKICjo8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7287
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since most examples use ddcmd alias, remove the redundant file names

Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 0c526dac8428..0e9b48daf690 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -321,13 +321,13 @@ Examples
   :#> ddcmd 'format "nfsd: READ" +p'
 
   // enable messages in files of which the paths include string "usb"
-  :#> ddcmd 'file *usb* +p' > /proc/dynamic_debug/control
+  :#> ddcmd 'file *usb* +p'
 
   // enable all messages
-  :#> ddcmd '+p' > /proc/dynamic_debug/control
+  :#> ddcmd '+p'
 
   // add module, function to all enabled messages
-  :#> ddcmd '+mf' > /proc/dynamic_debug/control
+  :#> ddcmd '+mf'
 
   // boot-args example, with newlines and comments for readability
   Kernel command line: ...
-- 
2.34.1

