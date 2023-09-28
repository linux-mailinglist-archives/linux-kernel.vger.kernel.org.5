Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9AA7B1776
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjI1JhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjI1Jg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:36:59 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E28126
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:36:58 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a21ea6baccso10503757b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695893817; x=1696498617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1H2jD/T72wNFGuODad3ytbvumv6Q48VnTWsSVBuRsw=;
        b=iYyyotxdZcY7GeAWfkwQHCbAcmXYX2yFhqFvDtSsC0GOoA7FGgQLNBI4x6RKTaAS91
         xdW3A8SvXjntIOeJaPN//Z+Nfz4ZsJl6efOmstUsXw+fS9mFJAvDvY4h5ZsQgrkzrmbn
         2Je5GTppxGjnnJk1zO70+172yBnb5Lh5snbGjzydV+zcjAXQZ7pWSjA+n9iVXwlEEsUx
         NTGg2QL3TOffPl9+Uv1dGQllHNaBQ4atf6nS1JtWr9SPBQxJ6Cjscg5pSfK+UraBKEVg
         f2N0HBkkdgZ071sX4JVJ+x8zUnve8DJwlZaHi3ssN8ci/SpWsx0J2B+hotICZlgMflX4
         MSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695893817; x=1696498617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1H2jD/T72wNFGuODad3ytbvumv6Q48VnTWsSVBuRsw=;
        b=n1WM8X0WG90E021wdJhhrlfiaicx7Gh0PY8RJQuz8qJH5UgugWQjrf1HRx9VEqF9Zu
         UZv1IdR/V++xkVtzN2qylZ3E7L7qPvuVNcEXTD2XpunCphtL4Hj0gjj3fETcdo27wY7T
         0WCQMnSaZBLKMPzwkkxJcGS3eLT7BwZr+MQYrk0NNWEK7xRqqCXbDXRhBj5cB8Bu8I6g
         lz4IW7RO9DU8UL2boQqESOQJvlm3R2g1bQEBJkWLurVYAcquScrX33XSH70Yi+FMBjl0
         Jdp5jyUUpG+oIhxHX0LTFnF72JSU7hCkfzA5tFS3nU4jFTmwF6xHKT886Q5qzml3wQLi
         lYGg==
X-Gm-Message-State: AOJu0YzwhrApUX8pbcXPF+z6egCXGBXM3Bx7ZFgcaocJXnfWmkCjHlZt
        zmxyEYC9AzHsKjSF7OFaZ5OueL1TWPuzdMmerQ4=
X-Google-Smtp-Source: AGHT+IE1QbIcMneFxU/csXugdEE2/7Yvtg2RUsfDugJuKvIriVmVUPlbc8LG9Ij9deP6a16q7yf1L6TBu6imhUhtwkU=
X-Received: by 2002:a81:6c17:0:b0:59b:eb5b:fbbb with SMTP id
 h23-20020a816c17000000b0059beb5bfbbbmr671357ywc.12.1695893817456; Thu, 28 Sep
 2023 02:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <202309280610.sLGSPkOG-lkp@intel.com>
In-Reply-To: <202309280610.sLGSPkOG-lkp@intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 28 Sep 2023 11:36:46 +0200
Message-ID: <CANiq72=J=bO-Q0=gMDyiRgvbF_Vre39iqbEnaEeDho4Vo2ox6A@mail.gmail.com>
Subject: Re: drivers/md/dm-cache-metadata.c:1705:9: warning: 'strncpy'
 specified bound 16 equals destination size
To:     kernel test robot <lkp@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
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

On Thu, Sep 28, 2023 at 12:24=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
>    In function 'write_hints',
>        inlined from 'dm_cache_write_hints' at drivers/md/dm-cache-metadat=
a.c:1729:6:
> >> drivers/md/dm-cache-metadata.c:1705:9: warning: 'strncpy' specified bo=
und 16 equals destination size [-Wstringop-truncation]
>     1705 |         strncpy(cmd->policy_name, policy_name, sizeof(cmd->pol=
icy_name));
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~

This looks fine given the check above it. In any case, since it
appears the code wants to terminate the string, this should use
`strscpy*()`, right?

Cheers,
Miguel
