Return-Path: <linux-kernel+bounces-149906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554698A97AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D91281652
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C4E15D5CD;
	Thu, 18 Apr 2024 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZzE/SIh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143D15AAAD;
	Thu, 18 Apr 2024 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437144; cv=none; b=CxmEUSS9T829Px+YhaxL7WaqDtIM59YCS0RrBbg5g3GksTmLbf6PG6EayfhkAAQZBk1SKTzV/eHkXH1rVKKVVJQXcs+hbIx9pbpssjfo/dJY9tnMrxjqPwBU9NHYaXaQV6UOyNxOV/E3D5zapScESIV6n7FCaQBHUV1fd4+bx0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437144; c=relaxed/simple;
	bh=qYBdQZFBaT3MRR2ejVHKQCzbq0TMjq5iVNYFOAd+fuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YN86jmC0AVaK+6DSnPmvzEHlDSaRc3s2/ovTZbZ+1/IlO/0f2HKF4eamkFv9NGtZqjAxwaOAk4JNP/bYL/byaaLzhMT4+27UNQfEIse29/trs51BsIhB191LBF/GmeFiyQSD1Mljb73PjNXe62CMWFenu91E1Gq823pjk/8p//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZzE/SIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72314C2BD11;
	Thu, 18 Apr 2024 10:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713437143;
	bh=qYBdQZFBaT3MRR2ejVHKQCzbq0TMjq5iVNYFOAd+fuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZzE/SIhyLLEDsK9wICo3F9lwT76UJZVK/AO/lmql2W+shkffCr/nLMR+DAgz5g28
	 cIxj/pfp1YNLvz/CpKFFJjk+trtCg0maSRx+o8R//tfg6u/YhGDvuQBp8XygxvM9eT
	 m4cfoprVSUgoWlXU/fIOAU759g4biYWnn78Howzz9ar/obZn9kr/7jQC88tb1XdDGz
	 LzqmkufyPfnqMV8S27C5HdxGyPgl4/rH/OGexot9WFgdN+juKdoP4FVLU/mX4REtQ5
	 vPPMkJSHM99OfksPq0Ub0Vx2+QPiRwLpR7yz3AM/oPRnM6pbhoyIcnce82oVROHk4G
	 yxO4slOtZI14w==
Date: Thu, 18 Apr 2024 12:45:37 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev,
	linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 2/3] VT: Add KDFONTINFO ioctl
Message-ID: <ZiD50WZZv3OOad7L@example.org>
References: <cover.1712080158.git.legion@kernel.org>
 <cover.1713375378.git.legion@kernel.org>
 <bd2755e7b6ebe9b49e82d04d9908a176e0fe2f15.1713375378.git.legion@kernel.org>
 <9019dc74-35ad-43d7-8763-cea3da93e9c1@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9019dc74-35ad-43d7-8763-cea3da93e9c1@gmx.de>

On Wed, Apr 17, 2024 at 09:31:53PM +0200, Helge Deller wrote:
> On 4/17/24 19:37, Alexey Gladkov wrote:
> > Each driver has its own restrictions on font size. There is currently no
> > way to understand what the requirements are. The new ioctl allows
> > userspace to get the minimum and maximum font size values.
> >
> > Acked-by: Helge Deller <deller@gmx.de>
> > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > ---
> >   drivers/tty/vt/vt.c       | 24 ++++++++++++++++++++++++
> >   drivers/tty/vt/vt_ioctl.c | 13 +++++++++++++
> >   include/linux/console.h   |  3 +++
> >   include/linux/vt_kern.h   |  1 +
> >   include/uapi/linux/kd.h   | 14 ++++++++++++++
> >   5 files changed, 55 insertions(+)
> >
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 9b5b98dfc8b4..e8db0e9ea674 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -4851,6 +4851,30 @@ int con_font_op(struct vc_data *vc, struct console_font_op *op)
> >   	return -ENOSYS;
> >   }
> >
> > +int con_font_info(struct vc_data *vc, struct console_font_info *info)
> > +{
> > +	int rc;
> > +
> > +	info->min_height = 0;
> > +	info->max_height = max_font_height;
> > +
> > +	info->min_width = 0;
> > +	info->max_width = max_font_width;
> > +
> > +	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
> > +
> > +	console_lock();
> > +	if (vc->vc_mode != KD_TEXT)
> > +		rc = -EINVAL;
> > +	else if (vc->vc_sw->con_font_info)
> > +		rc = vc->vc_sw->con_font_info(vc, info);
> > +	else
> > +		rc = -ENOSYS;
> > +	console_unlock();
> > +
> > +	return rc;
> > +}
> > +
> >   /*
> >    *	Interface exported to selection and vcs.
> >    */
> > diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> > index 4b91072f3a4e..9a2f8081f650 100644
> > --- a/drivers/tty/vt/vt_ioctl.c
> > +++ b/drivers/tty/vt/vt_ioctl.c
> > @@ -479,6 +479,19 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
> >   		break;
> >   	}
> >
> > +	case KDFONTINFO: {
> > +		struct console_font_info fnt_info;
> > +
> > +		memset(&fnt_info, 0, sizeof(fnt_info));
> > +
> > +		ret = con_font_info(vc, &fnt_info);
> > +		if (ret)
> > +			return ret;
> > +		if (copy_to_user(up, &fnt_info, sizeof(fnt_info)))
> > +			return -EFAULT;
> > +		break;
> > +	}
> > +
> >   	default:
> >   		return -ENOIOCTLCMD;
> >   	}
> > diff --git a/include/linux/console.h b/include/linux/console.h
> > index 31a8f5b85f5d..4b798322aa01 100644
> > --- a/include/linux/console.h
> > +++ b/include/linux/console.h
> > @@ -21,6 +21,7 @@
> >   #include <linux/vesa.h>
> >
> >   struct vc_data;
> > +struct console_font_info;
> >   struct console_font_op;
> >   struct console_font;
> >   struct module;
> > @@ -102,6 +103,8 @@ struct consw {
> >   	bool	(*con_switch)(struct vc_data *vc);
> >   	bool	(*con_blank)(struct vc_data *vc, enum vesa_blank_mode blank,
> >   			     bool mode_switch);
> > +	int	(*con_font_info)(struct vc_data *vc,
> > +				 struct console_font_info *info);
> >   	int	(*con_font_set)(struct vc_data *vc,
> >   				const struct console_font *font,
> >   				unsigned int vpitch, unsigned int flags);
> > diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
> > index d008c3d0a9bb..383b3a4f6113 100644
> > --- a/include/linux/vt_kern.h
> > +++ b/include/linux/vt_kern.h
> > @@ -33,6 +33,7 @@ void do_blank_screen(int entering_gfx);
> >   void do_unblank_screen(int leaving_gfx);
> >   void poke_blanked_console(void);
> >   int con_font_op(struct vc_data *vc, struct console_font_op *op);
> > +int con_font_info(struct vc_data *vc, struct console_font_info *info);
> >   int con_set_cmap(unsigned char __user *cmap);
> >   int con_get_cmap(unsigned char __user *cmap);
> >   void scrollback(struct vc_data *vc);
> > diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
> > index 8ddb2219a84b..68b715ad4d5c 100644
> > --- a/include/uapi/linux/kd.h
> > +++ b/include/uapi/linux/kd.h
> > @@ -185,6 +185,20 @@ struct console_font {
> >
> >   #define KD_FONT_FLAG_DONT_RECALC 	1	/* Don't recalculate hw charcell size [compat] */
> >
> > +/* font information */
> > +
> > +#define KD_FONT_INFO_FLAG_LOW_SIZE	_BITUL(0) /* 256 */
> > +#define KD_FONT_INFO_FLAG_HIGH_SIZE	_BITUL(1) /* 512 */
> 
> Do we really need those bits?
> You set a default min/max font size in con_font_info() above,
> and all drivers can override those values.
> So, there are always min/max sizes available.

These bits are not about the minimum and maximum glyph size, but about the
number of glyphs in the font.

Maybe this is an overkill, but sticon has this check:

if ((w < 6) || (h < 6) || (w > 32) || (h > 32) || (vpitch != 32)
    || (op->charcount != 256 && op->charcount != 512))

[ to be honest, I don’t know why this driver doesn’t accept a glyph of
width 4 ]

I thought it would be worth fixing the maximum number of requirements in
the drivers since I started adding a new ioctl.

> > +struct console_font_info {
> > +	__u32  flags;			/* KD_FONT_INFO_FLAG_* */
> 
> One space too much in front of "flags" ?

No problem. I will fix.

> 
> > +	__u32 min_width, min_height;	/* minimal font size */
> > +	__u32 max_width, max_height;	/* maximum font size */
> > +	__u32 reserved[5];		/* This field is reserved for future use. Must be 0. */
> > +};
> > +
> > +#define KDFONTINFO	_IOR(KD_IOCTL_BASE, 0x73, struct console_font_info)
> > +
> >   /* note: 0x4B00-0x4B4E all have had a value at some time;
> >      don't reuse for the time being */
> >   /* note: 0x4B60-0x4B6D, 0x4B70-0x4B72 used above */
> 

-- 
Rgrds, legion


