Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344127F623A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346039AbjKWPBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346036AbjKWPBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:01:11 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B204810F1;
        Thu, 23 Nov 2023 07:01:14 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5bd33a450fdso681013a12.0;
        Thu, 23 Nov 2023 07:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700751674; x=1701356474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gd28dXAiXNKxS9lDlxrb5KoNC5MdDodRXi/NCNqBcbc=;
        b=gORT5/BLiniKLnqQLVNbHSBBzpYIRL1G20C7+D1tvUXBqofdm4AJML/M/tyV8l/IJx
         AehdvLU2rrgQuPurPK2js5uSKB19J+fT4oBtmZ1zCY41lBTf3cwPs7fh6og5/GG1g43D
         a8dcrPS0iYTPoLo/CMon+r8+SQmi7T04duKXrsPdWQNB3ZTLFtd3vseOFTFGD91e9y0/
         EztSuG1cPg/xaFdWMhhiZsRucG0cGzxSBKepPp2xJqwj8/eq26Cpn42+ssL4jWYMIw9U
         4RbaY+HnphFkb+EhI2t9JVgpP717d1pC+r24uUYzMksQWN3JnKVmkwss89e/vUF2IhrL
         8P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700751674; x=1701356474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gd28dXAiXNKxS9lDlxrb5KoNC5MdDodRXi/NCNqBcbc=;
        b=LPha166CKnSh83GFUgEBNKxGRx0f5mbmvv1a9GumDdvlUiF34UIoRxFHf2xrWP2Pb0
         6GGy0YY9uwbc6jsK5pKWcXTVocHBC62PYJ3KSvuRjj316B8NP1Wc6ErghlUW7wPncU9j
         2qRqR2gQo/ScpXoKBGYSGSN5PpYcxqmPmM5lMbx8+ZKMPwdmecBmgUjXHNaq8W3ao+XZ
         LURQSG3KJY4hLdRVfAyJ22WwN2q9uXJjiHRzO/Spqq9uae81I8f0baBOOiBdHfCjia6D
         SBYfD8siJ5HloTacTBv+X5xrDJ1cZWzSwKC3lOzHtYCOYJE+XGs1m8ZMR0kk00Uehygj
         A59w==
X-Gm-Message-State: AOJu0Yy3Ce7W/TjL9RHhYZHyZ7fJu4oPyNLBM0oFz+AThubG8Wz4mFDW
        sf4I/hElQRwWD8bWmCMcGMaDjw8M5W1UDGWx0Rs=
X-Google-Smtp-Source: AGHT+IEbi8KMuCVXgbVjVtKzFpCV3fot+7R6WHpsbtlt+XGzmRiYNvLw+XrN9dp6pYfcFtRllvhKlkzs771TDl9jRqY=
X-Received: by 2002:a17:90b:4f4c:b0:280:2985:56af with SMTP id
 pj12-20020a17090b4f4c00b00280298556afmr6696370pjb.45.1700751673962; Thu, 23
 Nov 2023 07:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20231123132749.108827-1-boerge.struempfel@gmail.com> <CAHp75VcBMbENVKhbdJnXHGxAP85_5CMNxoq7JqV5XbUyRLPoaQ@mail.gmail.com>
In-Reply-To: <CAHp75VcBMbENVKhbdJnXHGxAP85_5CMNxoq7JqV5XbUyRLPoaQ@mail.gmail.com>
From:   =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Date:   Thu, 23 Nov 2023 16:01:02 +0100
Message-ID: <CAEktqctA0KWmL_W6aVM67DWB0Q6hOWUQqMwkOp6hn4+iouj1cA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: sysfs: Fix improper error handling on failed export
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, bstruempfel@ultratronik.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

thank you for your feedback

On Thu, Nov 23, 2023 at 3:25=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Nov 23, 2023 at 3:30=E2=80=AFPM Boerge Struempfel
> <boerge.struempfel@gmail.com> wrote:
> >
> > If gpio_set_transitory fails, we should free the gpio again. Most
>
> We refer to functions as func() in the text and comments (note parenthese=
s).
>
> GPIO

Thanks for letting me know, I will update the the commit message in
regards to this.

>
> > notably, the flag FLAG_REQUESTED has previously been set in
> > gpiod_request_commit, and should be reset on failure.
>
> Same about func().
>
> ...
>
> Seems the correct fix, but you may also add that no existing user is
> returning anything except 0 or ENOTSUPP that is converted to 0 in
> GPIOLIB core code. Hence no Fixes tag is needed, but still possible if
> maintainers want it.
>

You are right. For now, all mainline users are returning 0. We only found
this due to downstream-specific code. I'll add a comment about this not
affecting any existing users to the commit message.

> --
> With Best Regards,
> Andy Shevchenko
