Return-Path: <linux-kernel+bounces-153645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBDA8AD114
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD711C224BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7F1153594;
	Mon, 22 Apr 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uYqDgZv8"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE35153572;
	Mon, 22 Apr 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800351; cv=none; b=K3nY0g6VAFtid8R12sUKdLVDlcBAOXOoN3k/JGWCB0eFKCbGtNYBQ5Vo0SUqCI+W0mVjwu7QTlGcQtGfWYsbGpjc4uoS0hGpTFhczvpMqrQKoqcGUiK/9UR4C1EISrILKp/5uD9x3Ca+/NpuezQVV6kGd3kx7kG+R0e4UEzUCzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800351; c=relaxed/simple;
	bh=10FfD4ZHzSFQEH8sQUELtpgULLzge1X9Q8xRaKqG1Ik=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=P0pFvqAdhaDlelC0x22kKU2lo1qcvGO0BBuRE5D5jQ1YX3WtVRCuhe2o1woOCtJLt8v3nKax/V80Ou73Oq9K1qIKEKFrp6IcgGqc1J27NlqO3gO0BW3HAq40C5NJBIlGfyk/1aCKP9xZoP66MCh1ZC7b01cFJFaGYGdqhwOyps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uYqDgZv8; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713800333; x=1714405133; i=markus.elfring@web.de;
	bh=PvxrtFdGZmRXnr/yFq+g2FFB8EV93GFvYY78jv7kXYQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uYqDgZv8KFXEZOk27ftPEcnks5OVY+wyu+FtwLjpnJB7ovOhSoX9o6TnB+of5UUx
	 6P7/48RH0fqRy4GbZs1UlzbbbK5G7sXp1mMAbmlrMP4nANpHNL6pQtMaG6xb3sxqE
	 lig6k0TV/sJS3SGWYOAJR4Di9Zg1tiXeF2lmBagBM2yB3BlkjRZIRB6QY+ZiOIF4i
	 xtllarxKTdx77l+/sMFPm6Tmu35o8eVjr3PE//RG0A9il8Zr3lBa5ajYzqNh7exkK
	 xKWaTfTY/C0Q9IKk04FIOoDjh0HoqqKh4Bc4n47HTBomWGpeNOYVFNL+Hz695sTwr
	 2AnxM2aOHY+VRLf+Vw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MumNL-1spO180rnH-00tQ77; Mon, 22
 Apr 2024 17:38:53 +0200
Message-ID: <964c9987-ea86-4167-899d-3bd3442ebfdb@web.de>
Date: Mon, 22 Apr 2024 17:38:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jose Fernandez <josef@netflix.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Alan Liu <haoping.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, George Shen <george.shen@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Ilya Bakoulin <ilya.bakoulin@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Leo Ma <hanghong.ma@amd.com>, Nasir Osman <nasir.osman@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240410043433.12854-1-josef@netflix.com>
Subject: Re: [PATCH] drm/amd/display: Fix division by zero in setup_dsc_config
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240410043433.12854-1-josef@netflix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ImWj6NNFf54sdIU5jTB8RmmUgnJSM4ABxpBdpnbmrgQZxjocuvw
 xKz8NFS87E2HoZuS5ACRStYdZEpf3LwT7Ayfbgi511rH7Jqm1wmew0+1L2n6Ryy8tnv3mgh
 9OgnL+aZNfBvVRhTOuVYL4kuPl8JiHNVjHBwfbsO4u2o0NOuns/wGgkqKmxeYhxxjIILqVa
 XIBI1QPzz+XcsrdIu//bw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xFRexao3ArU=;5HQx+6cRQUkVuVF3ZgAFuJexcw8
 xt19fkO9itbevDWaxVlDInmziCgR00uiPUPVziaSor3KwtbRGg2J73bFlvlXJIqcHQh0v3YVK
 H30Ny9zBA3Ifc9LFVZ8KQZWJnL+agr3/spWHA5EUZ4DmQp8kd2+3NHWg5j3RWdTPI4O8GkMTD
 d4DdpO0C5vDlqHNUl4fQQxVG0mcSxU5vdKvzfnro+oWr8O8xSSgMq078KUWsy1QACwNJtMFR6
 QGdbbn3lOoaefXaE5TazGIqCURhu3ISLHM6CGpvjloCGdLc6vFYjpyRXnc1mFNmp6JEhEfj0K
 CE44hN3bMl5yjsCoCfcX7gjqv+KVIBBbQtzwXx5vLSKVuWe1AQbUDy2HmOq3TewvdqN/TcenH
 7ex3tulwgahTgk+8I6o2nr4UPfpdXAROeajEVcsODZWz4Sq51spMZ3KkfYlB7ld3gGhHhmdMm
 OgCWlfbKVH349NzeDa+OXxeEyQNc0b3h29SwKXFKzq5eZiSXJwI/stQZFcKRcLXHaJ2PVswHB
 0Ylh8L3bLQ50AbLNNjtas62bLe50k+neX38hlDyXID1q8tCVbCLhiKRSRc60bqW4T7bulyXVT
 LJ3+FD7i3nWV91K3nYr3zvphcr0Jd4vYjCbMG7Up3KWP2Qh81EDiCpf1bA3PNs42xhN7dAtYh
 FbriIOpdgvCL8aiO6lXnFbDnO/kKz043WSXgSTyy0wEaKwiqLcM8GDUa08TJnzZHBnH5LdH6g
 Sn7rJ3iOIe/31FfJk7KSeMZTWp2xswKO4u15yo6A8oy33RxTvaJ5uiYoh7OCEP+YsgRT5f10U
 Za7/Mqa8MiFVJBIsuUZN2ZUCf0Kl7see7XjK83huxQk7E=

=E2=80=A6
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> @@ -1055,7 +1055,12 @@ static bool setup_dsc_config(
>  	if (!is_dsc_possible)
>  		goto done;
>
> -	dsc_cfg->num_slices_v =3D pic_height/slice_height;
> +	if (slice_height > 0)
> +		dsc_cfg->num_slices_v =3D pic_height/slice_height;
> +	else {
> +		is_dsc_possible =3D false;
> +		goto done;
> +	}
>
>  	if (target_bandwidth_kbps > 0) {
>  		is_dsc_possible =3D decide_dsc_target_bpp_x16(

I suggest to take another coding style concern into account.
Please use curly brackets for both if branches.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.9-rc5#n213

Regards,
Markus

