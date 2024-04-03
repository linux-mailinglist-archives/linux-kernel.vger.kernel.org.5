Return-Path: <linux-kernel+bounces-130697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B718F897BBF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A05C1F26178
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6991155A56;
	Wed,  3 Apr 2024 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQsTKsvP"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649015623A;
	Wed,  3 Apr 2024 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712184202; cv=none; b=g9hueLZlPGNGtk+5kHY1ue22BJTCd5J5wJ+R629/5x2+dRSgA+wRyEl9rUaZZQRzPz22mvDbO4Ie8RVbmn8KChBdYCtHQn/rvT6vapJ9MwStNDHwJPk5OVk+5IPGHhrw2kPMYWFPtKJsfkQYcNOpJJf3tgb8U+noyiOJrgpUEzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712184202; c=relaxed/simple;
	bh=i83YdIPPx0R/zg6nAIJzCB1vAwrQ7TEYddQ6IihpENM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gwPVSPD82mtGAPIqynv+pQgOVVGSX+PXo9rl7G50KJF9lH/mDEhQn1QuVpt+fB7XKF6YfDBZQhHGc1HPKXL0sht8HUXOJ2ri89aZISJYH7McohUJwR4WtabECMhy+Qk1agxorsT1oXNrBoe6s3G/hoaEWv+PRFl8mhXWPK3iUDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQsTKsvP; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a47cecb98bso260872eaf.0;
        Wed, 03 Apr 2024 15:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712184199; x=1712788999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1/DXUBEvuqpvW9vgHBUj1lOdo7CYu69Q0rcw2cg02+k=;
        b=SQsTKsvPrPSCIV412FfI6N/0E5ZYD1zVKbgeK4QzjugxGtgo2BVF4Q7TMvwWgOn89T
         EeQvO9c+gGajPIBoE+lH6HvrkyExBobZUDrxKWidKzf17IMJQsPgtmrM7FLcJL+qX5rZ
         TSD6QAgbCsbKknQ6TWRN/PkDWjE1N4L4o9d0nWHMTeOOPYgfPwRTe0A5u3P1UzIplL1X
         eXC96B+sczZx4mex/AyXlJi7cQpYzCbZVsljy8CaVdmMRZuU3+SXQvKtBDJTFiStDEYs
         o8idLgXDEEoDATml8znT5egX7kocA1ZOgpEUNB+9KmLfTEZ8rVWNZlOeupPqsP7cTo0D
         4NNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712184199; x=1712788999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/DXUBEvuqpvW9vgHBUj1lOdo7CYu69Q0rcw2cg02+k=;
        b=Hiit4BaHnmzma/NM3gIttVfrR3YYo+fmzOxY0i59Q8FqsNGyq0L42kzIrnQt8qxW2e
         wE/6NXDa5hqVAthwd9yTEzEOF81qPiaYbxL5iN6y/e2ucvwltl8GIxFVHksGHyAQB74z
         1DleatuVlWL3/rZK+SIC2hnzUkMrjQKvf2i5c2dAyO841usxyZX/umCqWpQxYeF3uuC7
         J/tYP9gkDeE170siDOK0O4Kzjwj+3jusvPTX2xbCUCYm75yb6dESlPLkr7iE3yr33AL4
         eVkZ4pGaN1+cRAYE9F6bFpR293hULKWHJqdDYP8SgNNqn+pAWkZiGvCm143aRkrRyn56
         xmTg==
X-Forwarded-Encrypted: i=1; AJvYcCV2Efxa36iuyY6F6AgUzzueeOxFPbKW+olJrMPW67ZA7YuZS/LyarnfSMw4L5trkM6M0Mzd3zAQir8u8mp7p/kw4PLu+zEN5Qj2dvNqUSgBUR++A+hasP8tWb5UjiAMmba2pnkIfBVt4NmiVmDZKuRrEPi34rviw+qvRVkx52gJsty2
X-Gm-Message-State: AOJu0YyRGQFaw2dIyXAOnnGPk1VBX+kgzPuSdrDD4LkpLEWUNXfYeN8g
	7ikOCvTKS1ITQfQpK6Ly6FfArNt2AoFAsIiXr+g3+hAfXiv1fCyn
X-Google-Smtp-Source: AGHT+IGGiaWtu7HMckdPJc+ewu+TUaApVj6Bfhx2mSVpxVK2P7yAETpnx6+RfPfIS1VkdOFk5JiQTw==
X-Received: by 2002:a05:6359:4c1a:b0:183:90a2:f4ce with SMTP id kj26-20020a0563594c1a00b0018390a2f4cemr679434rwc.0.1712184199519;
        Wed, 03 Apr 2024 15:43:19 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 13-20020a630b0d000000b005e840ad9aaesm12184383pgl.30.2024.04.03.15.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 15:43:18 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-doc@vger.kernel.org,
	workflows@vger.kernel.org
Cc: apw@canonical.com,
	broonie@kernel.org,
	chenhuacai@loongson.cn,
	chris@zankel.net,
	corbet@lwn.net,
	dwaipayanray1@gmail.com,
	herbert@gondor.apana.org.au,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lukas.bulwahn@gmail.com,
	mac.xxn@outlook.com,
	sfr@canb.auug.org.au,
	v-songbaohua@oppo.com
Subject: [PATCH v6 0/2] codingstyle: avoid unused parameters for a function-like macro
Date: Thu,  4 Apr 2024 11:42:52 +1300
Message-Id: <20240403224254.10313-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

-v6:
 * collect ack of Joe, thanks!
 * refine docs according to Jonathan, thanks!
 * add checkpatch doc according to Joe, thanks!

-v5:
 * Simplify the code for Patch 2 according to Joe's suggestions.
 * add s-o-b of Barry according to Jeff Johnson
 v5 link:
 https://lore.kernel.org/all/20240401012120.6052-1-21cnbao@gmail.com/

-v4:
 * fix Xining's email address, s/ma.xxn@outlook.com/mac.xxn@outlook.com/g
 * fix some false positives of checkpatch.pl
 * downgrade from ERROR to WARN in checkpatch.pl

 Thanks for Joe's comments!

 v4 link: https://lore.kernel.org/all/20240328022136.5789-1-21cnbao@gmail.com/

-v3:
 https://lore.kernel.org/all/20240322084937.66018-1-21cnbao@gmail.com/

A function-like macro could result in build warnings such as
"unused variable." This patchset updates the guidance to
recommend always using a static inline function instead
and also provides checkpatch support for this new rule.

Barry Song (1):
  Documentation: coding-style: ask function-like macros to evaluate
    parameters

Xining Xu (1):
  scripts: checkpatch: check unused parameters for function-like macro

 Documentation/dev-tools/checkpatch.rst | 14 ++++++++++++++
 Documentation/process/coding-style.rst | 23 +++++++++++++++++++++++
 scripts/checkpatch.pl                  |  6 ++++++
 3 files changed, 43 insertions(+)

-- 
2.34.1


