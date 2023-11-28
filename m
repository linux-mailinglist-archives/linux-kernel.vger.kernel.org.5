Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B842B7FAEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjK1AWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbjK1AWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:22:06 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAEBC1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:22:12 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cb4d366248so4076877b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701130932; x=1701735732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FcF7EbG17wMf5A1vywn815C2rgzGBSTBqW3p8rKvm+Q=;
        b=gHW7zeIRSF2utN8brgCdiO6Rlba0fYGpE5dOK8IlsXWocIGrDthTK5MYK0qlDsXkw7
         gFpNyvoRmnbTa9zIL+TKPdtU+tCYSBjZCzJl7etvG6bAJe4ozoVqClXacnhoUodVz1en
         hBAKMVsquMEFYQFKpaTNhfdkxzuY5rGCExqIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701130932; x=1701735732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcF7EbG17wMf5A1vywn815C2rgzGBSTBqW3p8rKvm+Q=;
        b=jqkYhLlUFbF0R+9YgexiEcYnMaF94mm7oAFzPvbThAookNPXymhKtDQJSRzLrXewbl
         7fe3t1u/xVb29QjskRsDIBO293WCae3l/VaPT9VjqTKwSCv4LQwcbkEhywVTaoJWZE45
         nMWxDAtKDcF6aYV9YnwMGAtND/jhTO68JeEchoRH3um0b8mP2sSutGsZi4OcmOwf5kT2
         Ro4jG6RmXoZSvplK2YRIefy6SPKDmFFLfTfJhDO/44Bx+CbVTm9o8d1RXJtgKseDegCn
         wIwPanq8JoAiJzJ0YMFcqzyGnh0ON2VSVNZEIT+kxaqzF+gvdyCcZ+EJUv/bP0cMnn32
         v/sg==
X-Gm-Message-State: AOJu0Yy2WB4BFKXqtsAVvXORNi2//fnl3LoEhdO+GpGi7UgtRxhJ10nw
        10vuJmCsBFH5KGRpkoJAqKZ/Hg==
X-Google-Smtp-Source: AGHT+IGUgQLH74WqDwY1dXBnMXs3poKbhgyhnJWjJs8YpFTvm4lBIManweCNuXmLfe1LHnljM+TKyg==
X-Received: by 2002:a05:6a00:88f:b0:6b3:f29c:dde1 with SMTP id q15-20020a056a00088f00b006b3f29cdde1mr14055045pfj.21.1701130932417;
        Mon, 27 Nov 2023 16:22:12 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fh23-20020a056a00391700b006cc02a6d18asm4752811pfb.61.2023.11.27.16.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:22:11 -0800 (PST)
Date:   Mon, 27 Nov 2023 16:22:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Will Deacon <will@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] uapi: propagate __struct_group() attributes to the
 container union
Message-ID: <202311271620.B0CB21B@keescook>
References: <20231120110607.98956-1-dmantipov@yandex.ru>
 <f0bebfe0f7e02bb51676d8f6a80be0444e2b8662.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0bebfe0f7e02bb51676d8f6a80be0444e2b8662.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 06:37:14PM +0100, Johannes Berg wrote:
> On Mon, 2023-11-20 at 14:05 +0300, Dmitry Antipov wrote:
> > Recently the kernel test robot has reported an ARM-specific BUILD_BUG_ON()
> > in an old and unmaintained wil6210 wireless driver.
> > 
> 
> Heh. I guess it wasn't unmaintained enough for someone to touch it and
> add struct_group() to it...

It needed it since it was using memcpy across fields. But it's been a
while since that change happened, so finding this bug now is pretty
impressive. :)

> 
> >  include/uapi/linux/stddef.h | 2 +-
> > 
> 
> No idea what tree this should go through, but I guess wireless isn't
> appropriate.

I'll take it; thanks for the find Dmitry!

-- 
Kees Cook
