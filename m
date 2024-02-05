Return-Path: <linux-kernel+bounces-53835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA9884A71B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939311F26EB6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BB362808;
	Mon,  5 Feb 2024 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTHoIdkZ"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83478629F6;
	Mon,  5 Feb 2024 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162220; cv=none; b=WJalf2+01WLlUZNyBFGRUe7jPQECTSTgdVIKpJS1Erqi15wpF4EfslOPMN01YY+iHOrRHI+cVU6MnexvCOvIDXaULNe6xWd9PWAy4/PMSZaXkJtAjLGF4Ybmg6gX27nUQaxAd5WYa4gmqFYpsvidwMXJE4DhdH7yA7K6DMifcTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162220; c=relaxed/simple;
	bh=XY4TTAJbJUhHs+OdwIErJkmjXGbvN1tNZwvsPs7cS4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMvrHBircZIhe71yehdRSsCRtVLVQkUurzbMy7sI0CWhaIbfJsRGQ3xL+05gyUlfSFvY5xG0MziL2iU55ULdRUMTn4enJYHMHjSp5dMQE3Uu7eLHrBzy7ZM9dEpyE1WvKlKX2hTjw3l3VBbFM5kXXCQLBYlbjqI7G7WSRT9zT1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTHoIdkZ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so3826634a12.0;
        Mon, 05 Feb 2024 11:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707162218; x=1707767018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WownJN3vieYmCVvDaJslP4w36aaJ0JfyBZ8/ZSdb1Ew=;
        b=kTHoIdkZoOCyjACvqZKItLkozfiV2qx9ahywTDnHw4sydSwwwqpLbcxrMLIw2ZWPPC
         bgxH6J1k9d/qhz7hwx2bMOjiwhguXFXdlUy/zfcScH6YD8lni1RK5mLiLFyrYSHw62HZ
         3v3y4ddGtjR+buqt54CAjEvsFgk5VXsOxzy5eL4P3YwXk38JYnn+MNYIVwjEvxI7nM9r
         UW3YwW4ThfzH6fv48Xexk9KEqd6xR10LpFDP1RCgj9uO6XV8ardfp/Gj0GTjByBLLfbb
         HDOlDA8llRaj86HEy47vMjXPQX6Bgwb1UTBoRBiqFqY7m42kqQn3MmgnKk8Pa7MRgcLy
         92mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707162218; x=1707767018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WownJN3vieYmCVvDaJslP4w36aaJ0JfyBZ8/ZSdb1Ew=;
        b=mdVleis2kDcf1QNEwh1iNCShlG64gIcgQgc2i4yhzE65Gc9AqRmr8ourDo9QKUXBvv
         5ya8SXkwIdp3iLL8+LbrlOBqiZFsGZFnSfjVDf7LFeAAA6xBTq3d57oE8pb8mFlDgeCp
         abkzCxJ8bKwBnSz3kkSaoXAnmaZseqHP1+VxAG/VjPMRe2uE6M0It6gOXx4DDZLRIORX
         s1eUAsU9zf6q72bvtTcI25DVTEXKIPJeMSC0x3fIBU2AH3lBEe3xJgVjB8toNoGo8c5I
         oFu34lOMxi7cT7EXUle0TNwh3QvJepxsGYA6+VzrZQMPqE7ij8IqmL7Cpvr/Y6Gpeyei
         W8QQ==
X-Gm-Message-State: AOJu0YwhLnkku+Mk+H2+F3mUx29WRRZumZZFdxyvk0mWcozEWAcatI3A
	hldF7m6IAg98blO3EoLJ9RPpyk0dxRTmm/vsINIrtNt5EpIvIHs5
X-Google-Smtp-Source: AGHT+IFKDFB025e5u29N27FpcDCFQbYoe+NkNUu9nCOwpF1183SVpoRf6Eiwlpzc1Mg9NG4FqW0bPg==
X-Received: by 2002:a05:6a21:7893:b0:19e:4e80:38ca with SMTP id bf19-20020a056a21789300b0019e4e8038camr679969pzc.2.1707162217638;
        Mon, 05 Feb 2024 11:43:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXcWRFnS3Rfjcjem2fP/tReUf7+D1TKeDF9nsfEVLZQaAlV304amNPOgB6CWUQgvMW59KgbZ0ma00CayhZ/vv55kgzKIcaLqvrU9QsPkfcOdBXwU8/Kg1ISE5ijGIFTzhWtx9lQPlSHO8oVCR8Lc0JDIJLQxvtpEWEDBECXMKtp/1mtyzi9vy3Zo+KiIX2VW00nHAcxdklQLJ106tsBRBsixaOyPkHaSCMtVFaqdsxVObmmr6F1jOqio4vZygWJX4/3B8ePMZ3dW4X9dNFlHMEWb+Z26YOLvu5E0k9UJmyjm9vaCTsvfoflBD3oOLDVCuN9NqIQyoQ7iMFVu7yMj0yHWygYu5NdFcC3/gxFKWnlAxcKx6YeDe1/oe+DflNT60XWfG6REyLwhH90EBJ8JeRvN9ruKc4UDiouafy4SIbKVs4BbPYvwY9DaJQKIrCbWIQUVc7aKZIt5Sm2TcObIgQ+xv5oKUqhEP6x1h+/ul+dhCMHxYf6+P6KxsAg2dWJ89Ugs27kl9fi1eNNLq1rwXKQU1U5ZrI7oruYR+9/jNa7KS0obJktFMM42rgspLfafDhjX4LwRREGsWDaTGemYfXvDkdUokMQwhUYf6SEmlUHYZDXmL9MRDpip8mWJJYB+I+4jiMXl77VUcEYckXDwGCuvewAgenyBko3MANj6pfSA3rT2uUhVFUZ4Ev8eG8X7AZMwQBa+/ctSKdSejq0uOMx5S1tUvzpuimLFKmigbGs1puSV2St4+CrxvI98Q4GnRhbqxWRQmz6pKSzf1xDao7+n8b1Wd2xkwjIb9WSrO6Kbygkjjjo/0I=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id hy9-20020a056a006a0900b006d9b2694b0csm225526pfb.200.2024.02.05.11.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 11:43:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 5 Feb 2024 11:43:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Cosmo Chou <chou.cosmo@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jdelvare@suse.com, corbet@lwn.net,
	broonie@kernel.org, naresh.solanki@9elements.com,
	vincent@vtremblay.dev, patrick.rudolph@9elements.com,
	luca.ceresoli@bootlin.com, bhelgaas@google.com, festevam@denx.de,
	alexander.stein@ew.tq-group.com, heiko@sntech.de,
	jernej.skrabec@gmail.com, macromorgan@hotmail.com,
	forbidden405@foxmail.com, sre@kernel.org, linus.walleij@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	cosmo.chou@quantatw.com
Subject: Re: [PATCH v5 1/1] hwmon: Add driver for Astera Labs PT5161L retimer
Message-ID: <4a504043-e24d-4119-8c5d-107f0d371110@roeck-us.net>
References: <20240205152013.3833940-1-chou.cosmo@gmail.com>
 <20240205152013.3833940-2-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205152013.3833940-2-chou.cosmo@gmail.com>

On Mon, Feb 05, 2024 at 11:20:13PM +0800, Cosmo Chou wrote:
> This driver implements support for temperature monitoring of Astera Labs
> PT5161L series PCIe retimer chips.
> 
> This driver implementation originates from the CSDK available at
> Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
> The communication protocol utilized is based on the I2C/SMBus standard.
> 
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> ---
[ ... ]

> +static ssize_t pt5161l_debugfs_read_fw_ver(struct file *file, char __user *buf,
> +					   size_t count, loff_t *ppos)
> +{
> +	struct pt5161l_data *data = file->private_data;
> +	int ret;
> +	char ver[32];
> +
> +	mutex_lock(&data->lock);
> +	ret = pt5161l_fwsts_check(data);
> +	mutex_unlock(&data->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = snprintf(ver, sizeof(ver), "%u.%u.%u\n", data->fw_ver.major,
> +		       data->fw_ver.minor, data->fw_ver.build);
> +	if (ret < 0)
> +		return ret;
> +

You almost got me here ;-). snprintf() never returns a negative error code,
so checking for it is not necessary.

> +	return simple_read_from_buffer(buf, count, ppos, ver, ret + 1);

Number of bytes written plus 1 ? Why ?

Thanks,
Guenter

