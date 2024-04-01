Return-Path: <linux-kernel+bounces-126901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5EE89442E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C4A1F21365
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEAF4CE04;
	Mon,  1 Apr 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiV77F5z"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC4D4AEC3;
	Mon,  1 Apr 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992122; cv=none; b=h+6/PmMGUZtEdT43D0XR4i8xur/zJVJ1/e71lsP2r6vU9uXm8XT0aHFOufA6FBwrQK+iqQnZmWhRPZ2Oro4TdujsgVPuqJ+6M85FKYUId8r4CKiUsjv7IXgKystWTtFkh5KI4FSkHbHjWxbw2EmzFu0MjQ8w/P2p4Or7S2Y3B0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992122; c=relaxed/simple;
	bh=yGSMWtyTvsNKYw3IzNfdUL7VvAd5Xekz8J7V3atz0kA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jdE3zEdrELSSmvQsjSQ3dOnpRMw/6AiZpKTWhJ+XB62oibpUQbxQ1WATdjg2REwHzJokZp/oY5ZzhWGG4aj2Vt2z5GIYRMrb6PV0F8oW3KIqa5aYAJAd94HrTa26h/7EmHkrMcS3rdhUqdtXYoj6ASouhmqeQYWp36X3H8LnEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiV77F5z; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56dd16630d8so942350a12.0;
        Mon, 01 Apr 2024 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711992118; x=1712596918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cFKQ5iAv9Q4vsIgWAjjOKXP7jVa9L0LaTnYCKK3WFF4=;
        b=IiV77F5zUu06GtqP/E1HGs3pYrE3GvM9FT7Ei3Z9ToYBeIRAl3e13kapvD/bDFD45B
         sJRgniWwacQN6TP5QaQx4i52ecMZv5e6JWir1pB5VsueNOvdy5aqjK+gHHiiPrUyZvw1
         Xu8OB0kh63vM3P+i/4419t7tpCbAXTIomVZ0YF3BoqXGdp1TMuah90XmuHW7IO+6Fse7
         uoodgwqNIqpp+gP+z6OWr2CobwI1WykeXc+1qVi5UwqN/8cr0dJCZh2HvHfc3VW28SGH
         3yzVH1LTQ4LprO0CTy/mheEN05X7r3B3Lw1dXzDOzexBIWU4nUK3rlPvDG4IHd18OOiy
         GTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711992118; x=1712596918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFKQ5iAv9Q4vsIgWAjjOKXP7jVa9L0LaTnYCKK3WFF4=;
        b=e0LASU/o/x5Zv1FUgD0UWpSeCcBopM9qJfv/FuvN8IvA/OJy8RdZbh8ZfmYrQMWybh
         ou9Hqz3s1CBSTmegKBN40hnrF46OY/SDzq2xVUdhMVrlF4r2KS+WTCj5IlXq+dakOYEP
         De/f+vffSM/fCtsc5Zpmi1ht1jySL7NvhuRjdFqfChbanrLpjMLtJ5myQ7zNiLyxgj3c
         pHbPj8Ms8BZZejkVpDcFSgBC8EKGxS2NVoDE3JMR4rhAtOotGWgQNWDPlwFOUP5pyfgQ
         ZYviXEVZWhpb4LZrS6TQRRxQZIKDSxmW32YZc1s5iKv7TgaDWen0oN0mhQWvBLC99fq/
         a4yA==
X-Forwarded-Encrypted: i=1; AJvYcCVZwCtUkNWpQjYhzDGNrEbximYmLj04+uBix4lA4+pJjiErmcbqUFeOdjZaRe4BJ2M9US3bFy8F51ISyq+GzXmhLmVbvwAhC2guDpm6YdJsQMpNuMUCc14VzXo4fzZZLoLlNTtSd8bsFNnA+mrpfdzrkHqY15fvd502jpzi24U5cwPjLIoyrJo=
X-Gm-Message-State: AOJu0Yx7x2tlE1+rGLnLuSIpP9RLR5qTY0FLCwLafyTHpYDC3cIM2yZB
	jOhb7hAqCr/MTAf4uVb+PsuQKyUIsFJCcQHmf2OSjOuyeS9Sf2HdAqkQE0gPypM=
X-Google-Smtp-Source: AGHT+IHA4HhwZKjoCKMwQeG/ipnWsYQ2yEZNIYKMejNh6H2iV9+YIsf3PBnYkhMAIQ/U3ef4vYeK/A==
X-Received: by 2002:a17:907:c1f:b0:a4e:d43:dc4b with SMTP id ga31-20020a1709070c1f00b00a4e0d43dc4bmr8607122ejc.58.1711992118052;
        Mon, 01 Apr 2024 10:21:58 -0700 (PDT)
Received: from localhost.localdomain (ccu40.neoplus.adsl.tpnet.pl. [83.30.144.40])
        by smtp.gmail.com with ESMTPSA id xi7-20020a170906dac700b00a4e23486a5dsm5347949ejb.20.2024.04.01.10.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 10:21:57 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] MSM8976 MDSS/GPU/WCNSS support
Date: Mon,  1 Apr 2024 19:21:49 +0200
Message-Id: <20240401172153.9231-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series provide support for display subsystem, gpu
and also adds wireless connectivity subsystem support.

Changes since v1
================
1. Addressed feedback
2. Dropped already applied dt-bindings patches
3. Dropped sdc patch as it was submitted as part of other series
4. Dropped dt-bindings patch for Adreno, also separate now

Adam Skladowski (4):
  arm64: dts: qcom: msm8976: Add IOMMU nodes
  arm64: dts: qcom: msm8976: Add MDSS nodes
  arm64: dts: qcom: msm8976: Add Adreno GPU
  arm64: dts: qcom: msm8976: Add WCNSS node

 arch/arm64/boot/dts/qcom/msm8976.dtsi | 524 +++++++++++++++++++++++++-
 1 file changed, 520 insertions(+), 4 deletions(-)

-- 
2.44.0


