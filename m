Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059FA7F5E07
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345124AbjKWLje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345152AbjKWLjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:39:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF0810EC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:39:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC4AC433C7;
        Thu, 23 Nov 2023 11:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700739563;
        bh=QllpA71/m3DBpJ/yfnnpubGoAGIk5DmgA+EnjTDr7ng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gj/UEVwPr5PLINBZ3FBaWtVfaDSZso5fypwqc04eYMrLDYsFZWvQowjPtuvTBgpPR
         bjVQiIUvospkT8g/gT0QkkBq4j9lv8dibDyu8qUe0A7a/1og4h57QvdaaW6f+FIh7Y
         C7QiP4B+kzMfEffkZHraU5ZrIxeHIyGp3mOZ0h2AejevXJMGZTU5g5+ty3fGqNHyS8
         lo/XFix2EKwzdHlj81v3QLNdDf58oRxGvfo7YSZQcqLrJeSGWXg5zf1OZ3qLiBn8Tj
         /T8JTrl0icYDjLmvUOFPZHF97u7M6WjcdjElNCIQjb/0vbSwPeH5aa3NccW1AmKjzu
         MJCavJlMdb3mQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-586a516755aso840359eaf.0;
        Thu, 23 Nov 2023 03:39:23 -0800 (PST)
X-Gm-Message-State: AOJu0YzbBGGrLzmVC8p19Xka3MREZ9hL2OUU3JKTUGlXWwdydCOVASNn
        lndiYRRBhIevjYASMrwylhatiwv8o2K/yYHxh9Q=
X-Google-Smtp-Source: AGHT+IGqtC15M6xqNqKZmc2P1jTPcQMFaV0PDtxFsXWZPjArdo+QLHfFuuX4xII9x0O/UY5wPUZPkdgZ6toBnXANgHI=
X-Received: by 2002:a05:6870:aa99:b0:1e9:f0c5:4496 with SMTP id
 gr25-20020a056870aa9900b001e9f0c54496mr1181250oab.1.1700739562527; Thu, 23
 Nov 2023 03:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20231118025748.2778044-1-mmaurer@google.com> <CAK7LNAQt8fy5+vSwpd1aXfzjzeZ5hiyW7EW9SW7pbG2eTJZAOA@mail.gmail.com>
 <CAGSQo00hyCTVsqHtrzKBBPvuH38z5yRm_4jzdi00C0RV+8APwQ@mail.gmail.com> <2023112314-tubby-eligibly-007a@gregkh>
In-Reply-To: <2023112314-tubby-eligibly-007a@gregkh>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 23 Nov 2023 20:38:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT-OcaCi6tqPRgZxPXOV6u+YbaO_0RxtfmrVXPzdrio0Q@mail.gmail.com>
Message-ID: <CAK7LNAT-OcaCi6tqPRgZxPXOV6u+YbaO_0RxtfmrVXPzdrio0Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] MODVERSIONS + RUST Redux
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Matthew Maurer <mmaurer@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
        rust-for-linux@vger.kernel.org, Laura Abbott <laura@labbott.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 6:05=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Nov 22, 2023 at 01:04:09PM -0800, Matthew Maurer wrote:
> > > So, even if you enable CONFIG_MODVERSIONS,
> > > nothing is checked for Rust.
> > > Genksyms computes a CRC from "int foo", and
> > > the module subsystem confirms it is a "int"
> > > variable.
> > >
> > > We know this check always succeeds.
> > >
> > > Why is this useful?
> > The reason this is immediately useful is that it allows us to have Rust
> > in use with a kernel where C modules are able to benefit from MODVERSIO=
NS
> > checking. The check would effectively be a no-op for now, as you have c=
orrectly
> > determined, but we could refine it to make it more restrictive later.
> > Since the
> > existing C approach errs on the side of "it could work" rather than "it=
 will
> > work", I thought being more permissive was the correct initial solution=
.
>
> But it's just providing "fake" information to the CRC checker, which
> means that the guarantee of a ABI check is not true at all.
>
> So the ask for the user of "ensure that the ABI checking is correct" is
> being circumvented here, and any change in the rust side can not be
> detected at all.
>
> The kernel is a "whole", either an option works for it, or it doesn't,
> and you are splitting that guarantee here by saying "modversions will
> only work for a portion of the kernel, not the whole thing" which is
> going to cause problems for when people expect it to actually work
> properly.
>
> So, I'd strongly recommend fixing this for the rust code if you wish to
> allow modversions to be enabled at all.
>
> > With regards to future directions that likely won't work for loosening =
it:
> > Unfortunately, the .rmeta format itself is not stable, so I wouldn't wa=
nt to
> > teach genksyms to open it up and split out the pieces for specific func=
tions.
> > Extending genksyms to parse Rust would also not solve the situation -
> > layouts are allowed to differ across compiler versions or even (in rare
> > cases) seemingly unrelated code changes.
>
> What do you mean by "layout" here?  Yes, the crcs can be different
> across compiler versions and seemingly unrelated code changes (genksyms
> is VERY fragile) but that's ok, that's not what you are checking here.
> You want to know if the rust function signature changes or not from the
> last time you built the code, with the same compiler and options, that's
> all you are verifying.
>
> > Future directions that might work for loosening it:
> > * Generating crcs from debuginfo + compiler + flags
> > * Adding a feature to the rust compiler to dump this information. This
> > is likely to
> >   get pushback because Rust's current stance is that there is no abilit=
y to load
> >   object code built against a different library.
>
> Why not parse the function signature like we do for C?
>
> > Would setting up Rust symbols so that they have a crc built out of .rme=
ta be
> > sufficient for you to consider this useful? If not, can you help me und=
erstand
> > what level of precision would be required?
>
> What exactly does .rmeta have to do with the function signature?  That's
> all you care about here.




rmeta is generated per crate.

CRC is computed per symbol.

They have different granularity.
It is weird to refuse a module for incompatibility
of a symbol that it is not using at all.




> thanks,
>
> greg k-h




--
Best Regards
Masahiro Yamada
