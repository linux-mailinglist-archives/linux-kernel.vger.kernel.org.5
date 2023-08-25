Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AFA789035
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjHYVLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjHYVKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:10:49 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7408F211C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:10:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a3cae6d94so1226211b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692997846; x=1693602646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3g+XMtH2uVcd/Xff9kVc8hNxYGD4VUSG8tsCVsq7nwQ=;
        b=nRAwuKFCb2SWRK+G2/m/pWH3P7qbIw5blthE0bbcJ3tqSvx9gQvl6yLT7iLwx5AODs
         WFd92SjNhDaLy/wimwxb92IaJthui7vbmAaW9UfrRjuuMVBTHlPPVP3TpSKd1ehm3gWO
         ZAWFsFp9ggcS6RN07E61j2ppTphWnzXVUaFuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692997846; x=1693602646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3g+XMtH2uVcd/Xff9kVc8hNxYGD4VUSG8tsCVsq7nwQ=;
        b=DqwEs4ftl2Pz3ZSiSPY0/5eYZVNl7iaxzCxAVdt4A7D9bOL1ZDpHzrvpJxdMwL6pQd
         nd3dWeJc3OdixWYL5haN4plqSt+6IYXxV8BWoHEo9rKwBSc0OUrn5TPmoYQX1b0GjkTV
         3uw5xyfijFEmPdKzKUP2Ubhibq/MkpiS6f5PvZUt0Eg8RSLa2tJMTiDyhd8WmBAihSEs
         YAHFp9M2gdhDQ6uJ4iTIQxkwCrypwNUZeaNUK/ump58xPzvKv5U6ninXV83IydXZ5QH8
         xox/rZcU7aC7XGOKzIONuAS22dOFeJX9VXPYQmwOTU5HpPb70Vxbu2Uy5IS0VH7O5KMA
         K2Gw==
X-Gm-Message-State: AOJu0YzsgP1tvmXQyc7T9UmevlW8uezj4sS3fGKlQSYurzPqXkj7xVJo
        EkWAECH8bjI2nAnZ8K8CxyGpGA==
X-Google-Smtp-Source: AGHT+IHf9yEm1va+mcGEzYOWBCYUQs/vbpcCPXpBgpqcJ5V4v2iQU4jD8aPm42XEbXwQfdprL59J/g==
X-Received: by 2002:aa7:8887:0:b0:68a:51dc:50c0 with SMTP id z7-20020aa78887000000b0068a51dc50c0mr18354512pfe.32.1692997845932;
        Fri, 25 Aug 2023 14:10:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c3-20020aa781c3000000b0068892c40253sm1973202pfn.216.2023.08.25.14.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:10:45 -0700 (PDT)
Date:   Fri, 25 Aug 2023 14:10:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/3] wifi: mwifiex: Sanity check tlv_len and
 tlv_bitmap_len
Message-ID: <202308251410.8DAA6AC5E@keescook>
References: <cover.1692931954.git.gustavoars@kernel.org>
 <d4f8780527d551552ee96f17a0229e02e1c200d1.1692931954.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4f8780527d551552ee96f17a0229e02e1c200d1.1692931954.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 09:10:45PM -0600, Gustavo A. R. Silva wrote:
> Add sanity checks for both `tlv_len` and `tlv_bitmap_len` before
> decoding data from `event_buf`.
> 
> This prevents any malicious or buggy firmware from overflowing
> `event_buf` through large values for `tlv_len` and `tlv_bitmap_len`.
> 
> Suggested-by: Dan Williams <dcbw@redhat.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Fix format specifier: %ld -> %zu
>    | Reported-by: kernel test robot <lkp@intel.com>
>    | Closes: https://lore.kernel.org/oe-kbuild-all/202308240844.leyoOwdG-lkp@intel.com/
> 
>  - Update warning messages to explicitly mention that TLV size is
>    greater than tlv_buf_len.
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/587423b0737108effe82aefed4407daca39e9a51.1692829410.git.gustavoars@kernel.org/
> 
>  .../net/wireless/marvell/mwifiex/11n_rxreorder.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> index 735aac52bdc4..10690e82358b 100644
> --- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> +++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> @@ -921,6 +921,14 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
>  	while (tlv_buf_left > sizeof(*tlv_rxba)) {
>  		tlv_type = le16_to_cpu(tlv_rxba->header.type);
>  		tlv_len  = le16_to_cpu(tlv_rxba->header.len);
> +		if (size_add(sizeof(tlv_rxba->header), tlv_len) > tlv_buf_left) {
> +			mwifiex_dbg(priv->adapter, WARN,
> +				    "TLV size (%zu) overflows event_buf buf_left=%d\n",
> +				    size_add(sizeof(tlv_rxba->header), tlv_len),
> +				    tlv_buf_left);

With the suggested change to make this a warning and not dbg:

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

> +			return;
> +		}
> +
>  		if (tlv_type != TLV_TYPE_RXBA_SYNC) {
>  			mwifiex_dbg(priv->adapter, ERROR,
>  				    "Wrong TLV id=0x%x\n", tlv_type);
> @@ -929,6 +937,14 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
>  
>  		tlv_seq_num = le16_to_cpu(tlv_rxba->seq_num);
>  		tlv_bitmap_len = le16_to_cpu(tlv_rxba->bitmap_len);
> +		if (size_add(sizeof(*tlv_rxba), tlv_bitmap_len) > tlv_buf_left) {
> +			mwifiex_dbg(priv->adapter, WARN,
> +				    "TLV size (%zu) overflows event_buf buf_left=%d\n",
> +				    size_add(sizeof(*tlv_rxba), tlv_bitmap_len),
> +				    tlv_buf_left);
> +			return;
> +		}
> +
>  		mwifiex_dbg(priv->adapter, INFO,
>  			    "%pM tid=%d seq_num=%d bitmap_len=%d\n",
>  			    tlv_rxba->mac, tlv_rxba->tid, tlv_seq_num,
> -- 
> 2.34.1
> 

-- 
Kees Cook
