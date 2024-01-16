Return-Path: <linux-kernel+bounces-27739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 279F982F515
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEB8284557
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A701D69D;
	Tue, 16 Jan 2024 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3yC47mT"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3853F1D690;
	Tue, 16 Jan 2024 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432323; cv=none; b=bYcjeEGNVyG8Jz7exNpm1CtGX+enirdId/t+a/h9i0/0pgZE00QG/Dzm5Q5kzz985WfK+95nJYDlO44jtsjPSjw2/L41jznN4kFfmRyVdn8o+1zvjNIqw3uVHVO/eLMbAsV3EDJacMC566kX3qa/6Lm2qDZIr50PW4LjIYEgz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432323; c=relaxed/simple;
	bh=At0y0LAg63pryN4SDbw6Y9AQ4QA1Gvq+RIc+Zhyvjjc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mOHoJVLJIQ/wvuXl+c9EmFijkgimzNH6Dewx6ZLRphDhW+qfJTQ8LQEFQ1L7Pg7X9TZQr4EIGjgbon0K2Mfptnvu066rs6hUk/3SkcMpuX8CNo4krNxVzYOKjNwH07+lhDP4eu132BtG4W06kJ8wxaQXNtkm8QvnUuT8nGqHYvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3yC47mT; arc=none smtp.client-ip=209.85.215.182
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cedfc32250so4789593a12.0;
        Tue, 16 Jan 2024 11:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705432321; x=1706037121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8wrpQHEifzn5isE2BzzQKB98qg2UFhAKp9CxBXCvJHc=;
        b=B3yC47mThZHz1n1rEraIl8BdZz6L2Fg38Py+sMsuwBB1Q2sS+NhETRLan1gaaDiuS8
         lhevQPZDmHpKmkIj8O/+Yi0ZszvFtJP4PS2UWZWkg1dexSnx62PlTocfPeDOgsQsFqg4
         rUsTr88mCc8h52zW4KEpOouroD3IwBkASaayOsAMlxX9/VMKRzqVOth2z+vopDBcmTBZ
         99yaDqzj6p5P6LXQk1dCyB5ql1E2edE1/r5szxZ0H7TJgqS1+32ZRx+oSPSlC6mq6xGo
         8XE++OjRzEpnmKisgsDgx6EcYDEE1QBojWz6Kh71fvOGUqiBuHh+5uUw2lVIq6b8z8XG
         BHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705432321; x=1706037121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wrpQHEifzn5isE2BzzQKB98qg2UFhAKp9CxBXCvJHc=;
        b=qjSGMML0Inabe0raMZaongheQeluNc1B4gB+36AIwibUsTMGNVYxt1x1tdQNE+F9MR
         +NNCwBCpZ2nQgj8A7nMy2zFmw9uoegMbe9yWbZIcIZGZ6AcbncloHXR+LaiyWJjllc+S
         aj44Xdikx2ft9KOuEE+xyl/OMlNtM4MIIH1PFicHwYr2dABF1UVlTBWK/n6rxOE0o16L
         Zs9MUTbJvxNpfQxHk2N9fLaHl7Dab5h8KEVbWExgX5sdSeB5rpEIbMzbNz1H8ZdSq0Fd
         TKKHcUmJ0PAql1uc4j1TuiLElxMKsUlwHKFuvEYI9uuEWQgxbDtF4LbqeApbSuo8YMaX
         X22g==
X-Gm-Message-State: AOJu0YzL22jonKy71Mm6eCurrZ6YPmWV02sZG1K4CVH3uRI/ERiqatUb
	JjiMtV2yOpgdxfV6TyPwGCdQhVVkoAk=
X-Google-Smtp-Source: AGHT+IELUMf2IeBpxdiRocm2duo6eMGUfPK03qWFxT/xZMoS+7BRCBaEKqo72o+u91mqoqzJlN/7OQ==
X-Received: by 2002:a05:6a20:6723:b0:199:e08c:f444 with SMTP id q35-20020a056a20672300b00199e08cf444mr3237956pzh.64.1705432321341;
        Tue, 16 Jan 2024 11:12:01 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5c15:9a6:f612:d37a])
        by smtp.gmail.com with ESMTPSA id m6-20020a62f206000000b006dae568baedsm9627081pfh.24.2024.01.16.11.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 11:12:01 -0800 (PST)
Date: Tue, 16 Jan 2024 11:11:58 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: aduggan@synaptics.com, cheiny@synaptics.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4: Fix NULL pointer dereference in
 rmi_driver_probe
Message-ID: <ZabU_lsGCuki1dSY@google.com>
References: <20240116083847.89934-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116083847.89934-1-chentao@kylinos.cn>

On Tue, Jan 16, 2024 at 04:38:47PM +0800, Kunwu Chan wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.

It is perfectly valid to not set "input->phys" and leave it at NULL. So
while I agree that having error handling is good I do not believe
there's chance for NULL pointer dereference, so please adjust your patch
title.

> 
> Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/input/rmi4/rmi_driver.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 258d5fe3d395..d3a601ff51e6 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -1197,6 +1197,12 @@ static int rmi_driver_probe(struct device *dev)
>  		rmi_driver_set_input_params(rmi_dev, data->input);
>  		data->input->phys = devm_kasprintf(dev, GFP_KERNEL,
>  						"%s/input0", dev_name(dev));
> +		if (!data->input->phys) {
> +			dev_err(dev, "%s: Failed to allocate memory.\n",

No need to log the error here, memory allocation will already log the
failure.

Thanks.

-- 
Dmitry

