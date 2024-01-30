Return-Path: <linux-kernel+bounces-45126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EBE842BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E89C1C21CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF3078B62;
	Tue, 30 Jan 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjxBiw7h"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA0A69D36
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639978; cv=none; b=HZFhbFIaubHVuL7Ai8DguhoMu1jRQ9RclAh1xnEvf+IB76LOKLMgduFWUyrAblg9SmwXY1GjICovBymOfjR+UauqL1i24tAuuSL/F89pnU+M8yu+C5faewxmgTFghbnY0JYx/hEXb/pjVHJ0xnOiODSGuvjWxbRhMOyb5ii//5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639978; c=relaxed/simple;
	bh=MI0NDS6Iev4PjDUdrQb7Fd1NOLSljNC70XXvSCaQOzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FThIKqjp+lkqA1hl45OWebsvqo3PW2FEzeFJgfPlnjgQRg3t57e6nrmbyTkabbQNHtAqxodW1blTVW6cbn9NWbmMTe+T4ATe8w0WmKCP3F1paJgVTMuE17AtD6n8zGoKM4GZtBSgGjjfMnM5UxRIxG1xHBELZA8uOQGfLmoaDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XjxBiw7h; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bd5c4cffefso4732247b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706639975; x=1707244775; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pOjCTKxf4sFvuTCxIsDxH4OosQIHqdZ2rmZHkDuD9II=;
        b=XjxBiw7hNjXi97wqdnaZnr50iZg6Un6HCWlkP1K/7QQbCT1ZxHcRBeE+UcgXnKdb6h
         JO2JiBVA6wlXrucB1uiOuH9z3UxPSqOGuEnPipvw5hfO+eGrtQHa8FV1F0cl7GIP+OsU
         STuUwEwcQHkj3hBPw4ciud70s9Fm0iWEep1p0gLXY7QUyniSB2npKnlwSpdyKSzl3fcn
         7siI3wgPFmajLyQi2dZXNRzWuGrZF0LaO8kOnj0keSjW9a6YGwtw6jHRTjWHO5A0IS/A
         Ktw6qPi3LslO+LporoUnnF2hOpSP7tESbicSCKjphYvJHtY1jc8qgeESkSMR3VJ3AM2a
         6A4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706639975; x=1707244775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOjCTKxf4sFvuTCxIsDxH4OosQIHqdZ2rmZHkDuD9II=;
        b=IOiisuZiVpJ0UZl7jfku952WDvCwhwf3cxuH8ax3iwUM5A1vX6rV7loTaJNmmc6Uui
         BsVdp6esQxL4vDe0QU9bvSqRLggWfoJTL6U7z3+uzQRDtrApXs8ZbZvCz2Ov12Oo7twI
         UsrB95Qku6hQyX/he029Q1yQwYu82YJOMEma9WifyJnp4maxEDvQ5cRDK05X6Qt1vHuf
         w4WBOYwlYzBoJh2LHJdo3idezK6QLfIftwxI7lnH3+C05h3AiLr9XvYz5xfCWSKv6TfT
         /dftCpC+cvGLN6QqBWKS/8+bhX73Jzd4VsjYBMFLyy8yc8K9DtD0j55HsOWogFTivvos
         +Xxw==
X-Gm-Message-State: AOJu0Yx/jjTlFBjWYSVKp0KIN6puBVlHOSI3KKMPnraEbqyswh1lY9Tp
	XkV+WU29wuDIZ2Ke1JkZHPZnM96I0VvAPEO47+V97y7hACj7rLDkhv+PJGhBlQ==
X-Google-Smtp-Source: AGHT+IHKbwYWqn9d33FCtu9hgL0/2+JLAXUvS/DetlfUcPARSY8K+NddJ08iJ+7Sj53243anjwXCdg==
X-Received: by 2002:a05:6808:17a7:b0:3be:ac08:ea3e with SMTP id bg39-20020a05680817a700b003beac08ea3emr981434oib.40.1706639975619;
        Tue, 30 Jan 2024 10:39:35 -0800 (PST)
Received: from thinkpad ([103.28.246.123])
        by smtp.gmail.com with ESMTPSA id fb8-20020a056a002d8800b006dd8148efd8sm8081795pfb.103.2024.01.30.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:39:35 -0800 (PST)
Date: Wed, 31 Jan 2024 00:09:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/2] PCI: qcom: Add X1E80100 PCIe support
Message-ID: <20240130183930.GF4218@thinkpad>
References: <20240130065506.GE32821@thinkpad>
 <20240130180040.GA527428@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130180040.GA527428@bhelgaas>

On Tue, Jan 30, 2024 at 12:00:40PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 30, 2024 at 12:25:06PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jan 29, 2024 at 04:41:20PM +0200, Abel Vesa wrote:
> > > Add the compatible and the driver data for X1E80100.
> > 
> > If you happen to respin the series, please add info about the PCIe controller
> > found on this SoC. Like IP version, Gen speed, max. link width etc...
> 
> FWIW, I always prefer actual speeds, e.g., "8 GT/s", instead of things
> like "Gen3", for the reason mentioned in the spec:
> 
>   Terms like "PCIe Gen3" are ambiguous and should be avoided. For
>   example, "gen3" could mean (1) compliant with Base 3.0, (2)
>   compliant with Base 3.1 (last revision of 3.x), (3) compliant with
>   Base 3.0 and supporting 8.0 GT/s, (4) compliant with Base 3.0 or
>   later and supporting 8.0 GT/s, ....
> 

Makes sense. Will keep a note of it, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

