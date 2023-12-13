Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D518811E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379365AbjLMTNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjLMTNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:13:00 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79763D5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:13:05 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d351cb8b82so4920165ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702494785; x=1703099585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8bLQ7DFBgxbMxDjvYWNP8XEjt+7+EJYhkC4hdPmoZ5I=;
        b=KObCsxtQ1cAmUcxJcFiPl2+Hgp1HqS40KRgYEv02I+luzqC/IOyf37piWXHU9dmndl
         +UnUC2ryR970fxeaGXxIh7S88J6/3zyFnwATUyBC2cecbuBu7nO6mBpaG+CUw5yB3EYh
         UeoP1PzU6wnRtD/3fMquYi6ge1pMKRGf1A4LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494785; x=1703099585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bLQ7DFBgxbMxDjvYWNP8XEjt+7+EJYhkC4hdPmoZ5I=;
        b=nsDUtf4YKrOZ+e5Mp6m0/WOJ8L8Z8e4PdisXNIvHgZ2/z0mIOxF2P/2NhVWlG1i+Bk
         IkwYzqEbEWGoG3a5YHWoDm6WkpvtmocQbLD2F7tAV5f0k3QxgXGMUfrepKsl0vYz1les
         MnA0nmd0Zuyd9TgRhmbk9Tl8mKEJ5MXKYHG/+P6DC2nszC6tUHfZ6H4r7uUaH+ADiZOt
         r1PTCQrDruZ94n7eaVJmeOK79QHuETJP1BGcPb3vHbeY/ZFh1tskc48OrOXPm7xmcAZi
         qX7QcZzEXY81yC19ZqWOJPBUV0+erdrS5yjT/tT2b23jLC3U/IkWmrBUEf8XC/x1dqAo
         I1XQ==
X-Gm-Message-State: AOJu0YwC5+edY4iMvGtE5Z+GamNatAMUi6BuB9g/Q657T4zNb7Pai0eo
        cTDxL30L/vn7zzXGGNjQidgCjXhSIH41nJf1Pns=
X-Google-Smtp-Source: AGHT+IGL9MMpLeGyfBggOyjFOzc4MaMEeL6K7oxPe7D1N49hFYuaaCuEaNAiBmxymSDR4jyxBsYqmA==
X-Received: by 2002:a17:902:704c:b0:1d0:6ffd:ae22 with SMTP id h12-20020a170902704c00b001d06ffdae22mr4435835plt.137.1702494784997;
        Wed, 13 Dec 2023 11:13:04 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001d3485656afsm822977pld.183.2023.12.13.11.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:13:04 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:13:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] wifi: ath10k: use flexible array in struct
 wmi_tdls_peer_capabilities
Message-ID: <202312131112.F4A76DD3C@keescook>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-5-92922d92fa2c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-5-92922d92fa2c@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 09:06:43AM -0800, Jeff Johnson wrote:
> Currently struct wmi_tdls_peer_capabilities defines:
> 	struct wmi_channel peer_chan_list[1];
> 
> Per the guidance in [1] this should be a flexible array, and at one
> point Gustavo was trying to fix this [2], but had questions about the
> correct behavior when the associated peer_chan_len is 0.
> 
> I have been unable to determine if firmware requires that at least one
> record be present even if peer_chan_len is 0. But since that is the
> current behavior, follow the example from [3] and replace the
> one-element array with a union that contains both a flexible array and
> a single instance of the array element. This results in a struct that
> has the same footprint as the original, so no other driver changes are
> required.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> [2] https://lore.kernel.org/linux-wireless/626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com/
> [3] https://lore.kernel.org/linux-wireless/202308301529.AC90A9EF98@keescook/
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Again, good to keep the struct the same size.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
