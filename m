Return-Path: <linux-kernel+bounces-135009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DF789B9E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546391C216C5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438D350261;
	Mon,  8 Apr 2024 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECaDEgO5"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D5436AFB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563821; cv=none; b=PhgKEgoEdbKY3tGB+W1kEEo8Rv7KhpIz2Z7ErFlQD86Uo9BI6gk1YdUhvVdsY5Yl+jgPcV+5f6rQLJ8ek6FB81nxSCCpVQbTyOXB9P3z0ZF/t5SQx1Y+oRPVEmXaRKdX5i0NE/PfqsZJ2aE7cEY7/ZlCDFbDaCM2amyd0MA18vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563821; c=relaxed/simple;
	bh=RRyqPnteX9svo/FeqH7qejShvl+Wu9J6rtShURC1Bwc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=huKhYaju5dshkOhf7nONDz0aW9oqLYjyoYzd9mdKpZ+SgT1+Kvc7nMU4Q54NpkR2MgCUKryTXhL/sCex/ufozMqmT1WYViFoAWW5rxTBBrQPaLTcwOrcp5+Yw2mxWDYlv1HRa7AzmEDL/VPSbzqhNR7ZC8Ykj4vXb2CWa7mEasg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ECaDEgO5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a51d90def9eso57297466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712563818; x=1713168618; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrHqjLybF7CJnuNHXKR+lEoGvKA0pqz74L9RRTV+fT8=;
        b=ECaDEgO5bVhvHkPP0coFC3v9GyoLAfoYLjWAQ90iQBKh9meLoBGsM2+DeO0ebiE9PB
         zc8BxPE61FnUzDa/XQE16HfiFPJXCcn33EuCD4GXc0P2NTWmRl3S5CtHhRGf8xsS2Udf
         jsFI/cybYV0cI1gowI7LfP7NuPkrZBJOPqvsKfIEeYqfpm/3x0jZkYSno8QbP6mUtALw
         SIn7wodoAD1gpXjrRWl2qoZ93TCygzssTy/F0V/qbCiyJ8stk+xslLI0Pk9BMIG69AWv
         D/rjxkSW+2KYBjaD4qaBTAMZ0cJnQ9V+uUWKoU0hymHSbMP7hjJdU3yseyf2nNSpDgyQ
         gp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712563818; x=1713168618;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrHqjLybF7CJnuNHXKR+lEoGvKA0pqz74L9RRTV+fT8=;
        b=I6AjwakTqzeal5k9CReZtcyFRWxiYEXqo6NiCzstIljY03K5Deb7aazQLlJhUXW/GL
         unMoshFBoP8bhNH01Paeqwef/0eqEw7Fb02JesngIbS4v80lPTi40UWdAtKX90vZsU58
         /Bbc6zQZpv5httzCWX1RfrfpSzJSqjgZ/X/gZKMJ8ctlLfyK52YHjUY5b9f2Q4iJ4nyx
         JbpMKgHAvs7brhDNQasY5AYY4+HJBK5qmX3l+2jYZX8incmPCO7Y+OLUO7tq52HnG2AH
         5iyVPTJPqd3TQ5c8tQvRNMECkLdwI1PshdlQkh8yKe0Ii4751S+GljatPg+/+yc2emNk
         3tvg==
X-Forwarded-Encrypted: i=1; AJvYcCWB/FdP+7QtYFbtgyqN7V83F8bnhQVLfLGElVZQZj/ug3Dh/F/3Hk/A/dQjrLVExelCHtwbpVkPQOy1QsYrcCguuiKvwrkSSlhVctVc
X-Gm-Message-State: AOJu0YwvVO9Dq7qFTD9s0XOBgcHNWwfZpo+28s1CHfpDQL6GaTybB/B6
	LLfm4ZqJhseDoXjhMdH27SKqHGn/HZKTpKGxJWQn3f0K7FZQJNL0Oau5CRFdfJ0=
X-Google-Smtp-Source: AGHT+IFaWJ0ko+880OE4+Ydorjjhc+EVFX8MZM5sS9kOSFgetr0n6d6xvsAp8RTPVZNNLK44nNU7nQ==
X-Received: by 2002:a17:906:fcab:b0:a51:8a78:d2ff with SMTP id qw11-20020a170906fcab00b00a518a78d2ffmr5620413ejb.34.1712563818217;
        Mon, 08 Apr 2024 01:10:18 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id my46-20020a1709065a6e00b00a4735e440e1sm4149587ejc.97.2024.04.08.01.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:10:17 -0700 (PDT)
Date: Mon, 8 Apr 2024 10:35:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Brent Lu <brent.lu@intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Terry Cheong <htcheong@chromium.org>,
	Uday M Bhat <uday.m.bhat@intel.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mac Chiang <mac.chiang@intel.com>, apoorv <apoorv@intel.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: Intel: sof_rt5682: Fix uninitialized variable in probe
Message-ID: <6e16433f-1897-46a2-b3ee-e177e7d846b8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Initialize "is_legacy_cpu" to false to prevent an uninitialized variable
bug.

Fixes: 8efcd4864652 ("ASoC: Intel: sof_rt5682: use common module for sof_card_private initialization")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/intel/boards/sof_rt5682.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index aadd341a202c..966bcd3e8bdc 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -606,7 +606,7 @@ static int sof_audio_probe(struct platform_device *pdev)
 {
 	struct snd_soc_acpi_mach *mach = pdev->dev.platform_data;
 	struct sof_card_private *ctx;
-	bool is_legacy_cpu;
+	bool is_legacy_cpu = false;
 	int ret;
 
 	if (pdev->id_entry && pdev->id_entry->driver_data)
-- 
2.43.0


