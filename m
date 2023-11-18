Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539717F0150
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 18:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjKRRgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 12:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRRgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 12:36:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B850612B
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 09:36:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8162BC433C8;
        Sat, 18 Nov 2023 17:36:12 +0000 (UTC)
Date:   Sat, 18 Nov 2023 17:36:09 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH 2/2] kmemleak: add checksum to backtrace report
Message-ID: <ZVj2CRI7452gm6lH@arm.com>
References: <20231116224318.124209-1-jim.cromie@gmail.com>
 <20231116224318.124209-3-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116224318.124209-3-jim.cromie@gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 03:43:18PM -0700, Jim Cromie wrote:
> Change /sys/kernel/debug/kmemleak report format slightly, adding
> "(extra info)" to the backtrace header:
> 
> from: "  backtrace:"
> to:   "  backtrace (crc <cksum>):"
> 
> The <cksum> allows a user to see recurring backtraces without
> detailed/careful reading of multiline stacks.  So after cycling
> kmemleak-test a few times, I know some leaks are repeating.
> 
>   bash-5.2# grep backtrace /sys/kernel/debug/kmemleak | wc
>      62     186    1792
>   bash-5.2# grep backtrace /sys/kernel/debug/kmemleak | sort -u | wc
>      37     111    1067
> 
> syzkaller parses kmemleak for "unreferenced object" only, so is
> unaffected by this change.  Other github repos are moribund.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
