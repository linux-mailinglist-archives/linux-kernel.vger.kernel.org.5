Return-Path: <linux-kernel+bounces-68613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC2F857D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72693B248E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0CA1292EC;
	Fri, 16 Feb 2024 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i06tgrfl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21750128825
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088614; cv=none; b=mYA+mJcI/7YOy10r8HsVsCl1WxgE30ikEi9NImZ/pnLwi7stfbl73RCiqNBsZCoaqtXftsEniShJrqN785GI38ViHTbKICUnWu/Ic2EWtxdIV3heSdogAwbXZW4tTCW834K8czmuIzL3h7pLQ7VXJUhn6du8tSENM5rD1RtfW+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088614; c=relaxed/simple;
	bh=IJXUpJ+KNd1hRZ4fkW1Ba3sEcB2HeCkZOQBr1aRwnEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJAN+MvNdTvxSPAzPkJMqwZMO9iqMKPyVntJl0Ldq2oG3rsi2ipyQ2TqNG+HR8Turu2Yi2L128VonCfwP8lqAjSDfLWKRYeyZFnUKGBfDmhIaCAuuG0wLhMCehdnP2bmejcZ72Pyw/Cd0xuSX6sCr2x01fXeL5TsS2Y5MVXzny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i06tgrfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154BEC433C7;
	Fri, 16 Feb 2024 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708088614;
	bh=IJXUpJ+KNd1hRZ4fkW1Ba3sEcB2HeCkZOQBr1aRwnEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i06tgrflTvEdDi8uB9dkqCRbkUzFm8n9Nqmj62uvk4b9Nfx3suMd5u4qaj5SHsp9X
	 8cuQ6zZaZHB335REOCP8JvWphIRe/0zdtP8Ad5R4Qw20rL5CFJoIRoIYfifPosQCR3
	 iQczZnWRF2yf6Yglun9XpEVSYNLBpNLAFhB76rWhasWZppSLHZM55SqsE/YHUr/lE4
	 +reOufmMfl+l++sieFc0NRHlfDQ9pNcESnod1nA16gRCPbumR2VRM/vGIG4pxtJM3i
	 80jNIMYcxN1v1tsjQmiogPYxbl31v3GqeBf1EDhlfqjEhz4zcxlXSZfnytkRrLH5S2
	 pIb2D5wdixNJQ==
Date: Fri, 16 Feb 2024 14:03:29 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 3/5] sticon: Allow to get max font width and height
Message-ID: <Zc9dIRLbna585cGM@example.org>
References: <cover.1708011391.git.legion@kernel.org>
 <0c724c30a36aefe2cb4470182cf868d256fbabcd.1708011391.git.legion@kernel.org>
 <7c91e5e0-a6eb-4d53-89ed-efde04f57c7c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c91e5e0-a6eb-4d53-89ed-efde04f57c7c@kernel.org>

On Fri, Feb 16, 2024 at 08:10:15AM +0100, Jiri Slaby wrote:
> On 15. 02. 24, 16:37, Alexey Gladkov wrote:
> > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > ---
> >   drivers/video/console/sticon.c | 21 +++++++++++++++++++--
> >   1 file changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
> > index 992a4fa431aa..63368b3ff9c5 100644
> > --- a/drivers/video/console/sticon.c
> > +++ b/drivers/video/console/sticon.c
> > @@ -56,6 +56,11 @@
> >   #define BLANK 0
> >   static int vga_is_gfx;
> >   
> > +#define STICON_MIN_FONT_WIDTH 6
> > +#define STICON_MIN_FONT_HEIGHT 6
> > +#define STICON_MAX_FONT_WIDTH 32
> > +#define STICON_MAX_FONT_HEIGHT 32
> > +
> >   #define STI_DEF_FONT	sticon_sti->font
> >   
> >   /* borrowed from fbcon.c */
> > @@ -180,8 +185,10 @@ static int sticon_set_font(struct vc_data *vc, struct console_font *op,
> >   	struct sti_cooked_font *cooked_font;
> >   	unsigned char *data = op->data, *p;
> >   
> > -	if ((w < 6) || (h < 6) || (w > 32) || (h > 32) || (vpitch != 32)
> > -	    || (op->charcount != 256 && op->charcount != 512))
> > +	if ((w < STICON_MIN_FONT_WIDTH) || (h < STICON_MIN_FONT_HEIGHT) ||
> > +	    (w > STICON_MAX_FONT_WIDTH) || (h > STICON_MAX_FONT_HEIGHT) ||
> 
> Will
> !in_range(w, STICON_MIN_FONT_WIDTH, STICON_MAX_FONT_WIDTH)
> look better?

Sure! Much better. I made this patch to illustrate what I mean. I will
finish it if you find the idea itself acceptable.

> > +	    (vpitch != 32) ||
> > +	    (op->charcount != 256 && op->charcount != 512))
> >   		return -EINVAL;
> >   	pitch = ALIGN(w, 8) / 8;
> >   	bpc = pitch * h;
> > @@ -273,6 +280,15 @@ static int sticon_font_set(struct vc_data *vc, struct console_font *font,
> >   	return sticon_set_font(vc, font, vpitch);
> >   }
> >   
> > +static int sticon_font_info(struct vc_data *vc, struct console_font *font)
> > +{
> > +	font->width = STICON_MAX_FONT_WIDTH;
> > +	font->height = STICON_MAX_FONT_HEIGHT;
> > +	font->charcount = 512;
> 
> Why not to have a macro for this constant?

Because I don’t know how to correctly transfer this limit to userspace.
I mean, we have the code:

if (op->charcount != 256 && op->charcount != 512)
	return -EINVAL;

So 512 is not exactly the maximum number of glyphs. And such checks in the
code begin to look very strange.

if (op->charcount != 256 && op->charcount != STICON_MAX_FONT_GLYPHS)
	return -EINVAL;

So I decided not to give the value 512 a name.

In fact, I think this should be passed to userspace as a binary flag.
Something like this:

struct console_font_info {
	unsigned int min_width, min_height;
	unsigned int max_width, max_height;
	unsigned int fnt_flags;
}

enum console_font_flags {
	FNT_FLAG_LOW_SIZE  = 1U << 0, // 256
	FNT_FLAG_HIGH_SIZE = 1U << 1, // 512
};

> > +
> > +	return 0;
> > +}
> > +
> >   static void sticon_init(struct vc_data *c, int init)
> >   {
> >       struct sti_struct *sti = sticon_sti;
> > @@ -371,6 +387,7 @@ static const struct consw sti_con = {
> >   	.con_scroll		= sticon_scroll,
> >   	.con_switch		= sticon_switch,
> >   	.con_blank		= sticon_blank,
> > +	.con_font_info		= sticon_font_info,
> >   	.con_font_set		= sticon_font_set,
> >   	.con_font_default	= sticon_font_default,
> >   	.con_build_attr		= sticon_build_attr,
> 
> -- 
> js
> suse labs
> 

-- 
Rgrds, legion


