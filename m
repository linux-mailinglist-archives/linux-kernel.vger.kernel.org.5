Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073537E386E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjKGKJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKGKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:09:01 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176D5BD;
        Tue,  7 Nov 2023 02:08:59 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5DF7C468;
        Tue,  7 Nov 2023 11:08:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699351716;
        bh=mI+C9BE7qHDgUYbgoCaEsi8LmHTuqyG8+n8yBehjAyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRnYmivbqQSMQ0lFul0jCE5kcvHGedMK15bZUtIJdb4uAJOiHTEue6ck1FLRQHHtv
         5X/vEVVWgPHkqKir3Pjh+um3SZe/jpZ/hzvSOj/3WhpFfH9UNkJW8mKlVlKSAmswx4
         vWMWR7t07TlcL2YnK/776DBW9uAXDk9oDeaV5Mv4=
Date:   Tue, 7 Nov 2023 12:09:05 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-staging@lists.linux.dev,
        changhuang.liang@starfivetech.com,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v11 0/9] Add StarFive Camera Subsystem driver
Message-ID: <20231107100905.GA27932@pendragon.ideasonboard.com>
References: <20231025031422.3695-1-jack.zhu@starfivetech.com>
 <15ef0a70-734e-280a-f014-41914a55d8cf@starfivetech.com>
 <a3a2c179-2cbe-5a55-a21e-b45abfb6d494@starfivetech.com>
 <2023110745-tableful-trapezoid-4206@gregkh>
 <2023110730-thousand-skyrocket-d6ba@gregkh>
 <a2dbb182-2573-4c86-7e18-319d26a6593c@starfivetech.com>
 <2023110756-alto-stream-eb92@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023110756-alto-stream-eb92@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Nov 07, 2023 at 09:27:34AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 07, 2023 at 04:05:11PM +0800, Jack Zhu wrote:
> > > Also, while you wait, why not just finish off the last 3 items on the
> > > TODO list which would make your code not be required to go into the
> > > staging portion of the tree at all?  You've had a few weeks now, what is
> > > preventing that from happening, and when will that work actually be
> > > done?
> > 
> > One of my colleagues is doing related development, but he also has other
> > projects at the same time, so he cannot devote all his efforts to this
> > development. And we expect to use libcamera, which may take some time.
> 
> So that means there is no real plan at all to get this out of the
> staging directory?  If so, why should we take it at all as obviously
> this means that the code is now abandoned?

"Taking some time" doesn't necessarily mean "abandoned". I agree that
more often that not we've seen code dumped in staging and left there
unmaintained. Once bitten, twice shy (or as we say in French, a scalded
cat fears cold water), but let's not necessarily assume the worst
possible outcome :-)

Of course, if StarFive wants to speed up development of the ISP support,
both on the kernel side and libcamera side, I'm sure Kieran and I can
help (possibly not very fast if it is only done in our spare time
though, but that's a separate discussion).

-- 
Regards,

Laurent Pinchart
