Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04443813332
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573495AbjLNOd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573453AbjLNOdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:33:25 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FF7B7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ykBvY5pn5JR4ZN5c1iGVYQ+AhIwtbVMb4WlhLmTxFBY=;
  b=jkXcNv0GNPvVjbgg8jJNErbVOk06kwf51bE5qqfvxAD8Z9wHWiBIpxR4
   LB3X+qdsOOu/cmJGB5sKXdru+vzLXNHdouKDzvdIFGSPn4qDs9X3P7y4K
   K9ZPjz6eGgN6x63HN9HWNo1Fc3QjfJ+n3a6P5/zkwJMatrhV3KqpwFs5Y
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,275,1695679200"; 
   d="scan'208";a="142328063"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 15:33:28 +0100
Date:   Thu, 14 Dec 2023 15:33:28 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Ivan Vecera <ivecera@redhat.com>
cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Failed to start Raise network interfaces error
In-Reply-To: <88a7a623-ad80-406c-a63b-3136df963888@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2312141530500.3217@hadrien>
References: <alpine.DEB.2.22.394.2312102317350.3198@hadrien> <21977757-3a63-4586-ae03-e6630c1f009d@redhat.com> <d87c79b9-d0d2-2819-030-12c7df86eb38@inria.fr> <a79a13b9-b4d1-45ba-a104-01e911631863@redhat.com> <4c707e3e-a324-a5e6-dc21-833b6d40324d@inria.fr>
 <88a7a623-ad80-406c-a63b-3136df963888@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Dec 2023, Ivan Vecera wrote:

>
>
> On 12. 12. 23 17:33, Julia Lawall wrote:
> > > Look at 'systemd.net-naming-scheme' man page for details how the interface
> > > names are composed.
> > After booting into 6.7.0-rc4, I have the following in
> > /etc/network/interfaces:
> >
> > # This file describes the network interfaces available on your system
> > # and how to activate them. For more information, see interfaces(5).
> >
> > source/etc/network/interfaces.d/*
> >
> > # The loopback network interface
> > auto lo
> > iface lo inet loopback
> >
> > auto enp24s0f0
> > iface enp24s0f0 inet dhcp
>
> Just change 'enp24s0f0' in /etc/network/interfaces to 'enp24s0f0np0'

Hello,

I don't know if anything can be done about it, but this change introduces
complexities.  The people who manage the cluster that I use say that the
name of the network interface should be predictable, which is no longer
the case because it now depends on the kernel version.

thanks,
julia
