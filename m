Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCA0811F06
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442484AbjLMThH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjLMThF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:37:05 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430F29C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:37:12 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce26a03d9eso4807576b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702496232; x=1703101032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKFrk1J/zY5B8/hw5jHalDc7wotPr7TIY0wnvEd3yKU=;
        b=ZnmOgFxKwJ8Re0/W1X7QINsnOx3n6keubr66ij1nLZJ7ENeDku6jXTSRQF94mAlwqY
         KOGmS9DsIVribSCUQHsKzKI4m5RlDiPvh0vRXJ0dmR/dPzwWkajXlSWrnppaEdj2fOGy
         uT7o7ErF5rlM/wIYddneiSAxReOdA9ZbvSNys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496232; x=1703101032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKFrk1J/zY5B8/hw5jHalDc7wotPr7TIY0wnvEd3yKU=;
        b=ftf+K9Sv6w08Y7yhB2bsyZhKX/I0msrq92KkxKsc2YI36BG3O760OPxhXgb8gsPtrD
         lepzlHWgiGz/dpgw+ybmOPBwy7+MhzieJkNrTs8Mo3BSgbkPqOX0l8IUZzQLKRuQI2mq
         3d4mC7qiYRljXNVFTZN5DJ0/YX9f1MLhwKvqj+cd9J8upJUEqNDCtMPSu+935sqY4HOO
         O25Rl8iDlSYTQw/wfd0venzC1dxgLej1VW9LW/JltqxurKk71hk2PHGvGRiC5e1PTiSJ
         QCnhdv2U2BAet1F+TzWT+kKri2HTTQyqwES09yiErx2Yq8+bM7fKeM0NkVx3YIs4p3sO
         LtFg==
X-Gm-Message-State: AOJu0YzZM8ZVlBaHtXr9PvbWOu2XsoTc+GnADVUa259lT2zLucYGOQHM
        Q5gMThEzD+wONRTyfXrfiCWoJA==
X-Google-Smtp-Source: AGHT+IEWAmv4wu9vPJK2ICJzCkDWUMORDZXKYB0gKPC3a7NsXvr4GtEaXeBkWd0hXxXYBffoLLIBHw==
X-Received: by 2002:a05:6a00:1151:b0:6ce:2e16:3771 with SMTP id b17-20020a056a00115100b006ce2e163771mr4969573pfm.22.1702496231709;
        Wed, 13 Dec 2023 11:37:11 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y31-20020a056a00181f00b006ceba4953f0sm10685026pfa.176.2023.12.13.11.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:37:11 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:37:10 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] wifi: ath10k: remove duplicate memset() in 10.4 TDLS
 peer update
Message-ID: <202312131136.5C46279@keescook>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-6-92922d92fa2c@quicinc.com>
 <202312131113.4C01D1DD5A@keescook>
 <bdabfb74-ea4f-4455-bb4c-1d93977393ea@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdabfb74-ea4f-4455-bb4c-1d93977393ea@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:36:08AM -0800, Jeff Johnson wrote:
> On 12/13/2023 11:16 AM, Kees Cook wrote:
> > On Wed, Dec 13, 2023 at 09:06:44AM -0800, Jeff Johnson wrote:
> >> In [1] it was identified that in ath10k_wmi_10_4_gen_tdls_peer_update()
> >> the memset(skb->data, 0, sizeof(*cmd)) is unnecessary since function
> >> ath10k_wmi_alloc_skb() already zeroes skb->data, so remove it.
> > 
> > Is .gen_tdls_peer_update only ever called after a fresh allocation? It
> > wasn't obvious to me as I tried to follow the call paths. Is there harm
> > in leaving this?
> 
> The only harm is a slight increase in code size and cpu cycles.
> 
> However note the skb allocation is done within
> ath10k_wmi_10_4_gen_tdls_peer_update() itself, just before the code
> being removed:
> 	skb = ath10k_wmi_alloc_skb(ar, len);
> 	if (!skb)
> 		return ERR_PTR(-ENOMEM);
> 
> And in ath10k_wmi_alloc_skb() we have:
> 	memset(skb->data, 0, round_len);
> 
> So the memset() being removed is always redundant.

LOL. I see now. I missed that was was looking outside the function! :P

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
