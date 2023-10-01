Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02E97B4A28
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 00:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjJAWVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 18:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjJAWVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 18:21:34 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338C0CE
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 15:21:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-69101022969so14348355b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696198890; x=1696803690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0pqyiI3+7drkqtZIOt/nPWQvKqd+z/yppiMX4edx8e0=;
        b=NDfAyqKtPqK4dieOW/2h7XgW879BvlK+Zs+BmgGEF2I3fiZNYTmR1iQI2w3z6Hv90s
         qW2AfUWgYRNNZyu4aMHnl43dZDH8EEFYHWe/mIEYp8P4Nu0aXUDFgFbLz6B7zqpzrsTH
         rbSicNfLts5ilJRxU+mBMaa9C/2syFmn3aBYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696198890; x=1696803690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pqyiI3+7drkqtZIOt/nPWQvKqd+z/yppiMX4edx8e0=;
        b=lERP4Lb3b/wCawMxA8mORPn2pf5IVZ4GfOvTrgSwOYmBUNPGMjOencLjiXeHK46iVq
         At7JXfSsLpnqd5riWnHGjGMnGv3ku/JOF2ER/J65bPaKc4tz7K8/pqyQmSYH9XPFbeVN
         jkRpmK5wq/EKSXDFKEnR8TGXJBCjtxxsHKYAFBhn3Ei4tKMOPLZ7iYwo7vBIqWOuLjKR
         p1P+bhfTaydj12YFR8OdeYxYtqcyHDvZ1KPB69TDpWD+tsytSDtRQ3hXrHUAQymuv/Ng
         SMamZaj7ju/XKaJ0cQhm9lJve9KIHz7tlZhs4OhMW87uv+YkC9r14Q4N9muBapNaJvlX
         OAdQ==
X-Gm-Message-State: AOJu0Yz6vIHl5xOHuxft5v3T2hAe/s1OwftokFgIfT7ybAGA0/3wpyxU
        QWKc1lvIkP05OuRds6ppc7bhWw==
X-Google-Smtp-Source: AGHT+IEygYiXe/d0uPbrlFytK8CFzeVNQ2yBgFbzEaFRC83+K+JWqX4wlfI8uaxMMEcnvrQFQnEagw==
X-Received: by 2002:a05:6a00:852:b0:691:da6:47a with SMTP id q18-20020a056a00085200b006910da6047amr12630310pfk.31.1696198890639;
        Sun, 01 Oct 2023 15:21:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q26-20020a62ae1a000000b0068ffd4eb66dsm18313851pff.35.2023.10.01.15.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 15:21:29 -0700 (PDT)
Date:   Sun, 1 Oct 2023 15:21:27 -0700
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
Message-ID: <202310011515.D4C9184@keescook>
References: <5c3b7459b820e22e2ac6ce892d4aadcc119cc919.1696065263.git.christophe.jaillet@wanadoo.fr>
 <202309301342.5B5BED40A1@keescook>
 <alpine.DEB.2.22.394.2310010945130.3166@hadrien>
 <90E2BBA5-8A2D-42DE-B36A-CD37BABBB433@kernel.org>
 <alpine.DEB.2.22.394.2310012112560.3166@hadrien>
 <202310011405.7599BA9@keescook>
 <202310011421.C4F19D45@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310011421.C4F19D45@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 02:22:17PM -0700, Kees Cook wrote:
> On Sun, Oct 01, 2023 at 02:05:46PM -0700, Kees Cook wrote:
> > On Sun, Oct 01, 2023 at 09:14:02PM +0200, Julia Lawall wrote:
> > > Kees,
> > > 
> > > You can try the following.
> > 
> > Cool! Yeah, this finds the example:
> > 
> > drivers/comedi/drivers/rti800.c:74: struct comedi_lrange: field at offset 0 is the counter for the flex array
> > drivers/comedi/drivers/rti800.c:83: struct comedi_lrange: field at offset 0 is the counter for the flex array
> > drivers/comedi/drivers/rti800.c:92: struct comedi_lrange: field at offset 0 is the counter for the flex array
> > 
> > I'll run it on the whole codebase...
> 
> It found only the struct comedi_lrange instances, but that's good to
> know. :)

On a related note, why doesn't this work?

@allocated@
identifier STRUCT, ARRAY;
expression COUNT;
struct STRUCT *PTR;
identifier ALLOC;
type ELEMENT_TYPE;
@@

        PTR = ALLOC(..., sizeof(\(*PTR\|struct STRUCT\)) +
                         COUNT * sizeof(\(*PTR->ARRAY\|PTR->ARRAY[0]\|ELEMENT_TYPE\)), ...);


minus: parse error: 
  File "alloc.cocci", line 15, column 34, charpos = 485
  around = 'struct',
  whole content =       PTR = ALLOC(..., sizeof(\(*PTR\|struct STRUCT\)) +

if I drop "struct", then it complains about ELEMENT_TYPE...

-Kees

-- 
Kees Cook
