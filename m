Return-Path: <linux-kernel+bounces-126777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793BF893CA3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC201F22517
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B04481DD;
	Mon,  1 Apr 2024 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmvnDyNX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A3B45974;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984217; cv=none; b=MDfYs9GtPgzQNw4MIC2wHZnSghtwVpoF7LdQ72uJNE8Cub+kCUIlN7Nj3vrJh+XDTOyjxU4cU1hblMWmFTJ3e2fY82nRhaTE81r+h6UPYdgag3nZErTG9EMVEpjXnJSqwQRSr2mam/UcDQLJ2Be5VbnmdXDsH2pctyRPMkOfJIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984217; c=relaxed/simple;
	bh=10B9kij4RJ8Moszjff2kF8cKqehkeXTDRYV4vE4emTg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CO5aZGxLUisU1B5Kw01ECibm+gGQ5zN2EfXf8unjzz5C8ICqUb+JiK1qy/NnVRNCFzIihyo99fSzVdfJrpM/odAS7TJXUktSzUdf89yQbIfcSZwX/5INCfNiO9zCVdG+7VeHJTxgPGgEpn45LciBW7AdPz1QM6oGkcCmDZbC4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmvnDyNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 046F8C433C7;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711984217;
	bh=10B9kij4RJ8Moszjff2kF8cKqehkeXTDRYV4vE4emTg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lmvnDyNXrQmePxOdWlP/Mz9noqy2ujaQWVXS4amlmG+jzqOXv4Mc9hhTKl03VDbL8
	 2/n+qgK7s1yLDNC0zr/xZHwXW0VwqKUsp9wppd/IiCLcLEW9Jz3m21tZNXHqswmyFH
	 vsOCyolLPqAPYGA+uYgQ6EsLKMfmNivpAOUfxGm6+Ecy4A9nhQaxZrZEx5J88Xe9/i
	 lbzRQt1vue5xiPXpBm51ZyED3oXPLlMO4sbS5Y0WCjtbsd7YiZ4lB7umJUtAVtJEUH
	 r/tOs3R2XngD80ErdsUSZt3atkML36LtawbyFuPB7xJXSX1CyARm1wpKFznSunLVNI
	 iwrfc9N1eCSPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18AECD128D;
	Mon,  1 Apr 2024 15:10:16 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Subject: [PATCH 0/6] Add support for AD411x
Date: Mon, 01 Apr 2024 18:32:18 +0300
Message-Id: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIPTCmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0Mj3cQUE0NDQ13z1NQkY5PUJJNE0zQloOKCotS0zAqwQdGxtbUApX1
 /H1gAAAA=
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711985550; l=2067;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=10B9kij4RJ8Moszjff2kF8cKqehkeXTDRYV4vE4emTg=;
 b=XLN9Nt8v7bv1mWjyDAWDeyL+7eBHCtShfmeS9aiFjAAWhNLQnF8WvA3P84LoqGXId7oimiFXZ
 njaVyz3tn1JC8NxVW9DB6cuu1ZuAS2yhvJA9QrY4mondxwUlXGQn1ip
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

This patch series adds support for the Analog Devices AD4111, AD4112,
 AD4114, AD4115, AD4116 within the existing AD7173 driver.

  The AD411X family encompasses a series of low power, low noise, 24-bit,
sigma-delta analog-to-digital converters that offer a versatile range of
specifications. They integrate an analog front end suitable for processing
fully differential/single-ended and bipolar voltage inputs.

- All ADCs have inputs with a precision voltage divider with a division
ratio of 10.
- AD4116 has 5 low level inputs without a voltage divider.
- AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
shunt resistor.

Datasheets:
https://www.analog.com/media/en/technical-documentation/data-sheets/AD4111.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/AD4112.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/AD4114.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/AD4115.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/AD4116.pdf

This series depends on patch:
(iio: adc: ad7173: Use device_for_each_child_node_scoped() to simplify error paths.)
https://lore.kernel.org/all/20240330190849.1321065-6-jic23@kernel.org

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
Dumitru Ceclan (6):
      dt-bindings: adc: ad7173: add support for ad411x
      iio: adc: ad7173: fix buffers enablement for ad7176-2
      iio: adc: ad7173: refactor channel configuration parsing
      iio: adc: ad7173: refactor ain and vref selection
      iio: adc: ad7173: Remove index from temp channel
      iio: adc: ad7173: Add support for AD411x devices

 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    |  59 +++-
 drivers/iio/adc/ad7173.c                           | 318 ++++++++++++++++++---
 2 files changed, 331 insertions(+), 46 deletions(-)
---
base-commit: 5ab61121a34759eb2418977f0b3589b7edc57776
change-id: 20240312-ad4111-7eeb34eb4a5f

Best regards,
-- 
Dumitru Ceclan <dumitru.ceclan@analog.com>



