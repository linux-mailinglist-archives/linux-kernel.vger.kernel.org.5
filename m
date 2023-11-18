Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5094E7F0240
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 20:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjKRTHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 14:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjKRTG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 14:06:59 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ED1D52
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 11:06:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so4299a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 11:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700334414; x=1700939214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BX7PzfZyMqtOcztCqDIQ3igdby7s7mhmSg6YX3x3/1g=;
        b=D/6lOCgclHoafAv4Ib1OWRASBH+1hHgWnIm24ezKy1CDBZ6VERpvetTvRuFCclseck
         8mUraasbOPY7iiwFI3aBdooh938PU679bFKQh41yJ/eJC0ly/gc/g+Qxx+yig37veTeW
         aLpGiuCaUCg6Uyt7zHXm3fzUJQMiZ01nPJ68yQCtFaym2IIghOJPRvdfRUoEIAB05fC3
         Q2or77LfUIahJsduBeby8riEYu/fGuQKnlrc80bkVuhu/B13Sccngul8RWfz/KPtObGC
         pB4DjGuSuykSALJmhBoQ2lvIgwzQAVLfmgRUskvq87GnTL7ObZn75g57Tk4u82Hpjl47
         XOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700334414; x=1700939214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BX7PzfZyMqtOcztCqDIQ3igdby7s7mhmSg6YX3x3/1g=;
        b=Zg9JcY5gWlXvPMZox+YJX9rJoq3V6jYfZ/TqdXkVRKYkAt/cdv6mOdZNo8dyxnK9WS
         b209rdOjQZYv4JKvuu++3DR/9YA0k2ZQASQS28n6PAZ4lkcuuj5BI17Rc3wFeA+vLScC
         GzQPjcxgERSUWeh0r6RlG+lUTv7XX4Yi+vVP8zWVlNnmv6d0AciG3LPw/Xm4A10Zrgp5
         iCUuvIPvDCbHSgyekneo0gbxJ121sbgD15ZeG5cS2AmxAPpwNMqLHj2LWtKwBrpay1Ed
         g+dyZoDTrg5PvagVZJOg0PJLB+lOZKFTOBepq/vn85gmcRuD972TS9GV9ZVqJ9Fp0IgJ
         Vi6w==
X-Gm-Message-State: AOJu0YwUgwE6APJkV2PKYerJUgkRvVZvPsanAwlEZ52uusDh6uvTQh5B
        vzIj8QqEf3eP4D8LoSyxLoXWf7CccQg7Wmy/3ue7
X-Google-Smtp-Source: AGHT+IE+ySdOFa6ErrSdvsWW7KQSBH8g/N1u2mWL8+Nn6TPxiB77nMMZ3Dtk7AmGRGZyP5s5Us2Nmlsmyr4xdkN5Q94=
X-Received: by 2002:a05:6402:514f:b0:545:94c:862e with SMTP id
 n15-20020a056402514f00b00545094c862emr109260edd.2.1700334414224; Sat, 18 Nov
 2023 11:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20231117-maintainers-v1-1-85f2a7422ed9@google.com> <8243E862-CFC1-4658-B07E-9FB87E34E12B@kernel.org>
In-Reply-To: <8243E862-CFC1-4658-B07E-9FB87E34E12B@kernel.org>
From:   Bill Wendling <morbo@google.com>
Date:   Sat, 18 Nov 2023 11:06:37 -0800
Message-ID: <CAGG=3QUishWF-bApJM5ppGPaZJNaHQjSxSB=NFRYpkmC59THbw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: refresh LLVM support
To:     Kees Cook <kees@kernel.org>
Cc:     ndesaulniers@google.com, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 2:53=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On November 17, 2023 11:24:02 AM PST, ndesaulniers@google.com wrote:
> >I'll be taking a step back from kernel work
>
> NAK ;)
>
I was going to do that too. :-)

> >to focus on my growing
> >family and helping Google figure out its libc story.
>
> These are both big challenges, worthy of your attention. :)
>
> >For CLANG/LLVM BUILD SUPPORT I'm bumping myself down from maintainer to
> >reviewer, adding Bill and Justin, and removing Tom (Tom and I confirmed =
this
> >via private email; thanks for the work done Tom, ++beers_owed).
>
> Thanks Tom, and glad to have Bill and Justin stepping up!
>
> >Wake me when you need me.
>
> As the prophecy has foretold!
>
> >Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> We'll just report all issues as LTS kernel bugs and use the MAINTAINERS e=
ntries from there. ;) We'll miss you, but you won't be far!
>
> Good hunting,
>
> -Kees
>
> --
> Kees Cook
