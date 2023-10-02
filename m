Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EF47B4C9F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbjJBHgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbjJBHgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:36:37 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B918D7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:36:34 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso12645415a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696232193; x=1696836993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o8TgiYq+wn9fPs2sstUM34/3tbN8lpchGjTxpN3osFc=;
        b=EYcTIe1rA5iMT9Eckl75edHfhjI2D9SUeW2wCe3HFLYHXWuxwOgTZgpt6Z4iwjUTES
         s4ersIvJVc++7TZ+J8kJOkFvuOqa2DRihG/rYeoatuYKdMDtbiepbwDoOryk6a6nn9m3
         y9uwYMVUPlfjSUYEdwLj2h09wNwEfTgEIFC/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696232193; x=1696836993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8TgiYq+wn9fPs2sstUM34/3tbN8lpchGjTxpN3osFc=;
        b=GSkyT+o+4XlrHCVJw4RwRvxc2jr0h1Tus8bKv5+gpbew89GTw2WtugQLr2dVcl2V2G
         VwSyPL0Hz77VRf+XY4kUKeg3d6QDJJzASSOOaEWyUY+ZYqg/NUAXO3ZNF3SXosBRXH9j
         xJQf3RHBhlXEQIWjXO6q81t0PfbtSebEfSc48mr0YkIn/wm4oBH4YXTJ4yi1HDlY0faR
         ejwyuUKLUwHm2SA0xuLqrvNzHjjdkI2t2+CHvBt+QMogmlOXb0Zp7N6GtUv8OAgpFHYk
         iRoGcb7lP4a49gm2CPo6IqVmPj21qphZMkVFfyRtir4GPddq1r6zV74vueoRDR4q4One
         A3Mg==
X-Gm-Message-State: AOJu0Yy4dtUVG8kPgsxQC2BZRHgFWZTWwOUAsET5Cu8zjUgnguXSyIWa
        K/aZU5iQFqu6LoofVbhZ/Xh9Dg==
X-Google-Smtp-Source: AGHT+IE/4RrZBVTAWpHkJyOr41YZ89aixqnrkCQ1kdzSx+Qmep1XqZBJfajMYApMeMqYNsEHfwK1sQ==
X-Received: by 2002:a17:90b:3644:b0:277:1bd8:abe8 with SMTP id nh4-20020a17090b364400b002771bd8abe8mr9560405pjb.18.1696232193693;
        Mon, 02 Oct 2023 00:36:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 6-20020a17090a194600b00278eb908f78sm6274500pjh.19.2023.10.02.00.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:36:33 -0700 (PDT)
Date:   Mon, 2 Oct 2023 00:36:28 -0700
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
Message-ID: <202310020036.864B735D60@keescook>
References: <5c3b7459b820e22e2ac6ce892d4aadcc119cc919.1696065263.git.christophe.jaillet@wanadoo.fr>
 <202309301342.5B5BED40A1@keescook>
 <alpine.DEB.2.22.394.2310010945130.3166@hadrien>
 <90E2BBA5-8A2D-42DE-B36A-CD37BABBB433@kernel.org>
 <alpine.DEB.2.22.394.2310012112560.3166@hadrien>
 <202310011405.7599BA9@keescook>
 <202310011421.C4F19D45@keescook>
 <202310011515.D4C9184@keescook>
 <alpine.DEB.2.22.394.2310020737570.3166@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2310020737570.3166@hadrien>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 07:38:42AM +0200, Julia Lawall wrote:
> The sizeof with an expression argument is treated differently than the
> sizeof with a type argument.  So you need to write:
> 
> @allocated@
> identifier STRUCT, ARRAY;
> expression COUNT;
> struct STRUCT *PTR;
> identifier ALLOC;
> type ELEMENT_TYPE;
> @@
> 
>         PTR = ALLOC(..., \(sizeof(*PTR)\|sizeof(struct STRUCT)\) +
>                          COUNT * \(sizeof(*PTR->ARRAY)\|sizeof(PTR->ARRAY[0])\|sizeof(ELEMENT_TYPE)\), ...);

Ah! Thank you thank you! Yes, this works great now. :)

-- 
Kees Cook
