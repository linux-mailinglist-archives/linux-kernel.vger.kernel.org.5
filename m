Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8A7A5065
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjIRRE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjIRREd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:04:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCCE18A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:04:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695056645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8i21ryYY8Uu6rEylJXazPV2JaxcnRBMxWmsiqFC1FVQ=;
        b=UahcpfZICgJ2LNRwvH/qk7FpyxzjN+DkHabOOviwPuhoHVnESq6OM7d52K84WwU9cHL330
        QVugvtSkhE4S9v34chouQbPWK2wo2DEQQQsF2b8Z0qxecRHaU0fMNJ+DL8Y1z3RcFronOW
        G3lagOkC9IA16nGWk0mHhFBomFCem6NcfjLvCtMHwGu29T0+8ksppbuC+iU7nuvG0eRPsp
        jSADRnaeg8ie8Xlb3SC9+GVlvYCIO3DFa4VC6/QpTy+7zoTYi1wSF0HPs7T08bJxcLHn4K
        ZlP9hWz1maTF2jisYiYLnomViT/ypkxWyOX77nzfEcv01utZRqI6Hnh2rQ3r6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695056645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8i21ryYY8Uu6rEylJXazPV2JaxcnRBMxWmsiqFC1FVQ=;
        b=+VMHqVmwJXifwdQNe4Rr8Wg4e5oAzLYQEMcxqdn3wG8EcX4FegSA9sr9z7ppjHCSTDJ7qW
        4iXVElO7C49CH+Dw==
To:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, vineethrp@gmail.com
Subject: Re: [PATCH 5/5] timers: Tag (hr)timer softirq as hotplug safe
In-Reply-To: <CAEXW_YQEy7o4swk3voKXsWZN7V=BuaKwrcaHft4vV56TqcxNTA@mail.gmail.com>
References: <20230912104406.312185-1-frederic@kernel.org>
 <20230912104406.312185-6-frederic@kernel.org>
 <CAEXW_YQEy7o4swk3voKXsWZN7V=BuaKwrcaHft4vV56TqcxNTA@mail.gmail.com>
Date:   Mon, 18 Sep 2023 19:04:05 +0200
Message-ID: <87pm2fxvju.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15 2023 at 21:38, Joel Fernandes wrote:
>> Therefore this error message, as far as (hr-)timers are concerned, can
>> be considered spurious and the relevant softirq vectors can be marked as
>> hotplug safe.
>
> We could:

We should :)

> Cc: stable@vger.kernel.org
>
> Since hell is breaking loose a bit because of:
> https://lore.kernel.org/all/20230831133214.XF2yjiEb@linutronix.de/T/
>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I'll pick that up tomorrow.

Thanks,

        tglx
