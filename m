Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17304765DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjG0VFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjG0VFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:05:02 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456412D42;
        Thu, 27 Jul 2023 14:05:01 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8884360003;
        Thu, 27 Jul 2023 21:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690491899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tOY5b3y9jRLepq1BGsdeSApJYxOtzopsf/Bc3hO4kvk=;
        b=SQF1cOAZCL8tI3y3wag8IGoJi6glP2Pd2fcsnVDYCVkOaazyVankPSLGIeDvK3TKTY/gRZ
        rTnL9jKFWskJ/5W2muGV1MvhYnxUneA3BvYsifIzgdDl/1+BoJZYlJBGuwz4mQjDZ9+Qy0
        LQadGW+pBHvWSgz9GZ9AtJrvUuUUwrkNcNfHB0vpkcTSc/VPWYdP4CdfVNWOSHR8HScJnC
        tKTrW3k3qvIYJloqk70YEC1zOGS4YjOKWNyIoOfBcqVNp4wosOQu9KmoltrobBkPTYqqX0
        5cTZVMpzOF8WyVqxHij+97hUCeeOuUGxwP7nEMv//w4vGNaN4lVLlfnQzOygjQ==
Date:   Thu, 27 Jul 2023 23:04:58 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Valentin Caron <valentin.caron@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Christophe Guibout <christophe.guibout@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] rtc: stm32: multiple bug fixes and improvements
Message-ID: <169049184164.460519.5513202583626147097.b4-ty@bootlin.com>
References: <20230705174357.353616-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705174357.353616-1-valentin.caron@foss.st.com>
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


On Wed, 05 Jul 2023 19:43:50 +0200, Valentin Caron wrote:
> This series implements some bug fixes for theses issues:
> - typo issues
> - register read sequence issue
> - irq during pm callbacks issue
> 
> This series implements also some improvements:
> - don't switch to INIT mode uselessly
> - improve error printing during probe
> - improve rtc precision on stm32mp1
> 
> [...]

Applied, thanks!

[1/7] rtc: stm32: use the proper register sequence to read date/time
      commit: f69cb2d6034ddf8dae6848d29b9d4efba8cd4df9
[2/7] rtc: stm32: don't stop time counter if not needed
      commit: 1c18b8ec52396af6a6e20cd3450dc9bff0781ab8
[3/7] rtc: stm32: improve rtc precision
      commit: 2487925731b75961cf4b7d1d0d28d204b63787b9
[4/7] rtc: stm32: don't print an error on probe deferral
      commit: 95f7679c3ab2d032d935692426b6d9f7e681fd60
[5/7] rtc: stm32: change PM callbacks to "_noirq()"
      commit: fb9a7e5360dc8089097337a9685f6fed350a310f
[6/7] rtc: stm32: fix issues of stm32_rtc_valid_alrm function
      commit: 46828a5f89044b8e057f6bbb50ae2bac926a0fa2
[7/7] rtc: stm32: fix unnecessary parentheses
      commit: 650915ecd8f8cbb58e1ef55430f9e15ae03fd7d8

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
