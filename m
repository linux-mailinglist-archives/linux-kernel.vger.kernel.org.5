Return-Path: <linux-kernel+bounces-46492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CBC844085
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D471F2BEFD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586B47BB0E;
	Wed, 31 Jan 2024 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL+jpWWN"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217D7B3E3;
	Wed, 31 Jan 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707593; cv=none; b=fDR+8dMinQgec8ZdLY7X9VnlPyT9A7bIIvE768lWKahu6U0EZ5vYaOuS2KNJqC/ZnbFon6aBGLgs31GtmoU8C9tNBk6GNLNZde2Q6TDOgdFJMfyI/gddRNH8jyW2QuYlxHJJ4yagdZ/us1aTMxJHNbm5Epjgh6eGeEJnQuT1V6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707593; c=relaxed/simple;
	bh=lfOvCFrHQ69zgWnXFl1gLZxV4g1EyXYY1h7cgK9lrZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpaDGPSUo5YF9cBHNKbDu9cE8WMNChofdQ02Jb+15RXDxfPS7948kks7Z6o8io+V6jqhlo+oIUTzDEOzrG6hL/I62XPWdaW2gmL4F57YK/we4fAUjEs1Vkya/N4Pd/czSDxaiLC1uqxEVeGrRgI0zIfabIRW0xQaEhYNW6OJRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mL+jpWWN; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59a7682486aso667569eaf.2;
        Wed, 31 Jan 2024 05:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706707591; x=1707312391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1rp8HKmSXYoNC7+PpkJAkyq8m3dFpYfKxXEK7CwfrE=;
        b=mL+jpWWNRUzdQPdzgUPOyzz6iGLIUQvUPwFdkyotvI83ZPghQgLYc5SHdDrhVnZ8iS
         n2N1MaKUdmySdd0nKJkxiunymSNMIVPSt9EPDiS91r/qXYySBVhEL/VKEip2GKEMOxup
         NliS+b5d5h4H+GEIKmRjHAstb076U62tl0VzNkapWvJZqzNaKug8mRJqX8ZV071tgb1k
         bWGFrVzTVm4bhIBTzylcZi9Ib79fLNQe2anvi6jppntcCFmfj/yEh8bvG3ahgSatixXi
         1Qnz6a4Uddh/+V2SO8cBMAJU+cS7TmXdDFTnBX8rjOSUotme3gxF9KmzxUn5QxyfZ611
         1DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707591; x=1707312391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1rp8HKmSXYoNC7+PpkJAkyq8m3dFpYfKxXEK7CwfrE=;
        b=RPTwgHc5rQNEstEjUytR3O3eIMDtG8U5yLwFN4ImuXfg9eeXKae9z7e8aGQhPLFyPQ
         sT5jrmlYHjcaWCsFyTfpVmm2CpVDVGb2tHqajd1LbU5g64e8GaPrFoPIGOhY/ClqRpav
         0c0sKr4AkezQiz5ruTJAEfJUgVclsuo4JpCFm7GOjgJh3JMSpWdEdqbanPB1Gk7tSuXC
         3DxD6GWT72haxMSlCcP7I3s0ELiP7WVFRyMhbYt1xNlQiMGAVoPf+ReZCKJ/4gH2OZV6
         ax5mEuLex1iMKzX/sU+EnDQu76jKGoirw+0b4QG2PUJOqPQep+Pqz4Y/2rfLR19J3UtA
         cpGA==
X-Gm-Message-State: AOJu0Yx25brt/JZ1e9CzTV0RgISMweNc35b+cCD1fHMLKF/upp6GaYam
	DX6KXvynM9MiWEmAa6TJJjav9R96qRNOyOtPLS/JvmbIljo9SsrF
X-Google-Smtp-Source: AGHT+IEZt+D8U11+P06gzdHniW+92iEbClu62LwVc9leCBWLVDDh3ubpzHrfBIrKExvFtxnCB05q/g==
X-Received: by 2002:a05:6358:e9c5:b0:176:d552:c681 with SMTP id hc5-20020a056358e9c500b00176d552c681mr1438991rwb.21.1706707591128;
        Wed, 31 Jan 2024 05:26:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j2-20020a635942000000b005d5445349edsm10274977pgm.19.2024.01.31.05.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:26:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 31 Jan 2024 05:26:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Charles Hsu <ythsu0511@gmail.com>
Cc: jdelvare@suse.com, corbet@lwn.net, Delphine_CC_Chiu@wiwynn.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: Add MPQ8785 voltage regulator device
Message-ID: <d86f96ca-ec28-4524-b1e3-2e6d2e9f7c07@roeck-us.net>
References: <20240131074822.2962078-1-ythsu0511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131074822.2962078-1-ythsu0511@gmail.com>

On Wed, Jan 31, 2024 at 03:48:21PM +0800, Charles Hsu wrote:
> Monolithic Power Systems, Inc. (MPS) synchronous step-down converter.
> 
> Signed-off-by: Charles Hsu <ythsu0511@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter

