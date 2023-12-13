Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863A9811E78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442036AbjLMTP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjLMTP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:15:56 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E113A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:16:02 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c629a9fe79so4028657a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702494962; x=1703099762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Br5McNKdDym1wVpBK6ZxqsWLJASJUX98L4YfXiPz+I4=;
        b=M4osAj7n5fVuu0d2QVU/hVsbixcpCa/GrQXR8qiQgTT38HTQGDW8Rxln6DRS29lC1I
         /aOM6Y2SGohkmZNOTSxmmu64Ge2UhwxX9NBeLUuu+vLoui7JDjcfgZnlIDgGDXkHaHIf
         zt1L/nQJOfrcoZFRAzxBmvvczRgDRvjBr4bhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494962; x=1703099762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Br5McNKdDym1wVpBK6ZxqsWLJASJUX98L4YfXiPz+I4=;
        b=lUpeNLJbjY7kb+gV18VHQ+ov94DP7O2rM5h61Y2zPS4G1jtwjxfR4zuT8X+J3r5Q9M
         zzd19OSfTX4HADwzYYxmfm8a19iySUktuBQwUw7KcHFxXtZDnxiXlXjIpjTxO0Kv4+zX
         diU+qr3Ybuny+dbV2pWw+AlubkZ2k10EpL8N77c8Np6JBJAyPCu536GLt48ZJbNFZkaj
         TLKPzUGxzXe1PC5P60BaAkLVHR80X/DdGZA3U79ZJS0U45ue5M0QoQBynhc16z6zcwdH
         1+aQII0NIdPhmXH5hnmNmSKTt1DlC+hKIkzk2mmuvcyiqXozWkgzOU4ZvjcthHddVlxI
         cq0Q==
X-Gm-Message-State: AOJu0YwBrH2rxYW4C1aUWPsKPb2cnCJ7z7wrMPqa1qMtJHGjkH77Giv5
        TN8vdsi402D8ohQ2aRkjk68+mg==
X-Google-Smtp-Source: AGHT+IFoskKiE/aMuNO9zn8FAfarVwTklXpACZeypIRM0uei3Al3NZmvnOp5zIAhin3jtPPkFxdKzA==
X-Received: by 2002:a17:902:e804:b0:1cf:7c3d:df68 with SMTP id u4-20020a170902e80400b001cf7c3ddf68mr5893869plg.39.1702494961970;
        Wed, 13 Dec 2023 11:16:01 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902b58a00b001d331bd4d4csm4097248pls.95.2023.12.13.11.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:16:01 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:16:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] wifi: ath10k: remove duplicate memset() in 10.4 TDLS
 peer update
Message-ID: <202312131113.4C01D1DD5A@keescook>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-6-92922d92fa2c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-6-92922d92fa2c@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 09:06:44AM -0800, Jeff Johnson wrote:
> In [1] it was identified that in ath10k_wmi_10_4_gen_tdls_peer_update()
> the memset(skb->data, 0, sizeof(*cmd)) is unnecessary since function
> ath10k_wmi_alloc_skb() already zeroes skb->data, so remove it.

Is .gen_tdls_peer_update only ever called after a fresh allocation? It
wasn't obvious to me as I tried to follow the call paths. Is there harm
in leaving this?

-Kees

> 
> No functional changes, compile tested only.
> 
> [1] https://lore.kernel.org/linux-wireless/626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com/
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath10k/wmi.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
> index 4d5aadbc7159..0cfd9484c45e 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -8918,8 +8918,6 @@ ath10k_wmi_10_4_gen_tdls_peer_update(struct ath10k *ar,
>  	if (!skb)
>  		return ERR_PTR(-ENOMEM);
>  
> -	memset(skb->data, 0, sizeof(*cmd));
> -
>  	cmd = (struct wmi_10_4_tdls_peer_update_cmd *)skb->data;
>  	cmd->vdev_id = __cpu_to_le32(arg->vdev_id);
>  	ether_addr_copy(cmd->peer_macaddr.addr, arg->addr);
> 
> -- 
> 2.42.0
> 

-- 
Kees Cook
