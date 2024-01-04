Return-Path: <linux-kernel+bounces-16870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92738824534
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C1E1F23C11
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57CA249E0;
	Thu,  4 Jan 2024 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfmU2Wk/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A297C24201;
	Thu,  4 Jan 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a27cd5850d6so72220566b.1;
        Thu, 04 Jan 2024 07:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704382964; x=1704987764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jTkbnBm6/5/MdujzWlHiWh0IB4tKyJUPbJXAGWM4F7k=;
        b=dfmU2Wk/XoF9ktgi0hW5mvlbQ/+V+QJ97RrJLCuInY0gSxfR4B3Ix3PL4xnqCNVJyU
         xGk+vYK+ZtLh54OPRsDBfsowKXxTNAC8hDSe9wUVu9UJB5o7EUYA9/+Ub8nfx4e+GaFb
         6wcIWoOomBqv2f/mkAjuTYECpliTmnGlNW/inmaDeJTJvcDphWBpotNpvzmVHonTvqhE
         M5Tkdoioo6X3bZKjTqYI3sOi7gwdHLTCTzZBonxM6na91WKlEKlMSs+aNYfKEQ8AVcbQ
         IpsmbLAT2hrU+luFutG+7pDk11y/92BeGfLShrhVxcQvuc5fBzpKrDzjQ8b6SNn12XU8
         lyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704382964; x=1704987764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTkbnBm6/5/MdujzWlHiWh0IB4tKyJUPbJXAGWM4F7k=;
        b=X12MYIQKLR0eMPQH0/Yqcls6SePhDVU9hY3WwFHR8SDP3HTJSwSe0CdA7fy6AUv/cD
         bPcKPo/qq7gHDMQxQmIlmLiJtyx8ZUQtu2fOA9gaUDVKJcucdhJl+i1U8uUEzmBBa58q
         79BzaJopelQBYGNVOQrCUpwHqYgJ4DGnanKNDkFDff7xoiTRAFll1aU+3+YqbFZCOywX
         7gd5ZX3jQqFmhcwKVTfFbG4SnJwHTXp9g80akaVBcg8sc1/EnWe8GQMub0Dea8cBed8A
         oyGjvlDGf/d33nQp83Dg/EHJupL3zs+05tqB9SheYzntcyklcKeOES5Tm5utRrtdHyi9
         hM9A==
X-Gm-Message-State: AOJu0Ywr/FGwTiomOrETctpveg9TO9MkhfGewLx87ONYQfwKf/6ywFTT
	XM7e9GzYRYYVe6GbpbY4C34=
X-Google-Smtp-Source: AGHT+IHjeXF9p0hr/CJfgF2dv0x7zBSZO13sqctpbNXoAzsJdZH9m1qlb87mAlfmbz+5nHim8Q727g==
X-Received: by 2002:a17:907:76ac:b0:a28:b9b8:2f8c with SMTP id jw12-20020a17090776ac00b00a28b9b82f8cmr381280ejc.152.1704382963780;
        Thu, 04 Jan 2024 07:42:43 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id ex17-20020a170907955100b00a269fa0d305sm13894476ejc.8.2024.01.04.07.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 07:42:43 -0800 (PST)
Date: Thu, 4 Jan 2024 17:42:41 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 6/7] net: dsa: mt7530: do not set
 priv->p5_interface on mt7530_setup_port5()
Message-ID: <20240104154241.rxjins4mi5zkbhia@skbuf>
References: <20231227044347.107291-1-arinc.unal@arinc9.com>
 <20231227044347.107291-7-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227044347.107291-7-arinc.unal@arinc9.com>

On Wed, Dec 27, 2023 at 07:43:46AM +0300, Arınç ÜNAL wrote:
> priv->p5_interface and priv->p6_interface are for use on the MT7531 switch.
> They prevent the CPU ports of MT7531 to be configured again. They are
> useless for MT7530. Therefore, remove setting priv->p5_interface for
> MT7530.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

What makes priv->p5_interface and priv->p6_interface useless for MT7530
as you say? This code in mt753x_phylink_mac_config() seems executed
regardless of switch family:

	case 5:
		if (priv->p5_interface == state->interface)
			break;

		if (mt753x_mac_config(ds, port, mode, state) < 0)
			goto unsupported;

		if (priv->p5_intf_sel != P5_DISABLED)
			priv->p5_interface = state->interface;
		break;
	case 6:
		if (priv->p6_interface == state->interface)
			break;

		mt753x_pad_setup(ds, state);

		if (mt753x_mac_config(ds, port, mode, state) < 0)
			goto unsupported;

		priv->p6_interface = state->interface;
		break;

