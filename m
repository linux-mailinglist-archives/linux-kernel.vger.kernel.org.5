Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5607A41B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbjIRHEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240027AbjIRHEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:04:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E13311A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:04:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-530ab2d9e89so2516794a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695020650; x=1695625450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxanxzBzBYAY+nwMQabQhY93f4nqr/QEo3/ykSA6yhc=;
        b=txTzqw05xgM4j5/K/Sxp4qY+OpBZrKBE/DLmTuPbkxbZmyRqiyzF1eDl6CqxVHmLel
         ic+TBlqfy1Rd4LDqHuJJEsmEo27O/FFpjCI8l83zOsWBEmQfvdHxbm9OD8QV2lf/ABO4
         EjB1icaqdYX+dLgUMjxbGPNoE2at0c41UPQkSF3+TXVlrHAd3r/nB6dfz99/cRyJMsSr
         hn15RoVSpHmYh1hhahA9WU7CtbJtzp9qRl6k6iE1vd+CWXTyWnddOQI3Wt7ejqs/nhR6
         DQyTW4hfmIWg8Rm4AAUpSRWnerWOTELLeRpSm+g8ZZ1Nn9xJ4lnuDL293hvkh+b54960
         ycEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695020650; x=1695625450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxanxzBzBYAY+nwMQabQhY93f4nqr/QEo3/ykSA6yhc=;
        b=lhuU856aa+v5wcuLa5iGEQJJylrNlFPPwMO0FhEwKqj9Au3ibTHccUsLwLcRmxXmuU
         uEoPnn8BU5BUZupmwxaaLSYCpQX5qnWCEoxmKPgby5gjbW5tZGYnBzn6jFPM+3VrJyGJ
         UumnwaMoVS6oiqQCt0II9EMouY9YA0Mu43ZeOeSWM3rkug8PA011+Ujqxmehp2tcM8iN
         A316vBNLGfdrbaeRcaVM2yBgQ9f1DrrHmH63knm02aZWiikVpsf+MwsdpqeXtQCC2C+b
         iLew0h+QpDR8y4+SiVUq1q4ujd+wM8eghHBNHBjLahWbltbzaqUjN33969+d/VtTcpm4
         RJUw==
X-Gm-Message-State: AOJu0Yz8jk4UdnB1BBuTga0WjPFaxejFAUuw9iCloVoATt2ApP184jCI
        PyqT5QRNE85RsIWhMgiptzC3DOjc0xytiPoRnhmtIP2WfYizI9SbwA0wgg==
X-Google-Smtp-Source: AGHT+IHqikerTXA3+6J11m6jsjTlogmeIfrd2oscuOGRKrp9MkDG9Hp5jziyJnV6mEtXOrlAXSe7OBc2GyeiW4QrMsg=
X-Received: by 2002:a05:6402:3207:b0:530:c3ac:b684 with SMTP id
 g7-20020a056402320700b00530c3acb684mr6094984eda.23.1695020650534; Mon, 18 Sep
 2023 00:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230911-strncpy-drivers-block-aoe-aoenet-c-v1-1-9643d6137ff9@google.com>
 <202309142019.23A7D80A@keescook> <6338fbac-0177-43eb-be4f-7c586956953f@kernel.dk>
In-Reply-To: <6338fbac-0177-43eb-be4f-7c586956953f@kernel.dk>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 18 Sep 2023 00:03:56 -0700
Message-ID: <CAFhGd8pwtUSJBzepe=GBeyKuhD6ND6aWjeeT477Sdb4YTYDL_Q@mail.gmail.com>
Subject: Re: [PATCH] aoe: refactor deprecated strncpy
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Justin Sanders <justin@coraid.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 6:36=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/14/23 9:21 PM, Kees Cook wrote:
> > On Mon, Sep 11, 2023 at 09:09:07PM +0000, Justin Stitt wrote:
> >> `strncpy` is deprecated for use on NUL-terminated destination strings =
[1].
> >>
> >> `aoe_iflist` is expected to be NUL-terminated which is evident by its
> >> use with string apis later on like `strspn`:
> >> |    p =3D aoe_iflist + strspn(aoe_iflist, WHITESPACE);
> >>
> >> It also seems `aoe_iflist` does not need to be NUL-padded which means
> >> `strscpy` [2] is a suitable replacement due to the fact that it
> >> guarantees NUL-termination on the destination buffer while not
> >> unnecessarily NUL-padding.
> >>
> >> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#s=
trncpy-on-nul-terminated-strings [1]
> >> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.e=
n.html [2]
> >> Link: https://github.com/KSPP/linux/issues/90
> >> Cc: linux-hardening@vger.kernel.org
> >> Cc: Kees Cook <keescook@chromium.org>
> >> Cc: Xu Panda <xu.panda@zte.com.cn>
> >> Cc: Yang Yang <yang.yang29@zte.com>
> >> Signed-off-by: Justin Stitt <justinstitt@google.com>
> >
> > Agreed, truncation is the current behavior, and padding isn't needed.
> > (Or more precisely, it's already zeroed and this function is called
> > once.)
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Change looks fine to me too, but for the love of $deity, please use
> a proper subject line for these kinds of patches. It's not refactoring
> anything.
>

Fair.

Perhaps "xyz: replace strncpy with strscpy"?

> --
> Jens Axboe
>
