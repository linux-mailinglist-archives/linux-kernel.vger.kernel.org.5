Return-Path: <linux-kernel+bounces-2203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626EB815950
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798451C218EB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25052C6B5;
	Sat, 16 Dec 2023 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMIwTlD1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F2218ED7;
	Sat, 16 Dec 2023 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3366005be7bso231628f8f.1;
        Sat, 16 Dec 2023 05:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702733668; x=1703338468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e4Pnzm4bxmN1fk3GP72GEd90zQw6SBjTxtYWAmo9nW0=;
        b=FMIwTlD1o1vD2fYvOHgefWz0zrblL5SoUyIKrjcATnPHh7yWqfLFoZWeYsbg3QU6EI
         os8PaWJ59A8VyPBobI0DmkTI4eGscSSWcLV1TvKR+/Y6YiERjhD/MjzBgrtYANrbKzSA
         OVaQ/rUPS5AeFCiUQlwMTAT5tnhhTVw5L/ur01BFpPbRXpgYfnEsLzj5mgiZWQEcx8Yu
         19i6G1gz/9yCXY8hQpbSu3hqUSapIcsBPcHfM4FV22nGjtT4ZvFxpszlFMEa/Hi/3w7X
         vgViYIUw4oy/AiwvpGvkdM6udf5f9cVf6vCOqNEw/9yI0j8wlu8NBgkxs9uKAeuzeJ/x
         KJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702733668; x=1703338468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4Pnzm4bxmN1fk3GP72GEd90zQw6SBjTxtYWAmo9nW0=;
        b=thtSeyVS5pReief2JFd8l8PTMf17iYGEKfNqhoHZhXQ/uFscV0tloosTB7SZiTARMP
         BY+jbp9+8ajjKN8OCPIj4EAxm0pzw+fVf9KE2mmUHp7x+rgU5CA3WhNbstQ8dHvD+/hX
         ZcBGnhCFYdDAHxZpkYmUNTHTh5IShB5dO9kZn33+uqttJxgvigTCWZp6WDan468SiZRf
         aoj/iumZj1+Dw9NTe0EAfJnDBdsQci75NmqA97Zqkgl4rMbKy1pJSdRvwHPb/5jFAm3a
         v9TgEuyUEl5L6x8XJyAk2HOtgoJBxZI7qekPZzOXCPsevhxlhHs1GiOQPPqFtskGm5NV
         iYPw==
X-Gm-Message-State: AOJu0Yw7wodFO61sjTJF0ZyPVm+CfQC3bcosGAqtYHEJIucy7L2BJkiX
	SucCe2tNlmgYyL4lmN4HULw=
X-Google-Smtp-Source: AGHT+IHtl+U8thZppz5mNOff0+ApDzT0EKcByNUZ3orrNnMsfII8U9pYh68LYIjyCoPmkrtlwjcnow==
X-Received: by 2002:a1c:721a:0:b0:40c:61b2:c950 with SMTP id n26-20020a1c721a000000b0040c61b2c950mr2265466wmc.24.1702733667566;
        Sat, 16 Dec 2023 05:34:27 -0800 (PST)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id l16-20020a170906415000b00a232bf6045csm423629ejk.63.2023.12.16.05.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 05:34:26 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@csie.org,
	samuel@sholland.org
Cc: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/3] media: sun8i-di: several fixes
Date: Sat, 16 Dec 2023 14:34:19 +0100
Message-ID: <20231216133422.2534674-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes 3 issues, which were discovered during examination of
occasionally non-working deinterlacing on A64 SoC.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (3):
  media: sun8i-di: Fix coefficient writes
  media: sun8i-di: Fix power on/off sequences
  media: sun8i-di: Fix chroma difference threshold

 .../media/platform/sunxi/sun8i-di/sun8i-di.c  | 69 ++++++++++---------
 1 file changed, 35 insertions(+), 34 deletions(-)

-- 
2.43.0


