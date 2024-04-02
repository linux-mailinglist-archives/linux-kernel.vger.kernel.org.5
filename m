Return-Path: <linux-kernel+bounces-128027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06659895521
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2938D1C20BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A0B83CAE;
	Tue,  2 Apr 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwXOKwDD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D471C8062A;
	Tue,  2 Apr 2024 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063989; cv=none; b=ckOkC0VKLtTLG9zZNW2r0GDGIuMY2lftj1PWvokDYZlLc1UGmcd0wV3Nh8ISFk0D8ZSTJ8bynMjOBfK3Nd+RZmsnWcwWeehmzrkz4BuPszRxyoSOjufLKMbvxIhqn4fX4q/3Ofi/uwbFkPn5h8nUrACVNG/JxXpy5O5UtwE8eYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063989; c=relaxed/simple;
	bh=6D05Yya3KxK0OkWkNXVX0Mp3DXfWGd2Ns0Ca9ovdfaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reVBf5iEw0F8eFHbyJp5nBkjllSnp+qvML/xJ02FEoWyhrE0zNG7fSGVOr/RePAbuTelviO3mkEMkjEdn5DNn1eW7y1KaHhxtxsflBh3LESYU+eqmEA+dAsosfbanDMdL/wnelL8tN9mtSYoxlq6IgC4HN+IaxA6UZdUTKLxKIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwXOKwDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAE6C43390;
	Tue,  2 Apr 2024 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712063988;
	bh=6D05Yya3KxK0OkWkNXVX0Mp3DXfWGd2Ns0Ca9ovdfaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MwXOKwDDFThNQSSdwFoyIDPuzphqyMHtPg1wzAPeJNlw7LZilwgpYtOb5qPMLjVpV
	 CYUxFWbal2HMJeC93LtARxsmlb6Xu2PACLlFnYHIjXWlmS6M7tWn5kMUJ+qupt3FAv
	 U7fR66IQmSw/jK5b6N9x64B8O/rca4SOIhBepo5bAO1g9f+6nUpApx/hJ1JlMQAnFk
	 Vt3XjdtRfWGVvAnfqY43tgY9tNw2FLYYI90+yZA41lRIHs5PSTjZn1p04QirVPulpo
	 cI7UT62Ym4BcKJKH4D826Xqw5qw7ekg3r8hSuDN2oigtUp8rACw2FP0YND2Aex/qpZ
	 aRT7q6NBPsanQ==
Date: Tue, 2 Apr 2024 15:19:43 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev,
	linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: Re: [RESEND PATCH v3 1/2] VT: Add KDFONTINFO ioctl
Message-ID: <ZgwF72yHH_0-A4FW@example.org>
References: <cover.1710252966.git.legion@kernel.org>
 <cover.1712053848.git.legion@kernel.org>
 <ed056326540f04b72c97a276fbcc316e1b2f6371.1712053848.git.legion@kernel.org>
 <74ca50e0-61b1-4d4c-85dd-a5d920548c04@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74ca50e0-61b1-4d4c-85dd-a5d920548c04@kernel.org>

On Tue, Apr 02, 2024 at 01:02:20PM +0200, Jiri Slaby wrote:
> Hi,
> 
> On 02. 04. 24, 12:32, Alexey Gladkov wrote:
> > Each driver has its own restrictions on font size. There is currently no
> > way to understand what the requirements are. The new ioctl allows
> > userspace to get the minmum and maximum font size values.
> 
> minimum

Typo. Sorry.

> > Acked-by: Helge Deller <deller@gmx.de>
> > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > ---
> >   drivers/tty/vt/vt.c       | 24 ++++++++++++++++++++++++
> >   drivers/tty/vt/vt_ioctl.c | 13 +++++++++++++
> >   include/linux/console.h   |  2 ++
> >   include/linux/vt_kern.h   |  1 +
> >   include/uapi/linux/kd.h   | 13 ++++++++++++-
> >   5 files changed, 52 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 156efda7c80d..8c2a3d98b5ec 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -4680,6 +4680,30 @@ int con_font_op(struct vc_data *vc, struct console_font_op *op)
> >   	return -ENOSYS;
> >   }
> >   
> > +int con_font_info(struct vc_data *vc, struct console_font_info *info)
> > +{
> > +	int rc = -EINVAL;
> 
> This initialization appears to be unneeded.
> 
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
> > index 8c685b501404..b3b4e4b69366 100644
> > --- a/drivers/tty/vt/vt_ioctl.c
> > +++ b/drivers/tty/vt/vt_ioctl.c
> > @@ -479,6 +479,19 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
> >   		break;
> >   	}
> >   
> > +	case KDFONTINFO: {
> > +		struct console_font_info fnt_info;
> > +
> > +		if (copy_from_user(&fnt_info, up, sizeof(fnt_info)))
> > +			return -EFAULT;
> 
> Who uses the copied values?

No one. I did it by analogy with KDFONTOP. Thanks!

> > +		ret = con_font_info(vc, &fnt_info);
> > +		if (ret)
> > +			return ret;
> > +		if (copy_to_user(up, &fnt_info, sizeof(fnt_info)))
> 
> We should do the preferred sizeof(*up) here...
> 
> > +			return -EFAULT;
> > +		break;
> > +	}
> > +
> >   	default:
> >   		return -ENOIOCTLCMD;
> >   	}
> ...
> > --- a/include/uapi/linux/kd.h
> > +++ b/include/uapi/linux/kd.h
> > @@ -183,8 +183,19 @@ struct console_font {
> >   
> >   #define KD_FONT_FLAG_DONT_RECALC 	1	/* Don't recalculate hw charcell size [compat] */
> >   
> > +#define KDFONTINFO	0x4B73	/* font information */
> 
> Why not properly define the number using IOC() et al.? K (that 0x4b) is 
> even reserved for kd.h.

I just did the same as the numbers above. This entire header does not use
IOC().

Should I convert this header as a separate commit?

> > +#define KD_FONT_INFO_FLAG_LOW_SIZE	(1U << 0) /* 256 */
> > +#define KD_FONT_INFO_FLAG_HIGH_SIZE	(1U << 1) /* 512 */
> 
> _BITUL()

Make sense. I will use it.

> > +struct console_font_info {
> > +	unsigned int min_width, min_height;	/* minimal font size */
> > +	unsigned int max_width, max_height;	/* maximum font size */
> > +	unsigned int flags;			/* KD_FONT_INFO_FLAG_* */
> 
> This does not look like a well-defined™ and extendable uapi structure. 
> While it won't change anything here, still use fixed-length __u32.
> 
> And you should perhaps add some reserved fields. Do not repeat the same 
> mistakes as your predecessors with the current kd uapi.

I thought about it, but I thought it would be overengineering.
Can you suggest how best to do this?

-- 
Rgrds, legion


