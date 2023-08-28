Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A248978B4A6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjH1Pks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjH1Pkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:40:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2019.outbound.protection.outlook.com [40.92.19.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFBA99
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrtAIjRJzV3D+Y6BFqIHtXZlyD0RsEEB1KwIRfAqqRdTEV25foR5l4lhVzWSSwan4fFxBCDw88BFXdsIqbkQA+VnF7L3nfunhj5pM/XSjmRq5oLRtc35D6wX0ocvNaKk1ApXgvq8cqk8Fk4t7xy25fSS5/XAm2LGrDHKRIa99mYYFv9qk/j0sqotsHnAu6vsl48pZ2B0AGsohUP3bf1d6oz5p5XuaTWTCx13MHgGoaO23FbbIZqAX5sBG71EHEYUoo/onnXHP3AQKnoYTYV+mqoKfgfHRikxBmVOJvxdFlyDC2lV2zvIMlU6fcd+J8tiaKW1KXiQoESbF4ubUVqa9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRe4hNhsX0iaMfdC367nv4Wn6g76fv99bCsl4mUIQM4=;
 b=b7z4v553E4s2rAGYw6a+F5Z5dflRK2fx7jndKRTlmNhKKJZoIZ6DOu5vmAQZ3D320RAdImAvlXhLdf6bAfmm8gk7u7goCKG1MvpjdHnt8Z7mq+1yM2g89i4UTWCaZJSXOeg6qtyxbifhQ+TYWV9hntOLeNSX84RczpsAM+9QksZBUfVW7sVK7clY9vP36d1v+qatjrZiCJTvVRITrty+QhQ/SQe5ssLRpE99ZhVVmLuaUrnI9jcWAiNlW9+zHXjygE96B/FfI8SrqIM57A/EpMRRz52ERPDx8jUFEz0Rd1wu0of8uAxlgq6NOxQI+nYAAQNcy1gCAjKlwpb6g6VgRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRe4hNhsX0iaMfdC367nv4Wn6g76fv99bCsl4mUIQM4=;
 b=gyH9nUmgtA9oQnVAqS1SA/QUNL2lT8CRCc2nzWF3H7RDhHctyXoWyr7BEQqC04XrZ0XKQfEdI1cx+vMMnAGgPpph+aFul4ZGJLI/TlJX/HLPmtw6/5lm6RdauBilupmrEs2UP2iHJ3BDHL+uzX4Vk4GYxadkZCDDqkfdx/EqEZ1EF/Zje+M5WRiTpGKw/Awae9ymuilS33P7ZxIPzJ4dJVRSNb17MRr+s36jKoeUwBhXf0m+gDX1Mj1gBIsPSXVPPX3T9w9/kCEjOiaPNQ0f8kRIJtV5NQCSy+Uol1uFbPXFCI1gusY+aEqpr5YQVy76YMQoKqrwe7mQc0Jmyze58g==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:40:33 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 15:40:33 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v5 3/6] staging: octeon: remove typedef in enum cvmx_pow_wait_t
Date:   Mon, 28 Aug 2023 11:39:08 -0400
Message-ID: <PH7PR11MB7643299EE41E05AD6D736416BCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693236450.git.ozlinux@hotmail.com>
References: <cover.1693236450.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [cHHa/XOKWPf2B/DncvHZzqmAVLl50Mn/uXa5qZDUXV7aMTWN5gwtnpf+XGGfwtY+]
X-ClientProxiedBy: BL0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:2d::25) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <2bf1008bd2db9a11bc3fe4d4fc2c7a1046a16193.1693236450.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: bd475c58-c89e-426b-9073-08dba7dd1db3
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmr1VCrDDYJl/lCLgD1Tr5zrS4fiborvUdScXH0S2mBYAnoRgSFDYK49eo0pWmYAPXb+WYQ7lKCgEPc37O0tE3Csp8nYITYREDbMD/dCI27897YMe/MKNDorEZoimVRuYUYdwtfUrl9B4n8vPE/cB2pjo8iIPkM3hAgg0RRPFoI853jUbu21CsHtXVsgE1yjtNYrC9S439TPlLMuS8EOKuCCpx/NFzip0BCwLcRn/UpMCVMBHeOaA3d7whYo0kk9Fe6O5++yV4TcBMnWSaJTelm1sjKNZpoE/p8xmfI04oa77rGrBXMgoBg8NFKjcJ/yuz14tWbz6y3NnKFPf2hCvFADftweaixgFPVM0gFud196PQT/bTOpnjUZsNYpcDsZq4nhkNxs+mKoIXrBD6LFgCUJxBhhl8yn8k6bg4CeEkFMI4tuXw6Mf03iVddN1XFlgCXfq9/KoXUWIJQ4NFEaF9lznOtoNknlX7MucCJTHpsCMnhrI60i4eVYkgkjQ6DXbNLdYfYcP5CkczFj95GHQUkGy6rMvp+e3tWv4AxZgTvD22R7UeZOdgqEfVw803wtDYJnwV3eKzqaH4AP9h24ZdS3Z0a7+LdwFSDowFf2eQUGyYrxB0K+LFg4zCV+X1r10djqF+dGhNNtxmNBQyJ77mL/Z4HtxqVvxPIj/mdcOJeOufrcAScsk6GMbzjY6L1m+b5RmfLAe9TWzYZtaYB0aAazaHkhDHC4vNfxbhAVvZebP0CEbkFTesK9DkepKYucbqs=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njp8IQmAWj5SogIpJ71ZbrglZudfTJCusz8hM//bQpzkgXYuZFKxFjRRD0YrzwfeyhMrFgvismSzjCuv2AJMMurR2rmchQm8NBn2M4LEVGrQ6M/d8ka89Rf78ycr7POHUlpYvCx1Iv1VRjfkqt9joj9+0JNUjlFO6zrdi5fvYvQlIPltgi1sQ8o0FfQkvqnqVW+QVKzRI20eqIxC9FtJfjIlHwTKshJASel1dK9GM8VaBy7p2lwAvgSTDnLNsI/qkyKGylZ9oFcBrbAVTfFbsLIdLQ2KmhbN4LYRwbZhdwThT6Grp5PmP8TD/pngQhE16NRF6QqWkn71F+Snm4RQzePvUfvPWG+k8IeQOfIgIMJ4gy+1T5fL+XTVZ7GXDkeCPUzHSJ6pga8YwoUlzQGYMFGl4yBoO9/54lTLPe3iZPOdkiyWkH8aXwQcY0lknpZatCjsXp/rYUdYry6VCC2irekzvMm0ZhzdKVBvNJd/AgrxzPE3XJnyx1XfjYzl/Xv8aXAxoMP1yZHusu80hZzqAPn7XSH5QtKmUralY1u6v8vRJO5ZS1pkhH5c4z2hDeEGo3ojXCon0GJoiqzKyo9nFWnP/Xwztfj7grAeQiodiCxPxZ7vSJ93afYpANZGQRg7
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y+lxiduLMFilWSCkRvKJyk/TjKcYHCl+WW0GGXyJ3laHlVXOXrxfl6atipmy?=
 =?us-ascii?Q?dZ5fpLTfqwgl72sOIn4MPb7NjLnj6F4nY8TFIWIZpE49GKHCc+aBJ03+lm+T?=
 =?us-ascii?Q?RPjxZ3qjwDckb2jPB+dQOryDurtyFZR+9Rvn/6owWbrXpbVHG/aKYXk6tKZN?=
 =?us-ascii?Q?/kZ5BBG1LtkjWjJV3PqvT6E1TIM9ppXAy5Go5ikCF2pU2fBMuo9EmbJeAK01?=
 =?us-ascii?Q?MkWjaXWZDegiVI4XNDs7YcpYQUBZw5fIJdVKqlg4CS2+IDOEEqQ2mN5hWJWk?=
 =?us-ascii?Q?vV9Tx2k0nwD8sk2nD4k6bfc+kGwaZ/C07pS6RNEVwjnm3ga2CAPNBo3XYGHh?=
 =?us-ascii?Q?161bToqqAmeAhAvUyE+aam7aeAZuNsEExTtgY0ql26J4tskHhwjE8pPzy7zq?=
 =?us-ascii?Q?JClxZNa1WjGHe3lo7N+/sfNVNJNwDhotRSpCkHt3jqWYzNFPhswIXGhEnvts?=
 =?us-ascii?Q?eLFfVKyhJ7tULpjUAndruqOy3i/3M998ShXKu4+Pwctq8eeIEZ6oRW7gHKr0?=
 =?us-ascii?Q?nUGxNbdidr6ayUbMNUfpxl11TKbYElW2R/7SNHiw6Z7HWTTJOSRREEoxk700?=
 =?us-ascii?Q?PgCCVbzBoqoHkHsSdlM/Kd/x7p6/1XqFhe5QTVC5KrKtuSrkM6RAivbqh6Kf?=
 =?us-ascii?Q?1+1JjW/6xilugvqeDLpmx93Jp+boVJGeEwAJyMHtLBtuhz5Gx8fxpK6nZZIA?=
 =?us-ascii?Q?F55G3UHR1Rt6l6vEMPliWWGWTPxioAL93ghE34RNfRdAWwxB3R9pduKm+E/B?=
 =?us-ascii?Q?KOjkcYu+41h2HMjvc7zObti1s8tVJvOJhgpU1rGe6yJkMQlSjVZjc0hqz6yI?=
 =?us-ascii?Q?Ww94DGLqrQ7sWDA7IokU3+Udqv0BOcjl543iRj5zvCdT66fGczS7VZ408p4u?=
 =?us-ascii?Q?j6sG+ICoaYUacdshAfje0bsYhfu8QyieqYuw5JBum8n2v7RezK4qyHtmD5ZN?=
 =?us-ascii?Q?2rnh/hiaN9VpfnDZQzA3Vd7rhn+6ZDnU6NI5OBmR97dnXSb2EKv6mdnq/aYZ?=
 =?us-ascii?Q?7Tdr660aZ2UYCOBqrQkYTFtCZp4nq/osJgbzpOQ6t+kkxZdKx8noWYIe6IYY?=
 =?us-ascii?Q?haeCQ5EoNsKGOvDo4yA3ze3nUMHkO7Ud3Nioj5gK7K140/bZM3CxhCRPvv/v?=
 =?us-ascii?Q?37gDOGlmxlIlufciTjFvv6F+xSh+2NIt7CA+zTumNUeL2HXcmmbipQV1CZaF?=
 =?us-ascii?Q?gp7ptECGQ/n+e2l+UxBbI8Q4YgTLWLmG412JjubgJtb9UBwgYOplZjTeSb96?=
 =?us-ascii?Q?HU0VzSOVhadJv1NfO1xIdecPCBOE2QKMATBCvnZa6w=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bd475c58-c89e-426b-9073-08dba7dd1db3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:40:33.4672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typedef in enum cvmx_pow_wait_t, and rename all instances to
cvmx_pow_wait

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
---
v5: More descriptive commit descriptions
v4: No change in this file
v3: No change in this file
v2: Send the patch set properly, with messages in a single thread

 drivers/staging/octeon/octeon-stubs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 0b0c609a771c..4470c985dc5d 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -233,10 +233,10 @@ enum cvmx_helper_interface_mode {
 	CVMX_HELPER_INTERFACE_MODE_LOOP,
 };
 
-typedef enum {
+enum cvmx_pow_wait {
 	CVMX_POW_WAIT = 1,
 	CVMX_POW_NO_WAIT = 0,
-} cvmx_pow_wait_t;
+};
 
 typedef enum {
 	CVMX_PKO_LOCK_NONE = 0,
@@ -1342,11 +1342,11 @@ static inline unsigned int cvmx_get_core_num(void)
 }
 
 static inline void cvmx_pow_work_request_async_nocheck(int scr_addr,
-						       cvmx_pow_wait_t wait)
+						       enum cvmx_pow_wait wait)
 { }
 
 static inline void cvmx_pow_work_request_async(int scr_addr,
-					       cvmx_pow_wait_t wait)
+					       enum cvmx_pow_wait wait)
 { }
 
 static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
@@ -1356,7 +1356,7 @@ static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
 	return wqe;
 }
 
-static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
+static inline struct cvmx_wqe *cvmx_pow_work_request_sync(enum cvmx_pow_wait wait)
 {
 	return (void *)(unsigned long)wait;
 }
-- 
2.39.3

