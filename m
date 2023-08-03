Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F6B76E452
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjHCJ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjHCJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:28:43 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2131.outbound.protection.outlook.com [40.107.14.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BB3EE;
        Thu,  3 Aug 2023 02:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtKlaS/RUkPazOZRYGeVKePJhzCFIpFPzkS6eKDfR+wWJs3EiYkND8Mg98NcgqekvF8YU+SSwG0QPxn/tOzA4JNx70tH+UHb7+So+jvME5VvxwUlVhMBVicd+ecquAt4lajsatFYT3tkBSvqoOt69k9JFgb2uvAzeygrELBJtxu556h0WwzUATG3giLF4JpRVDpfkVJf9CSIyzM/HW7tqVdh1o5SQBZ7Gu0E0pVM9G/Z+u4we7FOaOfPgVYVP7Fn2J6DBmPIhLBuwM2eYLT9p1xfvr1O4aPhCD75hITt/oxNIT/ycAt0+faVeUW6ksCsZpTeTlJjCfUkeC8GENfv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsr0sTh6o0FoCe2pt9TXVGD3SFFmrgHMffjcHRqRoog=;
 b=d4kstlWH2sCxz6OKrrbxgr3YAGX7YZAS8FdJ52SN1EmcHyiToIfi51kQGiqhy4vp1OA1fP551M77BqEYoCbhIUsNs8gprixEdOIIDGGFNAulKrLY0162iw07pTAHHvljIuKvv6a/cBKxcAJifx+xoy1EOV48Iof6P+qy0MCShLZ8S5k/tE70h1HFcGntSjXrCq7811mWCCott1hRLPBDbvNjCcH70dwsfNJq1EGTnHLXK84cPLVvqs387Wk/wjLfhh9eazmlS3C4VC5ci6ShEHY4ZscbkK32670IDYpdtUELtYQhkdDMvB0nJCcjUt/7egrJNRLuLi3W7fBS/GCoRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsr0sTh6o0FoCe2pt9TXVGD3SFFmrgHMffjcHRqRoog=;
 b=pTjcy8jFzpiy/nmtv3Ck9EjC9pLNARDd9f+S1qsNuiJXk0VehJWvMJoEfNOiiRBMpLUzw110XIEUUjEP2LwuhomEUo51iJVuuVJUdkkQ9ktAsQgIz6ktdiB3I9i2NZqVjke3uh3reHy7bCmmTozshiDJJ8NIi9U1FaEwi48rFQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from AS4P190MB1998.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:519::13)
 by DB9P190MB1466.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 09:28:39 +0000
Received: from AS4P190MB1998.EURP190.PROD.OUTLOOK.COM
 ([fe80::27ed:5229:81b7:ef7c]) by AS4P190MB1998.EURP190.PROD.OUTLOOK.COM
 ([fe80::27ed:5229:81b7:ef7c%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 09:28:39 +0000
Message-ID: <fb332a94-9983-70b1-4a02-da3c31c68e29@plvision.eu>
Date:   Thu, 3 Aug 2023 12:28:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] prestera: fix fallback to previous version on same major
 version
To:     Jonas Gorski <jonas.gorski@bisdn.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Vadym Kochan <vkochan@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230802092357.163944-1-jonas.gorski@bisdn.de>
Content-Language: en-US
From:   Taras Chornyi <taras.chornyi@plvision.eu>
In-Reply-To: <20230802092357.163944-1-jonas.gorski@bisdn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::17) To AS4P190MB1998.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:519::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P190MB1998:EE_|DB9P190MB1466:EE_
X-MS-Office365-Filtering-Correlation-Id: 88138595-ba89-411b-afad-08db940404c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fu1ts7E5ZBvgJVyjLrTLZCqO3Mf8/b1D3Ht5xosNpCe+fphwgHCBq4l1xYnozBRfvF5s+7vKpiHnb5GL/fhBDZEL2HPoGS+ceDXYsHdKlNnGOpSjVVlWHP4m53fAiTh4JKo0aal22q1Ey+WI4epEvBox6/C+pgW0UT0T4J6kYhBc5PJnbpokaQvR+cj2teNtmB+peo8yg6QZovJOYrvTtjb/E21sRJ3Ck1tyL2eL0vswLoJnIcJquZR5AgYhV/Ivd4ZjUdwMHAEs971lcl1hzr7uniyyp4YC1Fl8i7KV+sn66EtZUEXr4SVvRek/fgRUbVb7CiOVhHBL4U1xipYJX61Rd8pr3g19679KEA4sSKTNJH4Yvbw6kvcWBZMJhuLHx846jUi8xI0y0j4SSwbz8B/DMRR+LW5prmPTt0Tu/Vv+PEPopQz7FyMv79qxMKyv/ZyoeBMHTtAiMmk44aHeGPEIUvfNbGnRYkcS42FcQV74dB0fNUS3KlPSgYkcgT0Cz+t0E39aUxf8KONuQ5f5XSZXVuSe5B/s4hmYbWWcsOILrcSGL/1MTCIT+K+0sZdztaJShznk9e7XYmMOnrZqaC61ztgBcTVhvLD7O/pIfglIb3X75Ow4pBcCH3M16lZg59he5koejM2K2ojq6Bb09w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4P190MB1998.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39830400003)(366004)(376002)(451199021)(2616005)(6506007)(83380400001)(26005)(186003)(316002)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6486002)(6666004)(6512007)(110136005)(478600001)(38100700002)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnYwWDhLdEM1akNVR1VYYm0ra2Y0VHJLa0xJWUxINldTdmZ5V2JveEs1TUZY?=
 =?utf-8?B?NWhQRnpHVkk4czRzdWtST2pTYWJRMnJJZkxIMGxBL3hvNUhNLzZVMkNuUWZv?=
 =?utf-8?B?SDdFV3RIS1hIWW1taU5XaEtSOGVVYTNQQlo4NEtxU3JXaHVxUjhXVUtNTjNT?=
 =?utf-8?B?VzdWOGZ3TjQ3cEJBY1FEc0R5YTdXVEwvaTJkUktTSzV5eVIzNTRBVHVEZWYv?=
 =?utf-8?B?TE1hNElOK01IQ25ZK25TRkgzTlprQ0d1ZG9kTHhwNFQxNnBweVVuUHlJNUhG?=
 =?utf-8?B?UlpVdWlIcjB5cGVrKzJIak41T2YwZnVwSzhuc0FScW9hRzJWSFVVeURxbFRq?=
 =?utf-8?B?WS9mVkRnZG9XallJM1FyL2x0UWx1d2hYZUpxM0tTbHU4MDhnQTB0dUY3Z1l3?=
 =?utf-8?B?UVptS3dsQ2JVYUx6MUU5aXZKTTd4UCtKemZjdUhQNVlLMmhzWDV0MldibVJD?=
 =?utf-8?B?R3hGelU0L0dCbnVYOUdJTlFGZWtJSmRJYmNQRUE4TjNySjJJWGdVam1acWVo?=
 =?utf-8?B?cGpGak0ySFlsTmVjeEtSbVl2Znd4UUpPSGEwVkoxUXFjTWplcE14UGtxMFB6?=
 =?utf-8?B?ZDNwQ1pYSG51SUdzS2IwWldFTk9FcDVnY05IMjFpS2VkZXF1TGJPSUtGS1BM?=
 =?utf-8?B?Si82RTV0Nk1CZkpMTWl2K2JKZmxxeUZ5S1l5MS9HK3hxWFloUkt2S3VSOWw5?=
 =?utf-8?B?ZzVLMEYvRWhhRy8zMlljcXNGMWg5aXpyTUdGTGJtdk9KcVp4Um1zWCtpSUV6?=
 =?utf-8?B?YVRPZXRzRDl0Y0paTlVWbVdUUFkxeE5JSnk0Wm81VGVhSjJIUllKQ3pZRWs5?=
 =?utf-8?B?bHk1M1JBcXVuQ3U2OGlLTkk3QkxBbDlHK0NON3RIZ1RuVG1YUUh5UW0ycGp2?=
 =?utf-8?B?YnN0K1Q0S3RlaVZhY29ZZ3k4dFFmcnFEZmQ2RzVjdkpaVCtpekVxYXlhcWNR?=
 =?utf-8?B?ZjE1MjVxNW52TG5xUkxvNVlvTUZ4U094ZCtKT0ZNK1IzNWlJeFFZSDlwVlIw?=
 =?utf-8?B?RGFiRUprZVo5VTMvZnc3V1ErWEd5RlMycVNwVmRYcUxUSEowdDJvaXhIcUts?=
 =?utf-8?B?Y1lyY3RRSndTOWJaMGhHRzlleW9RRERvYThMSHVYU1BqdEJmb1A2RFgrUHNv?=
 =?utf-8?B?VWhhcVNLaU8zdVprMTVVZnI5TzBkVHRLci8rc2ZhS1FuTWRpQzlRbUZLa1Na?=
 =?utf-8?B?OVA4SDlnTGgvWFBabWNJVnpsb2R5Q3BtZTJKOHIwZElJT0pEY2xqMm8yQ2U4?=
 =?utf-8?B?cDZoaWFMZVNwUEZueGhqRFJpaXFmUng1dkhXTFRoNnUrUXdTS0Q2N0w3TENY?=
 =?utf-8?B?RXB4REl0UXNuT0lVRCtnWHBHUUdrK2QvUCtKcENVMEF6WHN3aWcvR2Y0Ky9D?=
 =?utf-8?B?cHFvVndiYVljR0pZMVlZL25ZTFRPb05wT21hYU1XSFRiOURPeWwvVlBwRlJC?=
 =?utf-8?B?aHBnSzFkcEFDd2JrSWZ1MSt3aTY5aGREb0QvN3E5ejVnbCthem5CVjFnV2I4?=
 =?utf-8?B?b0YxU2hkUGgxa25mSzRQK3l3ajd6SXE3ZFFKT3BYYnR5Y1FFK21xZDg4cTYy?=
 =?utf-8?B?LzM5T0hRUFhDakRqUDNDSFBIUWdPZWVyaWM3cytMR0EzaHF5aUlNLzQ3ckdR?=
 =?utf-8?B?dm16ajRWeGFCNnljWGJmZmM1YzFibXVnRG9ybVp2bmRORlBwQ1FsdGF2RFVy?=
 =?utf-8?B?U3hacU1PWnl0NzBJNE1RQWlZRWdHRHVWYlU2RGZmdjBFWTdJNGlHbExJSFJJ?=
 =?utf-8?B?M1VSdVdLazVyb3R6S0M3U2lFbzZxRXlDOTJBNDdDcHJwSkpmbGQwMVdUN1R3?=
 =?utf-8?B?WmlCSGwrWmFqbWZTdkY1QmJwMkpEZDVTQityenRFcEY4TjJzeDlKU3V2MHRk?=
 =?utf-8?B?K2VKLzk2V0ZiQ1Mya3JEM1ZDU1ZqY1lmTC95Qm1IOXRzVS9RZHRBWjJwNmx4?=
 =?utf-8?B?K3VTTENIY1haN0dJTU5GN2VEdmRCQzF4U3ltRG4zRE1xVm1WMjF3RVZabG5U?=
 =?utf-8?B?N3ZUbHFtZy9jcEo1U3l3V08wZXFaTnlHdHBkbVRWeDJpclZZV2prY1VnQmpl?=
 =?utf-8?B?SnlYZWlzMHlSSTZwRmFneWN3MHpsUnlERjY0OXBicDBCSnJ4SzRBT1ZwVEdx?=
 =?utf-8?B?bmxaSml2RisvYmp6dDRBbW55OWNXYzNrU0NCaVkxWUUzRFdsam85dmZoaXZl?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 88138595-ba89-411b-afad-08db940404c9
X-MS-Exchange-CrossTenant-AuthSource: AS4P190MB1998.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 09:28:39.1483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kmz8vK36EQllY0nbgc8ogmG40KpVWKSFzBa13cEIowJ8CgRlALcDFF9BH1WMEUKY8cenqKY7GAftXSRz6VB9QlzmRx6f9PTllrzAIpjCkmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1466
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Fix this by inverting the check to that we aren't yet at the previous
> version, and also check the minor version.
>
> This also catches the case where both versions are the same, as it was
> after commit bb5dbf2cc64d ("net: marvell: prestera: add firmware v4.0
> support").
>
> With this fix applied:
>
>      [   88.499622] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.1.img firmware, fall-back to previous 4.0 version
>      [   88.511995] Prestera DX 0000:01:00.0: failed to request previous firmware: mrvl/prestera/mvsw_prestera_fw-v4.0.img
>      [   88.522403] Prestera DX: probe of 0000:01:00.0 failed with error -2
>
> Fixes: 47f26018a414 ("net: marvell: prestera: try to load previous fw version")
> Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
> ---
>   drivers/net/ethernet/marvell/prestera/prestera_pci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_pci.c b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
> index f328d957b2db..35857dc19542 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
> @@ -727,7 +727,8 @@ static int prestera_fw_get(struct prestera_fw *fw)
>   
>   	err = request_firmware_direct(&fw->bin, fw_path, fw->dev.dev);
>   	if (err) {
> -		if (ver_maj == PRESTERA_SUPP_FW_MAJ_VER) {
> +		if (ver_maj != PRESTERA_PREV_FW_MAJ_VER ||
> +		    ver_min != PRESTERA_PREV_FW_MIN_VER) {
>   			ver_maj = PRESTERA_PREV_FW_MAJ_VER;
>   			ver_min = PRESTERA_PREV_FW_MIN_VER;
>   

Acked-by: Taras Chornyi <taras.chornyi@plvision.eu>

