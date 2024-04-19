Return-Path: <linux-kernel+bounces-151987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DD28AB70A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FFD1F2253C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6998913D281;
	Fri, 19 Apr 2024 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qCJAg+8E"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2319D13D272
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564298; cv=none; b=lzPRcUZhlfQsBN+Z1m1MZbbGBfiPJHy245RjShttiseUkvA+Piq37cpUhGWmzrUmul/CdARFE4Cja/Pgrp3YVUNRXlakSrj/TOQL5cHVFRF0Yz67sUqwh0AyzWqqcVo5mpMbqRCNJ6rRk1HV47csjItqB64iAuX6aR6FeP6moc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564298; c=relaxed/simple;
	bh=59fbk9mdCDiZMMkdMPp9YypNs4kQzE7DiAt8CISNemI=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3ql+uvMcYP1F1mobnoS3wx74aHbBGqvNXgfF86jkATcHL9HTKKt+VwdIehaFRf+7jJqennYZ1cOzwfUt++8YHEGQTgOJUD3pkl+Ww+kbo8GY8W+ny8An6J7au2+XHE3eBmyGnXFnMb9I39/64fOErWZCZy1sXCPhl497Ug5ubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qCJAg+8E; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 31D333F5F4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713564294;
	bh=59fbk9mdCDiZMMkdMPp9YypNs4kQzE7DiAt8CISNemI=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=qCJAg+8Etkoy6vmMRivxlaiXKKETVib6sq29VUUmX7GlCQ3+Og5iqesY94w+flals
	 h8v4kXwMmVVzDHwal45sgD6v9UXBScRMJE6Y9gBYorJdcGhmrnsgHNlcPnsxgzf7QC
	 5zms4ChiRRCjg7ujPclj74PR3HtASp83Ubpcy6A00OepA4+ZrtbD2NAp2AwwiFy2DU
	 yWdmNiySi+CSv/fSRykyemLWf3c3aRHLwU0z3xqEnb27zSkrutOpQHXltc6bhgI/V/
	 owZYrKK7DrwH4kCvQTDcB35fGmjXiJyrNQaW0Pp7G+na0up/E7vWEyfN9haMh6uwat
	 e2NRwMAbNkU1w==
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6994084553bso29641686d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713564293; x=1714169093;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59fbk9mdCDiZMMkdMPp9YypNs4kQzE7DiAt8CISNemI=;
        b=Iw6l2JbUkrlWsAwyTJt9vkzpiBVpODpgn2UY/DNnAJW+3Egp8vVnL4CaYNn4BJWLdz
         8Zr5EECMl5lSTKsN1Gj/K+0TLTAoscgHosdWZpyfANuhbNQkk73zW0YoHxYgF6JFw+5W
         On5ni9HTTviDGhz/BmvHpI8MXX3cddWXlwE2k+nD2kJfIqU0yvPm+rHUITJxoO7oB5m2
         Eb0Mh68anl2q9unJCfUCvp2I+BCrREaoN1Lfd7daULhjHXBdzU0eB93FZWQ1ujtcakzX
         4d/+berJkgzI08LwKW0l6TvvNr4UCRc2SsRCoraJhXZ93YE47coCOaYfe7Eda/ieiGgF
         f/bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHNHA/O3x7o/CKb6UYOoVE6c8SIBOyPDpSKXHxYQlARFRrX4x633cf3SuhM6FaBq/Nyl2hMgqckAYG9PDuy00JVt/3yQsGES0NVU8G
X-Gm-Message-State: AOJu0YyggxhCrwJRmiv17iCigYMumOm4BbmIxewGgtvrYU5N7LxFwZmp
	tfgzNtfv+RoASk4TpyOZNmyTMUswpEOWCGIP4h8ukXh+eHr2hBD7iymbwGjWtHXGut1uXNZ03vP
	WjigGcB74oyc2MMfgA/a3WCJf0Id9Qbxwow0mL47s+7hmrXdOIvDg1L5IHpmfP59B/EGkbqfHti
	KCy7r9gP8CjVqG6i5bt5dzB/BAKy6viTi3y/cJnqSAuq0q9OaHdL9J
X-Received: by 2002:ac8:7dca:0:b0:434:fea0:656b with SMTP id c10-20020ac87dca000000b00434fea0656bmr3860601qte.12.1713564293110;
        Fri, 19 Apr 2024 15:04:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi3nRK9n4HZbD6JyrijRrJFNNUSTVrZHpqTxSgnaAa2BwTXIiXei42zsuP2X92+g6FGGYKm/L/I58UAPVbBx4=
X-Received: by 2002:ac8:7dca:0:b0:434:fea0:656b with SMTP id
 c10-20020ac87dca000000b00434fea0656bmr3860580qte.12.1713564292792; Fri, 19
 Apr 2024 15:04:52 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Apr 2024 15:04:52 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240131132600.4067-3-jszhang@kernel.org>
References: <20240131132600.4067-1-jszhang@kernel.org> <20240131132600.4067-3-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 15:04:52 -0700
Message-ID: <CAJM55Z-n4N1Mm_iiYngaJ3jrb2eoXTirH0qDXMV=R=QTH-d9_A@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: riscv: starfive: add Milkv Mars board
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
> Add device tree bindings for the Milkv Mars board which is
> equipped with StarFive JH7110 SoC.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

