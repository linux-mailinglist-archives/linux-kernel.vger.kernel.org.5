Return-Path: <linux-kernel+bounces-63753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D3B85340B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426101F2A2A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6895B1F5;
	Tue, 13 Feb 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rr9W2xZS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qrlQe9hi"
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001D658126
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836406; cv=none; b=NqFe4F9AEzU23PGTjWn/gflczV8ajWaqlxPQv/o8jyqfqqlpuw6huDmoGsu3gyleHXValhFLqhCgOEbE/kJEkUWqXMRB5n7XMnA+oFidPQsmxdp/7DIyFWmhQ1IWvHL5eg0xnnkA4MsApYkY4e2jNyzAjY71BNdgkAcOW2erKeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836406; c=relaxed/simple;
	bh=b3GC7jyyEFRSCBa5nAtN9ZbRd3Xebqo4L7wCHwOMklY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=pOmqaskvvatQX4tVIg9yjLCJFpX77lUWYnswUHJ9GymdQBsNhX9hc+OdP0bhcxOia/kJXmm5ow7ETQRHI6nLY9FH4L5QwfDSxupY4KA/lb7jozb9/M6iFlnaFUFgCWkq5CGpF74Wfeq5T+zrko7eXSsGUXGjSt9plbJKI71bpjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rr9W2xZS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qrlQe9hi; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id C02C118000A2;
	Tue, 13 Feb 2024 10:00:02 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 13 Feb 2024 10:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707836402; x=1707922802; bh=mlH1+joGCi
	tNuHIq4NgYcD03PcGWwGsVclCAlzSrC6g=; b=rr9W2xZSRfUYXJ1K7Er8kmSzdr
	YPeVZLRDo6na4KI7s6Y318wy1IvOOGMs1THUmpkm21w2WCSEUmC+Chh3StFa07Qv
	rzXFAC5qVpLw9Mshgct0qFN/zt7LuKANbNJ0tGGHSCiAEmx5NdQSO0hzEpkBtRJN
	HUO1aDpNc4CnRpq6BPyXwTlW9G+bWMkj4FnQwv6LpizCOSjdzI1WBwgW49J4ZP/Y
	I0gZHBBKNC129t7BmBIzYT4sF5no8DEUiH5Iz6/PbmRaVJT8/lTyRbSymjLVlJob
	DJbPwgh+2m0ltbI468PxpuFzzBVPimmGePa+2TremYQfBKJ9pcRnVLYOEOfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707836402; x=1707922802; bh=mlH1+joGCitNuHIq4NgYcD03PcGW
	wGsVclCAlzSrC6g=; b=qrlQe9hiFEDFUkxfTxKpqQXl1A2Bq8hi2c/1LQL2jgry
	F5rWnTb6GhLifUWVur74iuEDk8GglPoeczz8klOKnphJEBFhxBxyj7YglEbtiZV7
	AP3glPNibTQvL4K6Ti9KnxQBWT6Vum/2GZpRmaavP0yDET4aXiZE0fHvKyHN1YzC
	YUmuMOyUAJVEdZV1a+Z/eGVBq/j+0pjU5R/p2U8wYv63Mu0SiZ+LeUlqGxy8mp3E
	PE8Ha+l2Gl9zBhylnYu02tvQVe2vdQoyaUJBFLQ7Zg7kLPgdcDulF9jtyms9Sckv
	9iMF+lqcxL+6fscH5907nH4SdJUg0eSLCU3wYEmfEQ==
X-ME-Sender: <xms:8oPLZfdBagPzDr-BidswenT34AnrvC6dCbqXR9HZDKRU-CR5JkpjWA>
    <xme:8oPLZc-DANaknlX0mZiSM3K1Eq-DLM0np3W1F7FRZfdZpYrGQBfHZCNIzCPvlMiLc
    rp7QeMBl7b2XKgOfis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:8oPLZbmU2QNrJ0fAgSkM6rHa0I2O3WxpSTvUPlkvoCSBkuSQtC47Ew>
    <xmx:8oPLZe8JYLKbxo8YrcGec44O_O7MW6_YVur2RhOjIkBa2Tw0GH2tOA>
    <xmx:8oPLZZn-9xMDTskIOouTC9d-Q7ATz3fvGN2KUnB0itJFUgpN9iTJlQ>
    <xmx:8oPLZcHzVescDf5TaVO9ExVYeNrw0RJ6eYRHYOjgK6KZTPF5QqqFPLb0AUI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 28D58B6008D; Tue, 13 Feb 2024 10:00:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5448aaaa-3784-49c5-bc42-c5cd1e953949@app.fastmail.com>
In-Reply-To: <20240213142831.3069049-1-jbrunet@baylibre.com>
References: <20240213142831.3069049-1-jbrunet@baylibre.com>
Date: Tue, 13 Feb 2024 15:59:39 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jerome Brunet" <jbrunet@baylibre.com>,
 "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Kevin Hilman" <khilman@baylibre.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] nvmem: meson-efuse: fix function pointer type mismatch
Content-Type: text/plain

On Tue, Feb 13, 2024, at 15:28, Jerome Brunet wrote:
> clang-16 warns about casting functions to incompatible types, as is done
> here to call clk_disable_unprepare:
>
> drivers/nvmem/meson-efuse.c:78:12: error: cast from 'void (*)(struct 
> clk *)' to 'void (*)(void *)' converts to incompatible function type 
> [-Werror,-Wcast-function-type-strict]
>    78 |                                        (void(*)(void 
> *))clk_disable_unprepare,
>
> The pattern of getting, enabling and setting a disable callback for a
> clock can be replaced with devm_clk_get_enabled(), which also fixes
> this warning.
>
> Fixes: 611fbca1c861 ("nvmem: meson-efuse: add peripheral clock")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Perfect, much nicer than my version.

Acked-by: Arnd Bergmann <arnd@arndb.de>

