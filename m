Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5786C78CB99
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbjH2R54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238158AbjH2R5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:57:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EBF95
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:57:39 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401314e7838so10557305e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1693331858; x=1693936658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFho8P+UvUmfEV9wWiOTvex+Rj2mIp3Rwu/rvM1E0q8=;
        b=OXdc4F1dcJLZfEskIhO0i8KQnLpfcJJVPcffMsFY1G/UuKQfG//wd8yzrDNG05BiJe
         w4bg8r6MTsMEsVEwhO1i+s2hZKDGiTZTXZ+wyIB7ZLtgqldc/TYYuERv5ZNFIq7nnTgw
         BPvEOK1EIMyzqCF3HiawMJYHXFKftMKZBKxGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693331858; x=1693936658;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFho8P+UvUmfEV9wWiOTvex+Rj2mIp3Rwu/rvM1E0q8=;
        b=QWQ/Ar+/IiFvrFLTkOKZ1/pMWoUI4ZrdIVAUjyfOp6owWDeRXVFup3G/Tq9la9HZLv
         MZwNnl6vL2buw3GzwMllo5HjJtXUWsNTAO1PzdcQGY2BuOR0YOOnOd7K8BOI9/IPxMCY
         SjGF3oZzPNpayr93rUOsTCu3zkh/dOdzSKpwh9+4peFBst8aDkxDbsbW+8Dl7Tm4wXZ4
         Cb1tQ47TPrL93ifpxMsjMwPHlWo9ELTtw6YyP/W8KFiGOAu51/6QUu+P719gFlVKADQW
         TfbyStmHiziUZwMz4tQdYNiJcujhDpycwtNq3imZ5VWzxNnjMeLj0NHx87ZXNEeBqGMT
         Tx9g==
X-Gm-Message-State: AOJu0Yxp9DMIoPUA2ebRfnFMqB2Ag1XA1kmrZaa0HASKBECugQKSaSO3
        I8GQf0XHVk+u1LzSdaGqRAG/sQ==
X-Google-Smtp-Source: AGHT+IGAWDP/5Nw90I1fUZV8pHLMfzJOCfEFTIbxuzS3QBgmzrnEyZ9Z/DHllgOa/qo90N9EEEqu8g==
X-Received: by 2002:a05:600c:4284:b0:401:b9fb:5acd with SMTP id v4-20020a05600c428400b00401b9fb5acdmr40873wmc.3.1693331857981;
        Tue, 29 Aug 2023 10:57:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z16-20020a1c4c10000000b003fa96fe2bd9sm17728411wmf.22.2023.08.29.10.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:57:37 -0700 (PDT)
Date:   Tue, 29 Aug 2023 19:57:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        airlied@gmail.com
Subject: Re: [PATCH v2] drm: ci: docs: fix build warning - add missing escape
Message-ID: <ZO4xj/sHodsc8+X3@phenom.ffwll.local>
Mail-Followup-To: Helen Koike <helen.koike@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, airlied@gmail.com
References: <20230824164230.48470-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824164230.48470-1-helen.koike@collabora.com>
X-Operating-System: Linux phenom 6.4.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:42:30PM -0300, Helen Koike wrote:
> Fix the following warning:
> 
> Documentation/gpu/automated_testing.rst:55: WARNING: Inline emphasis start-string without end-string.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>

Applied this, sorry for the delay. I also rebased the tree onto latest
drm-next, in case there's any fixes for the current set of ci support that
need applying.

The other series I've seen looks like it's adding more support, I guess
that can be skipped for the initial stuff?
-Sima

> 
> ---
> 
> Patch for topic/drm-ci
> 
> V2:
> - Fix typo s/scape/escape
> 
> ---
>  Documentation/gpu/automated_testing.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/automated_testing.rst b/Documentation/gpu/automated_testing.rst
> index 1b87b802ac7f..469b6fb65c30 100644
> --- a/Documentation/gpu/automated_testing.rst
> +++ b/Documentation/gpu/automated_testing.rst
> @@ -52,7 +52,7 @@ IGT_VERSION
>  drivers/gpu/drm/ci/testlist.txt
>  -------------------------------
>  
> -IGT tests to be run on all drivers (unless mentioned in a driver's *-skips.txt
> +IGT tests to be run on all drivers (unless mentioned in a driver's \*-skips.txt
>  file, see below).
>  
>  drivers/gpu/drm/ci/${DRIVER_NAME}-${HW_REVISION}-fails.txt
> -- 
> 2.34.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
