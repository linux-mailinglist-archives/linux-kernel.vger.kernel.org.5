Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60422785ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbjHWOg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbjHWOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:36:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641BEE54
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE012625F3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A567C433C7;
        Wed, 23 Aug 2023 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692801384;
        bh=3vKRFxMpMI5yaOvDQPnrpGOwF6nSbpLAclelBBQ6V9s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uPazOo5YyV2vNg/R3LirVOwa559pagwW8i9iqnN+cn/YcDI8Q7rxsPIPRLoXKTqzR
         asvZ6ZHRqQVGU3RYFWevceokG2RZjI1jog9RM57cGUTahfYDg26VydNcKKHE3rI1hY
         vhoSZR6oSKhNRWFd8M5wqUSHPoyTKPvtS2pUGPv6v3utjek8+WmcQVktrg10IeYON4
         79oOhRBh1cPzzw+W+QHOj2VNCX3kzx+PJjMcN4DFigDnY1T+qKuM25Oy3+gE+qe55p
         hOOuFsS9yRhdQUIs+0PLS3uiDUNOcsYqn3T69cdK1MrJMn0ui0rFDmXjezZfFocSxR
         Lc1NxqA3ZroJQ==
Message-ID: <d27f6e4d-2a9f-e7cc-be23-ad710aa22bb6@kernel.org>
Date:   Wed, 23 Aug 2023 22:36:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs: refine warning messages for data I/Os
Content-Language: en-US
To:     Ferry Meng <mengferry@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230809060637.21311-1-mengferry@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230809060637.21311-1-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/9 14:06, Ferry Meng wrote:
> Don't warn users since -EINTR is returned due to user interruption.
> Also suppress warning messages of readmore.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
