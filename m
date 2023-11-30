Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD447FF76D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345843AbjK3Q4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345897AbjK3Q4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:56:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A02610F2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:56:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C48C433C9;
        Thu, 30 Nov 2023 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701363418;
        bh=jNTamNThZ0rAs2o+KORaTzGsMmcQ2kdIW/zV+pisW9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ep5mfn6/d/046KNhMrPxYSVs2b/H1SbZQJJM57P3hzC8hmlHC+aL7jEbzQHe/bzLV
         ZDl9UEr14ekcpfCJk6RDza5apPq9i/1g5VSUREK4wQ/5Ib8LBFZY5NsHmgDKwcsJd5
         raSV/4nqny+fZeQRHQXL35saZ9wB+AO2cAuRD2YA=
Date:   Thu, 30 Nov 2023 08:56:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Vivek Goyal <vgoyal@redhat.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, eric_devolder@yahoo.com
Subject: Re: [PATCH 1/2] kexec: fix KEXEC_FILE dependencies
Message-Id: <20231130085657.6f7f500cc17b663747e4ee76@linux-foundation.org>
In-Reply-To: <ZUNXxp9AIkjQkP9s@MiWiFi-R3L-srv>
References: <20231023110308.1202042-1-arnd@kernel.org>
        <ZTe8NOgAjvKDA6z0@MiWiFi-R3L-srv>
        <b71034f4-5cdc-44e0-b72f-1a8ffae0593e@app.fastmail.com>
        <ZUNXxp9AIkjQkP9s@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 16:03:18 +0800 Baoquan He <bhe@redhat.com> wrote:

> > > CONFIG_KEXEC_FILE, but still get purgatory code built in which is
> > > totally useless.
> > >
> > > Not sure if I think too much over this.
> > 
> > I see your point here, and I would suggest changing the
> > CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY symbol to just indicate
> > the availability of the purgatory code for the arch, rather
> > than actually controlling the code itself. I already mentioned
> > this for s390, but riscv would need the same thing on top.
> > 
> > I think the change below should address your concern.
> 
> Since no new comment, do you mind spinning v2 to wrap all these up?

This patchset remains in mm-hotfixes-unstable from the previous -rc
cycle.  Eric, do you have any comments?  Arnd, do you plan on a v2?  If
not, should I merge v1?  If so, should I now add cc:stable?
