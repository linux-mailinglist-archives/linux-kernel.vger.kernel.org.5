Return-Path: <linux-kernel+bounces-104193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C687CA7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729441C215C3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC154179BC;
	Fri, 15 Mar 2024 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="YZ6lHy1G"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88C17BA3;
	Fri, 15 Mar 2024 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494141; cv=none; b=QbD8Q6/oTHgS5XEyL/2ZL2Z5jRN6KalzETbP0HNXKe2GrAdIGjdvFEiW2uEQkrixh8moEli9nwKirWkyfdhZvbZtYMLGnUnzAzlirA5W06sVGkZhGt2krmyDYcPYbXz1/UFgVMIVjoyzPVpGaLh60mq3HquBD0HQnwjapPCJPVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494141; c=relaxed/simple;
	bh=yazkDWz8vY36nyv0hHpqPtCXAY3bGBXrURnrM/T+U9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbNjloFntnXfoZcwfyQWD39VkZdEtU3LNC+MP7TNMJjSWuZbUM8y/cvQpYK21htJ5MaKDPqogAH107Qfr8ksvJzyB3U69eQSXfzsNC/EQh0x7P8QwZ1Wgc16ja5xDGLgtZOK9J96wPAuuf0e5R9DWuZaf8z34DwnB+6oMqEyo8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=YZ6lHy1G; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710494132; x=1711098932; i=deller@gmx.de;
	bh=OgXuXKjwFfBK8Vy34O9Xx8GHBwv2eCacCtLGNY71u7c=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=YZ6lHy1GJLaD8bmtH+n18Ch90k0WLEPP7TyyuTjqDcZvvjBuMTNvXmY3c9TDMsaE
	 b1m2Vxn2v4vGVeZnb9ydPcKS1rkkNk+8M7LnnDKXjoIqizDYgjq5JoCoM3WLpkXwO
	 of+8yy0SiGR9ubcsu+hruDy8iYnyPTNQVcjtMkapskAlKBnojjYPl4xVy3h2uVh0Y
	 +JCqGb8mQBWbeGjA7MnNuEbOCBeT/22W+iFB0jsCgKZKE0IlsilWgxheG+1lTLqHz
	 1y/BJMjOnfuakPKE/nodX/sQV3P/Vv4sF/i8FGHOfWURaXkJ7Xiw4JKp7t/8uY3Iq
	 sQmcqNLeWiu+Uk5hrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.155.107]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5if-1rShrV029F-00J24i; Fri, 15
 Mar 2024 10:15:32 +0100
Message-ID: <2f8356a5-cf83-47a7-821c-0c0d6804b029@gmx.de>
Date: Fri, 15 Mar 2024 10:15:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] VT: Add KDFONTINFO ioctl
Content-Language: en-US
To: legion@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev,
 linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <cover.1708960303.git.legion@kernel.org>
 <cover.1710252966.git.legion@kernel.org>
 <ed056326540f04b72c97a276fbcc316e1b2f6371.1710252966.git.legion@kernel.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ed056326540f04b72c97a276fbcc316e1b2f6371.1710252966.git.legion@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wm7RlCTBOeGyFuyg4lZr35iCFEQB7vCDKLKNcAP0TpbSv/3zBrW
 43UWKNZ3iShv876yFIy8vmJZ/FQWsEKcAWSS4Mpe4mezfR4+7lunfXU1IZxvXRQHaeuHm72
 W8LI/SFdY6UqXCHr/UrMQUb+Xtwkdk6X6lpGqQ3I43uVfYogaQcyTDUO69MNtWn/mIdTPmM
 5LRlHkQcPyVPoxX+f6NLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qb4I6Mj66/E=;lfYQsgHAivXHVeyFsME4KKCFkhA
 5PYeSCZiee1AyYtLrDhZO8JmdCrJG1rEF6EOFaOLIOhiN0BO5yvVJ549rXkGpMunRpSl404+a
 S94Rhpbd/Z9AQpIbsco+H/ykSonGA83+2Niv00uOPtOcvAn9O3NVg16GmOMJbLHwUxVA3nKwR
 KHv6uvp5PWjROWlmkpzAeNPMvqmE1W9QfAxE7mrcupSp2JnzKyD2841GvH/yjUcsic1+luwOU
 +6v/VnIrW04f9u/DTWTiTMn2FRN2rq1yXprKKr738U+mOXbgXsdtG+JB+ILFkZkWXCUrKnjAy
 Y8qEoK1m0YSkfM9bQNKrVeGIt5DLhJHn828GTHrJ6mr7/kUM2046WE2OhUEdiG55vpM5czlNz
 Pv546PGhI0VOi4H70YPcN34fvBGkRccKTQ41BH5h8Bxk9snvCCOy/AtodcNcECmJlm2m3xHK5
 +QJzqypYVK2sCnFNWwWYCYMsFMo6eJ3mQdSqBIfrMJQPqHJ4dTyrmk8M14Zl+x4S5+s7MYVdb
 DptoE70qt7yZcFBgjQdJXNDow0QbyD5ZsJiLxXT3xmzjXYFWbLe2ulpVaEJ51F0LGbrSrmLg4
 CsL2b1fK5BUxgxdxOblof1qzPW7g299fZSic+DEVvpeExFpe2pT2b8bozUrCwz21Wix8h2ZKD
 ahsNdrh13DTlafLvf4RFOlShuAdsu7azaoal7b5kNfO2FujH650F6xXneLhpM5R5Xrneu/x2D
 WO4rpb4iiYwX7TEj3Qw0i9PUNKpu0u4YfSXcu8hSj9czKTakUDIomgKSgPHPjkUJN5xkUcVKw
 6by6zKm+js8heDgcTA8/B6lSks9Etg0aA9bnAp1XJdZZA=

On 3/12/24 15:23, legion@kernel.org wrote:
> From: Alexey Gladkov <legion@kernel.org>
>
> Each driver has its own restrictions on font size. There is currently no
> way to understand what the requirements are. The new ioctl allows
> userspace to get the minmum and maximum font size values.
>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>

Acked-by: Helge Deller <deller@gmx.de>

Helge

> ---
>   drivers/tty/vt/vt.c       | 24 ++++++++++++++++++++++++
>   drivers/tty/vt/vt_ioctl.c | 13 +++++++++++++
>   include/linux/console.h   |  2 ++
>   include/linux/vt_kern.h   |  1 +
>   include/uapi/linux/kd.h   | 13 ++++++++++++-
>   5 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 156efda7c80d..8c2a3d98b5ec 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -4680,6 +4680,30 @@ int con_font_op(struct vc_data *vc, struct consol=
e_font_op *op)
>   	return -ENOSYS;
>   }
>
> +int con_font_info(struct vc_data *vc, struct console_font_info *info)
> +{
> +	int rc =3D -EINVAL;
> +
> +	info->min_height =3D 0;
> +	info->max_height =3D max_font_height;
> +
> +	info->min_width =3D 0;
> +	info->max_width =3D max_font_width;
> +
> +	info->flags =3D KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SI=
ZE;
> +
> +	console_lock();
> +	if (vc->vc_mode !=3D KD_TEXT)
> +		rc =3D -EINVAL;
> +	else if (vc->vc_sw->con_font_info)
> +		rc =3D vc->vc_sw->con_font_info(vc, info);
> +	else
> +		rc =3D -ENOSYS;
> +	console_unlock();
> +
> +	return rc;
> +}
> +
>   /*
>    *	Interface exported to selection and vcs.
>    */
> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> index 8c685b501404..b3b4e4b69366 100644
> --- a/drivers/tty/vt/vt_ioctl.c
> +++ b/drivers/tty/vt/vt_ioctl.c
> @@ -479,6 +479,19 @@ static int vt_k_ioctl(struct tty_struct *tty, unsig=
ned int cmd,
>   		break;
>   	}
>
> +	case KDFONTINFO: {
> +		struct console_font_info fnt_info;
> +
> +		if (copy_from_user(&fnt_info, up, sizeof(fnt_info)))
> +			return -EFAULT;
> +		ret =3D con_font_info(vc, &fnt_info);
> +		if (ret)
> +			return ret;
> +		if (copy_to_user(up, &fnt_info, sizeof(fnt_info)))
> +			return -EFAULT;
> +		break;
> +	}
> +
>   	default:
>   		return -ENOIOCTLCMD;
>   	}
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 779d388af8a0..5bea6f6c2042 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -20,6 +20,7 @@
>   #include <linux/types.h>
>
>   struct vc_data;
> +struct console_font_info;
>   struct console_font_op;
>   struct console_font;
>   struct module;
> @@ -59,6 +60,7 @@ struct consw {
>   			unsigned int lines);
>   	int	(*con_switch)(struct vc_data *vc);
>   	int	(*con_blank)(struct vc_data *vc, int blank, int mode_switch);
> +	int	(*con_font_info)(struct vc_data *vc, struct console_font_info *inf=
o);
>   	int	(*con_font_set)(struct vc_data *vc, struct console_font *font,
>   			unsigned int vpitch, unsigned int flags);
>   	int	(*con_font_get)(struct vc_data *vc, struct console_font *font,
> diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
> index c1f5aebef170..6bda4cc1fe6f 100644
> --- a/include/linux/vt_kern.h
> +++ b/include/linux/vt_kern.h
> @@ -32,6 +32,7 @@ void do_blank_screen(int entering_gfx);
>   void do_unblank_screen(int leaving_gfx);
>   void poke_blanked_console(void);
>   int con_font_op(struct vc_data *vc, struct console_font_op *op);
> +int con_font_info(struct vc_data *vc, struct console_font_info *info);
>   int con_set_cmap(unsigned char __user *cmap);
>   int con_get_cmap(unsigned char __user *cmap);
>   void scrollback(struct vc_data *vc);
> diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
> index 6b384065c013..781e086e55bf 100644
> --- a/include/uapi/linux/kd.h
> +++ b/include/uapi/linux/kd.h
> @@ -183,8 +183,19 @@ struct console_font {
>
>   #define KD_FONT_FLAG_DONT_RECALC 	1	/* Don't recalculate hw charcell s=
ize [compat] */
>
> +#define KDFONTINFO	0x4B73	/* font information */
> +
> +#define KD_FONT_INFO_FLAG_LOW_SIZE	(1U << 0) /* 256 */
> +#define KD_FONT_INFO_FLAG_HIGH_SIZE	(1U << 1) /* 512 */
> +
> +struct console_font_info {
> +	unsigned int min_width, min_height;	/* minimal font size */
> +	unsigned int max_width, max_height;	/* maximum font size */
> +	unsigned int flags;			/* KD_FONT_INFO_FLAG_* */
> +};
> +
>   /* note: 0x4B00-0x4B4E all have had a value at some time;
>      don't reuse for the time being */
> -/* note: 0x4B60-0x4B6D, 0x4B70-0x4B72 used above */
> +/* note: 0x4B60-0x4B6D, 0x4B70-0x4B73 used above */
>
>   #endif /* _UAPI_LINUX_KD_H */


