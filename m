Return-Path: <linux-kernel+bounces-83594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA54869C07
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C091C21B86
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C726C149399;
	Tue, 27 Feb 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="qCDVfIYv"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF1148314;
	Tue, 27 Feb 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051147; cv=none; b=g+bL5xMvZupyi2kqdXbDopmVYR/nrRSj4fP0UdT44FrnWOcTBVTtRnxAMz/5t7W5mNCkyOZAttGTpyeuYguD5ueU93DXHbdREEcDnHQR0DQWGzxlGzhJqBDHw+mfU30BrFaNNFyKK2ar3BxwH6vqN51SuxFBSUryu0NPefFr8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051147; c=relaxed/simple;
	bh=dNU5NFxvimoHiIWcnfxSEUmX/gJDpUSnZiLZ6SQE0MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o00N+3Luudij+OgsROZtbi2yDeH8GUOIje1GOZXmIVvCvE5VlQxTY/obTTQVqvrRW6DRYsgiwER9OqLn4s4O7Taf1NdSbdvqeAlzGsjwNWwPQepn8Y5wpkaVtpxfG9QP1lPBog7YbE36uua8ZxGi7PfUNrPLRbB/GxOgEHUBgC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=qCDVfIYv; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=/DK9w3brhIW1NFxvU2xPXZWqVBRQidC0n6TtYYYTxoU=;
	t=1709051144; x=1709483144; b=qCDVfIYv1kqJIjpZ6XnZOl0gO7WAdAHpll4cPgmcZitXerI
	xwP5qMJy2N0C9U3UKRfwQ5QoCbuFm3BpSPCJzIxSyG9QSZ07ttogw87yZKBrESQfvbMPQy/qAfO5H
	vgiBJIXPhvJ5rl7dmLHF91vVFIGZfSzQGFE5SHEZloh1StNhiabljZmkZf/+pakWp51hvfgQoA2WX
	5tNRFRbAoWAmOw6HiuLQnY0kQpWpzfDVmlQ/cT79zMtFnuLo0N6/biBU1vLXe1NJvGcUEh46Q9eyY
	uyGSufdYwi0P5YAcRLNnsSZ8pdLbB9999buzTgZ9/9juUDCtT4vF1Yvh1YQQSIbw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rf0Gv-0007OS-RH; Tue, 27 Feb 2024 17:25:37 +0100
Message-ID: <1d8226cd-df43-4ef6-8425-2db01d513b32@leemhuis.info>
Date: Tue, 27 Feb 2024 17:25:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH regression fix] misc: lis3lv02d_i2c: Fix regulators
 getting en-/dis-abled twice on suspend/resume
Content-Language: en-US, de-DE
To: Hans de Goede <hdegoede@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Eric Piel <eric.piel@tremplin-utc.net>,
 linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
 stable@vger.kernel.org, regressions@lists.linux.dev
References: <20240220190035.53402-1-hdegoede@redhat.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240220190035.53402-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709051144;b6afc3ea;
X-HE-SMSGID: 1rf0Gv-0007OS-RH

On 20.02.24 20:00, Hans de Goede wrote:
> When not configured for wakeup lis3lv02d_i2c_suspend() will call
> lis3lv02d_poweroff() even if the device has already been turned off
> by the runtime-suspend handler and if configured for wakeup and
> the device is runtime-suspended at this point then it is not turned
> back on to serve as a wakeup source.
>
> [...]
>
> Fixes: b1b9f7a49440 ("misc: lis3lv02d_i2c: Add missing setting of the reg_ctrl callback")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/regressions/5fc6da74-af0a-4aac-b4d5-a000b39a63a5@molgen.mpg.de/
> Cc: stable@vger.kernel.org
> Cc: regressions@lists.linux.dev

Paul, did you maybe test this? I suppose Greg had no time to review this
yet due to all the CVE stuff and stable tree maintenance; but with a bit
of luck a "Tested-by" from your side might motivate him or somebody else
to look into this.

Ciao, Thorsten

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/misc/lis3lv02d/lis3lv02d_i2c.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
> index c6eb27d46cb0..15119584473c 100644
> --- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
> +++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
> @@ -198,8 +198,14 @@ static int lis3lv02d_i2c_suspend(struct device *dev)
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct lis3lv02d *lis3 = i2c_get_clientdata(client);
>  
> -	if (!lis3->pdata || !lis3->pdata->wakeup_flags)
> +	/* Turn on for wakeup if turned off by runtime suspend */
> +	if (lis3->pdata && lis3->pdata->wakeup_flags) {
> +		if (pm_runtime_suspended(dev))
> +			lis3lv02d_poweron(lis3);
> +	/* For non wakeup turn off if not already turned off by runtime suspend */
> +	} else if (!pm_runtime_suspended(dev))
>  		lis3lv02d_poweroff(lis3);
> +
>  	return 0;
>  }
>  
> @@ -208,13 +214,12 @@ static int lis3lv02d_i2c_resume(struct device *dev)
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct lis3lv02d *lis3 = i2c_get_clientdata(client);
>  
> -	/*
> -	 * pm_runtime documentation says that devices should always
> -	 * be powered on at resume. Pm_runtime turns them off after system
> -	 * wide resume is complete.
> -	 */
> -	if (!lis3->pdata || !lis3->pdata->wakeup_flags ||
> -		pm_runtime_suspended(dev))
> +	/* Turn back off if turned on for wakeup and runtime suspended*/
> +	if (lis3->pdata && lis3->pdata->wakeup_flags) {
> +		if (pm_runtime_suspended(dev))
> +			lis3lv02d_poweroff(lis3);
> +	/* For non wakeup turn back on if not runtime suspended */
> +	} else if (!pm_runtime_suspended(dev))
>  		lis3lv02d_poweron(lis3);
>  
>  	return 0;

