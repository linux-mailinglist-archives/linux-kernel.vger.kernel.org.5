Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E84C7FB55B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjK1JO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjK1JOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:14:55 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B0BACC;
        Tue, 28 Nov 2023 01:14:58 -0800 (PST)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1r7uBE-0007T6-00; Tue, 28 Nov 2023 10:14:56 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A4070C0136; Tue, 28 Nov 2023 10:00:24 +0100 (CET)
Date:   Tue, 28 Nov 2023 10:00:24 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Wujie Duan <wjduan@linx-info.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mark symbols static where possible for mips/kernel
Message-ID: <ZWWsKBmjMKYZtWpu@alpha.franken.de>
References: <20231128071225.801111-1-wjduan@linx-info.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128071225.801111-1-wjduan@linx-info.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 03:12:25PM +0800, Wujie Duan wrote:
> We get 1 error when building kernel with -Werror=missing-prototypes

check git grep setup_sigcontext arch/mips/

With this patch n32 support doesn't build. We need a prototype in a header
to fix that.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
