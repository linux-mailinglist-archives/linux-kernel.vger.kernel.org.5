Return-Path: <linux-kernel+bounces-60518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A47D8505F9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF145B23129
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476875DF3A;
	Sat, 10 Feb 2024 18:28:23 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75885C8FB;
	Sat, 10 Feb 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707589702; cv=none; b=u8MFXzJ7r1At9gskR8yEH4GwEckV25Xt1a3oHE8XmvVGQCxdtN/H6fhqe68eXQJbldOjs8GlVFsj9TBJhbod3S2UuteIO7YkiYnMZPU06FhwjVcNFnC6SMNrOFw7FOoe0ELZcWm54w2dxoj7uzGCA3j7C+igcCxGbZa8B0ACDEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707589702; c=relaxed/simple;
	bh=J1Ii1pmB0KX+fGzm1v3fncbFEfo+qoV5oXPke2TDW+s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mqoRl/4+lN5fOcD4HoeI9+K4C1EbTXO45ndFefXPT8nVCjcSuNabPeOWPq/un0CKDpz7pvC+6WWz9oZcFVX2SnEhNwK8TiafJ+OKKrhrOAQCMlvzL94NS04/A9vAfDH/uGidJX4TwPIBohQgcpe2J103BKUHYdMOYBR3sZpsuDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b69e54.dsl.pool.telekom.hu [::ffff:81.182.158.84])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000073B2A.0000000065C7C03D.001B780A; Sat, 10 Feb 2024 19:28:12 +0100
Message-ID: <79751864914857d6ed83a58acbd3134e79a3591f.camel@irl.hu>
Subject: Re: [PATCH] ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU
From: Gergo Koteles <soyer@irl.hu>
To: Attila =?UTF-8?Q?T=C5=91k=C3=A9s?= <attitokes@gmail.com>,
  Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
  Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
  linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Feb 2024 19:28:12 +0100
In-Reply-To: <20240210164703.141745-1-attitokes@gmail.com>
References: <20240210164703.141745-1-attitokes@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Attila,

On Sat, 2024-02-10 at 18:47 +0200, Attila T=C5=91k=C3=A9s wrote:
> Like many other models, the Lenovo 82UU (Yoga Slim 7 Pro 14ARH7)
> needs a quirk entry for the internal microphone to function.
> ---

Looks like you missed the Signed-off-by tag.
It is required for every patch:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign=
-your-work-the-developer-s-certificate-of-origin

I think you can also add a
Cc: stable@vger.kernel.org
tag.

Regards,
Gergo


