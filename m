Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3423B7801E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356249AbjHQXrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356327AbjHQXrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:47:21 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3789E3A91
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:46:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68874269df4so302989b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692315942; x=1692920742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5uC2JcHE9JS0c402i8ZIWy7dsF1n8BGwS1laDcefLsA=;
        b=O+1WPWEnTzQpTY+DGfPtB1ZW78qPJcUhAtsz1fyoeSxwO0YBhezQhhZV4OrVMgoXna
         /8U+/142TfXbfoDOXk7pdGwHMVRtbmkLk5NibSM3+ta3pI4Ip42jHoyuhhc331Pe8Sfa
         KtkJ2TLRvCcTwfLTi3fSl7+HhNc9onncFRl6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692315942; x=1692920742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uC2JcHE9JS0c402i8ZIWy7dsF1n8BGwS1laDcefLsA=;
        b=Z/wyucf3cspgNaR7V7CbG3NPTo4bsnk5fmH7iGWRbl3OJrmm/TFkA1oHUJymO1uzmf
         IgmyyUlFShuVSEh2VIRbWQrLfgwtiHvI6ZOB6kDTnqvDKRBh5QOVI5eyaG5hZ3NpzVvz
         mMD0wUand9o7paXudBbs7F6KSXeofNXwvP2tR2zOcmXS1QgYK6UNjw9NOPYiC9abge+P
         LXIy/pMaBTydHOVcjkXS61D+wuJOi7lk5v5JDRmWeeS4nZAKUZpHyIokjOfzpfBhsq5z
         zKrLsjg8J5r1UE4Qs9R/DDmku2NYs8HNzLATqt3dRCR4bBsG3pPizfG3tdH6TyYM6tzi
         zMjg==
X-Gm-Message-State: AOJu0YyDKNQ64kv54fDXYGmc4DtkO8MphoniFSPt8ObyQk+gA9HzLPPw
        J2NfHoTBCrbWO75136LKeHdyxg==
X-Google-Smtp-Source: AGHT+IHe89dMi3ZUn4C0h1cSLBafpmTmzM1zOOlc+5Q1brzsHi0/qSgClzIWnusxY0Snmv6vLwisjA==
X-Received: by 2002:a05:6a20:4a28:b0:13d:ea25:9656 with SMTP id fr40-20020a056a204a2800b0013dea259656mr944606pzb.60.1692315941870;
        Thu, 17 Aug 2023 16:45:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a20-20020aa78654000000b00689f8dc26c2sm299020pfo.133.2023.08.17.16.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:45:41 -0700 (PDT)
Date:   Thu, 17 Aug 2023 16:45:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Compiler Attributes: counted_by: Adjust name and
 identifier expansion
Message-ID: <202308171644.156176C@keescook>
References: <20230817200558.never.077-kees@kernel.org>
 <CANiq72=-DL0NV0zJrrzLmK77e6FALSupH4N-i-vfg8WrZdPDcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=-DL0NV0zJrrzLmK77e6FALSupH4N-i-vfg8WrZdPDcQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 12:06:15AM +0200, Miguel Ojeda wrote:
> On Thu, Aug 17, 2023 at 10:06 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > GCC and Clang's current RFCs name this attribute "counted_by", and have
> > moved away from using a string for the member name. Update the kernel's
> > macros to match. Additionally provide a UAPI no-op macro for UAPI structs
> > that will gain annotations.
> >
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Fixes: dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Looks good to me, thanks. Perhaps we should split the UAPI bit into a
> second patch.

I'd like to keep the UAPI part -- that was an oversight when I first
added it.

> I can take it into my tree; otherwise if you need this elsewhere:
> 
>     Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks! It'd be slightly easier for me if it was is my tree, so I'll
grab your Ack. :) Let me know if you'd prefer it otherwise.

-Kees

-- 
Kees Cook
