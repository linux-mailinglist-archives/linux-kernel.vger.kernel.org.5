Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09857BC038
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjJFUVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjJFUVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:21:16 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C42CBE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:21:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c0ecb9a075so19572645ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623674; x=1697228474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1oQgMYYOHJAqGUemakHE7gLhffpSOgun7mdtdcyLAY=;
        b=jc7xccloVcyKtIUqHNW9tr5OKqtIb4XH0tjVog2mXqEoPZRvY3LirwxoSSLxGsEnep
         rWNFdAcP4NT2EEDCsqD+M+FGmJxc/zj98fujKfyl5tlsvYcAg2y06hDYi94/PsxHtzpU
         XJyDn4Oj5qJoNZ7Dvrm0xbyynKpkzoAx8yy6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623674; x=1697228474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1oQgMYYOHJAqGUemakHE7gLhffpSOgun7mdtdcyLAY=;
        b=JfQcSctEseEV7h+1SlzwAxjkrwl5LpgkLleryIxWS+Nx5t0NdKts8fXwkMXIYZQ4sT
         loCP58SHmixxtLEDk5PhrUuWsAu16NZeb7oJII4+ngFsQCSYDhtdEZmo7uASbdnqQSyj
         /tppBzS1Sp+nIXzbgPnKZeCwUNqt6bwcZHH7CRj/8vct/d/tE5hYpGLlDwcTd2eCNR57
         1ya6h2ri4nQzcC+Y13L8cL9gPXPme7LiVQnqBjMzUj6471SJxvWcR0qD/5fSuba0PncC
         pYmnHQ4ZpJ5DSJVycU7Bd02DGE3N8XD+aBGO/3psTuFzCdMz+qu9DcrQdkPT5etIDsX6
         40aQ==
X-Gm-Message-State: AOJu0YyjysH1gTU/IJ8B7jBMsOVK2Ro69Hq1VJsrDhgMWy5jj2Fw0UFh
        Ucm1hbMoN/qCqdnlqxspqny2MA==
X-Google-Smtp-Source: AGHT+IGu32OJlQsQg2gdMOhdV/v2W3V3QUsAfaY6LRJfqpsCLXyocjInS1I983619DISa2FBj4aXpA==
X-Received: by 2002:a17:902:e810:b0:1c5:59ea:84de with SMTP id u16-20020a170902e81000b001c559ea84demr11148430plg.29.1696623674642;
        Fri, 06 Oct 2023 13:21:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ji2-20020a170903324200b001c75f94b0b0sm4333924plb.213.2023.10.06.13.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:21:14 -0700 (PDT)
Date:   Fri, 6 Oct 2023 13:21:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: Annotate struct mt76_rx_tid with __counted_by
Message-ID: <202310061320.8630F7E51@keescook>
References: <20230915200612.never.786-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915200612.never.786-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 01:06:12PM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mt76_rx_tid.

Friendly ping. Can this get picked up by the wifi tree, or should it go
via something else?

Thanks!

-Kees

> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Felix Fietkau <nbd@nbd.name>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Shayne Chen <shayne.chen@mediatek.com>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
> index e8757865a3d0..03ef617b1527 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -376,7 +376,7 @@ struct mt76_rx_tid {
>  
>  	u8 started:1, stopped:1, timer_pending:1;
>  
> -	struct sk_buff *reorder_buf[];
> +	struct sk_buff *reorder_buf[] __counted_by(size);
>  };
>  
>  #define MT_TX_CB_DMA_DONE		BIT(0)
> -- 
> 2.34.1
> 

-- 
Kees Cook
