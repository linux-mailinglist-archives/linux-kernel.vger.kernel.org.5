Return-Path: <linux-kernel+bounces-79594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB731862496
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9019A1F2289E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B02941B;
	Sat, 24 Feb 2024 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BS4O7zGd"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C2011190
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774909; cv=none; b=OdokVoLdmRDcoZghOVvqS5ktBV3LFcNBshIAAWIWQnaQA/6v63BnBB/5OTkl55HnOUZ/9aSTDcU+T07GO6CtX7d1e8mhypz615saWw7TCQgO4SQz32CuGlZis90Pw/uxq5QfrOWuVfGvyY6CTe3Xid8hR69q+sCXvFNPjzGzPZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774909; c=relaxed/simple;
	bh=T5+7su8OL+BSlnLb+xk8JBsir9UeXXFZWsV34OPpYAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hgQb/JdAIoxE0M4CG13C+JQypz0vGmrb/RflgCDIImmJZ7qI61ciw0MU9edra8r/hlVZRgTOCMFz48bP+5BEmJf23m6H+VJdxVsEb+rmE3R+nnUouzqUT6NS+L/LQDk0vp3nNCwbU1qm5PtQ+/PFLxaC7TEm3vAusRJXteakTVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BS4O7zGd; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-565a2c4cc1aso549382a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708774906; x=1709379706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ayWCuc2qo/ZlHTh56uOukdvuY2tQIy9SUAF8WGg+0bM=;
        b=BS4O7zGdy0HHoh5meCallLfItFEqO3ow/K789plkA/saez1YXv+AFa1Pp0RxX8ULZf
         THeJD7aP5z7B7o9neZUzQbAuSGOOMWXJELlf04EWvlgzxXrbHf7RMV5nIRuo4OWN1p4+
         iN0KrB1Wpit8wuKajsQ2RuLQunEowYAMqlP9ZkYU13k5CX0TxKYHxjII60pwKpDgvNsm
         DrS+uEvAN2Ens2z23S3I1DAfsieCBD0Cq5srFTG5eSnBDmmrbIBnkIvfSMJxHG+VHoCA
         Ib/IzI1xNAIT/gbHknbAaaoD+rkS5cFhqzru0wo69awU58QbxUo9/eNGjbsMQxwoRPLc
         UP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708774906; x=1709379706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayWCuc2qo/ZlHTh56uOukdvuY2tQIy9SUAF8WGg+0bM=;
        b=RbOnv9BMeV9HyxX54HXHN1fHcfr8YaAb0+5AEGtLrUsi4t2q/4kbjG+2wsvflb1AqL
         aQ+pfwuTDOZRa/hFOy+MGf/ehh0n65AOvKCqpBG9stbjisrrAKiqxQslWxwlO2GNxeY1
         c+9E9tXiVxXdHVatdsYRTa+pgT6iWRqf0IFLJwbwNMIaYeIOG23aVi8DZSPkJAfc42ap
         IPLH/A59sK/awC0/EyA5x9n4ZMZyLMwefpCeeV2DDWcEKnRZlaTfWxvKtDft5CwT4oed
         U6wuMzv3XtLZ/AIWcSDipJcyr1omesLmytMhmvAtM+rxtww0GJafT3JD/Fve274W53F8
         /HUA==
X-Gm-Message-State: AOJu0YxcJcik8w2mkE5VmEpymQk6raw/pYrbHZXpCTZlRPZ2MNgG1O/Q
	+GbEW3cypzjYsNlv2p7OGtP16Zk17zip8R451C+UgxKpxi5Qg2CSAMCftoEea30=
X-Google-Smtp-Source: AGHT+IF2gh9s7ufTdr6aWFabo//dk/uCN6qDluG/c192KfugeaKu/KSk21Ep5cbSXZCxhc7tOHDkqA==
X-Received: by 2002:aa7:df83:0:b0:564:73e9:a9cd with SMTP id b3-20020aa7df83000000b0056473e9a9cdmr1569839edy.31.1708774906324;
        Sat, 24 Feb 2024 03:41:46 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id et8-20020a056402378800b005655c44ac01sm453779edb.89.2024.02.24.03.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:41:45 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/1] slimbus: fixes for v6.8
Date: Sat, 24 Feb 2024 11:41:36 +0000
Message-Id: <20240224114137.85781-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=454; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=q68fp9cxpUfcGl9UVjMSD1DJZRLv2hmSpRDMuo+MhVU=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dXxT7zUhB8tScbHSjBaS30pB6D61cKMEN3R2 ltw/ZhDuc2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnV8QAKCRB6of1ZxzRV N5DAB/0e1snZhSzqw634uxGRhahDKldEDKG20R4TtMiiBkrGailzLo5XCxFKs7nx7R13nfPibLl 3kFCAB8bh9Y8GFfhhj1XqnDFOs4GWLnbiWiOtDSaz4PlJGoHARVcUdGaFM2/xoUwYgM4CirM2tg LcqIp2HMsoB4pupmYQk4C5ECqinAKi1XeuwJhM8xkDnbr1wBEpBWf/VyIA0b0Efm5gJ3wx6W38S 1BuWgtuaV8d2a76mjDSCToAYASPCfR7yzw6rn3OEmtFZF+2FkwUUJeA2m9K05Jt6KRa9rx097Ea 4YkAZ5pEh+/dAUiK5K2Hhhfqtgr7ARewRNSNIt0oWJrO4gCn
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Here are one fix in slimbus for 6.8, Could you queue
these for next possible rc.

This patch fixes one off bug in range of logical address assigned to the
device, which is why am sending for v6.8 rather than next release.

Thanks,
Srini

Christophe JAILLET (1):
  slimbus: core: Remove usage of the deprecated ida_simple_xx() API

 drivers/slimbus/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1


