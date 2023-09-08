Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4E79863F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 13:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbjIHLCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 07:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjIHLCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 07:02:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2513A11B;
        Fri,  8 Sep 2023 04:02:18 -0700 (PDT)
Date:   Fri, 8 Sep 2023 13:02:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694170935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u+LAvGWnlgALt4uSfxPrpnW9XB5xanSlh3Wm88mPH1M=;
        b=bAw9ZvUBN6TeWE5b7Ji/AFYwnDD88klJUTWzSxQs0ExFegHbRJcw1wkw1C6qp9zKG/YaHD
        XAT3B5I7/cXyMjjYiUVleTTHVESocpNYXrCH8eP3dqekoP6OSDhAiKzig/WfdV1jfJKzef
        Cugeo90WsIsy58dU1kpyH/KIjcoFVaXTHpdJczFhxq4NyET7Q/6jEwncMlAO7Jt6aACJZz
        qEFAj8SvHLwN5dBGwFksRR8b+skXyOwNPnrrMRSij+DEovmL7XilknszzqWlqDmFIHEQuR
        GeoTP7XxnxrZjfKvm5/fnhTYksJQAnnNWGc19QHZmjdz6jaJWtKUR7B2gVVbIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694170935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u+LAvGWnlgALt4uSfxPrpnW9XB5xanSlh3Wm88mPH1M=;
        b=r7pLo9/FiDxztwP8QDcDQnFy8BsJHgbTJQUDkUm1crfEcI/ToTE96VFxffihWprdLGJBUQ
        tn51hIsQ0cU+FSDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
        alexander.duyck@gmail.com, ilias.apalodimas@linaro.org,
        linyunsheng@huawei.com
Subject: Re: [PATCH net v3] octeontx2-pf: Fix page pool cache index
 corruption.
Message-ID: <20230908110212.wmeihrv9@linutronix.de>
References: <20230908025309.45096-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908025309.45096-1-rkannoth@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-08 08:23:09 [+0530], Ratheesh Kannoth wrote:
> Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

You keep loosing these :)

Sebastian
