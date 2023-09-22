Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749617AB928
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjIVS2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjIVS2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:28:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C96AB;
        Fri, 22 Sep 2023 11:27:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601EAC433CB;
        Fri, 22 Sep 2023 18:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695407275;
        bh=1l9eqy3mjUGInVTS090SvBs8R894YrRmCPPDJ7eQCNI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bv6Idan+5YpoBHv+JQVQcl6McYhDUt2mTECNrlqn6RZLu36VYa6ZVaWNHQPR0iRIC
         5MbC5y9hO35Ou6i8wYf/fPvkAnDMejiDyrzUkwh71o0VLtgProJgw6FoFYRQOgg54y
         S1tnfMRG27gTiGl4RSb1iKZ1uxPBj29ZegW608GxPq+DXtq3bQpEzEiFNaQHD732pk
         sJdgbXKkIzSmXHH9LLrGua39nUNWxQp9sL1XjrJq5j4xGit3GFgFQVuZXLXcbyj57m
         lv4nV8Mig4aXGoQRhxIXGNIrVSraP3hoYY5lmrU/EY5M/Hhophvy2/e2hpms7IoPEW
         gvunyGshCxcuQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5043120ffbcso3283835e87.2;
        Fri, 22 Sep 2023 11:27:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw3LujExx95DvkVECDAPuSBSCem7/NTLRRdqxFjM4ct7lIPh47P
        ov8kYI+hxKIN9PPyoSPwFHnDtrgCPaKHdrCTb6c=
X-Google-Smtp-Source: AGHT+IFEfZUHvlNlrjwH17RMZtajgQofvr61fOulNn1kyAlv3ruQGtPtarya9xpa/UEmGCLI8RZv0BY5OqHdB5O3neo=
X-Received: by 2002:ac2:430c:0:b0:502:d35b:5058 with SMTP id
 l12-20020ac2430c000000b00502d35b5058mr261081lfh.4.1695407273593; Fri, 22 Sep
 2023 11:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230915200328.never.064-kees@kernel.org> <6d98461f-a794-a258-9640-78fa277b6e76@embeddedor.com>
In-Reply-To: <6d98461f-a794-a258-9640-78fa277b6e76@embeddedor.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 22 Sep 2023 11:27:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7W8nCYsk_cA1ue=LYcdLhtBSoDnww5b+1RtteudNa0=A@mail.gmail.com>
Message-ID: <CAPhsuW7W8nCYsk_cA1ue=LYcdLhtBSoDnww5b+1RtteudNa0=A@mail.gmail.com>
Subject: Re: [PATCH] md/md-linear: Annotate struct linear_conf with __counted_by
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-raid@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
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

On Fri, Sep 15, 2023 at 1:27=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 9/15/23 14:03, Kees Cook wrote:
> > Prepare for the coming implementation by GCC and Clang of the __counted=
_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOU=
NDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-famil=
y
> > functions).
> >
> > As found with Coccinelle[1], add __counted_by for struct linear_conf.
> > Additionally, since the element count member must be set before accessi=
ng
> > the annotated flexible array member, move its initialization earlier.
> >
> > [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples=
/counted_by.cocci
> >
> > Cc: Song Liu <song@kernel.org>
> > Cc: linux-raid@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to md-next. Thanks!
Song
