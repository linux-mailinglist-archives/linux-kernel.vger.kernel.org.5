Return-Path: <linux-kernel+bounces-151989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFD18AB70E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4815283161
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2E713D27E;
	Fri, 19 Apr 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="gcbcIqn4"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D44113D24C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564344; cv=none; b=iD0HbLS6+s52Qs97bapVGmo3tR4Lc6Opewq/4p2FWjEUIYnjS8Ndj4POFaxvEJeOrfH1VEoULbDnpvFdUFOCMsSsf6AwOKtmPWOgGyATZ6aPUl64yIDtKEi0+OTwHUgNGAEQNuzv+UaHULvZWqJcXbMlgDVgt2Ea8cxtAY0WejA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564344; c=relaxed/simple;
	bh=iwngIHVe/4WMng29YbmuBW3l10hwsKwRmw0uFrHNG3g=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lc3wURZXJpO2PHRzKcO5L/1hQfWiw0wc8Q/vCUp5GCoAPkTpYqsOSOBExciplnu7HYU2B85YjTKxEnUtJTYOJw9lMbdLwCh3hR4gnpwo69itfMQdIKQ+MQl3igd6/cTL3S3uSxeiZpJFk4+NBeGpLOhQ3p+vNVRI0/KRmRUJOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=gcbcIqn4; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 817A33F182
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713564341;
	bh=iwngIHVe/4WMng29YbmuBW3l10hwsKwRmw0uFrHNG3g=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=gcbcIqn46I9Ifp2C20JlLfkg9yD1agLD2qFYOfjgOWbYFabCUkr+BJth/xJyMTzRQ
	 QBMapU23t3ScyTTKfGCAveM1bj1r9B1HxZwuyTB7r53PmcQKTDxryh8l6URZpgPl7l
	 ey2Q5ign10t6RdzsBNa5jnWmIhocFSMtKBCeHpD+wESgATH4XzgeGrmIBTnMyHuBK4
	 sjDWzXnRHzr3H8aGlrauvUJZOCwcYztnqCSRCBQ7Omq0g3sAd2M4zp0U7AO6cW1arD
	 wEXkqo3WofDfZqPERR+5FEAiMwONg8TNUruf5W2mSccyuG02htFE5pGxhzlbqRP+1a
	 abjbvplhUhHeA==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4386bcfd788so14119611cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713564340; x=1714169140;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwngIHVe/4WMng29YbmuBW3l10hwsKwRmw0uFrHNG3g=;
        b=Ug1iOeo99ek5I+Nv+OeymKzC45LWVoZK/NvsJ9pmir8GQGwCLUGFPt1r4w/omw770x
         HolmGiIFRVf4w0Kohmlp8Ly92WkR8OLgY8EgFny0QHEDhktTi1mbiE2JjqObFPA9sR9Y
         WDHaFukh+vmw1r4t4tb51pgfSWnGnABBIFkseL+AXe10hiJBYaV0pLJlCZ8lre9lDaJT
         YHiJWhcpV7uD+NuXssVZ7jMj9/4n821fEQk4f7I8svb7FanGKYmr4LIXyjP4W78o6+nn
         JGU661GAxtym/vjwaxiztHzQ36gw4dC3WNFmSShtVjjvAqvSPZ1ReHYzuMO6kL2NOEuR
         sMPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/tWsbQnz8lioHFenFd2Tjfali0eqbjx/xw+wg9iawFvEIqH+Q7u/EOaucXf2RSm0YrXDr9ymtL9gtbadr/7rAZ9Wmdp4TAwaaokmu
X-Gm-Message-State: AOJu0YzTxbdN1DfeJXWZdp7xAQQ/YXJBrgi5jI0clNcVORMc1GqC/qyn
	KrvAZZDXGrEClkW0wBD5rbGLlHZ2lY+z7N72DFjl+bQe6QvEP3JIVQt9YoGHSkuZmefiY7tji0o
	F9EWRPf498C/yDP5EoK1673v+HZ5LRT9pmMXbLQyJBXYlYz7Ue2P2U/84lZ2R3WpNyKSrRmQghe
	cdGUiVBoGRCKrFYf5l7eQfpNYyJQtu16GwnlS4AWcWzqA7QkOVolWh
X-Received: by 2002:ac8:7f49:0:b0:437:9bd0:238d with SMTP id g9-20020ac87f49000000b004379bd0238dmr4129621qtk.22.1713564340584;
        Fri, 19 Apr 2024 15:05:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmEg+HVg+ogQjxyJhDeGsv+9YsDoiouQKoYCIz1StpTBZ3JL+7PlHMw1o8Asrj+tWGcBMAdZHSHh3NcsI9BuU=
X-Received: by 2002:ac8:7f49:0:b0:437:9bd0:238d with SMTP id
 g9-20020ac87f49000000b004379bd0238dmr4129599qtk.22.1713564340345; Fri, 19 Apr
 2024 15:05:40 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Apr 2024 15:05:40 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240131132600.4067-5-jszhang@kernel.org>
References: <20240131132600.4067-1-jszhang@kernel.org> <20240131132600.4067-5-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 15:05:40 -0700
Message-ID: <CAJM55Z96TnvHNwN5JPKLYywO7eiRh54dJSaFD6Avsy3nmM0bjA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] riscv: dts: starfive: visionfive 2: use cpus label
 for timebase freq
To: Jisheng Zhang <jszhang@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Jisheng Zhang wrote:
> As pointed out by Krzysztof "Board should not bring new CPU nodes.
> Override by label instead."
>
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

