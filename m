Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD9377A458
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 02:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjHMA1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 20:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHMA0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 20:26:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3A0FC
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 17:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 562C061B29
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 00:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D6FC433C7;
        Sun, 13 Aug 2023 00:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691886399;
        bh=lk4ujpyD6hcWRHEtPzLbQveuf5POXSu2Rnzy7nxxUko=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bxLK+W8ON2OpMQpgGPf38ohj4WTKOwBOU4tue1v4k8Wznf8M4yLN7/u/4UWe5wAkR
         R94tLHXwqsFXnTnq+V6j/w2zp+bjKSH9LnyeIDc6YKE4DR2xBWwNLtxS6PQi3+q1bW
         YMcdWmzX6Urkia1n3fBmwmrycPUZM98v01ZJ5wc/F0k6OqczwW8SGWoI4jymuWtEGG
         cjepx4D+k4H3lqXPT6Y7HYHGrVUCflqNR7iaBed68KJ1WRQ/ekAh6uXFSEmmZfFXV6
         RNsTJcy1NpY6Ta2HPXlsvrLc/2fi1F4s6Qq3alANc9xEzEihIVPzPMLikkq/FxxGJq
         vQguKrARebhtQ==
Message-ID: <cf34c2e5-8218-871b-750e-319c1b5482d3@kernel.org>
Date:   Sun, 13 Aug 2023 08:26:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] f2fs: should update REQ_TIME for direct write
Content-Language: en-US
To:     Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com
References: <1691656800-21616-1-git-send-email-zhiguo.niu@unisoc.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1691656800-21616-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/10 16:40, Zhiguo Niu wrote:
> The sending interval of discard and GC should also
> consider direct write requests; filesystem is not
> idle if there is direct write.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
