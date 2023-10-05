Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56287BAED9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjJEWge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjJEWga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:36:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE35DB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:36:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c5bf7871dcso12697315ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 15:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696545389; x=1697150189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i/b9hklvRBoRTstYlGluSwicXQ/mlPMQJmwe6lDAUVA=;
        b=hebOhCTkv1KhysnfJ+tbzWfuRopHgJvp6zzNJhHoCx3DLUyA2vR10bYPwP5FWd7Tve
         FrBuiXaKhpN107so5pWbiEt9Gpq5bE9u/zpVzvqzm4o/1QZxYrG8ZaKfjIbuS5JXOwdd
         yuVDTeAidj2WMqdMC9Ecg0ec5ABKHFJrOOFxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696545389; x=1697150189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/b9hklvRBoRTstYlGluSwicXQ/mlPMQJmwe6lDAUVA=;
        b=SfwG6pPRju/Xm7GCF2i4JGXV5u3OAIWaWGCvBhWQrHOLYJnzHcAd9czzCMVghEHdKw
         o20gqrU37nxDgGEjNYR9QlVOIP7wPJJFjJ2Xi9ciZIL7HeoXXrQw7SGAISQ6f+W+vW6O
         zuw3kvBKR1G+XZIMUTvGGBOBU5S1rUo6Aw0+vu0swzGAiqkuptY33J0HnPQxVxc/XuBz
         GpISiXWhYm0HNPY3mN7JzsNscQ2OZbvxLnqjFOooWNBdNwHzltFMTpqXDEGqTFBFp0C1
         lB2TUQFLrLb8oMYuCwUj0JPYQo4YqRluL4Pyb2CLAwyrQpXzIbBuOKwiml+NOBsa1WkK
         7Ing==
X-Gm-Message-State: AOJu0YzxBz44MeTpFK9bggTdrr3p4yhuTTzYWm7NJalPNy/xHdbMVpaT
        5a4HmeMI2jmTSQV/aDV9t/loOg==
X-Google-Smtp-Source: AGHT+IHks10yDYEfCTUn0LTjg6G11Q867vQ86Z3yTk/vFhiVyJ6GELi4GUrsYZLPbuQ7Vkt963dGUA==
X-Received: by 2002:a17:902:c3d1:b0:1c5:6f4d:d6cc with SMTP id j17-20020a170902c3d100b001c56f4dd6ccmr5622471plj.22.1696545388810;
        Thu, 05 Oct 2023 15:36:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001c60a2b5c61sm2269196plr.134.2023.10.05.15.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 15:36:28 -0700 (PDT)
Date:   Thu, 5 Oct 2023 15:36:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] get_maintainer: add --keywords-in-file option
Message-ID: <202310051535.D3F6A925@keescook>
References: <01fe46f0c58aa8baf92156ae2bdccfb2bf0cb48e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fe46f0c58aa8baf92156ae2bdccfb2bf0cb48e.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 02:35:17PM -0700, Joe Perches wrote:
> There were some recent attempts [1] [2] to make the K: field less noisy
> and its behavior more obvious. Ultimately, a shift in the default
> behavior and an associated command line flag is the best choice.
> 
> Currently, K: will match keywords found in both patches and files.
> 
> Matching content from entire files is (while documented) not obvious
> behavior and is usually not wanted by maintainers.
> 
> Now only patch content will be matched against unless --keywords-in-file
> is also provided as an argument to get_maintainer.
> 
> Add the actual keyword matched to the role or rolestats as well.
> 
> For instance given the diff below that removes clang:
> 
>    diff --git a/drivers/hid/bpf/entrypoints/README b/drivers/hid/bpf/entrypoints/README
>    index 147e0d41509f..f88eb19e8ef2 100644
>    --- a/drivers/hid/bpf/entrypoints/README
>    +++ b/drivers/hid/bpf/entrypoints/README
>    @@ -1,4 +1,4 @@
>     WARNING:
>     If you change "entrypoints.bpf.c" do "make -j" in this directory to rebuild "entrypoints.skel.h".
>    -Make sure to have clang 10 installed.
>    +Make sure to have 10 installed.
>     See Documentation/bpf/bpf_devel_QA.rst
> 
> The new role/rolestats output includes ":Keyword:\b(?i:clang|llvm)\b"
> 
> $ git diff drivers/hid/bpf/entrypoints/README | .scripts/get_maintainer.pl
> Jiri Kosina <jikos@kernel.org> (maintainer:HID CORE LAYER,commit_signer:1/1=100%)
> Benjamin Tissoires <benjamin.tissoires@redhat.com> (maintainer:HID CORE LAYER,commit_signer:1/1=100%,authored:1/1=100%,added_lines:4/4=100%)
> Nathan Chancellor <nathan@kernel.org> (supporter:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
> Nick Desaulniers <ndesaulniers@google.com> (supporter:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
> Tom Rix <trix@redhat.com> (reviewer:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:1/1=100%)
> linux-input@vger.kernel.org (open list:HID CORE LAYER)
> linux-kernel@vger.kernel.org (open list)
> llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
> 
> Link: https://lore.kernel.org/r/20231004-get_maintainer_change_k-v1-1-ac7ced18306a@google.com
> Link: https://lore.kernel.org/all/20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com
> Link: https://lore.kernel.org/all/3dca40b677dd2fef979a5a581a2db91df2c21801.camel@perches.com
> Original-patch-by: Justin Stitt <justinstitt@google.com>
> Signed-off-by: Joe Perches <joe@perches.com>

Thank you! This will make things nicer. :)

-Kees

-- 
Kees Cook
