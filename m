Return-Path: <linux-kernel+bounces-85138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC7686B0FD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0408FB21BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9862914F96D;
	Wed, 28 Feb 2024 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arZ3c6p+"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C4A73519;
	Wed, 28 Feb 2024 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128546; cv=none; b=o/wRPiISAZeiieqQdoUs3ABr97z7oVP0fJFYxkEWfPBn0poG3NodOUyKxVg2ndKdzD381xc4CCdt/QuNc3HFcHTZH/QnQQZgO/FNXC2AZWDTnmyMzqk3XXCG8ujCTPep514tGxiT/P8BbrNJkgZPC+7nwuR8HjlBPYe0ui0fck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128546; c=relaxed/simple;
	bh=8t8hoaLRxmVNneYYb8zvqLM+/CaW5tOOqLAxKYoD+aU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mlzbMzU3ywShQiiTd72NGUUpaqY3ILWr6O+6zS33Gk4MLlaT3K39C4bozFyQBGB7D50sxosc+mRr7gv2SdmyGYFGHrDgDU6NnwdEaoO+tYRPqVFKzZMnRsvcFrJznrFqsfV/qBlGU0RKsdiTbVUMm7FvYuYyi/izjQLXAS5tq0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arZ3c6p+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a293f2280c7so847301966b.1;
        Wed, 28 Feb 2024 05:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709128544; x=1709733344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mUq32dELYvaZbPwdj51rNG+84kHbibnt9c28Nvcq26E=;
        b=arZ3c6p+N+uvtYwPHjdfRAweAZ051NJAk7GI+G5OAJYuKmfD62i9/k915CMcbVhRvL
         NTWGStqY+YQDMEEQjbI33l6x4F3khZiZqHryPLNkMQhValTYA8/uDVMu+5KYzqLbPsy/
         HHEagcLKUi3XF7hffBpNXawhVWBR13IaYJ2R6swJ0OQeMVSIhISVzJZOngwpE5h6C8S3
         vN7C2lXBpAL3SPpTs1SLkEauI2+XHoW+/ZCcc4SpL3if294FiWcvUllrsvny1SVmzh5w
         U1WlObkMrfl3riKGQ4qYS7RKoV4LorKchNdGkVOE2f5JE8aV4iAJsC6vJTuUsILcKWRy
         vtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128544; x=1709733344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUq32dELYvaZbPwdj51rNG+84kHbibnt9c28Nvcq26E=;
        b=vV16TJ1PWamJkB5Wq7+V2IVyFT8zUDr9YT3YQsCQ7TUaJHssRy+Ns7gzPvy+XwbyGn
         a9TPAg7iffpSNJQTnoMcExZV4KcaSwbU6muOrYabVGrPY+5FQ4Da2Jvv2GrHdv/9WKtM
         SijIVdn/e0o6Hqki9+JBWBA3OsT52PxwLiISD9dDsFF3jW6e6ss9SJVVAbOUKSrrfHeW
         ahhrSVMsdhtsTwrAdMjN7nEmyZO4b5dyHf5mt4zBo6jJ3wEfMT+kEQm1yajF7mgMj4Ik
         aACO3htv1RR3Jk5YBa8GJQ5ngvGvwO6LFEYr79px+a4OjK5zeh2WP8w4i1NJwAAlG458
         g7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCULRrDDSlz+sjMA6qbT/yFOvPtSjAtaVGFPnZKhy3blu/gEQKZXcWLkYMbE40ihi8kL+PaOgCExdoBwqrWJm8DKHoGwK2ZzpyE4OTvWfspyt3DSxZ4dhOSsqHoy8Ek4/uhE/jZfVLk7qJ4EUPsJNLl2d2ZA5crbufOHJAHT1CObQ9Sjzg==
X-Gm-Message-State: AOJu0YxupUB5tOlNkOY7RHgsokcqkp/aHktiGFdZ73eABgz+6yARgLlD
	EKEXVuaqOHRNyWD4ZIPflqCK5SxlZnaFeCJqkWqSe54gaPH4yYMM
X-Google-Smtp-Source: AGHT+IETRwWmPqicqrFjkEgYRoZjTMJcgxDsa5ASY7v05ij/tmHE1uSO4NdqEOA8D0xL960bz3084w==
X-Received: by 2002:a17:906:81d4:b0:a43:6cd2:7bb7 with SMTP id e20-20020a17090681d400b00a436cd27bb7mr5428327ejx.47.1709128543386;
        Wed, 28 Feb 2024 05:55:43 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id dc6-20020a170906c7c600b00a441674cae4sm312487ejb.222.2024.02.28.05.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:55:42 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v2 0/2] Add support for additional AD717x models
Date: Wed, 28 Feb 2024 15:54:55 +0200
Message-ID: <20240228135532.30761-1-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the Analog Devices AD7172-2, AD7175-8,
 AD7177-2 ADCs within the AD7173 driver.

 Datasheets:
 https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-4.pdf
 https://www.analog.com/media/en/technical-documentation/data-sheets/AD7175-8.pdf
 https://www.analog.com/media/en/technical-documentation/data-sheets/AD7177-2.pdf

V1->V2
 dt-bindings: adc: ad7173: add support for additional models:
 - Remove bindings descriptions update as already included in latest AD7173 bindings
 - Remove default: false for adi,reference-select
 iio: adc: ad7173: add support for additional models:
 - Add period to commit message
 - AD717X -> AD717x
 - Fix typo
 - Reformat supported devices list
 - Reorder device ID's by value
 - Use correct comment style
 - Add missing space

Dumitru Ceclan (2):
  dt-bindings: adc: ad7173: add support for additional models
  iio: adc: ad7173: add support for additional models

 .../bindings/iio/adc/adi,ad7173.yaml          | 39 ++++++++-
 drivers/iio/adc/ad7173.c                      | 82 +++++++++++++++++--
 2 files changed, 110 insertions(+), 11 deletions(-)

-- 
2.43.0


