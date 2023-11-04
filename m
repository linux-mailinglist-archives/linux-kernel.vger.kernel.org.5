Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1919E7E0E74
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 09:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjKDI6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 04:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKDI6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 04:58:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2071.outbound.protection.outlook.com [40.92.98.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEF710C8;
        Sat,  4 Nov 2023 01:58:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z961nQVhwB6yhwjdmfv83eq9cY3EfqoHDzMeWcHnHqUQgXFllCFl6Kk6MSQoj4rugtaz5zqyaO3MsyN9EvSHP6CinREZhHELV5kuCRSi7+Sdp2nT1bkEu9N9ZQgll0BJA3GS/skvTBZX5P3hnzKR+nHwpp/EtIzgZfXRpiQ0ka/2uDX6YH2c8uKXowE3Z497cw09Jg3Xa2RGE/PWQHxJLnSmkpVtzqzsYOlOUHidR8h4eSebmNCkGnvpwczcLbDL66imW7suT1grQjzXW7YlRApHqNUxpY4Dfsfs3+QtmUtUXPhgFjKbPEUwa8ZyQmFuZZs1jqD4TxTL5ml4YV3boQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFrC7sTSqoCIGx+yc3FWCIj+nQ7iRhsnCncViE8azbM=;
 b=hxfOyL22SDBG3WDieJnLkzGokUzRKrGkzukIV+gJ+XXx7n2Cu4A2swI8KCVtgfRaL/Baewdryrx7PetNeh379LXU61xF/MO9BMzkqZB+vOk+5nZxZxXkA0gjX4oR+Y8LhLO/gqo+orEj4lDXlQiePwaARrhnjSdTyPNaRnZ/JIxP1gImTSAum1fuyo67zg+fXlP5yQD0xDHmPaSoNVCujAm5qOIHGYx7Slnhges9rFMb4SU+mgrl696oSYzB/hV1ZL1RRhJ5Z54wYMjk/Dn4OPzRiOqzcy7tVqWFmpGQoKRUoSevLEoaSYeVDTybfmMGYI6RIvKVtp+OETpAtFhEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFrC7sTSqoCIGx+yc3FWCIj+nQ7iRhsnCncViE8azbM=;
 b=iZTHadlqgMLgwTHlOhL5lO8jh0+16y7yWbbMnZpsDnq/X+VqU1yXNc6A+5PrB3xlK+Jz9Jp3GVefVvAdnY1RTWvL0SrqXJC6rAzlAhWqJ3OnqN+BRnznOM5o8kuch62qEttoS8ukuKA2EKqxmadHjF06TFMSC9vanqevEeRBdNDAu8vRAM1ts3IUjJV4ZAMgcwcJ+175goKYGbEZQKVGmV+1tG+xQg/mRurz+S+mR80VrweZjuQ5s8KSUD5YMWBAFtj95KDajZvnFIIzV4IsZlgL8STel/xEdU4w5gvII3G3eQGmnTKtNHTGpfUSJtZH+JKXjStXRAmOo7EEJ9a2cQ==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB2289.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Sat, 4 Nov
 2023 08:58:17 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6954.025; Sat, 4 Nov 2023
 08:58:17 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>, Kalle Valo <kvalo@kernel.org>,
        linux-kernel@vger.kernel.org, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v2 0/3] wifi: rt2x00: improve watchdog support
Date:   Sat,  4 Nov 2023 16:57:57 +0800
Message-ID: <TYAP286MB0315D63EBE1DE458D6B9D42ABCA4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [A+xEnW//4QoIHEHHNXnIon+MgYICqzjz]
X-ClientProxiedBy: TYCP301CA0090.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::17) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231104085800.17576-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB2289:EE_
X-MS-Office365-Filtering-Correlation-Id: c060e477-f0f8-430d-d576-08dbdd142f10
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H26lxjrUiinAINy6LK+UV+MVY+pqF4iwCaTuklOZ0s3+Un9oyMOw8SbhCuq1Rd050WPc6IIb2/iHrou9M0fari5UHwnAmtnq/GXYtlrfPwkallMwipmNRzVQCnJNo19+rvOIAuWKxidFAp4PMbkuyzOavRTjOPLM+7mAp8cekugcyNKEi4WN7QjBuNtuYYSnajquyeydIba6A8rmT9b+Vb2oLrvii1EaKq+iwd4Ow5svbZerLemSOpxgpGYSaR/yIOuUgGN9e8BXRckuJuPALN8dnXV4MZXVyr9HRAx5eTNaDlIoJohqpemKwVDvhm06mgNRneDjz2JyoKnYAnR0Wb2kwp/4xs3oJyCEVFC6Tf+oTo0383CISyqP4gP8ZzK3GsopVlYCFTjaTEnblcJyg4fO8n17ptZMhA3HjSgo3IIk2qaisUg9MfNpgnip/J3L5ZFAEDy2rlzFp9Fyg87dPfBERcr09I8GW+1FMR8oJR5JngNAL3L19LZPeKEJG5Iq7Z3kM5a3JIRcmrLzBBZKPN4ace4VzHtDg9MJl6dmIP/bdNmJ80wE7XsExOrG2sYMecHkqjniKWCYXkoUxKCUcRT8krmbgZMk61y2WCXpCno=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dWRTbzzr/byaBdzhoh7W3B7+8pOdX+rUaMonaUpaK5cWhLPqPTh8YkE6+3N9?=
 =?us-ascii?Q?DiL7KLPMhXg5FKBgYF6Y1UphKMmUq1Y47g7V1pl1KVfO8PsiiJStcf9Tgjo7?=
 =?us-ascii?Q?txk3+wrybauzMCHW7Hvyf7Oj0n7heD7nk9OMgbzaHMDo4RNGUCWb3wBHm85n?=
 =?us-ascii?Q?xNxi4mhzeoo+cjvgCT82063Z/EYneoL/q8UgrM0YMUtCI+kWNVH5If8qQx2t?=
 =?us-ascii?Q?L0YKNYDFM7f+iG8+lgFM8SZynQ97Kzc/E6lEIFzb1DgcmSSJQZzlvcJV1TlD?=
 =?us-ascii?Q?haghrCSxj9M9jV5MgyQsa/IHy8FcM60q9Uiy6yqSgwSO2nb1kJMhLaOTHn6i?=
 =?us-ascii?Q?GIC+HzQtl08EwBiMY3w9mvlPvICZJpsgWGa73eyc4i444PNNgCFvH0KlXAq0?=
 =?us-ascii?Q?bSt1INH2UplT513bl5Piadk8FVmBjkAFbJl8o79SoBL891T8Ug5B5B9QWLtw?=
 =?us-ascii?Q?mn73zT2gKjlraABlmygKt1Uc/7HFiSftUV+kUWowV5eFIoJjnqfBRRvFPUUU?=
 =?us-ascii?Q?7SrKlDAIJOne85jMskL6H6j/yLaP01EgCWTu51hf7ScO1nCZLDzVmzF3jdyY?=
 =?us-ascii?Q?y28kpbCU1rgWdbNsdK9/lVARC9lczB+oHXe6TgkojDlYVjWV5SqMaSIn16t+?=
 =?us-ascii?Q?AqLqFclEre0RCJjdypyQuSwdQW7RHUFBWAQy5mLc6TpETsBE3D3MPQeEQC0I?=
 =?us-ascii?Q?8D6jaYI7kBmvMtgC0hn1B0vU0LKSzojRmpw/Bnv1zgCKd8bgkC0MzEfsWNtG?=
 =?us-ascii?Q?w6hv74Sknw2FbcN1M+Zc62u2dyvNGj8m3DIQa9dSqTHazB8RwX+7dMP0GlSy?=
 =?us-ascii?Q?xKay78o/6QPVxj3lmMEEF4MKX+tFqRbBRoABYyc/6M1fp1b2fK82MR4EuDnV?=
 =?us-ascii?Q?svgP1U5YN8gcZzhhMWbAmCFWHFzQ/a6QszmSFfgSb4TgnmEimJEwFVa5P2fF?=
 =?us-ascii?Q?laSzj3YVVRtF0xSAwB1xssroz4CkBFdKQC15jSbCANY0w/R+brtp596NlUYu?=
 =?us-ascii?Q?pSRgU2CaXlXZDnqC2FTyET5BQxCkfuVHD3JKqYyM5Re10nGkJbyp1M9W5ZQX?=
 =?us-ascii?Q?poUvEpu9Vtyrh0TawlRg17gpUkC/KMTpcHYjG8ChQ/UB2R3rn4W8sdChe0ym?=
 =?us-ascii?Q?UxeXmlHF5zzwhukOHQo64j208YdxzPjvbcCoau3cXzfzbF34pnQZRrGfL/Nm?=
 =?us-ascii?Q?XQbpxL8ggHdDLcGZfbF6L4CB23wBlFA4tJuBXTx8ISO+oJvqw0CoflFUx9E?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c060e477-f0f8-430d-d576-08dbdd142f10
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:58:17.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2289
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series patches will introduce a new designed DMA busy watchdog
and fix two small issues when calling ieee80211_restart_hw().

Changes in v2:
* Disable DMA watchdog for USB NICs because they don't have relevant
  register.
* Extend 'watchdog' module parameter to support different watchdogs.
* Clear the 'intf->enable_beacon' flag instead of hacking the
  conditions of the 'else if' block. The logic still the same but
  should be easy to understand what happened there.
* Clear the beacon before restarting the beacon queue. It should be
  like this.
* Unconditional stop the beacon queue in rt2x00lib_disable_radio().
  It is no need to check the reset status because there is a flag in
  rt2x00 queue struct to record the queue start/stop status. It won't
  be stopped twice. The procedure still the same as patch v1.


P.S. It seems that this cover letter won't be included in the patch
series in https://lore.kernel.org/. It's an issue with the Outlook
email or I missed something?


Shiji Yang (3):
  wifi: rt2x00: introduce DMA busy check watchdog for rt2800
  wifi: rt2x00: disable RTS threshold for rt2800 by default
  wifi: rt2x00: restart beacon queue when hardware reset

 drivers/net/wireless/ralink/rt2x00/rt2800.h   |  4 +
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 81 ++++++++++++++++---
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |  3 +
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    |  3 +
 .../net/wireless/ralink/rt2x00/rt2x00mac.c    | 11 +++
 5 files changed, 89 insertions(+), 13 deletions(-)

-- 
2.39.2

