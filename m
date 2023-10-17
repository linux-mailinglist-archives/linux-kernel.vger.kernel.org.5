Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755607CC7CF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344277AbjJQPqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbjJQPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:46:06 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B17410A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:45:51 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7ac4c3666so71706697b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697557551; x=1698162351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mrgPXshN0v6qqkRfhdm7z++OcXc8cz4EqlaMatvDL4=;
        b=Y+7Tt7h+hxvay5+yY0XwfwxvEwvC1rwyUBnqH6sFMgEth05lz/zC9WMXxw7oDNbnMk
         XJmM9PD8Rq2oDMAT0+73d88mCtMg3S5Z+JjcMw4hrZnh6acmdOdLmjbEmKmVYfiODRLH
         Uo21Z8o+/DPowcTUs1CeDBkNTfjodR/N1plj1hlL/31d89Zud6oAgbEbsiwTInHqIouT
         rRM1ZFKXe2Vko+dMlSPVcnZ2N8+gwESESSmCUGksSR8Z3C0cL2TAfM/a12KpT8OQnr+S
         U5a8KtrzN7hPtbCRaZMwpE7mOZdUqV/Pa8fwJ/ZYAeI8SAfzd17VK1tWCrvFhhjpOqWc
         orUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697557551; x=1698162351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mrgPXshN0v6qqkRfhdm7z++OcXc8cz4EqlaMatvDL4=;
        b=TGYoC3zOBslIzcAYYPJajHSW/VF28SsYYfAR4RqqYFwoR5X5LcBYiTxU2nV9vSSZBN
         vmXmdLoLQp25RjjpLRefyT8Tk28sUHw/OulYXc6cvP1htK7L5Pf7mkSKO3gmj8dmO4zO
         TVHRCHRom4XVZCkr1YhsN7P8SWFGDdsEGIZXqAAHyiSP48nrtmY+O0ZUc0D2gbUkCS2F
         t8ci5foKk0PRYozf33ucG79upDImmbkuR57Cf1JegiMzqwpLDdfKAPHh206LnsXrmz6f
         1bY2hh7TB1kCV7WKLudm1VHn5sewT5HuP5OQ9s5SttMTlJf5A0BsgSMAKGfIyRVSU4DR
         VIaQ==
X-Gm-Message-State: AOJu0YwEsYlO3SrpsjF4aFYNYFuyoayCk6nZOds+kYGFjI2ICrABilRg
        wfgedGh/CUF1Dc4NqLIn9mm9ktKxwFxmdLyhRQmD
X-Google-Smtp-Source: AGHT+IGHRxj2dP4KvVblGmde8rkHCNUaoyj84XhV8ASt9OQHBcIZq+PiPzhrUnobB2KaHgLd0Lat/LiyB1T8gyOqrHg=
X-Received: by 2002:a25:c712:0:b0:d9a:52ee:6080 with SMTP id
 w18-20020a25c712000000b00d9a52ee6080mr2021464ybe.37.1697557551094; Tue, 17
 Oct 2023 08:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
 <ba2f5560800608541e81fbdd28efa9875b35e491.camel@linux.ibm.com>
 <932231F5-8050-4436-84B8-D7708DC43845@oracle.com> <7335a4587233626a39ce9bc8a969957d7f43a34c.camel@linux.ibm.com>
 <FD6FB139-F901-4E55-9705-E7B0023BDBA8@oracle.com> <1149b6dbfdaabef3e48dc2852cc76aa11a6dd6b0.camel@linux.ibm.com>
 <4A0505D0-2933-43BD-BEEA-94350BB22AE7@oracle.com> <20230913.Ceifae7ievei@digikod.net>
 <D0F16BFD-72EB-4BE2-BA3D-BAE1BCCDCB6F@oracle.com> <20230914.shah5al9Kaib@digikod.net>
 <20231005.dajohf2peiBu@digikod.net> <d3b51f26c14fd273d41da3432895fdce9f4d047c.camel@linux.ibm.com>
In-Reply-To: <d3b51f26c14fd273d41da3432895fdce9f4d047c.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 Oct 2023 11:45:40 -0400
Message-ID: <CAHC9VhRdU1CZJpPSEdSmui-Xirr0j261K=+SM7KiDwiPG-JSrQ@mail.gmail.com>
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

On Tue, Oct 17, 2023 at 9:48=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Thu, 2023-10-05 at 12:32 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > > > > A complementary approach would be to create an
> > > > > LSM (or a dedicated interface) to tie certificate properties to a=
 set of
> > > > > kernel usages, while still letting users configure these constrai=
nts.
> > > >
> > > > That is an interesting idea.  Would the other security maintainers =
be in
> > > > support of such an approach?  Would a LSM be the correct interface?
> > > > Some of the recent work I have done with introducing key usage and =
CA
> > > > enforcement is difficult for a distro to pick up, since these chang=
es can be
> > > > viewed as a regression.  Each end-user has different signing proced=
ures
> > > > and policies, so making something work for everyone is difficult.  =
Letting the
> > > > user configure these constraints would solve this problem.
>
> Something definitely needs to be done about controlling the usage of
> x509 certificates.  My concern is the level of granularity.  Would this
> be at the LSM hook level or even finer granaularity?

You lost me, what do you mean by finer granularity than a LSM-based
access control?  Can you give an existing example in the Linux kernel
of access control granularity that is finer grained than what is
provided by the LSMs?

--=20
paul-moore.com
