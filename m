Return-Path: <linux-kernel+bounces-161795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD188B5161
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6FF1F220CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BE3111A3;
	Mon, 29 Apr 2024 06:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ADyRSW2j"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC33134A6;
	Mon, 29 Apr 2024 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371907; cv=none; b=MJFXZbnHZvrbSLIRLb1B0i3YHANE4BEAZk6rXWTHuDAPMK+HFl4b5vF5kBE7N07MEdHQny5Q5EH5C7oJN6BCK5IoEuQGWh64x/Dh1RIVnVLCmx2f83tPJ9xFZlSfGYcKK8MTVohdmLMSItVRpjg6kx9Tnxc9x1vxwHNlLQxXMb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371907; c=relaxed/simple;
	bh=Vk3HT11dsQJBG0qes20Skl5rvhJPwT7CLw5IwZVPPIo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DJDdNNX57yiNAA5FxsCFUMMIaERiYmk6v47f2X297eIyzdHvRWk02tMaHw7TQMHDVIGFiuPKT+an9cUxR/vooZeXyAUrwzXsAkZWmVwUQe/NIUh8YUV/jZGj7EnJpb6Vvck398UkTZgXePvCHcrvdW/9Kf1w0Fxay/MnlR3Hxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ADyRSW2j; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714371883; x=1714976683; i=markus.elfring@web.de;
	bh=Vk3HT11dsQJBG0qes20Skl5rvhJPwT7CLw5IwZVPPIo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ADyRSW2jovDcN47KF529Z37V8VkUMRpaaCUK4gd+Je6Dq8TPiqqd3Lxqsm1M9Sq1
	 2f4BafesjTMVX0I45HLI3A8aXC/VwahN6pjm1WRea/zq/TkCAH1AKT2nvETIXOw9J
	 xPHcKZZjXIr7+DRzYtSdKaj9dMMAtEIhXpMf1Wo/7bEiy3kV+JHsw2e9p0XI2+YDk
	 AJ/9k8qrepBaIsCuzrqTf7alkF2erwBQ43BfmyDfeF4wqur3zG74PmsBoclBW1ayn
	 bQypAonA3+SAkHEE1FOCPY9Z5i29xblMHkW8BByydNkh0ldKhGomAq4wS4KJJowCR
	 z8vNHTum2qA8fgagow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MElZP-1rtqS03SrD-003T55; Mon, 29
 Apr 2024 08:24:43 +0200
Message-ID: <ae0bb605-38dd-4f0b-8100-51ad910f6d13@web.de>
Date: Mon, 29 Apr 2024 08:24:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Weishi Li <liweishi@kylinos.cn>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, kernel-janitors@vger.kernel.org,
 Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240402093922.268368-1-liweishi@kylinos.cn>
Subject: Re: [PATCH] drm/virtio: fix memory leak of vbuf
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240402093922.268368-1-liweishi@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uZirKThhywvNbW5IfnrENAaJ8KZiCv2IZVH7GAXIXACHWRatvWJ
 yFVAIi2ubK91+Hx+oBRfmkC5+zu5ST5Xx5RfXZ1iDWV4id8mhtmN53tiC8BmLj7CANU3/ai
 phrv83UtH/+Kdv4TrwuBY6FU7S0TLw4tlnuVHa3XmdNAaoU56plIT3h8YGXI8CpwgaCUVuK
 XT+6lHSLgL2N1vVVOVxTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tHpQdTEll/0=;UvcfWdViFkDpE1bsJSpUd9EWf1R
 fBRWADUQpQncmAkqyzeNaTORNfMU/jNMG3w9o/q9OwayGwXJecLHIvVUOaX7PA6Wq+b7FIicC
 hoAShDWZYwYNfE6TsmBXf2nYT0x/HW5aZcF4aiM2Ziaq+2s1y8WzDSLZtykXRQnYSxFZxVemP
 bZ5VP2GK++dZHsyMQflzPuMoiQQKBfPHzPLP5On2V92avwguBdnz+m8WKEPcTHkLZ1wflCly2
 NgutE8XxcW9oobmS4Q0LCKxJh3aw+jAaXFnEpGvFi5q5VIG94Yz0jswCsTb6GuoalPPm531Y7
 Kb32OkT+rLQzbpAjy9qIeGAMu91MetIPXEnS++QJxmMfiI+vq4y6FBlnn5v721950OK1o2CCV
 mWt3iLs7i9sktsW4PYL3kVQjvXQXqKMGES33VpWXsN3Kgts7QwMjBZFaN0qH3i/IP8jyZ4Qv3
 wpNz4FMrLxQZqF9IjJb3JDy5riYBTk/obz7Bucs+GWoD/ybhkPxgYTYkN5MQI0MOqsQhjT85C
 NDoN9zJhXSDoQ1UPSdadOWZx9inLM92i8/sRI/HUOx6Hlxl3S5eGcAWEgqzq+LsBBGUGNUiD3
 0y4AQ+h3n3FjfiDXwZzRiRsEAKsqmVheRWCa8dLfPxQqiVDui2nM/KQVxldvjLQzi/xezSXO+
 LX4bp8qRQ7kD5rvApoNMNELsqKZVRpZeCRRrcIyVTE9nrdSY4xGidm19CoGquunJpWOQlgcOK
 NV8YUVhDfufi6jdxIY3VZTNGat0uOPdqg6vnM9HEVU6jtdS3Jk+NH+rOShrWY52ZjohvE2hfU
 vi1li9EFpG8r/gBSQs+ZbD3Ikd8ZOLnKCuvxAen6hj2/w=

=E2=80=A6
> Therefore, when upload fails=EF=BC=8Cvbuf needs to be free directly.

Please choose a corresponding imperative wording for an improved change de=
scription.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n94

Regards,
Markus

