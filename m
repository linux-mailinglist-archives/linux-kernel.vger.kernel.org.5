Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B487C6701
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377651AbjJLHXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343583AbjJLHXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:23:35 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6873CB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1697095410;
        bh=I16mHlBi0UiXdmmXtHHwF2XNoaCVoxqfrxpRLsstsrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lW84ZnfJYRbDKljTVPpqhbTdJcY0Jl02XKTPbKvU6ve6TaFGZ0djpGAHODqWLPD2F
         aCZ/wCnOSxdCmjc7OEuYNKZ9MoWc0q7bZQnmdBka9+Z5PazNGeWKkGeKxjmVFWDeDw
         2U5PZ/nSonQ6OvsGxr8k0KYzg22b2oOHyfFz8hH0=
Date:   Thu, 12 Oct 2023 09:23:29 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add tests for multi-object linkage
Message-ID: <bfc17e76-fcbc-4ce6-97a8-c1ed72ed2a67@t-8ch.de>
References: <20231012-nolibc-linkage-test-v1-1-315e682768b4@weissschuh.net>
 <ZSea+etQwlxbi+Ok@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSea+etQwlxbi+Ok@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy, Paul,

On 2023-10-12 09:06:33+0200, Willy Tarreau wrote:
> On Thu, Oct 12, 2023 at 01:13:37AM +0200, Thomas Weißschuh wrote:
> > While uncommon, nolibc executables can be linked together from multiple
> > compilation units.
> > Add some tests to make sure everything works in that case.
> (...)

[..]

> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > Note:
> > 
> > This depends on path "tools/nolibc: mark start_c as weak".
> > https://lore.kernel.org/lkml/20231012-nolibc-start_c-multiple-v1-1-fbfc73e0283f@weissschuh.net/
> 
> For these two patches: Acked-by: Willy Tarreau <w@1wt.eu>

Thanks, applied locally.

I guess the linked patch "tools/nolibc: mark start_c as weak" should
also go into nolibc/fixes.

@Paul, would it introduce too much churn for you if I submit another
nolibc pull with an updated nolibc/fixes?
(And the rebased nolibc/next with this commit while we are at it)

Thomas
