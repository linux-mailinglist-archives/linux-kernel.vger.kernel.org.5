Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCE0790E25
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348457AbjICVUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjICVUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:20:09 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4878AAD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:20:04 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 383LJga1031746;
        Sun, 3 Sep 2023 23:19:42 +0200
Date:   Sun, 3 Sep 2023 23:19:42 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Ammar Faizi'" <ammarfaizi2@gnuweeb.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 0/4] nolibc x86-64 string functions
Message-ID: <20230903211942.GA31739@1wt.eu>
References: <20230902133505.2176434-1-ammarfaizi2@gnuweeb.org>
 <e4862b01c0e4440f949e240360e438a3@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4862b01c0e4440f949e240360e438a3@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 08:38:22PM +0000, David Laight wrote:
> From: Ammar Faizi
> > Sent: 02 September 2023 14:35
> > 
> > This is an RFC patchset v3 for nolibc x86-64 string functions.
> > 
> > There are 4 patches in this series:
> > 
> > ## Patch 1-2: Use `rep movsb`, `rep stosb` for:
> >     - memcpy() and memmove()
> >     - memset()
> > respectively. They can simplify the generated ASM code.
> 
> It is worth pointing out that while the code size for 'rep xxxb'
> is smaller, the performance is terrible.
> The only time it is ever good is for the optimised forwards
> copies on cpu that support it.
> 
> reverse, stos and scas are always horrid.

It's terrible compared to other approaches but not *that* bad. Also we
absolutely don't care about performance here, rather about correctness
and compact size.

Regards,
Willy
