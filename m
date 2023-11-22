Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2A47F5202
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjKVVE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVVE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:04:26 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA15898
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:04:22 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-548db776f6cso510a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700687061; x=1701291861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mINXLXrq9/oLpdA6Yk/sy1UPcvyskcwNgTwzkZ9kBzs=;
        b=J+TAF2QvDW3tT3S/KbM5WIA5UU9ZgLW5iQGHLxF4J5F1x6f754B9ezoqHNp/Fly6/n
         6hGqdg+URMLDZMEaL6u3ogItVvNfbxQIrF4diW/kUN9+n5xBBBQ9ru9n3K5PVL6xtGwa
         OkyvjSNxvG9AcrcADjJrS7gZK52BJz2aDG3hnBz0f6dafGIVIipgOSbkqJTID015QBzM
         1YPQKEAhqYl4F0OaBukGlGjeUArlneb0HAJLKBNUNnLjtpMxeMRnj7S3A6O7Lx7ZiUcl
         Gux2U7WCJjhEdv5etZDzgmBFL2BdfuEkshalGei3QH+R5WCPiWbL5VfqOhifYuJJxbs+
         9Aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687061; x=1701291861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mINXLXrq9/oLpdA6Yk/sy1UPcvyskcwNgTwzkZ9kBzs=;
        b=WfIW8iR4U0h5RXML3R8VTOrWNqIMp/aVemNf9nCNVTw7+TIya4ZMN82vreudlJECmO
         sVU8M9kRoWvi4Yooez4dy+gHv5iR7JRRWf52wuTjegOGYHUrrkWmlrlXMzLnbr/AO6PY
         slF7mz6n9WeYntlnEioQ9pmlSPiW5nPKwZQKg3PoH21mKdI9VO0c+ow/uQT5+poi5M43
         fiRNzODZUQIrB+R6kgzaq7aMUfHVloC4KdhkudTpSJkSv2r/WHt1BkFyN5zRNeIw8uwl
         vsDGni+rFHMsJDO/Kl00LRnOieP2wWhn7Uasu3LLwkofQO0NKM74gYSZW1j/Av4EFVp0
         bEPw==
X-Gm-Message-State: AOJu0YxEy/QHAEP6ciqLkYsYYIiXVRdzN9XGk0TPhXh7Il7b/rXlUFun
        3NVWsjelV4zJm95ZD+c4SnjikOik3Rdpt5x00HPSKQ==
X-Google-Smtp-Source: AGHT+IEGm9MLKZeGbPnej8xX4u8eiSlbh1Mqb8POBm36fW5cFOc334Fc5wDrn2GxrY0UsMNCzK9qE0nvCl+hpFusPUw=
X-Received: by 2002:a05:6402:d67:b0:548:c1b1:96b2 with SMTP id
 ec39-20020a0564020d6700b00548c1b196b2mr225540edb.6.1700687061263; Wed, 22 Nov
 2023 13:04:21 -0800 (PST)
MIME-Version: 1.0
References: <20231118025748.2778044-1-mmaurer@google.com> <CAK7LNAQt8fy5+vSwpd1aXfzjzeZ5hiyW7EW9SW7pbG2eTJZAOA@mail.gmail.com>
In-Reply-To: <CAK7LNAQt8fy5+vSwpd1aXfzjzeZ5hiyW7EW9SW7pbG2eTJZAOA@mail.gmail.com>
From:   Matthew Maurer <mmaurer@google.com>
Date:   Wed, 22 Nov 2023 13:04:09 -0800
Message-ID: <CAGSQo00hyCTVsqHtrzKBBPvuH38z5yRm_4jzdi00C0RV+8APwQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] MODVERSIONS + RUST Redux
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
        rust-for-linux@vger.kernel.org, Laura Abbott <laura@labbott.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So, even if you enable CONFIG_MODVERSIONS,
> nothing is checked for Rust.
> Genksyms computes a CRC from "int foo", and
> the module subsystem confirms it is a "int"
> variable.
>
> We know this check always succeeds.
>
> Why is this useful?
The reason this is immediately useful is that it allows us to have Rust
in use with a kernel where C modules are able to benefit from MODVERSIONS
checking. The check would effectively be a no-op for now, as you have correctly
determined, but we could refine it to make it more restrictive later.
Since the
existing C approach errs on the side of "it could work" rather than "it will
work", I thought being more permissive was the correct initial solution.

If we want to err on the other side (modversions passes, so we're pretty sure
it will work), I could add to the last patch support for using .rmeta files as
the CRC source for Rust symbols. This would essentially say that the interface
for the entire compilation unit has to stay the same rather than just that one
function. We could potentially loosen this requirement in the future.

With regards to future directions that likely won't work for loosening it:
Unfortunately, the .rmeta format itself is not stable, so I wouldn't want to
teach genksyms to open it up and split out the pieces for specific functions.
Extending genksyms to parse Rust would also not solve the situation -
layouts are allowed to differ across compiler versions or even (in rare
cases) seemingly unrelated code changes.

Future directions that might work for loosening it:
* Generating crcs from debuginfo + compiler + flags
* Adding a feature to the rust compiler to dump this information. This
is likely to
  get pushback because Rust's current stance is that there is no ability to load
  object code built against a different library.

Would setting up Rust symbols so that they have a crc built out of .rmeta be
sufficient for you to consider this useful? If not, can you help me understand
what level of precision would be required?
