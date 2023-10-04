Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D680A7B7C18
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241805AbjJDJ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241784AbjJDJ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:28:22 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE38A7;
        Wed,  4 Oct 2023 02:28:20 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1dd5b98d9aeso385511fac.0;
        Wed, 04 Oct 2023 02:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696411697; x=1697016497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRXKpGBes2rUzzjaWR4OqYKNQnz+8sTz34lO9NeNuWM=;
        b=armtjL6daOW85htO6dmVOZ0cMkZT5KMwj1b0JmzXfEYZUh0eBW/mKBjVM73hwZF/kR
         wNdAoMd++OhPVW0gFJpkR0TzAd7mEZxuOspo0q8Gf1MSdkiYymD+ahYFuTncFuVjoZ4I
         jQ/Py5gd/K4hlxh7gFLSEGT1XfwXiUvFnEFtlb5IN8rkzD7kBtBr96A4oLGR+eVvNw3Z
         RDBYht/2otzL2J2ZkqnOmRsdeeSuNG3/EOp5rJNIkD0bYYO8WRgyO9Tcv+mPOflKkuT4
         6qngFtiNWJMaMFnO3Hj8Qy7t3xgjRrqTdkGdPtb52AD6K9GH/k3KHu0PM00mNHsGptrp
         yFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696411697; x=1697016497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRXKpGBes2rUzzjaWR4OqYKNQnz+8sTz34lO9NeNuWM=;
        b=rub+VUfwFkDzY23Wny3X/fYbSI3uSqozTo3WbH0PiT548UVluFbLRmp2jqRk2jM5oC
         +LL29PXZc+pabzbcZ11keX9BDQPCk0vBRvinZjEQiDtI/JfhHpQ+UziQIipBB4Is1rse
         w7np3VmJUTff6BKk0qQLpA54PdEpj2cxoBBQ0YKkUz0QBRBIW5z+PeOKfJQzXoUpw4WH
         09Oo7vPN4idMaXyRRtIvT70ymiskB2ApD2ZCqX8dkBwQ8tJLMvSp4uIaETbEBFLjog6i
         DfNAy9oxbKiAdyKqyZf3vwacNYP1eMf+oEAZ5uTnrSrYEdGH2/At8xoePPODEmbpK+GN
         +xhg==
X-Gm-Message-State: AOJu0Yzga2EWNL/Ech3ZaBoKtqiYMUAgiXajUmzjUpJI+bvhRLfyAEHI
        HYk27/wB6zGINtjtv8uJu4lYQ8l1DVUk4A2bkRw=
X-Google-Smtp-Source: AGHT+IFvdOBdsYNhOUttsn0uChqCkcyiqSqrVLc5oVDHEWUWQ6pwuH1wuPuYjvMDfA1PVVmCgzo3kWlzVPmosvtDX+E=
X-Received: by 2002:a05:6870:8a12:b0:1dd:611e:d404 with SMTP id
 p18-20020a0568708a1200b001dd611ed404mr3009612oaq.21.1696411697471; Wed, 04
 Oct 2023 02:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231003130142.2936503-1-andriy.shevchenko@linux.intel.com> <202310031638.D39E80C32B@keescook>
In-Reply-To: <202310031638.D39E80C32B@keescook>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Oct 2023 12:27:41 +0300
Message-ID: <CAHp75VeqvxjqXjmF8ymEYevJkCoQVnkJiuBkccHuGsU_E14LzA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Move lib/cmdline.c prototypes to string.h
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 2:39=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Tue, Oct 03, 2023 at 04:01:42PM +0300, Andy Shevchenko wrote:
> > The lib/cmdline.c is basically a set of some small string parsers
> > which are wide used in the kernel. Their prototypes belong to the
> > string.h rather then kernel.h.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> I think these should live in string_helpers.h not string.h (which is, in
> theory, supposed to be used for the standard C string library functions,
> though that's not 100% currently)...

These are being used in the early stages where usually we have
string.h. So, I would argue, but if you insist, I can move them. What
about lib/argv_slit.c then? Because semantically it's quite close to
what the lib/cmdline.c is doing.

--=20
With Best Regards,
Andy Shevchenko
