Return-Path: <linux-kernel+bounces-49605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2094F846CD2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452DB1C2A1CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6253577F05;
	Fri,  2 Feb 2024 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SzgNX3uT"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDDB60273
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866851; cv=none; b=bTUIKgATE8xNemFBejea0o92AqUlHIgnTEZoP3JWHoQRGo9GVKxSOl73hdPCvYmWbLVp/+4YDl/H1ie3J2XYMsktPuDoMigXzj3HQXbj86+Z3HVektV/H5q+oS4CIKFR4xmdfFqj0o2S6ZtY7Q7TdK3LSoDuHnvkjcP5afR7IQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866851; c=relaxed/simple;
	bh=ky8m3+NULdYpbDNNAVvwPKA9GBPMytd+qTwefaAXxn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZjuQyzPUnCwZf2VHw+xZeQrV7HfduxDAvBhRtjJwgaoeKWvgdQXQTHCDpeF0XQXiA35xCF06Ou/fWBKBoBcZz7ar9T0lsoiIYYfSCIqA2nxKPKadB1XJE7v/qUslxRxioDDY2xQoxRugcrYQTA61dX56QZpzx476TiBmGQ6M7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SzgNX3uT; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B65Ve0OU568B4D9kTmLoLRABlAGY2QMty8zi+Hdb1kc=; b=SzgNX3uTzQNPML6JnVjMzw6Nh3
	IN248C9GVhR+1lCzV8SNpWn57Ga00zhK+3za52pqLgyXkCvn+4Mhf9f3LmdDFWucwqTqiEBIxxcU6
	PUrPX7V4cLEzlvdvw+ucGFIOKt+7oenZ6DCdkSj9EcoLKdqXkkia5OTeqKawA76u2KObk+Vbl661O
	gB1CCZZYhL2W6L6K5FwlGjpnZwKpI1JQOCMh2J5mOF7BHvUkiOPvo2zuGMTiE/MPB0GyUWNCOWCi7
	gzaS7NJ7LSpU1pX7Q00ciPdhH1lcbbVHN+Tl1pQjahZzZ6LE2VP7l8p56+pR4NVm6ZsZqdGKfBLRn
	/ysbZ7zg==;
Received: from [179.234.233.159] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rVq2A-00Cu6p-0x; Fri, 02 Feb 2024 10:40:30 +0100
Message-ID: <a9ca3232-5495-4a1e-a057-a5849ee166a4@igalia.com>
Date: Fri, 2 Feb 2024 06:40:22 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Better support for complex pixel formats
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, marcheu@google.com, seanpaul@google.com,
 nicolejadeyee@google.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com
References: <20240201-yuv-v1-0-3ca376f27632@bootlin.com>
 <d7959499-c0cf-4454-b9f9-8436d8818095@igalia.com>
 <Zbyki1szIFvotn71@localhost.localdomain>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <Zbyki1szIFvotn71@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/2/24 05:15, Louis Chauvet wrote:
> Le 01/02/24 - 19:07, Maira Canal a écrit :
>> Hi Louis,
>>
>> Thanks for your patches! Could you please rebase them on top of
>> drm-misc-next? It would make it easier for me to review and test the
>> patches.
>>
>> Best Regards,
>> - Maíra
> 
> Hi Maíra,
> 
> Do you want me to rebase the whole YUV [1] series or should I extract and
> make my two patches independent?

Please, make this two patches independent.

Best Regards,
- Maíra

> 
> [1]: https://lore.kernel.org/dri-devel/20240110-vkms-yuv-v2-0-952fcaa5a193@riseup.net/
> 
> Best regards,
> Louis Chauvet
>   
>> On 2/1/24 14:31, Louis Chauvet wrote:
>>> This patchset aims to solve issues I found in [1], and at the same time
>>> simplify the composition algorithm.
>>>
>>> I sent more igt-gpu-tools test [2] to cover more things and detect the
>>> issues in [1].
>>>
>>> This patchset is based on [1].
>>>
>>> Patch 1/2: This patch is a no-op, but make the code more readable
>>> regarding the pixel_read functions.
>>>
>>> Patch 2/2: This patch is more complex. My main target was to solve issues
>>> I found in [1], but as it was very complex to do it "in place", I choose
>>> to rework the composition function.
>>> The main two advantages are:
>>> - It's now possible to create conversion function for packed & grouped
>>> pixels. Some pixel formats need absolute x/y position and not only an
>>> offset in the buffer to extract the correct value. This part also solve
>>> the issues I found in [1].
>>> - The rotation management is now way easier to understand, there is no
>>> more switch case in different places and instead of copy/pasting rotation
>>> formula I used drm_rect_* helpers.
>>>
>>> [1]: https://lore.kernel.org/dri-devel/20240110-vkms-yuv-v2-0-952fcaa5a193@riseup.net/
>>> [2]: https://lore.kernel.org/igt-dev/20240201-kms_tests-v1-0-bc34c5d28b3f@bootlin.com/T/#t
>>>
>>> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
>>> ---
>>> Louis Chauvet (2):
>>>         drm/vkms: Create a type to check a function pointer validity
>>>         drm/vkms: Use a simpler composition function
>>>
>>>    drivers/gpu/drm/vkms/vkms_composer.c |  97 ++++++++-----
>>>    drivers/gpu/drm/vkms/vkms_drv.h      |  32 ++++-
>>>    drivers/gpu/drm/vkms/vkms_formats.c  | 254 ++++++++++++++++++-----------------
>>>    drivers/gpu/drm/vkms/vkms_formats.h  |   2 +-
>>>    drivers/gpu/drm/vkms/vkms_plane.c    |  13 +-
>>>    5 files changed, 236 insertions(+), 162 deletions(-)
>>> ---
>>> base-commit: 5d189d57bb335a87ec38ea26fe43a5f3ed31ced7
>>> change-id: 20240201-yuv-1337d90d9576
>>>
>>> Best regards,

