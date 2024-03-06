Return-Path: <linux-kernel+bounces-93835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9341D873560
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48472282A11
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A16779EF;
	Wed,  6 Mar 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJHJgD06"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08066745E0;
	Wed,  6 Mar 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723408; cv=none; b=mNI9U2qkXg10W9yTschQ5/bpKoRGaOps2rl4iGfrqU8jkkwcH8X8SBY3R9EtHBA2xLgW0F9PX3HGbQTK+NctGXoe7+qBrig5qSEdfVR8StHJvM7r5zEUewOvvtG+ihxSFd3Cpo/KJ+D738sEcR5P28o0Xt3dqKxnz/JQtp/iT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723408; c=relaxed/simple;
	bh=2Z8srG2xNuPzM2ZRM5h7K8YQTFq81ueHFi6ujO1na3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZjRAtE17bcmONEHGjAXGEU/frwP4ocwcb3XnhmC6kRF0N3aUsSdc9VnvAjze0mr4EhYrHLDoTzIiU/MdG7TOxp4EyXBfsXKvQuj8yugHD02qqidFUid+BEyWT2zvGfuBzPIcFz6pfNBgW1YVXoEeInj7U0aMBN3ob2do5tuElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJHJgD06; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a45b6fcd5e8so79746466b.1;
        Wed, 06 Mar 2024 03:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709723405; x=1710328205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HsZePEd0gHKNMRSBX8gLYeyiLojwrZLJRPuiiGRE0Sk=;
        b=DJHJgD06yERxRMyflAeyK2J5P/36d5zjxP1VTqqkxiazeN7VrizbqC6PpbwcXA6l/H
         2jghn1UBmDuqusSLjlKe695DNyLeY0SHsvAnFdbCE+NB6R7hF3RvzngRHnqrmUQmUF8c
         mrm6lgdRlC9gzmZ6dtQvATmztyxOe1N0WAwMvyEzj8JsEfRoN3/sotRpL8/nullp4LvX
         vvvvbXC5qE918yLPs3GVP73pUZNUb37sUn+xUE+Oh6z+YAOeoBtEte9mn+VqF5cTPmjK
         4JuYOQGk6fiUX/lwvX+CLd9ImupkBd5Q1DIm0GxognxQUA7i9oFk9MrTRoPH0MVFQTHE
         m57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709723405; x=1710328205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsZePEd0gHKNMRSBX8gLYeyiLojwrZLJRPuiiGRE0Sk=;
        b=mjhfDwEmyGsAIvwerwowfDP//ASJB5HyxO4hrS0yjLHsp46cxNPDz5tWYUhcuazNAK
         MeTPfgMA1YjFfFDR5groTMa7J0qipGQxryd0ySjfs+Fn+3HwdjAVxSTeAtapNwpyFT4a
         7kttCXeiiwuVALZxWsob7AMoUfCOyrIU9w3/pF1tOAVJiHEX78L6vON82nWHADo8pOHc
         Ln7tZ0HCAfmuIbG/1ueYRcJ7th5rhf0EHQaF1QHfM99JwvL50fMbL8Jc67yXhjnRhu+e
         tygfISbYgxn2Up2bdC69Mjf+BgaQNkDwXQ06BxPldhHV667oJZ1OGfoTmdCn4Cy+OUdI
         wqXw==
X-Forwarded-Encrypted: i=1; AJvYcCVJb3MLlXBJQv5oTfoicyGzjiLGH1Fl7eWqUvTYPD/ruY1pR4yRLaWsoUU7cOdDxMO9Ny4AawRVi2j3kQPGT3/pCXP1C+YX65KpB2s9Rlv9PmUOv73Fida2h8PQfj5SIZQQh+XFJ9A32g==
X-Gm-Message-State: AOJu0YxaQqmtAms1VY/mLD4UmbNs7k/5KxTtzxcPQnUBC2iC54UgMqeQ
	4bFcRE9r3KZgLYit3CYh4OIRTE5Geg3xFLV4rB3fR3w1ZMftcJhYqm/LSg4MrLj/Ig==
X-Google-Smtp-Source: AGHT+IGuWeEUwr2kwToxYZw2aMZN8aQinLQstGcK8AmICWYQp47oG6rJYYl116Ls9NPxl4Fy5bICeA==
X-Received: by 2002:a17:906:6cf:b0:a45:bc57:5379 with SMTP id v15-20020a17090606cf00b00a45bc575379mr912652ejb.71.1709723404920;
        Wed, 06 Mar 2024 03:10:04 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id w26-20020a170906385a00b00a4394f052cesm7002479ejc.150.2024.03.06.03.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 03:10:04 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: dumitru.ceclan@analog.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v3 0/3] Add support for additional AD717x models
Date: Wed,  6 Mar 2024 13:09:53 +0200
Message-ID: <20240306110956.13167-1-mitrutzceclan@gmail.com>
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

This series depends on patch series AD7173
  https://lore.kernel.org/all/20240228110622.25114-1-mitrutzceclan@gmail.com/

V2->V3
 dt-bindings: adc: ad7173: add support for additional models:
 - Remove vref constraint for ad7172-4
 - Add missing model that supports ref2
 iio: adc: ad7173: improve chip id's defines
 - Create patch
 iio: adc: ad7173: add support for additional models:
 - Add new attributes to *_device_info to describe model specific behaviour:
      odr_start_value, has_int_ref, has_ref2
 - Remove unnecessary space from *_id_table
 - Move chip id define rename in a separate patch
 - Order chip id's by value
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

Dumitru Ceclan (3):
  dt-bindings: adc: ad7173: add support for additional models
  iio: adc: ad7173: improve chip id's defines
  iio: adc: ad7173: add support for additional models

 .../bindings/iio/adc/adi,ad7173.yaml          | 39 +++++++-
 drivers/iio/adc/ad7173.c                      | 92 +++++++++++++++++--
 2 files changed, 119 insertions(+), 12 deletions(-)

-- 
2.43.0


