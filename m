Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42E67B063C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjI0OJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjI0OJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:09:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B11F9;
        Wed, 27 Sep 2023 07:09:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5db4925f9so82585775ad.1;
        Wed, 27 Sep 2023 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695823752; x=1696428552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=siO7gpUQ8YClYi2HR3I26xxjgY32txOYwCoi5ofDplA=;
        b=iseeR/drDiVW8nfGwH+34FbFkQK25/UQ4nLAVNtmaH8kl36X6U7496/DaiKu0pYXy3
         pZQoaNZM4BHhX9x+i7QN1puzwZaJZEvaC6y5iyjWVWGZ9EbUJVlkugFqaUfT2ugzAeAN
         du9II/hMiXEUSmapOPpQeHPXTaGehD6tnfRyQ7qAfz/cPOKXSZXfkWZhAWR29O4R+QbF
         SzCTwr3ZNkzaQb7sZxrc2lTfFfLlyNtKBhmKLM2fsPugphQZRImc8Nn0Jcy0OgFIrTml
         YbTVE022jMdLEVL6kMwGciupDoNNb2b948ZiENziJe5tzRhAL2hNe4CVlsFHghPeoz9e
         wE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695823752; x=1696428552;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=siO7gpUQ8YClYi2HR3I26xxjgY32txOYwCoi5ofDplA=;
        b=iwyWWpk3VCM1hLFbHwdyLP++vBg/LjZpBV5jMLlEic02G+d70ra2ORf5e9mewZzB1s
         XpXaXZHxlRBXCCBT5vuyw14o8i7IrxzFYA3SIHJwkVWEHckzzO+GE4ISet2FD5u2Qckv
         fxXKdKrIBD8CUmwS/RATodiNa4GGr/FPJCpy/a2ngtcuT5hy9nNpe80X+XxT4kjKDdyw
         0v6a23tPrLX5R7GWC+YekpEAecI9xyf594rSnNtxtkHOc/TREai79PZu0ogr+GFhrLwL
         TeLYaSIJWTlvo6M+9DkErCy5RkMYN2pbYdSz00MY/KPV21jq58Q7TSrDFHF6WYxWzTg+
         f4ZA==
X-Gm-Message-State: AOJu0Yx4V7vGvjvX+YuNlITHuWxu7LA+sa/i/BAPHSHWl9XyNzBhz60w
        1gQD0YDFXIFBxFa4IKpitzzhZtqqvEw=
X-Google-Smtp-Source: AGHT+IHs0ZnY0Cz+CIYQt2l3hUxZzPdc2tPZKR3Ck17AzWhAMlCsWwLj0uW6fSJsAPG6XLuVgWMmZA==
X-Received: by 2002:a17:903:2309:b0:1b4:5699:aac1 with SMTP id d9-20020a170903230900b001b45699aac1mr3407241plh.12.1695823751628;
        Wed, 27 Sep 2023 07:09:11 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902dac300b001b9c5e07bc3sm13233988plx.238.2023.09.27.07.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 07:09:10 -0700 (PDT)
Message-ID: <d976a572-0865-af16-333b-2bdea3e6c6c2@gmail.com>
Date:   Wed, 27 Sep 2023 23:09:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs/sphinx: Explicitly convert Sphinx paths to str
To:     Oliver Faso <erer1243@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20230910040811.53046-1-erer1243@gmail.com>
Content-Language: en-US
In-Reply-To: <20230910040811.53046-1-erer1243@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 10 Sep 2023 00:08:06 -0400, Oliver Faso wrote:
> Sphinx 7.2+ is switching to using pathlib.Path
> instead of str to represent paths. This fixes the
> current deprecation warnings and eventual breakage.
> This conversion will be a no-op when using older
> Sphinx versions.
> 
> Signed-off-by: Oliver Faso <erer1243@gmail.com>

Belatedly tested against Sphinx versions 2.4.5, 4.2.0, 5.3.0,
and 7.2.6 (latest).

Tested-by: Akira Yokosawa <akiyks@gmail.com>

HTH, Akira

> ---
>  Documentation/sphinx/kerneldoc.py | 2 +-
>  Documentation/sphinx/kfigure.py   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
> index 9395892c7ba3..d26155990ec3 100644
> --- a/Documentation/sphinx/kerneldoc.py
> +++ b/Documentation/sphinx/kerneldoc.py
> @@ -138,7 +138,7 @@ class KernelDocDirective(Directive):
>                      lineoffset = int(match.group(1)) - 1
>                      # we must eat our comments since the upset the markup
>                  else:
> -                    doc = env.srcdir + "/" + env.docname + ":" + str(self.lineno)
> +                    doc = str(env.srcdir) + "/" + env.docname + ":" + str(self.lineno)
>                      result.append(line, doc + ": " + filename, lineoffset)
>                      lineoffset += 1
>  
> diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
> index cefdbb7e7523..13e885bbd499 100644
> --- a/Documentation/sphinx/kfigure.py
> +++ b/Documentation/sphinx/kfigure.py
> @@ -309,7 +309,7 @@ def convert_image(img_node, translator, src_fname=None):
>      if dst_fname:
>          # the builder needs not to copy one more time, so pop it if exists.
>          translator.builder.images.pop(img_node['uri'], None)
> -        _name = dst_fname[len(translator.builder.outdir) + 1:]
> +        _name = dst_fname[len(str(translator.builder.outdir)) + 1:]
>  
>          if isNewer(dst_fname, src_fname):
>              kernellog.verbose(app,
> -- 
> 2.42.0
> 
