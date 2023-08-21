Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500BD782715
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjHUKaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjHUKaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:30:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFFEDB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:30:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0c:5a83:9103:1700:7ffc:59a:ffce:ded])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7AAF76606EFD;
        Mon, 21 Aug 2023 11:30:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692613811;
        bh=3/SpDn4E/YYhiEBouzxukYNTQ4Iz0kF66TTL4tJYLSo=;
        h=From:To:Cc:Cc:Subject:References:In-reply-to:Date:From;
        b=nu2b9sg+XBfDx+1Q6998faAp9JCeba9ElDRqA99Thl8OOW5W87WK6Kh8TBPiZdLLM
         4nJQNWPYRcjkxhe5ga5g5mblRa6HQYT6mGp1neY0LM08ma/SZHUQCUTyd7W3XNNFr2
         7clr28GaKyo3QJ5hMg+4CETFKOXc60qx1vn1ZjYBvcEwDpVrrpwZ04xZ1lSS0NcrK8
         1En56btg2BKo1uSaFQy7nzh46JfCx4MJsKRRHaRJpN0YOPDuhXacZs2RzFJGLZGJxi
         NYnGETNYtXz+1jsBsj2FA3ePlSPolqf/phixY6r/uT9qwNIgxNs9fHLWkLl4HLtHo8
         Huic0ZIG2jWiQ==
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernelci@lists.linux.dev, gregkh@linuxfoundation.org,
        thorsten@leemhuis.info, regressions@lists.linux.dev
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: Re: Kernel regression tracking/reporting initiatives and KCIDB
References: <874jljhtmj.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me> <c7120c90-e40b-0433-0175-f23f928daa50@collabora.com> <87o7j4hjqc.fsf@collabora.com> <517c702f-5b75-b999-2224-bc27951f03f3@collabora.com>
In-reply-to: <517c702f-5b75-b999-2224-bc27951f03f3@collabora.com>
Date:   Mon, 21 Aug 2023 12:30:08 +0200
Message-ID: <87jztohemn.fsf@collabora.com>
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

On vie, ago 18 2023 at 22:11:52, Guillaume Tucker <guillaume.tucker@collabora.com> wrote:
> KernelCI is not any CI, it's designed to be the main system for
> the upstream kernel.  So it already took the high-level approach
> to look at all this after becoming an LF project and we came up
> with KCIDB and now the new API as the community still needs
> an "active" system and not just a database for collecting data
> from other systems.

That sounds good and I think that's the way to go, but does that mean
that, in theory, most or all current CI systems (0-day, CKI, etc) will
"push" their results to the new KernelCI in the future?

> Right, except you might hit another deprecation hurdle if we
> start changing how things are designed around KCIDB and the new
> API.  There's no doubt KCIDB will be supported for a long time,
> but taking into considerations all the new developments can save
> you a lot of trouble.

So, if using KCIDB as a data source is not a good idea right now, do you
have any suggestions on how to keep contributing to the improvement of
regression analysis?

If the new KernelCI API is already working with a large enough
regression database maybe this analysis work can be plugged into the
pipeline and we can start working on that.

> My point here is that KernelCI started tackling this issue of
> reporting kernel bugs several years ago at a very high level and
> we've come up with some carefully engineered solutions for it, so
> it looks like you're walking in our footsteps now.  The new web
> dashboard, new API & Pipeline and KCIDB which pioneered working
> outside the native realm of KernelCI provide some answers to the
> challenges you're currently investigating.  So maybe it is
> actually the best strategy for you to carry on doing things
> independently, but it would seem to me like due diligence for
> each of us to know what others are doing.

I surely must have missed most of those discussions but I couldn't find
any traces of the functionalities I listed either in a design document
or implemented anywhere. We certainly wouldn't have started this stream
of work if we knew this was already a work in progress. If there are
already concrete plans and some kind of design for this, let me know so
we can contribute to it.

If the solutions that have been engineered so far are still unplanned,
then I agree it'll be better to keep improving on this
independently. But in order to do that we'd need to be able to use other
data sources (KCIDB). Then, once the new KernelCI is ready to implement
these functionalities we can try to move them there after they've been
tested independently.

Cheers,
Ricardo
