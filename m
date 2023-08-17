Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B30F7800CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355638AbjHQWHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355710AbjHQWHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:07:32 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069ED3A94;
        Thu, 17 Aug 2023 15:06:55 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d72fca0043aso311447276.1;
        Thu, 17 Aug 2023 15:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692309986; x=1692914786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEagVrEGDeFW5SN5vPpOPc2eA1RFxeNwNkE6U0C7DwA=;
        b=jb/BfzOiDCWLz0fbsePFN1YWnMBu70IBbPcFr9NlJhuCD61w/5qYVXQBOrjiQpuJ2B
         GWH/76Nmvj9omdxfyLjasXMDkh9ymPzptefjOMFb/4UNNWE03pC5REQZW3riOYrifLgF
         zge81KdiCXLBe6dN/jwLiKJm+fJeRNs/tPEXtjss6JVAuhT+vCA0ETcl1vOxwXRTkYtD
         Lb0oRIl8HwlWd1XvJa5/xX4EwvmKcMHKwnlAR6xrhDE07zZt4IdtTCwg4bWSmSR9ipmj
         BbK1D/gcxD5R7jMMcqGaozLGfCoEPMbXIZBjHx7230HvThOItfJ8tmDOWF07wPdBPMEL
         cpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692309986; x=1692914786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEagVrEGDeFW5SN5vPpOPc2eA1RFxeNwNkE6U0C7DwA=;
        b=U5aIFOtmL+iiIMBYh4Yp1zLUK1qr9fUM3L6w/w0b9f1D63lSGAU/MCGPHlNCjwatZM
         17XzCN8kFm2xkys0A+RxzIUad8LywyVHvpWgIvkj/eE9BEq6bdR+u+y/pyGoj60oQPx0
         icoqJrKEEOACRUmWNm66wAJkwc0LBrOPJ3V6oK+vNiJ+MAF0TwRS4Dm5yYDkPsDo924n
         FgTdvLe/3M+6gJmWjTQULIIeVjKRJpfp+8HpgmPnkS5efb+Ko6TSIQgKfYUzMXXKS5Sx
         afskiWKn36MiPbgs8HlU1a16g37cEi8pFkW7gBIysc60GKwXQiqzgybM/yxtUpRuBcJK
         rE/Q==
X-Gm-Message-State: AOJu0YzGBCkjA/Zh0IWKZUPu72pSwb2w6RqiYv4/g2+bCu1O4B48hj3+
        J/i3H+Szk1+U5X4TJWGfDIxFtGH3fdGMzD5Wurw=
X-Google-Smtp-Source: AGHT+IEgYSpHAzlk0u5hqV1qyOMDcuGtnAQuKieE+kO68kfo5K6lPgyVsPLp34WPBN0mbU6xfJgn+MRL6/5KF9uL/dg=
X-Received: by 2002:a25:d348:0:b0:d1a:65c9:d98f with SMTP id
 e69-20020a25d348000000b00d1a65c9d98fmr845753ybf.56.1692309986633; Thu, 17 Aug
 2023 15:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230817200558.never.077-kees@kernel.org>
In-Reply-To: <20230817200558.never.077-kees@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 18 Aug 2023 00:06:15 +0200
Message-ID: <CANiq72=-DL0NV0zJrrzLmK77e6FALSupH4N-i-vfg8WrZdPDcQ@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: counted_by: Adjust name and
 identifier expansion
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 10:06=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> GCC and Clang's current RFCs name this attribute "counted_by", and have
> moved away from using a string for the member name. Update the kernel's
> macros to match. Additionally provide a UAPI no-op macro for UAPI structs
> that will gain annotations.
>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Fixes: dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good to me, thanks. Perhaps we should split the UAPI bit into a
second patch.

I can take it into my tree; otherwise if you need this elsewhere:

    Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
