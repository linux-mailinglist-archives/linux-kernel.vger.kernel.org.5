Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C299A794721
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 01:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242103AbjIFXRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 19:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbjIFXRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:17:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FBA172E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 16:17:13 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50098cc8967so495729e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 16:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694042232; x=1694647032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=amaeJ0Fab/jVgSejYsWbzXhmle5m64ntHUW0zCfkNPo=;
        b=aPEgXuqR2GjFwgfvv7+ENSWuVIlXahEdbPIOvD3wA6UqUAncEeyeKpTYSvGeqwW27g
         aHz1Ri1vsOAqEgoB3WwCMrhDpkS5JOyaPwIESMhCqIpLKxPDofQjV8iaZtIGrmhzITFF
         VxKcPbYWdnJSqKC5icqa1HEiZwR6K43DJcPLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694042232; x=1694647032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amaeJ0Fab/jVgSejYsWbzXhmle5m64ntHUW0zCfkNPo=;
        b=Q0QEfyqIm9SfHmzJM+z95CmM2zvG4+irQWWz2oqpSMPSGeM/+DToilfpGcV63E6tt4
         dsY7gF8/ip+FP0S43qOop3OPcOoLeaxclrYnRByITZIYZlhtepa+6jZHImk55UVwYFUj
         sxjBHGkmpjY9aJXV5u1DotxMK8y5/Wgm3iGDyuTR2U5E7mNzB2RKVwaKJvYLEAxw3ewg
         hp8evDRer8YJv7weE4Ow/5A/UAf8h0HYGzl4Bz1rvJKhvhagOflqIxTAW4JVYYP9hQXd
         +l0n8c7oqi+dxTv/v330LGsQWmeuuvXs2eFEDbJEABzbjRHpOZTh2T7R3HE33gB+1BWX
         KnaQ==
X-Gm-Message-State: AOJu0YyOSeJ+0LkEkj+iWxHrg60bIQvdJB9CQE3YzMJ2jnqBzkQqDqQI
        RGSZlxcBghSikx/i330nt8fLS7uaqJotLMomva/iCOsk
X-Google-Smtp-Source: AGHT+IETbXUFoURXJCzIWqwcyeSQ/z/GY3LpUAe4SXW977y7FfXU3oaTdOZaFkmQ72Nh8qPJBVoksg==
X-Received: by 2002:a05:6512:47c:b0:4fd:bdf8:930d with SMTP id x28-20020a056512047c00b004fdbdf8930dmr3513727lfd.22.1694042231815;
        Wed, 06 Sep 2023 16:17:11 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id i4-20020a170906264400b0099bcd1fa5b0sm9625961ejc.192.2023.09.06.16.17.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 16:17:10 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-31dca134c83so365333f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 16:17:10 -0700 (PDT)
X-Received: by 2002:a05:6000:1cc9:b0:31d:d977:4e3d with SMTP id
 bf9-20020a0560001cc900b0031dd9774e3dmr3263064wrb.19.1694042229754; Wed, 06
 Sep 2023 16:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
 <CAHk-=whaiVhuO7W1tb8Yb-CuUHWn7bBnJ3bM7bvcQiEQwv_WrQ@mail.gmail.com>
 <CAHk-=wi6EAPRzYttb+qnZJuzinUnH9xXy-a1Y5kvx5Qs=6xDew@mail.gmail.com> <ZPj1WuwKKnvVEZnl@kernel.org>
In-Reply-To: <ZPj1WuwKKnvVEZnl@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Sep 2023 16:16:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiy=JOAWvSLwPq-jHPBfq8EX5NjVkEoh+RUMZbVn+GuOg@mail.gmail.com>
Message-ID: <CAHk-=wiy=JOAWvSLwPq-jHPBfq8EX5NjVkEoh+RUMZbVn+GuOg@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sept 2023 at 14:55, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> > I don't think gcc ever uses less than that (ie while a six_lock_type
> > could fit in two bits, it's still going to be considered at least a
> > 8-bit value in practice).
>
> There are some cases where people stuff the enum into a bitfield, but
> no, no simple type.

Note that I am talking about the types gcc uses natively.

To show what I'm talking about, build this (silly) code that has some
of the same enum types that bcachefs has:

    #include <stdio.h>

    enum enum1 {
        val1 = 0,
        val2 = 1,
        val3 = 2,
    };

    enum enum2 {
        num1 = -1,
        num2 = 0,
        num3 = 1,
        num4 = 2,
    };

    int main(int argc, char **argv)
    {
        printf("%d %d (%zu %zu)\n",
                (enum enum1) num1,
                (enum enum1) num1 == num1,
                sizeof(enum enum1),
                sizeof(enum enum2));
        return 0;
    }

and run it. On x86 with no special options, you should get something like this:

    -1 1 (4 4)

ie both types have a four-byte size, and casting 'num1' to 'enum
enum1' will in fact give you back -1, and will then compare equal to
num1 in the end.

Because both types are in practice just 'int'.

But now do the same with -fshort-enums, and you instead get

    255 0 (1 1)

because both types are just a single byte, and casting 'num1' to 'enum
enum1' will in fact result in 255 (because it's an _unsigned_ type),
and then comparing with the original num1 value will no longer compare
equal.

(But casting it then further back to 'enum enum2' will in fact result
in -1 again, because you're effectively casting it back to 'signed
char', and then 255 and -1 are in fact the same in that type).

End result: you can get some really unexpected behavior if you cast
enums to other types.

Which is, of course, exactly why the compiler is warning about the
comparison and about passing in the wrong type of enum.

Sadly, the compiler doesn't warn about the cast, so you can hide all
of this by just adding casts. That doesn't make it *right*, of course.

              Linus
