Return-Path: <linux-kernel+bounces-142589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04578A2D89
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE0A2875E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB3C55E51;
	Fri, 12 Apr 2024 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN05y6vD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E42208E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921726; cv=none; b=UHby3jiac1l8s+5KDU9nNrj2wwnqE4WxmZLswz7P965DAfn87hiqAC1HIjand0tXDTlsR3/71nGlBSfl8eznngW3JESbnETTqWKYwwLy0ZqiGsVdeqxPSISaPAztN2MwF+aI6GUCUz6nctfK+tVjtHSi/Itqz2Of23zSexpH3to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921726; c=relaxed/simple;
	bh=cXvZH8jSB3R6/ZybERQXRn0CWZL55MbU8i6nLdnfYHQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s7eJS+M3yUf0fQJ8I5S+OXr21ZHU9Uoc/TVYssjM00S9e5RPDKCf90NDnGkd0oiklZOybDG9VV/PV9khgR5u4E3bFS4CeBqtljU06TedIZeRxxXmyKlr0rL/ucD3ln0hEA5EozvBM9UE7319dFJfhMshoj0jGbsfzZq4IdaJJpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN05y6vD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A243C2BD11;
	Fri, 12 Apr 2024 11:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712921725;
	bh=cXvZH8jSB3R6/ZybERQXRn0CWZL55MbU8i6nLdnfYHQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nN05y6vDJlP7k0Qzi/nEsn6vBPvcRhGe6spgWP5Mb7GW4wXi7xqfHI7zYUO604vi+
	 YCvEibefwHapVeAZA/zGhCQO4BauGaj25ImmfCyXUHAuhf1sBK4wizM8oahLPlp+iI
	 ZJcguxRyk+Y+RpwKQPzOxfQsFH29voqlzWXnp78KozySJSSyk1xRPhSzl8DtrHY7eI
	 RUm4balZ2QbEWVf3GEVK9rIJg3YhNbY7BeacfSmutKjuQ0xanPMlw02UmOvHTXZuDE
	 enZ6luky5LkUO2iiFo9JLuYUsMtaC8hAHpxaasyf1gs0PCBt3UNiEiWynjZLsfVKUW
	 A30aMF+vYZwoQ==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, kernel test robot <lkp@intel.com>
In-Reply-To: <20240408222926.32708-1-cristian.ciocaltea@collabora.com>
References: <20240408222926.32708-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH] phy: phy-rockchip-samsung-hdptx: Select
 CONFIG_RATIONAL
Message-Id: <171292172181.599648.17726910504244082480.b4-ty@kernel.org>
Date: Fri, 12 Apr 2024 17:05:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 09 Apr 2024 01:29:25 +0300, Cristian Ciocaltea wrote:
> Ensure CONFIG_RATIONAL is selected in order to fix the following link
> error with some kernel configurations:
> 
> drivers/phy/rockchip/phy-rockchip-samsung-hdptx.o: in function `rk_hdptx_ropll_tmds_cmn_config':
> phy-rockchip-samsung-hdptx.c:(.text+0x950): undefined reference to `rational_best_approximation'
> 
> 
> [...]

Applied, thanks!

[1/1] phy: phy-rockchip-samsung-hdptx: Select CONFIG_RATIONAL
      commit: e1c9216bec2793d051f83d77d93d3d6a899d06d1

Best regards,
-- 
~Vinod



