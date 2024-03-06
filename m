Return-Path: <linux-kernel+bounces-94285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DB0873C7D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991F81F21EF9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66786137917;
	Wed,  6 Mar 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WtBKxm0F"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2E1132482
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743423; cv=none; b=I3nWUGnG6cPsTeGF0uzmq0WHQOHiwMuoznVgEwAo7rLuhqyGcw+kkHYZVaAkPiFYUXDqIoUcibcc179gT3hOkg8W3UCPzRLY2uRY4h7c+WbMDVUggp75Og9bUB/6Vwu7LLjtGny7gw8aU1Wtww+Wr2FEgK6nprF+Bi4eAeHhSA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743423; c=relaxed/simple;
	bh=E3MQOz1OCEoOqhzGxzqvg86mWlLxnYD562N0ynNIUgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ni08h2WWUnpqCUSRp6tvv86y6Nv9g94B9w/Ee188jhQhKLENcyCcRtSk9Qa2ElPJdesjmvaegc4e8d4Rai96ZfJLzifFxSY1bcpWiu1ftSvIbHo34CLFalY2vrTEABM+VP6BC4uQqq9qpC+1zA4NjFIClNE291jKE7S3jaM81Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WtBKxm0F; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4d34dadcb23so1397792e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 08:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709743421; x=1710348221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CzHKJhoZJ9L9/JumXPgp0DQ56z60RjeIgEzaXkgl64=;
        b=WtBKxm0FgQ4JzrKaKgOHxpRCy5Wg0C4o1nAxZ2mfFCXs0IKswdUF61huwKuuel1rL2
         RmomFY8CnUZyR1kL0/80f78mfan3AxQ5nTdeN+ntuOO9CZhZPd00C4XMa9JhJNTdb9GX
         YnF6SdGjPRDu9O8veB8mHkvGSFitZ8YMy7OfH9TIcKnFZJ+rXyfuCJRf0FWKZOmfCgra
         Cwrr2/ENtq4l1ZyejuqWet5R7sUdKs+QfVh9LVSeAz5VjLFzpcKECk3CsFdib4nGnjjJ
         0OUB2Z5yRxTOMBZ6BM+05wOQK7gFRkDnT+5ZAdvZ7V1sFUJPKMupHEzoUUVpjddKo+YX
         1/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709743421; x=1710348221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CzHKJhoZJ9L9/JumXPgp0DQ56z60RjeIgEzaXkgl64=;
        b=r6ikJCPW2iQsLSV7/O6FZBc5CUbxjJhsnmHy4u/UA20X1d1OfjUTGtbFy5QeR7GNmi
         0aZXSRsrv4fuYJx1CZW7xD9cVzWMkAaRoI3j9lrqgj8ZPBu8mU4c3boZxgULCVU9DDzq
         yykoN3TS2xQkX2kRbymLQslqiHQWOYaZ9J2xHaNOZ/If2odrqiW1KFoozuumnfBSzXWb
         8IUdSh9hkeFoZq07LSsgUPbwG/GopMXVEXIS78KyB7UskFlAr2BDoI5wgBczbyzNcrK8
         UuN94JZHsR8dPQ6b5ez5hUG8VuepFtPVMqM3dM9fjyx3mghnFDeUUSTHMJjM3yk+xhxq
         ftAw==
X-Forwarded-Encrypted: i=1; AJvYcCVISoI74uQ2Uia/ycczyZWObx0g/jSUs97ODSmm6QmmzfaSkcnsf+SeS6nDdANFrp61f/co7766zhUUMuzconADmBkQywjfUCa4RdZ3
X-Gm-Message-State: AOJu0YzV9esDbD+7v8F1uc4O+crxEvQ9rzdbboWaM+ad11fUgGDaHXwz
	jYj5bNaI19q3V1n7zLA+3r1rwXUEEQc3kSgfeTK/wYSupM6Sx7X+Gyj8zzq/eCY=
X-Google-Smtp-Source: AGHT+IEtqKs4f+XSGVsSLHNo1vi31Z+1UVpK7SSLgkuapm9nCa1m0G66gdX1EHLx1QeDvVmUMUFg2A==
X-Received: by 2002:ac5:ccc7:0:b0:4cd:20ea:35aa with SMTP id j7-20020ac5ccc7000000b004cd20ea35aamr4880544vkn.8.1709743420987;
        Wed, 06 Mar 2024 08:43:40 -0800 (PST)
Received: from ishi.. ([185.243.57.249])
        by smtp.gmail.com with ESMTPSA id ep15-20020a056122390f00b004c02d68e4ffsm1628459vkb.44.2024.03.06.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 08:43:40 -0800 (PST)
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: William Breathitt Gray <william.gray@linaro.org>,
	syednwaris@gmail.com,
	vigneshr@ti.com,
	jpanis@baylibre.com,
	alexandre.torgue@foss.st.com,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] counter: Introduce the COUNTER_COMP_FREQUENCY() macro
Date: Wed,  6 Mar 2024 11:43:23 -0500
Message-ID: <170974334053.40130.15652602513065815985.b4-ty@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306153631.4051115-1-fabrice.gasnier@foss.st.com>
References: <20240306153631.4051115-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 06 Mar 2024 16:36:31 +0100, Fabrice Gasnier wrote:
> Now that there are two users for the "frequency" extension, introduce a
> new COUNTER_COMP_FREQUENCY() macro.
> This extension is intended to be a read-only signal attribute.
> 
> 

Applied, thanks!

[1/1] counter: Introduce the COUNTER_COMP_FREQUENCY() macro
      commit: 0e313270e0e91e8d48be7a58e1622228cf9e53f3

William Breathitt Gray

