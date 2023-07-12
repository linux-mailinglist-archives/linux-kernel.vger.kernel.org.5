Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9C27514C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjGLXy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGLXy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:54:28 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F751BF2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:54:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b89114266dso1423515ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689206067; x=1691798067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvkFiyqULDxpTvgtRj4icSA9iUWkpiYfk5PF0EtUrTI=;
        b=bmOM344cC3FsZrp85zCEuMvefaKXvyZ29nJcNSM2VxsVpaPyDIQO7SUmFD0FD1faQs
         avgbhXIemaecM59GyeF5bWuv1hkRIGlIkVgycsHrD+BKt4lifLjLBZl9hnhXrkL/Fvhc
         izik/yu9ygd36Ra8QwopPBqHdRTovzG3L8yrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689206067; x=1691798067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvkFiyqULDxpTvgtRj4icSA9iUWkpiYfk5PF0EtUrTI=;
        b=HOeNhvwtGO8822gaQcXQ6y/Zkp8PBz3aRRkQ0H2e4KPlN2iK6CFy9VU+rHTRMzIiT3
         HgPnSLFk+GHrROgPx9Kbgy80ie5wFu1sqmD0YvmL9kgBsOPlM2qYycYPIIU77Eq4jiho
         pngByBJG0hjrALCDx8eo9Q2TPejGtEKAkglxMFE02ied7Ajazi58YbYD6Ec75R/34Fqj
         IITFsYN6zdNkxw8ck2AEtceB0p4bOjvOPhPRqIYkpqy90VQTmq8VXhfdqGKPX0rAfxNm
         38/izHiOsBAm/h1l5FR8RlNm/aL1mgZjvi7ypjJgAcgyTNmlpoK8NZVStHqEyLcATehB
         4E3A==
X-Gm-Message-State: ABy/qLY7HJGuaP27A0edrJwl4SnddUX+W2rBDCqHOYZtnvAJvG4VrMi4
        6AUva+rAvsGbi0lgDF/7lU5GAw==
X-Google-Smtp-Source: APBJJlEQsAuK2FjOXsLLwedVTL2+xDqUAFVigL9HsD7VrSvCaYnqXJH1eTzZvJK9JyPR+/lZAQjrlw==
X-Received: by 2002:a17:903:246:b0:1b7:f73d:524 with SMTP id j6-20020a170903024600b001b7f73d0524mr98592plh.43.1689206066921;
        Wed, 12 Jul 2023 16:54:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902724b00b001b53d3d8f3dsm4493451pll.299.2023.07.12.16.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:54:26 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:54:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-hardening@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: Replace strlcpy with strscpy
Message-ID: <202307121653.4A9C69C655@keescook>
References: <20230703181256.3712079-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703181256.3712079-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 06:12:56PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since DEV_ASSIGN is only used by
> TRACE macros and the return values are ignored.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Looks good -- thing is using return values from the macros.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
