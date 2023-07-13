Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2457A751BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjGMIew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjGMIeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:34:08 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056A872B8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2Xxjy3n90fGjd4ajXpGvY4xibu2zskwsnGYPEgI7ywlG2xnDd4/dMd5mg5CAK/7VkzchO7drwWtFBEEUbSCvHEGlxLtYKq6sMKO9+oKM80brHImTPEc3b1IkndDQHdNsMz9taN7bOJ8BF7P0SKstPf290W1IG1R5EkT8By/qC+h+/WM/srFQKhXA0/mpNF75dvfDZcRfaa+Iw4OTl5K3bAb27LXwRpnghsNyHu1j530m5OGKLGOLHZySJnWCBdTTzMAeXun7YNPrMhDIjmlL4Fb+3O54D/xYQFPw5k2JuJb+sZyjBpwdORyXq8LTT2xqPQQp8HLnzgElpH1vZ2VRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brZiX0jJe+JlByRbznZ8kicveSBZMheCvd/zYkenHg4=;
 b=MeDWJrykiVD94QArp8V9M1MnTjqySHNbmsTkfvqg+lHgdAuhHO37qZ7TjEYBswI5Mv7n3h23ynhFWRsseGtPefKeKcZC0RNtEl3tVIPdjG2OQelSkbxq1JNkxh4VmLShti7vALA7Zp9tuCUsm2PQMOUu1sG+R5i1GachWjth/guMUx4FAxt1p3gXVJg4K44oabZAR+HKDpOTxQWt1qoBmw2ZTcWWfDWZheRMPn2zPFSkJZ2ExJd0DcpPWJg75TBy3JKKtmTfbSbnF+1e39kZHKb85kxHVKYh1zh6/XVT9yqF8Pnrgrl0Tr2bMngrSRAFx5JfdCtoo5GQMkmduIS9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brZiX0jJe+JlByRbznZ8kicveSBZMheCvd/zYkenHg4=;
 b=KaasUDM6UZX6vjp4vRRBhidRRmGNeJNxoehOH6W3mTQksxNRVPWHiOto5NkA1R7LJE4oz6VmqsGdVsvTtMi9XNkkMAjvWIlo0hv5uB1frqJNDGZUcy5WlumpBnnb/i50WeuY4lSh1l4COmbmis3FIaw3bBr5fZajxGGOdst0aDrOPII0rZDG7KAeq2DL4K/UuYmw9+cvLqbKFpeonQUzQiK6rwPMrYdfDyV/mqj9rT1ArspXiMdkXli0Gs1jBSfLNDDLP1vorS+9HQBHcXR99PkLXu+r9gNdqsUWkNrJ3+Uy1fRAp0aLzWkbO8d/5QfB+0pgTrDdgEcrHFbUWhvcEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 KL1PR0601MB5702.apcprd06.prod.outlook.com (2603:1096:820:b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 08:25:07 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:25:07 +0000
From:   Wang Ming <machel@vivo.com>
To:     Wang Ming <machel@vivo.com>, Akinobu Mita <akinobu.mita@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2] lib: Remove error checking for debugfs_create_dir()
Date:   Thu, 13 Jul 2023 16:24:43 +0800
Message-Id: <20230713082455.2415-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0082.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::22) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|KL1PR0601MB5702:EE_
X-MS-Office365-Filtering-Correlation-Id: 80af678b-e86b-4bab-f649-08db837aaa3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6m8HQ0WFBpCLPeoCQsIFX77KLDRKpm7lZsvYA4SyU73W4HrOnq/KYKsRXFuT92mjm/I7UlINnz+FxcPFTpGHe2R2mp+b17ifNFQ4S1Np4QH+0SB3td67HBG+PuEheiAPtrujtP3/w/+FV3vC6oScCX7R4ESgKJApzybVQX0qJNHOKuzsNresV+WbwiwG7DIbdr0mH6nm+olRJ1Ba6dUQdEAmRD+PBedasM36palIGclJJSCNE97i1FMPXUyOVhftu7G5j4xJsQgSavvpk8gI+5HhPzX7C40sBN4YJD5VcJkvkDoYvdz5o6fegmn8z3Jykx3hZSMRsNJIz9sKOIxvYoe7iJtidga8fFQ6+EnTJo7YAR2QhFPCw3VZZrBDwnRU3i/o6USoqxNNobH7RXwIcsGc03hx+9cUY57iytNAIube0H0NL5/BldkErbroYhqmlR9DZxptlDJHR1n6DDaUDx6eP1EJFwJdmEMfSU0aM6oO8OQTa/Y/BWi5OuuezTFdvH5q+wlrxSmIeJMXclvIQwXwDGBI1aZNocdspD9tEygxytblUMJHJwXWddWYffO1NfKEpcrhCdy9dFl3kkNKMSs1TJbBUj+nMZgncU7djYX5ioQXMHlh28iGXr9qyJ4B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(110136005)(52116002)(6486002)(478600001)(6666004)(26005)(1076003)(186003)(6506007)(107886003)(4744005)(2906002)(66946007)(6512007)(41300700001)(316002)(66476007)(4326008)(8936002)(66556008)(5660300002)(38350700002)(8676002)(38100700002)(36756003)(2616005)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v0Ofa3n5qo5b/0kEYVcbYB6SMF/CCJBZQSpolliAiSxwntg7gYvzMEE/otm3?=
 =?us-ascii?Q?CjozQhwv3ZWrkUu+d7aSnMec3Jqr2M9ujDtS3FPQTXPAmGdiAL9Sp/UNSDxI?=
 =?us-ascii?Q?MnX1AnU8p5gIUhq8QyaBUIr5XfremSv3oV+NX1cfV5/VTnvg8Y327Dpy/ZVG?=
 =?us-ascii?Q?/FUUxwxPUrojnpGdadV95FremC6TaK1YFe0Zs9aF6PYC7VN2RHJFcOoOPj5c?=
 =?us-ascii?Q?G206WAoZ8dBphhilx2VXU2au4DXQnB8KAl7XCXfuLeY4Futy47BtaKcdMpTC?=
 =?us-ascii?Q?y9wL+wLkEnVVGUaIIF0GsfDIHLLeBywX+I3YvUJec9cJetEM9X9qQLfWJ7pU?=
 =?us-ascii?Q?4THkuIu1YTyygX6qEvIu18IeEwZ37mFvGozZZPLp/eYYOEiUwOIWLlylaJEZ?=
 =?us-ascii?Q?GguAkryw9i9zHMVYuptvs6akCSAtsk+DGXHqtqV3YvgBJJVLS2SIVGP8N4MW?=
 =?us-ascii?Q?dJ4C4t4Bpns/Hub1ap5gCPyMQRbNQYaD2V778mguZn2Y8Jl7kywUis/nSw8V?=
 =?us-ascii?Q?GlEYJfSrw+9Sr/Z3zJJ/63a3T0uwL+qvmR+hRY7EZPc/eOpq80+zdVinZzAu?=
 =?us-ascii?Q?V4aTNZNfA4N2ZBuvFrVkXhSmgzy5kx7Xv/ZgMS0C/oUsvRlmLfyuWWV/Ebnc?=
 =?us-ascii?Q?n5dWWb3qpYGhhsYPAkG1ZV/sYnxzzl4BVsbUz3hs6LpnwSkRR9CMSSyyyVnH?=
 =?us-ascii?Q?8FFcveuZJhbdDTNTEFQCvYa3LU/nQIXUkUBrzFeuaNcWs0nGOhtwOYZM6yaZ?=
 =?us-ascii?Q?oFYYRoU96SaSPTjTm7auKmqLRV3+vauWA4x6xKoo9WbPOFbQ5CtJb0xDAER9?=
 =?us-ascii?Q?rFgrokK1nmdTGztUMQYhS3DjJVQ1Nt58h8EL/uUsLLu1jjKsDhwbFjhbtQre?=
 =?us-ascii?Q?TktPywwBHxovGm9ZM93R3BJH/rR3zEoKLgF9psBWhYzcSxmzy0Aj1vGzE+R4?=
 =?us-ascii?Q?bIIEKHewndtoIh8UYrStUxwEFFyO+1cIqnNOpdxjs4l5hqQmw7hSC5FawxoR?=
 =?us-ascii?Q?DjjniJtrDxTgVuS7sTvhIUZOqlgueRUBhcwVG+vbu3AoVWyyADTdQvnlm6CO?=
 =?us-ascii?Q?QVwhTRmBe3DPuqwFZ9iGKsTUD1Vg9mS+hBELoXQfPeYaMPPHDRXRt1wFh8Gr?=
 =?us-ascii?Q?S6Y3Goj7glm6iNsG2wdYRpSyh/a2p9gwYNhRA255zNE+U6EfIPLaUhC5/sAI?=
 =?us-ascii?Q?KugAW4H34yZ6OdtnhB8zMLzBx+QsZHui9NVaON4DEMC0o4vuwveofnQBzPA4?=
 =?us-ascii?Q?2KsaWeFtX5AKGz/SL1ukJTw3PqyhivoUXLDjB89qi1BqW3oVrz+D4hvUKDZL?=
 =?us-ascii?Q?K23sxY7w/hTjGQ3TIr+wH7RlI3e2Eukk4UFPi1Wnv72p2p/eAb8st2Zf3GCx?=
 =?us-ascii?Q?eTLryqphOdi7SxkEV5wwjkZt/EIxuOs9qXFrc3ykvDUm4G4oKIIPHIxMQEzt?=
 =?us-ascii?Q?o8YphQqLqdSndfrQaW61hFp26lRFDUZtK2pgSjcESiV87D3PTTGJkl7k6sJH?=
 =?us-ascii?Q?fpYEEytEcdDVO/m+QjtJMqs78fVFYuq9IxYAbhCrAf5N3lN6YPbhdIe6FGBY?=
 =?us-ascii?Q?0l8aALhkex0X8+iE6ey9jVzxWQ7UTSzlXw2MS2Ie?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80af678b-e86b-4bab-f649-08db837aaa3a
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:25:07.2250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfevT5vBQm9xsGlzBBjf1AlTMncqzl+IL7af8fKpjG6rBhAN3wJQSpaIcma3czwitdUt7Tn4N1Onbk8q36oFCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5702
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is expected that most callers should _ignore_ the errors return by
debugfs_create_dir() in err_inject_init().

Signed-off-by: Wang Ming <machel@vivo.com>
---
 lib/notifier-error-inject.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/notifier-error-inject.c b/lib/notifier-error-inject.c
index 2b24ea6c9497..954c3412d22d 100644
--- a/lib/notifier-error-inject.c
+++ b/lib/notifier-error-inject.c
@@ -83,9 +83,6 @@ static int __init err_inject_init(void)
 	notifier_err_inject_dir =
 		debugfs_create_dir("notifier-error-inject", NULL);
 
-	if (!notifier_err_inject_dir)
-		return -ENOMEM;
-
 	return 0;
 }
 
-- 
2.25.1

