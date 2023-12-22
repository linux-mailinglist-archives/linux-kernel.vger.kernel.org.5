Return-Path: <linux-kernel+bounces-9280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1639181C35C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0F6B22959
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF66D184C;
	Fri, 22 Dec 2023 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="adaZShO4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3001FECE;
	Fri, 22 Dec 2023 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Q6NjPgYJQtSodOzthdhnA37trDHql/uqNpeL2NkABuU=; b=adaZShO4wEcL4qF2GJqtyMR7Gt
	Pm80sELUqhpf2d84fpt+taz4yQk7scuc4qKRMns6INFV0iFG+R63LMpi3zOAayxqZFD7rqGH0h0YZ
	RUGYYkrDh4YtHObEFdLByHqIPPcNeMC8DdIuYzin7qpB5nPXHmPWJNGq4NXM8ksNKwHiPEh9rAJq+
	g7d1gmeyNXT45W20wrg7R/ipvtoLVnavfbRYiMkAMYkWuv/TMvFZzpunUgZlw4unFjuK9yhn6nms9
	i9QzPaBOm1pAnHvtDquRJLAV3N6/gGMJi7PG6YOT7iFccS7k9i0pZmC0nBXyxflRf9UhNKLO3FL+s
	rHqiQPnw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGW42-004jsp-0V;
	Fri, 22 Dec 2023 03:19:08 +0000
Message-ID: <0e7b22c0-4645-4403-9408-dfc8e86eda86@infradead.org>
Date: Thu, 21 Dec 2023 19:19:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda/tas2781: fix typos in comment
Content-Language: en-US
To: Gergo Koteles <soyer@irl.hu>, Shenghao Ding <shenghao-ding@ti.com>,
 Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <ead5609d63e71e8e87c13e1767decca5b272d696.1703203812.git.soyer@irl.hu>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ead5609d63e71e8e87c13e1767decca5b272d696.1703203812.git.soyer@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 12/21/23 16:11, Gergo Koteles wrote:
> Correct typos.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
>  sound/pci/hda/tas2781_hda_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
> index fb802802939e..8f63e3099d3e 100644
> --- a/sound/pci/hda/tas2781_hda_i2c.c
> +++ b/sound/pci/hda/tas2781_hda_i2c.c
> @@ -421,9 +421,9 @@ static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
>  	}
>  }
>  

also:

> -/* Update the calibrate data, including speaker impedance, f0, etc, into algo.
> +/* Update the calibration data, including speaker impedance, f0, etc, into algo.
>   * Calibrate data is done by manufacturer in the factory. These data are used

    * Calibration data

> - * by Algo for calucating the speaker temperature, speaker membrance excursion
> + * by Algo for calculating the speaker temperature, speaker membrane excursion
>   * and f0 in real time during playback.
>   */
>  static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
> 
> base-commit: c7e37b07cc7564a07125ae48c11fd1ca2bcbeae2

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

