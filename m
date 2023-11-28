Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7137FB990
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344566AbjK1Los (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344132AbjK1Lor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:44:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BD7D56
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:44:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA56C433C8;
        Tue, 28 Nov 2023 11:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701171888;
        bh=guVQnjvPaV+z42jgf62dWWfF0TqriCPnTjAgzPyzxms=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d/aYqu6vn5DDREA/9VJfY02ukaUiOZ+PPaAzqolR/aOMxdiATKsY8+PtgFUGGLYbU
         6L4qRE6VRlGiFT41Xr5D7u4rvpnEMBlX3U+pRH+YuVJvSSiet0VB2Vn/9iTE6+Wrub
         XXwWkFA3Q2jBqVXoIdw8h+9ocDX86mv1vBZ/ovtjdNFs7e1+tZSXa18ZHnAt20v4hu
         0ZsT6IxMZGpSmArYjjSDfLS+CMh6wAMjVcrjWMtDeP7KQ9+wazyz4SgkwFMxxv8m5K
         L7tk0R08kr8HWfM+d4hu8bCXVshlra0vLQvpAtrBQxR8d+KPVpdFPT3/M844UMaJVu
         P5Xnrb+LC76kA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1fa1c3755afso1426293fac.1;
        Tue, 28 Nov 2023 03:44:48 -0800 (PST)
X-Gm-Message-State: AOJu0YwzDLkysMKcmPLP6Eo29LZnWfFxQK4bRvTqpBwjOoVOwGkraUFM
        QTzdyPfoTaGZs4k8yA2/ZOYjhatAklX8JH3Lk4U=
X-Google-Smtp-Source: AGHT+IE++xAdjjagU/hso0TxHFl08NatL1qvkjh/s1wbEKplR9/ZY/+K3LxbRaf3aAa9WEkpkfiMyftS8jxLOMfya70=
X-Received: by 2002:a05:6870:6c0b:b0:1f9:5310:90ab with SMTP id
 na11-20020a0568706c0b00b001f9531090abmr7776846oab.3.1701171888137; Tue, 28
 Nov 2023 03:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20231122235527.180507-1-kent.overstreet@linux.dev>
 <CAK7LNASQ+btvNOZ8yU6JLXBHVzPaEwj-7z0_dFouw2EUKd=3uA@mail.gmail.com> <20231125195620.rjgkooixugucv2vp@moria.home.lan>
In-Reply-To: <20231125195620.rjgkooixugucv2vp@moria.home.lan>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 28 Nov 2023 20:44:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3_rk7xysSGnzq1carsght6gziyCnwEX=fjXy-KwhQEg@mail.gmail.com>
Message-ID: <CAK7LNAT3_rk7xysSGnzq1carsght6gziyCnwEX=fjXy-KwhQEg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Allow gcov to be enabled on the command line
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001842ac060b34f29a"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001842ac060b34f29a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 4:56=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Fri, Nov 24, 2023 at 11:02:00AM +0900, Masahiro Yamada wrote:
> > On Thu, Nov 23, 2023 at 8:55=E2=80=AFAM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > This allows gcov to be enabled for a particular kernel source
> > > subdirectory on the command line, without editing makefiles, like so:
> > >
> > >   make GCOV_PROFILE_fs_bcachefs=3Dy
> > >
> > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > Cc: Nicolas Schier <nicolas@fjasle.eu>
> > > Cc: linux-kbuild@vger.kernel.org
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > ---
> > >  scripts/Kbuild.include | 10 ++++++++++
> > >  scripts/Makefile.lib   |  2 +-
> > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> > > index 7778cc97a4e0..5341736f2e30 100644
> > > --- a/scripts/Kbuild.include
> > > +++ b/scripts/Kbuild.include
> > > @@ -277,3 +277,13 @@ ifneq ($(and $(filter notintermediate, $(.FEATUR=
ES)),$(filter-out 4.4,$(MAKE_VER
> > >  else
> > >  .SECONDARY:
> > >  endif
> > > +
> > > + # expand_parents(a/b/c) =3D a/b/c a/b a
> > > +expand_parents2 =3D $(if $(subst .,,$(1)),$(call expand_parents,$(1)=
),)
> > > +expand_parents  =3D $(1) $(call expand_parents2,$(patsubst %/,%,$(di=
r $(1))))
> > > +
> > > +# flatten_dirs(a/b/c) =3D a_b_c a_b a
> > > +flatten_dirs =3D $(subst /,_,$(call expand_parents,$(1)))
> > > +
> > > +# eval_vars(X_,a/b/c) =3D $(X_a_b_c) $(X_a_b) $(X_a)
> > > +eval_vars =3D $(foreach var,$(call flatten_dirs,$(2)),$($(1)$(var)))
> >
> >
> >
> > I do not like tricky code like this.
> >
> > Also, with "fs_bcachefs", it is unclear which directory
> > is enabled.
>
> It's consistent with how we can specify options in makefiles for a
> particular file.


It is consistent in a bad way.

You used "GCOV_PROFILE_" prefix
for the full directory path, while it is already
used as a file name which is relative to the
current directory.



>
> I suppose CONFIG_GCOV_PROFILE_DIRS would be fine, but your patch isn't
> complete so I can't test it.


I do not understand what you mean by "isn't complete".

It is just a matter of adding the config entry somewhere.

I added a patch just in case, though.


Note, both approach pros and cons.


The command line approach works for external modules.


With the CONFIG option approach, you can easily see
which directories are profiled by checking the .config,
but it is not easy to enable gcov for external modules.







--=20
Best Regards
Masahiro Yamada

--0000000000001842ac060b34f29a
Content-Type: text/x-patch; charset="US-ASCII"; name="per-dir-gcov.diff"
Content-Disposition: attachment; filename="per-dir-gcov.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lpi9qfrq0>
X-Attachment-Id: f_lpi9qfrq0

ZGlmZiAtLWdpdCBhL2tlcm5lbC9nY292L0tjb25maWcgYi9rZXJuZWwvZ2Nvdi9LY29uZmlnCmlu
ZGV4IDA0ZjRlYmRjM2NmNS4uYzk1ZDkzMTg5ZWNjIDEwMDY0NAotLS0gYS9rZXJuZWwvZ2Nvdi9L
Y29uZmlnCisrKyBiL2tlcm5lbC9nY292L0tjb25maWcKQEAgLTM3LDYgKzM3LDEwIEBAIGNvbmZp
ZyBHQ09WX0tFUk5FTAogY29uZmlnIEFSQ0hfSEFTX0dDT1ZfUFJPRklMRV9BTEwKIAlkZWZfYm9v
bCBuCiAKK2NvbmZpZyBHQ09WX1BST0ZJTEVfRElSUworCXN0cmluZyAiRGlyZWN0b3JpZXMgdG8g
ZW5hYmxlIGdjb3YgcHJvZmlsaW5nIgorCWRlcGVuZHMgb24gR0NPVl9LRVJORUwKKwogY29uZmln
IEdDT1ZfUFJPRklMRV9BTEwKIAlib29sICJQcm9maWxlIGVudGlyZSBLZXJuZWwiCiAJZGVwZW5k
cyBvbiAhQ09NUElMRV9URVNUCmRpZmYgLS1naXQgYS9zY3JpcHRzL01ha2VmaWxlLmxpYiBiL3Nj
cmlwdHMvTWFrZWZpbGUubGliCmluZGV4IDFhOTY1ZmU2OGUwMS4uNWQ4MGY3ODRiOTIyIDEwMDY0
NAotLS0gYS9zY3JpcHRzL01ha2VmaWxlLmxpYgorKysgYi9zY3JpcHRzL01ha2VmaWxlLmxpYgpA
QCAtMTQ3LDggKzE0NywxMiBAQCBfY3BwX2ZsYWdzICAgICA9ICQoS0JVSUxEX0NQUEZMQUdTKSAk
KGNwcGZsYWdzLXkpICQoQ1BQRkxBR1NfJCh0YXJnZXQtc3RlbSkubGRzKQogIyAoaW4gdGhpcyBv
cmRlcikKICMKIGlmZXEgKCQoQ09ORklHX0dDT1ZfS0VSTkVMKSx5KQoraWZuZXEgKCQoZmlsdGVy
ICQob2JqKSwkKENPTkZJR19HQ09WX1BST0ZJTEVfRElSUykpLCkKK2V4cG9ydCBHQ09WX1BST0ZJ
TEVfU1VCRElSIDo9IHkKK2VuZGlmCisKIF9jX2ZsYWdzICs9ICQoaWYgJChwYXRzdWJzdCBuJSws
IFwKLQkJJChHQ09WX1BST0ZJTEVfJChiYXNldGFyZ2V0KS5vKSQoR0NPVl9QUk9GSUxFKSQoQ09O
RklHX0dDT1ZfUFJPRklMRV9BTEwpKSwgXAorCQkkKEdDT1ZfUFJPRklMRV8kKGJhc2V0YXJnZXQp
Lm8pJChHQ09WX1BST0ZJTEUpJChHQ09WX1BST0ZJTEVfU1VCRElSKSQoQ09ORklHX0dDT1ZfUFJP
RklMRV9BTEwpKSwgXAogCQkkKENGTEFHU19HQ09WKSkKIGVuZGlmCiAK
--0000000000001842ac060b34f29a--
