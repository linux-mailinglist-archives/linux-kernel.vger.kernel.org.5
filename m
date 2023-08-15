Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64A077D681
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbjHOXHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240529AbjHOXGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:06:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1948BC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:06:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98377c5d53eso765675366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692140800; x=1692745600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrPa0mBv24tqWNTDwul7//LSN1cVDKf7kn8qJcAv5os=;
        b=I2gqKHVnynhn5a6q7JufzjrjRBbX85r9laDBvivZCmJTEHBX/D5v38OrAFPAQ4Ahuc
         BiyPhwLlWkv5/U0J+sAvWtfA/Ee5uB0NoidvQXMtfa0FS74sBrPLCyRJmmEIQzd8EV7y
         6/y3/f3zM1JfDx/29KU52/0d6Ru65VZzlri72Sx5Xe31cTIDpCeu0hsdP3cBw8UiVdIa
         bJ2H2pnogg1LR7+3bKP5HbfMwKxX9p5tNM4N4yGhHNM0AjDm19KPz9SZ0cpmztJdTEJm
         JYpg4T9J1ZqP6T57bMG+D2pVB60Cbw1NXwlJoKjH8PZ6RtPiWJAYrfjgcJMBFI4n/rwr
         VBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692140800; x=1692745600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrPa0mBv24tqWNTDwul7//LSN1cVDKf7kn8qJcAv5os=;
        b=jc4A1akW5yTwq+LwvB4q+ZoToUnzDdBdnU53STNCKP1QDBOTj+KZtnPVtUaphMmgwK
         qafjDX+jfgrqTde80sm2rw/0IET+WzgwQlBbYDkt6ictTGZIrgBSh4pzpZD5Ui0D/VxG
         0Mkbisp8IFeOV4jp09ZmTlCStgjwJTDo3fcfRoc9rgS9if7sj/ZgEgZbubmiMbZfMFJG
         OmrsA4A6IVi+OM1JXMGBoB47GjTzdnMQhoiRFukqRfErd6xe0hyfN1eyfTDbXJrjr+yr
         yi5QyGQJXVSUeMOsIHQrtdWj60FaaInnBRK5cvdYuYb9jj90k20U+g3u3Z7Jl2qXyPkj
         xtfw==
X-Gm-Message-State: AOJu0YzxyX/UqjCNAXYLfcRD3d1gIl6P/utFTZC5bqOp3aZWK0+wXIKo
        M+UG3DvyFOX+l2aSbceKNOFEzm5552o2EL2qvjYLxw==
X-Google-Smtp-Source: AGHT+IEYf/fyOVx0742lOUxeNNrFI2vcP6VhqTkYiAQ+DS6mXjvMmtfl0u01KMqRzs8F2tE5QS8vH45FY5IvumziGEA=
X-Received: by 2002:a17:906:19:b0:992:bc8:58e4 with SMTP id
 25-20020a170906001900b009920bc858e4mr75813eja.20.1692140800125; Tue, 15 Aug
 2023 16:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230815-void-drivers-mtd-maps-physmap-versatile-v1-1-ba6fc86d5e4e@google.com>
 <a7956e13-7b94-fb65-8b43-f2c9fd014353@linaro.org>
In-Reply-To: <a7956e13-7b94-fb65-8b43-f2c9fd014353@linaro.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 15 Aug 2023 16:06:28 -0700
Message-ID: <CAFhGd8rTU0o8uiGT1qUKbsOZTgqLR7Sw5h-+07y4SJ6QOd9KsA@mail.gmail.com>
Subject: Re: [PATCH] mtd: maps: fix -Wvoid-pointer-to-enum-cast warning
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 2:15=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/08/2023 23:11, Justin Stitt wrote:
> > When building with clang 18 I see the following warning:
> > |       drivers/mtd/maps/physmap-versatile.c:209:25: warning: cast to s=
maller
> > |               integer type 'enum versatile_flashprot' from 'const voi=
d *' [-Wvoid-pointer-to-enum-cast]
> > |         209 |                 versatile_flashprot =3D (enum versatile=
_flashprot)devid->data;
> >
> > This is due to the fact that `devid->data` is a void* while `enum
> > versatile_flashprot` has the size of an int. This leads to truncation
> > and possible data loss.
>
> Cast does not solve truncation. This part of commit msg suggests that
> you actually fix real issue... and that is an issue, because then
> AUTOSEL will grab it. This is just compiler warning silencing and rather
> coding standard correctness, no real fix, so please drop the sentence.
OK, makes sense about this not technically solving an issue and thus
AUTOSEL may pick it up. Can you elaborate, though, on how the cast
doesn't solve truncation. Is the initial implementation not a
pointer-width down to int-width cast? Surely we're losing the top half
of bits. I'm still not saying there's data loss, to be clear. Just
that the compiler is warning because of the truncation.

>
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: There is likely no data loss occurring here due to the fact that
> > `enum versatile_flashprot` has only a few enumerated fields, none of
> > which are large enough to cause data loss.
>
> If there is a data loss, cast does not solve it.
>
> > Nonetheless, this patch helps
> > towards the goal of eventually enabling this warning for more builds.
> >
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
>
> Best regards,
> Krzysztof
>
