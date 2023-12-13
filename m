Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B79810889
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 04:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378392AbjLMDDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 22:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378381AbjLMDDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 22:03:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8447ED5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 19:03:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C302DC433C7;
        Wed, 13 Dec 2023 03:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1702436607;
        bh=KL+YGefPMQWTJUJcgEiowZLLsMSBdN8/Uc2RwgmG8Fw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mb8yokjfhmyagSO86j/flHconRVGwvnZRvEmkn87TiHpnoDWMlcNw0uHeU4RdvE2V
         5g/pUbK2OkMCGmRz1Vvnnlco40uP4s0TLvn4sfeMyCajnldHB898CkCfSnharG9ciO
         AiZIKqD0vUTfJWDQKS3jjPvQ/fzi55h9qFtl7RFA=
Date:   Tue, 12 Dec 2023 19:03:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bixuan Cui <cuibixuan@vivo.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH -next 2/2] mm: vmscan: add new event to trace shrink lru
Message-Id: <20231212190326.899a71c20ecfb143b84e93a6@linux-foundation.org>
In-Reply-To: <20231212032640.6968-3-cuibixuan@vivo.com>
References: <20231212032640.6968-1-cuibixuan@vivo.com>
        <20231212032640.6968-3-cuibixuan@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 19:26:40 -0800 Bixuan Cui <cuibixuan@vivo.com> wrote:

> -TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
> +TRACE_EVENT(mm_vmscan_lru_shrink_inactive_start,

Current kernels have a call to trace_mm_vmscan_lru_shrink_inactive() in
evict_folios(), so this renaming broke the build.

