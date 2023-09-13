Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9118079DDB0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbjIMBjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjIMBjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:39:32 -0400
Received: from CO1PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19011016.outbound.protection.outlook.com [52.103.10.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431D7115;
        Tue, 12 Sep 2023 18:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih72f4B6CwQSXVjY1exJx/pBm0reLDd4NfQTyxZt+SPmF3Meuv1Swlvke7QRQa0fuWjsMwPKYL2xdU9E9witss6ubwc7bi7pxFpLGNn7r59xyvGO1MRTLeEBfouYnQfVnXjgq7jll5YGIUs7OXLXHocHJgcwqGfccd7uR/7CFd5eu7UJte8lJvduEEXnK4GYy3IqzIF9DDjHBBPpXs2Nno+gjYGLea+332HsSlrGnTy3ZQ7TaCT2DO5vP8fifSqg89mN4v0CMIpCbUSFXNKNAnnSSQGl9MqrGTH3F09j231bCq0UkWmcHAMj/sqMEUAJVaei3pe928rF9r8WgbmtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRG3Jb8bb2nP0BTsCSJTBgtYqBy1CerpCSU9FgeIhCw=;
 b=LvaZZkQ1zQVsWBUV9LNhGhNqFs9nbV/14KXDKY/cNcdOzeJ94MxttOvmyn75qYvGNSkT4IA0yAYt8UqUQqkLi9fObFCOKZJ9MJ6CLYiZN6efzjXiBxLl2ZUekmpo/Y5mduGz5NZrarApnAiv3NpZjYwhe20Yq58i+1QMBtiKtLxUuRly2xh5rjbye1K5lI6YdLweravD3kLKQ1jRU3nnVC3iJhKFJLb4B+wXRGzDP1sWk90QpLxqJuU9zvvlh8Tn5UX6ioktU020iLX8zi6SRTec3pis622nWLEXKzO/EWROKQ0ut16b6hmh5MICsiqW1o01vainOyPVCi7BA8OKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRG3Jb8bb2nP0BTsCSJTBgtYqBy1CerpCSU9FgeIhCw=;
 b=Po1cWBLWeJ7DP3hJKLFlkpN4nntzaR/s35KyTYL7kyeCMV/d6Um6+JZYMsf2GMI407ZZCEjBWf+dBHwYXUqmcAFWm6hu34shwn5hEKisn91MRD0dMEBPGLGbc0XMW0RVQO5iJ5mcuJWgHyhOt1DoCeRx2d7NxeCaWPajrFk7qcPKTn3II8O/IhnjeXSOtouNYkg6q1zFjGOgi78Zw5YW6vhPFRYOijs5sqF34k3MitcFXPjFMGgtcnY+UTlf02qkP6LqDUkoTseU67a4aehLNVMFsGgJ8Eh8PqeS4z8LKiW3VMsFXO40KQe5zTFvqBlW3TGHriyWmXvpfowFx65jEQ==
Received: from CY8PR05MB9378.namprd05.prod.outlook.com (2603:10b6:930:91::8)
 by SJ0PR05MB7801.namprd05.prod.outlook.com (2603:10b6:a03:2ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Wed, 13 Sep
 2023 01:39:26 +0000
Received: from CY8PR05MB9378.namprd05.prod.outlook.com
 ([fe80::3ea2:7971:7c79:b09f]) by CY8PR05MB9378.namprd05.prod.outlook.com
 ([fe80::3ea2:7971:7c79:b09f%3]) with mapi id 15.20.6745.034; Wed, 13 Sep 2023
 01:39:26 +0000
Message-ID: <CY8PR05MB9378AAC222D4298DE011ED6BCDF0A@CY8PR05MB9378.namprd05.prod.outlook.com>
Date:   Wed, 13 Sep 2023 09:38:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: [PATCH V3] xfs: use roundup_pow_of_two instead of ffs during
 xlog_find_tail
Content-Language: en-US
From:   Wang Jianchao <jianchwa@outlook.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <63b3742c-0efe-c096-c737-a0e0419480bd@outlook.com>
 <59dd15dd-5b35-871d-6d3a-ec779975b089@outlook.com>
In-Reply-To: <59dd15dd-5b35-871d-6d3a-ec779975b089@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [rJLQNKwNUuvPFL1yeDcZ6fPrcdRBupt03dBDEVDaMEE=]
X-ClientProxiedBy: TYCP286CA0048.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::11) To CY8PR05MB9378.namprd05.prod.outlook.com
 (2603:10b6:930:91::8)
X-Microsoft-Original-Message-ID: <0a72f462-8b8e-4dec-6ce4-f52e33423957@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR05MB9378:EE_|SJ0PR05MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4d7f4d-950c-4bde-b3ff-08dbb3fa436f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZaDU6nr2nZxd9aug41VZGrpZPKPUUsDRfSICTSWd60z/302xLXQpTRqgL98F0vOKdlKax1VIQdD02Zivog2tVE2544k4yxBJ2R6/k3m19asuBigiaI6AYefZL9i7otWHSLZqBWWBsOoMhYZvMP8OXWunAfGmlhWBuXFW8IHAlR6KnGtDV+1ub7HQY9i5L0G+xoVPimXGvoBErygBEZMUIJ5pgKaOLoXJfGR+nhZ0wlt+/D3V76bOi13WySzf+tA6tGLITb5rg7PvtC9u0K7+drKkN4EPTNVIGSaaf6tpcVOZI4EsmLuu4dNO68rN7GnBenSo7dBo4rFwjwa796e3IlfRSMA1JFssh6Ror4WxXtSZIj3toS5/F+/NMhzDi1/Ez4iPxBENRLpQ7M4NeSZgFrwMKVyC9bLKvvDG2GDx/Iy9Y2hhuKIalHUFsF2YL4+W6HLUyBYGIbc2cJ5rglLmKBMidn7rzD/Gc3aA/X/0Zk22UZjrJejrk5NeNaNLqVgWoCzOJlxb2giPJXjJRtnnO8MbHkrEdtzbeAjKP17ZEPnGw7f4RYODww3tB2f+Cpj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk8xMktjQ0lmVTFXcWhPbXdwbWVDTUVxb0t3REo0MjdNMjVwT2RubUY0NFdo?=
 =?utf-8?B?bHRoV01ielBvTkdZb0JmcnJnSzBUeVBkcnZVZjhJVmlLbzVubmpKMDJidTdU?=
 =?utf-8?B?bDIzTEJhMk1ZV0EveVlQTkRXeW03ZFhoVTZoWjFzR0NSYWF2ZXVEVXY5aHFJ?=
 =?utf-8?B?ZkIrRVhXbTlrNy9sSDRXWGwwZGFwTUE5NHlEUVZBcms3c3l2NkdENW5CZ0Y4?=
 =?utf-8?B?d0xOYzRRTytJQlpTRDZEMnREaXRaV0hlaGFQZE9JK3BRRFFLaEdrT005aEYz?=
 =?utf-8?B?TEY2dUgreE5UMlBWWVc0QStoZ2c4ZmRoelVPM2JnVXQ2M2hFQWlTVzNTRFpa?=
 =?utf-8?B?MVJaOXBteFlpVzQzL0E0RnZFTm0vV3FQcWNKNVoyMmdTUi9QQjd5T1FQU21m?=
 =?utf-8?B?WUY0WGZFUTlwSnRNdlFqRzd6TWIzTmdWOVJrcDNxYkJlM3RNUm50VGhqYkJQ?=
 =?utf-8?B?VTVRcE52VUJZdUI0M2UydW10YVcxbDlwenBITWI2QVc1M3d1SVNwUS92SHRw?=
 =?utf-8?B?T1hwSEMrdHdyQnprLzZjcmE4L2ZHU2xBaXF1MzU5MTV6WUpmL3lSbFc2NWRn?=
 =?utf-8?B?R1V5RXlNQTUxNFZza0FpdkFUY29abHNOVzcyQnJIWFNMcGVDUXZ2RWxlWnJ0?=
 =?utf-8?B?R3JWZjlEU0trbTIwQ0ZGNUJGdkxhQlNCaVQ5dC9RVEJtN2pRQ1N5TS9Uc0lw?=
 =?utf-8?B?SkVEWG84ZFlndEJWMEZxUDF0OHU3NXBoWmp1ZGU1aDRrd0lxTkJaSjBJaVNu?=
 =?utf-8?B?eDIwcUdwczIrWjkvRWpQbFZIL1JCNXVkN1Yrbk1aQitJeW5haVAzYnpzTjYr?=
 =?utf-8?B?SlUrZ3BxNEt4YVVpRklaeHNwTGN6WDJIODJsNlROcHJSL21PRENTSWlXZU5I?=
 =?utf-8?B?cnltSFlNRlpjSlNScVM5b0h4SXVzUHJwck0zMm9jS1B6WmNGd3praUJpRDRS?=
 =?utf-8?B?MzZwa2xpZ0pQOFF2WFJGc3lReVJ4NG1jT3VwTFI0QUM2WmpGZUkzK29BME4r?=
 =?utf-8?B?NFVBRWZkMjJxa3Ftdlp6K2RDMkxSNW9KblFaQXlPVzFFbFpoa3N4ZU8xblVI?=
 =?utf-8?B?MGlvVjdsMWk5a3pwZ0dibGJwam9jYkxaU3c3M1F4S0kzSmY4WnBNcTZtUGxD?=
 =?utf-8?B?SDJzeVVEdzhpb1VxOXNvNFhBWXZVdkRFUERCK3RyNUUybUpNa0JUc3d5WFd1?=
 =?utf-8?B?d0JXU0tLMEtZWWtwNXJRcTdVNEtYN1pEQnp4SUlkNC9RZUFXOGJ5aDYrS3BP?=
 =?utf-8?B?NG9IVXB1b1d2SVdvb3N4bjVuQnBiVHBhbTZCenhNZWZjNlVmd1o4MXpwR0t1?=
 =?utf-8?B?ZHZYWGNackFOSXZWOXRyWE15aXpaWW50NkpVYjU0eEo1SjhVN2MrUlB6R3p3?=
 =?utf-8?B?L2VCVXdTamNFQjlwZUt5akxiY0VUWDZwOGVZRlpjeGRoTXNmYmRjSkxvcG4y?=
 =?utf-8?B?RjJkR2toQlh3Kzl6YkN2TGlvb2hEYmRYeHlIbm5qV1pYK0wwaU9yQnRhVllm?=
 =?utf-8?B?YzBNUmh4NWVzcVJVNEFkNVNTSy9NMVJBSi8vUDV2c2RibUpMMThza3NYWEdH?=
 =?utf-8?B?WG9NM0k5d09qVm40ODZFdHVJamxBZUlMdUppNnBBekREUEdVaUs0bGFnem1i?=
 =?utf-8?Q?uGitnokdT6GjfGx6zEPtlq8x9BWqzlQDdeIdWADtL3YM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4d7f4d-950c-4bde-b3ff-08dbb3fa436f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR05MB9378.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 01:39:26.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7801
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In our production environment, we find that mounting a 500M /boot
which is umount cleanly needs ~6s. One cause is that ffs() is
used by xlog_write_log_records() to decide the buffer size. It
can cause a lot of small IO easily when xlog_clear_stale_blocks()
needs to wrap around the end of log area and log head block is
not power of two. Things are similar in xlog_find_verify_cycle().

The code is able to handed bigger buffer very well, we can use
roundup_pow_of_two() to replace ffs() directly to avoid small
and sychronous IOs.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Wang Jianchao <wangjc136@midea.com>
---

Changes in V2:
 - Move change log below "---"
 - Add reviewed-by Dave Chinner tag

Changes in V1:
 - Also replace the ffs in xlog_find_verify_cycle()

 fs/xfs/xfs_log_recover.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 82c81d20459d..13b94d2e605b 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -329,7 +329,7 @@ xlog_find_verify_cycle(
 	 * try a smaller size.  We need to be able to read at least
 	 * a log sector, or we're out of luck.
 	 */
-	bufblks = 1 << ffs(nbblks);
+	bufblks = roundup_pow_of_two(nbblks);
 	while (bufblks > log->l_logBBsize)
 		bufblks >>= 1;
 	while (!(buffer = xlog_alloc_buffer(log, bufblks))) {
@@ -1528,7 +1528,7 @@ xlog_write_log_records(
 	 * a smaller size.  We need to be able to write at least a
 	 * log sector, or we're out of luck.
 	 */
-	bufblks = 1 << ffs(blocks);
+	bufblks = roundup_pow_of_two(blocks);
 	while (bufblks > log->l_logBBsize)
 		bufblks >>= 1;
 	while (!(buffer = xlog_alloc_buffer(log, bufblks))) {
-- 
2.34.1

