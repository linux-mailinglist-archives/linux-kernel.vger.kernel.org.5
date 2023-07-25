Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5A76228A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjGYTjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGYTjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:39:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19257273B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:38:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67E5461787
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AA6C433C8;
        Tue, 25 Jul 2023 19:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690313923;
        bh=GoUXo6/o1PnTsEABLRvNQd0YtZcxL3kR3vakvLywyl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GnH1ULa9D14vIeeYWINMZ/8t1jpb7mg8AiXD57d9ifxw1V/KZRVPn/iM65+Ns5z4y
         zaxsTnsd3OwTcgKVAWibNfbTYXVAUkUGq8JyFr9uIrCQL1SerZRJpLOWLgCTHNs9AA
         HFJUnBm8JBJkp8qtKGhWr7edvTOA54o4LiSOtg8xETu0iZ3AQyTkN/I+C0O/1lVZow
         wI9dtYWOISe9tAp17z56v3wgCPPR7qmdEw6LEQQfLXsZ/rASIECsGpjjkT1k0zFgXd
         /kp1ZpR3WzXPorhc7tur7l0aB3Vk1AeE/lvT/9w4WY28ARLykHGOF5TBe2wj3WObQK
         4qrcz2gJLAdtg==
Date:   Tue, 25 Jul 2023 12:38:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Lin Ma <linma@zju.edu.cn>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/sched: mqprio: Add length check for
 TCA_MQPRIO_{MAX/MIN}_RATE64
Message-ID: <20230725123842.546045f1@kernel.org>
In-Reply-To: <d02a90c5ca1475c27e06d3d592bac89ab17b37ea.camel@perches.com>
References: <20230724014625.4087030-1-linma@zju.edu.cn>
        <20230724160214.424573ac@kernel.org>
        <63d69a72.e2656.1898a66ca22.Coremail.linma@zju.edu.cn>
        <20230724175612.0649ef67@kernel.org>
        <d02a90c5ca1475c27e06d3d592bac89ab17b37ea.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 20:59:53 -0700 Joe Perches wrote:
> > Joe, here's another case.  
> 
> What do you think the "case" is here?
> 
> Do you think John Fastabend, who hasn't touched the file in 7+ years
> should be cc'd?  Why?

Nope. The author of the patch under Fixes.
