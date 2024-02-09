Return-Path: <linux-kernel+bounces-59332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E4584F586
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D98E7B25F08
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A20381DA;
	Fri,  9 Feb 2024 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w1zxl2Da"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923BC376F3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483744; cv=none; b=iC5KtqY5wqeTHbOaa8+zMdF+9LDhgO/ysJ5WyH7i5Mo4JT7v7ouqHMZEKN3ozcAhIltm2eDa9KR+tk67i+Eo1jrBAX3Oi62EOzR1l6qZZKAM29mxHcmKqT9LJLF10xIqx7kwtxW+NsdO4cNi0J0lrB8S9WGI7jbD+AICc3Mo1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483744; c=relaxed/simple;
	bh=f7GZuFfz/b9JhqGQIt1IzzcdKqz5xKX7YwzzJ1JOQlI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CE56WspSaEh4CRLqogCP9p+1VBnxofz7I1oTzRM1Gi4fOoPqPel0Wkyp0gk2Ptstw5A0ld6UXWB2pkTODDmKDIL06jrETX1MhVzFrYO8Ly8BNcN7fOUwGbUhu5vTSgbVBOtpF8Eohi+VIcL3Snnnx2SPnAqhyxA3soviuR0hpDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w1zxl2Da; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3566c0309fso107910366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707483740; x=1708088540; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUKtKA5PQgc2ohgTX2ul6KjbHH8/opO9tMZEq5ncFHI=;
        b=w1zxl2Daeu+MVSdys/IkYIh3vl7eRT+PN9CSZURPiRHCoGdzfHVgUWzAEOo6c2bMRP
         sWV0WI6FOzDkgt9WFYgB5iizAjP1LOft4GHoCIYqoCz+JpeA5F3KdJu8UgZwwtujj0Ol
         gHGDoknYAHTgpCvd2QJDAjKj03PY4zoVpm7w0Au5KZ739tWj3cXFQSVLlMkmccuOmM0D
         HJRpoNlb6/DGvDeLGaofritegYHypwWRBEq1ksVMEhiQ6T72ps2mCVan1BqXbbrWI6u2
         oA8UWxgJgJYSDPC945WgJ0PRIu+uL91s9Yvd7il7f4PqqiCgHznBwji/WxakpOVvi9Hg
         YRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707483740; x=1708088540;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUKtKA5PQgc2ohgTX2ul6KjbHH8/opO9tMZEq5ncFHI=;
        b=E3KDmjSS9hI+kqdIYMDKM6OQ2Msu1K6FM89mR+vtrpo8KEcUgrYeBgHCE4ubX2zlp2
         h0rIVnOWvx8TtA8PqQ9Y76jI0wC+ns5BFyEnvuIpU7SDsyJUq9U361iz15OXz5/t218x
         tr9fuQu9Mu3khMfy9aK+c21psvYp07m32v5IpEBR41k7iU4EosNKmr5DJsioZmQY3VrF
         4tJ9j6d7ksjspE8hOo6HW7LGD7TjaXOq4k1dFVS39g2Vj1PosWSMsXdCveeDAB0xL4cK
         BqwTHx/+xZBWuLdD6b6Dk2zVxNOQoj6QFGdA5S0/uv+O5W1OOErFT8F6T+sZNW3qv9zc
         +yIA==
X-Forwarded-Encrypted: i=1; AJvYcCWNitRwhPC3nRBit1oIJQ0JyeApm1nLjdx9s56PdKoEh77Bql+quxYe9k9pPg3yA85xTOy84zSyUQaItQrkEIGw1wwuwlEXl5fCqOji
X-Gm-Message-State: AOJu0YwYSjJImLp1HYDwYvI3Rw4w7idMoePytFDMxB5cZgp8IqyR4xC6
	driuRwoMTwhlAJb0BdD+Ojr7tNezmOyX6JuApAf2bBYkUmhC6kQKOMpEEGsBvrQ=
X-Google-Smtp-Source: AGHT+IFVhkx7LhzyB7e7l1QguxXFgUlo/kYuQodTA9Wx4dGpn0Unm/Z4m0tI6DXnNy9amLuIQwAwDg==
X-Received: by 2002:a17:906:c28f:b0:a38:3ec3:9379 with SMTP id r15-20020a170906c28f00b00a383ec39379mr1033826ejz.44.1707483739784;
        Fri, 09 Feb 2024 05:02:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfmM9ZYYYYAhCtOvAd02GyyM2a5rau2KzAaKyzbK+sHeXX4dGwyEmZGCbR3tEQdYmFuiJKImr+m84uY2IGqSwC2XdPT4tGDRj/UiG8xPfRBr3qSmi9t8EkeelvN5WeXcrlIhHutkJe2GSCNntNuEhlaRTmN+nUTe2F1GJFhAPIgUejYLaRwVa6YEIfS++0/T18Z91kebqOE+xPvU9TaZz6dNp31q+u7DTbfDPDDnTAdkykemR3wqxJvrsbZe2AWQR23+TU1jrGNzdQwVeTOyxG00xSRDF9iIRC46PWTexGNYn1Aj0fulduoMjBphpjFxXE/+qKVvy+ASWixuzyB6OrjnEGri3gkUj0F+PWXOP/9OITnkMGWkeN3oH33XwV1VvoAH7giyC63uLZkhUJzbqL10g0GA2gPczDwntPVPKVCsLBcXVLSUf6AItX875IBKnwSTZnjhwz5GmbrKXCGpFPmp7AGNEDGurKfB4nbdAf2Lcf5PIxOfXeM4F1o4JNCt0i5TNcnMXaSYDE7JTuKELTebYZg668FA==
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id un8-20020a170907cb8800b00a37669280d1sm740179ejc.141.2024.02.09.05.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 05:02:19 -0800 (PST)
Date: Fri, 9 Feb 2024 16:02:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: SOF: Add some bounds checking to firmware data
Message-ID: <5593d147-058c-4de3-a6f5-540ecb96f6f8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains about "head->full_size - head->header_size" can
underflow.  To some extent, we're always going to have to trust the
firmware a bit.  However, it's easy enough to add a check for negatives,
and let's add a upper bounds check as well.

Fixes: d2458baa799f ("ASoC: SOF: ipc3-loader: Implement firmware parsing and loading")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/soc/sof/ipc3-loader.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/ipc3-loader.c b/sound/soc/sof/ipc3-loader.c
index 28218766d211..6e3ef0672110 100644
--- a/sound/soc/sof/ipc3-loader.c
+++ b/sound/soc/sof/ipc3-loader.c
@@ -148,6 +148,8 @@ static size_t sof_ipc3_fw_parse_ext_man(struct snd_sof_dev *sdev)
 
 	head = (struct sof_ext_man_header *)fw->data;
 	remaining = head->full_size - head->header_size;
+	if (remaining < 0 || remaining > sdev->basefw.fw->size)
+		return -EINVAL;
 	ext_man_size = ipc3_fw_ext_man_size(sdev, fw);
 
 	/* Assert firmware starts with extended manifest */
-- 
2.43.0


