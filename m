Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E223801EAA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 22:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjLBV1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 16:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBV1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 16:27:51 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27474F0
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 13:27:56 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-28654179ec0so2004363a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 13:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552475; x=1702157275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHEDt6VQ8LzeSpO7og1P0K/YDfArH7UZrlszyK0VJhs=;
        b=A0njk1uEzGdzfnskQb3vd7n5zV+OMsAAU/SYawClffVNIyX9gTme3Siqve1BeDAWGD
         XQRZBRiF4zHaGlySDgqNsCAuV1BeKhiVqzMZvmn7xOYJuLS+EY+ctFOcrRZV7CDaen1H
         CXcBtPkiyA7tK1iVhlFDSvOe1rxyuTxnxWcRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552475; x=1702157275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHEDt6VQ8LzeSpO7og1P0K/YDfArH7UZrlszyK0VJhs=;
        b=WnAFAF1x0FJ7jcBdUAQJvv4F2NQU3gMWG7iJP71Do8Nc3QKxOqH5PZD2uFtxTuztM1
         fNWDSTF6TofcW4oGKjTOv1MA5e3DFaUSzsoq1YfRsumRwcLO8zLcHhYRterGmrmQZoaQ
         /HNUFaj9/skWvcZed3yTDKYbIl9h1UDBPpW5Bb8gERESka0uDhhbvSxNLVkGcFn5qg3h
         wkTL1gIBElWJyf37RjlWSO9Nkh6n9E5lPgZzm5YKfufFh+D0nOOmHWySVJ371Os5GNjV
         AjfClKAxyOFk5lE69Ohatnp8Ll8Txfvkf05pTMAtnlGT+JkeX1WAVO6oK1mhzQJsxUDJ
         ofEw==
X-Gm-Message-State: AOJu0YybpinBHt4WiEmdXTKAb8mcMCBKZIgaUEIU/pY0ZKgzPOwhVVqS
        snvn9aFUUzHDif3Pkf5RNbyBpOQM+TwaFCrjYE8=
X-Google-Smtp-Source: AGHT+IFXUE4tSK9GGzbHw7vo/cKKLHlnC44NDlmDCgLl/yvcuTLoq9/NPk2WjmKD8tGBeTcLq2UwmA==
X-Received: by 2002:a17:902:bd05:b0:1d0:6ffd:e2e3 with SMTP id p5-20020a170902bd0500b001d06ffde2e3mr1629422pls.125.1701552475636;
        Sat, 02 Dec 2023 13:27:55 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b001cffe1e7374sm5608964pla.214.2023.12.02.13.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:27:54 -0800 (PST)
Date:   Sat, 2 Dec 2023 13:27:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: mt76: mt7996: Use DECLARE_FLEX_ARRAY() and
 fix -Warray-bounds warnings
Message-ID: <202312021326.D3504C1@keescook>
References: <ZVaCNAohuieMmdq9@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVaCNAohuieMmdq9@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 02:57:24PM -0600, Gustavo A. R. Silva wrote:
> Transform zero-length arrays `adm_stat` and `msdu_cnt` into proper
> flexible-array members in anonymous union in `struct
> mt7996_mcu_all_sta_info_event` via the DECLARE_FLEX_ARRAY()
> helper; and fix multiple -Warray-bounds warnings:
> 
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:483:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:490:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:492:58: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:469:61: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:477:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:479:66: warning: array subscript <unknown> is outside array bounds of 'struct <anonymous>[0]' [-Warray-bounds=]
> 
> This results in no differences in binary output, helps with the ongoing
> efforts to globally enable -Warray-bounds.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

*thread ping*

Can wireless folks please pick this patch up?

-Kees

> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/mcu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
> index a88f6af323da..9f516f796d63 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
> @@ -163,19 +163,19 @@ struct mt7996_mcu_all_sta_info_event {
>  	u8 rsv3[2];
>  
>  	union {
> -		struct {
> +		DECLARE_FLEX_ARRAY(struct {
>  			__le16 wlan_idx;
>  			u8 rsv[2];
>  			__le32 tx_bytes[IEEE80211_NUM_ACS];
>  			__le32 rx_bytes[IEEE80211_NUM_ACS];
> -		} adm_stat[0];
> +		}, adm_stat);
>  
> -		struct {
> +		DECLARE_FLEX_ARRAY(struct {
>  			__le16 wlan_idx;
>  			u8 rsv[2];
>  			__le32 tx_msdu_cnt;
>  			__le32 rx_msdu_cnt;
> -		} msdu_cnt[0];
> +		}, msdu_cnt);
>  	};
>  } __packed;
>  
> -- 
> 2.34.1
> 

-- 
Kees Cook
