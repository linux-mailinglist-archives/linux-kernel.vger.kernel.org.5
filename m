Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED2F757AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjGRLsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjGRLsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:48:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40275E3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:48:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so7554054a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689680886; x=1692272886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zlIs2dsVoMlsB/D5YESYBz8KY0+SG3lYxZZPQTzebVI=;
        b=frcHAFDOWpjvuR36HpnIiI72u46e2CI0GU5+TvRTYYrKYhzpHE1jrPxYSJpHb1WZ5u
         Rjvu3QuVwgrssy1PGJBfjXSgeoHvbLEBcq6o9pGZTRy8rXryEJkmJsKGrX44KuirUX/S
         Bjbra8AqzdhaNbsmCtLTLmR2L1UK9PwUFAEHGuIFjm5a+LQijfaIBIIj4z1HqpkM+Lwo
         pW0Ex8ONIDt9E45A2Zlex2R3W6Ho7WHjQA6dNGePcE9pod5uKo5N7m3vvl7MrKq3gYcy
         cy2AZU6ewullzS2mWYg3aXPuoOjS4HFCJ2vDeikr/9IrtasI5b+MryhNPKGWkJ6gEqSU
         I9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689680886; x=1692272886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlIs2dsVoMlsB/D5YESYBz8KY0+SG3lYxZZPQTzebVI=;
        b=l2XQrOXyNI+yV7F4LNh6mkInjTAq6D4AZ0H8kz94yY254uSGUe3fSx+vRbREwACtc8
         N3GJlwjIcVuIxn/Q6mnCHGBLeVwnWEL9dprUvN4i0EOhv6NDNrw7aLRPq+I5BSdv6D3H
         6DS+24sClZOdQBgMhWYp6FcFRCqkK+cc7OlBEawcXx0RMytT20XPhZh+1m40QppwRzSj
         N7+oHughlFiaPHb2807dfFGk9LohnoWxC9tRrQLx8xR99dRipV3HJtgCsBZeQB9f/bV9
         67yZJzR9LSxFZwGoTyo13THF1I1CPGlp/K6FpN8z5cSi2krgUYVaYP8hup2H+0Eo/UyB
         6JJg==
X-Gm-Message-State: ABy/qLaCs9VuJRHTGljGpv9d5xGt8A2oQ8o1c8iARDsvUcnpChsoAjig
        I8PdrgD134KcSo2gdRRSDK6Lzxjds/r/sqYRA0tplg==
X-Google-Smtp-Source: APBJJlFOb4s90Dp23tihg0GBLYaT6KbaJU1ZWY/54YeFcSGLkmVWc1J7vMYdT7KOfZGpbIWxsV9ACDuKXIxwSpFDJ64=
X-Received: by 2002:a05:6402:457:b0:521:8bf7:bd32 with SMTP id
 p23-20020a056402045700b005218bf7bd32mr4736081edw.19.1689680885550; Tue, 18
 Jul 2023 04:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <87o7kbnle9.fsf@doe.com> <87jzuyobch.fsf@doe.com> <20230717213424.GB3842864@mit.edu>
In-Reply-To: <20230717213424.GB3842864@mit.edu>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Jul 2023 17:17:52 +0530
Message-ID: <CA+G9fYt4dDCw+nLvUGcX-JHG6fvyA8qsu1Caqdog53DW8MO4Mw@mail.gmail.com>
Subject: Re: next: kernel BUG at fs/ext4/mballoc.c:4369!
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 at 03:04, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Jul 17, 2023 at 08:04:54PM +0530, Ritesh Harjani wrote:
> >
> > These can basically trigger in extremely low memory space and only when
> > such ranges exist in the PA rbtree. Hence, I guess it is a little hard
> > to tigger race.
>
> Ritesh, thanks for looking into this!
>
> Naresh, how easy is it for you to trigger the BUG when using LTP?  I
> did two xfstests runs using "gce-xfstests -c ext2/default -g auto",
> one on the ext4 dev branch, and one on linux-next 20230717, and I
> wasn't able to trigger the BUG.
>
> If you can trivially trigger it using LTP (perhaps with a low memory
> configuration in your test setup?), that would be useful to know.

In our setup it is not easy to reproduce with the same device and
same build on x86_4 and arm64 juno-r2 connected with SSD drive
and running LTP fs testing.

LTP fs_fill is triggering several ENOSPC before getting this reported
kernel BUG at fs/ext4/mballoc.c:4369!

The reported issues are not noticed on latest Linux next tags.

- Naresh

>
> Cheers,
>
>                                         - Ted
