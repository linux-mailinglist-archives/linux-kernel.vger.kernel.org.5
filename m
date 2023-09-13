Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EB779F562
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjIMXRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjIMXRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:17:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C2F1BD1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:17:31 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-573ccec985dso249854a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694647050; x=1695251850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1a1XS5FwL95wVQ3U0hOYK16YJk3gJb5vChvM9EJIak=;
        b=NovGamzA9VvBNl1NvPwObRG4Yw8PVqhR4W2GbES9EwqPPd8vZ4mFtfrvBaSYXGLaA4
         MAz6DE7lN9SXDmizvtRaBovZL69KvTwI6z/vEVlwZTg/wvvDDcU6p+r1DdhMEYVF7wG0
         EwreFS0fKayZ4E+M2fxYwOseRYK3+5S9+DSOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694647050; x=1695251850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1a1XS5FwL95wVQ3U0hOYK16YJk3gJb5vChvM9EJIak=;
        b=Uj536mDx2XZQ7BiPfQUqMwrlUxFL+nVAhOAxKObggSfypdQlqk+Wcs4EoFxlvO/h9g
         i7sBlh/ix0J4/OAe3sw+Oyfn25IqLzwnfYV2eB29zKSTDj0VQTSC59TxeHIIwftNsUqR
         h3AZzeFqR45N+IgLzgNdMzS9yYBITHPnawFMVJpIkzGPsaj7Csy/RPv3FaqC3F/+YoKo
         sYpEqa0rYPIy8ileDRlyVcDzgFj4Mr4e4ZanwiuxCcpzK9oLthU0Qilo6c6kH7yAM+uu
         3oaU1dLYfNmLRLCwhrbhQgAyLFEdibrtMETtpZKGgRBtuUILhuclA3Zy9e/Ae1OVhwrV
         AAEA==
X-Gm-Message-State: AOJu0YyODyy3l00aJzdajP1tdRPtagKcK7hy1mjBggiEPZA3doqJPYSF
        ifmszFXl/Lkl1rkt0qnVzHIcsg==
X-Google-Smtp-Source: AGHT+IGClTtKAGRhwBX0rTWyQayaNUFl7oUgqH9imWkdIjnn/sGMkGEiuN74YRWSvEaa6g5mBChF6w==
X-Received: by 2002:a17:90a:a008:b0:26b:24ed:e0d9 with SMTP id q8-20020a17090aa00800b0026b24ede0d9mr3570072pjp.33.1694647050628;
        Wed, 13 Sep 2023 16:17:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090a684f00b0026b4d215627sm128652pjm.21.2023.09.13.16.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 16:17:30 -0700 (PDT)
Date:   Wed, 13 Sep 2023 16:17:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, corbet@lwn.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tony.luck@intel.com, gpiccoli@igalia.com,
        mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        linus.walleij@linaro.org, andy.shevchenko@gmail.com,
        vigneshr@ti.com, nm@ti.com, matthias.bgg@gmail.com,
        kgene@kernel.org, alim.akhtar@samsung.com, bmasney@redhat.com,
        quic_tsoni@quicinc.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@quicinc.com
Subject: Re: [REBASE PATCH v5 08/17] arm64: mm: Add dynamic ramoops region
 support through command line
Message-ID: <202309131613.C0E12D0D14@keescook>
References: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com>
 <1694429639-21484-9-git-send-email-quic_mojha@quicinc.com>
 <20230912101820.GA10884@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912101820.GA10884@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:18:20AM +0100, Will Deacon wrote:
> On Mon, Sep 11, 2023 at 04:23:50PM +0530, Mukesh Ojha wrote:
> > The reserved memory region for ramoops is assumed to be at a fixed
> > and known location when read from the devicetree. This may not be
> > required for something like Qualcomm's minidump which is interested
> > in knowing addresses of ramoops region but it does not put hard
> > requirement of address being fixed as most of it's SoC does not
> > support warm reset and does not use pstorefs at all instead it has
> > firmware way of collecting ramoops region if it gets to know the
> > address and register it with apss minidump table which is sitting
> > in shared memory region in DDR and firmware will have access to
> > these table during reset and collects it on crash of SoC.
> > 
> > So, add the support of reserving ramoops region to be dynamically
> > allocated early during boot if it is request through command line
> > via 'dyn_ramoops_size=' and fill up reserved resource structure and
> > export the structure, so that it can be read by ramoops driver.
> > 
> > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > ---
> >  arch/arm64/mm/init.c       | 94 ++++++++++++++++++++++++++++++++++++++++++++++
> 
> Why does this need to be in the arch code? There's absolutely nothing
> arm64-specific here.

I would agree: this needs to be in ramoops itself, IMO. It should be a
ramoops module argument, too.

It being unhelpful for systems that don't have an external consumer is
certainly true, but I think it would still make more sense for this
change to live entirely within ramoops. Specifically: you're
implementing a pstore backend behavioral change. In the same way that
patch 10 is putting the "output" side of this into pstore/, I'd expect
the "input" side also in pstore/

More comments there, though.

-- 
Kees Cook
