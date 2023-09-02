Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C18C79095F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 21:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjIBTeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 15:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjIBTeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 15:34:36 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833DD10E0
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 12:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693683269;
        bh=T1sQaIchalcyp583pf5sV11Kf4LDPeU4kP1oH6wI+gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=IZrgehuqx0+JodoC60w4GOMhiAinxHF3kqGSxLo2Evbe+bln7bmFpwRIV8mlPFwd/
         q63zX9lKIh42u3+zlknEF/MWdg2HaopOkDKFHRIJKFe1FGYM5QHxag2svqUVgOO5om
         BEDw/NqWpWTVqFc2AORoHi185Mo/+XTLHLFaalAMmB6HtzJ+n70dcYQsxsLQjAv+KI
         MJQyy0L0BZyyqOdoOIStf9bpMdl4BaScXXa7SxkAWhzxDDcMlY0gcwZ6OQ1TOM/0/Y
         UxnTZ/FgUr/fnxPqeyAEtiVksfTZTmD2bP9zpXtTNnF/9yLQmZBlYVy0H5IUq7gISX
         2OSuSZp6VJOkw==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id A9A1924B3D2;
        Sun,  3 Sep 2023 02:34:26 +0700 (WIB)
Date:   Sun, 3 Sep 2023 02:34:22 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        David Laight <David.Laight@aculab.com>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 2/4] tools/nolibc: x86-64: Use `rep stosb` for
 `memset()`
Message-ID: <ZPOOPjK+z847Ivq4@biznet-home.integral.gnuweeb.org>
References: <20230902133505.2176434-1-ammarfaizi2@gnuweeb.org>
 <20230902133505.2176434-3-ammarfaizi2@gnuweeb.org>
 <CAOG64qNB+aRU+8VCD5MkM4srQaUnTqzZ7rZ8USxVheDAYzgTsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOG64qNB+aRU+8VCD5MkM4srQaUnTqzZ7rZ8USxVheDAYzgTsQ@mail.gmail.com>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 02:28:18AM +0700, Alviro Iskandar Setiawan wrote:
> nit: Be consistent. Use \n\t for the memset too.

Good catch, I'll fix that in v4 revision.

-- 
Ammar Faizi

