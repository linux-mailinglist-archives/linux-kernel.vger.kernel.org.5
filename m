Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D07A80F5DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376735AbjLLS4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376678AbjLLS4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:56:54 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4549F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:57:00 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c32e205fcso9256385e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702407419; x=1703012219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jZqFXSKKPd9Ks/RHdE7adax2t7T1aOez3KnX+eA7uc=;
        b=B3yBbIXeGPLj1NKU94FLTKHEsg2zzJuJhHXaarl87i6ntTubP5MppBG9YhKUwN0qGi
         hFqcBQTae+bKmnmGQDT3nFkAXYCDLYI/ANVDrAWv4QHJE5gGSGkk3XVFZW1zgbVXigoE
         gIAu6SCX0BgYY4narCRxHRAZdeLv7IGtlmRmRF5AvTZJCSj0y67EmlPQKuFAS00m6ua3
         nJhnTGV6Pp/6ZM0leiOFEYlDI2J+0FA5f/L8DMVc0jIEtr4kkhIEwEaHfc9u8wM3b/1N
         t4vix48besm5RQfFRQNT7NNO7CwatRFIyNXVL0Hy7e0SoTNquDZPdltlqDl8RnYsfWru
         hxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702407419; x=1703012219;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jZqFXSKKPd9Ks/RHdE7adax2t7T1aOez3KnX+eA7uc=;
        b=g9axXdTdKja7/ozv5wkjZ/AMyjNbHkz/6XtqAfihEDHe+D4kSm3YbnX3xFwJGshShN
         G6hAYF6xXVN0mn5MFQf2bEgA43bw4EOu9qha6XYwtv5DBKDQvcJXE7TZ82KRRVIJVYkB
         D36Vux2KX9Wfbb1XVEgiaoHl36vdW9YFz9yYadE5pC1PRwAUtZ1vp+qaiREpuzvWUgPn
         zdV94YHj5M+op81xOT+SXkPzBWvLHh6fCqk2DP65TxyHio9rxhmzup01KKy8B6uqFve2
         MzSsFL87PGQAqx3+QIVgdoI16i8ewdBTGrWkovhiOXI7bkbny1CC/HAT8WgtkLRBvEob
         hBcQ==
X-Gm-Message-State: AOJu0YyAsrkvYa64aIMGB6VaJPPY0FcH+X8DOAsUEXkNyo4zFTnH3pa5
        pZmSYhWFE+hpJCA0Y22E/U720nMpMtQ=
X-Google-Smtp-Source: AGHT+IHwaHKV1sGHAHOEQAnyDRP51wcL4tlpVXOeUO/hCDwA2xZwlsFWuh2yYF5C4lMyoBC1fkBG4g==
X-Received: by 2002:a05:600c:1c86:b0:3fe:d637:7b25 with SMTP id k6-20020a05600c1c8600b003fed6377b25mr8363131wms.0.1702407418795;
        Tue, 12 Dec 2023 10:56:58 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c35d400b0040b538047b4sm19863451wmq.3.2023.12.12.10.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 10:56:58 -0800 (PST)
Message-ID: <6a065daf-3639-4a87-8ab6-7018e0362900@gmail.com>
Date:   Tue, 12 Dec 2023 19:56:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] staging: rtl8192e: rename variable pHT
Content-Language: en-US
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231212165637.17618-1-garyrookard@fastmail.org>
 <20231212165637.17618-5-garyrookard@fastmail.org>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231212165637.17618-5-garyrookard@fastmail.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 17:56, Gary Rookard wrote:
> oding style issue, Avoid CamelCase
> rename it. pHT -> ht
> 
> Signed-off-by: Gary Rookard<garyrookard@fastmail.org>
> ---
>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index ac85151a6069..add8f58b5b1e 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -250,17 +250,17 @@ void ht_reset_iot_setting(struct rt_hi_throughput *ht_info)
>   void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
>   				  u8 *len, u8 is_encrypt, bool assoc)
>   {
> -	struct rt_hi_throughput *pHT = ieee->ht_info;
> +	struct rt_hi_throughput *ht = ieee->ht_info;
>   	struct ht_capab_ele *pCapELE = NULL;
>   
> -	if (!pos_ht_cap || !pHT) {
> +	if (!pos_ht_cap || !ht) {
>   		netdev_warn(ieee->dev,
>   			    "%s(): posHTCap and ht_info are null\n", __func__);
>   		return;
>   	}
>   	memset(pos_ht_cap, 0, *len);
>   
> -	if ((assoc) && (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC)) {
> +	if ((assoc) && (ht->ePeerHTSpecVer == HT_SPEC_VER_EWC)) {
>   		static const u8	EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
>   
>   		memcpy(pos_ht_cap, EWC11NHTCap, sizeof(EWC11NHTCap));
> @@ -275,9 +275,9 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
>   	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
>   		pCapELE->ChlWidth = 0;
>   	else
> -		pCapELE->ChlWidth = (pHT->reg_bw_40mhz ? 1 : 0);
> +		pCapELE->ChlWidth = (ht->reg_bw_40mhz ? 1 : 0);

The last line changed with my patch:
[PATCH 02/10] staging: rtl8192e: Remove variable ht_info->reg_bw_40mhz

It is always difficult to know which patches are accepted by the 
maintainer but you may want to look into the following mailing list to 
see if there have been any patches send in for this driver.
https://lore.kernel.org/linux-staging/

You could apply the send in patches and build your ones on top. Then you 
do not have this issue. But when the patches you are using are not 
accepted you will run into the same issues.

Thanks for your support.

Bye Philipp



