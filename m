Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944567CC9EB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjJQR3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjJQR3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:29:22 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1B3113
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:29:19 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9ac31cb051so6395496276.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697563758; x=1698168558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1ro9HlJSCZOnQY3V+1VmfmbVpDBOi+uN5Fq4ETuRqg=;
        b=deAuIb4pEhjm6eBPy09V3tBAICS79bZ60HcDl2EaptWgOX65CHSTtunZZBxZywbUxc
         7f/LQE141m184U03smIc9cArPvIvNYDioVqhTS+gfnVqBeUF9afNOp16zXYcDEeWe5vr
         EqdXfpM6LQWgrJhH0Tsl67FUAhZp26IVs6T3bMgKMU8V6wv9YGhB+rL36JPgLuYVYq73
         petuYj48JGDAZMHz/6hXb4+5JgL7/m6oIlqO+QeoJrBUGJc4CMSPtDfyqOV6p62xxonx
         Iy7WCVQP07odKbIUI/GZKYzITHpkahyoCLxVvrjmQaxVKPWlBdM1IUcYIn/TbocVdrFe
         Gd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697563758; x=1698168558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1ro9HlJSCZOnQY3V+1VmfmbVpDBOi+uN5Fq4ETuRqg=;
        b=Y5iqc29pjj/JI8VF+aA7UAEEoVbX09o7hKwcuXa+3mEiBY2VldElTyotW6YsfOjh+n
         HhwCcYv28i8IjKgSpJdK8+OQyec7GBb85y9DDfNARPsSRgWYPunKgVLo/LY9G6vase3V
         SuY+qBZlQN3CmvIiX0tSswmxseC3U+6D66BtFFk7UyjHKX6KvdEfKiTTlrHJPwQA/M0n
         cJvL2+4qYahh3X4bA3aQ4uY9J1e+VRbXaRAKPEcR/uvoDh6WIk0x7iLQVWvZExsz4jAB
         UxjWIWR8WG6yPAkSW1WzZvqL5YGHHUoMuw27Cdr4hopEVKxg6SjSgRPxnp0hq48a/ald
         9mbQ==
X-Gm-Message-State: AOJu0Yx1xdgafUK0kNiMQLysWuzrrqQgcM6CnG43JMhQLe3uvCXkPxeL
        FCRY9NMRmGnzN49seo+1Eef19OTnW4vmULWbMthq
X-Google-Smtp-Source: AGHT+IE20i63zTruAYA/HeKI6xRC7P5Iphgvp7RwIHUvJvGWCiFiihYJF7iPPrjTqS0EbJ0jsUao4v+7X57KlQGZQNY=
X-Received: by 2002:a25:2383:0:b0:d9a:3bbb:8602 with SMTP id
 j125-20020a252383000000b00d9a3bbb8602mr2572828ybj.64.1697563757988; Tue, 17
 Oct 2023 10:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
 <ba2f5560800608541e81fbdd28efa9875b35e491.camel@linux.ibm.com>
 <932231F5-8050-4436-84B8-D7708DC43845@oracle.com> <7335a4587233626a39ce9bc8a969957d7f43a34c.camel@linux.ibm.com>
 <FD6FB139-F901-4E55-9705-E7B0023BDBA8@oracle.com> <1149b6dbfdaabef3e48dc2852cc76aa11a6dd6b0.camel@linux.ibm.com>
 <4A0505D0-2933-43BD-BEEA-94350BB22AE7@oracle.com> <20230913.Ceifae7ievei@digikod.net>
 <D0F16BFD-72EB-4BE2-BA3D-BAE1BCCDCB6F@oracle.com> <20230914.shah5al9Kaib@digikod.net>
 <20231005.dajohf2peiBu@digikod.net> <d3b51f26c14fd273d41da3432895fdce9f4d047c.camel@linux.ibm.com>
 <CAHC9VhRdU1CZJpPSEdSmui-Xirr0j261K=+SM7KiDwiPG-JSrQ@mail.gmail.com> <a851227aaa75ab16b0d6dd93433e1ee1679715f9.camel@linux.ibm.com>
In-Reply-To: <a851227aaa75ab16b0d6dd93433e1ee1679715f9.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 Oct 2023 13:29:07 -0400
Message-ID: <CAHC9VhS_Ttdy5ZB=jYdVfNyaJfn_7G1wztr5+g0g7uUDForXvA@mail.gmail.com>
Subject: Re: RFC: New LSM to control usage of x509 certificates
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 1:09=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Tue, 2023-10-17 at 11:45 -0400, Paul Moore wrote:
> > On Tue, Oct 17, 2023 at 9:48=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Thu, 2023-10-05 at 12:32 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > > > > > > A complementary approach would be to create an
> > > > > > > LSM (or a dedicated interface) to tie certificate properties =
to a set of
> > > > > > > kernel usages, while still letting users configure these cons=
traints.
> > > > > >
> > > > > > That is an interesting idea.  Would the other security maintain=
ers be in
> > > > > > support of such an approach?  Would a LSM be the correct interf=
ace?
> > > > > > Some of the recent work I have done with introducing key usage =
and CA
> > > > > > enforcement is difficult for a distro to pick up, since these c=
hanges can be
> > > > > > viewed as a regression.  Each end-user has different signing pr=
ocedures
> > > > > > and policies, so making something work for everyone is difficul=
t.  Letting the
> > > > > > user configure these constraints would solve this problem.
> > >
> > > Something definitely needs to be done about controlling the usage of
> > > x509 certificates.  My concern is the level of granularity.  Would th=
is
> > > be at the LSM hook level or even finer granaularity?
> >
> > You lost me, what do you mean by finer granularity than a LSM-based
> > access control?  Can you give an existing example in the Linux kernel
> > of access control granularity that is finer grained than what is
> > provided by the LSMs?
>
> The current x509 certificate access control granularity is at the
> keyring level.  Any key on the keyring may be used to verify a
> signature.  Finer granularity could associate a set of certificates on
> a particular keyring with an LSM hook - kernel modules, BPRM, kexec,
> firmware, etc.  Even finer granularity could somehow limit a key's
> signature verification to files in particular software package(s) for
> example.
>
> Perhaps Micka=C3=ABl and Eric were thinking about a new LSM to control us=
age
> of x509 certificates from a totally different perspective.  I'd like to
> hear what they're thinking.
>
> I hope this addressed your questions.

Okay, so you were talking about finer granularity when compared to the
*current* LSM keyring hooks.  Gotcha.

If we need additional, or modified, hooks that shouldn't be a problem.
Although I'm guessing the answer is going to be moving towards
purpose/operation specific keyrings which might fit in well with the
current keyring level controls.

--=20
paul-moore.com
