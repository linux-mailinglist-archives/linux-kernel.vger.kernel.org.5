Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B827AE3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjIZDK5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 23:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjIZDKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:10:54 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7953B4;
        Mon, 25 Sep 2023 20:10:46 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59f4db9e11eso64074117b3.0;
        Mon, 25 Sep 2023 20:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695697845; x=1696302645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rMSxjrVDIEUhAUfTpZ8/rC5Bw846FjHkIGiRkImifs=;
        b=HGoG8ma1d+ajUu+ZC1aBKKOZt9FgnTBKT4OoMMDBcdkZLMlT+bG5FyulpAFKrgkP92
         dF5xOh4ksMqfTcbfaNFZy5gWER+gEI9THw/M97Hxc5oWQ/4jZ0GiQSh2Y1bXrgHkejWg
         DrgKvXn0YohW9iA+hUt0zLSL/d9izOKmX5++4f5qwV52FdD9KetVPOUq70hU7ete7oy+
         UDhlMHtyrHyUPSRB5cFsi71iBSWbjcD5API9aiDBFps8vmzEdRAEq+VAqsx3Ajeis5Tq
         gL+Xq/ItxJAIocR+RviNNoy28HYqaIOhgBnOGhpDOdw3hn0fVyvb6KmJC2iNJfkOV9op
         88Yw==
X-Gm-Message-State: AOJu0YwvkD4qUr9sTMPU8t16FVAGgmGu1lUsarHCkOvR7f7+UI+q4eAW
        MmKIq6z+Xtq6Iq6d+xchCi0Oe4YKYqNKzA==
X-Google-Smtp-Source: AGHT+IGVvt3vBP4+tla/JQR+DzN9B/CohKdu+f7rp2TW9qvQmB44SlU689X0R/JmZEt9Mr5Of8X8yw==
X-Received: by 2002:a0d:cc49:0:b0:589:a4c6:a4ed with SMTP id o70-20020a0dcc49000000b00589a4c6a4edmr7784340ywd.3.1695697845074;
        Mon, 25 Sep 2023 20:10:45 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id v81-20020a814854000000b00576c727498dsm2755725ywa.92.2023.09.25.20.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 20:10:44 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d81d09d883dso8960102276.0;
        Mon, 25 Sep 2023 20:10:44 -0700 (PDT)
X-Received: by 2002:a25:2e43:0:b0:d84:b0f8:90b with SMTP id
 b3-20020a252e43000000b00d84b0f8090bmr7770498ybn.55.1695697843859; Mon, 25 Sep
 2023 20:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230925-strncpy-drivers-input-misc-axp20x-pek-c-v2-1-ff7abe8498d6@google.com>
 <202309251100.A187272A49@keescook>
In-Reply-To: <202309251100.A187272A49@keescook>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 26 Sep 2023 11:10:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v64W3oa6g-Ln2wVqXU4eVa-tY=zhvooAXckzDve8_fR-gQ@mail.gmail.com>
Message-ID: <CAGb2v64W3oa6g-Ln2wVqXU4eVa-tY=zhvooAXckzDve8_fR-gQ@mail.gmail.com>
Subject: Re: [PATCH v2] Input: axp20x-pek - avoid needless newline removal
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 2:00 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Sep 25, 2023 at 04:31:05AM +0000, Justin Stitt wrote:
> > This code is doing more work than it needs to.
> >
> > Before handing off `val_str` to `kstrtouint()` we are eagerly removing
> > any trailing newline which requires copying `buf`, validating it's
> > length and checking/replacing any potential newlines.
> >
> > kstrtouint() handles this implicitly:
> > kstrtouint ->
> >   kstrotoull -> (documentation)
> > |   /**
> > |    * kstrtoull - convert a string to an unsigned long long
> > |    * @s: The start of the string. The string must be null-terminated, and may also
> > |    *  include a single newline before its terminating null. The first character
> > |    ...
> >
> > Let's remove the redundant functionality and let kstrtouint handle it.
> >
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> This looks much cleaner. Thanks!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
