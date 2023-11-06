Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6FC7E1F0C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjKFK7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFK7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:59:38 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC8AB7;
        Mon,  6 Nov 2023 02:59:35 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 472F1223;
        Mon,  6 Nov 2023 11:59:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699268353;
        bh=lhvz5saAeUdjlsIZ14t/fbtSNafXh2meA6GJnGK0o5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p8wPSvFkU3F5WBwwM7QHtI1kB3IStSW2iy0ehDjUxEwxDPlEIJVeI/NDOzMEABskK
         Bn0aUm09ZZk9yMNhGO8QBjX4XaIy8DM0O8zXxiLQZ7qbxnehyjDkDDAGr1D8zWJYeN
         LS9W9Z8YM+w7YQyPtmVzOobwASF4TX9Q6gtSDAQg=
Date:   Mon, 6 Nov 2023 12:59:41 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esker Wong <esker@chromium.org>
Subject: Re: [PATCH] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
Message-ID: <20231106105941.GB16995@pendragon.ideasonboard.com>
References: <20231020-uvc-event-v1-1-3baa0e9f6952@chromium.org>
 <20231106103925.GA19272@pendragon.ideasonboard.com>
 <20231106104245.GB19272@pendragon.ideasonboard.com>
 <CANiDSCsnrb5a3XTnHRrUjttcV6aAw7yC6RtUApvsK5CBhFGJyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCsnrb5a3XTnHRrUjttcV6aAw7yC6RtUApvsK5CBhFGJyQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 11:51:06AM +0100, Ricardo Ribalda wrote:
> On Mon, 6 Nov 2023 at 11:42, Laurent Pinchart wrote:
> > On Mon, Nov 06, 2023 at 12:39:26PM +0200, Laurent Pinchart wrote:
> > > On Fri, Oct 20, 2023 at 06:41:45AM +0000, Ricardo Ribalda wrote:
> > > > Add support for the frame_sync event, so user-space can become aware
> > > > earlier of new frames.
> > > >
> > > > Suggested-by: Esker Wong <esker@chromium.org>
> > > > Tested-by: Esker Wong <esker@chromium.org>
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > > We have measured a latency of around 30msecs between frame sync
> > > > and dqbuf.
> > >
> > > Not surprising, especially for large resolutions. I'm curious though,
> > > what do you use this event for ?
> 
> I think Esker is using it to get more accurate power measurements of
> the camera stack.

Esker, would you be able to provide more information ?

> > > It's easy to miss the ++ there when reading the code, would the
> > > following be more readable ?
> 
> Actually that was my original code, but I thought you would like this better :)
> 
> Thanks for the review, a v2 is on its way.

Thank you.

-- 
Regards,

Laurent Pinchart
