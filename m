Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80F679E872
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbjIMM6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbjIMM6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:58:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F022E19B4;
        Wed, 13 Sep 2023 05:58:17 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9B5C5BEB;
        Wed, 13 Sep 2023 14:56:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694609804;
        bh=M7dKeNMIT1EMz75IrJ+oFJE2UlePCjaNN7ef/pgxLyg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dRNsrWFAOavc+qboaBX4mH9+K0nLBzN9++lrDVX/oDuhRmE0I4ZUyvotTi7gWIPe6
         EdYkwgNxzdqd8d9L8auDMb3SvtQpfrr2TwBsBsJg1nOxASG2hbJl7ljSTDqa1aH9QW
         xjtP7tZhcuSC69KZoW6074r7ocS/nmsVOujKz4j8=
Message-ID: <9efde4d8-385d-54da-fb0d-55625d3c4571@ideasonboard.com>
Date:   Wed, 13 Sep 2023 15:58:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH] drm: omapdrm: dsi: add refsel also for omap4
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, airlied@gmail.com,
        daniel@ffwll.ch, u.kleine-koenig@pengutronix.de, arnd@arndb.de,
        laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
References: <20230913065911.1551166-1-andreas@kemnade.info>
 <48972ab0-e4ed-11b2-31fb-ad93695a4db1@ideasonboard.com>
 <20230913124828.GL5285@atomide.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230913124828.GL5285@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 15:48, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> [230913 12:11]:
>> I'm somewhat sure that the upstream driver used to work on omap4 sdp, which
>> has two DSI panels. But I can't even remember what omap4 version it had.
> 
> I think those were both dsi command mode panels though, not video mode?

Yes, true. If the PLL is totally wrong due to refsel, I'm sure a command 
mode panel would also fail. But it's true that video mode panels are 
more sensitive to the clock rate.

  Tomi

