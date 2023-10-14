Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72207C9319
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjJNHOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNHOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:14:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EF6BB;
        Sat, 14 Oct 2023 00:14:28 -0700 (PDT)
Date:   Sat, 14 Oct 2023 09:14:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697267667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xbnbh99yvU7jmpVxBKvgmPJFoeFC8l82RIMouf6GW24=;
        b=SBLKtjiYviFjveDjRb79mJyxqapQGgfrGoHxycbxNOE2Fx56SiFEglWX4Z+srnhA39LBC9
        j8gWwA4026XEr4N5xgZeV/vldWNo6AIaeyMoDv0B+AUqVa1PKruF9c8NQscARdJBDrf4Wa
        FPmksb863QBpNNH5Tog6eniPPmgR/GpVl7+fyo+ZUzloSFQpRWGCwDV91MjKA9cjTdb5Rh
        zKzFCcwDnU1z3OySo+uFCqYB1U2gPrfwMoac4EUjfEnf8pXQF2BKvQerJy5WdMJF/Ztnsh
        fPtDURRSjfUEPTqu0lnoiG+R28vH+W+cqvZhZs78/z8w2BrZoT5xHMglF4BjTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697267667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xbnbh99yvU7jmpVxBKvgmPJFoeFC8l82RIMouf6GW24=;
        b=nfCw1hp2mjdEYlYTl1kbXXZXVkQCKhmYbw6+QD1OshrBYdosdg7ivbBHLGcOE+FOwu6l/g
        J7kWFgWAwoMJjCAQ==
From:   Nam Cao <namcao@linutronix.de>
To:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Cc:     outreachy@lists.linux.dev, manishc@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, coiby.xu@gmail.com,
        gregkh@linuxfoundation.org, netdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: Add bool type to qlge_idc_wait()
Message-ID: <20231014071423.UgDor1v0@linutronix.de>
References: <ZSoxLxs45bIuBrHg@gilbert-PC>
 <20231014065813.mQvFyjWb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014065813.mQvFyjWb@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 08:58:13AM +0200, Nam Cao wrote:
> On Sat, Oct 14, 2023 at 07:11:59AM +0100, Gilbert Adikankwu wrote:
> > Reported by checkpatch:
> > 
> > WARNING: else is not generally useful after a break or return
> >
> 
> What checkpatch is telling you here is that the "else" is redundant and
> can be removed. Although your patch suppresses the warning, it makes the
> code messier :(

Ah wait, after reading Julia's comment, I realize that the "else" is not
redundant at all. Seems like checkpatch.pl is lying. So ignore what I
said.
