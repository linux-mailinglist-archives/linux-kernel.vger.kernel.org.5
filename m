Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BC47A0316
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbjINLwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbjINLwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:52:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63919CC3;
        Thu, 14 Sep 2023 04:52:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94620C433C7;
        Thu, 14 Sep 2023 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694692351;
        bh=bY6gpFweje0TA1EJp0zihUndohZBvlaM4pTha0LTaaA=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=HEzvOyz2sdB5n75zpEBiYGCwixAXK/g6GTkdVt1HW5h1rdduTfBe1HUp3E3NRRfvu
         /jCvLAk6vSoQoX4WKjqZC15948pOwjOnsN+LfWxeGDgeAc4y1brfY+0DznTwvxBtc9
         On4Bbg+brNk6wsD7A1xlikvORVdB49qu2NYVpnbyg4kX9bmBQP7ZyqpiJpBr/QYTn3
         Kw8UzLpetjgjWhmOJL+yne6upNiPNS7DDUv9R6sqQv2xT5mTU7HdadcrIYzcA6LIy7
         nqXRk7dzZKtbQjg+PdcG8LJFRuCbvug99Y0v6jCiudlEQzr+yJKgEEo9m1C3WVsr1w
         RqX16PtPLdVwQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 14 Sep 2023 14:52:26 +0300
Message-Id: <CVIMAS87EVVY.27PMG6YI8CBLY@suppilovahvero>
Cc:     <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <x86@kernel.org>, <tglx@linutronix.de>, <dhowells@redhat.com>,
        <vgoyal@redhat.com>, <keyrings@vger.kernel.org>,
        <akpm@linux-foundation.org>, "Baoquan He" <bhe@redhat.com>,
        <bhelgaas@google.com>, "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Lennart Poettering" <mzxreary@0pointer.de>,
        "Jan Hendrik Farr" <kernel@jfarr.cc>
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
 <ZQLI92sQrnTC9Wel@gardel-login>
In-Reply-To: <ZQLI92sQrnTC9Wel@gardel-login>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Sep 14, 2023 at 11:48 AM EEST, Lennart Poettering wrote:
> On Di, 12.09.23 17:32, Jan Hendrik Farr (kernel@jfarr.cc) wrote:
>
> > >> The format itself is rather simple. It's just a PE file (as required
> > >> by the UEFI spec) that contains a small stub application in the .tex=
t,
> > >> .data, etc sections that is responsible for invoking the contained
> > >> kernel and initrd with the contained cmdline. The kernel image is
> > >> placed into a .kernel section, the initrd into a .initrd section, an=
d
> > >> the cmdline into a .cmdline section in the PE executable.
> > >
> > > How does this interact with the existing EFI stub support in
> > > linux?
> >
> > It doesn't. During normal boot of a UKI the stub in it is used
> > (systemd-stub, see:
> > https://www.freedesktop.org/software/systemd/man/systemd-stub.html). Th=
e
> > kernel's own EFI stub will still be in the binary inside the .linux
> > section but not used.
>
> That's not true actually, if the inner kernel supports the EFI stub
> then systemd-stub actually defers to that for kernel execution. It's
> more portable that way, since the kernel then deals with the
> differences in the boot protocol on different architectures.

OK, that's nice.

> Lennart
>
> --
> Lennart Poettering, Berlin

BR, Jarkko
