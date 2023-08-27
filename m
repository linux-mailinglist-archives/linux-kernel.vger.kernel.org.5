Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74D789BC9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjH0HX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjH0HX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:23:27 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DA11B9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 00:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693120979;
        bh=kzUoAhHfZFWTCDtFqzcZ9hB5Rub2uXiCOZnjvCKM8Jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YYk9wK4rBqWtT03jynEXBPUMlxyeSUcm38XVKYpFZnYtHnbsckuhe+8XmCmBnGMSg
         bpoMBHbDECLOrg+PNYCBK9vh6SZzGVAKJmaxT/Zs5ke+l7iEvayiaRo6i6GfhMcw8Q
         lQZSSX0ej5OQAdxwfOcudKyBR36viM0mJAnFV62FR+cmF/3ewWM2DLQUBy1gcCtUT5
         bqcw1FQQXFCvJ5XwsVcLq9jF4uhNIEKhKcXC4WTEJAOV0YXVV9RkEDVTMb6P22P8Rm
         mI+86xfL2dNZwnIEkHQgyFnhjA1TrbXDwiiZC4Lj3Q9ltUT0zMIJ5BZN938AkMP0PC
         dFY3o62EqPZnw==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id A4FD124B1DA;
        Sun, 27 Aug 2023 14:22:56 +0700 (WIB)
Date:   Sun, 27 Aug 2023 14:22:51 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] tools/nolibc: i386: Fix a stack misalign bug on
 _start
Message-ID: <ZOr5y9HaSXZV6jvN@biznet-home.integral.gnuweeb.org>
References: <20230826141632.1488740-1-ammarfaizi2@gnuweeb.org>
 <20230826141632.1488740-2-ammarfaizi2@gnuweeb.org>
 <f67cedfc-f275-4b26-b27d-c5c506fe0e85@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f67cedfc-f275-4b26-b27d-c5c506fe0e85@t-8ch.de>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 08:53:26AM +0200, Thomas Weiﬂschuh wrote:
> Afaik references to commits in commit messages are supposed to follow
> the same format as in the Fixes: tag.

Copied.

> Thanks for the fix!
> 
> In general:
> 
> Acked-by: Thomas Weiﬂschuh <linux@weissschuh.net>

I'll fix the reference format, append your acked by tag, and explain
more about the logic behind 'sub $12, %esp' in v2.

I'm currently traveling, will send the v2 revision on Monday morning
Jakarta time.

> Also a Link: tag for the Reported-by: would be nice.

I would have linked the discussion if the report were on the list.
Unfortunately, Nicholas reported it offlist.

-- 
Ammar Faizi

