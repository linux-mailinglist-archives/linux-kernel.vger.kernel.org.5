Return-Path: <linux-kernel+bounces-142797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171F48A3030
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CBD1C23E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E6E8595A;
	Fri, 12 Apr 2024 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rBlWWE1q"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9850241
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931046; cv=none; b=gN3By28HFDbJIUBPCLafSR31aa/2bhQ0ZBByBKTAteMB66Jnwey3mSZ8DbpYoToZ/cDIHYKCi7I82NQsxDjD8gQh3Sj1C2N7Dk1D/mf9uQIedSsr3aviQ9YT5UvyeIwu7uczHCSMTvxViAVCgPyBIuKgD3h927YQ2zOQOSyATBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931046; c=relaxed/simple;
	bh=eHOxBBjprG1o9q20YKJ7kUwj0nRt3ln7D3EachtJXns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeKz8htAfQVo0fnLIQ4Nz2NcgsRzJIkMFtS3fIkLC8/SzSM8Nf7qa8iducDRpqjuDXFDpSGqpjpbSb+wTX/PO97cnzUokdv+J1vbXZCXMSAEKnfzzcTZS9eJmPyGGZBxn30IaYy6JeEL8mvD8askBOBEIXdJpXRSiRTh9DZmlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rBlWWE1q; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d8b194341eso8652121fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712931043; x=1713535843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHOxBBjprG1o9q20YKJ7kUwj0nRt3ln7D3EachtJXns=;
        b=rBlWWE1q6NfoF3GrYH/TPnFaHUUFERtFTSfCaPJik+DS2dQHUaOk5h6JGOTX+BBH6T
         YbWHhhh0u/7eFUoV1XNfHltCGOTDFgbJyb34L8+OpZXzmgwrP0KJ09EXkTVre81+WUtE
         LFJAFIVXJFaro2PS+P5cVnEQhqP1jCxHGOK4JJ7jh7Cc7f+riB02VHFD8illW7+91l8S
         s7aJLaQ4IY3MlcGlcS+UUlR3+4uHtDEbBgnlA2oVX1fBO6mwnmn+4INz+lWV10lMfYPq
         do5ne11J92XxEZhPJDBkkzcugshV3hf5ANp1ZH27xX7i2U/4dunSE0OJ6y1mvD4Xv06E
         UMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712931043; x=1713535843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHOxBBjprG1o9q20YKJ7kUwj0nRt3ln7D3EachtJXns=;
        b=u5UxgwBcaiX7MZmqPVqQG1durmLiVtAIPqUHGnsfr5FRlNAGpXX65WB6fhyM2plfgx
         oRiQJ8O+QlpIdKywRia6jQds7FEz6ZrnxDWtGwRxOEyKp0i8IPMG/xWZh8ghQN45Fzhd
         tc7lVNDh64tFsJuqf1JE9omVb6uPC9iP47KtM3FJbw50346Q9vZvnqQsaD0xX5A8enP1
         A+PjNV4p+BpNv9CN0kY6gu/skZghKCQ7QPSXZyymFA5VKlCLHDhK1yizOEV8B4weuMbU
         9RKjhNwJ+s9nnKskTXS+llPJCRtoZOCkGJO1dmf+x0PtxE9dmycstAZ2Dq09zA8oxhRM
         LYpA==
X-Gm-Message-State: AOJu0Yzt0MAGoj7gEqYAtXxqyfS3lBr+KCoEppx8WDd0yEXQ/c8MrF7f
	XbPZNIRJ+GBhp6Rzneirup7Ioek0qrsSkFuSYtRsUWeazr65mOBS95ZRp8rthL9pFyEFOXaBlYa
	t
X-Google-Smtp-Source: AGHT+IHyq3RMCDUQZpF6XlMLtN0BgTnEUVKgIFmC4s6+esqCGkM831cc5336wcimG7a0/J47ls3jvA==
X-Received: by 2002:a05:651c:1502:b0:2d6:b11a:3a49 with SMTP id e2-20020a05651c150200b002d6b11a3a49mr2011608ljf.9.1712931043031;
        Fri, 12 Apr 2024 07:10:43 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.35])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c3ac900b00417fea53331sm2109184wms.24.2024.04.12.07.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 07:10:42 -0700 (PDT)
Message-ID: <7657fab7-f925-4c32-8bf0-8513b51b06fb@linaro.org>
Date: Fri, 12 Apr 2024 15:10:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 6/6] mtd: spi-nor: introduce support for displaying
 deprecation message
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20240412134405.381832-1-mwalle@kernel.org>
 <20240412134405.381832-7-mwalle@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240412134405.381832-7-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/12/24 14:44, Michael Walle wrote:
> Therefore, introduce a (temporary) flag to display a message on boot if

Fine by me!

