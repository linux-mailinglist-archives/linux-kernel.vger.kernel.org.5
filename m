Return-Path: <linux-kernel+bounces-65122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA5D85483D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F215E1C2164A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5D3199B9;
	Wed, 14 Feb 2024 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Albkkf6m"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24318633;
	Wed, 14 Feb 2024 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910035; cv=none; b=h7mwgMpTHgcnxOR4SZGmQ90M9SMLpACkQ43zEAOLQagHyp1SBcN+Vzm7482xoZcQo4uyAo8GtT2L7hOinAOjsoAsUDQURnIzn2rwrV+nHWkZYqE5fVOS/fvO/0jzeBgAbShmcjnWtrrKuYC3vb/asCEGMKRTHMRa3oUwJ4bOpnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910035; c=relaxed/simple;
	bh=Y9ZOz9wfhoWTc74GBWwODS9bl4h4+TQW+6+1SJl1ulU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SMewTqY2Lf3arVXDt/CrAH0BePP3WscSoAGHeUU910zmjDF44VaiucNWXjs2kdc9wCnYaOQoVC3blX7D+/z5oSSZ8ZQsO1mHY5CcdJAzuAV1acmhYmeRETfd3cBBACRzfzrZOizbvzdP4MDX39czmQN0iTRAVs27P6prmZv2tDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Albkkf6m; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3122b70439so686974866b.3;
        Wed, 14 Feb 2024 03:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707910032; x=1708514832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvnuYy0h15lFkU1OUHWfDosbzwhtBQMjSlFdPWysW7Q=;
        b=Albkkf6m8knYWt3o0diqeYVjt4/P5VszWL4OGG2KcoZxsh/mo7cjdz2yhaxpBWq7sx
         wrz1QGvA/rg7D2Z/04iG4QogTwTsWq6VfCt+64ci8OH5jnQa3b3UauSVIB7o4sI9kDWc
         0zLt9ldFhzoaaML1jZ6S2VC4gEqolWPYvwpNazNE1mQcwvGGkaGavwnnBVpLsgr4Czz5
         /DM4EL9N/nQKalYUMy56VPK1+M/9O2LWiM7mHlYgchpyUr67k6RyXMPrBC83EsJGL1ED
         uHpRNarcDZT7jHlgK/xxW/OhO/Y+voHYvRItS304c9zE6pyMFSfM3P8XxWlrBEuuOvXD
         OWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707910032; x=1708514832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvnuYy0h15lFkU1OUHWfDosbzwhtBQMjSlFdPWysW7Q=;
        b=QLl+XOUezRYOMJZPL/sEoZUADDSls+OQi88ZCgGIRTUx1wdcHEYvbzzg3h4vuLtriE
         zn2q5bbgALldiXeZKuQ8Pct661APL0oVVbw6+YM/smuInLCKgPrM2oVutdtI/P4F7iJh
         +Iz6sm8GWw/fK7xOL9zXIPRJO6ddNlxqdkzoR4QDvfuL0qO0EWUiEE/7a1i8eWtgDekw
         GVQoE0NgnYYjJOJQyQKLLKCV52ew2aRY0lYDhxXS4h1nE62YR2WF3AuNq4MjhzAXzxrx
         N1FzjDvy8MCClR5am3IsW2r2NlpnhpDE08o9gVbuEs92i8muYaUlPSL+jbjOvO6H6l6C
         VoKg==
X-Forwarded-Encrypted: i=1; AJvYcCXlsgJvH71Y7MSm28tmZEof90EURo1KrkEA7JrwW1PUkzqcx9r4l0xo24NYBe2H3x06itowQ3hwh7YK9v0J9hF7cZ/qMQuyMDR9OXhgDTBxU/LVkwAtHfL0mYE1FSXo5rkJPI0BVi+eeg==
X-Gm-Message-State: AOJu0YzuvcnPGOdMjwPeoEZfA6CzBMrCOK9ECxyur97icAzmOAXXhDoX
	JbnW+bwX4WIFhj/FoqkODBlN3Ckx+CSHF96ht3vnHBKBd+V+5+/X
X-Google-Smtp-Source: AGHT+IEyA8IghOjt0/o24CNEtlvU8Q8EpuH4t5P+6Twv6iElYcBmi65oltjzzBJ6k3JW8qLE3O5n2g==
X-Received: by 2002:a17:906:459:b0:a3c:91e:a7d7 with SMTP id e25-20020a170906045900b00a3c091ea7d7mr1681566eja.60.1707910032171;
        Wed, 14 Feb 2024 03:27:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHvmngmL9lPnXkipC4/DtY3Zg1e18hVX6Q1AxtWOfRKQdeZbYHMAwFpb8FW172+NkrE2Q/gHTQyRj/stlBsuV58V60mppe1beHyb2CC64xj4vW4XPds60ERDgEI98yJ3y/AehXn4o8D3t4m/MNSFdXwvzP7mAkX9MG7PQpMRsUJWNuVr1lyLX64Tytn/Q1VstX7L0rW6QMiZOd0IT3THzoYpSmynF6WVC2ygUs6XgbmzEHIHIHX3VlxzCBHbDWFw6L+t9HGAFbLUoJE8Tyz3bePOhiqk3TbsBxCjdsuDOuEdJljjMBYAgbaGx4PzqKhRUrCoLOj5Ps8qgGcUECE3QbwaNoUjhgLihcSlluhW5elIEXHNKcFGVSnWCK3U5/yfYKM/RcGdM2r10cwkdHgICsTu6prJ1dgU8H+q0sOI4AyuVyNT5YjviMGxeh8feRdT4pyovufik3xZG25v4SIXFeArPnjLaR4etwTfTFGkw/
Received: from andrejs-nb.. (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id tj13-20020a170907c24d00b00a38a705121csm2212012ejc.47.2024.02.14.03.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 03:27:11 -0800 (PST)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: b-liu@ti.com
Cc: afd@ti.com,
	conor+dt@kernel.org,
	conor@kernel.org,
	devicetree@vger.kernel.org,
	kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nm@ti.com,
	r-gunasekaran@ti.com,
	robh+dt@kernel.org,
	rogerq@kernel.org,
	srk@ti.com,
	vigneshr@ti.com,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v3 5/5] usb: dwc3-am62: add workaround for Errata i2409
Date: Wed, 14 Feb 2024 12:27:08 +0100
Message-Id: <20240214112708.157743-1-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201183522.ssj553rwefr2wuqi@iaqt7>
References: <20240201183522.ssj553rwefr2wuqi@iaqt7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> All AM62 devices have Errata i2409 [1] due to which
> USB2 PHY may lock up due to short suspend.
> 
> Workaround involves setting bit 5 and 4 PLL_REG12
> in PHY2 register space after USB controller is brought
> out of LPSC reset but before controller initialization.
> 
> Handle this workaround.

Tested-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

You have requested [1] to check whether this patch
fixes issues I observed, and I can confirm it does.

[1]: https://lore.kernel.org/all/2629cd30-23aa-4f03-8452-ae13297fd6b6@kernel.org/

