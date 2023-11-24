Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FA17F70D2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbjKXKHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345451AbjKXKGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:06:55 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439C11B6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:07:02 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5cc86fcea4fso14566587b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700820421; x=1701425221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWcP6gQgrwmdsnOkpH93ij3XRZvKw3Rujab02fsHwiU=;
        b=qxN5ioYEcENuAMn/Jxr8Kcg+5ZM9glWmzc3x2Wi4S+x6rIHteCtrlCsNYbUfjdtyne
         BOdb9FO72GTlLtiezDwv7z4FSZeDqFsIqJv3K7V9Er47Gp1Kz630X58BdnwoGtrxcEpe
         1tvf9tPCzQGzUdh2tt2cnuSUV/TJi8E1wS6stwjJMQBwVvYT8hxvgDAhSopsGd12KbZh
         QP2nKDWokcgtUjPWANTtF/8dgHgQlYDF6SwKsPZHxvKYIAma9EnC1co9CQ0vtrD4NJrS
         P1CSCaqZd17kLEjuFbJESHzg++yLR3jYXQ3HozJxQFwMyl1Ep+MNrCZnxXFBGc5LBp/A
         sSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700820421; x=1701425221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWcP6gQgrwmdsnOkpH93ij3XRZvKw3Rujab02fsHwiU=;
        b=FgpbKMBguREXER1NwMZQT51ifwgxaTO0tSLiGJItfqcq1wUdvaWDlNH9mLSRRXM7Se
         Evwnn5YCtDyaQUGdoqS2JCBGlxV6TTtwTdAsle1zNpbJXKm4al9UieahZuBVn2ipoRqd
         pC0pbWxZamAX6h5629TT2W3GCs3BKGPSYYFEcKwKNTHVPFyz8gKgp3LKwFZWpT2eYIYX
         w60XFVuYzP8Tf/AwfNAFnldoobLIkkhk7HeMv57VuBtAz69G4cS+qEW63r/z64s4R4OT
         hy7EaPq/xnUg60rNINzbplKaVNN4iRcZSDPIAot2AmE0e4N4iADblF7sE3qDFRoAsPei
         F9CA==
X-Gm-Message-State: AOJu0YzBx0DCS+u2oaBmdxIEy8crjUr0z8HUoHpIXsv7MPkq525qe8kK
        TW59nGMo3KntVCnDtjKE6lmcsEyKJYVcnkK/hpNJUQ==
X-Google-Smtp-Source: AGHT+IFSnAJD8pB6XNkHS4v3hhDyUz8bMnLEKTFJgyUyBO5NiU10+s0sV8dxVVUWj46P6kffDmIbWY6kXKt507dXHqo=
X-Received: by 2002:a81:e950:0:b0:59b:c805:de60 with SMTP id
 e16-20020a81e950000000b0059bc805de60mr2174447ywm.45.1700820421368; Fri, 24
 Nov 2023 02:07:01 -0800 (PST)
MIME-Version: 1.0
References: <20231120222832.4063882-1-masahiroy@kernel.org>
 <20231120222832.4063882-2-masahiroy@kernel.org> <CAK7LNATK3BVDZ88v7MWjzOk3Kv8CR4Tz_k77yi1OO=zc+71j=g@mail.gmail.com>
In-Reply-To: <CAK7LNATK3BVDZ88v7MWjzOk3Kv8CR4Tz_k77yi1OO=zc+71j=g@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Nov 2023 11:06:50 +0100
Message-ID: <CACRpkdaMBrWUR8OYLPiQNNJ64mfenFyQa9f4iB+w5kZ44WjSeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: pinconf-generic: resize the pin config array directly
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Tue, Nov 21, 2023 at 11:21=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> On Tue, Nov 21, 2023 at 7:28=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > pinconf_generic_parse_dt_config() allocates memory that is large enough
> > to contain all the config parameters. Then, kmemdup() copies the found
> > configs to the memory with the exact size.
> >
> > There is no need to allocate memory twice; you can directly resize the
> > initial memory using krealloc_array().
> >
> > I also changed kcalloc() to kmalloc_array() to keep the consistency wit=
h
> > krealloc_array(). This change has no impact because you do not need to
> > zero out the 'cfg' array.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Sorry, I retract this patch set.
>
> krealloc() does not save any memory
> when the new_size is smaller than the current size.

But the first part where you switch to kmalloc_array() is still a nice chan=
ge.

The fact that we use kmemdup to be able to also shrink the allocation is a
bit of an oddity I guess, but let's run this patch by Andy Shevchenko, and
ask what he thinks about simply introducing kmemdup_array() or if he
has other ideas for this.

Yours,
Linus Walleij
