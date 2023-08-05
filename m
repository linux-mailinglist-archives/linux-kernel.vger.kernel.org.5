Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BC0770E12
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 08:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjHEGW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 02:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHEGW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 02:22:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E7C4ED6;
        Fri,  4 Aug 2023 23:22:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12DD760AD6;
        Sat,  5 Aug 2023 06:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165CEC433C8;
        Sat,  5 Aug 2023 06:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691216543;
        bh=71bkMSZKOc3HbinOnFH6CrCi9MNzOVOiV++TgrRs0RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=krCquNPUKYxEdMuc6EYEPY8FF+8qdVLpNWeGVb7Bi4Lvanzga1ZgzDz72YEobrbwa
         liuvHaUB7WeuMZh01GdVUCh0ERZtx5s/3eemeuDuGdkY8XOl8D6uCxaLuSjVBpsZ3V
         bgyiYsgmXq2Nj4T1/pcvMARjJCAxLZMT2KMu2CMg=
Date:   Sat, 5 Aug 2023 08:22:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     coolrrsh@gmail.com
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] fixes warning
Message-ID: <2023080507-umbrella-automated-0db9@gregkh>
References: <20230804200711.65750-1-coolrrsh@gmail.com>
 <20230804200711.65750-2-coolrrsh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804200711.65750-2-coolrrsh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 01:37:11AM +0530, coolrrsh@gmail.com wrote:
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> Typecasting the interrupt number from "unsigned int" to "signed int" to compare with 0(signed int by default).
> Declaring interrupt number as "signed int" would violate kernel standards. So typecasting is the possible approach.
> The fix is for spi-mpc52xx.
> 
> This fixes warning such as:
> drivers/spi/spi-mpc52xx-psc.c:332:5-13: WARNING: Unsigned expression compared with zero: mps -> irq < 0
> 
> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
> ---
>  drivers/spi/spi-mpc52xx-psc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Your subject lines are still incorrect :(
