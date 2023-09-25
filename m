Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86DB7AD7B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjIYMIW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 08:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjIYMIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:08:06 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82CCE58
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:07:21 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59f82ad1e09so14280197b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695643640; x=1696248440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFBEfegJ3qKvlKJFWO80BnWRWZIHZ0dmFMA8YWuzIyA=;
        b=FCbhKAxQrN02QyiOFLTnO9RM8/7UvQso8HYPa+HXrw+MJwaZHXmE3BwQXgG5NVYBkW
         VC7+TJB9LN3LZuu8RVmiCK26MFBuPYHMjF96DxjJFSlyfJHB5hzxqhme22JGgyYT5veW
         Et9GSweCIQDUyJ9j/vFDsT6bm3GOmSvRndxGd/byrHhqsGTq85Pb096STqGTxMu5Bz9n
         jT7yKqwiaAb59gP3N2QEE7h4RD2mqvrVhFNQwBcNzWKVu0fDqYJ0NetTz3mfYm6NppxJ
         2GmDFotVglruzBhiFAm6HpDjwHI7Mud4h9nFbFmlcFxYdg+AahVrl2CLJvIdTUWvmRI/
         payQ==
X-Gm-Message-State: AOJu0Yz2EGOmRupe2ri2FxmGzeigaHqqDSD6P7g2DRn6vw8K9axYe0uX
        KQ4w8fDzwfne1FMolDKns462CofaPFWSWA==
X-Google-Smtp-Source: AGHT+IFd1aAKSfFydD5AS54DFcm3PUqFv3MxyZUvOoEr2mZ14fRo9ogv831m8YyefncMKfOpTb0GGA==
X-Received: by 2002:a0d:f5c4:0:b0:599:8bd:5bdf with SMTP id e187-20020a0df5c4000000b0059908bd5bdfmr6025409ywf.50.1695643640598;
        Mon, 25 Sep 2023 05:07:20 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id a184-20020a0df1c1000000b00577269ba9e9sm2352319ywf.86.2023.09.25.05.07.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 05:07:20 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d8181087dc9so6811207276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:07:20 -0700 (PDT)
X-Received: by 2002:a25:ce53:0:b0:d77:8fd3:36e with SMTP id
 x80-20020a25ce53000000b00d778fd3036emr6855294ybe.20.1695643639909; Mon, 25
 Sep 2023 05:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <202309222350.hCUFrIQ1-lkp@intel.com>
In-Reply-To: <202309222350.hCUFrIQ1-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Sep 2023 14:07:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUn1n47=nV_WMe9Yx1aTzYgsDKoj_AuZUPoAH7gJpCuGw@mail.gmail.com>
Message-ID: <CAMuHMdUn1n47=nV_WMe9Yx1aTzYgsDKoj_AuZUPoAH7gJpCuGw@mail.gmail.com>
Subject: Re: {standard input}:1198: Error: value of ffffff6c too large for
 field of 1 byte at 00000533
To:     kernel test robot <lkp@intel.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear robot,

On Fri, Sep 22, 2023 at 5:23 PM kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   27bbf45eae9ca98877a2d52a92a188147cd61b07
> commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
> date:   9 weeks ago
> config: m68k-randconfig-r025-20230123 (https://download.01.org/0day-ci/archive/20230922/202309222350.hCUFrIQ1-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230922/202309222350.hCUFrIQ1-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309222350.hCUFrIQ1-lkp@intel.com/

Thanks for your report!

> All errors (new ones prefixed by >>):
>
>    {standard input}: Assembler messages:
>    {standard input}:1198: Error: value -148 out of range
> >> {standard input}:1198: Error: value of ffffff6c too large for field of 1 byte at 00000533

Do you have more context (e.g. which source file is being compiled)?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
