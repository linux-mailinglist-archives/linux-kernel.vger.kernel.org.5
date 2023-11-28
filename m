Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517707FC20C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346265AbjK1ObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345709AbjK1OU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:20:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5216F18E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:20:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB959C433CA;
        Tue, 28 Nov 2023 14:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701181233;
        bh=ZafUz/tBS+WxAqK8BrScQ+1PsQuHRQibBxd+i4NeQAw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EAz96Pu6G54eCNjLGpnYue2Jz1H9mdLT4rjwuXrUj0KySio0zBUS7XM7HRTG+sOvN
         cvJ68LcObTkorl4drW5GvgnCEKDjLmL44N67bRd9kZ0PgU1IGmvZpWzImwyk5XuYxV
         f5287dK2msj8dmtzGr3kfnPjZyMn+TRaz9VTdY5x+pTwtzrYxfhdrg+eYDANWTuE8V
         bGz9zZGsmEPYOOZzavIorjgLbtJEjQl9XGpVYWpA1sizGKGPC8OkAe4/GJaGl91bK4
         v0Y21NdmUGsZX79qBi7+kYe1JsWl9n7lilP5OLHQpQaqqgEJ3iZrerkmU0/W67fyks
         1x+RbAEz8KxSw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1fa1c3755afso1491258fac.1;
        Tue, 28 Nov 2023 06:20:32 -0800 (PST)
X-Gm-Message-State: AOJu0YxRhQlsbPhL65I9cOuQe8Iu7JbM+nqoHwfmAZeNmRHi9Sb/T+pC
        UPG65Dy/nlNyRlhfeWmmb+UjR75yXmv2aXICWBU=
X-Google-Smtp-Source: AGHT+IHswiwugmGVsE4mtflYbXoTA6rzhNrpmURMsGKRXV46JcUiWdu8Hu3GnToiEji2taygrJwe0QnQUJlToz83FGA=
X-Received: by 2002:a05:6871:454:b0:1f9:f54a:f5ef with SMTP id
 e20-20020a056871045400b001f9f54af5efmr6192409oag.19.1701181232316; Tue, 28
 Nov 2023 06:20:32 -0800 (PST)
MIME-Version: 1.0
References: <20231122034753.1446513-1-senozhatsky@chromium.org> <20231128053443.GA6525@google.com>
In-Reply-To: <20231128053443.GA6525@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 28 Nov 2023 23:19:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT_Z4TeNzngMskEoNdSTWUH5gGzYm5MfO6C_H8rFcF6ng@mail.gmail.com>
Message-ID: <CAK7LNAT_Z4TeNzngMskEoNdSTWUH5gGzYm5MfO6C_H8rFcF6ng@mail.gmail.com>
Subject: Re: [PATCH] kconfig: WERROR unmet symbol dependency
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Patrick Georgi <pgeorgi@google.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Reinauer <reinauer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 2:34=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/11/22 12:47), Sergey Senozhatsky wrote:
> > When KCONFIG_WERROR env variable is set treat unmet direct
> > symbol dependency as a terminal condition (error).
> >
> > Suggested-by: Stefan Reinauer <reinauer@google.com>
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>
> Gentle ping.


I believe you know this patch is too cheesy to be accepted.



KCONFIG_WERROR is meant to turn all warnings
to errors.

I do not see getenv("KCONFIG_WERROR")
sprinkled everywhere in Kconfig.



One more thing, you cannot directly exit(1)
from sym_calc_value().

Curses programs (menuconfig / nconfig),
must call endwin() before exiting.

Otherwise, the terminal will not come back
to the canonical mode.


You do not need to fix it, though.








--
Best Regards
Masahiro Yamada
