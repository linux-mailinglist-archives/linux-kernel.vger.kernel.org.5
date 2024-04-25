Return-Path: <linux-kernel+bounces-158398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA848B1F44
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705091C20E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F379E1DFD2;
	Thu, 25 Apr 2024 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="qVwvEwNk"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE501CFA0;
	Thu, 25 Apr 2024 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041220; cv=none; b=Ff7Rc/sv0nvXRmPI85fW/eeF7SfC/nUecCdJdSzogHfzIymiqDzdV02Ig5aIhxTpiGO3kAlUKtJMmgbPAqzzcVcl7hucfLybNyabmRGmy13bb0paZUyE/Z+HdBgPIn9x/2ak+bKtV9w0lkVgWI7WcHGu9QIN78g2zSohMIDbKhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041220; c=relaxed/simple;
	bh=k9lwRoRUvzlqoz5fwQzOOXNGJR3OjPhHvUezKJw2Ov4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtbgmxnNvyC2Vsa2BsKEw1mLG+6d8milnqEzugv1z8JAZOo25TO3tVKv356+9hvO0xhZg8Wm6p+m0EPXn4GTgwSvGGnxpmpIxQFQGBtVOxXenfk6bVS0WcUnaZV0FdYnlWVE9/76By0UZW50yfvyxIarfwku4rq1L5HVtjyL1YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=qVwvEwNk; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714041210; x=1714646010; i=deller@gmx.de;
	bh=DnQrdoB/COKjUydxVL4EICP2m/O5cwQeNi5jQNG1kyo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qVwvEwNkelYyIDERb5bx4mXjUTcjbUxGb/VrS6Ou9rnt4IvFUAPKfxMoL8HsTFeH
	 y+55xss7l4wOJseAD9wDqNw9reFf+NpJHd/YeefMy+Y7CJ9YDvpcMmXH997pAd64a
	 0K2JOsouV59/QmZtoYhiPGfiT+jwHVBgbVTsWbliGeaobpyxRWjGnB5HJcogUm3HO
	 UKGGzR0Dgqh/I5h1Ub+vxmGy9v7e7qFyFiF3VaZgxwsZwMyNemx35N0cHSPdK8tfU
	 wt6BRby9+lsnsg/65cuZe6DJwLSosYKFLeIEfOf2pMop3K7N3juQ8+WwRVHNqKQDN
	 Ko/6Z9SPZ3D1hnCJNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hZJ-1s4b750ooj-006R8N; Thu, 25
 Apr 2024 12:33:30 +0200
Message-ID: <9993ad2d-48a8-43be-ae41-4b8d710c1ea7@gmx.de>
Date: Thu, 25 Apr 2024 12:33:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] VT: Add KDFONTINFO ioctl
To: Alexey Gladkov <legion@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 kbd@lists.linux.dev, linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <cover.1712080158.git.legion@kernel.org>
 <cover.1713375378.git.legion@kernel.org>
 <bd2755e7b6ebe9b49e82d04d9908a176e0fe2f15.1713375378.git.legion@kernel.org>
 <9019dc74-35ad-43d7-8763-cea3da93e9c1@gmx.de> <ZiD50WZZv3OOad7L@example.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ZiD50WZZv3OOad7L@example.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fOyXlsniexNLwuogny4huBYhXIcRVc/ImtJjQa4EtckVox0DKZv
 JG1j8F8qlUI5nVjEziWDlidnXu5MR6w0HLMojU1Ud6Rm1nlQV1a6a8q59wwaTbzbwcsO3u+
 bkmEIjh9eZPKBbhQQNxk+qVHk3dcRKDLWPw7HBNmYggWFFmmjBN6E0mj/znfIYsHCNapLCu
 hUnvtikBymQw7QG8LtDjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oSQasQPzzW0=;TF6gLtDjYAVjAlX0so2dJrvRzYO
 jAw35nmibMv/Ar1d1TOr5DLdDOGPVJSUEkn85LrrZQjKl27cXCGFOoXpGhIfknQ0C+L5HgW/9
 B8qvhj6EeZS5ysUr+3tumQFyD3PmYWoxJwi/bPmRvl1QHKFVgUnmh0zI9eiVrLRlIJEpvXEDW
 /vHMSm/QdFZoSPFA//PtInu9Q4zsia7Aqh+yTzIX679aSPhbYUzPKisO+Fa9E39HRwR7K1J+f
 A4ED2t5oL3K2LxSYaIB3NCUHtIO4mP+IM3c3sx1I6qSzp9eoa93Y0fZHI8vvZjlw4ZV8QTmQn
 9o4tsOVJ6hULNHXYluShkOyzi+HmveCqcfTtpRa6/i7LfjRgmOajNWqQm9FMW54DwO9CGKuH9
 SEvEPl7+/+BAeI2zxQEsG4iLnkCPB7b3MtiWcMbi24Zf8wTIbnWUafW0uUh1G4pz6SVRPfhJ4
 mhCOGjEpMUtI6BqTGNZKNtEjuIopfFvRoOoDAhqD2Ss2PZhVJKeFKeCG0k9LwAlah/1FdT20l
 8pOXqkZPtQNOXkAckvKN+oVNAmMMotq4gAMy4GnKrUMb5akvfDxe/2Y8JyCOaAHTU1CtOcuhm
 f3+pea60tQBQhX4wLQquP4P131BU2LEWRDnHaqed3QKp0B9s94AimLOThRXzKKodK4TPstZKL
 BqOIXu60kywxfYdldD9skG1Xqgc9pUfIr3dlGWL5oCAkzeHYxBLL6QGhU53PUB6iPj0I0NEV1
 W+fVhhmI7z2NgTSFhE2myupI4YXucX5SONBPfyyRCX6xLIESft7BOKmTqmvcFETFJ+574Gni+
 DVY8bn/hzvXhoiuAnMn4uv31oI/R7qvrUQ0nPZJrqcssY=

On 4/18/24 12:45, Alexey Gladkov wrote:
> On Wed, Apr 17, 2024 at 09:31:53PM +0200, Helge Deller wrote:
>> On 4/17/24 19:37, Alexey Gladkov wrote:
>>> Each driver has its own restrictions on font size. There is currently =
no
>>> way to understand what the requirements are. The new ioctl allows
>>> userspace to get the minimum and maximum font size values.
>>>
>>> Acked-by: Helge Deller <deller@gmx.de>
>>> Signed-off-by: Alexey Gladkov <legion@kernel.org>
>>> ---
>>>    drivers/tty/vt/vt.c       | 24 ++++++++++++++++++++++++
>>>    drivers/tty/vt/vt_ioctl.c | 13 +++++++++++++
>>>    include/linux/console.h   |  3 +++
>>>    include/linux/vt_kern.h   |  1 +
>>>    include/uapi/linux/kd.h   | 14 ++++++++++++++
>>>    5 files changed, 55 insertions(+)
>>>
>>> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
>>> index 9b5b98dfc8b4..e8db0e9ea674 100644
>>> --- a/drivers/tty/vt/vt.c
>>> +++ b/drivers/tty/vt/vt.c
>>> @@ -4851,6 +4851,30 @@ int con_font_op(struct vc_data *vc, struct cons=
ole_font_op *op)
>>>    	return -ENOSYS;
>>>    }
>>>
>>> +int con_font_info(struct vc_data *vc, struct console_font_info *info)
>>> +{
>>> +	int rc;
>>> +
>>> +	info->min_height =3D 0;
>>> +	info->max_height =3D max_font_height;
>>> +
>>> +	info->min_width =3D 0;
>>> +	info->max_width =3D max_font_width;
>>> +
>>> +	info->flags =3D KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_=
SIZE;
>>> +
>>> +	console_lock();
>>> +	if (vc->vc_mode !=3D KD_TEXT)
>>> +		rc =3D -EINVAL;
>>> +	else if (vc->vc_sw->con_font_info)
>>> +		rc =3D vc->vc_sw->con_font_info(vc, info);
>>> +	else
>>> +		rc =3D -ENOSYS;
>>> +	console_unlock();
>>> +
>>> +	return rc;
>>> +}
>>> +
>>>    /*
>>>     *	Interface exported to selection and vcs.
>>>     */
>>> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
>>> index 4b91072f3a4e..9a2f8081f650 100644
>>> --- a/drivers/tty/vt/vt_ioctl.c
>>> +++ b/drivers/tty/vt/vt_ioctl.c
>>> @@ -479,6 +479,19 @@ static int vt_k_ioctl(struct tty_struct *tty, uns=
igned int cmd,
>>>    		break;
>>>    	}
>>>
>>> +	case KDFONTINFO: {
>>> +		struct console_font_info fnt_info;
>>> +
>>> +		memset(&fnt_info, 0, sizeof(fnt_info));
>>> +
>>> +		ret =3D con_font_info(vc, &fnt_info);
>>> +		if (ret)
>>> +			return ret;
>>> +		if (copy_to_user(up, &fnt_info, sizeof(fnt_info)))
>>> +			return -EFAULT;
>>> +		break;
>>> +	}
>>> +
>>>    	default:
>>>    		return -ENOIOCTLCMD;
>>>    	}
>>> diff --git a/include/linux/console.h b/include/linux/console.h
>>> index 31a8f5b85f5d..4b798322aa01 100644
>>> --- a/include/linux/console.h
>>> +++ b/include/linux/console.h
>>> @@ -21,6 +21,7 @@
>>>    #include <linux/vesa.h>
>>>
>>>    struct vc_data;
>>> +struct console_font_info;
>>>    struct console_font_op;
>>>    struct console_font;
>>>    struct module;
>>> @@ -102,6 +103,8 @@ struct consw {
>>>    	bool	(*con_switch)(struct vc_data *vc);
>>>    	bool	(*con_blank)(struct vc_data *vc, enum vesa_blank_mode blank,
>>>    			     bool mode_switch);
>>> +	int	(*con_font_info)(struct vc_data *vc,
>>> +				 struct console_font_info *info);
>>>    	int	(*con_font_set)(struct vc_data *vc,
>>>    				const struct console_font *font,
>>>    				unsigned int vpitch, unsigned int flags);
>>> diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
>>> index d008c3d0a9bb..383b3a4f6113 100644
>>> --- a/include/linux/vt_kern.h
>>> +++ b/include/linux/vt_kern.h
>>> @@ -33,6 +33,7 @@ void do_blank_screen(int entering_gfx);
>>>    void do_unblank_screen(int leaving_gfx);
>>>    void poke_blanked_console(void);
>>>    int con_font_op(struct vc_data *vc, struct console_font_op *op);
>>> +int con_font_info(struct vc_data *vc, struct console_font_info *info)=
;
>>>    int con_set_cmap(unsigned char __user *cmap);
>>>    int con_get_cmap(unsigned char __user *cmap);
>>>    void scrollback(struct vc_data *vc);
>>> diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
>>> index 8ddb2219a84b..68b715ad4d5c 100644
>>> --- a/include/uapi/linux/kd.h
>>> +++ b/include/uapi/linux/kd.h
>>> @@ -185,6 +185,20 @@ struct console_font {
>>>
>>>    #define KD_FONT_FLAG_DONT_RECALC 	1	/* Don't recalculate hw charcel=
l size [compat] */
>>>
>>> +/* font information */
>>> +
>>> +#define KD_FONT_INFO_FLAG_LOW_SIZE	_BITUL(0) /* 256 */
>>> +#define KD_FONT_INFO_FLAG_HIGH_SIZE	_BITUL(1) /* 512 */
>>
>> Do we really need those bits?
>> You set a default min/max font size in con_font_info() above,
>> and all drivers can override those values.
>> So, there are always min/max sizes available.
>
> These bits are not about the minimum and maximum glyph size, but about t=
he
> number of glyphs in the font.
>
> Maybe this is an overkill, but sticon has this check:
>
> if ((w < 6) || (h < 6) || (w > 32) || (h > 32) || (vpitch !=3D 32)
>      || (op->charcount !=3D 256 && op->charcount !=3D 512))
>
> [ to be honest, I don=E2=80=99t know why this driver doesn=E2=80=99t acc=
ept a glyph of
> width 4 ]

I think there was no technical limitation when I added that.
It's just that the font would be so small...

> I thought it would be worth fixing the maximum number of requirements in
> the drivers since I started adding a new ioctl.

Ok.

Helge

