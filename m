Return-Path: <linux-kernel+bounces-151262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9A18AAC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED834281B89
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B0512E1C9;
	Fri, 19 Apr 2024 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FB/5ZZWX"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530812AAC8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520180; cv=none; b=PmxVyghZ3XHXGjb76IzVTJ5LxaVJaUQEr3cB/qwipoIVrlX9npY+c6K5JUOhZhB8bDE/+M0PLbL6Jq8bOjXWVZ/fKJLwY744g8sVX51w5Xnt2SjIBKAI4TlY6lnXZXl3zLefyNg7hIvSfJZcBwZ4BwPpOAi1wdJVEe6TWnfashs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520180; c=relaxed/simple;
	bh=HnkZzu3hOGP6WP/z/J628OEomq/9kbGj6cjO+bxIfdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H5VnyQ7G6HpL4z95pou2v5dolRP8pPeKMeOg9yHaP1DUux4CM69pNRl/5mJnSW1YDAw+jN54khq2JWzdAexbNPpn8FCYGlcaUSIpSpRHnfS5PVfwfJ3We49fdSP6PkJeC0wsb0AnHNQaWNWXF9SNbmgWzlR6SbWjjdsODn2EkvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FB/5ZZWX; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78f04581a66so114768685a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713520177; x=1714124977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXXgUMwvGuh/bAZ05Vu9f2lIZUwmSZiJ1Ue2E9QmyGE=;
        b=FB/5ZZWXHSbh0bTNV0KIpvoqfHUagCPy4DSzYSMyCE2L5FJ3ZXEthtPd2Ubyu201l0
         +4iuUuFrP6ntwGGlQmy/VzI/1nKl/giD0Ei3VyJ37dIEsS0hyhVSXsjCQY3WEdRpj4wr
         hgdwG3onZR658pM5JfdJMaP0iQYCtMiyWK4ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713520177; x=1714124977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXXgUMwvGuh/bAZ05Vu9f2lIZUwmSZiJ1Ue2E9QmyGE=;
        b=h7XCq8He19B1uf20KJkRFRI1T+MMptI9FRdf/j5qww5ZgY2JQHn5VloUTr0ePUn5KH
         7H2cfh7ntQrOhqAZKaZl4c83y4ZdqbCu6kympHTftJJb5TKnhL770fa4hx4D3pWD4TyI
         yZlGu+np+9t302mOVwhUIQb9OfzPckQwygH3836C/KlyA8/mwrD6B3ribb+wHBwwgXuL
         Idv6VSast2mv4T50K+Tf5jJNIPfw0mxSIdLSkiNBvZHt7mIUrPyYpMVKmSOv/8tX7sBU
         DUgzB092Wt1BRmMLJnQw4pyWRYdhLULj+52Lhe34tA9dENSr5Ts71rXHyeRpW9I7OTJZ
         jldA==
X-Forwarded-Encrypted: i=1; AJvYcCV85roblJuTja1BmsNcOk4YXsvFMa8JOYLGbwi2z/mEPl1rwN6CUlJQaBtGUDX/a2l+N7wfIomwWQiXBiECRt+q3H6fkfg5llQoJGvN
X-Gm-Message-State: AOJu0YxRU5Kf8rJr9VvulZ+sCaZLWB19BU+vRQdpSd3PQ+Etyb/kIZe6
	6Z+V7eu2BSBnMB/4hN5nKYdXjuCG2bDUlyRZxfshD+R0C1BxhaD2Mfi4Vy5HrA==
X-Google-Smtp-Source: AGHT+IHtaefRUDCkJpXsh07H2yA2NeK9gO3xvd3htQb2Rtwe8WSp0MnWmceFe0R4rsJzjkJBUbtDcw==
X-Received: by 2002:a05:620a:111a:b0:78b:e8b0:f156 with SMTP id o26-20020a05620a111a00b0078be8b0f156mr1546954qkk.67.1713520176717;
        Fri, 19 Apr 2024 02:49:36 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id dt14-20020a05620a478e00b0078d735ca917sm1434532qkb.123.2024.04.19.02.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:49:36 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 19 Apr 2024 09:48:01 +0000
Subject: [PATCH v2 15/26] media: netup_unidvb: Use min macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-fix-cocci-v2-15-2119e692309c@chromium.org>
References: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
In-Reply-To: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
To: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hugues Fruchet <hugues.fruchet@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>, 
 Abylay Ospan <aospan@netup.ru>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Dmitry Osipenko <digetx@gmail.com>, 
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
 Sylvain Petinot <sylvain.petinot@foss.st.com>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Simplify the code.

Found by cocci:
drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c:138:26-27: WARNING opportunity for min()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c b/drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c
index 46676f2c89c7..1c885d620b75 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c
@@ -135,7 +135,7 @@ static void netup_i2c_fifo_tx(struct netup_i2c *i2c)
 		(readw(&i2c->regs->tx_fifo.stat_ctrl) & 0x3f);
 	u32 msg_length = i2c->msg->len - i2c->xmit_size;
 
-	msg_length = (msg_length < fifo_space ? msg_length : fifo_space);
+	msg_length = min(msg_length, fifo_space);
 	while (msg_length--) {
 		data = i2c->msg->buf[i2c->xmit_size++];
 		writeb(data, &i2c->regs->tx_fifo.data8);

-- 
2.44.0.769.g3c40516874-goog


