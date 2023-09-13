Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B784079EB77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbjIMOpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241371AbjIMOpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:45:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B745998;
        Wed, 13 Sep 2023 07:45:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECECBC433C8;
        Wed, 13 Sep 2023 14:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694616315;
        bh=21jb4SlwYggpUuBiHB+zXUXjDoCem9aDhvc2KROaIus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTqruD+X6hP2710U2cq7ErV4IDgLCUlUCWLvSmOE6Ep8OovA2ChYfFMIMvYwcPnO1
         HUfBCu4SeqpY/uOUyO28R6fXHq329sPuQGg18Jmwy0kfx+gA+B+TWtKMMg2mqsO3dN
         PSxqroGSrpXJTgLxCF3Dvc4XoRYrqps5ziIX1iSfuziF2s8gzCCAfrUeKOtJHW5GYi
         1Knq/V8EW07fns8+rNRuyyQASjp+D1WkIGgEgJcsWXC+NJtLOsWx1X7tdQt67NE22l
         VXV5EflSahPQ3M2RW5iIm0y8/Mmy+7T0uB7OLGJB+jJN0JfwIEPPOqcFR8W+l9HjAV
         EdLj4cWXNY4Fw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 17:45:10 +0300
Message-Id: <CVHVCHYZT8KG.3L0IH30QYT0WH@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jan Hendrik Farr" <kernel@jfarr.cc>,
        <linux-kernel@vger.kernel.org>
Cc:     <kexec@lists.infradead.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <dhowells@redhat.com>, <vgoyal@redhat.com>,
        <keyrings@vger.kernel.org>, <akpm@linux-foundation.org>,
        "Baoquan He" <bhe@redhat.com>, <bhelgaas@google.com>,
        <lennart@poettering.net>, "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
 <CVH4GZXQFZ1F.2V5BIZNSKQ1FA@suppilovahvero>
 <5a67051d-eb21-4a96-acc4-40f829a59e23@app.fastmail.com>
 <CVH6NGLENMPH.271W6X80061M@suppilovahvero>
 <1c342231-7672-450e-b945-e57cd17b4ae7@app.fastmail.com>
In-Reply-To: <1c342231-7672-450e-b945-e57cd17b4ae7@app.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 12, 2023 at 11:49 PM EEST, Jan Hendrik Farr wrote:
>
> > These are sort of "tautological" arguments. There must be some
> > objective reasons why this architecture was chosen instead of
> > other (i.e. using what already pre-exists).
>
> I think I misunderstood you in my earlier reply. I do not understand
> in what way you think my arguments are tautological. Can you
> elaborate?

current Linux kernel has these features *already* in
place:

1. CONFIG_EFI_STUB
2. CONFIG_CMDLINE
3. CONFIG_INITRAMFS_SOURCE
4. Secure boot with MOK keys and .machine keyring to manage them.

Given that every single feature in IKU does exists in some form
in the Linux kernel, I think it is fair to ask why scrape away
this all existing science and reinvent the wheel?

If your reponse is "systemd", it is a tautological answerk, i.e.
same as sayig that "it is good because it is good". Not very
motivating.

BR, Jarkko



