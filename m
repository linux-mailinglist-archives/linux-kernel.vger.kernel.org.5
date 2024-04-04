Return-Path: <linux-kernel+bounces-130803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06A897D48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AFB1F2562A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892A37492;
	Thu,  4 Apr 2024 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZqCX2+Km"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28BA1C290;
	Thu,  4 Apr 2024 01:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712192668; cv=none; b=hL+mgajxiK4newfSWk5H1YLGMpiR1Ty56R3zeTrCV9udD42fVYDyGjbGT3HDbl0a5gAHjLfmNEJ3nqg9O+W+4w9Nzm/5GmypUUXn6sKDDEiLy8a+BzFfExYwkw+UYS177Vpyu/tAGnRAEw+l4TxUN4Ekux7xWxLDGrlFX2VvoCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712192668; c=relaxed/simple;
	bh=CsSunsGsmrBhTTg8MRk6DIdjh8MY9O8BuTCfLBCOtSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfcjTj2jz1zTTjpqOiMBPB1VsfD5J25ZcfXKjt75y8CtwG2OKI811cSt8+MzRLUT0e0ChhtNwTT+N1ZtxmgHfv1dxcK8shwBUP7vV43UsizxUGy6Ccx9X/o2p1SAOI1Gvgt9y3kM1wNABaKIxchkg5Ql/atr8vZELLT3lfp/MeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZqCX2+Km; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 636CA4D4;
	Thu,  4 Apr 2024 03:03:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712192627;
	bh=CsSunsGsmrBhTTg8MRk6DIdjh8MY9O8BuTCfLBCOtSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZqCX2+Kmhzxea3Q0l5I2ggzAB3ZK79ftDIm79k7kix7FDxgxBA5HNX2f+smdDTxce
	 iJEq+ZcDW28uE6TR6u4SGD05C/40T4cUUyfghUWScqFTvXQxb0b2lNyn1B1NZ89NRw
	 ugDN1BcNOJlqmkeTxlcdy3pY8qCibtTCGkJVWYjE=
Date: Thu, 4 Apr 2024 04:04:14 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Explicit alignment of uvc_frame and
 uvc_format
Message-ID: <20240404010414.GF23803@pendragon.ideasonboard.com>
References: <20230501-uvc-align-v1-1-0f713e4b84c3@chromium.org>
 <20240322115606.GA31979@pendragon.ideasonboard.com>
 <CANiDSCuB0jABPPsoj0RxJ2UbV1UD0i5WwnubySDB0p7LocNJDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCuB0jABPPsoj0RxJ2UbV1UD0i5WwnubySDB0p7LocNJDQ@mail.gmail.com>

Hi Ricardo,

On Fri, Mar 22, 2024 at 03:26:39PM +0100, Ricardo Ribalda wrote:
> On Fri, 22 Mar 2024 at 12:56, Laurent Pinchart wrote:
> > On Mon, May 01, 2023 at 04:49:31PM +0200, Ricardo Ribalda wrote:
> > > Struct uvc_frame and uvc_format are packaged together on
> > > streaming->formats on a sigle allocation.
> >
> > s/sigle/single/
> >
> > > This is working fine because both structures have a field with a
> > > pointer, but it will stop working when the sizeof() of any of those
> > > structs is not a muliple of the sizeof(void*).
> > >
> > > Make that aligment contract explicit.
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > > This is better than 3 allocations, and do not have any performance
> > > penalty.
> > > ---
> > >  drivers/media/usb/uvc/uvcvideo.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > index 9a596c8d894a..03e8a543c8e6 100644
> > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > @@ -252,7 +252,7 @@ struct uvc_frame {
> > >       u8  bFrameIntervalType;
> > >       u32 dwDefaultFrameInterval;
> > >       u32 *dwFrameInterval;
> > > -};
> > > +} __aligned(sizeof(void *)); /* uvc_frame is packed on streaming->formats. */
> >
> > Don't we need u32 alignment here, not void * alignment, given that
> > uvc_frame is followed by an array of u32 ?
> 
> Let me make sure that I explain myself :)
> 
> I made a small program in compiler explorer:
> https://godbolt.org/z/7s9z8WTsx that shows the error that I want to
> avoid
> 
> When we have a structure like this:
> 
> struct n_foo_bar {
>    int n;
>    struct foo *foo;
>    struct bar *bar;
> };
> 
> We expect that *foo and *bar point to memory addresses with the right
> cpu alignment for each struct. Otherwise accessing foo and bar could
> be slow or simply not work.

So far, so good.

> In the driver we are doing something like this to allocate the structure:
> 
> int size
> struct n_foo_bar *out;
> 
> size = n*sizeof(struct foo)+n*sizeof(struct bar) +sizeof(struct n_foo_bar);
> out = malloc(size);
> if (!out)
>   return out;
> 
> out->foo=(void *)(out)+sizeof(struct n_foo_bar);
> out->bar=(void *)(out->foo)+n*sizeof(struct foo);
> 
> But that only works if sizeof(struct foo) is a multiple of the
> alignment required by struct bar.

The real requirement is a bit more complex, it's sizeof(struct n_foo_bar) +
sizeof(struct foo) that needs to be a multiple of the alignment required
by struct bar (and even that is simplified, as it assumes that malloc()
returns a pointer aligned to the requirements of struct bar, which in
practice should always be the case).

> We are "lucky" now because we have a
> pointer in each struct and that gives us a void* padding. ... but if
> we ever remove that pointer from the structure we will be in a bad
> position.

We have three levels in uvcvideo. The top-level structure (your
equivalent of n_foo_bar), struct uvc_format, has a pointer to an array
of struct uvc_frame. The second level, struct uvc_frame, has a pointer
to an array of u32. All three are then allocated in one go,
contiguously.

The largest field in uvc_frame is a pointer, so the alignment
requirement will be fulfilled if struct uvc_format is aligned to
sizeof(void *). When it comes to struct uvc_frame, however, its size
needs to be a multiple of sizeof(u32), not of sizeof(void *).

Given that the alignment constraints are not intrinsic to these
structures, I think it would be better to handle them when allocating
the memory. Something along the line of

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index f33a01dbb329..cbc40d663e4f 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -687,8 +687,11 @@ static int uvc_parse_streaming(struct uvc_device *dev,
 		goto error;
 	}

-	size = nformats * sizeof(*format) + nframes * sizeof(*frame)
+	size = nformats * sizeof(*format);
+	size = ALIGN(size, __alignof__(*frame)) + nframes * sizeof(*frame);
+	size = ALIGN(size, __alignof__(*interval))
 	     + nintervals * sizeof(*interval);
+
 	format = kzalloc(size, GFP_KERNEL);
 	if (format == NULL) {
 		ret = -ENOMEM;

plus a corresponding change when calculating the pointers to the frames
and intervals just after.

> With the  __aligned(sizeof(void *)); I want to explicitly say:
> 
> "Ey, this struct is embedded in another struct and they are allocated
> contiguously"
> 
> Does it make more sense now?
>
> > >
> > >  struct uvc_format {
> > >       u8 type;
> > > @@ -266,7 +266,7 @@ struct uvc_format {
> > >
> > >       unsigned int nframes;
> > >       struct uvc_frame *frame;
> > > -};
> > > +} __aligned(sizeof(void *)); /* uvc_format is packed on streaming->formats. */
> >
> > Same here, technically we need to ensure that the following uvc_frame
> > will be aligned. void * alignment will give us that now, but that's not
> > the actual constraint.
> >
> > Wouldn't it be better to handle the alignment constraints explicitly
> > when allocating the memory ? It's not that uvc_frame and uvc_format have
> > intrinsic alignment constraints, the constraints are only needed because
> > of the way memory is allocated.
> >
> > >
> > >  struct uvc_streaming_header {
> > >       u8 bNumFormats;
> > >
> > > ---
> > > base-commit: 58390c8ce1bddb6c623f62e7ed36383e7fa5c02f
> > > change-id: 20230501-uvc-align-6ff202b68dab

-- 
Regards,

Laurent Pinchart

