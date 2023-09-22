Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1F97AAA46
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjIVHcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjIVHcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:32:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548D8C2;
        Fri, 22 Sep 2023 00:32:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13C3C433CA;
        Fri, 22 Sep 2023 07:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695367928;
        bh=ZzFUdwOJ/4dChLS6pmbmyN8T4P/gwsea0R+6/2tRYDk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z+Zl2/DcTiNDkxO/lhZc4YEOSJ/FKxAqvtLnSQ6EeRiINUkrCIquncRml6G4VzalL
         KxHQdmohDSBYO8LfKnEYBXG9fSeefZwMVz/A+giydPQf0sMtfsWO5Cn4wHwB4hR96a
         meoNXhstXNLaQASbSeLkMp9p1DouAXdDwZE652E0620jzhsFUaqm5lvxF3AbHwdVky
         2k7aRfoZW0KRo0AVXUSopSNVl5qbxly1qwkfWzY7LMvzTSlAjQQyDhqrqMG60CKos7
         AF4R+9HnQC0QLWbdBVfbeU8Ra9WU3474DUqrZslR2DivigDQIMUDlqh41IG5oeDkQ4
         H/BAA1ur6f4aw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1d6b5292aebso977281fac.1;
        Fri, 22 Sep 2023 00:32:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyu7vrOcQthX8suRe1Yw7+5jJV98+4ziZMHuTfvWa4QbN3Q7dK6
        g2sdjxXp1/6rFFHkT8vVjn9D/an/L68nVKwgQFQ=
X-Google-Smtp-Source: AGHT+IHeKkYqD4nlPbgVB+0ToS/Nb6BY3zOzZgdAKplen4/uCBshYWYMZWCTQrZ7agNTYabicYhPwYzrPyhY3RcDXEQ=
X-Received: by 2002:a05:6870:3293:b0:1be:ccce:7991 with SMTP id
 q19-20020a056870329300b001beccce7991mr7920824oac.13.1695367927311; Fri, 22
 Sep 2023 00:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230920015559.1877441-1-aik@amd.com> <CAK7LNARrb_NLpBL19LHEdg0WJKsncaUPQLk-wxhR+Rh8sps3jQ@mail.gmail.com>
 <a6a90c61-e884-4b18-83b7-ca3d2e0378e7@amd.com> <1f9ca335-4d34-4871-856e-e6aa8e2bc16d@amd.com>
In-Reply-To: <1f9ca335-4d34-4871-856e-e6aa8e2bc16d@amd.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 22 Sep 2023 16:31:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNARTQ1GANx2ZA1UHThOEXrtYyiAV94bwhrADFfKsKdc0Jg@mail.gmail.com>
Message-ID: <CAK7LNARTQ1GANx2ZA1UHThOEXrtYyiAV94bwhrADFfKsKdc0Jg@mail.gmail.com>
Subject: Re: [PATCH kernel] kbuild: get rid of unwanted "+" when
 CONFIG_LOCALVERSION is set
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
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

On Fri, Sep 22, 2023 at 9:59=E2=80=AFAM Alexey Kardashevskiy <aik@amd.com> =
wrote:
>
>
> On 20/9/23 23:30, Alexey Kardashevskiy wrote:
> >
> > On 20/9/23 21:59, Masahiro Yamada wrote:
> >> On Wed, Sep 20, 2023 at 10:56=E2=80=AFAM Alexey Kardashevskiy <aik@amd=
.com>
> >> wrote:
> >>>
> >>> The scripts/setlocalversion script correctly tries not adding "+" whe=
n
> >>> CONFIG_LOCALVERSION is defined.
> >>
> >> I am afraid you are misunderstanding the script.
> >
> > Possibly :) I should have read of "+set"... sorry :-/ Thanks for
> > spending time looking at this.
> >
> >> CONFIG_LOCALVERSION and the "+" sign is unrelated.
> >
> > How come?
> >
> > scripts/setlocalversion -> if [ "${LOCALVERSION+set}" !=3D "set" ] ->
> > scm_version --short -> echo "+".
> >
> > Where is that LOCALVERSION supposed to come from, and when? Is not
> > LOCALVERSION related to CONFIG_LOCALVERSION?
> >
> >>> However, instead of grepping for it
> >>> (as it is done for CONFIG_LOCALVERSION_AUTO=3Dy), it relies on
> >>> LOCALVERSION
> >>> set in the shell which is not.
> >>>
> >>> Export LOCALVERSION so scripts/setlocalversion could see it and not a=
dd
> >>> unwanted "+" at the end of the kernelrelease.
> >>>
> >>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> >>
> >>
> >> So, scripts/setlocalversion will always see
> >> defined LOCALVERSION.
> >>
> >> With your patch, LOCALVERSION would be set to an empty value,
> >> which would make the following condition always false.
> >>
> >> elif [ "${LOCALVERSION+set}" !=3D "set" ]; then
> >>
> >>
> >> Your patch is equivalent to deleting
> >> line 175-183 of scripts/setlocalversion.
> >>
> >> Of course, that is wrong and unacceptable.
> >
> > Ok. What is the right way of getting rid of the "+"? Thanks,
>
>
> make LOCALVERSION=3D"" ...
> seems to be the only way, is that right? I thought CONFIG_LOCALVERSION
> is good enough for not having "+", hmm.


Correct.

Reading the commit description of
5df99bec210a2cf89dd91e52f0d0a714bf4cd96a
makes it clearer.





Best Regards
Masahiro Yamada
