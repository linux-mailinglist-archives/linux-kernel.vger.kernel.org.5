Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC25C7E624D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjKICky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKICkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:40:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60682D58
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 18:40:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B574C433C8;
        Thu,  9 Nov 2023 02:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699497651;
        bh=2sXfghKvvs+1Sf+834EoQ/nNY3FKvk1JNShHQLfkGcs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oF1AKSitNOeVvDE6ffaLVBtrkkZnT6zVxHa8RDBtgVb+NMi7ItmbWwK+wkYBt13oF
         pxP8yIL5UKFt7/FDfNT9L75GS9GCpG8xVMp5T/cYDIluwZ/XZl4Z0tSWkrU1LdFdtE
         CH9RCjHookBzGAUz8vIY6KDdBRsd5G+M3ub9JEUAVLmdshbR5KoLLxh4roX+PieSuh
         4uKKOgDotKgwm2+hYmZeR6W2CJbE9pruNlSqb/I0dc5I4wze0AQpdF+KELRgrvXE9V
         /V+Y0k92AerOIBu4OtsEftYzGaCLT3RVjC9dyuJKQI0h+0L5GYrdxeo+FDDzq0sxhb
         ee+0z6VroHKtw==
Date:   Wed, 8 Nov 2023 18:40:49 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Andrey Shumilin <shum.sdl@nppct.ru>
Cc:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, khoroshilov@ispras.ru,
        ykarpov@ispras.ru, vmerzlyakov@ispras.ru, vefanov@ispras.ru
Subject: Re: [PATCH] iphase: Adding a null pointer check
Message-ID: <20231108184049.1f27de01@kernel.org>
In-Reply-To: <20231107123600.14529-1-shum.sdl@nppct.ru>
References: <20231107123600.14529-1-shum.sdl@nppct.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Nov 2023 15:36:00 +0300 Andrey Shumilin wrote:
> The pointer <dev->desc_tbl[i].iavcc> is dereferenced on line 195.
> Further in the code, it is checked for null on line 204.
> It is proposed to add a check before dereferencing the pointer.

How do you know this is the right way to address the problem.
Much easier to debug a crash than misbehaving driver.

This is ancient code, leave it be.
-- 
pw-bot: reject
pv-bot: nit
