Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FD77B9853
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbjJDWqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjJDWqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:46:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE127D9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 15:46:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B76AC433C8;
        Wed,  4 Oct 2023 22:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696459570;
        bh=8ro/a0Bpol+VYScaDsgjBSknL1h5UTqtEB8kDcWMyG4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jvnJKHHo4Zwbi3zpqsrtxGJ92sSZrwqygzCu0OelPHkLTm/cKqtk7YzSw314/QR6y
         BLtw0idqiTPN+2QQjkumlEUJx47RrJAVBxAq8RvkE0gNYBn4AxH0yvV3Y90R/q2uWw
         /TqVex7OdZ4VK35V1CkiFU+eiMWGOEi35Cwv5mca4xyBhCYPWb5rxXYIw/5yUlwuya
         7oTaZLFVbM9KlruwAsBPpWgknQTO/v/HTR2IVZLzBHAEar39ZmLU+w1hTI0YWj+TxS
         8FIFxL4c59v8FlId6w+XVe5zvWikhfuLNb6xqA4E01SoPCDigvbOBYKqIxFQzg1nlM
         MMmJmwdq6IHgw==
Date:   Wed, 4 Oct 2023 15:46:09 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <hawk@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: Use SMP threads for backlog NAPI (or
 optional).
Message-ID: <20231004154609.6007f1a0@kernel.org>
In-Reply-To: <20230929162121.1822900-1-bigeasy@linutronix.de>
References: <20230929162121.1822900-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 18:20:18 +0200 Sebastian Andrzej Siewior wrote:
>    - Patch #2 has been removed. Removing the warning is still an option.
> 
>    - There are two patches in the series:
>      - Patch #1 always creates backlog threads
>      - Patch #2 creates the backlog threads if requested at boot time,
>        mandatory on PREEMPT_RT.
>      So it is either or and I wanted to show how both look like.
> 
>    - The kernel test robot reported a performance regression with
>      loopback (stress-ng --udp X --udp-ops Y) against the RFC version.
>      The regression is now avoided by using local-NAPI if backlog
>      processing is requested on the local CPU.

Not what we asked for, and it doesn't apply.
