Return-Path: <linux-kernel+bounces-132413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA190899499
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E443284576
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A7820DC3;
	Fri,  5 Apr 2024 04:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1s8Hl5m"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D928E2;
	Fri,  5 Apr 2024 04:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712292797; cv=none; b=VV8yJp/0VVqILp2qIneQCWiAeor5pBmUSplMQx0JoyirEggwozMlZN/WR1tJ+EGzhtQ+KZ3ytI1XFZlFyBSmbxYB//PRNqZRmQSYsy3piuCSrPjLCReeZVRb057rtWfvdztmhHB6/gHBrW5AZFdycif0TJpnfeXwMuNWmIxaRQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712292797; c=relaxed/simple;
	bh=GZnrGBN9X5DCj+ZTywIyLhZvY0sns6POFvF9IftpFaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AzaRrgHgPs7QuMpJmNlUjT59udOzeoJ2P9L3dlXvELt0iw4Uqbcfm1h+8myTUkdiHxX+zUvIsFJiIMBl950lLmUNWhdCYmGfQ5DIAL5s5wF8+RvrFJwi2qpSS5HWrcIsrSajN54P7fYPlsDHLHSyCpPZ3ySq1/RozEaar5go5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1s8Hl5m; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-343ec8a1504so36158f8f.0;
        Thu, 04 Apr 2024 21:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712292794; x=1712897594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZRtbPPT/bG9zERbjZdijLfQPAJAhV3+LksckhYDXMI=;
        b=X1s8Hl5mwXFe90Ty1gX34NYGVV13NvSu/p4ccWsoF9Zq8/mdqXtfdZRl/WyhN3NcIx
         KaKy2oUmdZr+BVNp/4ldgj1uZzR+y2wscfqZYSYJzHhQuY1LGUXU2L+i+eGdttdGH+DA
         ae6xIKKbt2lD/BIfx+Qk9tb8NDDlrwIGj928dw0BqzUUZgd7H4bB/Rx5wqUpgoSwhIhW
         /rTrPed251ZBtBdBB0cq39RkaRkhRsCdIRY0xGPgCPWf/s+KhMiFO5VcblUKgbLAt4PN
         R3KgG3UPZi9/T+QPeIZnYAy7biTG5YqS9qqjoMwn3j7UB/Nr+ZZ80OrXXqklX1hdLGyD
         5Gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712292794; x=1712897594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZRtbPPT/bG9zERbjZdijLfQPAJAhV3+LksckhYDXMI=;
        b=UZz+jGP1KrAO16kZE9YdWvWfP6Z4Owu8LdJZZrEyLowFZBlgPI76p1pjzFLIgWu1I6
         xipzmsqELNNrTsEJIyBcJTEOLEXf/yyywUzXTbOB5BbFuvjzjzFmE+KQJp8R4CK9GQaa
         MdKKHWfjKijzvc5u5NMM3DoTdHIZ4z6e1P8soFCbw1+kzmGSlyAXnDSgFRPwJMevBkaf
         a2YhHFhJkpDH6s6GP2NvuIcCQsC8pJKjq3nrsfsDmE1g1XJwiPtICplhzVEiSJyscU9O
         Z5O0P5YtrRogTxSGYYZOBEmIp0CDjWold7zwI1GVxVNw2x9qAwzw+1tRUfHX8p/lgMap
         am2g==
X-Forwarded-Encrypted: i=1; AJvYcCUbHWAmVRSOwDFr2G2ShK0rm8v7X/SZAtHZACGWcBcBzyiU3FKQcUrZrXqokNr6LJb+2VWC17wRskM7F4WyCWwUyYSgjZPII/ow
X-Gm-Message-State: AOJu0YxjVDaVJJBaAAOsblhY6/ltWxgE4H4Wj1pdRT4HW9TRisLM2Vb6
	KRssqEJIx/SpLrip1MZxz1bvAh2JYFCDXU97uBQ3ENbAL7CJZHkDaglHEwN2
X-Google-Smtp-Source: AGHT+IHa6B2jnJxWwLQx0GRAkL1EXjGbruaypCl/JaIFXG4cWViOD4M+N95m0YjVppK7imAUTKCaKA==
X-Received: by 2002:a5d:64cf:0:b0:341:d7b5:27 with SMTP id f15-20020a5d64cf000000b00341d7b50027mr410069wri.6.1712292794128;
        Thu, 04 Apr 2024 21:53:14 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:370e:900:9daf:1dd4:230e:4f59])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d452f000000b00343e825d679sm488302wra.87.2024.04.04.21.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 21:53:13 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH v2 0/1] iio:imu: adis16475: Fix sync mode setting
Date: Fri,  5 Apr 2024 07:53:08 +0300
Message-Id: <20240405045309.816328-1-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix sync mode setting by applying the necessary shift bits.

Ramona Gradinariu (1):
  iio:imu: adis16475: Fix sync mode setting

 drivers/iio/imu/adis16475.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--
2.34.1


