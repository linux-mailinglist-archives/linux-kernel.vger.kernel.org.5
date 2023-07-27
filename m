Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC81765DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjG0VKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjG0VKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:10:45 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB4C359A;
        Thu, 27 Jul 2023 14:10:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD2C440002;
        Thu, 27 Jul 2023 21:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690492230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/dtomQZ81OfMTviNmxiSs3OCEafDlGWxt32cXXwBla4=;
        b=eLR+P0EPdYZxvLxwdOYxSxjtDsdij+C5XSDmj7laX5UQFbZwF3EQZOKfUcAHizmdkPZmR7
        2DDDFouVTJGLJdwiTMeicxviqa31sC/JmL08slIzXIkcx+7+pr7aE0NnfCm6kkyX8qMyyt
        lRJ8iNt9Y0avUeOMhTvaDJb1eJzbY2lYCcEgbWe/Rl4uMuJeTveS/rw8SCXlwZvl+BrXD8
        JVMm0oBcj/hWQBzYRCSD+k4AvdLpPO99TE8sk7MnySomz3r13ihnXuygpMgoj660VSF1O5
        u++aqXVAP/lbKOHDzeN6afQgLRm87wTpAtlqENIkj+SHzDzRTCx5chFOioxZvg==
Date:   Thu, 27 Jul 2023 23:10:28 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S . Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] rtc: bq4802: add sparc dependency
Message-ID: <169049221010.465987.18412731901072385567.b4-ty@bootlin.com>
References: <20230719192835.1025406-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719192835.1025406-1-arnd@kernel.org>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jul 2023 21:28:18 +0200, Arnd Bergmann wrote:
> The added HAS_IOPORT dependency might not actually be necessary as Geert
> points out, but the driver is also only used on one architecture. Sparc
> is also a special case here since it converts port numbers into virtual
> addresses rather than having them mapped into a particular part of the
> __iomem address space, so the difference is actually not important here.
> 
> Add a dependency on sparc, but allow compile-testing otherwise, to
> make this clearer without anyone having to spend much time modernizing
> the driver beyond that.
> 
> [...]

Applied, thanks!

[1/1] rtc: bq4802: add sparc dependency
      commit: 766c3f8a092b4d42abd68ee0338349838430a5ee

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
