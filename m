Return-Path: <linux-kernel+bounces-149568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064348A92EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BBB2B223C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDB36A353;
	Thu, 18 Apr 2024 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ib04HZiD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87DE3399B;
	Thu, 18 Apr 2024 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421116; cv=none; b=BbjU1K+vkcF3t1mBuGmhuwtRNTYNm6aX7Or9Qeykfk7EPWA+UVJ9sNDdQRaEwQRAB7fNyVFYaeLdluXpBSuaj9XHHbxak9uSKtIdofIasvXLTZeINMxubjHLHvmtTHhmzN9qc0+sQ0Emc72zictYH+WZrdNRTm/+npxc0KcwQ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421116; c=relaxed/simple;
	bh=MxnTVDtDjnYwfWZDmuJOc6TliL4mkFOANDo/r2/ykOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EverwrPDuwczzq10kcVY/7qj1qBWOI9ig9Ge1vbMVsw/NvH3Dhzofe1dPJSHymt1FK9A4o1HPnw+VRO0E5x6cH4J3SaW89eGsyqXBp+hHhWkezAtqqZDwWNZo390eNAEkMseQ2PEEFw7BrqD2nNAl1A66hJIqw847d58ptCYe9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ib04HZiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AFFC113CC;
	Thu, 18 Apr 2024 06:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713421116;
	bh=MxnTVDtDjnYwfWZDmuJOc6TliL4mkFOANDo/r2/ykOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ib04HZiDbQY4HtKDMisUutqYWrKXQs//XzrOde2lUrG5XmHRiYouk7r2AMpt6Tk2v
	 YEZXcVxYot9ibdzLThxNeuvGudMQt1Blyi3wS2dgQNkUkmjmjjLzVDSZeHpMh/d8st
	 NitWmywximUzQ7d6mPjrEu2ErPiyyqeKik/8chXk=
Date: Thu, 18 Apr 2024 08:18:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexey Gladkov <legion@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	kbd@lists.linux.dev, linux-api@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-serial@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v5 2/3] VT: Add KDFONTINFO ioctl
Message-ID: <2024041830-feisty-gristle-5fd0@gregkh>
References: <cover.1712080158.git.legion@kernel.org>
 <cover.1713375378.git.legion@kernel.org>
 <bd2755e7b6ebe9b49e82d04d9908a176e0fe2f15.1713375378.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd2755e7b6ebe9b49e82d04d9908a176e0fe2f15.1713375378.git.legion@kernel.org>

On Wed, Apr 17, 2024 at 07:37:36PM +0200, Alexey Gladkov wrote:
> Each driver has its own restrictions on font size. There is currently no
> way to understand what the requirements are. The new ioctl allows
> userspace to get the minimum and maximum font size values.

Is there any userspace code that uses this yet that we can point to
here?

I know tty ioctls are woefully undocumented, but could there be some
documentation here?

> 
> Acked-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  drivers/tty/vt/vt.c       | 24 ++++++++++++++++++++++++
>  drivers/tty/vt/vt_ioctl.c | 13 +++++++++++++
>  include/linux/console.h   |  3 +++
>  include/linux/vt_kern.h   |  1 +
>  include/uapi/linux/kd.h   | 14 ++++++++++++++
>  5 files changed, 55 insertions(+)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 9b5b98dfc8b4..e8db0e9ea674 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -4851,6 +4851,30 @@ int con_font_op(struct vc_data *vc, struct console_font_op *op)
>  	return -ENOSYS;
>  }
>  
> +int con_font_info(struct vc_data *vc, struct console_font_info *info)
> +{
> +	int rc;
> +
> +	info->min_height = 0;
> +	info->max_height = max_font_height;
> +
> +	info->min_width = 0;
> +	info->max_width = max_font_width;
> +
> +	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
> +
> +	console_lock();
> +	if (vc->vc_mode != KD_TEXT)
> +		rc = -EINVAL;
> +	else if (vc->vc_sw->con_font_info)
> +		rc = vc->vc_sw->con_font_info(vc, info);
> +	else
> +		rc = -ENOSYS;
> +	console_unlock();
> +
> +	return rc;
> +}
> +
>  /*
>   *	Interface exported to selection and vcs.
>   */
> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> index 4b91072f3a4e..9a2f8081f650 100644
> --- a/drivers/tty/vt/vt_ioctl.c
> +++ b/drivers/tty/vt/vt_ioctl.c
> @@ -479,6 +479,19 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
>  		break;
>  	}
>  
> +	case KDFONTINFO: {
> +		struct console_font_info fnt_info;
> +
> +		memset(&fnt_info, 0, sizeof(fnt_info));
> +
> +		ret = con_font_info(vc, &fnt_info);

Shouldn't con_font_info() memset it first?  No need to do it in the
caller.

> +		if (ret)
> +			return ret;
> +		if (copy_to_user(up, &fnt_info, sizeof(fnt_info)))
> +			return -EFAULT;
> +		break;
> +	}
> +
>  	default:
>  		return -ENOIOCTLCMD;
>  	}
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 31a8f5b85f5d..4b798322aa01 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -21,6 +21,7 @@
>  #include <linux/vesa.h>
>  
>  struct vc_data;
> +struct console_font_info;
>  struct console_font_op;
>  struct console_font;
>  struct module;
> @@ -102,6 +103,8 @@ struct consw {
>  	bool	(*con_switch)(struct vc_data *vc);
>  	bool	(*con_blank)(struct vc_data *vc, enum vesa_blank_mode blank,
>  			     bool mode_switch);
> +	int	(*con_font_info)(struct vc_data *vc,
> +				 struct console_font_info *info);

To make the names more obvious, how about:
	con_font_info_get()?

>  	int	(*con_font_set)(struct vc_data *vc,
>  				const struct console_font *font,
>  				unsigned int vpitch, unsigned int flags);
> diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
> index d008c3d0a9bb..383b3a4f6113 100644
> --- a/include/linux/vt_kern.h
> +++ b/include/linux/vt_kern.h
> @@ -33,6 +33,7 @@ void do_blank_screen(int entering_gfx);
>  void do_unblank_screen(int leaving_gfx);
>  void poke_blanked_console(void);
>  int con_font_op(struct vc_data *vc, struct console_font_op *op);
> +int con_font_info(struct vc_data *vc, struct console_font_info *info);
>  int con_set_cmap(unsigned char __user *cmap);
>  int con_get_cmap(unsigned char __user *cmap);
>  void scrollback(struct vc_data *vc);
> diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
> index 8ddb2219a84b..68b715ad4d5c 100644
> --- a/include/uapi/linux/kd.h
> +++ b/include/uapi/linux/kd.h
> @@ -185,6 +185,20 @@ struct console_font {
>  
>  #define KD_FONT_FLAG_DONT_RECALC 	1	/* Don't recalculate hw charcell size [compat] */
>  
> +/* font information */
> +
> +#define KD_FONT_INFO_FLAG_LOW_SIZE	_BITUL(0) /* 256 */
> +#define KD_FONT_INFO_FLAG_HIGH_SIZE	_BITUL(1) /* 512 */

I don't understand why bit 0 and bit 1 have those comments after them.
That's confusing (i.e. bit 0 is NOT 256...)

> +
> +struct console_font_info {
> +	__u32  flags;			/* KD_FONT_INFO_FLAG_* */

Why are there flags if you are only setting these 2 values?  What are
the flags for?

If this is going to be a "multiplexed" type of structure, then make it a
union?  Or maybe we are totally over thinking this whole thing.

All you want is the min/max font size of the console, right?  So perhaps
the whole structure is just:

> +	__u32 min_width, min_height;	/* minimal font size */
> +	__u32 max_width, max_height;	/* maximum font size */

Those 4 variables?  Why have anything else here at all?  For any new
thing you wish to discover, have it be a new ioctl?

> +	__u32 reserved[5];		/* This field is reserved for future use. Must be 0. */

I understand the "must be 0" but this is a read-only structure, so
saying "it will be set to 0" might be better?"  Or something like that?

> +};
> +
> +#define KDFONTINFO	_IOR(KD_IOCTL_BASE, 0x73, struct console_font_info)

As mentioned above how about KDFONTINFOGET?

thanks,

greg k-h

