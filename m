Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CF479FF32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbjINI5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbjINI46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:56:58 -0400
X-Greylist: delayed 475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 01:56:53 PDT
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8331BEF;
        Thu, 14 Sep 2023 01:56:53 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 5DD2AE801F5;
        Thu, 14 Sep 2023 10:48:56 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 0FC7C160258; Thu, 14 Sep 2023 10:48:55 +0200 (CEST)
Date:   Thu, 14 Sep 2023 10:48:55 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Jan Hendrik Farr <kernel@jfarr.cc>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>,
        bhelgaas@google.com, Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
Message-ID: <ZQLI92sQrnTC9Wel@gardel-login>
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 12.09.23 17:32, Jan Hendrik Farr (kernel@jfarr.cc) wrote:

> >> The format itself is rather simple. It's just a PE file (as required
> >> by the UEFI spec) that contains a small stub application in the .text,
> >> .data, etc sections that is responsible for invoking the contained
> >> kernel and initrd with the contained cmdline. The kernel image is
> >> placed into a .kernel section, the initrd into a .initrd section, and
> >> the cmdline into a .cmdline section in the PE executable.
> >
> > How does this interact with the existing EFI stub support in
> > linux?
>
> It doesn't. During normal boot of a UKI the stub in it is used
> (systemd-stub, see:
> https://www.freedesktop.org/software/systemd/man/systemd-stub.html). The
> kernel's own EFI stub will still be in the binary inside the .linux
> section but not used.

That's not true actually, if the inner kernel supports the EFI stub
then systemd-stub actually defers to that for kernel execution. It's
more portable that way, since the kernel then deals with the
differences in the boot protocol on different architectures.

Lennart

--
Lennart Poettering, Berlin
