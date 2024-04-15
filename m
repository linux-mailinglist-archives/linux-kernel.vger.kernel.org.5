Return-Path: <linux-kernel+bounces-145935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69128A5CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6731B1F22C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7B015746A;
	Mon, 15 Apr 2024 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax1KleYq"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB50156F41;
	Mon, 15 Apr 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216634; cv=none; b=Zg6yEyvfKDy3hWy3Qb2eUnKOFhweD29uiWdgNsuOVy6DsCm+qNcfD73H6pYJrwZI3PLnkkCOcwE7iN1Cupb23reELa2eTTsYA/uQo9IeKDfBe+OaOnW5BXSMRyNa6NC5hyuZNU7Qg9LMMx09bJ1SBhBdwthik24jbXZOBl4IO00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216634; c=relaxed/simple;
	bh=JtZ7+KtyDK1OPu+K6I7cSseOL3/7Hx/l6JUARwK22w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axkiZ1gTlycrKWwcvN6+j1JahfZdwzepbZbpJVQiq14FJOctwjpqGTMdgNBg1zsISJVoElu8ruFNO9exEJgbyHnXGihfauhFc38JhmUKNyBUGdB0su5X79jMNO5MgCM55ahA6JW+JUMpB4FVDxbNf8dQiE0TDBWGBTz20b/fgeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ax1KleYq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4187a98705cso5914435e9.2;
        Mon, 15 Apr 2024 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713216631; x=1713821431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3UenIt43MR55osoDYYHxgKVrMxBgUF9iSo5nPwqTj4=;
        b=ax1KleYqc6IEbBerqLbK/9nIBpR9ieuFFOMCgDL2mC3yrZKyuHIjIxS2PjjFZo5WX6
         y+FqiO6lnqVAlQHCej3Ov99L6DSC9HhJkwKHCgDadDeGmomfAiGj4ZuoqLF2/KsR6+zB
         hYN52ypJRa1h2HftP+LD45L8tkg/wqA/C/QalP23gQ9tZiBlp7eJ5GEuV7tsc5WYX7VX
         D9kp+OzJKTIamoyWu2HzQR3GLseih4fnAd5nz7sWFvFM/3wcZuJPUz6n/kH4CC3XlxA5
         lOaQuAhm9i/wdgIP115gtsgUva2jG3OCKNWWJJrC5aEqHjzKHxz4IWs2YDRbu4zNQIAP
         QAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713216631; x=1713821431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3UenIt43MR55osoDYYHxgKVrMxBgUF9iSo5nPwqTj4=;
        b=T+9ARL3b/KE5jUq/sf6oFLwlCsuA1lt0KlnLdVq4lY8U+5ieH4LzPk5/MHRp4zwnIr
         1GQzJIvymMnEI8bShbhrUcnbIB44/IRrsyGzJLthSfwbT7EvuCvJSt4uBNuK/KWBgchc
         SactsUYDgE7DGIzhkyR7vXmOAVPkWsKiUhH2zZHqh3THOklNV6uRgHPqKP55TqDjnRhL
         AYR3AaUZIP75jjUwh+7G1v0AF+QXyIUugwyRG7zaC5+y9xUMiNHNWxWPzKz79X2mucUD
         CVGgMtu/yuN+i/M2niN0Ji/XwWWaDaRUQGig7Fpr/O/J7no0zV5GetL2YT+pdtsW+puq
         63qg==
X-Forwarded-Encrypted: i=1; AJvYcCX7ZRt/WdIIHHFGbQB6wby2TFbIFE92Wn/ZtQn2Tb/6K8rq8ukMxnGLEOOrDs4uttnApwSlBnyLEN2puKIiH+ppeUkUHv5ksYGJyJf74GlJO46HdQ74NdfGzGk2uGnxFRbyJBXr9JnT
X-Gm-Message-State: AOJu0YyNSO+BIB3iip6xd4DXCQmQupXb0yH97Xxjs34ifrs5PJNmIiYl
	BmVNzQ2YifXF5EZJ/+F4S6JMu0KgnlIPNiGJEzzUwzShLRXyzYng
X-Google-Smtp-Source: AGHT+IEwUBu5rbeR+NG06wmX6iS00FXzbXScxtwmPHMX9rL9YKp0y7tJFVOwnT5Cr/tvT+wNXf43WA==
X-Received: by 2002:a05:600c:3b25:b0:416:2a95:6e8b with SMTP id m37-20020a05600c3b2500b004162a956e8bmr8060461wms.26.1713216630661;
        Mon, 15 Apr 2024 14:30:30 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id c10-20020adfc04a000000b003467a420243sm13145756wrf.12.2024.04.15.14.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:30:30 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] clk: sunxi-ng: fix module autoloading
Date: Mon, 15 Apr 2024 23:30:29 +0200
Message-ID: <5929348.MhkbZ0Pkbq@jernej-laptop>
In-Reply-To: <20240410155420.224157-1-krzk@kernel.org>
References: <20240410155420.224157-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne sreda, 10. april 2024 ob 17:54:20 GMT +2 je Krzysztof Kozlowski napisal(a):
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.  Clocks are considered core
> components, so usually they are built-in, however these can be built and
> used as modules on some generic kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks!

Best regards,
Jernej



