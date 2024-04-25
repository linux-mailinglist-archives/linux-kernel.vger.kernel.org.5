Return-Path: <linux-kernel+bounces-158452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF1A8B2057
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856072826DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AD812AADD;
	Thu, 25 Apr 2024 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="YVR/bz//"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBBF84DEE;
	Thu, 25 Apr 2024 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044954; cv=none; b=qK9Cej8KpRIwOhtnSZNP8W5DHWNoKK9YqokTJ5E9pN5wXFFdxmAgyl2OzDzD1JzPoYcYFj9/28VaAIq0q3FURv7Kq9/xxCdeBu5DaLo14LUazZONyJzy0EPBycurJX6jRK6bbEgj5W7Xv4dB01FpSGBOPplEekCsOgX9fM2Uy3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044954; c=relaxed/simple;
	bh=62rGSpnWaxxUaRbRg+LNUd0Vy12ZjbRKCfLvcC0SDdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zc3E3jQ3XNKtIvewlnO0Dm2a7JrOiv+LYGLflAqpKhNdg1gKLlKBeN71rQSKw56tCnL07jpqXULMqB4q6Ywu6y7GtyWDeRwJCTuatNJ9hZFdMBM8UioMmCm40/HX4Q2+AomyffwXpYOv2vQGSr2cwlPN1YE6IheJRwLCMdUJHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=YVR/bz//; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714044942; x=1714649742; i=deller@gmx.de;
	bh=Wd75oAOWRnH4MgUUY1TJVV9iqximUQMOF5SkISYOC+Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YVR/bz//9KPFntYUdJremhvXdpR2DQpePQxqpKNQkbE9MZAxUKkcGbwymChfBT19
	 zNGSnDVtgaLThv4rgSXNc+07q/IFoD3JnCYb4IFoex7EJLsZLJRBhxTFklSP4U+RS
	 +XYERZOOa5whhyS3YBMBVETJGVboy7m+R+Lqjt4PAJVAbOE19Jb7Aki2OyZP4Ssyu
	 RAwqvxhnqsng6X3/zf9Nhv+TBtpKr8Zi5SuByv+FuQwQUuposD6oB97z491uX17Yj
	 GqmXmtwVSRr8IrksRPS3AFCsprRXxvaSuN9IPLEPFIGejid9j2KaPcJ1jBTEKyasg
	 wFtHsrI59/yNXxsVYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdebB-1sZZK32rFR-00ZfO1; Thu, 25
 Apr 2024 13:35:42 +0200
Message-ID: <f3e4e710-a392-4924-94c1-6dd52c803f9a@gmx.de>
Date: Thu, 25 Apr 2024 13:35:41 +0200
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
 <9993ad2d-48a8-43be-ae41-4b8d710c1ea7@gmx.de> <Zio5JfRBvzxuVUbX@example.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <Zio5JfRBvzxuVUbX@example.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qG0SgbS54dSqSDLb/4RqUArtcDUwbeC5rZ406sdxMI1Hr3XO42/
 BzusuIvXIZbIKT/Jzz3vWxcAwDZIA//T1d2C6bCGDkqkkKv3nMd2yQWy6K+zE+Q/ifyGnPK
 rka5hfHK0W/Bz2FjGF9yAARKlrxm/oUiEBddRR0XEc1M5o9tXvqKzoDoW+J+ExFm7T5ynS0
 N2EmJEv880IYvkgdN1pvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HY9J8ff6syI=;IqxmUssLChGH6UiPde+YNC40L99
 cN2erDiCmy11HUyqa9cEOfWtlGVwCfxPFnokA72A+tNP4it8uJX71/vdNwypLpjm7GS6etrVp
 sv69ExfSvkOw4q/xSyor9G2V1m+iRnlm0EF1HaOXIYdZzajW57caJClasjNDvFWpgtBe98kYO
 rAyEwLins6ep4Pi4RuR0FHIsaI/R3UhSUYw2vyk6342S2c+0ecO1JCxZVEvUiqlf/OuQSNZbg
 3aVVOdyc4T5uF0GHwkd1Huq+2AacHbFlGvEocop4ZaVee6iBfEdGUDw/pxK3l0kvdyNF9oF5B
 fdm46+RWXQ3OllePSnLxu1IU3DZS/OmP1AYggsGXitcSnqVFQzzuqb/nHJwoz++kGCmJx2WVV
 i574CQD1zzaJHjl3I9mn/jQFjo1gFIpuy8//lBUPZzWVyB7rYGUIvCElrzZxVHWmOqN8wWmnx
 tzl3zeknR9V13KaB5O9py+R1MFWXNcmNkdqpDQeH4dWZuwdZpgmJemIm8zDD0UjPWEVWVMPYx
 pyGKDauVnRwRGl4fO9qM/FMLrqvtf54nZqLqXPiJxB/O0CHXEM6CviEm7AHAzLgbIpcpujPLw
 uYH/NccNV9Hb9iS6g8LotqIj2F+otXLTyL5hesPD4OC2AyWrJDRUosrpLfi2m8TJn4UGJ78Ky
 lMOk0p7viFXRQnKf/sg0sswCCgowkeumPBYYyq4uN+UmrDAMgeq5RPnAb42BwhkgzGpvcWy1f
 +Adj1UVaFc4JCK9IX4OuTWOQu+rpqtTdY3QO3TtobJItrXXlJ6+3uDeTqlME7TqLtPHQUur7e
 YqJNpicFrLid1PXb6qjteO0PkXybFRYNiHY+/SgafAIZ0=

On 4/25/24 13:06, Alexey Gladkov wrote:
> On Thu, Apr 25, 2024 at 12:33:28PM +0200, Helge Deller wrote:
>>>>> diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
>>>>> index 8ddb2219a84b..68b715ad4d5c 100644
>>>>> --- a/include/uapi/linux/kd.h
>>>>> +++ b/include/uapi/linux/kd.h
>>>>> @@ -185,6 +185,20 @@ struct console_font {
>>>>>
>>>>>     #define KD_FONT_FLAG_DONT_RECALC 	1	/* Don't recalculate hw char=
cell size [compat] */
>>>>>
>>>>> +/* font information */
>>>>> +
>>>>> +#define KD_FONT_INFO_FLAG_LOW_SIZE	_BITUL(0) /* 256 */
>>>>> +#define KD_FONT_INFO_FLAG_HIGH_SIZE	_BITUL(1) /* 512 */
>>>>
>>>> Do we really need those bits?
>>>> You set a default min/max font size in con_font_info() above,
>>>> and all drivers can override those values.
>>>> So, there are always min/max sizes available.
>>>
>>> These bits are not about the minimum and maximum glyph size, but about=
 the
>>> number of glyphs in the font.
>>>
>>> Maybe this is an overkill, but sticon has this check:
>>>
>>> if ((w < 6) || (h < 6) || (w > 32) || (h > 32) || (vpitch !=3D 32)
>>>       || (op->charcount !=3D 256 && op->charcount !=3D 512))
>>>
>>> [ to be honest, I don=E2=80=99t know why this driver doesn=E2=80=99t a=
ccept a glyph of
>>> width 4 ]
>>
>> I think there was no technical limitation when I added that.
>> It's just that the font would be so small...
>
> If so, then I can remove min_height/min_width from the ioctl structure.
> And most likely the flags can also be left empty since at the moment all
> drivers support 512.

Yes, I think that's ok.

Helge


