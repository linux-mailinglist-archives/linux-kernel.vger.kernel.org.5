Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1E178C438
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjH2MZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbjH2MZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:25:35 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B42C3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693311932;
        bh=TSL2x4KYn5kiCcXqC7AbSu6awyvCZ6o6QeX6Y/f2s+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZefByI09onel6PHszcx2Hkx0xzXjlNyPNjAZv5D5UF8Lp1cUTtbGBMPZMGkREo3U8
         YVqB2n7MB6W8+HrzkbMlTWY6vcJlcogGFw6tW2tW+UCwja8oPxZf0aIt9LA6GwPjZf
         Mw1Xs2A6s1846fTfuuy+Xh/28KXGaKcLSFou+erZ5KnqbOcNr8+Y4w+7nOCDFjjP9u
         UQjPubC93DRAejuE+3GO/kHDPXLotLIVpITTulAo4dA1W+qXiA4AbbzYFYqxFJ2vO5
         cLN4WxgNPtQuAsJW/sdYnI9TK9yd07ceHmlMfNE1ZgVmkaiTbrFCvnHeJWNIrO8+c1
         pXTGXETh0sXIQ==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 6874024B211;
        Tue, 29 Aug 2023 19:25:29 +0700 (WIB)
Date:   Tue, 29 Aug 2023 19:25:25 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] tools/nolibc: i386: Fix a stack misalign bug on
 _start
Message-ID: <ZO3jtQoEs7Lm6Aan@biznet-home.integral.gnuweeb.org>
References: <20230828070240.1691921-2-ammarfaizi2@gnuweeb.org>
 <20230829083732.5981-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829083732.5981-1-falcon@tinylab.org>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 04:37:32PM +0800, Zhangjin Wu wrote:
> As Thomas suggested and you replied, since there is no public report
> link, what about uses the link which has test code at the end of above
> paragraph.
> 
>     ...
>     instruction (e.g., movdqa, movaps, and vmovdqa) [1].

OK, I'll add the link in v3.

-- 
Ammar Faizi

