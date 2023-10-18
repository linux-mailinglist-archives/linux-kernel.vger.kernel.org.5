Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4317CDAF6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjJRLtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJRLtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:49:15 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBE2111;
        Wed, 18 Oct 2023 04:49:13 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D0E752B3;
        Wed, 18 Oct 2023 13:49:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1697629745;
        bh=fJTg0p90iZsCaFDhrtNZ4cK233vjH3fuyCAW+LUdm6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UzLRwX0Rx1eEQZdYIHxP15ldj265YRAQkCj9YC4BjMMQ7zG9GDcL+I8DtaWz6txg8
         e5VqL9YFaYvJRReJMXoFhLnvS3t0BJowR6bPJJmsfjO8L4o+96IyqLOrxshd2gVzZj
         OHVr7E8qn3q/dwyP6+aqftLRjmqYHuyWNKyibtwM=
Date:   Wed, 18 Oct 2023 14:49:19 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-staging@lists.linux.dev,
        changhuang.liang@starfivetech.com
Subject: Re: [PATCH v10 0/8] Add StarFive Camera Subsystem driver
Message-ID: <20231018114919.GF11118@pendragon.ideasonboard.com>
References: <20231008085154.6757-1-jack.zhu@starfivetech.com>
 <98297bfc-ab81-4bb5-acc3-619fdf879276@xs4all.nl>
 <c255e215-b1ed-7397-0534-8d6ebda86350@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c255e215-b1ed-7397-0534-8d6ebda86350@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:11:40AM +0800, Jack Zhu wrote:
> On 2023/10/16 19:40, Hans Verkuil wrote:
> > On 08/10/2023 10:51, Jack Zhu wrote:
> >> Hi,
> >> 
> >> This series is the v10 series that attempts to support the Camera Subsystem
> >> found on StarFive JH7110 SoC.
> >> 
> >> This series is based on top of the master branch of media_stage repository,
> >> which is tested with a v4l2-compliance compiled from the git repo
> >> (git://linuxtv.org/v4l-utils.git).
> > 
> > I get one smatch warning:
> > 
> > drivers/staging/media/starfive/camss/stf-isp.c:122 isp_enum_mbus_code() warn: unsigned 'code->index' is never less than zero.
> 
> Could you please tell me the code check command? This way I can use it to check
> my next commit.
> 
> > And I also notice that there is no TODO file: staging drivers should have a
> > TODO file explaining what needs to be done to get them out of staging.
> 
> OK, I'll add it to my next commit. I previously misunderstood that it was submitted
> when moving out of staging.
> 
> > I'm curious to know that as well :-)
> > 
> > It looks like there is a lot of additional development that can be done, since
> > most of the ISP parameters appear to be hardcoded.
> 
> Part is the module initialization configuration. In the next stage, we will use
> incremental development to implement 3A functions.

I'm really looking forward to that part :-)

-- 
Regards,

Laurent Pinchart
