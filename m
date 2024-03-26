Return-Path: <linux-kernel+bounces-120055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D31388D0F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1297F1F26040
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A1113FD8F;
	Tue, 26 Mar 2024 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOU073AP"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC313F006;
	Tue, 26 Mar 2024 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492215; cv=none; b=M3s75BApBP/1rL9wYnNhWSwm5NRkdf791pkjSDVobEoHraugR6uq8eqigyVTej0U+ZMvpbgHbS+ao7KVO1bwoNW3/WTxLcaCdmA2/rg66rd20CryQezbTH3auiLwAeIfwAhcpXe6m+Pw51/uaidqQj0diGGCQO/tOWUKQkVobpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492215; c=relaxed/simple;
	bh=QmVeROJQ0lincNy5m4Pr7PglStdcHgCo7503gRfib4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cECGzSlnzb8kD/YTwQMgpTkYRbe1mFRBwyL9Y7Av513YuoQlal4ToK+vO4Ks5QCRE9P1Pkz86bq+QMdZOntBc6kO71s9lAO8leL1aVjfzJK2we3Nsfxyvro3LNbtTw35Q/kE7JxdoE6C0a+lDKkC5aYTySYpzbZdPyIUDtmzUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOU073AP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so4090200f8f.2;
        Tue, 26 Mar 2024 15:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492212; x=1712097012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LQJQZwwgTr2u1m9ejwhwibmgi3bRpdcmBpljIJFhSk=;
        b=nOU073AP0KdX0qqb9Z/thlM4ZMQsjdsV8t/2+SrMHB30+nMPoEYJDMB9yCOluN+3um
         gpSbunEzMM8hR5cSnlW+Izr5er4/O/yqlKvz3tmRAuxq8UgLySS5YtDnAYskekgkPMzu
         hNYHLF9siCO/iwL1W05HyLjn3r63uPsXgwg7od/9ZeczrIqkb9ns6eArSa88eLonL+uv
         WjA8lPPgoXJbkVZA/7Lwy8XFP5G8ai8bY60I+3Vww46lA8sFl4O0vMld17SvMRpgU3Yd
         IELscmqT4iyANeYAMIlJgK0/eQCvI+4qQe1W8t2ONjFgvRvZtKRk7AWwIPHyjy6kXXsP
         n74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492212; x=1712097012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LQJQZwwgTr2u1m9ejwhwibmgi3bRpdcmBpljIJFhSk=;
        b=Z/6mOXq+dFZNoYytVPmhJvMT7TI/nQk8KDAhMPhWDziuMsZ3RqxOBD6czvQDVhozIb
         4uM19LeqNbnJJo9usUWs6BNHAsdBFQ4KSV8t5Ko/fyI9/ns6MMVMfp03tzOVD/gpK8m2
         Jic7issJ22wc8FWydbQ5jRc1M6Nqdxi6bwGiJ2nom2UX7iYZDhs1NDLi2G2hWMhp9nFN
         7FUup+UFgybF0Y/1SFgVxKz6tfZ5pE9ztZ3djNvsXWp0W+i9Cf2y7p75BHQCI+DM9AtV
         5PRz3yORi/RAz64fU/xO0YnkyjIweWss+WpEDU3SP5eU1Vok71hOo15xy2WRcZjzAGwd
         mE7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUf93Sp9dK5hgueEcl2eh5fQUOrYygV/gNPysP8xBQRdVqSZdnP98Mg03UdAYIPq/tbM1A/fF3m7XfhQcv+Bb0ggPH0fVYMBTaUy3+ZuKs8yEHS6wJvimMkSYK1ZAJWCRT7zYW0s4VDi0fYtbWM7t/2RR7plH5MIexSxX6zoQfuOLdFu2M=
X-Gm-Message-State: AOJu0Ywrzjo9d0rfHDr7VSQ1FFTC3eMUEq8pWVWdrFWGZq6pvvCr4+N2
	eJ7t35wmTaZluXXAzUrW/CFejCDjxbrRNruT5pn3BH6RmzaF9K8K
X-Google-Smtp-Source: AGHT+IGFop1rfyOa3Etq788IIziOHriMpNXijb1nTDHg9zB8DC6W8pChR/LTy4mbgyV4cbXiDJWT+w==
X-Received: by 2002:a5d:51d1:0:b0:33e:6cce:c2ea with SMTP id n17-20020a5d51d1000000b0033e6ccec2eamr9089661wrv.51.1711492212359;
        Tue, 26 Mar 2024 15:30:12 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:90ec:252a:cdf5:54e9])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b00341de138a2esm600647wrb.94.2024.03.26.15.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:30:11 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 11/13] pinctrl: renesas: pinctrl-rzg2l: Pass pincontrol device pointer to pinconf_generic_parse_dt_config()
Date: Tue, 26 Mar 2024 22:28:42 +0000
Message-Id: <20240326222844.1422948-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Pass pincontrol device pointer to pinconf_generic_parse_dt_config() in
prepration for passing custom params.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 9bc110b00cbb..d64a441b4f55 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -611,7 +611,7 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 	}
 
-	ret = pinconf_generic_parse_dt_config(np, NULL, &configs, &num_configs);
+	ret = pinconf_generic_parse_dt_config(np, pctldev, &configs, &num_configs);
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1


