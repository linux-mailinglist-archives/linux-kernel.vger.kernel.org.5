Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2637BA0B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbjJEOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbjJEOhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B955835B6;
        Thu,  5 Oct 2023 07:02:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D891C116A8;
        Thu,  5 Oct 2023 08:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696493083;
        bh=n0iBSjPCJkTWykMjXg2IpQ/zpWh4QfV3NqOyRltJBhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCfl+kBAeFYIZUswnR8uZMzh5QaIJPbx13BP7AgAhJj9nSlwojL7hm97zgFR+Yxm5
         7/oFKTMm3x9km0Lwzc0wP8DTaW0x1ExhMFUQSaP0H9MdSTmVzeaD/awJ0BZawcZOeG
         hjVoG3S3lyssDem651xtmzWvVyey+eIoIQcBc7p4=
Date:   Thu, 5 Oct 2023 10:04:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v12 6/6] staging: bcm2835-audio: Register bcm2835-audio
 with vchiq_bus_type
Message-ID: <2023100523-comprised-eggnog-bd20@gregkh>
References: <20230923143200.268063-1-umang.jain@ideasonboard.com>
 <20230923143200.268063-7-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923143200.268063-7-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 08:02:00PM +0530, Umang Jain wrote:
> Similar to how bcm2385-camera device is registered, register the
> bcm2835-audio with vchiq_bus_type as well.
> 
> Since we moved away bcm2835-audio from platform driver/device,
> we have to set the DMA mask explicitly. Set the DMA mask at probe
> time.
> 
> Meanwhile at it, change the name and module alias from "bcm2835_audio"
> to "bcm2835-audio" to be consistent with bcm2835-camera device. This
> does not brings any functional change as '-' and '_' are
> interchangeable as per modprobe man pages.

Again, why is the module alias still needed?

thanks,

greg k-h
