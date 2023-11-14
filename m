Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4A57EAA96
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 07:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjKNGnJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 01:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKNGnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 01:43:08 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715A1D44;
        Mon, 13 Nov 2023 22:43:03 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AE6goAQ3719874, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AE6goAQ3719874
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 14:42:51 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 14 Nov 2023 14:42:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 14:42:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 14 Nov 2023 14:42:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Su Hui <suhui@nfschina.com>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtl8xxxu: correct the error value of 'timeout'
Thread-Topic: [PATCH] wifi: rtl8xxxu: correct the error value of 'timeout'
Thread-Index: AQHaFfU176HEg0cqUE+cx76xEkVz7LB5XczQ
Date:   Tue, 14 Nov 2023 06:42:50 +0000
Message-ID: <e8b847437ab242d18108d9364360bb8a@realtek.com>
References: <20231113054917.96894-1-suhui@nfschina.com>
In-Reply-To: <20231113054917.96894-1-suhui@nfschina.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Su Hui <suhui@nfschina.com>
> Sent: Monday, November 13, 2023 1:49 PM
> To: Jes.Sorensen@gmail.com; kvalo@kernel.org
> Cc: Su Hui <suhui@nfschina.com>; linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kernel-janitors@vger.kernel.org
> Subject: [PATCH] wifi: rtl8xxxu: correct the error value of 'timeout'
> 
> When 'rtl8xxxu_dma_agg_pages <= page_thresh', 'timeout' should equal to
> 'page_thresh' rather than '4'. Change the code order to fix this problem.
> 
> Fixes: 614e389f36a9 ("rtl8xxxu: gen1: Set aggregation timeout (REG_RXDMA_AGG_PG_TH + 1) as well")

I think this should fix
Fixes: fd83f1227826 ("rtl8xxxu: gen1: Add module parameters to adjust DMA aggregation parameters")

> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c    | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 43ee7592bc6e..9cab8b1dc486 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4757,6 +4757,12 @@ void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
>          *   RxAggPageTimeout = 4 or 6 (absolute time 34ms/(2^6))
>          */
> 
> +       /* REG_RXDMA_AGG_PG_TH + 1 seems to be the timeout register on
> +        * gen2 chips and rtl8188eu. The rtl8723au seems unhappy if we
> +        * don't set it, so better set both.
> +        */
> +       timeout = 4;
> +
>         page_thresh = (priv->fops->rx_agg_buf_size / 512);
>         if (rtl8xxxu_dma_agg_pages >= 0) {
>                 if (rtl8xxxu_dma_agg_pages <= page_thresh)

The logic here is:

	page_thresh = (priv->fops->rx_agg_buf_size / 512);
	if (rtl8xxxu_dma_agg_pages >= 0) {
		if (rtl8xxxu_dma_agg_pages <= page_thresh)
			timeout = page_thresh;

Do you know why 'timeout = page_thresh;'? Intuitively, units of 'timeout' and
'thresh' are different. Maybe, we should correct here instead?


