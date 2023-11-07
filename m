Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AC17E3525
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjKGGQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjKGGQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:16:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB1A183;
        Mon,  6 Nov 2023 22:16:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F54C433C7;
        Tue,  7 Nov 2023 06:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699337785;
        bh=1DUHo7iF0MscewlRLmsCnEFojb1hLmgMueDa31SA3HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L/NMHSLsuVo6pPDoLri5kcaBoy85g2/eKu5UTOkbwYpm3i/KD+gH+WauQ+9KVfFpQ
         iFO3C7yR0oGwnu4yyPmPBiLNXv1UdiG0TrvMMJpwm9jKP5xzAFZqcS0EgCTAUrA/so
         YRm2fx7FJ3Q4Rx1jIE27S5elCI4svAQUVk1dSYPs=
Date:   Tue, 7 Nov 2023 07:16:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-staging@lists.linux.dev,
        changhuang.liang@starfivetech.com
Subject: Re: [PATCH v11 0/9] Add StarFive Camera Subsystem driver
Message-ID: <2023110730-thousand-skyrocket-d6ba@gregkh>
References: <20231025031422.3695-1-jack.zhu@starfivetech.com>
 <15ef0a70-734e-280a-f014-41914a55d8cf@starfivetech.com>
 <a3a2c179-2cbe-5a55-a21e-b45abfb6d494@starfivetech.com>
 <2023110745-tableful-trapezoid-4206@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023110745-tableful-trapezoid-4206@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 07:15:10AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 07, 2023 at 11:27:27AM +0800, Jack Zhu wrote:
> > 
> > 
> > On 2023/10/31 9:09, Jack Zhu wrote:
> > > 
> > > 
> > > On 2023/10/25 11:14, Jack Zhu wrote:
> > >> Hi,
> > >> 
> > >> This series is the v11 series that attempts to support the Camera Subsystem
> > >> found on StarFive JH7110 SoC.
> > > 
> > > Hi Hans and Laurent,
> > > 
> > > Could you please help review the code?
> > > Thank you for your time!
> > > 
> > 
> > Hi,
> > 
> > Could you please take some time to help review the code? Thank you so much!
> 
> It is the middle of the merge window, no new code can be added to any
> maintainers tree at this point in time, please relax there is no rush or
> deadline at all here.
> 
> While you wait, why not help out and review other patch submissions from
> other developers, which will help your changes get to the top of the
> queue?  That way everyone's load is reduced and you are not just asking
> for others to do work for you with nothing in return.

Also, while you wait, why not just finish off the last 3 items on the
TODO list which would make your code not be required to go into the
staging portion of the tree at all?  You've had a few weeks now, what is
preventing that from happening, and when will that work actually be
done?

thanks,

greg k-h
