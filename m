Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AAD78B221
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjH1Nke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjH1NkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:40:17 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2015.outbound.protection.outlook.com [40.92.19.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A72690
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm6rKOOvl61xWK5df8B1rywmBX+/gcAJFqpTwoh+ap3UcezPkJA4MzjolBHIf2lMi2yxsNlJQ+MLkQaQNB2aNwnQHp0/Q7Hl1lVwKqqx1bhgkOqZtmaYP/6VkeiINek6eLn72DShr9FyrATJTjbwqsc4fnJtceUOT1kCMXry0PsU/HpRYx7bsMKf/5iS9ughzrBEAfIqDZMbaxOhGTLm7CIt51BX3mNdCZ5CoouGS0zLs4QqenEibcW9Z5WFgsITuFTvFK5DK80lRRIo5QIqBR5X7Rc2QWc3WE0Tk5zCAhS8RqNfbAqHy6Ar95eQb6NnVtTR5LxKheD1n97tHajZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmK+r73fs0KlYMjSrJAaNXZW75zLVwRFfF2qDvpAKnk=;
 b=TJz1+EZyuEyfAqS6KRh3TIDyfct0LU903MOr3D2eM6ecqqtkA2RkZryj/KP06LyXH4U9KdMK55b2wmdHMniHTnzWsaJ5fyX7MBOsZcLAN0Jg+fhiy08Pqtg3p0A9ZwMFqUeT4P5m0hFkD9VfvzCQcaEFmF9QB7pN8M5vOrpTlx9Lup93/kOWykxYMaS2YRQ8ihuc8LMplFwtY4pn41gSPvfrJlD80CWaFhR2EjhhBKAk/Qlg7q2DZ6158e2IxExmu6t76vJYWDQzx40VPDXHH1aNGyUjyufpPDLveDega+Les984K9fZaQbOKu6Gy2/ezrpIpPbMe+utPMVBSIs4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmK+r73fs0KlYMjSrJAaNXZW75zLVwRFfF2qDvpAKnk=;
 b=KjmDI9SJO0mLNQsYUByY5/Aaieb03zd8A0i9TH8iGxTBxga45Y0pLTQ91jmEZsQZkMH3f31fEA87gMOIslnWwqtbm8/9443H6LKEHA06m70VeSt3zkKHZKMGoNjbZ2M3ioWlosPA0QC8W4CxY1mO9c3F1XrTP7oTXsCDtfLwLLcUJONgVBTsek0gYx7rlWwGFN4GQ2agAXh86PO8atxgunBQmOSXtDOkUyyk5hqyL79dVeGiIQBDiZUQB1vFf7dOBB/X7GhpG9bsmmen4zC2gj2pCYlAGfiPVJomLpDLrkb1ODx0rmOqNkf4yT1snicKryvjkFVeRxphoNmucMJIQg==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by CH3PR11MB8773.namprd11.prod.outlook.com (2603:10b6:610:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 13:40:13 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 13:40:13 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v4 4/6] staging: octeon: clean up the octeon ethernet driver
Date:   Mon, 28 Aug 2023 09:39:17 -0400
Message-ID: <PH7PR11MB7643AC47A98B8A42130AD4F0BCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693229582.git.ozlinux@hotmail.com>
References: <cover.1693229582.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [fBnVDfeOyZtM8ujMXzpJxxX/bvgOdLX4Y/H1EYyXlnxXqpUeMzGte75njPbA/MQi]
X-ClientProxiedBy: MN2PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:208:120::39) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <e8d86ef1077e497005eb68b26ae998bfd628e140.1693229582.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|CH3PR11MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: cbeeea8a-e3c4-444b-8502-08dba7cc4e12
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmr1VCrDDYJl/lCLgD1Tr5zrrErctzovFMCu1hglkIx8bbFa4a7AvKGb+ftyHkjEEwrSXNlD6QjPeOqrBfs5INgJzPvdhyf8mHZMIKSrCJp6/VruEckRDVW2PioKdr1osLJTan5QXxrjWfP4+mWybIRm5ljgjYQ9O+6cma3WhkIz79xc87UXA9zN4JZxBtDeCpIrs3hQVrJkNLmOyZ5sHtsa3Wh/STng/tnqssH6VMZQhP/8LlXkIrx6hTIlMD8biAwADNIKs/wMhFfVwnXTqgd3yNUgwnE8YHyRsifKGJAgeMZ1HlVSDYdncTB/7pe3TYrZwkd8xcyutcNxD9ns91ZjOvINX7G6/phe6/+SDn3mkUDNh0etYmZY+0ir/RYtDCe8izKxRIFQy3LP61VUEpiQS+f5NubB9hG0uWUZWri0h6ESP3Qigy2LzpMP0nG4MJlodjImI6qyptaU2SXJBxWTmda30sR0pyJkmBoKdqGq5VTy1XZNOWURyoNmi+t8fcN+tKNvXP82E7K0SpM8NHEo4vxdwywYCokQq1vJSmghSWfCg3/8cM7lUV6w4/a1iQ9wZL4w+SSru6vJZvRgxm3ZyyMn0rAdcS/M9sixNvWar9hkoqz9DWby1t9gfNwL+cVEZ3WTexU8af9FETVHbXDGFbyHjlLPLSfj7iUuoZbhhYSBfmzfrp4A7S1lgswDosRl2ftzneoDCAJdNwRzA9FJqJPE13gh2XpMg1TRhMN6gjuA5Sg/S58isIZO8QW16Xs=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /mY+K1dnKsmT0Mmhu4gF1I1pRpbRCzCYdaOOO7wkJOU1sl8ivnvwRLRDVxJeFtGO1lsTENKUNWCrxNJMZT+W3CxZH3tellwlVk2OKO23NkH8/gYWFgzhlB2XMY1iH3Od19rTZZR0HHHtLMLNZo7AMDRSw2nqAd4gsGi7qb0D+yYpw7/+4BkZW6J834sD3JjfzVMr734iSWAHZABK2/2pvz0U02ub0xBxmFm0Np04hXqyZ1S1x1eZHYYv9qZf27W6aGPg9JSmprWulxkbvH0Nl3QZ1k3k73ZxSII47jPNou2LPf3TI+ShhiN4PIosSkcDpBakUFihas3ttx+oM783kMuoobFFIkhW6EmlsTEqChwbzk9HVtXSaF0BkyYM/BePKL9xHdt2xQ3CRzg9TYmsIJyfL5DXBv3wVNsMmz1YCTPmRkkpmGvr3EhuhkejaDDoFtl2+FHP7d6trajhTlCLzAKWLN2fWk299+DWIGO5g6c9l4vxSc172tKjy2PfgOWgNrqTVvFxB4vc3TnXbNOCtKveY90pYugV2jOd8AQXwcNcwUPAIKndZ+9omd/z5LnY0z8wZGo7N2yuioz6f37GaPQgZnz+ovkV5rbF9F8LNH+sfnywRknM6J8jTt2Mj1me
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fj9iY+UdV7U143k/WwSL0Kb6BFXJ2mdmE02fXh1+gIjOJrMWxMAINRejHh/t?=
 =?us-ascii?Q?XHEUSYqsbrIs/Wc1RiZB8kHuHaf78mOhLasacxMQ4ZGhbMMwH6oWOU32bI2i?=
 =?us-ascii?Q?BrSnY2HobZYEsNl5IC7r8MwIwRWQlAD7uvOPF6hyZsWmi26fPLMSHVBUIfMz?=
 =?us-ascii?Q?SZr8kGVLpBMg0WTpp3rZ8RIaZ4RVn3z0DwC1chmpCOLsowaVn9/rzrOcAkX9?=
 =?us-ascii?Q?mndQ77m7wNDpwoGHwFR2nbP7B4N2oahUwbZaAC8MRCiaV0Ug5LYkvToZnl1D?=
 =?us-ascii?Q?rz1kb2jz7wzZ47PpW9Xy0319+KTtb53rWuFDLs5TCHiPX+GFwKTU3IHiI6wT?=
 =?us-ascii?Q?3jMbRnDIjHfpqN2Zz8J43vkRCoCpf2Xu5qsh7aSZkCYccWHWqJQDOvoPZeJF?=
 =?us-ascii?Q?JPj60TqNkqD+McsfTQWFdSnjPYwRavsacIcV9FCxPbm6crLVWaTM4rx+xuTD?=
 =?us-ascii?Q?IqATzqQoht5EZ2+Jw4V2Zv2pNWNX+ngxjhKIAKvAxEt4ipf2h7Sb3mZ0eaoK?=
 =?us-ascii?Q?d80kAYjkC7SXoiP/a17PHTjLqMuHav+CzdZqC1mKVr+ZXPjUk2QljqpjDCjj?=
 =?us-ascii?Q?Bjes0xx0TTvzT0J4+Rv++q2yvO+zWiIL+XsNe40igEAOWmCrr3gItGPDISMi?=
 =?us-ascii?Q?eMTZtC8VdImvOoUN0OxrBaDP6B5CId+1odho7OIMcYz9xu9pVeMrdyMw8mlp?=
 =?us-ascii?Q?EYgdvXethsK4UlmpyEch0a49228sbCVSliVgcP3b5GEb0mij4UJJpFqfLGuc?=
 =?us-ascii?Q?kzCwfKq4UCImbw5Xl4OO4sUiOMeK7tdPr1Qeh+R3oyE8CTmx1WxyON5q+LHE?=
 =?us-ascii?Q?nhGSajQPgyQhcPEaWb+5G+KczINPsJA1QZdzC78rpEmXf/wyXVWf+VqVpWAk?=
 =?us-ascii?Q?mcLGngnAtCT0skXLn9oZn7Kwy6RHFPlwoqJoux84pV1M2i1ViJYoDB/q+3rQ?=
 =?us-ascii?Q?nRLeG9rk27E/+eo5W+lUc0nb01b82EldqTPmM47PBIhKhgLIcgw/5cdLNhp2?=
 =?us-ascii?Q?9+ilvyOtneh9soVlavuO65nqRS5NBFO80xwussWZ9t/RwyDnhm0iNHlArNTi?=
 =?us-ascii?Q?aqMrSQs46m4znSMqX/gtBSZQJgHDO4vGxV2eWkoK+72Rx9tioS3CQ4zE8lsb?=
 =?us-ascii?Q?LIJVXumf6tR7IaZFmbvYC8GZzxN6tgSPCVybIgHj9gvtuIpKAtuLjarzbQJD?=
 =?us-ascii?Q?kMGt3AejKofLHa/+iy9orie96uig75eyWvlzOQi7CfBjzBeuKCs7fsNpvw1i?=
 =?us-ascii?Q?mIbBLYdASmmUoQShFgX+DRBNXtZNM/opfRwvImrK5A=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cbeeea8a-e3c4-444b-8502-08dba7cc4e12
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 13:40:13.1841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8773
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the octeon ethernet driver better adhere to the
kernel coding standard

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
---
v2: Actually send the patch set properly
v3: Fixed a bug where I forgot to change all instances of a struct
v4: Actually fix that bug (this is my first patch, give me a break)

 drivers/staging/octeon/octeon-stubs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 4470c985dc5d..2cdbcbd8a97b 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -238,11 +238,11 @@ enum cvmx_pow_wait {
 	CVMX_POW_NO_WAIT = 0,
 };
 
-typedef enum {
+enum cvmx_pko_lock {
 	CVMX_PKO_LOCK_NONE = 0,
 	CVMX_PKO_LOCK_ATOMIC_TAG = 1,
 	CVMX_PKO_LOCK_CMD_QUEUE = 2,
-} cvmx_pko_lock_t;
+};
 
 typedef enum {
 	CVMX_PKO_SUCCESS,
@@ -1381,12 +1381,12 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
 }
 
 static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
-						cvmx_pko_lock_t use_locking)
+						enum cvmx_pko_lock use_locking)
 { }
 
 static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
 		uint64_t queue, union cvmx_pko_command_word0 pko_command,
-		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
+		union cvmx_buf_ptr packet, enum cvmx_pko_lock use_locking)
 {
 	return 0;
 }
-- 
2.39.3

