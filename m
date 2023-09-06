Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED1D7944DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244613AbjIFVAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjIFVAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:00:15 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640B0180
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:00:12 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1ccc0d2e697so212008fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694034011; x=1694638811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/pwierm3geTwmDbGyOTegsvARs4VbCErTu9xnGSGKQ=;
        b=FhRaY3wV1cmt0AFkGpmynXHbmkWYYF9y4MJuKOV3R2br2wal3+XFgAJDgnHX4LqGIi
         s2VQirwjDfRwyHf5Fq1S+ibSW/IvLxORlb6Voc9VsieLgSX66HQRvIw3WBZ2xU7c+rmn
         I1jr/MdSpfr4FwwxSGIMoucjN0613+9gSJ2HIvKmKXMsNBfI425oROzTyOiQFJuy6G5t
         klA/g82iWx7x7gxFRUMZoUYnNKA1t7HOuy9rT/kOfY8iUW6BhbgtH4Hv9DlylT2sy5gO
         zLZ/iK9kCFrg6iioHNrCL694/ezYjSBi/EJc5KaMdapsHTwtKDoNw3WbgfBadClRJhhy
         MYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694034011; x=1694638811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/pwierm3geTwmDbGyOTegsvARs4VbCErTu9xnGSGKQ=;
        b=VAzPyjJBPjzxONLRtiUJtR5BvxhXfsnlAQiEOrcXlZaNR1L7qamWUclvzHEfgN27ap
         AXISHj5rwk8J8vAHI3fPqvFpdqiI7ITlB4Uw3At3A4CUVTX3OacxVShsyQQTJLDAT44I
         CQ0usNgFFKKfYoJ+6EJhF4hOIGZoO4pzLf60tubnknZHJRIcj9+bY72bRUwxMwVX1xqz
         gOZ+Mx8YAtsr1NE666CyUBcBzjZOSuNcfb/fha3hhC9PP483pSBk/Z1nY2JvcjjBOS9z
         Q7Q7qVQp3ceHWDNH8y2vAtzJNMaEaD8yCm8WTT+lu8VlI2afTcktiKQ70MsF/rBg7aXI
         cRCQ==
X-Gm-Message-State: AOJu0YxpiSDQ+MuZPRqgQ9HXUy/glJYkHdP/FYXLBbuf/ShDqQkgk/WJ
        FbY5Yx5i37zJ0nOVwvc3/Zs=
X-Google-Smtp-Source: AGHT+IFv3dLk3FZQ+S5ys+7ZRzdMcKUQN5Bg35xrtWeiheQLbsG+0wYE4xxTuwUCncv2z03QyLIE/Q==
X-Received: by 2002:a05:6870:e6c5:b0:1be:d49b:a3c5 with SMTP id s5-20020a056870e6c500b001bed49ba3c5mr22284941oak.29.1694034011323;
        Wed, 06 Sep 2023 14:00:11 -0700 (PDT)
Received: from geday ([2804:7f2:8006:99ef:50e4:98e3:42a7:1619])
        by smtp.gmail.com with ESMTPSA id c21-20020a05687093d500b001d0d4c3f758sm8131032oal.9.2023.09.06.14.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 14:00:10 -0700 (PDT)
Date:   Wed, 6 Sep 2023 18:00:10 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Antonio Terceiro <antonio.terceiro@linaro.org>,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: snd-cmipci oops during probe on arm64 (current mainline,
 pre-6.6-rc1)
Message-ID: <ZPjoWr17SNFHLDPD@geday>
References: <ZPelHaX/Lt++kkOm@linaro.org>
 <877cp3esse.wl-tiwai@suse.de>
 <4f335dd2-8043-c60e-cf84-c2b01c4fee12@arm.com>
 <ZPjGuCdmPgqznc5t@linaro.org>
 <ZPjM7op/B/CGCF/N@geday>
 <9e48fb7c-72a5-241a-004a-5f6791a81475@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e48fb7c-72a5-241a-004a-5f6791a81475@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 09:37:18PM +0100, Robin Murphy wrote:
> 
> Bit bigger than a Pi... ;)
>

Ohh, that's impressive indeed!

But looking around with Google, it turns out the Altra Ampere PCIe is
definitely quirky, see:

https://lore.kernel.org/linux-acpi/20200806225525.GA706347@bjorn-Precision-5520/T/
https://github.com/Tencent/TencentOS-kernel/commit/f454797b673c06c0eb1b77be20d8a475ad2fbf6f

The first quirk should probably be activated on Antonio's kernel but the
second one being a downstream Tencent patch, isn't. Alas, the second
quirk comes with a performance hit, see:

https://gitlab.freedesktop.org/drm/amd/-/issues/2078

Thanks,
Geraldo Nascimento
