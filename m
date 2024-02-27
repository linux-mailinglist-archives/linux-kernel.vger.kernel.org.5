Return-Path: <linux-kernel+bounces-84139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F3786A2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAC51F23CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856EA55C1D;
	Tue, 27 Feb 2024 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="r3ZhuY/6"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B61D556;
	Tue, 27 Feb 2024 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073979; cv=none; b=D4vHwJzT/O5LKkVL/K2vfih3OQUYZjpXzqsbzTddeMlcuaUEZPZJd4xP7epZHfiWzUsQ2CZvdv/PJbYpJg68cExYaVFBzvE3obk6TJbKouq3dPppm9w5k6dn4utYQPV81+Xv2DWJKyNsnyodeTOtetiO+SQTqk7L9EfUNvBx6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073979; c=relaxed/simple;
	bh=jMOvdp+7Kb57vAU/pajmYjMpp+leXZBO/O/x1MAJUTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFEvu8hQtDxMHNSCokRHHtTTsNgEEGtzeBF64slGIYffYjIzpRw/Bp2TMeaOwFdeJxeFY9zvqAiMipIJQxEpRQn93xAV4m7R645SRH+VdnVn8fTUEoiYlvoJ3S4SVSwTMaAjEwgDGeN8F1nqSWoqJn8lpwft82CggMCOF6RSGVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=r3ZhuY/6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GELtHCqztILJCJyymU5pQS8T2fsqGAS/e9ITGcryoD0=; b=r3ZhuY/60lM3m4cl4kp3YR5KnM
	9SZzwe5SgNk/Q+6Dk7Co7U+crfx6xjdJtiGcrL/TX7PT5dsXKclYLe510taXv65W948NJ5aY1huiK
	WGiWYgy2E58C/SXgKZhVkRl0WOKDE/d+amjDiu7KxYCvQkSgzTPhTtaZjgv5kPSZKrLIuEkCx81+A
	uUbVKxB6G53JrleM1wHNuSABctLyDW2j0sVdTSv3bM54vtfth/9HhYHapbt63t9/UXZHXpUFFyFMi
	cnpirBCn74tDUSmH/9eXXlUAMb94x0a5DKwBlRCx+TpXEQVDF/spXq+ZYARRCs4GFtwx8QK4b+fcS
	8n5dD4ow==;
Received: from [200.173.162.98] (helo=[192.168.52.5])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rf6CE-0044Ea-FM; Tue, 27 Feb 2024 23:45:10 +0100
Message-ID: <2693770c-0d27-4186-87e1-e55a0a5f17a5@igalia.com>
Date: Tue, 27 Feb 2024 19:45:01 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 29/36] drm/vc4: tests: Remove vc4_dummy_plane structure
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
 <20240222-kms-hdmi-connector-state-v7-29-8f4af575fce2@kernel.org>
 <244fe6b9-f295-4c85-908a-014ada0033fa@igalia.com>
 <y7mxj2i56h7bcnonywjdf2eirdqil66k32drw3wb3z7juqr3ph@4u24mlrvxslc>
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
In-Reply-To: <y7mxj2i56h7bcnonywjdf2eirdqil66k32drw3wb3z7juqr3ph@4u24mlrvxslc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Maxime,

On 2/27/24 10:02, Maxime Ripard wrote:
> Hi Maíra,
> 
> Thanks for you reviews!
> 
> On Mon, Feb 26, 2024 at 09:29:32AM -0300, Maíra Canal wrote:
>> On 2/22/24 15:14, Maxime Ripard wrote:
>>> The vc4_dummy_plane structure is an exact equivalent to vc4_plane, so we
>>
>> Maybe I understood incorrectly, but isn't the vc4_dummy_plane structure
>> equivalent to drm_plane?
> 
> Both statements are true :)
> 
> vc4 itself uses vc4_plane to holds its plane-related content, but it
> turns out that there's nothing in that structure anymore and vc4_plane
> == drm_plane.
> 
> In our mock driver, we have another structure meant to store the
> mock-plane-related content which doesn't have anything in it anymore,
> and is thus equivalent to vc4_plane.
> 
> So, basically, vc4_dummy_plane == vc4_plane == drm_plane.
> 
> This patch is only about getting rid of vc4_dummy_plane though.
> 
> Is it clearer?
> 

Yeah, with that pointed out, you can add my:

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> Maxime

