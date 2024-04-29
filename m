Return-Path: <linux-kernel+bounces-162695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F838B5F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2982B224EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637BF85C69;
	Mon, 29 Apr 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He2JnMeX"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A858563E;
	Mon, 29 Apr 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408629; cv=none; b=fC/OQF7M33/iQP7YNfzT6b0gJUcxumUcYxxGkMzsx8gsfMTuOBooTmtVnetNc8cDFWf1lnd4IK4QaPeYarhqxKkqjNSYGXYQFOI91YoyyFdICxsQS8BpliKLXENEWSQPXbxNXJ2UgHXxIliu9yaAzpAXdB9Nc5S7D+faUZ+q6Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408629; c=relaxed/simple;
	bh=0nnKFi0nFP/tbopKUHfdYPnFpmKlGf/6qasicOvPJ30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeqhAOIX/UWJO2NM4fLLk5wPXJiIXapIjVLBrQ4krTEvWouBLB8C3/7Fj2wUQJR27VsCnRIV3W05uhc6+a4Rso5/vt1/q8jhJ6YvGJ2hxQabeVPiEHwAksFtR6i5brj/YizDmJaolpKiPxd4PCeoUuDsFgFHrIPo3Ngbnz5Llxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He2JnMeX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed627829e6so5764987b3a.1;
        Mon, 29 Apr 2024 09:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714408628; x=1715013428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk8auT7WvS/IMsC60Jj9GSGDNoxW8FE3WaK9ZUNjDRQ=;
        b=He2JnMeX74wymSBXhTQVfEWgScFv4TRAlFFNQ8AHh2shPaC5eK88+4quYr+iFNThIl
         EZR/TafhCsex+5tflPqefNQcgeQFXDHvTYFgmVQxZEPlGfPMiyNJejudujEzKKJhrvT3
         UDXAg4eWGyfityPN+WPIUPrGEUKY3mJX9G365dvDznQA0K5yd1WlIPGtralXh06h2QCe
         u3Ke0qRwXSDENBS83bLoYWJYGVcdHlQ8rngN7ZIBxqtRw2cO1q+nkkqHXGy3XI+cDzOr
         W+zewj3T/qBqSluiM21T0YYW1NL79jaQITnG15KPyDVyAAggvkdKZD7VDtJJY3EmC77X
         5Qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714408628; x=1715013428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jk8auT7WvS/IMsC60Jj9GSGDNoxW8FE3WaK9ZUNjDRQ=;
        b=Mo7AOioPySNyjtGVgJqBbcMgHcQgIZDZgDS+x9ELVA+/UOK/YjmLX77OSa8RSARd7g
         cOMqAvz96z4IeXMSdD8erX8buyALpLBal3UMaLmHIyZ1IdriZJklfI0GzLK9bNYZttb+
         IPm8HUXzuaoSk40ak381OmVB2sENFhrlOVbh8/21eEHOsH8StllQ2Cox8xe1dn6DGppZ
         bykacmxv1DayAUOj5rOXN0NwoCWohADgPB+Caiboggi9Cn1i0mPp33kLGfer2D8UARmQ
         9wiMSS3/eoCHbQhkp21p05sjuci48jLWpqq3n6oKDDDTiuawxUmPw6I8QJAnTmKYkrP0
         IWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX90gGPe4rgovlkoBvVAQQadvCZZotpPc5R3olz6wQos7YOAIxUqVCLv4y5l2wOKFqwSqALAUXAUVRz0+xxM5YeNva2DLETpxMmZhFaYZ8klSr0XRSltUvCU1Xog42al6lYWnv9wyZtWw==
X-Gm-Message-State: AOJu0Yzx+BYWBHgJE0eO7FpougP4i8Vs7ee1KiNEv7Qwtn9aKPyALl5/
	ruhhZzNxctZkX1q4yef5OHpxLVss6mWgrgN5Cl1Xgh8O3PKLzHgf
X-Google-Smtp-Source: AGHT+IHVSM9yTu7bAim7frvC0bVurNgtibMR8fJP+VVoRypkkqeKCabgmQhmubCUsM3ss5vPyfh1iw==
X-Received: by 2002:a17:903:1212:b0:1e3:999a:9726 with SMTP id l18-20020a170903121200b001e3999a9726mr13069751plh.29.1714408627527;
        Mon, 29 Apr 2024 09:37:07 -0700 (PDT)
Received: from five231003 ([2405:201:c006:31f8:99f3:b2ed:50d6:5ff8])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170903048100b001e2526a5cc3sm20502543plb.307.2024.04.29.09.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 09:37:07 -0700 (PDT)
Date: Mon, 29 Apr 2024 22:07:01 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v2] spi: dt-bindings: ti,qspi: convert to dtschema
Message-ID: <Zi_MrRyGrLfqrHLH@five231003>
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

Please don't review this.  I've received additional comments on v1 after
I sent this out, so I'll make those changes and reroll with v3.

Thanks

