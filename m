Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760C878DE37
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbjH3S7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244959AbjH3ONZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:13:25 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95FC122
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693404802;
        bh=e8EboqZptFPY7KxQhU7IuozNgzgxOwr0ilKOSAn1id4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=l+2JYOAbqKiK/KGYWNDCQ/Z8hsfwQkZnLPIY1RJPPUh+ZmtaLP6NTewZrH4xM3UNu
         8JH1b0TqfcfmxRmr9f3RRmc1yjFjxyAQPXsloX8L+gFVN3oBiELEArGjtB83Qrstfn
         C+pk+aOydsLI6FkCXfG/WJHsdRlSKj+oU6Pv3Md46mA3Z9aXKPeCfkAObeDagTqsUD
         R7rAAU9R96DDCEAKWyhY5N/27nky05ZLkZYqnNIrAJaMMk1rQhbs1yLjS0sT53hBDi
         MrPeMNmtRsZYBLT1VtF+ZxXrB7XgcusU8nMZ62gYyknDkCniQGvgiFMoDFd+Hp3VpH
         6ZWCP+dybvlTQ==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 7921E24B2B0;
        Wed, 30 Aug 2023 21:13:19 +0700 (WIB)
Date:   Wed, 30 Aug 2023 21:13:14 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 2/5] tools/nolibc: x86-64: Use `rep stosb` for
 `memset()`
Message-ID: <ZO9Oeq0bHU+NU29D@biznet-home.integral.gnuweeb.org>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <20230830135726.1939997-3-ammarfaizi2@gnuweeb.org>
 <CAOG64qMkQJ-znXbeBz=zubhbonzEKtzJ5y6xQZPvXUpkC-=TDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOG64qMkQJ-znXbeBz=zubhbonzEKtzJ5y6xQZPvXUpkC-=TDg@mail.gmail.com>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 09:08:05PM +0700, Alviro Iskandar Setiawan wrote:
> The first instruction could be:
> 
>    movl %esi, %eax
> 
> That's smaller. Also, the second argument of memset() is an int
> anyway, so there is no need to have a full 64-bit copy of %rsi in
> %rax.

Agree, noted.

-- 
Ammar Faizi

