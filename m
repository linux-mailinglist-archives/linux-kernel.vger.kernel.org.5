Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AA97807F4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358918AbjHRJGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358947AbjHRJGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:06:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EECEFE;
        Fri, 18 Aug 2023 02:06:00 -0700 (PDT)
Date:   Fri, 18 Aug 2023 11:05:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692349559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=797A4g137aklzqty4Q0W/9jDhfvBpZi/RjFD2RSZuXo=;
        b=4qWYuLyIWUBMRT7Lcy4sL+QAlOBfHR/yiQkAtf9V5C+CZVlnbMSOUfIs455XG3OpoYYA6o
        giHHqi1nfT+0EYstvmzz+ZChwdXxiFY9BvLMjfavkcLvOK/UmyvVktbhgFIPW4cWQCfs5S
        armnOSnxs97sksutnxKoRP5G9vy+idbAdFo3pAgfyBzBNSfbXS+mXZ4OpXDxIWkDoLv+1j
        36uaTg1xM7pXdObHxT4VZYBfSl/wCFoPViz5QOv4TJiXK/LkiqX3HRTYdI1s5xVOV/j9gH
        wN6IwZzKqX/as9KQkMl5O6dSDZqKCIIPJF2EdEVNMN2cCsAFRf2OAr8XKz6KJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692349559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=797A4g137aklzqty4Q0W/9jDhfvBpZi/RjFD2RSZuXo=;
        b=zfzsD6nibSYHMn40GYkqzcFRG6cwbAIwRB5zV+jh+bCeGel7IdK93Q2Fd1G8fvBLNe1sFZ
        Mu5zRyP77OxmxFCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] softirq: Adjust comment for CONFIG_PREEMPT_RT in #else
Message-ID: <20230818090557.NAiFBJTa@linutronix.de>
References: <169234845563.1636130.4897344550692792117.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <169234845563.1636130.4897344550692792117.stgit@firesoul>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-18 10:47:35 [+0200], Jesper Dangaard Brouer wrote:
> The #ifdef CONFIG_PREEMPT_RT #else statement had a comment
> that made me think the code below #else statement was RT code.
> After reading the code closer I realized it was not RT code.
> Adjust comment to !RT to helper future readers of the code.

indeed.

> Fixes: 8b1c04acad08 ("softirq: Make softirq control and processing RT aware")
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
