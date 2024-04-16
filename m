Return-Path: <linux-kernel+bounces-147056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EED8A6EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F2EB23B97
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD37012F5AA;
	Tue, 16 Apr 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWQdZpZJ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5046C12E1D9;
	Tue, 16 Apr 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278865; cv=none; b=G5mc9P4nIac2U8r7LGIDNnzBzFHS4Lc7zTTrvQzINIq2WbaCAPrpdd3y03TXN1nUCNiwX9egA/OGofjR4sDgJG1s5rpmTH959iP2eEDMV4j3+H0NdgL46oHFwP3DHvMq3FftkSKjUR73zQeReCYKIc3SNzNZa6tlWhIt80F+cW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278865; c=relaxed/simple;
	bh=8cfg8Z9zJeLzJLzSRlYp8D+SSkO5uxZDS/dJ+fBVazA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9jaWU7yKOXmaH6XGfbY0MS1fIkniDW9iYuQ0P5jRUTbU3UizQ6MMT2rMEaalv+rf9m4QvHtKV8UsBC90kOBcak8xbKQye+KjdPb7EbmnzpO7FK2VR4+o0+W7ObfWhl8daFQfPgoQxZCJhaB6uG1NqsJIwUxHE4fpoSvBsNgkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWQdZpZJ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516cdb21b34so5773581e87.1;
        Tue, 16 Apr 2024 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713278861; x=1713883661; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dbrXiXP1Z0BGggRg41SKIMpA/U+f24cxgl+dajAMLS8=;
        b=AWQdZpZJaTaI5Puj5mDNb3YXgDGEGBEOtWa3yJGXTznQUhESQSfUKrtY/c6oGlfV6G
         RgZ2eRvIqQHLsaEEGtHSUTONXWb9GQO2I/ZZuzmVR+lf5K56mEUB5syz95ATxgUfH8qu
         cV4veDFfCfd3esU7Raww4PjT+zu+68JZo5D7cTv9vTxcpcdjM7pIUcvfoCyTBt9QgZ0g
         k/57V2JGXzR7ukQR+bQQZPm46rXg+8SrZ5dni75UxgmtzFrNoJ+sCZN+9RcWCSlmaCqS
         xDGfm6Kru1iSth0Jef5XxRV8+SOHgP4wr1FIh0sd/3lNg6rZiyrI/hXEIfLAc0fvegKH
         jUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713278861; x=1713883661;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbrXiXP1Z0BGggRg41SKIMpA/U+f24cxgl+dajAMLS8=;
        b=uOzV+Q2D3gpGcKjP1wnamwxDMnkWU7d+uwaRD93z5lne8O+QlHnCPiGg+IFsUmT9Or
         9hhug+OthURJN1zu3em0BZ5zxEOp+gOyMjGSFrsI2LDUZr3LqEsVo6sBiHCtIENz1OV5
         XGTQLSln6TIw3XxX3cpE/u25aGGGP4Tt17dT9SXB8KDmkjmGN8PBbNdqGQ4+xmqzQDir
         bSpzqxABUebz/UkXIsodM33BR2dJh87nh6ZBUmVcVHjvcI4Z688lrRKu4Dqk8B8gAhqu
         G3CgUwS44RW6YJT5Gz+XnjI2rN7bERcHlqRUQIrrYQUahTg9vGt/lZwJqjKELsjIDGYW
         BzEg==
X-Forwarded-Encrypted: i=1; AJvYcCVn0xx/aCC6D65TYbgvW6ctDAohlje87LQu6kHUP1BeyQgKrt2itIAL9tbaQD+VSVFBSTO5Ybbz3WVaOPKjB6KC8ZKH003TjOCQqrX367QY8QuOveMpZu3FYfyacp2e7YGSS2j7JbKIfJxfpSBQ7ZY8Xqw4Hdb7/3Nx+75j1Is1lJsO9way82juc3xW4DzLOt38hsLIMLp/NSY59yilVET6QfoK
X-Gm-Message-State: AOJu0YzARsxRaf8JGvGdB754IY21WHYIcqfPk7jxvBreC95OC1LM/WRT
	yJhiEcBXHVkFg4MD5cCJZy0/seDlN3ELwR2Lxz8yzTxAIoFTQ/Tp
X-Google-Smtp-Source: AGHT+IGVhUdbPenkEaBQEHoVWuoYM/g4N2s7D3ZyC86/yvbgSIn/UZQYlQxGwuRqXOP8zkYj3k1bUg==
X-Received: by 2002:a05:6512:473:b0:516:9f1a:929d with SMTP id x19-20020a056512047300b005169f1a929dmr8026763lfd.1.1713278861201;
        Tue, 16 Apr 2024 07:47:41 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id v17-20020a05651203b100b00516b07d95c0sm1606425lfp.217.2024.04.16.07.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 07:47:40 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:47:38 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 4/5] net: stmmac: add support for RZ/N1 GMAC
Message-ID: <xp34tp5cjmdshefxjczltz2prqtiikagfspf4lobznzypvsyah@ihpmwfynwzhh>
References: <20240415-rzn1-gmac1-v3-0-ab12f2c4401d@bootlin.com>
 <20240415-rzn1-gmac1-v3-4-ab12f2c4401d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415-rzn1-gmac1-v3-4-ab12f2c4401d@bootlin.com>

On Mon, Apr 15, 2024 at 11:18:44AM +0200, Romain Gantois wrote:
> [...]
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
> new file mode 100644
> index 0000000000000..e85524c2017cf
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Schneider-Electric
> + *
> + * Clément Léger <clement.leger@bootlin.com>
> + */
> +
> +#include <linux/of.h>
> +#include <linux/pcs-rzn1-miic.h>
> +#include <linux/phylink.h>
> +#include <linux/platform_device.h>
> +
> +#include "stmmac_platform.h"
> +#include "stmmac.h"
> +
> +static int rzn1_dwmac_pcs_init(struct stmmac_priv *priv,

> +			       struct mac_device_info *hw)

AFAICS hw is unused, and the mac_device_info instance is reached via
the priv pointer. What about dropping the unused argument then?

> +{
> +	struct device_node *np = priv->device->of_node;
> +	struct device_node *pcs_node;
> +	struct phylink_pcs *pcs;
> +
> +	pcs_node = of_parse_phandle(np, "pcs-handle", 0);
> +
> +	if (pcs_node) {
> +		pcs = miic_create(priv->device, pcs_node);
> +		of_node_put(pcs_node);
> +		if (IS_ERR(pcs))
> +			return PTR_ERR(pcs);
> +
> +		priv->hw->phylink_pcs = pcs;
> +	}
> +
> +	return 0;
> +}
> +
> +static void rzn1_dwmac_pcs_exit(struct stmmac_priv *priv,

> +				struct mac_device_info *hw)

ditto.

-Serge(y)

> +{
> +	if (priv->hw->phylink_pcs)
> +		miic_destroy(priv->hw->phylink_pcs);
> +}
> +
> [...]

