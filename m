Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A517A2468
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjIORON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjIORNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:13:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED24E7F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:13:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fc081cd46so2283011b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694798014; x=1695402814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fRHJ/RTdkjV1T7VQMz3Gh8DiS1ERKAhw13PCyOr4quI=;
        b=d/BpGzO4zmNEoey5wzbS5IJHtoYqCwjle7N4blNvGqGh84uci5bxH0GnllApNKPD4n
         0NjFVClcVCLCNgigXho/sFdE3zOGCm7Bc0SuAL14ImPszCtaSMX6vZVLIw9Pk4e/yood
         pzSXn/fgHkaEc1ccSzgxO0c/ZXDIEvyVB7OeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798014; x=1695402814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRHJ/RTdkjV1T7VQMz3Gh8DiS1ERKAhw13PCyOr4quI=;
        b=AeiFPGqC1KlmKU6o9SnsgdGhRLvYXkb5CEzaAwBzp1L5nR9iuFoJ67ipWG6KMVHh27
         KFrjCfzNKhKtjTyKF/ZLp1vSFRzVPLz3S0Sf9fQt3DkTlH19DRIQR2kLsYfCeaPCWTcG
         OhDV6IGxPHp3olX/yJjA4VL/K8Lwchxmn7JC+PYrimCIH6xPezx+02c8+Cdf6Mp8FqAL
         zXnaDzBY+fJLL0fK/3r5iDoS0KbSFLEtAKVbqT7TBwoWlJdjD0NsPuS78v2tFZt5hEDm
         9bVA4IIEmaVIPpWKSIMu9U256/CIuvBCWQC5GSi2QbPpG0OptKTOh2uYNbUGS5QGTqKr
         UeDg==
X-Gm-Message-State: AOJu0YytHTpyDNFhnq0EMBeX5dqLUHp9X7AcsG1Nan2DVSTUkTLCCyYc
        wyOfsM6WaxJ6AAedHCeISmthIA==
X-Google-Smtp-Source: AGHT+IEJoJES88+Guv1IYodwJB+0lLZf+yalUNfYiexFIPINgKTeK/Z0sDBr642L1qn2LfQeqyMcvQ==
X-Received: by 2002:a05:6a20:8f0c:b0:159:e0b9:bd02 with SMTP id b12-20020a056a208f0c00b00159e0b9bd02mr3278129pzk.40.1694798014413;
        Fri, 15 Sep 2023 10:13:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j15-20020a633c0f000000b00565009a97f0sm2965476pga.17.2023.09.15.10.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:13:33 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:13:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] firmware: ti_sci: refactor deprecated strncpy
Message-ID: <202309151012.446CC82E2@keescook>
References: <20230913-strncpy-drivers-firmware-ti_sci-c-v1-1-740db471110d@google.com>
 <202309142103.6DFFDEB@keescook>
 <20230915124038.vmj3gzthboypzp3v@parsnip>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915124038.vmj3gzthboypzp3v@parsnip>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 07:40:38AM -0500, Nishanth Menon wrote:
> On 21:03-20230914, Kees Cook wrote:
> > On Wed, Sep 13, 2023 at 08:23:02PM +0000, Justin Stitt wrote:
> > > `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> > > 
> > > We should prefer more robust and less ambiguous string interfaces.
> > > 
> > > A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> > > NUL-termination on the destination buffer.
> > > 
> > > It does not seem like `ver->firmware_description` requires NUL-padding
> > > (which is a behavior that strncpy provides) but if it does let's opt for
> > > `strscpy_pad()`.
> > > 
> > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > > Link: https://github.com/KSPP/linux/issues/90
> > > Cc: linux-hardening@vger.kernel.org
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > 
> > Looks right to me.
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Does this belong to stable as well? If so, please add appropriate stable
> process.

No need. This is a refactoring only. :)

-- 
Kees Cook
