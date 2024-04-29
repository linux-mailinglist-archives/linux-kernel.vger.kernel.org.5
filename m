Return-Path: <linux-kernel+bounces-162400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CC38B5A99
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DFFFB28DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6697174C08;
	Mon, 29 Apr 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="unogiTDc"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C95745C3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398763; cv=none; b=KWO6AblVViNm4ecdefYF0izRSccu5wyCQqu54GIM55eggy8U7f8scnEIl9yrx+xQv7AnG/kHvQ5n5aalYQUItGz33wc1cAofb3ERNO2TG0Nmr1DHCdlgEk/gwt+lwgg/3Wxo+PsgRnfTZkgWWOOTuaTbSjEYX6mGy2z4KBhcNw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398763; c=relaxed/simple;
	bh=AsKCtbhh0t38BAJJdTfdKeBFCuozd2y8Acb8XDQyUhc=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkCTHdlk88W5NO2TSxUn3RC1wTMhwWaTkrHGpYYWO1zuTQX0gKwAHioJ/njbxZitONFHLksfYQndVjvv/aqRv08/P6jKbCwqORJiyOVBCiou7Qzl0J+u3Ew000hU+q52YdxVOSuDX6EusvqhhWSN1MTyzrH1/F5l6ODglyQUJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=unogiTDc; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 01AF93F9A3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714398761;
	bh=AsKCtbhh0t38BAJJdTfdKeBFCuozd2y8Acb8XDQyUhc=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=unogiTDcmDl/y2u8DVdqOH8XQwmI0vrnsgHqHwvlyfGQ7yHck9dRekpPau5JqG5h9
	 aqiOKwL/RZR0ZwYJ1Wf91jpGH9V8D8kpiv4SMGaDNMfTpgT0MCX8mRQ5VV9WUm54Rp
	 A347ZP70XOzwIjFKrx9/wZSwmCgMqewtxf/KPP5kTNaGmed+JcyZ0nLDpRqTwTl8rm
	 S8irnOm2gIFqIXhW9y0JGDX836j46Tr6aa3HQiAX/vaL0IQjaXs3+jVuxvXwGUE04t
	 bEkU0937v2YeGhV+Df9hV2ZcfE0M81pN+AKUElGQ2KGsLnKQhygqdVbf7bErElvZYE
	 2f2SOSUF6ZHIw==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43acbc2a093so17118121cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398757; x=1715003557;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsKCtbhh0t38BAJJdTfdKeBFCuozd2y8Acb8XDQyUhc=;
        b=wnKc5AvDf41Zz3nQutxAhLzDLOyN3vVL4hk4MO+nfVBC96ISFN9Th4FJsCvIBw5C/T
         txFR/WuIEVfwT+hwWEIJN08QsY92G/2hI0dHazeJ+Siot5SPJj2UBrmx/qQx49jruSr0
         x/e4s0+q+oXsGhgKsCuHYQZKG90DR1T1mR/aa5dxzNNZeTAtHxh5jNtfmIdDFUgAmpSl
         ZYkr1azHmS9O0YQnbMblB5jae0gG9aoTI/je7DDEwk89EAekQCuRU6JxJ9F0v5n5PURQ
         FEtlS8GKGQfAbVcuswykopliOj+5nw9eq7JBdr584b+hqNlhGf+wM+736aNAeIl5oISI
         f9iw==
X-Forwarded-Encrypted: i=1; AJvYcCW4B0xW3VhVLVCvM78kt1UDAB4UuFzKPnT1I9EDvnHD5c0qv4YvJAvPsvLhJcqngthm4aPNeDe8lAkad520+gB8myGihkpd7tsDZWX6
X-Gm-Message-State: AOJu0Yyxqm62ZwDiLdRhYvsD5QICqLu5q7uAwJjsFhzlCj2Gotz4TqZD
	xX53X5c2LV9QABd+IendmH2LsjBkLA2PZdhReii+m0fCmzC49GPVRAsyctwtkwoh9CtO14neLul
	G0Fpe0F5FlYHvyKw63Iqv5LbtPK/A536iNyAT0JAq46K6TgHv8wGY3mENkKayayHV+IvNM2zhbk
	fdpy4P8QyLcTcxtAyBpx0BgD1QxA4ztJoJ8myrdM3ivTfzy+OS8g+3
X-Received: by 2002:a05:622a:115:b0:43a:cc86:568d with SMTP id u21-20020a05622a011500b0043acc86568dmr4712047qtw.23.1714398757085;
        Mon, 29 Apr 2024 06:52:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvsZDMj5ez5DEP73GepCyTJCbf25O42FZuiBqqsRrRWXYhRZe9NxVtx5qVKVmEXoQHNABuLQfLBMvNRJ2qSCY=
X-Received: by 2002:a05:622a:115:b0:43a:cc86:568d with SMTP id
 u21-20020a05622a011500b0043acc86568dmr4712026qtw.23.1714398756859; Mon, 29
 Apr 2024 06:52:36 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Apr 2024 06:52:36 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240429001317.432-9-jszhang@kernel.org>
References: <20240429001317.432-1-jszhang@kernel.org> <20240429001317.432-9-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 29 Apr 2024 06:52:36 -0700
Message-ID: <CAJM55Z9Q3sm=2HPoa5cWh8_hn9xCCgxy+v7H4y9n=jWzhCKdbg@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] riscv: dts: starfive: add Milkv Mars board device tree
To: Jisheng Zhang <jszhang@kernel.org>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jisheng Zhang wrote:
> The Milkv Mars is a development board based on the Starfive JH7110 SoC.
> The board features:
>
> - JH7110 SoC
> - 1/2/4/8 GiB LPDDR4 DRAM
> - AXP15060 PMIC
> - 40 pin GPIO header
> - 3x USB 3.0 host port
> - 1x USB 2.0 host port
> - 1x M.2 E-Key
> - 1x eMMC slot
> - 1x MicroSD slot
> - 1x QSPI Flash
> - 1x 1Gbps Ethernet port
> - 1x HDMI port
> - 1x 2-lane DSI and 1x 4-lane DSI
> - 1x 2-lane CSI
>
> Add the devicetree file describing the currently supported features,
> namely PMIC, UART, I2C, GPIO, SD card, QSPI Flash, eMMC and Ethernet.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

