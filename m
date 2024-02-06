Return-Path: <linux-kernel+bounces-54274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEF084AD26
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78C61F24510
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10EC5026D;
	Tue,  6 Feb 2024 03:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxTDWVvN"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACE2745F7;
	Tue,  6 Feb 2024 03:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707191648; cv=none; b=mhylG6bzfnxth2ZXvXd2wpcNKigP+lJ4OcROD1qIFLCmT6jnFEKNWMcrUPTvNAOQeRsZo6D4n4MVeN2mPdDni7wuEcRWPBggv/2VKeF362gwKPO92VwwWpefRci3l4WBUVJ0tpcMtbZZ5tzg6Mh73e6YjswtOX0VDtw/+O2Izng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707191648; c=relaxed/simple;
	bh=t6ixaW+6H4/89KVyOXvsad4/xMeBBQWucAwxMQsaZTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDJEgnKPHd8RxPHpJdxH2INFypmDCEKd/cKTVUvQkQ2P0zxZDyh0f1HMW5/xw1UMnWy7sVhBzBjeJi4P3Sk5IKL7wR4NHucg0yQhi0Owt8sDTZQoi+hQ4P91JsVUz+a7TI9VinSaMbIujPAm1jSo/tOQuaynAKEYnBYHagnZdsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxTDWVvN; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d09d90fa11so30737911fa.3;
        Mon, 05 Feb 2024 19:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707191644; x=1707796444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EZHqfG5XPKO9mKULs9lbfSFN1v0+XqUhR2fg30tQFWc=;
        b=KxTDWVvNfr40+ZE6PQBKWzUHhH+piRb8o0SBn8idOtzo+adkOsRkH8adyd7GGOxMup
         cHIJoo42raH+VzjKOc+DoRUQ2yBbs7qf/ccHjWyRoH64IpRN4Tw5HJ60esV48ZtEvJi0
         vPPD8R5B5oxJKHMkYyKPisiSx3EAkquN4ArKoQcoSRRPE8SU44uGApasuhduTK+5LsNp
         WWd38hcXOv7TwzMGsH8p44yHyY1BV+VQ8fz3CTLtpg7V7K3dFMuUW8+8lqC+dIxDHCPQ
         VJqyicA5OkIMVpFHvb6lAxtly+nCYYoXyO8QaPOlp8dO5Rc4jy5cRbpXrdHWZQkHkQPQ
         yb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707191644; x=1707796444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZHqfG5XPKO9mKULs9lbfSFN1v0+XqUhR2fg30tQFWc=;
        b=or7vjHgHYgMjd+maKS3GBoNH06NLExV8GtZ4n6rDHt84BDCC4SejVAAEgTHw6+392r
         1ZSzQMkD+PtNORdxciE52Hlj42aOH867xZcyOtiKrT57qR2YUjs6sPkXzrpYJbe7qZ90
         +zyK1D69S5MR9Lbw+mPJTZNvz1WarsArTaJXF8DiO45M+ozI7S10tGt4i5TO+tIfNdmR
         nvGZaPaPMsSQTHG1PmkehqayCUnCzAlHG7DQYwi9c8AzJndj367Cda81CK45lrfhfTmv
         LjCUsK1SGe1E6IB4BFrkOD1X+tACXOKLGIOUwuaNXcpUtfBTKC+zKEQQRT6Pe/NLbb5w
         hwdQ==
X-Gm-Message-State: AOJu0YzfEB2/vzHLJSkyrSyiLQF+5Y0U9CSHNYyP1vWI+OF3xD5E2h30
	bZ4JfqJ92WgBA4BnsuGdKe7iICRHV5EZ9o+QQZ/zCZvLe8TsvAOsQ912NaHxo1gvrPaoBTs1xbn
	ZnYAy16ZzgEgIb2nNC82fUgJY954=
X-Google-Smtp-Source: AGHT+IFPhe+tym3Y1EbWx7SXmOEgvof0leWdZvWa0cStvMwvhV6qBwSmhJF/qSRg4bgrypjlE9IdK08hGvb07MnuuO0=
X-Received: by 2002:a05:651c:22a:b0:2cf:2781:8735 with SMTP id
 z10-20020a05651c022a00b002cf27818735mr577251ljn.23.1707191643441; Mon, 05 Feb
 2024 19:54:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205152013.3833940-1-chou.cosmo@gmail.com>
 <20240205152013.3833940-2-chou.cosmo@gmail.com> <4a504043-e24d-4119-8c5d-107f0d371110@roeck-us.net>
 <CAOeEDysSZEeKt==zyexLE1GhE5ZpeDHS7sDLRfcC=4JgiogLKQ@mail.gmail.com> <a05ec2fe-cfe4-48d8-bff4-9f3689c585d3@roeck-us.net>
In-Reply-To: <a05ec2fe-cfe4-48d8-bff4-9f3689c585d3@roeck-us.net>
From: Cosmo Chou <chou.cosmo@gmail.com>
Date: Tue, 6 Feb 2024 11:53:51 +0800
Message-ID: <CAOeEDyscobVHaAe+72P2wEiucgWUDX=2H2W5dq0P1q8RB=7tzg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] hwmon: Add driver for Astera Labs PT5161L retimer
To: Guenter Roeck <linux@roeck-us.net>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	jdelvare@suse.com, corbet@lwn.net, broonie@kernel.org, 
	naresh.solanki@9elements.com, vincent@vtremblay.dev, 
	patrick.rudolph@9elements.com, luca.ceresoli@bootlin.com, bhelgaas@google.com, 
	festevam@denx.de, alexander.stein@ew.tq-group.com, heiko@sntech.de, 
	jernej.skrabec@gmail.com, macromorgan@hotmail.com, forbidden405@foxmail.com, 
	sre@kernel.org, linus.walleij@linaro.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, cosmo.chou@quantatw.com
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 06, 2024 at 11:26 AM +0800, Guenter Roeck wrote:
>
> On 2/5/24 19:05, Cosmo Chou wrote:
> > On Tue, Feb 06, 2024 at 3:43 AM +0800, Guenter Roeck wrote:
> >>
> >> On Mon, Feb 05, 2024 at 11:20:13PM +0800, Cosmo Chou wrote:
> >>> This driver implements support for temperature monitoring of Astera Labs
> >>> PT5161L series PCIe retimer chips.
> >>>
> >>> This driver implementation originates from the CSDK available at
> >>> Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
> >>> The communication protocol utilized is based on the I2C/SMBus standard.
> >>>
> >>> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> >>> ---
> >> [ ... ]
> >>
> >>> +static ssize_t pt5161l_debugfs_read_fw_ver(struct file *file, char __user *buf,
> >>> +                                        size_t count, loff_t *ppos)
> >>> +{
> >>> +     struct pt5161l_data *data = file->private_data;
> >>> +     int ret;
> >>> +     char ver[32];
> >>> +
> >>> +     mutex_lock(&data->lock);
> >>> +     ret = pt5161l_fwsts_check(data);
> >>> +     mutex_unlock(&data->lock);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     ret = snprintf(ver, sizeof(ver), "%u.%u.%u\n", data->fw_ver.major,
> >>> +                    data->fw_ver.minor, data->fw_ver.build);
> >>> +     if (ret < 0)
> >>> +             return ret;
> >>> +
> >>
> >> You almost got me here ;-). snprintf() never returns a negative error code,
> >> so checking for it is not necessary.
> >>
> > Oh! You're right.
> >
> >>> +     return simple_read_from_buffer(buf, count, ppos, ver, ret + 1);
> >>
> >> Number of bytes written plus 1 ? Why ?
> > It's just to include the string terminator '\0'.
> >
>
> If that was needed, it would be risky. snprintf() truncates the output
> if the buffer is not large enough. You might want to consider using
> scnprintf() instead. But then I am not sure if that is needed in the first
> place. Almost all code I checked doesn't do that, and it seems to be likely
> that the few drivers who do that are simply wrong. Can you explain why the
> string terminator needs to be added to the output ?
>
> Thanks,
> Guenter
>
It's just in case someone reads and prints this, but with a dirty
buffer and doesn't handle the terminator.

