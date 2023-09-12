Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6589C79D7CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbjILRln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjILRlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:41:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF78C1;
        Tue, 12 Sep 2023 10:41:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81422C433C7;
        Tue, 12 Sep 2023 17:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694540498;
        bh=XN9VLs/RWqIKbir9oOJKNB68E42vRN6udYWXC6xNx3g=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=AUAeaB7Xrro3wr98z/qT44pYdzgB+sn9/iogCEnYTZY26XGn2eL0GxsRDDu9sYLSf
         1EamAyK771TErgxTI0DshiQJr56K73toeoxpktx1PMkJ0je4Qs/bRXx42voXUGVeeJ
         Y2eAoCcyEvHDeAuRCawyKNFhzaaiXl1lMVqhm4NHLtoyuE7d+BG6XrfR02XnLEf4fy
         GPMbgapZIeU7YRRiYAgTBLjJ2DIIbcbsuKNRTEagA1L9xYa8H58fhQSSu3u3+CRCc0
         BSnRm5k867ea4Q3QJB38fSocyLnawl7PN6ym1u3akhHa9GtguPA7HgN/TDNvKE1p2q
         jpzIKnMGyfD8w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 20:41:33 +0300
Message-Id: <CVH4GZXQFZ1F.2V5BIZNSKQ1FA@suppilovahvero>
To:     "Jan Hendrik Farr" <kernel@jfarr.cc>,
        <linux-kernel@vger.kernel.org>
Cc:     <kexec@lists.infradead.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <dhowells@redhat.com>, <vgoyal@redhat.com>,
        <keyrings@vger.kernel.org>, <akpm@linux-foundation.org>,
        "Baoquan He" <bhe@redhat.com>, <bhelgaas@google.com>,
        <lennart@poettering.net>, "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
In-Reply-To: <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 12, 2023 at 6:32 PM EEST, Jan Hendrik Farr wrote:
> >> The format itself is rather simple. It's just a PE file (as required
> >> by the UEFI spec) that contains a small stub application in the .text,
> >> .data, etc sections that is responsible for invoking the contained
> >> kernel and initrd with the contained cmdline. The kernel image is
> >> placed into a .kernel section, the initrd into a .initrd section, and
> >> the cmdline into a .cmdline section in the PE executable.
> >
> > How does this interact with the existing EFI stub support in linux?
>
> It doesn't. During normal boot of a UKI the stub in it is used
> (systemd-stub, see:
> https://www.freedesktop.org/software/systemd/man/systemd-stub.html).
> The kernel's own EFI stub will still be in the binary inside the
> .linux section but not used.

What sort of bottleneck does the EFI stub have so that we need yet
another envelope?

BR, Jarkko
