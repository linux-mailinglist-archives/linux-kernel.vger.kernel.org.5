Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FE07ED858
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 00:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343756AbjKOX5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 18:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjKOX5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 18:57:48 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D5A11D;
        Wed, 15 Nov 2023 15:57:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWytcmddY7Mn6jyH5ge78kUyI9EJQHOOUAMJqtHmPcc++2tS0IjzOUVczuHrUR5BJCMqXXCyFXH5tPqUHum/0kbkNLTrpnaLgT2mUo6XVykDflHJQmPUjdzE3bHGBz04RfW7JyWlSURZG/eNeTz4JmaZWi7laVXDrwn2TIEe8fble50gCqIaJDFvFQtk55AZaRJu+MUCmhv19cHWPkcWVZQB5xvET+k7cXspyzTFUiM7Xf/fVMOQ8bUBkClRZMus5MnhkmTnbS2gFf8ZbEV2qQosDydrMSvp5BcM1SaR55zgC5+o38cHYaX6ZjbKsFp8qHc4GyihIOliH7GElmIJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/yLzrw+7SCYm342bnGIqS81xk67BJZwIDCRYX6Vxtw=;
 b=Lw4PZ4YB8IylXozYKO7Tu56OxnvLVARo5XcTB2GhXr5JIfbYwBb22/0iRV49drXKuM7TLfw2KvC7Wp6rwlONH0T14NelORAWKOO85fGBek49l2yrmwz63aqbnzfkLI8z/u7LZRI0nFbAkWBLQd/Z2OXi97l072icwotiCFOR5xASqN9n/mKKpTa243i+zPX+hU+PqfNZ13MensDSUebqqRtTN1AIydHTRmozI73K8h/4itHJ5o7WyIZ+Kt+olPmEcI70GyLG9gKsFC25qeDxYmzCnO2CNEm+hMGYjTa1Nl5CbY4KjIIo6Qm+Qw0ygaVyRm6zvlTMynG5Dl2eLp1ssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/yLzrw+7SCYm342bnGIqS81xk67BJZwIDCRYX6Vxtw=;
 b=XxER4ucPEgY+1uMKHyI0r2WaKqWzkgRzCLMyy/FRp9SN31DOsAV3SaDjappKk7emFqrTQXATzozArbyEKlNhoyhHZ+YAgekPWLERiE5nwUgbf4vYc4dPOrsXpqnRYI6GGeWtF6JqAuzSbkLUnX4NpNjCO1gGpqHU4dIdmBqwr9g5XWDTwZDrLruMHmS6wV8+ZEqpyMhASL07w7mBSIygc4II9phrYuFBLKk+jgba9JOcyVHCxYYfDCv+gHASqY8AGmoRBypkwi1bvXobBqowoUjBs6DRliJncXay/CJFNxLQqamEX1Dv/T58Tw2sBWMqXVIjxGmBI3EcwlR/8jSCmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM9PR04MB8745.eurprd04.prod.outlook.com (2603:10a6:20b:43e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Wed, 15 Nov
 2023 23:57:41 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::eeb0:9b32:19a2:8e12]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::eeb0:9b32:19a2:8e12%7]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 23:57:40 +0000
From:   Chester Lin <clin@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Chester Lin <clin@suse.com>,
        Chester Lin <chester62515@gmail.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH] dt-bindings: serial: fsl-linflexuart: change the maintainer email address
Date:   Thu, 16 Nov 2023 07:57:32 +0800
Message-Id: <20231115235732.13633-1-clin@suse.com>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0099.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::15) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AM9PR04MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed05a81-aa02-4b5e-8348-08dbe636a6f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXIKAS8hOinU4v4YRszzhMUN+O/lJ/pHCPkC7tL3u4cPlPhzY5IL4/7SbUzRAvtw/bm6M6BJ2p/IiFNNthfZ3crqDZhSdH5z8baEpNyy37EWgkXepzqzy0nzDvkr9gd5twzTCT3WJiOERzOqFN8Q4GnVSXFmnmrjwRsOqU7bykXct/fu6k2vudY6PrwXbULlalph9IFa6Wl0jqFOkLdQfEkLRmbpyB4gEmcg4PXFzbaBz4OylRyvi2NM+DBKcTsfYsah6QgR3JsjWHwOPdfsVBeLjRUOfIgeaP8NxxMIDxz5YuQkZvO7Xtkc88Z8F75M7PCjVb0SBi5ms9kwCJ1l8N+1hwktJIRa4C/aS9402e3JhX+wMO5uPUxy7mbqxus05eahGUD1jor7iy41jIe8Cwu8FR1MsDm1BN1FArOj6e4hqVLQXH2MoIokZLnpyY+UmmV5LiqMWXt3zuk62H5vLXVf3xpS7SWM9mTg6WpSUschkpAyopSD9dRaXT8jx8xICu///6oIZtWvCElW1NWiq5cIQV6oMmzRlwO+j+HhNr4hXd8e4tP940AwglW2JevnhiCMFNpOth5MxChkoG+7lbL90fdwxPsyYONQjJ/UScM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(109986022)(4326008)(66556008)(66946007)(2616005)(41300700001)(2906002)(36756003)(8676002)(8936002)(5660300002)(7416002)(316002)(66476007)(54906003)(38100700002)(83380400001)(478600001)(6486002)(966005)(6512007)(1076003)(26005)(6666004)(6506007)(86362001)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xCgzHc4vWZduzLWLBrYIXvZgRaExj2O8vKtiHauvbAc5m7dtRQKd+cXpt+F/?=
 =?us-ascii?Q?+NJlcB3CGtUgz0xaZ8JEnNNtAv4R/p3C/6g4sKLNmaqfx9S6gs5csDL4YM4g?=
 =?us-ascii?Q?fpEdrBRAQbjFwf4gUgQ4WdgnYndn3ymJUvfTPgCAu5/2NqZf9S+sHQMwGJba?=
 =?us-ascii?Q?OSymxs7miAEKzUq10ElVo1xi0ztUA4tfPaS0PHGlECqXmNRjMTJocYV61cpO?=
 =?us-ascii?Q?nmxKv3tkMWgXA9zeZeoNQtr3NQgy1ZV8SqPibTxn+D2HAAUovlL01tlzKxoQ?=
 =?us-ascii?Q?s7vSdefjyM+x+x1GYf6d1/wul430XgoKKByFJ3oTDAFRBn5bLXwBCFBymUMB?=
 =?us-ascii?Q?w0m7Svr2gfQ4QsLeRZ4uAzstACLDdUvO+jv2wA5mAW/Q0xqb+A1wdfD9oBwR?=
 =?us-ascii?Q?o0JCGGGcTxulB8jqMTvPNqEwHlnXpuNhr/ijv0EUzcKYcq9WM+8Rir6Tld6n?=
 =?us-ascii?Q?Aba75rjX4qZ3zM+Ce8RtZ0YaLdZruq9RTX/lb73tMqrEktKCdalMSIpAw7yF?=
 =?us-ascii?Q?KP/ls52Wxgm/9WZrJefcceuG+uer4p8s9nhRc3N6jKO0rf17Gz6NYShCbrLW?=
 =?us-ascii?Q?OQ+WTjIav6RN2JGy61mXMZXc7L6nakdEiQXACfMlXI4G6acr3NYul11O9vL/?=
 =?us-ascii?Q?YDUZgRuJfoO0QTL4xVNBdP8bYtXU30ZuMLqkIezevvOQeAdHhnEG8N4LQJ7j?=
 =?us-ascii?Q?9Pp6SXhqEbG9ZdYZYkjyjTcY8h6uyIcKWAhWvTEjjYGbtKPuK2U5/FlTS47B?=
 =?us-ascii?Q?8CeTgSYlxJiY3Ypoa9NTAV1VoYHOOkASOuik7tEWDzCc8a5k/26a+GDWZllb?=
 =?us-ascii?Q?9Ftu2CThYtbytfmzQfBWyJtuYLTf+okwNg5T1HnxopY1OziPLa5aI6ERZp94?=
 =?us-ascii?Q?F53LNWz0n4LMAjVP8zu3ntEa4xT7MpvLaRVq9xclaWHUx2CRq7i6szZfN6i9?=
 =?us-ascii?Q?F5WyKM86mYR7bNfRhRyL0bNWN6TCL6+wIy1jZrBJIxxJz3tFvrHJfTJ2sIEv?=
 =?us-ascii?Q?NVfquOk3rgIKPuMIa0XHfWdf976MEtEcHa8CR1IVu8lopSW1myt9w1WmZm75?=
 =?us-ascii?Q?0cPvmJt2JHWwzw63Cj+rk3dcGqIVtQtfjniqzz9AaFYwlX2V9pvpkPfFvH99?=
 =?us-ascii?Q?NUzb8bzAXNWJKcdoIaxgjPCXJQ9k92vg3DkPRDBf9c4wZdQfwCAVofpFUL31?=
 =?us-ascii?Q?H0iZZsdMuSEbA2259QjKTvXfOZZdAGBZAnnNyk6q/PRJSDuFp3eDe9l7sbLs?=
 =?us-ascii?Q?k6YdKF9UG1wJfrqRI//zuS3mx1WcK5+idoC1woH5zE2g9mjOdTx5jcxWqWxh?=
 =?us-ascii?Q?dnbegJxXdgzi+6W3/0MUAERFDIQf9DMncR0kC2tmTMbnrvdRO9YdMHyxu2qN?=
 =?us-ascii?Q?fNBOyreUTR2IMNR74Ufe/NW127UPtBEc9zMRKmy8xH3UJb8nDcM1PzwXXkc6?=
 =?us-ascii?Q?L5W2+iU+JX616JjS1rhUylC6wxLA1UJoGOcjpz/MZrD2nT3Dbs6P1eUrhAzJ?=
 =?us-ascii?Q?GAroKYB75R/uBYYIImj9c2tmX1SoSw873hePyL+RflLQyZnN2dn7S6m/4176?=
 =?us-ascii?Q?dvYjPcVTenY8LSW+n/s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed05a81-aa02-4b5e-8348-08dbe636a6f0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 23:57:40.8213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCVCEmjmZCM5PijiD5yneMtz4NH5Vm8HQTQJ+4OTsU/KXJJnUwAOyTYpXy++917H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8745
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am leaving SUSE so the current email address <clin@suse.com> will be
disabled soon. <chester62515@gmail.com> will be my new address for handling
emails, patches and pull requests from upstream and communities.

Cc: Chester Lin <chester62515@gmail.com>
Cc: NXP S32 Linux Team <s32@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Signed-off-by: Chester Lin <clin@suse.com>
---
 .../devicetree/bindings/serial/fsl,s32-linflexuart.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
index 920539926d7e..7a105551fa6a 100644
--- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
@@ -13,7 +13,7 @@ description: |
   https://www.nxp.com/webapp/Download?colCode=S32V234RM.
 
 maintainers:
-  - Chester Lin <clin@suse.com>
+  - Chester Lin <chester62515@gmail.com>
 
 allOf:
   - $ref: serial.yaml#
-- 
2.40.0

