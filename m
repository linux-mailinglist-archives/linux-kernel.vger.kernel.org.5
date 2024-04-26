Return-Path: <linux-kernel+bounces-160094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DD48B390A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D1D1F2393B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2E71487C5;
	Fri, 26 Apr 2024 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuhOv9UJ"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD201482EB;
	Fri, 26 Apr 2024 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139629; cv=none; b=etbS8W0zHvIAbqmlRQDmyQ78rMAf/vqeGMpCYHR6thgAqwaAgESvS7dPOPa48xdzqyjwDPUpGh7Ixf7ScxNdKurXBbKzOe1ohUUyRqs6pwDlB1qt3TXV+DNqdpa5X5In70ZGvFHUxLd9ZAuteQtZjBqoMYtH3kKXBRuY5KIZXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139629; c=relaxed/simple;
	bh=2diDGfXgoqGZPV0weeNRZMPINUbCViSW6NuyJ9qT79o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G2nelvFRxFmk8iFxcpsMJm9YQh+03x2k54/rFTOlnCCX7sVkposvmr57Oq7M8n3PU4N+JmyMar4GBNFzhX7lKTtsccXFsdTiSJmVIKjNhe3OzA9sbrbvpoMNXr5dMENZg3FqgHX94eORYCfK3oEdv/OrK69ub9Rsu1whMgrQMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuhOv9UJ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343e46ec237so1731259f8f.2;
        Fri, 26 Apr 2024 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714139625; x=1714744425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwRPVp4IQMXqt/6idnRqfFQtuAI0tlXLTfnP1hSTCQM=;
        b=QuhOv9UJG5tMvISuMKrzF6RmEaT8HlfjLFxXssjVlCtlTLkka/pNpE6Vk0FT3fT5tc
         ZeCtuyOK8Qvk+mKJoQV25G/gnq0OaTgTpuMqpI0iFBuWnCNZ7yqKAB/ZhjPq6GhdPLDj
         K1rmbiq7/WhOyied/5dFJ9Dt8rYyB1rUjoRk7LVjyo7XGJPrV1YEhTNwJ8+mkqmYB2LF
         DfIn0FofiXdzd+jUnLPmlcUFMxKka6gbCHnn8CGnu9BAsYhn4xdbLuVoGPpyLOcCL4jr
         dQYNV8dbA1D2+p4px25r5QGWVuC/YCaQr2533FmmyqbOJu5fahXQudjqr/Y95pRFqbPw
         QOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139625; x=1714744425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwRPVp4IQMXqt/6idnRqfFQtuAI0tlXLTfnP1hSTCQM=;
        b=MA4z2b294LNB3PElGFb/Sv+EQyQTRnfxj2bSFXPLVtw6BK9JZJb586KRI7c6KWLF/L
         8jkrBLGjrCjz8HAJ3NljsBd9hDd3iNC6+w04J0W3DvWHnz7ExxYJNciW7bFGqGY1knSH
         SqnDH+Nf0J+UUUe1sGF5xqSQypRmipsVNsmR0JrM/4XkpBHBvbmz/m7PL0y+PTMiZldD
         DQP0ECAUm+lgTkssFpBD2FF9rFsnlDgDCBsHA3H1UItcAKxYcHaJgOSjDPKhQ56SL2HG
         jlyrDVqo8di0FLkKzAt+5BB4LCDvFf967A6dxs5gGtiMwMexKXk6bo0gMOnLqWjPmjvE
         cN0A==
X-Forwarded-Encrypted: i=1; AJvYcCVfsoRrFJD8XuDETZipU0SWJVib5jE4YUb1cagEeoWpD6gFcCJTmIBlFojoOoZCqxMLmpnbspBA9AcKqsJ6hQSL4GC5s3PLcFT6wKSeiGSxYCp26rw6MrtBPdE4J44G01lz+fWL6Q==
X-Gm-Message-State: AOJu0YwiMv8iMlRMbPzNm7dRzxu3ljooLa3keC20oMSERhSxDS7TjV0d
	xGbLnOvwaWVKpr4QfcBcAt7jn5dXHOrPsT285E80waLzM65R8MtMzzteJ0vL
X-Google-Smtp-Source: AGHT+IFs9eB77Zr2ZWpQ6HgnBNShWFrml09IBs/i7NOnwkTqdsCCAu4hDuP7h2aRXvx1yNEvyFT6Zw==
X-Received: by 2002:a5d:66c3:0:b0:34a:2d0c:4463 with SMTP id k3-20020a5d66c3000000b0034a2d0c4463mr2410851wrw.4.1714139625439;
        Fri, 26 Apr 2024 06:53:45 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:320d:e800:f4f8:b5e1:d7d4:bf65])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6d46000000b003434f526cb5sm22302919wri.95.2024.04.26.06.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:53:45 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH 0/7] adis16501 and adis1657x support
Date: Fri, 26 Apr 2024 16:53:32 +0300
Message-Id: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add adis16501 and adis1657x support in adis16475.

Ramona Gradinariu (7):
  dt-bindings: iio: imu: Add ADIS16501 compatibles
  drivers: iio: imu: Add support for ADIS16501
  iio: imu: adis16475: Re-define ADIS16475_DATA
  iio: imu: adis_buffer: Add buffer setup API with buffer attributes
  iio: imu: adis16475: Create push single sample API
  dt-bindings: iio: imu: Add ADIS1657X family devices compatibles
  drivers: iio: imu: Add support for adis1657x family

 .../bindings/iio/imu/adi,adis16475.yaml       |  31 +
 drivers/iio/imu/Kconfig                       |   4 +-
 drivers/iio/imu/adis16475.c                   | 698 ++++++++++++++++--
 drivers/iio/imu/adis_buffer.c                 |  32 +-
 include/linux/iio/imu/adis.h                  |  18 +-
 5 files changed, 681 insertions(+), 102 deletions(-)

--
2.34.1


