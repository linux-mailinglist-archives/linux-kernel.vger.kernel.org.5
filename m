Return-Path: <linux-kernel+bounces-141428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F108A1E18
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A97F1C25361
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347D413540C;
	Thu, 11 Apr 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/gHjecz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB91350EF;
	Thu, 11 Apr 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857729; cv=none; b=Uvfnuduz3yZWls4ZFx6p7lQcmwbUz9L9RjKZYyAyjHyqP2kEjJ8sXbdcFz7Nznps3d5icj0Tdatg+4yESoR9ZgJXAaNig4coIj7RWa3O+Np5CGDwlfFDXej+Qfe+971De1USlpSjiZWWB+i0vjA48gqMwTbeJYlZsF/8co05b94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857729; c=relaxed/simple;
	bh=+xGai2+yQRuwJxV3vruDN127Ywqk6sjQlpgvB62GDC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jeOvuloQnFCpIq6XCrHzXGtE+JIcInozPdC1c1hanyFe7/qpDW0kqJA7gwfdOVYoomxsvOKdgMFusPo01LHAu06YjD25PTREmgeeJBZ/VjtDOWBIsU2fHErwpF8Kjzmo7RtsUJ2/scc5Mr2l+t2UJPzDgbEyDo892MMMnCk2e+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/gHjecz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A5BC113CE;
	Thu, 11 Apr 2024 17:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712857729;
	bh=+xGai2+yQRuwJxV3vruDN127Ywqk6sjQlpgvB62GDC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s/gHjecz3MF1Jb2zrk0vs01JvLf/r7UbyG0tYD6S8t6zcAeWzxwgkflgdv+JaBUxm
	 gPPbJf9zFuQZdg87TCYvk8hhMnzmkrJAYcz5Dd+oOkHpkSzw8jxzxNit3qrbSVfQc3
	 0Qz5xJL4jjMt1wcAQyIlVF+/wl7rnQsKZWaSBTSuUg8vzRw7ZQqpPnabkpiSkQ9P4f
	 pWydTIK8Fdm7kHSpUjHUJdMx/kJ3jSu1IGTOLPkZ+TN9mdNRYEFqWAGDnrHCQZT8F0
	 gVHZisYtQOm3Rk+AVAbhyrryJwRTipgsUsFB8CFN2jFu7jIzX/A2Azj8ZlJHjIzlVj
	 JV+XUPutiYz0Q==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>, linux-arm-msm@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
In-Reply-To: <20240405144141.47217-1-krzysztof.kozlowski@linaro.org>
References: <20240405144141.47217-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] soundwire: qcom: allow multi-link on newer devices
Message-Id: <171285772650.544231.3543346756872331188.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 23:18:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 05 Apr 2024 16:41:41 +0200, Krzysztof Kozlowski wrote:
> Newer Qualcomm SoCs like X1E80100 might come with four speakers spread
> over two Soundwire controllers, thus they need a multi-link Soundwire
> stream runtime.
> 
> 

Applied, thanks!

[1/1] soundwire: qcom: allow multi-link on newer devices
      commit: ce5e811e069168898ae2ff02a90de68637ed7dc4

Best regards,
-- 
~Vinod



