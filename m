Return-Path: <linux-kernel+bounces-63342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17B8852DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8630D1F21C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B2922EE3;
	Tue, 13 Feb 2024 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7rrdx+4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5475D17567;
	Tue, 13 Feb 2024 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820137; cv=none; b=j7ZKdHrGyNzMVGxsn3aMLrqF5w9PyJeHHRxF7uW4XB4v99UfJ7kjms70OUMBdyPAWo9pGas6rqEdcWOBJCVTIEzMtpLnu7k5hkyb+cs79r1zc29s7jTmx4xpGe4SCnFDwjpBDoXUPw+gOEKK4YDG2VQiLPGIIMPiu7wxnJkeP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820137; c=relaxed/simple;
	bh=KELckhVrrPAn8QJQdC/3ladRTgf3KCcEhqMhtdeu0sY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OmZyKsEO4Se5HtivWeWQWN35c6GpTQ3vOaQ5q59/pcbdnh5AZL1qVXwEm7+aMNWL5Te+sIYpGkociMtbp4aT8rwDDS+IcadBMRrLn3xLPcLplpYFRwioF9wgGn9BEgmxbaE1+wyANHGdmQYw0uTpjzjE9LsKhYFNH9m8BguG+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7rrdx+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7F6C433C7;
	Tue, 13 Feb 2024 10:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707820136;
	bh=KELckhVrrPAn8QJQdC/3ladRTgf3KCcEhqMhtdeu0sY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=q7rrdx+4nriD2crmR29XX7qnukNSdg0kYiRaCTcUYiqAzfKz+YEonRLqVawcgvPJW
	 uuK0goTyBZJySTmVHHZVVs2jb8oBUPMUO2tUI7LX0Bg9EntgMb/lo5uZH0AU/xrl4Y
	 ZSVZ9LbNSS8Mj3QSQmEHVna74EHd9csAocY7JYSTawE32saeqYly8OuT2D3isw6vSR
	 uZ4WN0AedrMBSb86vfKQcklrUQN8W/n+92s0BeB5p638yWXDZD48ZY6C4C3lnHERYI
	 nzDRzK0SGEwnjCaE1LLUnGo/+Dw3iaN/BvwtwYK47oHjV461a6FpATrmhN/IZRCN7r
	 XQhXqW5TjT6EA==
Date: Tue, 13 Feb 2024 11:28:57 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Manuel Fombuena <fombuena@outlook.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: multitouch: Add required quirk for Synaptics 0xcddc
 device
In-Reply-To: <CWLP123MB547355BA62AD835719F60865C5492@CWLP123MB5473.GBRP123.PROD.OUTLOOK.COM>
Message-ID: <nycvar.YFH.7.76.2402131128490.21798@cbobk.fhfr.pm>
References: <CWLP123MB547355BA62AD835719F60865C5492@CWLP123MB5473.GBRP123.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 11 Feb 2024, Manuel Fombuena wrote:

> Add support for the pointing stick (Accupoint) and 2 mouse buttons.
> 
> Present on some Toshiba/dynabook Portege X30 and X40 laptops.
> 
> It should close https://bugzilla.kernel.org/show_bug.cgi?id=205817
> 
> Signed-off-by: Manuel Fombuena <fombuena@outlook.com>
> ---
>  drivers/hid/hid-multitouch.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index fd5b0637dad6..3e91e4d6ba6f 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -2151,6 +2151,10 @@ static const struct hid_device_id mt_devices[] = {
>  		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
>  			USB_VENDOR_ID_SYNAPTICS, 0xcd7e) },
>  
> +	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
> +		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
> +			USB_VENDOR_ID_SYNAPTICS, 0xcddc) },
> +
>  	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
>  		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
>  			USB_VENDOR_ID_SYNAPTICS, 0xce08) },

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


