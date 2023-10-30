Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885AA7DB31F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjJ3GND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjJ3GNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:13:00 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE26B7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SOF4+PcgGPb+gmIIwjzNN4MW7Y6OXy/4z0Y3hzoww/k=;
  b=bpRdTC9evxq++pSHCC7JZIzJIFMcbUGe8q4kMVeutURj1tNxbNxu7u2W
   dSqhLhx67Wv8+7n/tfl2cYuvulFUdcaP6UqnoyIHCaLKAoNGI0bIeUiAo
   IfO3fgUk0CG8SmnhN6X4398qwz7sFDMbVKmDtpkkym7cUWysxXNuewjwM
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,262,1694728800"; 
   d="scan'208";a="133817206"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 07:12:54 +0100
Date:   Mon, 30 Oct 2023 07:12:54 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Dorine Tipo <dorine.a.tipo@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nick Terrell <terrelln@fb.com>,
        Daniel Stone <daniels@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Linux Outreachy <outreachy@lists.linux.dev>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH Resend] Fix line Length
In-Reply-To: <ZT7v39jG4WTxPYjm@debian.me>
Message-ID: <alpine.DEB.2.22.394.2310300712310.3533@hadrien>
References: <20231029144312.5895-1-dorine.a.tipo@gmail.com> <alpine.DEB.2.22.394.2310291610030.3136@hadrien> <ZT7v39jG4WTxPYjm@debian.me>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Oct 2023, Bagas Sanjaya wrote:

> On Sun, Oct 29, 2023 at 04:11:01PM +0100, Julia Lawall wrote:
> >
> >
> > On Sun, 29 Oct 2023, Dorine Tipo wrote:
> >
> > > Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
> > >
> > > Fix the line lengths of lines 8 and 49
> >
> > The Signed off by line should be here, below the log message.  Please see
> > the patches sent by others.
> >
> > >  export IGT_FORCE_DRIVER=${DRIVER_NAME}
> > >  export PATH=$PATH:/igt/bin/
> > > -export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib/aarch64-linux-gnu/:/igt/lib/x86_64-linux-gnu:/igt/lib:/igt/lib64
> > > +export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib/aarch64-linux-gnu/:/igt/lib/x86_64-linux-gnu
> > > +export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib:/igt/lib64
> >
> > There was a suggestion that it was better to keep this as one line.
> >
>
> Hi Julia,
>
> The submitter touched one of CI scripts for the DRM subsystem. To test
> this patch, there must be a way to run these scripts locally (which
> may requires non-trivial setup).
>
> Cc'ed DRM maintainers.

There is a DRM outreachy project.  I think that motivated this patch.

julia
