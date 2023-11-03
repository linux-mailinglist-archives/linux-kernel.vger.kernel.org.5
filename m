Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125897E0491
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377772AbjKCOT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjKCOTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:19:24 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2029.outbound.protection.outlook.com [40.92.59.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74086D45;
        Fri,  3 Nov 2023 07:19:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsSL07w4IDLC0fhabW2zz87kspfGWiGxX1lFw1ScYke/+hjktyBC5fDZmPf8Y/4r0Orn6nlbutyKqjMz1rIwJ9rF1yQvBiiRs70ggT29evr9vVTWTF+PodBf8GJylLxQ9gs+g+fOzWzhkNEPdEvfS3JmSeImwOJ8pE7jJFjzt/L7sn6F12G/yENUXJs2M0AwAFlZXBtDdwEs7IRF/8Kuk6mvJHGFN5mlIHZztGmBIx/Khy/eM3uW2R3kUXvWH0ZdFZyyheJyh2ES/1zgKHzqLgdfLv1RKFWLgNRW29LU6cRCyxw5UGWA7Ph4kwXzJf/XId/KYWtZ3fpBILrc0+g/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haBTJKP1wIWpjjT1d+Hh1wPfbOWb+381XDgSGorsAl8=;
 b=He86B8lQ5o7SJxNav+iOp6nc8ZuWjQ74NhL7Jjs3mAU81mJ3qCSennZYWTIjjLroPK+2hs0p9u3isUhp++CwSM9RfroNTJ30gksJE+v0C+jKrXGeC374EPFry4iGXbWuuJNKziLyfLthVynh1o1XIY6e+e5OPnyOGrsra83lbR0BdYw6+AkdnrKVkcDeYZdxEQJG5dIHI7JqOzgfTKBc4X9ee8P9ID8P5L5XAj8EjHhwOijve1P8bhvynXPSmkg+rhqCVdThegyDNDnT8gQ6Lugzy7+WtyKb+STgiSt+VyKG9zQDKe/tqP9aQE97KiwRZ/aEsJ949iR8nGhrcRy/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haBTJKP1wIWpjjT1d+Hh1wPfbOWb+381XDgSGorsAl8=;
 b=kw4DJP8qngTYaCfBNqF2nYq5+LJsMdV+vQYi0Taz88ztdWrEAumW7Ow5VSZ6iegwHujRIAdgbvGk7V9xmzOuLfdMsKM5ABUY6zcY1rZlOtGgs0vbkmCm/9D7BGuei9BQvK8Hidxy3HcKAQ//CQJ2uigvwHLOuKpXxs1VGRFmbj5qR6f7GGxChBqYrVd9lBoCHl+KiwJfRXsfiDasheUbw8bRdMn66ARrQkMceZnxmM8PudTGwpl0bRmJBAfy+MjPrKG1yw05E5N6/MN9yH1YAhZjUy0xsMPz5V2ASD7PzorW/cDoer5A6OhGUC3SLXphzLeoeKgk+jZ3GO7bsxCKug==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by AM0PR10MB3331.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 14:19:19 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 14:19:19 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     gregkh@linuxfoundation.org, yuran.pereira@hotmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
        edumazet@google.com, florian.fainelli@broadcom.com,
        justin.chen@broadcom.com, kuba@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH] Prevent out-of-bounds read/write in bcmasp_netfilt_rd and bcmasp_netfilt_wr
Date:   Fri,  3 Nov 2023 19:49:00 +0530
Message-ID: <DB3PR10MB683569338168B85CB009A5E8E8A5A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DB3PR10MB68352DF6CB458CCF97C416ECE8A5A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
References: <DB3PR10MB68352DF6CB458CCF97C416ECE8A5A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [KrQf17aBUp+IEi7VtwCbhN0E29StOFCL]
X-ClientProxiedBy: JN2P275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::26)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231103141900.1620900-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|AM0PR10MB3331:EE_
X-MS-Office365-Filtering-Correlation-Id: a77bc5eb-178e-4323-5c20-08dbdc77de16
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZ6dRuSPIOjOsceLX/6WORqs5W1BwHEjT/KrvjFoNd+zCCx6/A5G9vRAx6PI0BFLHboAdyygGQZE+XBKSIbhr0I3EFEFFrt33jdICh6gfaeUjpDs5Zw1lJzju9+uQQAipD0mrj6XSdQ9FpVxYx41FFB0hPhGanOmXAZq+JEheNKCUjdcrJoGYJUYW2NWiES9AbxXNdbrJBj373wxk8ppzRUTeWwnWtkkriQHgR04B3cswHRMuLPp13/EZB9TxvFLaf0RyjWPNtwahVd1ROsigTaI5Cf7Rinjh05fq+UxNZS4qLIr1RCgt26CvscbSM1sEcn+EO3ALySGOIWHp4TuG1l0zab/HlqkuGzd/7fB7y4fpSa/4wmvcNIfm4DfQSB+h2+P8UM68W/8owU4rUe0lnf0R2wli26m6N8dx17W9TCTXuxOEjPNMkOS/WSalPuE6Qn02AbnPECEmLyxObqWe97gPMFlccid2gAFnQfcFbzPWnFsQAoidQwlDyzXjTpIrDurXA+cswOhJ3jLNz4GJK5hMoWwHPNofmNampWIrq5TzTrmTu1mGKvisO30x0lQIOzIGGZ0sjie3UygHFRrM8ytYEJ8stUKFRBhadC1b/OYgpMVuSjjwbeXm9n21A4I
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cse4UXeTk3Cldc4FlpAzcTxFjuoQM5Cr+0UKo6ohVwn6UHjVjbobRyTBHc70?=
 =?us-ascii?Q?lLdtgYcNuI05OO/UzdWMQt0EJ2RSNHegIoxaUtAXYp2v1YYit/GuBrJp9sdJ?=
 =?us-ascii?Q?ccbCXl/p69VXvvG+rvjahCDpHBpoLHUwKPCmYJ6d8zfiR5ca6B8L0+ineM+w?=
 =?us-ascii?Q?grkhxW7SO/yfOwVJJKrHm5KAyMsNdGu42r8vAbcnUtxjkII4G4Fkobp5y/Ho?=
 =?us-ascii?Q?Ph+xOZBjSNYx1t/+2bYEWve7OW+u8K9X5UcRy2JeRexCeU1WlkfhqYm5jD2S?=
 =?us-ascii?Q?XuOxCyxGhUXByo61sW9FZ10PtertbhSyV8c+59HZuqtwsLmu5GZAOSnq8q+2?=
 =?us-ascii?Q?SgaaZGhNjFAylqQnzslOQgKvYI5eoQurYpAyLEESvhuzwp0ha0vy8oI3Dg0E?=
 =?us-ascii?Q?8lvXlkYxX+Vuj8OAraM8hqy2CYBQWAl+sZBtWo4VxrBfNWuEf//s9veTUk1l?=
 =?us-ascii?Q?BQv0mx1wOlYT/6F1uQapSZy50Pic7RXl04rasw6lvotttut4QzR8TuSIbZ+Z?=
 =?us-ascii?Q?U7vhGZb1973JxB1f0Eshp6quIzwfqJRZXOQ+OF0vF3Zaw3YPpmPOgleBzTBY?=
 =?us-ascii?Q?z+rsIagRMjo/ZHtkM10a/cXQOElhmgDBJ6vwcHI/JXH7VCFhgW07/KH2Zkgb?=
 =?us-ascii?Q?MY3SgGxQJ81pdYmfdsB68ZJxU4DHAqsV1U8LoLNj0SaFWm1MvBg0l1m7Rk9R?=
 =?us-ascii?Q?kSEJWabRAHACI6Mg1GRqAk9pTqO478y4Ug0mA0dYePlhw+oDhpHV06fUJYKJ?=
 =?us-ascii?Q?ZKIvAe4SI4qEhHbNI/4CVLlNBUk7an+s0mkU2V5VFjHfmiteCjkCLC2n/oCX?=
 =?us-ascii?Q?rOb2fW7mZtT5lC7Y26RQl4UiQqm467YmH8jqPbzxaqd40MyIVMRdzSBLCHAa?=
 =?us-ascii?Q?aGWp0Gobn8ROiPSGoW9QBfaAY5fxVagdPUBCA+NfFvn5YIHgx9TDINeyNsqQ?=
 =?us-ascii?Q?uaet6Hyl7YtDoJ2haea5AnBJ5vM9Gheg1XD9xOL3qVE2EKXbW7aFhKzMIMIr?=
 =?us-ascii?Q?1zmxSfPGxcRsMqP4ZHGI/3SB9GRtjwZDr6b4kSF5GYsXPdfJbdBNw7x4Bw0J?=
 =?us-ascii?Q?8/TBbgn6Og1O9YyreRF+BHhmUNiXHZgz3+s7z/dDjGddaR11xlRog2q70lu/?=
 =?us-ascii?Q?KA4FySu7ZcB6LftMSAU2ieBx+TiZPbUO87GtTz9kCthN2/hZVpeHzZ4jBVlT?=
 =?us-ascii?Q?Bam3YuIjPFGPJYlnlMMod9lzmaZHAyN9ksimERtsXZBCjW5Wmx86ucn2H3o?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a77bc5eb-178e-4323-5c20-08dbdc77de16
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 14:19:19.4579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3331
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On a second thought, it might not be a good idea to return
an error without modifying the caller, since the caller of
this function currently uses this return value without checking
if it's an error.
I guess that explains why the first check returns 0.

```
static int bcmasp_netfilt_wr_m_wake(struct bcmasp_priv *priv,
...
{
		...
        if (first_byte && (!IS_ALIGNED(offset, 4) || size < 3)) {
            match_val = bcmasp_netfilt_rd(priv, nfilt,
                              ASP_NETFILT_MATCH,
                              ALIGN_DOWN(offset, 4));
            mask_val = bcmasp_netfilt_rd(priv, nfilt,
                             ASP_NETFILT_MASK,
                             ALIGN_DOWN(offset, 4));
        }

        shift = (3 - (offset % 4)) * 8;
        match_val &= ~GENMASK(shift + 7, shift);
        mask_val &= ~GENMASK(shift + 7, shift);
        match_val |= (u32)(*((u8 *)match) << shift);
        mask_val |= (u32)(*((u8 *)mask) << shift);

```
