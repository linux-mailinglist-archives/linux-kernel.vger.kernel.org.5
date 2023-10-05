Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D938A7BA172
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbjJEOmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjJEOhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D794E357;
        Thu,  5 Oct 2023 07:03:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DECBC116A9;
        Thu,  5 Oct 2023 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696493137;
        bh=HoLOrIR292OK4LNCHKlQpciqwUF+riXC6qahbbVsLY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTz+1BNHOgV0lFcjaazPlDTfyaTqmwjXZ/zZp7FcfA8XXEwjfSUYHShpjj2BefInh
         UDjhAQCauP5lrbl1BakuefOU6Nq38/Rv2zRtjH3xG3RVUUxx0FmUYMfabK1w0rPk9F
         S2FO8I/SGd6NLOJgfc5UvIr0ryhqcsgmMrdTDwBQ=
Date:   Thu, 5 Oct 2023 10:05:35 +0200
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
Subject: Re: [PATCH v12 0/6] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
Message-ID: <2023100502-unwilling-bleach-b5ac@gregkh>
References: <20230923143200.268063-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923143200.268063-1-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 08:01:54PM +0530, Umang Jain wrote:
> The patch series added a new bus type vchiq_bus_type and registers
> child devices in order to move them away from using platform
> device/driver.
> 
> Tested on RPi-3-b with media tree master branch.

Thanks for sticking with this through so many different revisions. I
only had minor comments on the series, you can address them in follow-on
patches if needed (one at the least is needed.)  All are now queued up
in my tree.

greg k-h
