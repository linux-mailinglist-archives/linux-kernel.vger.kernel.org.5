Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ABB7F2D65
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjKUMj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjKUMjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:39:55 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A708138;
        Tue, 21 Nov 2023 04:39:50 -0800 (PST)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1r5Q2f-0001Uc-00; Tue, 21 Nov 2023 13:39:49 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 48821C0136; Tue, 21 Nov 2023 13:38:26 +0100 (CET)
Date:   Tue, 21 Nov 2023 13:38:26 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, YunQiang Su <syq@debian.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: process: Remove lazy context flags for new kernel
 thread
Message-ID: <ZVykwhGE/aqjcpaK@alpha.franken.de>
References: <20231026111715.1281728-1-jiaxun.yang@flygoat.com>
 <ZTvQGs/lEpizUFLh@aurel32.net>
 <ZVjaDTcjNpD3m0cC@aurel32.net>
 <ZVuuqAUJ7f2ELIYW@alpha.franken.de>
 <c9e2daa2-65a8-445e-bace-ab750f04411a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9e2daa2-65a8-445e-bace-ab750f04411a@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 12:27:11PM +0000, Jiaxun Yang wrote:
> > I don't like the patch doing too much code restructing. I can't
> To reproduce, you can just install Debian sid and build kitinerary with

I found an io_uring test program, which triggers it. Now my loongson3
machine needs pressing reset in a remote location... is there a way
to configure it to start automatically after power-off/power-on ?

> sbuild. However, it seems like loongson3_defconfig won't expose this
> problem, you'll have to build kernel with Debian's config.

CONFIG_IO_URING=y

that's the needed config option.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
