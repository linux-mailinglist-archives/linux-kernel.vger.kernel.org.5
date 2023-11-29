Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0165B7FE316
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjK2WZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjK2WZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:25:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729752137
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:24:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4025EC433C8;
        Wed, 29 Nov 2023 22:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701296627;
        bh=fEXq9E8HmJBtiL8syNoj8Vbn8l4dQ40YP+5YhnLV0Ug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p85de6TjKrzSuMxCk7vCrt0nm7vVwuO17usm2SverDaBt/fW0T0gQ+I34dSYpgWk4
         cxlL1oAEbTUUu6md7D41xK215v7YgzhPYGmgZPhiGVKsHo/lY2HCn7DlxkJl+kLSfH
         Rt61YCWDZtqg4yTn5/ZLBnL2lSPWdQdgqeXnlorE=
Date:   Wed, 29 Nov 2023 14:23:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, eric_devolder@yahoo.com,
        agordeev@linux.ibm.com, bhe@redhat.com, kernel-team@cloudflare.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] kexec: drop dependency on ARCH_SUPPORTS_KEXEC from
 CRASH_DUMP
Message-Id: <20231129142346.594069e784d20b3ffb610467@linux-foundation.org>
In-Reply-To: <20231129220409.55006-1-ignat@cloudflare.com>
References: <20231129220409.55006-1-ignat@cloudflare.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 22:04:09 +0000 Ignat Korchagin <ignat@cloudflare.com> wrote:

> Fixes: 91506f7e5d21 ("arm64/kexec: refactor for kernel/Kconfig.kexec")
> Cc: stable@vger.kernel.org # 6.6+: f8ff234: kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
> Cc: stable@vger.kernel.org # 6.6+

I doubt if anyone knows what the two above lines mean.  What are your
recommendations for the merging of this patch?

> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

