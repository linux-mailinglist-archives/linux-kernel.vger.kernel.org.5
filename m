Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD1980EFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376473AbjLLPIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376461AbjLLPIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:08:19 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F8CAA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/ViUfK5Qr+atc+6M7L5mu3NaL5ELpYL5fC4EkoScI0k=;
  b=oP6sHml1sTlA4Bk/6Ezha0+OpcjEZiYoeDpglw1Ku8biOQCqDINVza8/
   cmxCGzNo34i0rLmIATmFyiF1l/yV73LBcieC5jnFP4Q1CR7fFUJwxH+vF
   KpaoEwWrvpqam0xCCbT7sQ83EnGVTq0ayI9o9MtBEWMfszc2bG6PGkfil
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,270,1695679200"; 
   d="scan'208";a="74197563"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 16:08:24 +0100
Date:   Tue, 12 Dec 2023 16:08:22 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Ivan Vecera <ivecera@redhat.com>
cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Failed to start Raise network interfaces error
In-Reply-To: <21977757-3a63-4586-ae03-e6630c1f009d@redhat.com>
Message-ID: <d87c79b9-d0d2-2819-030-12c7df86eb38@inria.fr>
References: <alpine.DEB.2.22.394.2312102317350.3198@hadrien> <21977757-3a63-4586-ae03-e6630c1f009d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Dec 2023, Ivan Vecera wrote:

> On 10. 12. 23 23:28, Julia Lawall wrote:
> > Hello,
> >
> > Starting with the commit:
> >
> > commit 9e479d64dc58f11792f638ea2e8eff3304edaabf
> > Author: Ivan Vecera <ivecera@redhat.com>
> > Date:   Fri Oct 13 19:07:51 2023 +0200
> >
> >      i40e: Add initial devlink support
> >
> > I am not able to boot normally.  The console shows the message
> >
> > Failed to start Raise network interfaces
> >
> > Searching for this message on th internet produces some old discussions
> > that suggest to look at the file /etc/network/interfaces.  That file on my
> > system contains:
> >
> > # This file describes the network interfaces available on your system
> > # and how to activate them. For more information, see interfaces(5).
> >
> > source /etc/network/interfaces.d/*
> >
> > # The loopback network interface
> > auto lo
> > iface lo inet loopback
> >
> > auto enp24s0f0
> > iface enp24s0f0 inet dhcp
>
> The problem is maybe with interface name... after this commit the interface
> should contain port_name suffix. In your case the name should be
> `enp24s0f0np0`.
>
> Could you please check it?

Thanks for the feedback.  But I'm not clear on how this would work.  Does
there have to be one name for kernels before this patch and another name
for kernels starting with this patch?  Or is the new name also acceptable
for older kernels?

thanks,
julia
