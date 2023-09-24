Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B467ACAD5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 18:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjIXQ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 12:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXQ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 12:58:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC59FC;
        Sun, 24 Sep 2023 09:58:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c93638322so1166443166b.1;
        Sun, 24 Sep 2023 09:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695574714; x=1696179514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XW+n8l4tbJu47AKEn2z/gzBzCsxjR0qfp5ki1h8zQs=;
        b=HUqmdfzwZuuAP5NHCaPM55mMyYBlNZyr0WP+t8f4T/ta7sZRaasyCU61wJKu9anNUb
         iTM+q0+kaq//kUVHaJjde8D5sFsUKUue+OoGj9Ek4HiUGsF+T/oudOOyTfPhR3hJz2+J
         6YfoMQzJ5cWq8mrmurxAsZfdUmQh51imy2sh7MEPDpLjSwMn61mbZK6OQ0M6Rvc2lbJH
         78nbS4KjGlcvVBXYS6H7q0PYs2aiR6sVex2y3ovfUKEkSHxnIVZpdy13y8vQirb4qnch
         dQLS+vAkJ2zDmtkFIWt9Nl7grTHtRgETQEcvprwcQZTv3ymtTFAgKFzvUaYcHaI8IxSj
         Ybpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695574714; x=1696179514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XW+n8l4tbJu47AKEn2z/gzBzCsxjR0qfp5ki1h8zQs=;
        b=lF8z2DrvsyAXxwca17l12NzIcqm63JHQzsHiJhrwvbKsmQLNG0ihoQkTzLkhaHI9Cg
         0lBwx9DCcNdR9h/VdTyWe+205BjAfKkn+4KEmh0zVhTqMw74ZCNp36UTFyT0GMTgkMeZ
         ZP8iKCKvOgdhv3+V7wxA+nukXwISVyAVuGIhO1O11sAu8JZbVEbk0fz5cjHQWHK26Yl8
         P7zqP9Ja6+xDKK3Gwekcn/kM1aLkxu0SvAyxuKhwzQMJXEy/qe54ynnnPIbmDP1UTfdP
         vNB2QgLwqiOpizW+u1EkzcrLDgeLVxlfJ6SR6EogWxoWFRB8mY3rhtHVFsLt2IvI/qJl
         P8xw==
X-Gm-Message-State: AOJu0Yx7395qf9nDV5+XrUZdSd0Ko2dZBRU8oCuJM0NQqyj9VarH6g9x
        4oRpRcBPF8x/vmEw4fzpEQ==
X-Google-Smtp-Source: AGHT+IEWYIU9wTSQiOE1m07Ej4FE0FiTCYRcI4DAMXUkgMLmZ5nj+9sRo1y2sL5IFLuY3K9R2mG6tw==
X-Received: by 2002:a17:906:8a75:b0:9a5:cc2b:50e5 with SMTP id hy21-20020a1709068a7500b009a5cc2b50e5mr6327566ejc.32.1695574713937;
        Sun, 24 Sep 2023 09:58:33 -0700 (PDT)
Received: from p183 ([46.53.250.251])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099df2ddfc37sm5217076ejc.165.2023.09.24.09.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 09:58:33 -0700 (PDT)
Date:   Sun, 24 Sep 2023 19:58:31 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] hardening fixes for v6.6-rc3
Message-ID: <88707e12-dba9-4a9f-95d7-8d6f3c8f0f58@p183>
References: <202309220957.927ADC0586@keescook>
 <CAHk-=wg0C+eEm0Tegpvc1zZjcqkdG9L0ed10tg_rQ1-WZciMGA@mail.gmail.com>
 <202309222034.F2B777F55@keescook>
 <CAHk-=whf6Zu3Cfm1eOTxXniZf5EPaf1iLj_q_6BVHrzTUBfUGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whf6Zu3Cfm1eOTxXniZf5EPaf1iLj_q_6BVHrzTUBfUGw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 11:04:57AM -0700, Linus Torvalds wrote:
> On Fri, 22 Sept 2023 at 20:49, Kees Cook <keescook@chromium.org> wrote:
> >
> > 2) __cplusplus is relatively common in UAPI headers already:
> >    $ git grep __cplusplus -- include/uapi | wc -l
> >    58
> 
> Look a bit closer.
> 
> Most of those - by far - is for the usual
> 
>   #if defined(__cplusplus)
>   extern "C" {
>   #endif
> 
> pattern. IOW, it's explicitly not different code, but telling the C++
> compiler that "this is C code".
> 
> So this new #ifdef is an ugly new pattern of "do totally different
> things for C++".
> 
> Apparently required, but very ugly nonetheless.

Most of those in uapi/ are likely unnecessary: extern "C" means
"don't mangle", but kernel doesn't export functions to userspace
except vDSO so there is nothing to mangle in the first place.
