Return-Path: <linux-kernel+bounces-8421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7DB81B6E6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268C71C20B66
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341C5745E2;
	Thu, 21 Dec 2023 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGKHlCRt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A72745DD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d4103aed7so3594405e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703163800; x=1703768600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RV0pLhc1eNEl1ZlcZJjaTsQkbCWEhiomsd6unkLFjqk=;
        b=rGKHlCRtA4ArjWFndzqlKIVP3vp+6PJIY7OVbvjbhuXKfokId2z81ly8xoWl+LFvXj
         0k8nfAa1QL7oRSIhsCVcMOGZzDmciJcL7bqEZar1GqL8SoQhHn0JW9HhabDRwqR9bFBJ
         u8mWQmhJ8joPnIOx6yLO7ba8PjWNh2WvDBjxekcvceLhHjxzo9zHKMJpnMDbdRk+GA3W
         8HXbWezTGoKGEG8ubhp8RccyYWIzUk16MoOXWn+wI/nwi9iyeoYzKyMQFszFTwgx3Dov
         Evm7iST/Boqoenrrwv1mQ5PIdoXTivKjILGCv+bZ5bbNdD3XSlFNjKNijMtW2O1DcTuV
         BXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703163800; x=1703768600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RV0pLhc1eNEl1ZlcZJjaTsQkbCWEhiomsd6unkLFjqk=;
        b=onxmKxOkzfN/ABaEUhZJ90QYI+tAiDh+cU/gQEo++/VUG4jZWtEwhEtptr94AFv0w9
         /2ZNK2ysn4vw8XValDaoOAOLtX9AfVP/ln3vgSVT3FG3ZQdUN/mXtQUYyxz3l09OvxDV
         zv1MNKUPfjsAyg9frTzPVdgXvFhtqD0sU7IAKXnLQd/lP8XjlBHaNAE8svr7ygS/ekma
         W5O4RGaOpVqxXJkKl728fZ6r1xPvSyBROpuU8QaGD5eNOZMqfSftC+/mOv/MSq0FT+Yy
         h5gTWBl2J0fknUXl8Eh+GhRJxuaQ/E8cZVonTSJ+Xr3ZrpjuPrUQHsr8Uwmm0whLzHDp
         w1qw==
X-Gm-Message-State: AOJu0YzOwJnWVuXlvpx4iKY1xvvcBAseqo36rHHkqTEA77RPc5IaWBs+
	vDbfGAlIdDJgZRTRv0dlcuJLYw==
X-Google-Smtp-Source: AGHT+IGKsaJTN83KjRRHH8cCmgQL1O4crtaE1PWiINYVCRwM7jAdDKa1rYTlbRJxuhg6htojieQNew==
X-Received: by 2002:a05:600c:1c10:b0:40b:5e21:dd49 with SMTP id j16-20020a05600c1c1000b0040b5e21dd49mr770884wms.119.1703163800473;
        Thu, 21 Dec 2023 05:03:20 -0800 (PST)
Received: from hackbox.lan ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c4ecf00b0040b36ad5413sm3229791wmq.46.2023.12.21.05.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 05:03:20 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	shengjiu.wang@gmail.com,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: pll14xx: change naming of fvco to fout
Date: Thu, 21 Dec 2023 15:03:07 +0200
Message-Id: <170316377039.2868388.1010743948171671677.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1703068389-6130-1-git-send-email-shengjiu.wang@nxp.com>
References: <1703068389-6130-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 20 Dec 2023 18:33:09 +0800, Shengjiu Wang wrote:
> pll14xx_calc_rate() output the fout clock not the fvco clock
> The relation of fvco and fout is:
> 	fout = fvco / (1 << sdiv)
> 
> So use correct naming for the clock.
> 
> 
> [...]

Applied, thanks!

[1/1] clk: imx: pll14xx: change naming of fvco to fout
      commit: f52f00069888e410cec718792b3e314624f209ea

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

