Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98777839C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjHVGMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjHVGMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:12:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03585186
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 23:12:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc63ef9959so31999325ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 23:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692684728; x=1693289528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w45Oqv9V+9GduMYZDVvpjOPvC6nIzmlSs0r5WVQ2Q5k=;
        b=NRA3ibdjsNuRArDJbB+9n5vZjZxQGhFDqh2Cr9v17/iiJCG9qQo6bRiXx8hMPByy6O
         wdAEn0XZi7zJASuTW9oGUjKm4QD2GkH6W5APo6rjGD5NDgjqrbxHF87+B3gitaeqCuCq
         DwIu796zGkwCSTW+efq9ZxNNQczi0pIYy+/gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692684728; x=1693289528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w45Oqv9V+9GduMYZDVvpjOPvC6nIzmlSs0r5WVQ2Q5k=;
        b=kuBZyqx3SVJjqrO/VRIKKgvuej2VjD1XKkYdpF397rui4oljj64eNYVLrj0uLOAuob
         eHFcwbiFUsDjc63T6MFCDK3UQxMirryNUBUuwGKI098mZv0DEQizMY4bkFDQYmkaCXuc
         kGfjcwxaKxbhoKfo0pTdvKnF7gz3SL+gcpQj9v4Fkhs4aLXmgdWPixZYqgGc8JDySZgW
         7R2A+xD+tssWgH3m0DtC3ODFZlMy2yq1EzxztX/ryvVhbThyh17SeArghws/qlFU3WUP
         dNI0JUX6E5P7g+y+wnkbumR3Pf92ps3ZOnEjCi9K86hxS9Jn4R6rdWUJUwicZGSn+jVa
         KmXQ==
X-Gm-Message-State: AOJu0Yz7i9OIODjhlxMMNOOWpY8MwvHoCQ3HslD6h5ekLsX3UCsk/gp+
        SQBE/1I2o/cl2+jukMUnuOKldw==
X-Google-Smtp-Source: AGHT+IHiuSHIk401989XjYLzZuT/i2ncQJKajBtdSdauDZOiU31hXa77jn81segf0rCj+wwJsWu52Q==
X-Received: by 2002:a17:902:d4c9:b0:1b8:a88c:4dc6 with SMTP id o9-20020a170902d4c900b001b8a88c4dc6mr11451735plg.45.1692684728409;
        Mon, 21 Aug 2023 23:12:08 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f833:4d35:e744:4f9e])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b001b9ecee459csm8122816plh.34.2023.08.21.23.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 23:12:07 -0700 (PDT)
Date:   Tue, 22 Aug 2023 15:12:03 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Ying Sun <sunying@nj.iscas.ac.cn>,
        Jesse T <mr.bossman075@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] kconfig: introduce listunknownconfig
Message-ID: <20230822061203.GA610023@google.com>
References: <20230817012007.131868-1-senozhatsky@chromium.org>
 <CAK7LNASJWKSsdzn5ccgWaC35-XvHGU7pnE6C=eZFDbqrrghtdQ@mail.gmail.com>
 <20230820024519.GK907732@google.com>
 <CAK7LNAS9KC1GjPgadMEivSpy4TMYU8mQ+BrtfJpNs2kvhK18yA@mail.gmail.com>
 <20230820072119.GM907732@google.com>
 <20230820073332.GN907732@google.com>
 <CAK7LNARTZXvWD8PrA3bC+Ok7LK85qO=pkMs4kOPGn90OBooL6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARTZXvWD8PrA3bC+Ok7LK85qO=pkMs4kOPGn90OBooL6w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/21 21:27), Masahiro Yamada wrote:
> 
> My (original) hope was to add a single switch, KCONFIG_VERBOSE, to address both:
> 
>   - A CONFIG option is hidden by unmet dependency (Ying Sun's case)
>   - A CONFIG option no longer exists  (your case)
>   - Anything else we need to be careful

A quick question: is it too late to suggest an alternative name?
Could KCONFIG_SANITY_CHECKS be a little cleaner? Because we basically
run sanity checks on the config.

And one more question: those sanity checks seem very reasonable.
Is there any reason we would not want to keep them ON by default?
And those brave souls, that do not wish for the tool to very that
the .config is sane and nothing will get downgraded/disabled, can
always set KCONFIG_SANITY_CHECKS to 0.
