Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BA27ED8AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 01:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjKPAuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 19:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPAub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 19:50:31 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDC5194;
        Wed, 15 Nov 2023 16:50:27 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8A0DAB9A;
        Thu, 16 Nov 2023 01:49:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700095798;
        bh=w3K2tM27H6CsFZMEkRRGB2SJ0BRFe0OzxBqn5o6Byts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBBXxCVa9mZJyLBnYT5RG/XgNfz48ehLMUmiq9kRJlrZ9PLYwHn3nT+DcwckljQCx
         KY4NBUeM0tBWEdaC006AsUjd5RJ/0CwjQcom2LGeRwKY2dDIt2LNBehuAA4aOToTBN
         8NCt55BK4vaAecPTkI1FXk06E8EcMWgEWFRKEV8A=
Date:   Thu, 16 Nov 2023 02:50:30 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2 00/15] staging: vc04_services: bcm2835-isp support
Message-ID: <20231116005030.GA21041@pendragon.ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <20231115195947.GD29486@pendragon.ideasonboard.com>
 <58fe01b9-5fb6-451c-a759-c6a5afd695e3@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58fe01b9-5fb6-451c-a759-c6a5afd695e3@gmx.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 09:57:52PM +0100, Stefan Wahren wrote:
> Hi Laurent,
> 
> [add Ivan & Peter]
> 
> Am 15.11.23 um 20:59 schrieb Laurent Pinchart:
> > Hello,
> >
> > On Thu, Nov 09, 2023 at 04:02:52PM -0500, Umang Jain wrote:
> >> This series aims to upport bcm2835-isp from the RPi kernel.
> >> It is developed on top of staging-next which comprises many
> >> VC04 changes for it's de-staging. Hence, the merge of this
> >> driver is targeted when VC04 is de-staged completely (which I
> >> have been pushing), but it can be helped getting reviewed meanwhile.
> >> Hence, the reason for posting the series.
> >
> > Related question, what do people think about dropping the legacy
> > firmware-based bcm2385-camera driver once this gets merged ?
> > firmware-based camera operation is deprecated by Raspberry Pi, and
> > doesn't work on the Pi 5
>
> i don't remember exactly, but wasn't the bcm2835-camera required for Pi
> Camera V1.3?

If I'm not mistaken (Dave can correct me), the legacy camera stack works
only with the Raspberry Pi official camera v1, v2 and HQ modules.
Raspberry Pi has switched to a new camera stack based on libcamera,
which works on the Pi Zero 2, Pi 3, Pi 4 and Pi 5. This new stack
supports the same camera modules as the legacy stack, and many more. The
legacy stack doesn't work on Pi 5 at all.

> At the end cannot speak for the users. AFAIK OpenSuSE and Fedora use the
> driver.

-- 
Regards,

Laurent Pinchart
