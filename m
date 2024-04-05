Return-Path: <linux-kernel+bounces-133318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A2589A227
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD92289CDF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EF117107C;
	Fri,  5 Apr 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg//saIJ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1F16ABC3;
	Fri,  5 Apr 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333429; cv=none; b=sm230r/fDp1FOiPGkKSmR4LTrtOzWPmF+q94qIvADGQItJcVG/jxAQmy3cT04ZV22ctAds+WmfGOUk8dHgDAEKWoIR6Y1IDpZQ0GF+ZnVzcTG9hneAYoOLGItOX6mlSNKvStrhgDUYGMsL6TYhkDpSoTMZUiNLcCiOfN18MJ+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333429; c=relaxed/simple;
	bh=XoXoslvHGhFAGNnZ/jtkQPOaFZnm6QeH3/hk2RonHU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWsLNrsw7SM1kp61YNrN5OL86aSX4TqmVMLI3dZwjS9QNSc7e81SX3lUE6Yn6oHR/9NtIjg0HZaQNXHHIEaf28hEfg0PFLbbI6y88bBR3shNWxyVt4XvlqYYAPHj4K0hNVZ4gROeczUrQOqT7AJuEwaUGqA0mebxbNDH55UdTWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg//saIJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4715991c32so350484566b.1;
        Fri, 05 Apr 2024 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712333427; x=1712938227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRnuU2T0zeBP54NjTK724wHa45BiVHY1dZbI/4zG+So=;
        b=Sg//saIJpNTqinmB2+tRADa5wtqoQWxwHXuOdbWL3EWDePEIJ7ZFvGR6vsGgZaClur
         fKyD7NDPBMBtOTzrYeuF5NFBqqQBPAgZn4bP2vbrTOCFQqE3W+kDpeJ/ozakujp+tUMY
         /QiOBTP8jwnl0IXFBu+S7MCw5s5jrhaTSFF1TYd/8UGGG0buZLO9wFMGe1if7wWrBZZF
         RSPf3L8dJKbwbB95JQs4yhCORhbc02ZufaxRRLnchOq5YToG0ljoIa9aSW4JaooG/g1j
         2U5C/h/9WTpy0j1GTtM3fKiWG/4Hqg56P0xbXAl7M1VrKS9QB8EgT1Ud+45xYYPOsd/E
         BMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712333427; x=1712938227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRnuU2T0zeBP54NjTK724wHa45BiVHY1dZbI/4zG+So=;
        b=JCxtT4sHBAEEjJOdX3BZXdsenIA55CadPBCI6nqNBzCGctTlfjweCkasjptQjiXtGb
         P9csVQ1afQFuD5EuVyTr4kB1XY7RVXbryURU7/BIkhU60/4qx7pU2gGVO6bmH9qmnnzJ
         /Tj36A78ir43ngsEBTCFQvtDqjGI7JB3alJSXghkxi83yECCrwCWDpe8nWfe7AYXMV/w
         PeWlwPaYAF1xEofwKeMfTfzPhUxPTXLdrBLXZdli29LqjY7rekDnqTL+/4GSrCENPhxB
         qV5FgcvbsqPbwe40tnaIQivLd6j1xV1IWXvKbZW7bsmM2RDF3NpN7A/6YnMDh6rl+WOD
         YUIw==
X-Forwarded-Encrypted: i=1; AJvYcCUCx7ZYlvT9+52kuHO45e53ROHVS7mO3GhH6fstSDJOr291ihd/Dg10zhxcTswhjh5wCh+3bGTtBAGDkL6A4h39zfKvb00k/b6G+sK4
X-Gm-Message-State: AOJu0YzBSjSz5y7O26HskrbKl30xuxiAyzxj950LQtDv2tRC+BCGULPy
	z4YajXg/cVqM8yy28fuqgiNLzi076Yfm8tzpZDnWSt2vp2K6KleE
X-Google-Smtp-Source: AGHT+IH7Qbt1NBMrdEBXQHquNIASOfmjNvLH5V9PKL2THeFZ+c+Z2bsaJEPTx1jQZbu29vT3ktgvlA==
X-Received: by 2002:a17:907:ea8:b0:a4e:d43:dc4b with SMTP id ho40-20020a1709070ea800b00a4e0d43dc4bmr1835447ejc.58.1712333426307;
        Fri, 05 Apr 2024 09:10:26 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id n2-20020a1709062bc200b00a517e505e3bsm979891ejg.204.2024.04.05.09.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:10:25 -0700 (PDT)
Date: Fri, 5 Apr 2024 19:10:23 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 02/16] net: dsa: vsc73xx: convert to PHYLINK
Message-ID: <20240405161023.qp2jl2a63z4vg3a2@skbuf>
References: <20240403103734.3033398-1-paweldembicki@gmail.com>
 <20240403103734.3033398-3-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403103734.3033398-3-paweldembicki@gmail.com>

On Wed, Apr 03, 2024 at 12:37:18PM +0200, Pawel Dembicki wrote:
> This patch replaces the adjust_link api with the phylink apis that provide
> equivalent functionality.
> 
> The remaining functionality from the adjust_link is now covered in the
> phylink_mac_link_* and phylink_mac_config.
> 
> Removes:
> .adjust_link
> Adds:
> .phylink_mac_config
> .phylink_mac_link_up
> .phylink_mac_link_down
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

I think you should split out the phylink patches from VLAN work, since
these seem good to go.

