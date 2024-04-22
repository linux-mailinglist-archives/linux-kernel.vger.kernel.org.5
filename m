Return-Path: <linux-kernel+bounces-153788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADFA8AD326
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA8F1F21E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B39153BD5;
	Mon, 22 Apr 2024 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ym1zpgnf"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BDB153BC6;
	Mon, 22 Apr 2024 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805863; cv=none; b=HOoAzkoF9T8QfDY1nPLxbzfAu8D/0yW48Qd6MzJWADxJ3fFzFWjJ5NfpwSxY9iCNDKpVmMkhgqBKDkqSjmuRa8s7pbSdyFIsLr612rm5gX55wu9ao7inzoZX5/26DSIL42MNUwAuMIgMnPQqtgmlx7FpCM4w5Lj5+oSP4IvvPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805863; c=relaxed/simple;
	bh=LwjGFpqMPE7/isFyix1F6hQ3BlY9L4xSAYUXU2nXEO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhTA48qAYsfkx25RUIiPbApVTQQQb6S84/JgEjhVyVsvDvSpQXUuuYhqduWnf4Yebouq8BBOCss98zf/xRJHHyYfwnZODqw7QFWZBI9BNGM5jMinaG1nZHb2W5/3kXBVR7QOOFlxqaQuHnuy5iT9pUBKgXVZVdXr938qZZExZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ym1zpgnf; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=o+rHFy1a1QfA8CSXaqess65zqT0THwLSLU62WTJDzAQ=;
	t=1713805861; x=1714237861; b=ym1zpgnf321E/uM2vmV+7bzcIuRhgRe9JY7WxBwaMD9pG6e
	my6DZ2Mvhjf3YjyQhXVjDiBZEWW7lH3xPL1tfxpTXFS7RMR1zT7Owzn0qn9A1YtIsHZaAMeeqEtmm
	90i0h+eBTRlp3uqFY5HPBvVAqP6HSl7p2yQKi4UYOAVrGqHgpYobhRI/va27LqAGAepHmJSDVHJh6
	Pw6MCccIhaH9JwERmGrRDb9Z9ALGQuPINfcKsXupQjlLrFZ5178hLo+mj+5p9GehSVqkbdz14zsag
	T7NzuOxoY3saz4tsBKe8vwacvOeU4bJ9lTSb1V1mcmn6VClHI7encPvsBZUGVWCA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ryxBx-0003Vp-JQ; Mon, 22 Apr 2024 19:10:57 +0200
Message-ID: <14d1b38e-0f11-4852-9c52-92b4bedb0a77@leemhuis.info>
Date: Mon, 22 Apr 2024 19:10:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] HID: i2c-hid: Revert to await reset ACK before reading
 report descriptor
To: Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Douglas Anderson <dianders@chromium.org>,
 Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Kenny Levinsen <kl@kl.wtf>
References: <20240331182440.14477-1-kl@kl.wtf>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <20240331182440.14477-1-kl@kl.wtf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713805861;d4d60d74;
X-HE-SMSGID: 1ryxBx-0003Vp-JQ

On 31.03.24 20:24, Kenny Levinsen wrote:
> In af93a167eda9, i2c_hid_parse was changed to continue with reading the
> report descriptor before waiting for reset to be acknowledged.
> 
> This has lead to two regressions:

Lo! Jiri, Benjamin, quick question: is there a reason why this fix for a
6.8-rc1 regression after more than two and half weeks is not yet
mainlined? Or is there some good reason why we should be should be extra
cautious?

Side note: I noticed this due to the tracking today, but I also saw a
user that recently ran into the problem the quoted fix is supposed to
resolve: https://social.lol/@major/112294923280815017

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> 1. We fail to handle reset acknowledgement if it happens while reading
>    the report descriptor. The transfer sets I2C_HID_READ_PENDING, which
>    causes the IRQ handler to return without doing anything.
> 
>    This affects both a Wacom touchscreen and a Sensel touchpad.
> 
> 2. On a Sensel touchpad, reading the report descriptor this quickly
>    after reset results in all zeroes or partial zeroes.
> 
> The issues were observed on the Lenovo Thinkpad Z16 Gen 2.
> 
> The change in question was made based on a Microsoft article[0] stating
> that Windows 8 *may* read the report descriptor in parallel with
> awaiting reset acknowledgement, intended as a slight reset performance
> optimization. Perhaps they only do this if reset is not completing
> quickly enough for their tastes?
> 
> As the code is not currently ready to read registers in parallel with a
> pending reset acknowledgement, and as reading quickly breaks the report
> descriptor on the Sensel touchpad, revert to waiting for reset
> acknowledgement before proceeding to read the report descriptor.
> 
> [0]: https://learn.microsoft.com/en-us/windows-hardware/drivers/hid/plug-and-play-support-and-power-management
> 
> Fixes: af93a167eda9 ("HID: i2c-hid: Move i2c_hid_finish_hwreset() to after reading the report-descriptor")
> Signed-off-by: Kenny Levinsen <kl@kl.wtf>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 2df1ab3c31cc..72d2bccf5621 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -735,9 +735,12 @@ static int i2c_hid_parse(struct hid_device *hid)
>  	mutex_lock(&ihid->reset_lock);
>  	do {
>  		ret = i2c_hid_start_hwreset(ihid);
> -		if (ret)
> +		if (ret == 0)
> +			ret = i2c_hid_finish_hwreset(ihid);
> +		else
>  			msleep(1000);
>  	} while (tries-- > 0 && ret);
> +	mutex_unlock(&ihid->reset_lock);
>  
>  	if (ret)
>  		goto abort_reset;
> @@ -767,16 +770,8 @@ static int i2c_hid_parse(struct hid_device *hid)
>  		}
>  	}
>  
> -	/*
> -	 * Windows directly reads the report-descriptor after sending reset
> -	 * and then waits for resets completion afterwards. Some touchpads
> -	 * actually wait for the report-descriptor to be read before signalling
> -	 * reset completion.
> -	 */
> -	ret = i2c_hid_finish_hwreset(ihid);
>  abort_reset:
>  	clear_bit(I2C_HID_RESET_PENDING, &ihid->flags);
> -	mutex_unlock(&ihid->reset_lock);
>  	if (ret)
>  		goto out;
>  

