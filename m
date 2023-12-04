Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF424804159
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjLDWKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjLDWKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:10:14 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57393D5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:10:20 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce3534bf44so1556305b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 14:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701727820; x=1702332620; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=37lLGq0t65HiQcCI/lHUkF2BBlMT4MulFisBI2pP0eQ=;
        b=YY+m3a0e+rHMlAnVpwiVrIZfhQCHWZbJgCQv2rmTk9t+DCVpIfg5C1MMwYcG/LbIFT
         C07IuUACyG0OpNlYsmJVbNK7l2H2+NbqpBBzqNlOSSdF1+U1tFsNVEU/y5JfDARzs5wi
         7dEEhsM6teLNfxli7gOgXBJDAQn9FoiYkkthI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701727820; x=1702332620;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37lLGq0t65HiQcCI/lHUkF2BBlMT4MulFisBI2pP0eQ=;
        b=qhomMUx53LMfxGh4bkmhJMNWySHGiN30gxn3CicnSqtHK9F2F80ti8Y7Ph1mAn9EHB
         3567+GPzW7IK3yrLcg1DEmnVdQjBMgg5VYN/8OBoxGQJhVORKLiJlhPWOsQBsnNXNAkP
         sgYucv21IHMMPBe5pG06OUpMcrw42UKWalrjKl2qTy9Dh8lOsp+ilRh83AltsiqT7DeC
         uOLoQic6348JtZEwcpEFaLjaHZZgKTQqUPJWlzx1WliOpQFoEOgSCPCrUUERLWjvMDPK
         FeUqu/RXeDpOpIHVZYZVhRYhJc8TxnRs4JYsxwgNwzghrdN8w5HuasSKg46fmuXCSgAc
         JI8A==
X-Gm-Message-State: AOJu0YxqQp1joYRLbBLaKuY8BFkSV9es9AS9H5bKOsT9qEKmCTUSwXQ7
        4tUxXl1Rwa4VvotDsdpl4UKpqQ==
X-Google-Smtp-Source: AGHT+IH9TOoEe2/nqRvH0ErCIbYVOAfwPd4pEfF5AYtWMfDgZvmYCqQ7ZmWzcn17sOVmBuDJHh/YTw==
X-Received: by 2002:a05:6a00:a18:b0:6cd:d67f:7cb with SMTP id p24-20020a056a000a1800b006cdd67f07cbmr276199pfh.16.1701727819715;
        Mon, 04 Dec 2023 14:10:19 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t23-20020a056a00139700b006ce53b30d66sm1985284pfg.46.2023.12.04.14.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:10:18 -0800 (PST)
Date:   Mon, 4 Dec 2023 14:10:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ronald Monthero <debug.penguin32@gmail.com>
Cc:     Anders Larsen <al@alarsen.net>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] qnx4: Avoid confusing compiler about buffer
 lengths
Message-ID: <202312041410.708A1416AD@keescook>
References: <20231130205010.it.412-kees@kernel.org>
 <CALk6UxrWjHAfUXQZF4UcA-iwW92gpmfc41LBETC5_wDXn4zWww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALk6UxrWjHAfUXQZF4UcA-iwW92gpmfc41LBETC5_wDXn4zWww@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 01:46:27AM +1000, Ronald Monthero wrote:
> Cheers Kees,
> BR,
> ronald

Is this a "Tested-by"? :)

-Kees

> 
> 
> On Fri, Dec 1, 2023 at 6:51 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Hi,
> >
> > This attempts to fix the issue Ronald Monthero found[1]. Avoids using a
> > too-short struct buffer when reading the string, by using the existing
> > struct union.
> >
> > -Kees
> >
> > [1] https://lore.kernel.org/lkml/20231112095353.579855-1-debug.penguin32@gmail.com/
> >
> > v2:
> >  - Use BUILD_BUG_ON() instead of _Static_assert()
> > v1: https://lore.kernel.org/all/20231118032638.work.955-kees@kernel.org/
> >
> > Kees Cook (2):
> >   qnx4: Extract dir entry filename processing into helper
> >   qnx4: Use get_directory_fname() in qnx4_match()
> >
> >  fs/qnx4/dir.c   | 52 ++++++------------------------------------
> >  fs/qnx4/namei.c | 29 +++++++++---------------
> >  fs/qnx4/qnx4.h  | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 78 insertions(+), 63 deletions(-)
> >
> > --
> > 2.34.1
> >

-- 
Kees Cook
