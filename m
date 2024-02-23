Return-Path: <linux-kernel+bounces-78344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293E286122F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4021F2316E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896A77E772;
	Fri, 23 Feb 2024 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imYAMsJi"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD151E4B3;
	Fri, 23 Feb 2024 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693329; cv=none; b=F5JbtD6J2t4vegNhcFnEnKnCdht6Z2Y3zvDWfxUC36kIx96oqrF0lrBetxGExeD/f668Jy7HLB0O2WEVeU1z7v3lx3By8/bKWpXsOVHGeSg/i8mTqM/YROwU6Xm/5yCCuSVkx0gka/pvUCPCOaiP7+Q+M1OnIa/Zi0MkFiJaYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693329; c=relaxed/simple;
	bh=wjq07PpYymrZKKAoQVhq2BQc76gSpF0DqGU+6ncJhNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krXd1eP2xNmIqvIWcit9Lhrp71IyV/QUAQwA5+NaVE+8XQIIse4ATKo7gbgdVfq3q3MLjCQ/P8NHt559CXX1x4L5IwwpxFt9DVytBAw7yRtSA305JPb5OzoRCCZNiV6UI22HH/9SVH193iU9wjVaFpPa1QfTo/PP6RfQm99AdMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imYAMsJi; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3f829cde6dso93656366b.0;
        Fri, 23 Feb 2024 05:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708693326; x=1709298126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjq07PpYymrZKKAoQVhq2BQc76gSpF0DqGU+6ncJhNo=;
        b=imYAMsJixbEvRQxEfXAg3LQWGuA0c6z9+858Bp5S0DH8XZwQ15J7GhiYuk7KUGYQ6t
         II8H3oBs7JNdq0k/ZhxNYt/IPMN57zPzLjuDtsfPbZGGC1D+czpxi56hxAnk7cNnXSZ2
         rNPiBWixYI2zWyIYuMClHAOJoAhs1sdIYU4j3CQr1XevR8eK+vzcNoDS2jw6n2OyRho/
         evhwscn8X+DUvdkvm+fOi0RbkI1x3mkX0pAJKq7YegpsmxT/+tXXYk1WXVuJvsIzCfWB
         CPm0J1RcZfcMGLt1bPgYq+REcmDqgjXByRN6rs+VXw1DicDIxaYmMDtOm3F47PviMMQf
         E6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708693326; x=1709298126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjq07PpYymrZKKAoQVhq2BQc76gSpF0DqGU+6ncJhNo=;
        b=a4Xr5ulzxfVck4VFhY/YPyU9TOIzEboqNja70Oc129iKTJtsPyMXidroeLnqkyY9Pz
         vto2yTq7kio0yKMF612+I+TBehRIAl381FYeoqAUx5bbGCztmVWl/8lSxQfCFoUWXUu4
         vHs1Vgxc44eliYMdU/zYJtrmkT9PnzEdDY/s/jTfjr6/sqgLgsJo/j3dzDx7RZF/KLKA
         VzA946vd0bX3msOqCgwIoJ0p9pbVdTQxL0/OEdUaMbPtxaSjip7+PAq4F59I2Sy4y8Xz
         MguooI612XaReyY29ZUkeuQt3aTzuRK2aznwxKJhRNRVDaS4y+ijvmuIjjQIYbfHcQA/
         eyjg==
X-Forwarded-Encrypted: i=1; AJvYcCVCIyubaAZJEZJP745+BNju0+20Kwkj5yqHuCqbJgg1Scq+9k4krz6wXkisMJSPlJkhntAqN4DPjYv6xNjY5zZOitMKPCTcwnmA+8eKpebyCbM1ylylRImFXW0VRlszGjqrkbaUs4g3
X-Gm-Message-State: AOJu0YzniotdBf6wQV77RlDiCxp6wS0Jx5vjDySKxuePix9lYpjnzBvw
	bnxT380q2LkpQ+6sEVoOvAp9XVy3OmA0wobC/dW2hkYHTj1VDRXdgPLQej8tYlYUqAum/9wkzyV
	AJoeT6GwiK+br5kKBTrDRV+UtQNweuWJ86Rg=
X-Google-Smtp-Source: AGHT+IFJicXo49jcPmF3ozTCIntOPHZaNICbV+q4qp+G0h6fLVfkxYx5SfT0LbSBWWGkkoGdw+ja5cEeSVfLsSgJPVQ=
X-Received: by 2002:a17:906:688f:b0:a3e:9df6:7f0a with SMTP id
 n15-20020a170906688f00b00a3e9df67f0amr1215288ejr.68.1708693326401; Fri, 23
 Feb 2024 05:02:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
In-Reply-To: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2024 15:01:30 +0200
Message-ID: <CAHp75VfmsDeTP97srRJU09gA988xw68+ZHsXvXT3W_wv1HEauA@mail.gmail.com>
Subject: Re: [PATCH 0/3] iio: adc: rockchip_saradc: fix bitmasking and remove
 custom logic for getting reset
To: Quentin Schulz <foss+kernel@0leil.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Heiko Stuebner <heiko@sntech.de>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Shreeya Patel <shreeya.patel@collabora.com>, Simon Xue <xxm@rock-chips.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Quentin Schulz <quentin.schulz@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:46=E2=80=AFPM Quentin Schulz <foss+kernel@0leil.n=
et> wrote:
>
> The mask for the channel selection is incorrect as it's specified to be
> 16b wide by is actually only 4.
>
> Also, the 16 lower bits in the SARADC_CONV_CON register are write
> protected. Whatever their value is can only be written to the hardware
> block if their associated bit in the higher 16 bits is set. Considering
> that the channel bitmask is 4b wide but that we can write e.g. 0 in
> there, we shouldn't use the value shifted by 16 as a mask but rather the
> bitmask for that value shifted by 16. This is currently NOT an issue
> because the only SoC with SARADCv2 IP is the RK3588 which has a reset
> defined in the SoC DTSI. When that is the case, the reset is asserted
> before every channel conversion is started. This means the registers are
> reset so effectively, we do not need to write zeros so the wrong mask
> still works because where we should be writing zeroes, there are already
> zeroes. However, let's fix this in case there comes a day there's an SoC
> which doesn't require to reset the controller before every channel
> conversion is started.
>
> Lastly, let's use the appropriate function from the reset subsystem
> for getting an optional exclusive reset instead of rolling out our own
> logic.
>
> Those three patches should not be changing any behavior.

Nice series, I have the comments in patch 3, but no need to resend
until Jonathan asks for. He might address that whilst applying.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko

