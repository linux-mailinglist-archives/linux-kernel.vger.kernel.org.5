Return-Path: <linux-kernel+bounces-165728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5158B904A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8412832B6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7979D161939;
	Wed,  1 May 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="G8fB6p3c"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80B161320
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593351; cv=none; b=kjyuztsKBJ9xTHyOFkHj+KFeGFvonf54RBtyt4tWKgziBSEYPLzuMLv1cqudVACtR8smgsnLpHlh8jKURquldYr9DpqPGrYO4Nmlj7Cl3LeXMPLHgN5M5rJpJnyu4SixF0s3FWNVgzeevmf+4sRnDKUm0jJOH4HqO4xL8kehoOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593351; c=relaxed/simple;
	bh=f73jSEAMJKBp15N9UkPWYqMCh4YYPf7JXmaAdRz51NM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pXHCZd0dtpcEFjFwXLiqys2K4qvsUXdlZsnc0YVQypWj1JmaPu24/8ucZY1zNai9qYekrne1J/n1DgHuxM8S8BWTFe8gkgpMWuQGtTpr5eCJ4qtrDHiQ7RMbufx5Rxt6+qErjSZdi5i9v0r+VanhaPsGbPYyStJWEDrpus6wp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=G8fB6p3c; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4375ddb9eaeso44506431cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1714593348; x=1715198148; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rp2Oeq63C4vnEAayPDNotRfG8unurD54mFT8YeJ0RJ8=;
        b=G8fB6p3cRleezXSUdf75DPwTwg/BGvJI1AQM0CxtcLKHJFBKOWCihsPqx2DlsyXCYf
         iYZ0adjob8rjmfBeIaXweR59CDEahG7vx/wAtpEA1JNeWr1FhxG45iTgNRK3sY9aF1iD
         z54Vuz93SzYgYqPW+HT4lXxn0G/1dwzcpwp2Zc3/Kn3CH5+SXrVFqRvmV6/lNxf06Lgl
         cq4pVws4InG6dwdeOBNVfZTjlvebK4KZKqEweYvg3nNwfEKatbsFLFX3kAahqcu/dUgi
         oM9lVplSWH2h53aoCMUfFx0kisLM8tOgGILxn3gYGQRHHWutST/pIGJraSQo5/dWZRKi
         tiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714593348; x=1715198148;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rp2Oeq63C4vnEAayPDNotRfG8unurD54mFT8YeJ0RJ8=;
        b=cKYehr2UgoVshaVjb/ZC8g8rxaDrCbEM0PfUE8n6djmr5CDG9vN23ZpoG15IWX6ato
         3xi85VycOGVe94CvIUc2UZTQZSsJQQdnyrfh/Mj6ap4zfqeScH8rvHYpY9U5FgC0WF6F
         VpClr/ggboeJxRyeoekHLJv8XYgH+4N8cJ2pE0k/3W+0HuuHF3xiO06pY+cbMfpsi1UW
         t2by5oh66+plHdszs29YNaRqmD8EO5JZSEqXlPMuIStVz8zf45xagWMmM0rBkfzMOIWn
         eB3V61yS45V16dhUnWlGAugJvN3WG90o1hhlHMyKg7thyMXGx7ETwLHli02KhL3aCOzd
         KNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCULPdGqKEOGsyxX6Sfk4bIiz5OvdgIkvJNtecWC7HQR503PSKcnoiP/+N1y6Mbd5KPJL4yHkRjYANE0eOgGUP3hHfet+GxZhcvCyTRF
X-Gm-Message-State: AOJu0YzK7iGlSC9qjyjtMSYF7L5foYCOyYh/s4GgNVTNAWuFB9sjeRvC
	WTZO3oBSI732sYWGVakyJWxwlWcXqP7Pr7Q9MVwp1/PshZw/SJjkZ4/m8VqrfQQ=
X-Google-Smtp-Source: AGHT+IE+pwCRMel6AM6QEax/+YdZn8uEc6qt/ryuDm38HckiIWQdWtCTMgcpb+i+ZFA4KAjP/8xZaQ==
X-Received: by 2002:a05:622a:4b18:b0:43a:ea03:31b6 with SMTP id et24-20020a05622a4b1800b0043aea0331b6mr3444178qtb.31.1714593347744;
        Wed, 01 May 2024 12:55:47 -0700 (PDT)
Received: from nicolas-tpx395.lan ([2606:6d00:17:6448::7a9])
        by smtp.gmail.com with ESMTPSA id jv9-20020a05622aa08900b004366d3eef03sm12490361qtb.68.2024.05.01.12.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:55:47 -0700 (PDT)
Message-ID: <46ea74867fee6f0dbefb4c2d24a682d15beb41e7.camel@ndufresne.ca>
Subject: Re: [PATCH 1/2] media: v4l2-ctrls: Add average qp control
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Ming Qian <ming.qian@nxp.com>, 
	mchehab@kernel.org
Cc: shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 xiahong.bao@nxp.com,  eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
 ming.qian@oss.nxp.com,  imx@lists.linux.dev, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org
Date: Wed, 01 May 2024 15:55:46 -0400
In-Reply-To: <25a33db9-3bc1-4d90-83d4-0bdbea9bc5d8@xs4all.nl>
References: <20240329092352.2648837-1-ming.qian@nxp.com>
	 <25a33db9-3bc1-4d90-83d4-0bdbea9bc5d8@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le mercredi 24 avril 2024 =C3=A0 12:03 +0200, Hans Verkuil a =C3=A9crit=C2=
=A0:
> On 29/03/2024 10:23, Ming Qian wrote:
> > Add a control V4L2_CID_MPEG_VIDEO_AVERAGE_QP to report the average qp
> > value of current encoded frame.
> >=20
> > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > ---
> >  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 4 ++++
> >  drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 5 +++++
> >  include/uapi/linux/v4l2-controls.h                        | 2 ++
> >  3 files changed, 11 insertions(+)
> >=20
> > diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst =
b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > index 2a165ae063fb..cef20b3f54ca 100644
> > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > @@ -1653,6 +1653,10 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_ty=
pe -
> >      Quantization parameter for a P frame for FWHT. Valid range: from 1
> >      to 31.
> > =20
> > +``V4L2_CID_MPEG_VIDEO_AVERAGE_QP (integer)``
> > +    This read-only control returns the average qp value of the current=
ly
> > +    encoded frame. Applicable to the H264 and HEVC encoders.
>=20
> qp -> QP
>=20
> Why is this applicable to H264/HEVC only? I think it is fine for any code=
c.

Same question, though we should document the range, which will differ per-
codecs. We should also document to always use the specified range, rather t=
hen a
HW custom range. This way we don't endup with issues we have hit with other=
 ill-
defined controls.

Nicolas

>=20
> This needs to document that the value applies to the last dequeued buffer
> (VIDIOC_DQBUF).
>=20
> > +
> >  .. raw:: latex
> > =20
> >      \normalsize
> > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/=
v4l2-core/v4l2-ctrls-defs.c
> > index 8696eb1cdd61..88e86e4e539d 100644
> > --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > @@ -972,6 +972,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> >  	case V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES:		return "Use LTR Frames";
> >  	case V4L2_CID_FWHT_I_FRAME_QP:				return "FWHT I-Frame QP Value";
> >  	case V4L2_CID_FWHT_P_FRAME_QP:				return "FWHT P-Frame QP Value";
> > +	case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:			return "Average QP value";
>=20
> value -> Value
>=20
> Also move it up two lines so that it follows V4L2_CID_MPEG_VIDEO_USE_LTR_=
FRAMES
> rather than FWHT controls.
>=20
> > =20
> >  	/* VPX controls */
> >  	case V4L2_CID_MPEG_VIDEO_VPX_NUM_PARTITIONS:		return "VPX Number of P=
artitions";
> > @@ -1507,6 +1508,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, e=
num v4l2_ctrl_type *type,
> >  		*max =3D 0xffffffffffffLL;
> >  		*step =3D 1;
> >  		break;
> > +	case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:
> > +		*type =3D V4L2_CTRL_TYPE_INTEGER;
> > +		*flags |=3D V4L2_CTRL_FLAG_VOLATILE | V4L2_CTRL_FLAG_READ_ONLY;
>=20
> Drop the volatile flag, this isn't a volatile value.
>=20
> > +		break;
> >  	case V4L2_CID_PIXEL_RATE:
> >  		*type =3D V4L2_CTRL_TYPE_INTEGER64;
> >  		*flags |=3D V4L2_CTRL_FLAG_READ_ONLY;
> > diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4=
l2-controls.h
> > index 99c3f5e99da7..974fd254e573 100644
> > --- a/include/uapi/linux/v4l2-controls.h
> > +++ b/include/uapi/linux/v4l2-controls.h
> > @@ -898,6 +898,8 @@ enum v4l2_mpeg_video_av1_level {
> >  	V4L2_MPEG_VIDEO_AV1_LEVEL_7_3 =3D 23
> >  };
> > =20
> > +#define V4L2_CID_MPEG_VIDEO_AVERAGE_QP  (V4L2_CID_CODEC_BASE + 657)
> > +
> >  /*  MPEG-class control IDs specific to the CX2341x driver as defined b=
y V4L2 */
> >  #define V4L2_CID_CODEC_CX2341X_BASE				(V4L2_CTRL_CLASS_CODEC | 0x1000=
)
> >  #define V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE		(V4L2_CID_COD=
EC_CX2341X_BASE+0)
>=20
> Regards,
>=20
> 	Hans
>=20


