Return-Path: <linux-kernel+bounces-162613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5D88B5E13
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D49C1C217E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222F983CB6;
	Mon, 29 Apr 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEJjaB8o"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943082D9E;
	Mon, 29 Apr 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405746; cv=none; b=QC4pI/qurl7J9AFzabPg+NxYM/1UtIK4mzV8K67Wy1gRVqNFeB8CJAuwWEyNRwEkPh5+0MaxmxPn0x7vKBanw9FpbvoAofIUv8TdkEbUEXakjQKVDU+XhzMoueHpgajzXV2lwrM5FcK7s13Qgpdn/g1wz7tKcHlvM/PWhzWIwJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405746; c=relaxed/simple;
	bh=ZVzOBW5sDTut2lHyNx/PKeP/GfUlSjNh77/I3/nUe9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+x2sKZgmNycKikoXBUpZ4ePpO4+QX/y92GbsPLcJUJDcALbg6fOdP37Q17lJh7c+sRmv1cM1WfG8+06j33MpjpWt1cNdTUOJXZcpr5IPVOvnEb8w8G6yZFE0IYw08YR1HghnF+J0TL4tqR0BmtznVGWrauHq22u4amR3m+mcLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEJjaB8o; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e834159f40so36733065ad.2;
        Mon, 29 Apr 2024 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714405744; x=1715010544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RTVJAIKC4lPIZ0F4i4bQIVUsZ9S3zGn4x8qWDen6T24=;
        b=QEJjaB8ojqdV+ayNQM7CBhlVH0QrpvWCmw1tLGtAF4uSEky4EyXyZiMdkwO7Up+Tmd
         rQp+fyUFcm+Jmv+OC49iWlTlPRX4Ybyf4QzoFknSLu0hpqcdIj/CUrfADr0ahfA+nwNU
         E7SLgryQiD/vK5Wz3bZ+NeOKzi9QB8G/SRRSQgDHUNIqpC0b+buZaJcFSjdUeaK+k7/d
         QESY04xHL3xjUoxzXWi37rLbCfm5yJQxnNjc9lj7bRRUocEJdDgnN60Ep03XkXDE9t5H
         YbTcja7DltW9oANB9EMaoPy53763fEyE3gTfLuddg3j/6EtdvXKXoKz/hmf0cZ0aGzOT
         WK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714405744; x=1715010544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTVJAIKC4lPIZ0F4i4bQIVUsZ9S3zGn4x8qWDen6T24=;
        b=hrSQPJ7ww0/2E3T6aI/BJRihL+KGwoHHFSLHN/kiKEyM8uACyhTdGJbNcxQSoSQ7t8
         +Ylrrw4+nHBi1gjckZRP83QeGOqUVWXVZ9PMzOaUwoyk6iQn+d36koAzrv9JaLgJaeeo
         xlXyG6l0i+cm0fddvFo7nRg0lT+Lq0VXNrHpIQzOnr0+SiCE68HRgtolEK77DiAz1gop
         CI/E0BCoL/y3CmkqNl1T9mnzyiIgVcXFMgA70y5eCJqBzO4sPlf5DGs3b7jKTQtQCvJ0
         +54ZCEaMV6UNLnD2W4qyzspo1UqKLLuvjEU44cLrRnoRfgbHXN0L+xApRlBz9DqnX5zW
         Rz9A==
X-Forwarded-Encrypted: i=1; AJvYcCVZkHHd9elWkZfVoMWkV11gAz0QHV+NXvJnL92sPVDlGaVxRxZUNdXsvqoCRLFKh84tLym9oeajWcTpb7GaXFvFYabnENPj6U5SDA5MsGWWbU/Vo9UkYkSh2HGLIzS1JDEZv1tIW2fo/A==
X-Gm-Message-State: AOJu0YxBYrBUAsBw2F2DeGmccTxQfwfqHz2dwxupIzlnlToJbI7zoFJo
	3ovnCvRFwOKa2w6yr1dQfNNViGa8vajQ4Ycn4Ws1dGw0T7oN/mBcJiOd0BrL
X-Google-Smtp-Source: AGHT+IGUHeNWKqWe1EsrhcdTBmnx7paoRfJsqeZpp1FD6zALSHFENPxrectRjZ5wK6+7rR8vOKLcRw==
X-Received: by 2002:a17:902:d648:b0:1e7:89af:f267 with SMTP id y8-20020a170902d64800b001e789aff267mr9425905plh.37.1714405744245;
        Mon, 29 Apr 2024 08:49:04 -0700 (PDT)
Received: from five231003 ([2405:201:c006:31f8:99f3:b2ed:50d6:5ff8])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902768500b001e4478e9b21sm20470297pll.244.2024.04.29.08.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:49:03 -0700 (PDT)
Date: Mon, 29 Apr 2024 21:18:58 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v2] spi: dt-bindings: ti,qspi: convert to dtschema
Message-ID: <Zi_Bar7-I0yxYfL6@five231003>
References: <20240429154443.5907-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429154443.5907-1-five231003@gmail.com>

Forgot to add the "Changes since"

On Mon, Apr 29, 2024 at 09:14:21PM +0530, Kousik Sanagavarapu wrote:
> Convert txt binding of TI's qspi controller (found on their omap SoCs) to
> dtschema to allow for validation.
> 
> The changes, w.r.t. the original txt binding, are:
> 
> - Introduce "clocks" and "clock-names" which was never mentioned.
> - Reflect that "ti,hwmods" is deprecated and is not a "required"
>   property anymore.
> - Introduce "num-cs" which allows for setting the number of chip
>   selects.
> - Drop "qspi_ctrlmod".
> 
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---

Changes since v1:
- Removed a redundant paragraph in the commit message.
- Mention that we are dropping "qspi_ctrlmod", which I forgot to do in
  the last iteration.

