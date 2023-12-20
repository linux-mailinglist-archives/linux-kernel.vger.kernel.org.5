Return-Path: <linux-kernel+bounces-6608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89462819AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEB0CB21C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3071D52B;
	Wed, 20 Dec 2023 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4UQ/oc/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159CF1CF8F;
	Wed, 20 Dec 2023 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5534d8fcf7bso3919641a12.3;
        Wed, 20 Dec 2023 00:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703062572; x=1703667372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zb/Vx4nJlslgqI+Qgi3fLqRNq9EoaG2QoMsYKPdbKYI=;
        b=J4UQ/oc/qQBG+Rc7DjHaTaUxbd53WRNq9JXQDHuCjE1XP6pDxU8W0IfMcCPPa+XYMJ
         fab/psmXWy2JPFO6bvQSHx8g7XlitcIzgWSfs+DLjHFcgdKfC9CICdzyot3eXHlfomm3
         QJN63mUnEeIpyYqwTOjMeF/SOdB/SX/+81sFEvj+8LvQyx9/36HRgqvxg7MePzOshkrp
         huRTlezfcC6BSvPVW6eYq2S01Lfr3tN2DyYlklL5mo6IT9wCcFcSciUjit+sbfouJB1z
         Q+XGoE3zQhkB+5Ttq71TsMWEgZCdbjo+Q5flixsxfCyCEVto/bqitQ+u/0/JALiNYYEp
         05Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703062572; x=1703667372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zb/Vx4nJlslgqI+Qgi3fLqRNq9EoaG2QoMsYKPdbKYI=;
        b=ntxQ+ZY0TrcJ6o6WYdHtjpJTUU0LuOIH7yemCgGqkILvXh5rYh9yJbwsh4YJV+3dT5
         gnE+CbdXpIC8CRy1UJz0ReN0EOysiDune4+jBkGuONBWw4Spuha1+iN0ihfOo+w7oNO6
         DqjSLI5AIkaI5wzIsfkA/R9+BICQm2zFZxWa+ZfT4Z2inHqQ75sakSwIlqfss3IftGo0
         OhJlBpvE7wFpgPXg4DDSI5YHVUziQAWuYbA+GKVB375gOZlXrEL1Q98pTIwOcoj7RuPZ
         /ZtI10X296OXcV1JZd/Rz1oqP1Rs86BCzREgq9C5IUHFnYkiX2rGwxORoPzxoXBHEyuy
         a3bA==
X-Gm-Message-State: AOJu0YzRC8TfV8saaA/Qbq0T41BiCEgBMO+iy44YeTTQfZ1leuVF4GKg
	QsyQ88e46QxtrejnxRD3pKA=
X-Google-Smtp-Source: AGHT+IGFZX6mlv2Mejj+wwecpAPZP5tS8SCmpDOMeWxQbWsmakCnpGSZPG/k9XPFJlvEYCnlnVWqeg==
X-Received: by 2002:a05:6402:902:b0:54b:4e24:e526 with SMTP id g2-20020a056402090200b0054b4e24e526mr11187831edz.42.1703062572042;
        Wed, 20 Dec 2023 00:56:12 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id cq12-20020a056402220c00b0055335e89ed8sm3532169edb.30.2023.12.20.00.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:56:11 -0800 (PST)
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: 
Cc: linuxfancy@googlegroups.com,
	laurent.pinchart@ideasonboard.com,
	martin.hecht@avnet.eu,
	tomm.merciai@gmail.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] media: i2c: alvium: store frame interval in subdev
Date: Wed, 20 Dec 2023 09:56:05 +0100
Message-Id: <20231220085609.2595732-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,
The goal of this series as suggested by LPinchart is to remove the following
data from alvium_dev struct:

 - struct v4l2_fract frame_interval;
 - u64 dft_fr;
 - u64 min_fr;
 - u64 max_fr;
 - u64 fr;

And use instead the the newly added storage for frame interval in the subdev state.
This series is made on top of the media_stage tree[1]:

 - media: i2c: mt9m114: use fsleep() in place of udelay() (02d4e62ae245)
 - [1] https://git.linuxtv.org/media_stage.git/log/

Tommaso Merciai (4):
  media: i2c: alvium: removal of dft_fr, min_fr and max_fr
  media: i2c: alvium: removal of fr field
  media: i2c: alvium: inline set_frame_interval into s_frame_interval
  media: i2c: alvium: store frame interval in subdev state

 drivers/media/i2c/alvium-csi2.c | 99 ++++++++++-----------------------
 drivers/media/i2c/alvium-csi2.h |  5 --
 2 files changed, 29 insertions(+), 75 deletions(-)

-- 
2.34.1


