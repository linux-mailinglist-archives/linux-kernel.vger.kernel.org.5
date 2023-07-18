Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB827585BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjGRTrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGRTrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:47:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188D81992
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:47:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3AF660B45
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DC7C433C8;
        Tue, 18 Jul 2023 19:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689709642;
        bh=a4umGYRDvYDJZM2/mBq+3qEU9SR1eriRi+EkCDcNGjU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K5CNPLK9e8vCAo7aFILV9ozJohcg7nnWMvl5pB65ehZXOqkShwlyngOSt2Ca6s4lK
         APKiJ2llRnyWv1Y/cKuem5d+Tr5daQ7a2TIhpED/Vsny4Z7eaSblY2vvF1MjHV/Sdl
         mnwKnPRd+oU34Oa4YjjpQJzRRgad9qLI83X4UTwbjMWnl8lLNcsUygp/uXJfSM48SS
         2kZ95rCXxq3TPAvoQxUZ+/huYfn8lVJ9q4i6ow7V6Y6/2TYFUubHaExNZztybe0jKG
         sT76VYgTI+x4aE1xB0p7FZ66qs8hBdIDgld8Bp0Fp7PAn0s5d6x/Z4x3KHXCdLNgmU
         QV4KccAFgTIfA==
Date:   Tue, 18 Jul 2023 12:47:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     shijie001@208suo.com
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Fix errors in af_llc.c
Message-ID: <20230718124721.7e8510f3@kernel.org>
In-Reply-To: <7da2f0c57e848c77ab30a948dc73653a@208suo.com>
References: <tencent_4CED92D1C8320CEA29489ED8DFEF3614EB05@qq.com>
        <7da2f0c57e848c77ab30a948dc73653a@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 13:48:33 +0800 shijie001@208suo.com wrote:
> The following checkpatch errors are removed:
> ERROR: "foo* bar" should be "foo *bar"
> ERROR: space required before the open parenthesis '('
> 
> Signed-off-by: Jie Shi <shijie001@208suo.com>

Please don't send checkpatch fixes to networking.
Your patches are whitespace damaged.

We had an influx of similar changes recently.
Are you part of some organized effort?
-- 
pw-bot: reject
