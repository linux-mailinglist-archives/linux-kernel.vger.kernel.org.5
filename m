Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CC27FE36F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjK2Wng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjK2Wne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:43:34 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3528C1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:43:40 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b27726369so2368285e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701297819; x=1701902619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPlSYieAKeZ1ZlgSPfXPoqg/eW8uKpsVlCNZ8IU+hBA=;
        b=D2aGmlP1LvAyjmxatkr2rxYMqVgc0mJgJuyD/NiwRF0VfQFsYcuu4triQGSuLB0MOC
         k6Rpi/FqLU/RfuaUpVOO8Ng3PR8Rp3/Ps3kCdD2f1QvM91FiCchEj9EE09ZwFrp5X1gE
         MVWFi7fp0DZQ2Yn9ijonFDNZNATqshGXITzE9OuDB4leErbQeDgYIm7exp4Wdo8NLewt
         xOqF3nfhBHU3Qo25vfjqP2lO+rc1W/yHIAm28jGonLCz6vvkTkj7w+ZPChpvIultMcBS
         4oZLU6rX79k1g5uJXo8VeWjvvdahO+k0++YrqGDH9wp8p/AoOQYaROeKoR08cwrhrOJ9
         zYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701297819; x=1701902619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPlSYieAKeZ1ZlgSPfXPoqg/eW8uKpsVlCNZ8IU+hBA=;
        b=R4qLvf4pdq3in+c1gDMiUhpUi2dFj2WvZdk+DjCuPUrkZTLLVZoUENZWzGSwYWOSX0
         FK50u1xUnFk38YAGwr/rMuI5ziz3AkuhxbxTEJXDuwFn+SdKdJCqvfOnbgTGH57af5Gd
         /bDYQF+Andaj6Nbo7Ka2m7JtbrmURNbKPsmpfWpsyP6ffvD9eJu4f17CpGgsHA4HTdRJ
         8i/7m1k7U75QKp4oioiuUA7PPjc3iE4aCORXFL113qSljwCgck5SUz/2QrspFfXV1HhM
         Qe0qhrEBQhzT3TVKYc4zFBbVTMrkoFaawh/xtveJJeubOHw9VQxvE9js6zyroeU9z9Um
         +ChQ==
X-Gm-Message-State: AOJu0YyhYSNs0p5HTiF1fMKtjlhqsadKoUXvYhc003/p61L471zYpCnk
        Ols0Tf+y5ldwV87ynaKSVLk=
X-Google-Smtp-Source: AGHT+IEUxdkYKt7NZdrpshbCMEE1jShiqAxqEFI/E6ZthNf7BgkK1wK8sSTJSHAgD288i8OAdBQ1Kg==
X-Received: by 2002:a5d:4d01:0:b0:333:f03:4640 with SMTP id z1-20020a5d4d01000000b003330f034640mr4906914wrt.1.1701297819067;
        Wed, 29 Nov 2023 14:43:39 -0800 (PST)
Received: from andrea ([31.189.63.178])
        by smtp.gmail.com with ESMTPSA id l9-20020adffe89000000b003330a1d35a8sm6287307wrr.43.2023.11.29.14.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:43:38 -0800 (PST)
Date:   Wed, 29 Nov 2023 23:43:34 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] membarrier: riscv: Provide core serializing command
Message-ID: <ZWe+ljzCUQQVu7oD@andrea>
References: <20231127103235.28442-1-parri.andrea@gmail.com>
 <20231127103235.28442-3-parri.andrea@gmail.com>
 <91ab0210-07f9-42c4-af7f-a98799250cf7@efficios.com>
 <ZWYDtB/otYvTMZWd@andrea>
 <0a84c0e0-2571-4c7f-82ae-a429f467a16b@efficios.com>
 <ZWeDF0eHyOc/b9UJ@andrea>
 <53aac2ac-46ae-46b8-9fdf-34527b79a63b@efficios.com>
 <ZWesWCRAPV3rZlx9@andrea>
 <041c83e6-1ca5-4953-bcec-03571135165d@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <041c83e6-1ca5-4953-bcec-03571135165d@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > So I should probably stick to 93917ad50972, which apparently selected
> > CONFIG_MEMBARRIER on RISC-V, for the Fixes: tag in question.
> 
> I think it goes further than that, because you can explicitly
> CONFIG_MEMBARRIER=y, see init/Kconfig:
> 
> config MEMBARRIER
>         bool "Enable membarrier() system call" if EXPERT
>         default y
>         help
>           Enable the membarrier() system call that allows issuing memory
>           barriers across all running threads, which can be used to distribute
>           the cost of user-space memory barriers asymmetrically by transforming
>           pairs of memory barriers into pairs consisting of membarrier() and a
>           compiler barrier.
> 
>           If unsure, say Y.
> 
> Before 1464d00b27b2, riscv just happened to set it to =n in the defconfig.
> 
> I suspect the initial port of riscv merged after v4.14 was already broken.

I see.  Oh well, guess I'll have to leave this up to the maintainers then
(I believe I've never managed to build riscv that far), Palmer?


> > I'll look into adding the membarrier feature you mention (as a final/
> > follow-up patch), unless you or someone else want to take care of it.
> 
> I'll be happy to review it :)

Sweet!  :-)

  Andrea
