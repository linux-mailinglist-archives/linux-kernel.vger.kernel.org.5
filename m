Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B3E78E3B6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbjHaAEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244576AbjHaAEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:04:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DDACD2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:04:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso1557445ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693440285; x=1694045085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2wclbGISi0DTsfnw2wuB5z2VMldigUtFlGGDgvrtyHY=;
        b=i5emslwmEfx6A6P3nRttHrDbA0mNyP9zy0qnWunRqBPf/DtfXT3l30rX2T0zHYQdEH
         yEpo5WUZDGCiaHEcSnCv5VWn+TCugNATZKKEZVmfZfz4gyVOyxfN5yendgfJzugV9cq+
         Add8CLfWPQFY0bT8j2R2pKd9Yw186y/oC3z34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693440285; x=1694045085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wclbGISi0DTsfnw2wuB5z2VMldigUtFlGGDgvrtyHY=;
        b=S2f7Xyaqy9NMOWfpzaEtejSwn5S+ea5pvdfCDyXxRkImHFilVH/oDLbnPdRuX9FX1j
         lB4OpVh86Vo+qoP6Pd9I1xQKx9W6GGgTq4s+xWgzuFZBLrwkU+4GlgXax6TJYJ6wvAHC
         hHcRSw0qXrF8tE9YVnbIzEDRNDRSeLwLNDmyLkx4lINeEWebq/qBjuznRT5xaCqNAhu5
         m32JM+73IefSmL9w4xvJkFrvMCCBOdAmhY+qCx49sHRoIreQPLbCb8/8V0tJewXZDDgp
         R3BCtPD55iU4BCNVk2oLelZe8KRM8FTHp/Rcfg5rCD7rX8jvpaWLWWSs+2ZIM+Pq0I5M
         FGIg==
X-Gm-Message-State: AOJu0YwIL+hLiCZl+cNiclYSn6Kyn1odDvm955lQS2frfH8/GkVNXiWh
        z/CieLqBEWEXVwm5Zb4wQKfayg==
X-Google-Smtp-Source: AGHT+IFGMTemHoGX0sBWxi5Tew5dUP8jSwJec6Ka+YeMhrkhHDOargCzGiUpjQ6Og16mC5nefUj++g==
X-Received: by 2002:a17:902:d34d:b0:1bf:5df2:8e97 with SMTP id l13-20020a170902d34d00b001bf5df28e97mr3592551plk.4.1693440285320;
        Wed, 30 Aug 2023 17:04:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902820d00b001c0cb2aa2easm67102pln.121.2023.08.30.17.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 17:04:44 -0700 (PDT)
Date:   Wed, 30 Aug 2023 17:04:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hardening@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k/atari: Replace strlcpy with strscpy
Message-ID: <202308301704.7A3F0F9CBD@keescook>
References: <20230830185428.4109426-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830185428.4109426-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 06:54:28PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
