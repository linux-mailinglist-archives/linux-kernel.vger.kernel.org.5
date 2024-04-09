Return-Path: <linux-kernel+bounces-136855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6C789D90E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6D628A691
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D8712D77B;
	Tue,  9 Apr 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt5fXBfk"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19074F883;
	Tue,  9 Apr 2024 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665061; cv=none; b=d2OHnBbt64FZy+2Y3Oti7GA2xiAWHn4KG0oMxXHCC/qUA/H2XczStoeVmkD5lLf0lpsEqY9qYTEwIREeBrE+AeVNreNnrCZzoHaFQ4kSqJHL2TW3Gm2SrMr+6mcovfiOV3YH4tOu/ZpNfvjllg6YkdfirDqaSOWeqABetgo4gaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665061; c=relaxed/simple;
	bh=yTpd+BWqGy/dzKhGoAtCV3M5u9DuLZOaQnFsBurj/hA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hHsjUWJnCSY+DOf0Img3ZJCicWX6HFSMwxq7Mkd89gow0x4xxTr3PKUFy21EtG/PlH7Xf10MMwDMGHI5JdGvMA/OwIq+iPjwWHcMqOfx2A2MN/BpTtO/RZxFfX/q+mq4OH8DDpOYbdM53G6iOGSo4d3KU/UlhCHfC/pJEnmKV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt5fXBfk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so2055943a12.1;
        Tue, 09 Apr 2024 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712665058; x=1713269858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Jqx/icbU3jj6O8zCfgxgC+Ni+cIZc9toLFwd7zueOI=;
        b=Lt5fXBfkl+IKU/4tqZJITFwW69YkKlbg7OzveqkA5DfFCC2EG9BFxoiBATNjwnK3wu
         28FTc5XArVAaLNByI1+j2iH3gruMGLAn9oicdlOdSCsmU9kkbmgXrpBHbedovK4PTAv5
         wkl2aefTS7MBCJN2M4/Wtp0lXiBGjK62JOTsBlU47kQ4s92aOJkk0JCoBACkB40ltFXQ
         ZxeZAwGKl9o2htl/YBkqFpkj55s6Xi9pvC5bdA5GQMrWUbPum+IjStT97ZIwWI4k/WbY
         /+GAG1rJSQZgsawdiEfUM62HcS5B8GNHo6MJtp2gMXDAFLMTPcCFZDqE9cOC/vJ62BMQ
         m8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712665058; x=1713269858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Jqx/icbU3jj6O8zCfgxgC+Ni+cIZc9toLFwd7zueOI=;
        b=nryobRCXbJ8ANXL7iV3noYzk0w89X1js6X5kqjo5l+6SLsn0zia7onexGQeayalcsv
         15HY8xWlx0cpQyPnMWFwCqJZ2LwRUtRtts1EMMySajulE0b4KgBLJkoWiOWGO+Zj81/j
         kiLoBEXIarGQMmk5pqQeyf7mNKJo2Y9DcbaubENSU2cD9t/ZIStOM1uajle46uIbh1B3
         OftSeYYVdka5ORSql66jIfjDtY0KfnbXJTboLdHUOJCsXhPu/wdmyJ2sS9fiFJrZae/w
         K76IMjsprcvPgygQq7xFgu1223zihNUTtRL1Upevq/Sj6uA0f+p7k4JwvZQvjzIh6j5A
         nhvg==
X-Forwarded-Encrypted: i=1; AJvYcCWEpg+R10/baIOst3Jl3RFXbtFDQHLbjNiqchFk7tV92hBUl0OKHLWgnZK7VbRQxjVYCWzXAHVTbuiRESJmisRQzvdtUAt6rRJj/FdP
X-Gm-Message-State: AOJu0Yxe0FB/IWjygRZ0HNK1jgBn4tpWSPq+KC19p9et6rya9Cn9u59Q
	t2EqMyDzMZ3Mh+DAnCi+6Ju83Y/iO0F0QDPT4jZVrPvmXsovPc2JWRTpJbuIZH0=
X-Google-Smtp-Source: AGHT+IHb0aiM6x4hHUXi5dInTdRuPrj0DpsSGhZ+3F8jUx7rtLw7EPUKxknUPhwEqWysDtEgwfQacg==
X-Received: by 2002:a17:906:e0cd:b0:a51:ae52:19d8 with SMTP id gl13-20020a170906e0cd00b00a51ae5219d8mr6615237ejb.6.1712665057395;
        Tue, 09 Apr 2024 05:17:37 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch. [77.59.154.235])
        by smtp.gmail.com with ESMTPSA id en1-20020a17090728c100b00a51adace6ebsm5030412ejc.79.2024.04.09.05.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:17:36 -0700 (PDT)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 0/2] ASoC: nau8822: add MCLK support
Date: Tue,  9 Apr 2024 14:17:17 +0200
Message-Id: <20240409121719.337709-1-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

This change adds local MCLK handling, which would cover a case when a
reference audio clock is present in a system, but is not allowed to be
changed, see [1].

[1]: https://lore.kernel.org/all/ZfBdxrzX3EnPuGOn@ediswmail9.ad.cirrus.com/

Andrejs Cainikovs (2):
  ASoC: nau8822: move nau8822_set_dai_sysclk()
  ASoC: nau8822: add MCLK support

 sound/soc/codecs/nau8822.c | 69 ++++++++++++++++++++++++++++----------
 sound/soc/codecs/nau8822.h |  1 +
 2 files changed, 53 insertions(+), 17 deletions(-)

-- 
2.34.1


