Return-Path: <linux-kernel+bounces-45963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D096984386B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F5B2832D5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDE25677B;
	Wed, 31 Jan 2024 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E04Loq62"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29720657B8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688100; cv=none; b=QK5Dab9zA1bbDkPMBW0knAUEyx/s0+5YkcYXAZxfKAYK8itPIr25LNIvKBTUFlVYldWtCJ91vGVnNtrfaQoXIzde7ZLHRr6JLcVue1Sl/a73buSIISc0MXg5UtkMsXOzevgMpcksddjFGWOJ14ZH1V0cqM+u/j9qErmoE3W4vQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688100; c=relaxed/simple;
	bh=bcdYESMliQGwmnXxlM5uRrAlJUkgH4mbAcDcbEkBiy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGAqAiMJ6TqYI7DntBqndkUhuGR/gclUihZJU71we3wI5S/Ee6kmAqoohs/sGFyFCK+Yvf18CazwUKzAIBd8UHnQyMXD73mQfCKMMqO57xF4iEUb8FSUA35yYjk6Ls7sukgNs9opfb6XOJ4S6Kx3MbQL0q7CW49GWlv4fS3lg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E04Loq62; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a35e65df2d8so347578366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706688096; x=1707292896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=31HHx0QgCVuAgnQ4tzCd7Ii1IZudPB4QFu8JKjXKEyk=;
        b=E04Loq62M4WoB+GJcgafbT5/MW9CT0PUXpqioR/Xwji08OIv9mmvdloYDsi2O73bCk
         azVRYzbAd/na8iwdsH0od8hZAj2KLCH0BqT+eEZdLTj74+2rmJiIkul9Uoz24YbVABTe
         NwuILiEupnlx0SayCNSlU8wcB0UW1skM+olUnD8LKGHhzfDgqnN1zWV7vVFiLH4GkKD3
         HsqXl1vZz0R5qJ1HRCy2u8CMS/fIy5kbpBiU4fP3YfiA4PVB/XZN3tcqHrR7ymaFLssA
         3xegW9x56gl+osABZ0njZ6zdYmF8G0RPKugfbRHRFdUAvArC/j27AC5zXr6oXkf7XARE
         5tGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706688096; x=1707292896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31HHx0QgCVuAgnQ4tzCd7Ii1IZudPB4QFu8JKjXKEyk=;
        b=BUkb93YWwF75xxoOlnIpHWcjLtTX2zsk0WtqkZn9uZBZdIsN84OBn3PvTLmZVnnYwE
         0xGNWqzHRKzL3OfIQVwjzFRyo8HXzbXt5n5WtuTOwnY7ES8S9MKNqSMbQwDJK8sfjOVt
         qARz/mr1Lk374ny1GyaDLM5/KIIsJn5J1BqXyAFmmlL+jhEw0XW/bdR89Gt/0QBFeTml
         7TKRcfuDArhMFfmZvoqEewn3FjBnlIdmicUi0CL2DiAFgqLCqbfudCjkE1AuvHGmWv5t
         zc0iI3Pe+5X3UY2mBCkK4w1bMJYuyzZg8/UsJNEQJq29mGilJz3twgpCXuWgQuXPQ+8r
         Gegg==
X-Gm-Message-State: AOJu0Yxp2/1ZSq/kgXb58MeTd1rljACHHO1AqNaSXFK8z1hl1mwNR84w
	IUh8XR1MPuvAcdy/0nWkgSDKyLDcBxtQ3sB4eSnNkM0nLqNRAeMv6M3qmym+PA8=
X-Google-Smtp-Source: AGHT+IEdAof27yhgTklY1BaSC03UZGW8w2/UZ7s+/KaHZPtPCy2fxL7XqnrhdsryXCuvprnRGu/V9A==
X-Received: by 2002:a17:906:f6cc:b0:a36:7bb0:e2 with SMTP id jo12-20020a170906f6cc00b00a367bb000e2mr438749ejb.34.1706688096295;
        Wed, 31 Jan 2024 00:01:36 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id tz9-20020a170907c78900b00a35920de35dsm3678369ejc.188.2024.01.31.00.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:01:35 -0800 (PST)
Date: Wed, 31 Jan 2024 10:01:34 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/2] dt-bindings: PCI: qcom: Document the
 X1E80100 PCIe Controller
Message-ID: <Zbn+XmyG5+X5fm8z@linaro.org>
References: <20240129-x1e80100-pci-v2-0-5751ab805483@linaro.org>
 <20240129-x1e80100-pci-v2-1-5751ab805483@linaro.org>
 <120f24cd-dad0-4553-8f94-c8ebc9413338@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120f24cd-dad0-4553-8f94-c8ebc9413338@linaro.org>

On 24-01-30 08:44:56, Krzysztof Kozlowski wrote:
> On 29/01/2024 15:41, Abel Vesa wrote:
> > Document the PCIe Controllers on the X1E80100 platform. They are similar
> > to the ones found on SM8550, but they don't have SF QTB clock.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> 
> This will conflict with my series, so whoever comes last need to rebase :)

Sure, no problem.

> 
> Best regards,
> Krzysztof
> 

