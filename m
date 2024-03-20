Return-Path: <linux-kernel+bounces-109083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07426881472
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67C7283B95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EA6524D4;
	Wed, 20 Mar 2024 15:21:27 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91A53E02;
	Wed, 20 Mar 2024 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948087; cv=none; b=abA1j+eQBd05rKlxLD/7ZIjYunxa5dbzplLt8bfV57K14X8VrkUh7YAdWS9v6q2l6MgM9Fk167f7SqROs5XLy8DNxLfixV+GX9oYyFTxi792+nglDrEKymUjpuhVs4S9ugsfcDMBbms/4goQZFXzA818fS3MBWpUwb/YEX3VBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948087; c=relaxed/simple;
	bh=7EtSSNSy2ryF+ATDOn8xw+BRs/v4pwXxWNT6O+sQk54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MFvp1DujNOx9PENqi5UjQ/2tB8vab1MIuicuAHfTWVLC0GmhwUuuHN0/MbvCXLfgGRUhuxky64mv9HXOSiBUZ96vc8hf8IqxFprXOzUalNwkiC2gzwACWdc6aFs9rn5n1ufY48NY8xPxuso4+jUKEoJvHMVao1PXMjBSRXv/Qfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b6960e.dsl.pool.telekom.hu [::ffff:81.182.150.14])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000076BD5.0000000065FAFEEE.0022CD79; Wed, 20 Mar 2024 16:21:18 +0100
Message-ID: <af9264dd7993e2904ce8f35bfa3654dcf38920f5.camel@irl.hu>
Subject: Re: [PATCH v2 RESEND] media: uvcvideo: uvc_ctrl_get_rel_speed: use
 0 as default
From: Gergo Koteles <soyer@irl.hu>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
  Mauro Carvalho Chehab <mchehab@kernel.org>,
  linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 20 Mar 2024 16:21:17 +0100
In-Reply-To: <CANiDSCsXeuNLHSGhqYjkRoyhgW6MZo1xufONbYdm42OcRrj2ng@mail.gmail.com>
References: 
	<eb4f7f29a94231c5fa404f7492dba8e7fd9fbb23.1686746422.git.soyer@irl.hu>
	 <088902f67634fb0931da7b045e05afe5c8197cdc.1700505816.git.soyer@irl.hu>
	 <CANiDSCsXeuNLHSGhqYjkRoyhgW6MZo1xufONbYdm42OcRrj2ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ricardo,

On Tue, 2024-03-19 at 10:43 +0100, Ricardo Ribalda wrote:
> Hi Gergo
>=20
> I missed sending the reviewed-by sorry :)
>=20
> Btw, do you still have access to the device? Could you tell me what
> you get from  and UVC_GET_MAX, UVC_GET_MIN for
> UVC_CT_PANTILT_RELATIVE_CONTROL and UVC_CT_ZOOM_RELATIVE_CONTROL ?
>=20

PTZ Pro and BCC950 only have UVC_CT_ZOOM_ABSOLUTE_CONTROL, not
UVC_CT_ZOOM_RELATIVE_CONTROL.

v4l2-ctl -l:

zoom_absolute(int): min=3D100 max=3D1000 step=3D1 default=3D100 value=3D100
pan_speed(int): min=3D-1 max=3D1 step=3D1 default=3D1 value=3D0
tilt_speed(int): min=3D-1 max=3D1 step=3D1 default=3D1 value=3D0

printing data[first], data[first+1] in uvc_ctrl_get_rel_speed:

GET_DEF: 0 1
GET_MIN: 0 1
GET_MAX: 0 1
GET_RES: 0 1
GET_CUR: 0 1


I found the output of Obsbot Tiny v4l2-ctl -l at
https://www.labohyt.net/blog/gadget/post-7643:

pan_absolute(int): min=3D-468000 max=3D468000 step=3D3600 default=3D0 value=
=3D0
tilt_absolute(int): min=3D-324000 max=3D324000 step=3D7200 default=3D0 valu=
e=3D0
focus_absolute(int): min=3D0 max=3D100 step=3D1 default=3D0 value=3D0
flags=3Dinactive
focus_automatic_continuous(bool): default=3D1 value=3D1
zoom_absolute(int): min=3D0 max=3D100 step=3D1 default=3D0 value=3D0
zoom_continuous(int): min=3D0 max=3D100 step=3D1 default=3D100 value=3D0
pan_speed(int): min=3D-1 max=3D160 step=3D1 default=3D20 value=3D0
tilt_speed(int): min=3D-1 max=3D120 step=3D1 default=3D20 value=3D0

This is where the default value of pan_speed/tilt_speed/zoom_continuous
can be useful, even if they don't work exactly like the defaults for
other controls.

So this patch isn't that good after all.

Regards,
Gergo


> Thanks!
>=20
> On Mon, 20 Nov 2023 at 19:53, Gergo Koteles <soyer@irl.hu> wrote:
> >=20
> > Devices with pan/tilt controls but without pan/tilt speed controls
> > return 1 for the default value of V4L2_CID_PAN_SPEED or
> > V4L2_CID_TILT_SPEED. For these controls, the value of 1 means a
> > move and that's not a good default.
> >=20
> > Currently, for these controls the UVC_GET_DEF query returns
> > bPanSpeed or bTiltSpeed of CT_PANTILT_RELATIVE_CONTROL.
> >=20
> > According to the UVC 1.5 specification, the default value of bPanSpeed
> > or bTiltSpeed should be 1 if the pan/tilt control doesn't support
> > speed control.
> >=20
> > "If the control does not support speed control for the Tilt control,
> > it will return the value 1 in this field for all these requests."
> >=20
> > This patch modifies the uvc_ctrl_get_rel_speed to return hardcoded 0
> > for UVC_GET_DEF query, because that's the stop or don't move value
> > for these V4L2 controls.
> >=20
> > Previous discussion
> > Link: https://lore.kernel.org/all/CAP_ceTy6XVmvTTAmvCp1YU2wxHwXqnarm69Y=
az8K4FmpJqYxAg@mail.gmail.com/
> >=20
> > Signed-off-by: Gergo Koteles <soyer@irl.hu>
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/u=
vc_ctrl.c
> > index 5e9d3da862dd..e131958c0930 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -444,9 +444,10 @@ static s32 uvc_ctrl_get_rel_speed(struct uvc_contr=
ol_mapping *mapping,
> >                 return -data[first+1];
> >         case UVC_GET_MAX:
> >         case UVC_GET_RES:
> > +               return data[first+1];
> >         case UVC_GET_DEF:
> >         default:
> > -               return data[first+1];
> > +               return 0;
> >         }
> >  }
> >=20
> >=20
> > base-commit: be9aac187433af6abba5fcc2e73d91d0794ba360
> > --
> > 2.42.0
> >=20
> >=20
>=20
>=20


