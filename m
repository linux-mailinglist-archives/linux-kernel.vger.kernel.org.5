Return-Path: <linux-kernel+bounces-104194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1047E87CA84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00192825C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DBD17BA3;
	Fri, 15 Mar 2024 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Ucg22uyj"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331431798A;
	Fri, 15 Mar 2024 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494187; cv=none; b=DnxNZq8yrPPJCvgYQDSl+BFhVGTnYUejvJQ1Hio542bVoC4Y9l4fz6IEdrPtGih4x1uBvb1FWwmHoJMim7un/qcUUyPQ7GujKX9tMkrzjmAAGWCwLRHkVCRVIIJIUQqZv8AsDBknnsENWgofgtYwI7l+bwXbqhkK62nMPEf8o0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494187; c=relaxed/simple;
	bh=sVh221sKCY6dxs59B7y5VJOAx7gsVUi2AyYV7Mo9e2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwrVN0rFOawnv7Evh8iXNUANcR7tqNXH1Gb/WMwC5x9kRqNyWpJF9KiHt6qOGmV3kRqT3NENe7gmVtMzZPBFbHplcpuCZrHM7zXU5Ep/xAhjXg0GcqVcZ3IRiJtZzv6hE2D0xtpBj1vZnyaJtkBi1OM3+PJBP8eop4TFu9eZ6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Ucg22uyj; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710494178; x=1711098978; i=deller@gmx.de;
	bh=hYLXNRNt81ZtoyMN6O1zonkQ13t8/7kmK8R+aKE4kgU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Ucg22uyj8iuv/cDVowkXvUXM10tDk5guuVRCm9CVXYMtR9BzQV9VV3tRu5z5QnpY
	 lNpYStsDC85wxrxgh4UuSrLoKW5Jed/lVkr5Qh1hoZpmduf8wv8MJOmFzwzYN3Jr9
	 8YzCySw+ToFwVFmUGiju8ZYPSab7/YdiPPBvYAMsPzE2ghn8YBqnSkAm7gxz6jn9w
	 eDHRxyVRYCQS/GiNVqCdTwTCAPRWv6zy1yyK5N+KKwiJ604mkbcOXvEyPfLzh35Rn
	 gB6ygfz/h6LrYsWGQ+cLIYzDhZsEuhnfBbQBkyTMfy2QYkMOn/DqbCRFVVI7+W4qE
	 8xKPHA3JSq/Yu781XQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.155.107]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9uU-1rU51E1V7S-00ICSh; Fri, 15
 Mar 2024 10:16:18 +0100
Message-ID: <bc2a7319-2daa-423b-8b18-e55446dbff81@gmx.de>
Date: Fri, 15 Mar 2024 10:16:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] VT: Allow to get max font width and height
Content-Language: en-US
To: legion@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev,
 linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <cover.1708960303.git.legion@kernel.org>
 <cover.1710252966.git.legion@kernel.org>
 <78fcb9ad77b88edee8768806ce6a4d23f6d33118.1710252966.git.legion@kernel.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <78fcb9ad77b88edee8768806ce6a4d23f6d33118.1710252966.git.legion@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1Fz/iIrPY0EpPDzAgv+9YcYDyuPh/pzFhEy2tfwLDbQQt7AnPUQ
 QqOTMT23C5mCjI3Cl14Gum0UqTeu1Jd+JaobIh6XPjqV6UnJCxDdNrNYT1MfFf3r/U7HSW1
 3IGGr4DuTVynY1Lruvp8dT1J36HrDlhpFK3T44OQGl9FWT0bioIQg2LRfjHGrYIT1Yzh0/I
 OAQuZ/X5ZZ9JBfUdNvt4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LjGbrVmHslk=;NTUBkXlAJNIoZVNxfVB5L5Agd0X
 e7waE7PH3wFR/Uv30Y9NVS1FLeTMEGitHyTt2nzPHxDo84tyFsNLTRijRwC0Sph5IkSpcJuKX
 LpSqpNEbDRdHmytT/0v8HaeiN6b1hEDIgpcKP0xkWIUUcp7T5RSyWZgMApLlfz+HORIud7BH/
 zug9clYum/7sDa41zv9fthkYoHIKW9bmzFyJRsn7Z9Qcbuazl3QLSnpdQxTkbi2lOYs5skyAI
 N/z2zuDqaY/5L8+OjPL1YSN8eqVb0LWSyDkGDqkPjHYEOgAxo+MLUK9qFzd8sXguCM53Mo5Nq
 7luiib886lw2S5SiKR2Wtb0Jp/T2kcatO2fzxQUv32wZ8Jkf2D9X9I/Zs02mxscRQYTyVx+at
 GI0ezoaqwtxmnH73OZkVu//O7eM7W2Su3sgze/ARYV1CsI+/rIaoQI47uRwHJma1eaJCugX+c
 azD5UYrII3qX2p5VGhQoJ+hkvtA7zy6r2fX5Df70B4YkpWz37lfZlWBZMyyCN8H4UWjrj1bDr
 nEafIl9rG03PAnmmNTAwzer1+67mAQGQa0zYnxxBBwa927nB/poY1sH9hNGuxiDqtNf9pAzRA
 wj98D+e1K4N+NgEBxDM+OwXhu7lwdkHsSeBMxBXXa4u0ThHlAAE9nCAvfKYElmRNU0f3LLdOL
 nVmbPGv0B0Ly0Pip1jvRJmrgpWylXP00sRSm0ZArTBIY5i/anc5YUnae791CjdNPUTNHWpcgn
 frTsqNbpOzUZKObmKeFYvetauZpl7DVekvQvYQSNwPe+KheGibb05K7LIle6sLbDLHUkqaScW
 7xuRaYmuWjIBF3BFpAEnAyrz8PxRqpV7ciy9MIYRQm4Bc=

On 3/12/24 15:23, legion@kernel.org wrote:
> From: Alexey Gladkov <legion@kernel.org>
>
> The Console drivers has more restrictive font size limits than vt_ioctl.
> This leads to errors that are difficult to handle. If a font whose size
> is not supported is used, an EINVAL error will be returned, which is
> also returned in case of errors in the font itself. At the moment there
> is no way to understand what font sizes the current console driver
> supports.
>
> To solve this problem, we need to transfer information about the
> supported font to userspace from the console driver.
>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>

Acked-by: Helge Deller <deller@gmx.de>

Helge


> ---
>   drivers/video/console/newport_con.c | 21 +++++++++++++++++----
>   drivers/video/console/sticon.c      | 25 +++++++++++++++++++++++--
>   drivers/video/console/vgacon.c      | 21 ++++++++++++++++++++-
>   drivers/video/fbdev/core/fbcon.c    | 22 +++++++++++++++++++++-
>   4 files changed, 81 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/video/console/newport_con.c b/drivers/video/console=
/newport_con.c
> index e8e4f82cd4a1..87f174a95fa8 100644
> --- a/drivers/video/console/newport_con.c
> +++ b/drivers/video/console/newport_con.c
> @@ -33,6 +33,9 @@
>
>   #define NEWPORT_LEN	0x10000
>
> +#define NEWPORT_MAX_FONT_WIDTH 8
> +#define NEWPORT_MAX_FONT_HEIGHT 16
> +
>   #define FONT_DATA ((unsigned char *)font_vga_8x16.data)
>
>   static unsigned char *font_data[MAX_NR_CONSOLES];
> @@ -328,8 +331,8 @@ static void newport_init(struct vc_data *vc, int ini=
t)
>   {
>   	int cols, rows;
>
> -	cols =3D newport_xsize / 8;
> -	rows =3D newport_ysize / 16;
> +	cols =3D newport_xsize / NEWPORT_MAX_FONT_WIDTH;
> +	rows =3D newport_ysize / NEWPORT_MAX_FONT_HEIGHT;
>   	vc->vc_can_do_color =3D 1;
>   	if (init) {
>   		vc->vc_cols =3D cols;
> @@ -507,8 +510,8 @@ static int newport_set_font(int unit, struct console=
_font *op, unsigned int vpit
>
>   	/* ladis: when I grow up, there will be a day... and more sizes will
>   	 * be supported ;-) */
> -	if ((w !=3D 8) || (h !=3D 16) || (vpitch !=3D 32)
> -	    || (op->charcount !=3D 256 && op->charcount !=3D 512))
> +	if ((w !=3D NEWPORT_MAX_FONT_WIDTH) || (h !=3D NEWPORT_MAX_FONT_HEIGHT=
) ||
> +	    (vpitch !=3D 32) || (op->charcount !=3D 256 && op->charcount !=3D =
512))
>   		return -EINVAL;
>
>   	if (!(new_data =3D kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size,
> @@ -569,6 +572,15 @@ static int newport_font_default(struct vc_data *vc,=
 struct console_font *op, cha
>   	return newport_set_def_font(vc->vc_num, op);
>   }
>
> +static int newport_font_info(struct vc_data *vc, struct console_font_in=
fo *info)
> +{
> +	info->min_width =3D info->max_width =3D NEWPORT_MAX_FONT_WIDTH;
> +	info->min_height =3D info->max_height =3D NEWPORT_MAX_FONT_HEIGHT;
> +	info->flags =3D KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SI=
ZE;
> +
> +	return 0;
> +}
> +
>   static int newport_font_set(struct vc_data *vc, struct console_font *f=
ont,
>   			    unsigned int vpitch, unsigned int flags)
>   {
> @@ -688,6 +700,7 @@ const struct consw newport_con =3D {
>   	.con_scroll	  =3D newport_scroll,
>   	.con_switch	  =3D newport_switch,
>   	.con_blank	  =3D newport_blank,
> +	.con_font_info	  =3D newport_font_info,
>   	.con_font_set	  =3D newport_font_set,
>   	.con_font_default =3D newport_font_default,
>   	.con_save_screen  =3D newport_save_screen
> diff --git a/drivers/video/console/sticon.c b/drivers/video/console/stic=
on.c
> index 992a4fa431aa..d32ca458eb77 100644
> --- a/drivers/video/console/sticon.c
> +++ b/drivers/video/console/sticon.c
> @@ -56,6 +56,11 @@
>   #define BLANK 0
>   static int vga_is_gfx;
>
> +#define STICON_MIN_FONT_WIDTH 6
> +#define STICON_MIN_FONT_HEIGHT 6
> +#define STICON_MAX_FONT_WIDTH 32
> +#define STICON_MAX_FONT_HEIGHT 32
> +
>   #define STI_DEF_FONT	sticon_sti->font
>
>   /* borrowed from fbcon.c */
> @@ -180,8 +185,10 @@ static int sticon_set_font(struct vc_data *vc, stru=
ct console_font *op,
>   	struct sti_cooked_font *cooked_font;
>   	unsigned char *data =3D op->data, *p;
>
> -	if ((w < 6) || (h < 6) || (w > 32) || (h > 32) || (vpitch !=3D 32)
> -	    || (op->charcount !=3D 256 && op->charcount !=3D 512))
> +	if (!in_range(w, STICON_MIN_FONT_WIDTH, STICON_MAX_FONT_WIDTH) ||
> +	    !in_range(h, STICON_MIN_FONT_HEIGHT, STICON_MAX_FONT_HEIGHT) ||
> +	    (vpitch !=3D 32) ||
> +	    (op->charcount !=3D 256 && op->charcount !=3D 512))
>   		return -EINVAL;
>   	pitch =3D ALIGN(w, 8) / 8;
>   	bpc =3D pitch * h;
> @@ -273,6 +280,19 @@ static int sticon_font_set(struct vc_data *vc, stru=
ct console_font *font,
>   	return sticon_set_font(vc, font, vpitch);
>   }
>
> +static int sticon_font_info(struct vc_data *vc, struct console_font_inf=
o *info)
> +{
> +	info->min_width =3D STICON_MIN_FONT_WIDTH;
> +	info->min_height =3D STICON_MIN_FONT_HEIGHT;
> +
> +	info->max_width =3D STICON_MAX_FONT_WIDTH;
> +	info->max_height =3D STICON_MAX_FONT_HEIGHT;
> +
> +	info->flags =3D KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SI=
ZE;
> +
> +	return 0;
> +}
> +
>   static void sticon_init(struct vc_data *c, int init)
>   {
>       struct sti_struct *sti =3D sticon_sti;
> @@ -371,6 +391,7 @@ static const struct consw sti_con =3D {
>   	.con_scroll		=3D sticon_scroll,
>   	.con_switch		=3D sticon_switch,
>   	.con_blank		=3D sticon_blank,
> +	.con_font_info		=3D sticon_font_info,
>   	.con_font_set		=3D sticon_font_set,
>   	.con_font_default	=3D sticon_font_default,
>   	.con_build_attr		=3D sticon_build_attr,
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgac=
on.c
> index 8ef1579fa57f..b75d31ef3353 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -61,6 +61,10 @@ static struct vgastate vgastate;
>   #define BLANK 0x0020
>
>   #define VGA_FONTWIDTH       8   /* VGA does not support fontwidths !=
=3D 8 */
> +
> +#define VGACON_MAX_FONT_WIDTH VGA_FONTWIDTH
> +#define VGACON_MAX_FONT_HEIGHT 32
> +
>   /*
>    *  Interface used by the world
>    */
> @@ -1013,6 +1017,19 @@ static int vgacon_adjust_height(struct vc_data *v=
c, unsigned fontheight)
>   	return 0;
>   }
>
> +static int vgacon_font_info(struct vc_data *vc, struct console_font_inf=
o *info)
> +{
> +	info->min_width =3D VGACON_MAX_FONT_WIDTH;
> +	info->min_height =3D 0;
> +
> +	info->max_width =3D VGACON_MAX_FONT_WIDTH;
> +	info->max_height =3D VGACON_MAX_FONT_HEIGHT;
> +
> +	info->flags =3D KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SI=
ZE;
> +
> +	return 0;
> +}
> +
>   static int vgacon_font_set(struct vc_data *c, struct console_font *fon=
t,
>   			   unsigned int vpitch, unsigned int flags)
>   {
> @@ -1022,7 +1039,8 @@ static int vgacon_font_set(struct vc_data *c, stru=
ct console_font *font,
>   	if (vga_video_type < VIDEO_TYPE_EGAM)
>   		return -EINVAL;
>
> -	if (font->width !=3D VGA_FONTWIDTH || font->height > 32 || vpitch !=3D=
 32 ||
> +	if (font->width !=3D VGACON_MAX_FONT_WIDTH ||
> +	    font->height > VGACON_MAX_FONT_HEIGHT || vpitch !=3D 32 ||
>   	    (charcount !=3D 256 && charcount !=3D 512))
>   		return -EINVAL;
>
> @@ -1177,6 +1195,7 @@ const struct consw vga_con =3D {
>   	.con_scroll =3D vgacon_scroll,
>   	.con_switch =3D vgacon_switch,
>   	.con_blank =3D vgacon_blank,
> +	.con_font_info =3D vgacon_font_info,
>   	.con_font_set =3D vgacon_font_set,
>   	.con_font_get =3D vgacon_font_get,
>   	.con_resize =3D vgacon_resize,
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core=
/fbcon.c
> index 46823c2e2ba1..e10abe416159 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -101,6 +101,9 @@ enum {
>   	FBCON_LOGO_DONTSHOW	=3D -3	/* do not show the logo */
>   };
>
> +#define FBCON_MAX_FONT_WIDTH 32
> +#define FBCON_MAX_FONT_HEIGHT 32
> +
>   static struct fbcon_display fb_display[MAX_NR_CONSOLES];
>
>   static struct fb_info *fbcon_registered_fb[FB_MAX];
> @@ -2456,6 +2459,21 @@ static int fbcon_do_set_font(struct vc_data *vc, =
int w, int h, int charcount,
>   	return ret;
>   }
>
> +
> +static int fbcon_font_info(struct vc_data *vc, struct console_font_info=
 *info)
> +{
> +	info->min_width =3D 0;
> +	info->min_height =3D 0;
> +
> +	info->max_width =3D FBCON_MAX_FONT_WIDTH;
> +	info->max_height =3D FBCON_MAX_FONT_HEIGHT;
> +
> +	info->flags =3D KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SI=
ZE;
> +
> +	return 0;
> +}
> +
> +
>   /*
>    *  User asked to set font; we are guaranteed that charcount does not =
exceed 512
>    *  but lets not assume that, since charcount of 512 is small for unic=
ode support.
> @@ -2483,7 +2501,8 @@ static int fbcon_set_font(struct vc_data *vc, stru=
ct console_font *font,
>   	    h > FBCON_SWAP(info->var.rotate, info->var.yres, info->var.xres))
>   		return -EINVAL;
>
> -	if (font->width > 32 || font->height > 32)
> +	if (font->width > FBCON_MAX_FONT_WIDTH ||
> +	    font->height > FBCON_MAX_FONT_HEIGHT)
>   		return -EINVAL;
>
>   	/* Make sure drawing engine can handle the font */
> @@ -3158,6 +3177,7 @@ static const struct consw fb_con =3D {
>   	.con_scroll 		=3D fbcon_scroll,
>   	.con_switch 		=3D fbcon_switch,
>   	.con_blank 		=3D fbcon_blank,
> +	.con_font_info 		=3D fbcon_font_info,
>   	.con_font_set 		=3D fbcon_set_font,
>   	.con_font_get 		=3D fbcon_get_font,
>   	.con_font_default	=3D fbcon_set_def_font,


