Return-Path: <linux-kernel+bounces-42019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D7183FB0C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 00:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B627B2185B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AC745958;
	Sun, 28 Jan 2024 23:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8Z3X7Di"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132E8446A3;
	Sun, 28 Jan 2024 23:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706485571; cv=none; b=gcZRydct3E6XyUUtg6kkFt/BQxQnnfdkXcmlGzjLwCWsb5gU1KgAeRqBm3bjY+86ZAZSHOBD/NOzXm5L+UzBVPE7S05zaCj56tFTnzz7nAwgIY+7BraEmENIodOBnevZhyt3/hchk4gWzBNhJKbbBKz0V/Mc/HsOXa5Mvw+7NDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706485571; c=relaxed/simple;
	bh=F2CcdSFEcSZkRHkuIFEaNgrNrFiKs2Rt6M35imhi/A4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJPtdTQ9e+e/HL1eIGd4rjngti+4/efCHkMSfnRDpWlZ9fd+fzfp1/D7a5+OIb5vxMLXTlv6nkboA82LzgcRN3q8V2iZCLLCDqYOMpNxzuRhgklO5Ty+rO7OSgpAa4xapBs1HoAvhMAZ4y+LOUVGm/UPruiEugcIkIaFTxyJ9W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8Z3X7Di; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso33505315e9.0;
        Sun, 28 Jan 2024 15:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706485568; x=1707090368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3ExQwt9EMOd22cvQiREoaRfTSQMU9S5MtkBG9NL7czg=;
        b=j8Z3X7DiH2yduRYpJTR/wUHjtRo0IqZdImlIZZDsS9NoKKAaSEqcX5W/BvQr2m8zF1
         hsx/rrGTlTzMkRciPhBYpL9BYIM2FPK5C2DT0VDjRicFYlXRKUHDSMEqdeWBu11KruiY
         E28x9S4+XW2SEvNElMwnu7mK7b/UrtvGrTNJmzXQ/jRAE5IpMW8JiLpCa0V7KkZuuoed
         yR/ig8DrMa1aDkE63913jEZ1ITAaikAYKoPRr9oyMBA7ZPXLRHELZikthe2F/PrUNxBD
         wbZcPeD8CkOhsSUn89mubn4/TA1ApuHA4fpQKdEw/rmBnJtQjXzNAdt870coKBd+RWdP
         Xd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706485568; x=1707090368;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ExQwt9EMOd22cvQiREoaRfTSQMU9S5MtkBG9NL7czg=;
        b=dLbPRe8LRIE/Db6/qhsnLEYc+lDMrXdqgdYeycQJ4dvKDsxcmqdLZxLJZ82DalFwID
         ts1q0WDtjp1fVkxUC+RRx1FmwBwTf4sMUOC6BVJVXNwJtmJDecxrPTzNK8Da8PjbfbHd
         uSYehbAnV1mLebyyULj79gItHUAKDaOOsSf7jXEnb+Ya5Ii4wKlc+fOe1BqPphwxErEw
         XcFgtt5iSyjZIA7zQccsxcJndjAS+weI5SR4kRqi52ESB00xdBM8+XkEbBAlHSSB7Hft
         dYI9tMZJUQ57L4mqUm5OzVGKOie6B8vnQO9o6jQ+H2XQkMEPm1qCr1VWYz3f418aGtY0
         pTgQ==
X-Gm-Message-State: AOJu0Yxf375/HF6jFodNlrSIhve3JxIOxt0t2bhvQ9Zrfs/sVWmOYCCX
	HoOnfsLzTRtGa3FJofmic3LgyxfzgArbprN4hHd6iZBKjC0ORGBQwyjso1lP
X-Google-Smtp-Source: AGHT+IHyTkAKI+PWKTlibMrDODOKgosiIOdV8Prm1IzlSYZSswDopMwPkRxIOLuAP2zVc8WqBkCucw==
X-Received: by 2002:a05:600c:1e29:b0:40e:8767:1615 with SMTP id ay41-20020a05600c1e2900b0040e87671615mr3550371wmb.37.1706485568087;
        Sun, 28 Jan 2024 15:46:08 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id eo9-20020a056000428900b0033ae9e7f6b6sm2313874wrb.111.2024.01.28.15.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 15:46:07 -0800 (PST)
Message-ID: <65b6e73f.050a0220.cd8b1.8846@mx.google.com>
X-Google-Original-Message-ID: <ZbbnPXXjvUset6Iz@Ansuel-xps.>
Date: Mon, 29 Jan 2024 00:46:05 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v3 1/5] net: phy: move at803x PHY driver to
 dedicated directory
References: <20240128120451.31219-1-ansuelsmth@gmail.com>
 <20240128120451.31219-2-ansuelsmth@gmail.com>
 <5d76636c-0737-4189-81f6-b87a03aa5f24@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d76636c-0737-4189-81f6-b87a03aa5f24@lunn.ch>

On Mon, Jan 29, 2024 at 12:39:20AM +0100, Andrew Lunn wrote:
> > @@ -36,7 +36,7 @@ obj-$(CONFIG_ADIN_PHY)		+= adin.o
> >  obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
> >  obj-$(CONFIG_AMD_PHY)		+= amd.o
> >  obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia/
> > -obj-$(CONFIG_AT803X_PHY)	+= at803x.o
> > +obj-y				+= qcom/
> 
> nitpick:
> 
> Please could you insert qcom before qsemi, so we keep it correctly
> sorted.
> 
> Otherwise:
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>

Stupid me I didn't notice we also had things sorted in the Makefile. Yes
will send v4 with the thing fixed and the tag added.

-- 
	Ansuel

