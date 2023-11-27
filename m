Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0CB7F9BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjK0I3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjK0I3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:29:53 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9E5D6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:30:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-332e42469f0so2441255f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701073798; x=1701678598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2CdZagPBNXqbD/b1Zs1TWZBKxImZV6/P7uarWOkiV20=;
        b=xMae0OGarg23UsAdbLH5y+CDMD0rquxSioFprZC/RurORG+2uUwKnYXh0zNrNi5Tyg
         DKlZo2BYuVphBisaRSf+8nWH3YD+W2Tz4GHIEW3+n6mneCwZeGScD9qY/0F6BDEPbRH6
         j3eRuVmvo4j/WCvVVdr+Yaay//4jJY02DM6maN+QM2DxZysjZuGF68J3Zh6kX7WVDYc6
         2ZPOY19UVir3PGQ4edq1isdYeRBfmPdIZjJCNbzJ74ubm2GWHgcPJ/ulACux+xFry37r
         +PwCfztGKM4vWLmx9l8+5/9tRqBONaT+RjC08HOKx19MBnjMZSmBa1NmrdaMBPhnL1kz
         kuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701073798; x=1701678598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CdZagPBNXqbD/b1Zs1TWZBKxImZV6/P7uarWOkiV20=;
        b=GT5/k/k8lcIo/GO5JhQj9Mgy/GrnmA7CUBg3ekdWm4868JxbaqbJ05Bz+Pxuhtp/jl
         fHtox6GXZwTnOjIBX0dxLVPPawl9kW3gHMKEoZeq5zdLBxIat4ZzrXn5UpXgxFHiCr2H
         1WXJ803mX9bWBs6ghGuXMc7nh2a24EUN1oAktQhESH8YZMFg0q79MV405zzCCk/do/gs
         eAMGfyAg1vv/OzmwwNn8gcPv9C2pjCvvWJ+sXIUUxCduW69iQIiNqJ/Dc/4sYZE5W7pJ
         LlskAKh1cpTqhZArFrX2GCZiAGgZjLAD12TOpzHzG1P5ThQzqRppSl9q7v6vV0xJuVhS
         V+kw==
X-Gm-Message-State: AOJu0Yw/lPVuxF5i452cfrEOiHSIkCHFiQARIy6GLAMkfOVG8iD+6/St
        5T3i1H1K2N5X1ocQ8zQOOrZ2NQ==
X-Google-Smtp-Source: AGHT+IHwm8g6hZ3Vl9KSBq7O269APfEEEnP5IbVc0hpRh7KvLTRgo5PytufR1YXdZhec67eFvPpDng==
X-Received: by 2002:adf:f48d:0:b0:332:e4cc:6a38 with SMTP id l13-20020adff48d000000b00332e4cc6a38mr6966002wro.57.1701073798517;
        Mon, 27 Nov 2023 00:29:58 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o10-20020adfcf0a000000b00332cda91c85sm11225013wrj.12.2023.11.27.00.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 00:29:58 -0800 (PST)
Date:   Mon, 27 Nov 2023 11:29:55 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Peter Rosin <peda@axentia.se>, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] mux: Turn 'mux' into a flexible array in 'struct
 mux_chip'
Message-ID: <19d7ddce-f911-481e-ac89-bc942e40fbe1@suswa.mountain>
References: <d17bd9b622dbe3f7cb2f18736ef3138a6927f86c.1700986053.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d17bd9b622dbe3f7cb2f18736ef3138a6927f86c.1700986053.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 09:08:11AM +0100, Christophe JAILLET wrote:
> The 'mux' array stored in 'struct mux_chip' can be changed into a flexible
> array.
> 
> This saves:
>    - a pointer in the structure
>    - an indirection when accessing the array
>    - some pointer arithmetic when computing and storing the address in
>      'mux'
> 
> It is also now possible to use __counted_by() and struct_size() for
> additional safety.
> 
> The address for the 'priv' memory is computed with mux_chip_priv(). It
> should work as good with a flexible array.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The struct_size() goodies only work if sizeof_priv is 0. Adding an
> additional size_add() would make it safe in all cases but would make code
> less readable (IMHO).

Once people start using size_add() then we'll get used to reading it.

The controllers value comes from device tree.  For example, in
mux_mmio_probe().

	ret = of_property_count_u32_elems(np, "mux-reg-masks");

I should make Smatch parse device trees.  So that it will know the
correct range for ret in that assignment.  Eventually, I will.

KTODO: make Smatch understand device tree values

regards,
dan carpenter

