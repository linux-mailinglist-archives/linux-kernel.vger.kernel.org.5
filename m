Return-Path: <linux-kernel+bounces-153171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43828ACA8C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80721C21093
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5D13E8B9;
	Mon, 22 Apr 2024 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b5yt1zYl"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E513E021
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781528; cv=none; b=C1bV+HTEMNEvcPct1jcOnrfH/f2NLawy7e33P4t32NBvSQ35BYmOSGaHl6AUmDJ3/hQkkDm7CCnySTKNo2hknYHChqxohgBhSL42TgzL021LX7Pff7XQRtDXRDzVE3jYQoAyZCMrKbPrVF5M7BE/o9NNymFTI/61gezlKn/wxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781528; c=relaxed/simple;
	bh=jJqY3EzcXGU+nKakTn7MTvOCbow73aPwa+neDvl0lh8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XsWkWl5FO9n98JuvRxT2BY3sch9LhT/S3EtB1pITqjdT7DtsdH0J1rwUURbsOkgNzwxTmcrwHmqoiWHFSTige5ybqog6XKPjphDvL9q9qHAwUFZRx7NRJUnZHHP/A9/WoZ8ZJMNhYxMXLmnVo0ZW+i6BMQJMx99pwQjzh0gZ7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b5yt1zYl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5200afe39eso460516966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713781525; x=1714386325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjOFtSdcuWQZYN13n2HXTmueHu30sawDV2mP2f/7YqE=;
        b=b5yt1zYlTK/gPb6cEjOq/3J0TN0egOXVIQjvE4tWCelmB0HI7P4bBEc39GySaFNB+i
         WtB4lnLZS/2xTztLeLRwWhA/niqSMy3AlOf3MktCrxTSrZ7HKLtSwjSs5N4uP1U3Weaw
         H5JBVPKtzHgQ6KVyQw5ObO/ZD5CswaJ7Yi812kmjzgMMzBpy0VBMDw8kpzZ3EEhrHgHE
         3vCuLUs0Y/7H/lH7RHO2RzuDmrxauDlliNE4VRmbYI/cEEQ52csVyhxv1s94iY0NYEh4
         dXU3oeoC5gfykcQZ0DibYURmyiPxeIm4X6Woy31emwt9sn8koLdLgR4PGXhh0JzJ0pRB
         XQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713781525; x=1714386325;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjOFtSdcuWQZYN13n2HXTmueHu30sawDV2mP2f/7YqE=;
        b=cWWaiG9ZOB7i7rsxIM6+Gr0mdCzQkfUpz1oSG9kyKkYYAJR/E5FSfMLqKraMz6Ubmd
         eURErEYhjQntjLabwH72e5MyUoCoLtnC5r3YbFxdmP8v797EgKeXtk2+qePpqtgCbfV7
         Kisg9FXOnQndUAqUaN7ijvp1vkIcNdK28j5vOhPG5JNqaAUkH2nm2rTESyGslIM5rK5u
         iEcYimiZStpsqrKnN6XncCZsga0/U32CSJTUkpQJYKIvKykpAKjnShWee5Rw+qut1TOY
         5eOPCYEwxulEplXNwqi4qig4VWzN/dTmf+Jxfmuxzf+OWMl+t6KDVoE06zpA+2JdZGi5
         TyDA==
X-Forwarded-Encrypted: i=1; AJvYcCVzhSHch1AFB0hi4C0C9Q9d83mZ1Hlxl5N2M2LjU8Rbb6jFO/5TFulB5I0Y3VtfKfDRFgrRf22I7EgLOFYpCWd6Msn3y3nb5RzmGyQ5
X-Gm-Message-State: AOJu0YxofNPMIaxEfMUsJ0z1JtVbA7WoEzWwt6eNlapY6SQMiUukIWJk
	cbIqKtwSSlNkcq4rTwlOEOn0Ffs/TENKb6cPlFTq3Hw5EWWSDuf8XPB7UW/Y9vM=
X-Google-Smtp-Source: AGHT+IGJbFE/xk27S/lBooXeZazvrQf8V1BxKpteLDJyf6SzZbXaMCLpiQbsqNz9JHTqiEI/1HgXqA==
X-Received: by 2002:a17:906:3ad0:b0:a52:57a6:2f45 with SMTP id z16-20020a1709063ad000b00a5257a62f45mr7820235ejd.21.1713781524763;
        Mon, 22 Apr 2024 03:25:24 -0700 (PDT)
Received: from [127.0.1.1] ([62.231.100.236])
        by smtp.gmail.com with ESMTPSA id k18-20020a1709063fd200b00a524b33fd9asm5553172ejj.68.2024.04.22.03.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:25:24 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240401-imx95-blk-ctl-v6-0-84d4eca1e759@nxp.com>
References: <20240401-imx95-blk-ctl-v6-0-84d4eca1e759@nxp.com>
Subject: Re: [PATCH v6 0/4] Add support i.MX95 BLK CTL module clock
 features
Message-Id: <171378152318.2944518.13528932834119248200.b4-ty@linaro.org>
Date: Mon, 22 Apr 2024 13:25:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 01 Apr 2024 21:28:14 +0800, Peng Fan (OSS) wrote:
> i.MX95's several MIXes has BLK CTL module which could be used for
> clk settings, QoS settings, Misc settings for a MIX. This patchset
> is to add the clk feature support, including dt-bindings
> 
> 

Applied, thanks!

[1/4] dt-bindings: clock: add i.MX95 clock header
      commit: 977b07f769970aec97b907cfc93fb681ecffc9fe
[2/4] dt-bindings: clock: support i.MX95 BLK CTL module
      commit: b773f5ad2bfd2d00bd2c5ea7022bc5b86d23a1b7
[3/4] dt-bindings: clock: support i.MX95 Display Master CSR module
      commit: c6e87b066756ec4b3f5f9061b508f3bd724ec652
[4/4] clk: imx: add i.MX95 BLK CTL clk driver
      commit: 5224b189462ff70df328f173b71acfd925092c3c

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


