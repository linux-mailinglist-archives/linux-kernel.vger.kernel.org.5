Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3937754848
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 12:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjGOKsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 06:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjGOKr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 06:47:57 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B5635AA
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 03:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=hJKuyUGhxmtOjD6kuHJpi0wsrKNzXYtETGeFgeXc7II=;
        b=Ucn6CxYxKvVLUdqvXK/zV8JuQ0wNHIPEYcb0pJoQHqQ8+LD6unz7fqTc2oSc5lqqu7Ibmoh1yIo7N
         TGekQlit/GMH5TY9jkx5I4VQbdt3HK04NI/44y/hTTzhJ5NDz15EtWymT6O3F3EYxBqE2wA4P4KlqH
         NVhhRUOOHpjrMFPjGgR18xSr0gavVOBTghE8Rtkae71MvZrMVDX5/lAbKoN3f63xCQVORSSUuZe9+e
         3UiWLbMUMVnPzHvwgL1jHjb0fqTU0oB3aWCEF7f5zIeLbrLdmreGwo1ovBzxVJn/+zZeETPk1O4MOG
         QZnVV+ZRNIo9bp60/P/r9eFqQphNWCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=hJKuyUGhxmtOjD6kuHJpi0wsrKNzXYtETGeFgeXc7II=;
        b=QSHCG+TTDqqScOMMkMX5MCSUEPNB30xqbjj+ZHx+D5zA152EKUJw4H6fom0gYsdJnxUz8oOFfgrye
         PxB/85MCw==
X-HalOne-ID: 0c1f8229-22fd-11ee-b315-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id 0c1f8229-22fd-11ee-b315-b90637070a9d;
        Sat, 15 Jul 2023 10:47:55 +0000 (UTC)
Date:   Sat, 15 Jul 2023 12:47:53 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sbus: Explicitly include correct DT includes
Message-ID: <20230715104753.GB251436@ravnborg.org>
References: <20230714175048.4066006-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714175048.4066006-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 11:50:48AM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
