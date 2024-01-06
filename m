Return-Path: <linux-kernel+bounces-18684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673A18260F7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 18:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E19F1C20D74
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5796ED275;
	Sat,  6 Jan 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="logIENqj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68BC8D2;
	Sat,  6 Jan 2024 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a29058bb2ceso57242066b.0;
        Sat, 06 Jan 2024 09:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704563830; x=1705168630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ayftTtZ8YCt/OAxuOOsBAiLw6iK2Sj5mQxrpX9AKLaw=;
        b=logIENqjSge78w2n9nhFL2HY/0fcCuYsu6Uen0sIjr8/T93q7dLaDTE8Gprdl1kcb5
         yoluJaoObH9w4gk9dfh8fCy4ImIdWKCNyWsRfXKYAqUCGi/1dtnh9LNVfgxDoHA/+aK9
         e+cq840AaLJ6Dh4IKGLwVD4eea2IB/WdwUXwDdYrbQtBwSt86KMYUg/G+YUyf1qDT5Jk
         inq2zKxztAom4AqP2wSxQRLguHv5eep2CKAOuYM/ecqU/ob4xnH5tomMT9ojPcdWTejV
         1Zv9AbBmtvgRYVktblnO2AxlYqPUfhkg2lvb7p5fluBOEPFkgKaUx5jSUjjNKqC4YNVR
         jR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704563830; x=1705168630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayftTtZ8YCt/OAxuOOsBAiLw6iK2Sj5mQxrpX9AKLaw=;
        b=TWxOTSKANaF4SW2KmG/TtkKAT0zDWlZ1u89nyuaOJXOxDck/wGoSwAdE+ir6jO4eho
         /AIKhYwcfgWUMeKhxnhoyKpeUyGpHje3E0irhZOoHRLNXRtrF9hggZS2uU0yXTwko3If
         c0xGhIAlkyZ8R+044pvHV0NfGAGBwLBDAf33PWTNDdzvEUJGJ5NW+EtdRDnU1ciT0jpJ
         +6CCSLlBUwuaKEFOmrlLLjl0yKCDGgr9wwbbcFgrYtxWVe0rFiQydPqYprYWVlNSGwM3
         3NzdKSBoQL78JhopibZGRY/aEGiGbrPq2ZmSyb8MnJDKO2NjfDc5BD0QUQTBNiQcRdm+
         UtdQ==
X-Gm-Message-State: AOJu0Yzt6PkPfRk0pCdGtK0G9AFwkmMCBPKkRfBoJ63V9HWkYxgJiwJM
	UxaYVzyDqaJt5HWakIVVA+Q=
X-Google-Smtp-Source: AGHT+IE0uN+TM2n9f/3lN6P/+RkP08uWhdbyAD7eRYSJ5p0Rqs2uEymo7ubCJiBUdy9bgfh0fTTKdQ==
X-Received: by 2002:a17:907:bd1:b0:a29:1cb8:46fe with SMTP id ez17-20020a1709070bd100b00a291cb846femr280946ejc.5.1704563830130;
        Sat, 06 Jan 2024 09:57:10 -0800 (PST)
Received: from cjw-notebook (2a02-8388-0502-f480-6c32-186a-368b-d6a9.cable.dynamic.v6.surfer.at. [2a02:8388:502:f480:6c32:186a:368b:d6a9])
        by smtp.gmail.com with ESMTPSA id m21-20020a1709061ed500b00a236378a43fsm2179351ejj.62.2024.01.06.09.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 09:57:09 -0800 (PST)
Date: Sat, 6 Jan 2024 18:57:06 +0100
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 0/3] w1: add UART w1 bus driver
Message-ID: <ZZmUcr7Ct7g42PD2@cjw-notebook>
References: <20240106-w1-uart-v4-0-7fe1378a8b3e@gmail.com>
 <1aeff309-6867-4296-8983-a60e8fd31614@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aeff309-6867-4296-8983-a60e8fd31614@linaro.org>

On Sat, Jan 06, 2024 at 05:56:34PM +0100, Krzysztof Kozlowski wrote:
> On 06/01/2024 17:02, Christoph Winklhofer via B4 Relay wrote:
> > Hello!
> > 
> > This patch contains a driver for a 1-Wire bus over UART. The driver
> > utilizes the UART interface via the Serial Device Bus to create the
> > 1-Wire timing patterns.
> > 
> > Changes in v4:
> > - rework baud-rate configuration: also check max bit-time, support higher
> >   baud-rates by adding a delay to complete 1-Wire cycle.
> > - dt-binding w1-uart: specify baud-rates for 1-Wire operations
> > - Link to v3: https://lore.kernel.org/r/20240105-w1-uart-v3-0-8687093b2e76@gmail.com
> > 
> 
> You can slow down a bit. You sent v2 too late to be applied. Then you
> sent v3 and next day v4.
> 
> While I like approach to release early, release often, it does not
> necessarily apply to the bindings. Bindings should be complete, which
> means they should describe the hardware as fully as possible.
> 
> About the driver, you can develop it incrementally, it is a good idea,
> however since ~rc6 my w1 tree is closed. It will remain closed till next
> rc1 is released (merge window finished). Nothing will get applied during
> that time, so if you intend to add new features, better to send v5 after
> the merge window (instead v4 now, v5 tomorrow, v6 next week and then v7
> after rc1).
> 
> Best regards,
> Krzysztof
> 

Ok sorry, understood - thank you for the clarification.

Kind regards,
Christoph

