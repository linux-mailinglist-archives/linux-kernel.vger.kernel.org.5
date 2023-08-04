Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715C5770B08
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjHDVdt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Aug 2023 17:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHDVds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:33:48 -0400
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAFCC5;
        Fri,  4 Aug 2023 14:33:46 -0700 (PDT)
Received: from [192.168.2.4] (51b69adf.dsl.pool.telekom.hu [::ffff:81.182.154.223])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000072F66.0000000064CD6EB7.0001EB4C; Fri, 04 Aug 2023 23:33:43 +0200
Message-ID: <39e3ed9f0c3fee61bd99788cdc7cf6cdcd1ee65c.camel@irl.hu>
Subject: Re: [RFC PATCH 0/2] media: v4l2: map UVC_CT_ROLL_ABSOLUTE_CONTROL
From:   =?UTF-8?Q?Gerg=C5=91_K=C3=B6teles?= <soyer@irl.hu>
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Aug 2023 23:33:42 +0200
In-Reply-To: <caeddb66-6bac-3621-6a92-dbeca16261c3@wolfvision.net>
References: <cover.1691096157.git.soyer@irl.hu>
         <caeddb66-6bac-3621-6a92-dbeca16261c3@wolfvision.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, 2023-08-04 at 20:45 +0200, Michael Riesch wrote:
> Hi Gergő,
> 
> Interesting work! I would guess that there are a lot of cameras with an
> accelerometer or gyroscope that could report the rotation.
> 

I think only the Streamcam in the UVC world, but who knows. :)

> On 8/3/23 23:28, Gergő Köteles wrote:
> > Hi,
> > 
> > Logitech Streamcam can be mounted in 'portrait mode' as well.
> > It reports the current roll (-90, 0, 90, 180) with
> > UVC_CT_ROLL_ABSOLUTE_CONTROL.
> > 
> > This RFC defines V4L2_CID_ROLL_ABSOLUTE, and maps
> > UVC_CT_ROLL_ABSOLUTE_CONTROL to make it available to
> > userspace.
> > Then, the userspace can rotate the stream based on the roll.
> 
> Should we also discuss pitch and yaw while we are at it?
> 

They are there with V4L2_CID_PAN_ABSOLUTE and V4L2_CID_TILT_ABSOLUTE.

> As far as I know there are controls to set pan and tilt of a PTZ camera,
> but there are no controls that report those angles.
> 

Aren't real PTZ cameras using the CT_PANTILT_ABSOLUTE_CONTROL for
panning and tilting? Or just to move the crop window?

> > Is it better to use V4L2_CID_CAMERA_SENSOR_ROTATION for this?
> 
> IMHO that would make sense.
> 
> Best regards,
> Michael
> 
> > The value set matches that control.
> > If yes, is it worth mapping UVC_CT_ROLL_ABSOLUTE_CONTROL to
> > V4L2_CID_CAMERA_SENSOR_ROTATION for this camera only?
> > 
> > Any feedback is greately appreciated.
> > 
> > 
> > Gergő Köteles (2):
> >   media: v4l2: ctrls: Add ROLL_ABSOLUTE control
> >   media: v4l2: map UVC_CT_ROLL_ABSOLUTE_CONTROL
> > 
> >  .../userspace-api/media/v4l/ext-ctrls-camera.rst         | 5 +++++
> >  drivers/media/usb/uvc/uvc_ctrl.c                         | 9 +++++++++
> >  drivers/media/v4l2-core/v4l2-ctrls-defs.c                | 1 +
> >  include/uapi/linux/v4l2-controls.h                       | 2 ++
> >  4 files changed, 17 insertions(+)
> > 
> > 
> > base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5

