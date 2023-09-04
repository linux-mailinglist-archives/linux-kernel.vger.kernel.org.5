Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97BF791D56
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353505AbjIDSpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjIDSpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:45:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AA118B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:45:20 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c337aeefbdso9823215ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693853120; x=1694457920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIC0vvBtQknXQrQ2iQzcpIL5nVgglpSsEX1r8/R4Dm4=;
        b=jmoJY34itV1nfgekHte6maTs7G6ScfQ6SJlZ+FAVA/eNwo5qxh1G+Efe/jfvp7V/Gd
         xXt+1PEg4djSFD25+ITRPiggvbfb7DA3vgboeN49gcBPXeXw+WIrcku4zVEbGHjBnPSm
         0Tf4OlRq8lHsrXKsXs3rWhM1g3V12zC8A9/0lujHhT8czplPdBZDvbs7Nwc02RtTFU57
         dNjaOwgFH4/sJ9l/5bFEb7A8e7yO410g/zUUxEuFpVAXZrNrYNhVAqXeTVu+67C0l6Ex
         tOj8jhl8FyVhzqCSD/mfg43Htr1qHPyKveG7twCE8zrquDyEFspMp7VriDku/iRGm7Db
         Dgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693853120; x=1694457920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIC0vvBtQknXQrQ2iQzcpIL5nVgglpSsEX1r8/R4Dm4=;
        b=Gp4KPcIE+IESG1qgtWswFYwUM4Zz+EWG38UVFH7G8ByzD3Ml1jWrIqGKp78jYmprYF
         Y3FmMWypQ38lVImnY10SVeejbYpRvkTBafD/oFDjJ9sqzdW2gYHep90wc9aJEoepniLd
         OXdlQ2O3H/RyaOTeBWuMi4rCOjEK+IQxwimZm43jY3lKubRwtPpjHUDperimVbAFZXss
         bSH0521ClhjGo+yEJsZlsgQPWfxCFFP5ZVdRwLICnhCFBPAv3MqH6Fru6VAAxCP5JnaP
         Kse0AgWOflfhoeoivAknTQ/5W/9YOUyhRk8kTR53pRZKy/vhJzHtgqq5qq19/aWOYyqO
         jWIQ==
X-Gm-Message-State: AOJu0YzTroGRpwmtznSKjKNx9KMCKNZTkUnpIXPhcjpefQpiItJO+8x1
        4xaI/ThEmw7bXJ64RJZaG76u89MeZp/Lx1l1uW8=
X-Google-Smtp-Source: AGHT+IEThPgz1V55Vl8XBsd/0dGFumQyosa4oaMfCufM9oHx/sB7SPUhjv5wNXIXgSnOoK1W6ivp9M2xfIVQrRF8fVs=
X-Received: by 2002:a17:90a:4b08:b0:26f:e9fd:8287 with SMTP id
 g8-20020a17090a4b0800b0026fe9fd8287mr9859030pjh.20.1693853120048; Mon, 04 Sep
 2023 11:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <3948766e-5ebd-5e13-3c0d-f5e30c3ed724@suse.cz>
In-Reply-To: <3948766e-5ebd-5e13-3c0d-f5e30c3ed724@suse.cz>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 4 Sep 2023 20:45:09 +0200
Message-ID: <CA+fCnZdRkJTG0Z1t00YGuzH4AFAicGUVyxFc63djewRz0vj=pQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] stackdepot: allow evicting stack traces
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Wed, Aug 30, 2023 at 9:46=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> I wonder if there's also another thing to consider for the future:
>
> 3. With the number of stackdepot users increasing, each having their
> distinct set of stacks from others, would it make sense to create separat=
e
> "storage instance" for each user instead of putting everything in a singl=
e
> shared one?

This shouldn't be hard to implement. However, do you see any
particular use cases for this?

One thing that comes to mind is that the users will then be able to
create/destroy stack depot instances when required. But I don't know
if any of the users need this: so far they all seem to require stack
depot throughout the whole lifetime of the system.

> In any case, evicting support is a good development, thanks!

Thank you!
