Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CC47B49B7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 23:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjJAVW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 17:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjJAVWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 17:22:25 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B219B
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 14:22:23 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57be7c28423so5077166eaf.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696195343; x=1696800143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PHJrlgm7LFwgtNAlZtL3Zhw4zS1ia4QUcX3TsUNW/zY=;
        b=K8ahlFg2t0R6P640XZbVxn1n2eDcpclSPylMTjfPl2JXWodDr6kLrmiNBWzklmDxfH
         Aw2tK9NBINlcbwYXlmiUEecoy2Zwz4jDigiPKrVjpnE7TY7Rvf5x+y+PkzQQHURorboz
         xCH+3AnjYHGTOI1euqmlPVViIwmcqqhQwYQ1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696195343; x=1696800143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHJrlgm7LFwgtNAlZtL3Zhw4zS1ia4QUcX3TsUNW/zY=;
        b=fgHiS2n2b5TFT4zH89/fzQN+Y9KrDH8mqKT382LTlVJBaUC9oUlpce4nYYxTR3pVWY
         FKFgR382wZBe5mIUOZlhURFclVWlsnPajOC8fgYHwgLQohPxkkkszQK8GfZ7OwYxSQDZ
         SEa9W0JBdv54E2II10mpeCGPQ6W4lMphooMeAx0Lt+6bjAMXxqClk5Chl8IImWIT7zEk
         HoUbwPzSBhakOF129q3q3OTxTwCIkUmmeX0zujyc2x2xRPLgHen339Of3ajyTpcvcwZ+
         Tw8FOC9H2XfA0j1o4lGkilefmwXnMXB0bR9WnpjukxkZwtjCNGzF0N7Ttbaeer5LvmVX
         sUwQ==
X-Gm-Message-State: AOJu0Yzo7Rwd8OlraiwhsaP5majOcC63D7FWgyKbPzVcktrKnmutuOHc
        y14KPzKbPaTfjxVBb1bcTHWpnA==
X-Google-Smtp-Source: AGHT+IFJ8g4Z37QS8SaU2llcFOkETm2VqxZtmL7Bq8TmJ06CIdCQ3MlUKaTsGOWE7trNihoFqgoeXw==
X-Received: by 2002:a05:6358:91c:b0:139:cb15:ecd3 with SMTP id r28-20020a056358091c00b00139cb15ecd3mr12488851rwi.8.1696195342750;
        Sun, 01 Oct 2023 14:22:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y5-20020a62b505000000b0068ffb8da107sm18363405pfe.212.2023.10.01.14.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 14:22:22 -0700 (PDT)
Date:   Sun, 1 Oct 2023 14:22:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Kees Cook <kees@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] comedi: Annotate struct comedi_lrange with __counted_by
Message-ID: <202310011421.C4F19D45@keescook>
References: <5c3b7459b820e22e2ac6ce892d4aadcc119cc919.1696065263.git.christophe.jaillet@wanadoo.fr>
 <202309301342.5B5BED40A1@keescook>
 <alpine.DEB.2.22.394.2310010945130.3166@hadrien>
 <90E2BBA5-8A2D-42DE-B36A-CD37BABBB433@kernel.org>
 <alpine.DEB.2.22.394.2310012112560.3166@hadrien>
 <202310011405.7599BA9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310011405.7599BA9@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 02:05:46PM -0700, Kees Cook wrote:
> On Sun, Oct 01, 2023 at 09:14:02PM +0200, Julia Lawall wrote:
> > Kees,
> > 
> > You can try the following.
> 
> Cool! Yeah, this finds the example:
> 
> drivers/comedi/drivers/rti800.c:74: struct comedi_lrange: field at offset 0 is the counter for the flex array
> drivers/comedi/drivers/rti800.c:83: struct comedi_lrange: field at offset 0 is the counter for the flex array
> drivers/comedi/drivers/rti800.c:92: struct comedi_lrange: field at offset 0 is the counter for the flex array
> 
> I'll run it on the whole codebase...

It found only the struct comedi_lrange instances, but that's good to
know. :)

-- 
Kees Cook
