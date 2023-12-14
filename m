Return-Path: <linux-kernel+bounces-106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE434813C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40AEAB21D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C4C6E2B5;
	Thu, 14 Dec 2023 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fph0oSnA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8142BCF6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e2f9e9a2e8so19447207b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 13:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702587896; x=1703192696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XaEePl5RQ+VpxipxnsU9kC510VbER/cFKzlRYB5eqEk=;
        b=Fph0oSnAZ8YTXVx6MXfJZUcdj7nlFgIdvTjgZRZOOTycAgTsA5nmFsZUdMlCUY0KDj
         ECSOAnVkvL6Bu1UXlQQ7pmstkoWjAIH2BTQn2EJiIyHYgfa6IexE3nEcsYJVTzyFlynM
         CdAbHX+fFAHV0zqj0wEbF3KfGcbQ1w8TeN0yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702587896; x=1703192696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaEePl5RQ+VpxipxnsU9kC510VbER/cFKzlRYB5eqEk=;
        b=prFRQNBpu1G9pCnwWPtBPzoojjnj5Zk+xaxhk2H4IQJc7xxjq71RooPSuGc6vIg0F9
         ZxPnVZWtEx/bwq3LN5dZO5U7TR0fUvontlhKCkNy0V/2qu7RmreLWjNQSkl3Xt8rIhhH
         i7JX/Pjrq/dJ0hBWFLSoaJ8GkMUkNtpvSjiM25KL5F632LJ9IIaytGKayVhe8oLlRO2m
         CstlxWUjX3r2RYJLi1+uHpmEtcO7NDaXDwy+LmaRBb3n0AnAxMct/x8O1qiO8+XvUtB6
         /xVUeZWkdwbT9JVXu3W589XAnHka6AJVtf/LfoUP+R+26uIXpO8ovrWilHVie5deP6ba
         zU9A==
X-Gm-Message-State: AOJu0Yw0KynbeLP1E0nUPWbmTA+hv0xGbQyQejem1iuiLznAvM9ZoMG+
	nLGcTQC8q1yk9IgTveIZ5QKVSQTe0pkq9k9K3VFYQQ==
X-Google-Smtp-Source: AGHT+IHgqSr6rS4vvOT8wEgvYIMG2kXyBSCq/LJKO7eoFe+ffOq0fRk5GUplGzu3QfPXNAZZCiyXGXQ/nDWoi3ikYWM=
X-Received: by 2002:a05:6902:cd:b0:db7:dacf:3fc1 with SMTP id
 i13-20020a05690200cd00b00db7dacf3fc1mr6479659ybs.110.1702587896545; Thu, 14
 Dec 2023 13:04:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <20231213110009.v1.2.I274b2d2255eb539cc9d251c9d65a385cc4014c79@changeid> <20231213221124.GB2115075-robh@kernel.org>
In-Reply-To: <20231213221124.GB2115075-robh@kernel.org>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Thu, 14 Dec 2023 14:04:45 -0700
Message-ID: <CANg-bXCG61HFW7JFuAd3k+OrCG_F9F3e8brjM-pmBauS53aobQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] arm: arm64: dts: Enable cros-ec-spi as wake source
To: Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Raul Rangel <rrangel@chromium.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Andre Przywara <andre.przywara@arm.com>, 
	Andy Gross <agross@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Baruch Siach <baruch@tkos.co.il>, 
	Bjorn Andersson <andersson@kernel.org>, Claudiu Beznea <claudiu.beznea@microchip.com>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Jesper Nilsson <jesper.nilsson@axis.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Michal Simek <michal.simek@amd.com>, 
	Paul Barker <paul.barker@sancloud.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Thierry Reding <thierry.reding@gmail.com>, cros-qcom-dts-watchers@chromium.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> If a device knows it is wakeup capable, why do you need a property too?

I'm referencing:
https://www.kernel.org/doc/Documentation/devicetree/bindings/power/wakeup-source.txt
"Nodes that describe devices which has wakeup capability must contain
an "wakeup-source" boolean property."

Currently the driver assumes the device is wake capable without
parsing the device tree, which is an incorrect assumption as wake
capability should not be enabled on some cros_ec systems.

> I haven't looked closely enough, but it smells like after patch 6, these
> properties would be required for wakeup? That would be an ABI break.

Agreed. In this case, the driver is a ChromeOS related driver and DTS
is built from source for each OS update.
For more context, I will make sure to CC you (and everyone else) and
include a cover letter in the next series version.

