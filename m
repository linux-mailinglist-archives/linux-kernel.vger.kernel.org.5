Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4D47C8298
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjJMJzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjJMJzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:55:42 -0400
Received: from KOR01-SL2-obe.outbound.protection.outlook.com (mail-sl2kor01on2114.outbound.protection.outlook.com [40.107.129.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8619BB7;
        Fri, 13 Oct 2023 02:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUuoI1HLb5uOBchJO5wxNOKTnyu8sJNxF2ulVaJXs7fT/h8g1jMLazuvFljmNbEVDfCPQ79jGcDEaidKNou3x6GcRvukyswdbf5AcKb0HdHmmHEjkadrkvQXdncT66HoQExpf3YFUjke22mevvdEKKaRNMPutlaYErxnjHsb/7zmDrAe4+iDFeK6LE0c2I3h6Y8ri8TLj4qo2y3aFa8vf5cGeKYCfH6jPq4rfgeVjz/Bp+ceBAHm0BhDdhoPiKQ1gFzRKXDnnv/PK0+1PbpcJdC7D/C/LJMAgA0pPGEinmXXazkzaZitwK8ocRSpnGGXoBpKwXytyeanjwdAjr7T/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uj2B5XcVZOq11NAUOS1JSsynye8q41z0wlmx5dwKbQ=;
 b=OdspclFgHAeRNlf5p7P4a+hhqdcj02jOLpL4ww0vdgTpKeS6UmEnXkKh0RfCIxSfUQ2JmlmARjHBW5NDYezGE2C4Hy8RSO1GnHjD0Hk3f9zGp7YnGj2qROttepFSsESnRPz5JAxDdXJt6ZJSC10vEho/LTcMPsgFZ4sk32/eZ9XTj+z29U8NRj1UQ3r4yhgbG4KJjS0FrooPyHfUYEVQ9y175ryngC227mkuiBixpPQEJYDehCNgQsuIumdhl+xgn39/Vyxrbk++K88RwNd3yNAJNoh0Iwq46qKJtFOd+Z1osCmNgWYpXDJroQPB1YokcMewj2Xd8NolD6AHuhYVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unist.ac.kr; dmarc=pass action=none header.from=unist.ac.kr;
 dkim=pass header.d=unist.ac.kr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unist.ac.kr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uj2B5XcVZOq11NAUOS1JSsynye8q41z0wlmx5dwKbQ=;
 b=KHCBCGSsWpWEe2mUz9bFa/VHu64A8jsB4Gy+nAUHZyVQZvZ7NKvVepaVl9q9vdaBXNttGO0EuvH4uS7yyKnSJy6y3cgAdp2I6hPxs2Tub0Ku/zgtMpSBvnmagkoJ/31l07QkopmRWx5Z6ucoE+/VfkgqgBLPwcFaLFive5ox898=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=unist.ac.kr;
Received: from PU4P216MB2281.KORP216.PROD.OUTLOOK.COM (2603:1096:301:12b::12)
 by SE2P216MB2055.KORP216.PROD.OUTLOOK.COM (2603:1096:101:11d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 09:55:33 +0000
Received: from PU4P216MB2281.KORP216.PROD.OUTLOOK.COM
 ([fe80::6ff3:f217:1fb8:db64]) by PU4P216MB2281.KORP216.PROD.OUTLOOK.COM
 ([fe80::6ff3:f217:1fb8:db64%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 09:55:33 +0000
From:   Ingyu Jang <ingyujang25@unist.ac.kr>
To:     davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        ysjeon@unist.ac.kr, Ingyu Jang <ingyujang25@unist.ac.kr>
Subject: [PATCH] crypto: authencesn - Fix incorrect setauthsize function
Date:   Fri, 13 Oct 2023 18:55:23 +0900
Message-Id: <20231013095523.184497-1-ingyujang25@unist.ac.kr>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:404:42::15) To PU4P216MB2282.KORP216.PROD.OUTLOOK.COM
 (2603:1096:301:12c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PU4P216MB2281:EE_|SE2P216MB2055:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9f002a-25ed-4098-6fd5-08dbcbd28aa5
X-LD-Processed: e8715ec0-6179-432a-a864-54ea4008adc2,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9dkYwtN5obXPgJMgilsPR40z8aw/KzkD9Jn0uL1VpxwaXERpE6/iwXWxU6izCtYCbUVtBBIO6qoeCZSV+Ys5dk8864caHPspeKDEOl3rBmjKJWauFleaNQ26ilNxa/Xrfq/WaoMUTvYtAWHvNz59w9FvhSPSOD+omEGYjK7yo8LU3CQr1AJeCVaP9G3TZ4FJg99gmOQyXbTu4ihVs7z4reI4CBd3L8n/h69qo5r+vKiqZEGcyWIqbrSWN4upUNd8UKT8qXjvBMbmTCCNMIv3vj8RobUmqOTMXVXwcUsRcQogMyrWnXwefIwwVBF/pBUz7zfA3OOf9k6SMd2VJtqeVgXcgYZzFadao02Ttrar+S1Y51Qz36UABau0O7HODU3SRWzc01Ltz16bpDCxysTQW9aild1wjL/iCS2FPnWHjkWTxRvU3UChpnqc4yU5fu9D7rmQjLr4tlB7CnqTK+tUqt9w7CQX7r97iNFApZidlZsKyQS6hWB6STI1qCs/b2GXX2OSERpEUUA2DtIWG049/uYHGd808vKaGB6hxm+BMoWQyNuYjJAeWWjDdWvVn7fq5IH2nlWERi6p9XZpQllJGq0v7Mx3cJzBc6ZNZICDCunfJ4fgZVxl2pFmcSVeIU7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU4P216MB2281.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(2616005)(38350700002)(6512007)(6486002)(26005)(1076003)(107886003)(52116002)(86362001)(6506007)(6666004)(478600001)(41320700001)(83380400001)(8936002)(38100700002)(8676002)(4326008)(36756003)(41300700001)(66946007)(66476007)(66556008)(316002)(786003)(6916009)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m/qNwRe9WPa8IZvn8TJXAcKDHgjBGazhe0dByt7/IxuDLjf4nLZVMjXHhVFs?=
 =?us-ascii?Q?nRY/jE38ip5JNiSTlM1/Pa2fdLBdMF+75LdYH3M1MfaqZT9GzZF8XnAyanVH?=
 =?us-ascii?Q?l7felA4DilnUar4NZTpMJkgb7YDWi8X0+kRu1QrFQkkH5OB/6zfYYaaod90J?=
 =?us-ascii?Q?XhwGBeF0fUN+e0vGkh2bTveoFCHVNkKfqxJ2JKZQIaTwqxaUabrcu+SdHnzK?=
 =?us-ascii?Q?NkD79p6STfWw0zOOHZW6DiA4rXy5ePIo2h91O8yraec4/uPdW4B+tf6z8FU2?=
 =?us-ascii?Q?SGm8xrvEfuWHwM+9pPu9PqujS5gGs9nwn61DxC42tYNrzAH5iWGJ849wHkwS?=
 =?us-ascii?Q?VTyuSr+gGdrT5weAhFO02gkP8hknNj3TfCld7bppFs1DGAhH5XX3BedBTkg9?=
 =?us-ascii?Q?A6gh9wZYuDFdSTQhVCCVud8P3Eh6RvgqckQ0++qikMcKLd+lMpb7i0D/WJgk?=
 =?us-ascii?Q?avI8bhRUwf/ZrUeK1VqFj1Vfehszil+k6WR/+63jNqvxhGcu7qNM3/O/5KmG?=
 =?us-ascii?Q?7QaSYbLJJ3vV3c6x5jMNJ+AHdvStImpWqQbE/++Ema3OSog3Zal03lgRYVbU?=
 =?us-ascii?Q?7iZeOk7nrRIyEjf26z3Ef8J2/JPbZWybQ0mkvmS4QhoB3HPZelJR/cwl/qoM?=
 =?us-ascii?Q?qIuLN3hldSVvxqgEqLT0zhDq4bGmsB39VYsm4t+ZsEgej3hRp5Fwatm7zevV?=
 =?us-ascii?Q?brYZM1eCILoP/ka6gBnPNa8YV+QM5h5g3tDKIVru0/mhh66SvOkPdYFhxhog?=
 =?us-ascii?Q?eQO3C+/cNIeMwlb3zIS9XgKJhQyD+EJKFhxhK9AwBXUMSTTIlvXVf+Bb6f5S?=
 =?us-ascii?Q?KE3QdX0+k5g4LIvwfy54BzMOfcSRMwVvdIo3hGHY00sBXPTUscQ9iMFXuesx?=
 =?us-ascii?Q?PIPbn5unyR6Whc6qHXeRBz0MUGkM6qWpU2l83muN/NYnPVRSb1SW6VBfzaP0?=
 =?us-ascii?Q?pGD4EK05yvRQVbFD1td9l1HREJYX7ARpyvJuvq5ltVqRJy7cdM3eTiXbYs86?=
 =?us-ascii?Q?kv/l0aIB68pXWHC5kOniIlXpAgaz0H6PVNXtrpST4eJhhDi3kR/r8gAxdJi+?=
 =?us-ascii?Q?U8CISRPwFrPvmouAhYpoEyqsD+Aml10C3JDif4wCLuwUf10ude/3pPsVXHqn?=
 =?us-ascii?Q?iZbCs5/Y9HGH2aeK6gHECxsxlU2bRgO8ty172YpXm6biqOd9iq2ZiI1UmgIP?=
 =?us-ascii?Q?RMcNeD1/p7yQbLb2+tuqm7YqMyg8yRM71DBBFo82yjdJAeWFCnicmr0fgMXE?=
 =?us-ascii?Q?mwp6lnbj7ciyxE/rqMcoKG483u7Uv3zpgdp6/br+4p6dQsCV/7DHSe52B5HO?=
 =?us-ascii?Q?HfKkpC1VlblCREcWvMk1PpuJlVJlwTBGW5YEYSD5b+9W3MweS9uJKeRVxb+s?=
 =?us-ascii?Q?r5Tf7NykYD5p++PmeRYVcbX9IsQBS/+fl2YiKvaKLZgPPyGJinGrhUpM/cL8?=
 =?us-ascii?Q?/9NeyGVTdJF/sV+UNeyzgWjDweOhDsqSfSEqV5K3UCiKzVr31KX+OYGYI6mh?=
 =?us-ascii?Q?I545Z5OkmTCTf2wOLtJ5IM6iXiIB4xgsJe4cex7f3CoNoXEk+PSGfc95mBhA?=
 =?us-ascii?Q?LnMKrciNb6IC7JXncARQm6VKs0S8y26ZwmQa3o/X?=
X-OriginatorOrg: unist.ac.kr
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9f002a-25ed-4098-6fd5-08dbcbd28aa5
X-MS-Exchange-CrossTenant-AuthSource: PU4P216MB2282.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 09:55:33.5360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8715ec0-6179-432a-a864-54ea4008adc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+7Uq3AHDEo+2zOHwlQQapUIZ/Jms6k8Xb0ol+lmFbWIvL6TdlGmvNmKRqw8cFHht5pDZdd5W6XiHK8Cvkv4aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB2055
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a mismatch between 'setauthsize' documentation and
actual behavior of 'crypto_authenc_esn_setauthsize()' function

As per the documentation in  'aead.h' for the '@setauthsize' attribute:

@setauthsize: Set authentication size for the AEAD transformation. This
function is used to specify the consumer requested size of the
authentication tag to be either generated by the transformation
during encryption or the size of the authentication tag to be
supplied during the decryption operation. This function is also
responsible for checking the authentication tag size for
validity.

However, the implementation does not align with this description.
The function only checked the validity of the input authsize without setting it.
Consequently, 'authsize' is used without being initialized,
resulting in an uninitialized memory read issue.

Signed-off-by: Ingyu Jang <ingyujang25@unist.ac.kr>
---
 crypto/authencesn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/authencesn.c b/crypto/authencesn.c
index 91424e791d5c..c1346d5b7950 100644
--- a/crypto/authencesn.c
+++ b/crypto/authencesn.c
@@ -52,6 +52,8 @@ static int crypto_authenc_esn_setauthsize(struct crypto_aead *authenc_esn,
 	if (authsize > 0 && authsize < 4)
 		return -EINVAL;
 
+	authenc_esn->authsize = authsize;
+
 	return 0;
 }
 
-- 
2.34.1

