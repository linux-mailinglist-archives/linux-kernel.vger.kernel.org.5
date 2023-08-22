Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB3F784CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjHVW36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjHVW35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:29:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E338BCDD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AF1C63B8A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD88C433CB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692743394;
        bh=BDQidCO7vkJbJC0BHPsOnkF97i/b/WjbxoxOj68MHeU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PzPn3MKZH8Ylu//1jluFmSi+KLUgDAMe2L5HTB9cmPAzzQ5/qFk8NX5NbS953rF7V
         OOAVJ4f0II6sOyGpi0cmoJY7b0vs8MJ6N2RDgqxRV0AKhjFaSdqocCMcRtsNcGZlcX
         f0avTD0HIybUOZYVGYJF88T2uyQf48L685sVil+HYJ3O7M0T83IhWpRqhuUPCHBy6N
         VtAbpcgAvlMVamUnBx6oHulkcvKfipWaxuAYKj3vMjhiNqfYf5xSrxZNcySiADhGxd
         lLst1tMxI0xAmS9OXEM2focMOUyTglSURDbzBLiCcjH2+kPyG/Yc94HCaGD0cFyM+7
         SDOO3oJxstEkw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so84239691fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:29:54 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw3DwSNxWwQXdYRpqq2xJb2cjELev/gmIKxNwsiVY1CD+zWDWuD
        ufVGo6rAShnp59CuGh6j2EW0gKLNp6uiEblkxA==
X-Google-Smtp-Source: AGHT+IHn7iYa6EYm1dHZGL55YVCnUkQJpmo7yVnsc0JzNBF150tCD9jG7xnDPSn8SciaI8U00RhzHo1TJP9m52/7bEk=
X-Received: by 2002:a2e:81d0:0:b0:2bc:d33e:ccc5 with SMTP id
 s16-20020a2e81d0000000b002bcd33eccc5mr2332262ljg.41.1692743392809; Tue, 22
 Aug 2023 15:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230717225440.3211576-1-robh@kernel.org> <51dce096-1e45-c78e-e0b3-fcffa2cea4ec@kernel.org>
In-Reply-To: <51dce096-1e45-c78e-e0b3-fcffa2cea4ec@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Aug 2023 17:29:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKF_ncQ3KNOHXugGJQO-GCE4coUeOmhQXd3AkneTQv_7A@mail.gmail.com>
Message-ID: <CAL_JsqKF_ncQ3KNOHXugGJQO-GCE4coUeOmhQXd3AkneTQv_7A@mail.gmail.com>
Subject: Re: [PATCH] ARM: socfpga: Explicitly include correct DT includes
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 4:29=E2=80=AFPM Dinh Nguyen <dinguyen@kernel.org> w=
rote:
>
>
>
> On 7/17/23 17:54, Rob Herring wrote:
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it was merged into the regular platform bus=
.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those includ=
e
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
> >
>
> Applied!

Did you really? Doesn't look like this is in linux-next.

Rob
