Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E9C7CA26A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjJPItf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjJPItd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:49:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636E2ED
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:49:31 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4066692ad35so43661155e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697446170; x=1698050970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ujCqCEnI5nPLWrZA65nA5QR8pdmJeCeOuXdZT+k04+A=;
        b=ahrRJHkLj8hx3A7ai2xF3b9O8BFNk69lJPGddz/DCwNaitv2vaSsD7xodaWIMtII+o
         db/1pbXgriPD3cimTkrMISDu5CbrmjwMA5rKxBA9zVch6MejxvWv7al6AkO/VpEpxC71
         M+qwSp5I84p3CL5+183AHA3D7502QI2PYI2X5s/thtdKUL2mPC+IcuUHJ7uR6iQuHzuP
         I1Mg8MPPEiRS6tb9Jt+gTE+lyGxhbNNM3Ii3y1ay8rC2ZI2Rc/TpGhyNZa7T47Yjylqa
         jZJfU11oy7UjqjUzBPyYdG+RV3nxRKFv8kq4IJUE3CKAK0EX7y4VeBX3qGE+SHnqY0Gc
         oXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697446170; x=1698050970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujCqCEnI5nPLWrZA65nA5QR8pdmJeCeOuXdZT+k04+A=;
        b=ty47HLSFaQJB4BY5a7SGLvbT74LYOI2EXz4y+K8doEL+qX/ZgfE+TSymLSY9PST8I0
         x/iXh9ySjzD+NygZOlRGjXkxWeYaXBQFEpZCAiSz3qD6zbXWa0iS2pISKWp5KGkIL2fe
         VYQ9DonXiDzfAO532cgDjlgMHiYzA3U42T1uHXd/csm7KgYC1fpdCPRrOWEEmhdZ6sJH
         09xaYVxAZc/Nls1YT0PHp5NErPZdIUktOJ/sC8V6+H9huTARvlEIhUVaiGLUjFGcgPgL
         9o50XETwLXSMCDtvWjyGOMz/wche9ihYqhf6dRemjCoraB9ZYO5JZgnQ0xePwaoUn7C0
         dQmg==
X-Gm-Message-State: AOJu0YxSzvrpaY617/YfDgo/opWsK+M7w47MxWs+FbagaajWL8fDwpgi
        swaP18jwnfCnbISCOGXrYOR4Hg==
X-Google-Smtp-Source: AGHT+IGgUt1nPmDmQRaC/qE2VLEoX7W1KZWueCCuBdU27TAIwCfFYjI3OgeCWLSt7fypjC0c6jtjPA==
X-Received: by 2002:a05:600c:259:b0:401:b204:3b8d with SMTP id 25-20020a05600c025900b00401b2043b8dmr30832997wmj.27.1697446169764;
        Mon, 16 Oct 2023 01:49:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bi13-20020a05600c3d8d00b00402ff8d6086sm6475160wmb.18.2023.10.16.01.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 01:49:29 -0700 (PDT)
Date:   Mon, 16 Oct 2023 11:49:24 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     gustavo@embeddedor.com, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: replace strncpy() with strscpy()
Message-ID: <83dbf2b1-9bd3-45bd-bd92-18af505c4d2e@kadam.mountain>
References: <ZSzapU+eKWvHVwxi@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSzapU+eKWvHVwxi@lab-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 09:39:33AM +0300, Calvince Otieno wrote:
> Checkpatch suggests the use of strscpy() instead of strncpy().
> The advantages are that it always adds a NUL terminator and it prevents
> a read overflow if the src string is not properly terminated. One
> potential disadvantage is that it doesn't zero pad the string like
> strncpy() does.
> In this code, strscpy() and strncpy() are equivalent and it does not
> affect runtime behavior. The string is zeroed on the line before
> using memset(). The resulting string was always NUL terminated and
> PRISM2_USB_FWFILE is string literal "prism2_ru.fw" so it's NUL
> terminated.
> However, even though using strscpy() does not fix any bugs, it's
> still nicer and makes checkpatch happy.
> 
> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> ---
> Previous Patch Versions:
>  - Earlier patch versions had issues with whitespace, preventing correct
>  application. This is a reroll of those previous versions.
> 
>  - Versions v2 through v6 focused on improving the clarity of the commit
>  message. There were no code changes in these patch versions.

You forgot to put v6 in the subject...  But it looks okay now.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

