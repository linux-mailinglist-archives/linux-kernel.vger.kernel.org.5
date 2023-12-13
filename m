Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0E6810F40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378470AbjLMLBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378316AbjLMLBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:01:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9B210F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:01:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D4FC433C8;
        Wed, 13 Dec 2023 11:01:56 +0000 (UTC)
Date:   Wed, 13 Dec 2023 11:01:54 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: irq: set the correct node for shadow call stack
Message-ID: <ZXmPImuyntNM7a1Z@arm.com>
References: <20231213012046.12014-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213012046.12014-1-shijie@os.amperecomputing.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 09:20:46AM +0800, Huang Shijie wrote:
> The init_irq_stacks() has been changed to use the correct node:
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=75b5e0bf90bf
> 
> The init_irq_scs() has the same issue with init_irq_stacks():
> 	cpu_to_node() is not initialized yet, it does not work.
> 
> This patch uses early_cpu_to_node() to set the init_irq_scs()
> with the correct node.
> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
