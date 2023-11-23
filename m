Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CDB7F6890
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 21:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjKWU4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 15:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjKWU4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 15:56:02 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD8DD4A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 12:56:08 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50aae766214so308301e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 12:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700772966; x=1701377766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jH0gybkUMh1ws0/iTKIPo/qAYIylPc5Y9Jda3lmDcHY=;
        b=XnlC8jYeOhJUgC84IQFFyBg1wo0EfJpcsbT2x9i9Q5+QdjV/cjyQx3GYvdYhEil7Eo
         o1kgW/dtSuVhGAbpyeR1/qIip1nyJ2b34YTcXdRvVudhboeuGWUl5ZqGCro3g3CbwVP4
         mJ7PvwCUnsURFKhzMxgrmKeZHwxu63SbqZUhNEKiZ2HGC+3m8t3/BwLDt/i6OS8p3pZK
         21UPi/b4XThiasejrltUAaBRNtHiVggNJt2DeERFiD/i77nFCuYYTW2Pv5byEj3jZzNZ
         la3xTKG610d3BsOOvUq/tQAHTmLUh/zWXJuiGLi9kyV8YX/qysSUL5yFJSqPeN/e4m7O
         sVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700772966; x=1701377766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jH0gybkUMh1ws0/iTKIPo/qAYIylPc5Y9Jda3lmDcHY=;
        b=F5Ot4YukQul5EGF8cro1a4KbRoU66mVorXF8O9tFNkKE+wKs8VY9QGewvGSiB0nwCX
         BRo5YTm4scr4rHm75kNwjqhqqtVKYGTStCMC+hA5RYwpHfv0GDP6ZKDrtZphIA+nVSEc
         XTN5iWji18cUifPAkdJRBOQ5YkDlyWVkx92UAC4QxLmSPFBIb2JD/FhbcLRPnnzczsCC
         vmz/VLa6p0ZmS7ynRpy/tEXtxrgPmv2idDYqBPd2AEEruwtDqMpiLlVyxY4vQNMSwZB1
         m1RqAYwE0llNCMl5dXe3pHvkgT+AD6wPfvOEb3MvCcrIifHEakFaDUgZjscAf5Miebo9
         kGlg==
X-Gm-Message-State: AOJu0Yy08nBAeg59aA6JNlDlmgSEBMV3xssJB/sSaEpIG9Jo0Gs7I7Pj
        PRVehl61tnMwOcRR5NWQW3A=
X-Google-Smtp-Source: AGHT+IGiDJDLfNf/e/HQ3cEiHa48KWl1Fl5KWMyvPvB4N3tL0Tr51v3z1jAjw2RtMMd7LBa8Lqnlxw==
X-Received: by 2002:ac2:5498:0:b0:505:7123:21ae with SMTP id t24-20020ac25498000000b00505712321aemr177948lfk.6.1700772965949;
        Thu, 23 Nov 2023 12:56:05 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id me22-20020a170906aed600b009dd8473559dsm1189780ejb.110.2023.11.23.12.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 12:56:05 -0800 (PST)
Message-ID: <5ff4d268-2fcb-4d55-819a-e2650731b91f@gmail.com>
Date:   Thu, 23 Nov 2023 21:56:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] staging: rtl8192e: renamed variable
 TXCountToDataRate
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231123144337.13112-1-garyrookard@fastmail.org>
 <20231123144337.13112-3-garyrookard@fastmail.org>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231123144337.13112-3-garyrookard@fastmail.org>
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

On 11/23/23 15:43, Gary Rookard wrote:
> Renamed from Pascal/CamelCase to Snake case the variable
> TXCountToDataRate.
> TXCountToDataRate -> tx_count_to_data_rate
> 
> Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
> Driver/module rtl8192e compiles.
> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> ---
> v3: Corrected versioning from v1 -> v3, includes change history.
> v2: v2 was skipped over..v3 corrects this.
> v1 Style and compile issues, asked to redo.
> 
>   drivers/staging/rtl8192e/rtl819x_HTProc.c    | 2 +-
>   drivers/staging/rtl8192e/rtllib.h            | 2 +-
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index 280e335cbb6d..fb8294f31a60 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -114,7 +114,7 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 nMcsRate)
>   	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
>   }
>   
> -u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate)
> +u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
>   {
>   	u16	CCKOFDMRate[12] = {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18,
>   				   0x24, 0x30, 0x48, 0x60, 0x6c};
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index d2cf3cfaaaba..0226a69f40c3 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -1783,7 +1783,7 @@ extern u16 MCS_DATA_RATE[2][2][77];
>   u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
>   void HTResetIOTSetting(struct rt_hi_throughput *ht_info);
>   bool IsHTHalfNmodeAPs(struct rtllib_device *ieee);
> -u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate);
> +u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
>   int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
>   int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
>   int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> index f32584291704..28aba1d610f7 100644
> --- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> @@ -208,7 +208,7 @@ int rtllib_wx_get_rate(struct rtllib_device *ieee,
>   {
>   	u32 tmp_rate;
>   
> -	tmp_rate = TxCountToDataRate(ieee,
> +	tmp_rate = tx_count_to_data_rate(ieee,
>   				     ieee->softmac_stats.CurrentShowTxate);
>   	wrqu->bitrate.value = tmp_rate * 500000;
>   

CHECK: Alignment should match open parenthesis
#61: FILE: drivers/staging/rtl8192e/rtllib_softmac_wx.c:212:
+	tmp_rate = tx_count_to_data_rate(ieee,
  				     ieee->softmac_stats.CurrentShowTxate);
