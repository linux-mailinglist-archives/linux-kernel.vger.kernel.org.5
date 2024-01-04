Return-Path: <linux-kernel+bounces-16855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F5F8244F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E191C22251
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166EF24202;
	Thu,  4 Jan 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njqD8Wzr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD60241F4;
	Thu,  4 Jan 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26f73732c5so70208866b.3;
        Thu, 04 Jan 2024 07:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704382163; x=1704986963; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=//61JkAFmR4ja1MQYPV50hTEwRUwt59eOyo8emTzwoc=;
        b=njqD8Wzr3mpLOKT80ddBlDkDmOqd3j/NHYQXduJiJSymq/egFnRNXqytoPLFlepppB
         qKvCt5c0bxL2APkPdWDpxvEM9DSZ3a4UcgJF9GhJUyXW2mD8JDYFdtqTH//X+C4wl6mK
         yFAlG9h20gEh9TkwzetEFDmXwxKDokzuaGVr3TmfMR7RJYqY48AGL+pxto80dOZZEWpl
         QxXnMYfEvEgtJ/WcioUQZGZuP1/97Tzt3G/8Y1rRl1oDvIvxYRfLaxI3YDH9QBSSvjF8
         csBF6aLw9rQp3r786245JE8U4rThZrHb7+UQUvb4f245Z1efc61A5MZ9aPwSmNvIbo2u
         RgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704382163; x=1704986963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//61JkAFmR4ja1MQYPV50hTEwRUwt59eOyo8emTzwoc=;
        b=wyhGDTwA7FrgEjudjvej5Bvi6j+gHSkk9UaoKLugcmNQ8JQdr8VHAGFyVyV936r/wJ
         gnqYeKQrKfpRd1V+Qp+SqiqXhOJNAwIksnmekMs8Kvqef9nIDVjmdsmA8QYFaKXaFxxP
         86DnYLTFXYYLBmzv4HxjRyemV5Elz5KgH7OwBzIzFo/Z0SVM2b0S7x2ZbWGEAUrhz/7i
         zX6zSXm1++uPtZRjtNCbIg0MB7x3yydanPJFpTuKKSsHbPg8ZnEOm4b6bWgrc3ae2uvu
         TdEU6LLeQuGQ3UMqZCrSK7Po69Nt6W3eW8B2Qt8Ll3kS/4c8eq0JWvqUAppVA0twcb6v
         FRtQ==
X-Gm-Message-State: AOJu0YyTpY16pX3zU1WHCr8I9Yt2SvsSZVJLZYL0NtQj3U8/Rw5nfCK5
	fsxkksrCL3EJ8PD1hl2NVeI=
X-Google-Smtp-Source: AGHT+IEFGh6wzkj5OLLtZKwtP7/o8aS6I+L0Q/lrIXojf++vN1QSj7YEGQahqkI2+h3JUmXLtyaL9w==
X-Received: by 2002:a17:906:f247:b0:a27:2f12:94ab with SMTP id gy7-20020a170906f24700b00a272f1294abmr430597ejb.99.1704382162780;
        Thu, 04 Jan 2024 07:29:22 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id zv13-20020a170907718d00b00a26aeb9e37csm13066662ejb.6.2024.01.04.07.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 07:29:22 -0800 (PST)
Date: Thu, 4 Jan 2024 17:29:20 +0200
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
Subject: Re: [PATCH net-next v2 5/7] net: dsa: mt7530: improve code path for
 setting up port 5
Message-ID: <20240104152920.gxzpv2ljvcuhdzvf@skbuf>
References: <20231227044347.107291-1-arinc.unal@arinc9.com>
 <20231227044347.107291-1-arinc.unal@arinc9.com>
 <20231227044347.107291-6-arinc.unal@arinc9.com>
 <20231227044347.107291-6-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227044347.107291-6-arinc.unal@arinc9.com>
 <20231227044347.107291-6-arinc.unal@arinc9.com>

On Wed, Dec 27, 2023 at 07:43:45AM +0300, Arınç ÜNAL wrote:
> There're two code paths for setting up port 5:
> 
> mt7530_setup()
> -> mt7530_setup_port5()
> 
> mt753x_phylink_mac_config()
> -> mt753x_mac_config()
>    -> mt7530_mac_config()
>       -> mt7530_setup_port5()
> 
> Currently mt7530_setup_port5() from mt7530_setup() always runs. If port 5
> is used as a CPU, DSA, or user port, mt7530_setup_port5() from
> mt753x_phylink_mac_config() won't run. That is because priv->p5_interface
> set on mt7530_setup_port5() will match state->interface on
> mt753x_phylink_mac_config() which will stop running mt7530_setup_port5()
> again.
> 
> Therefore, mt7530_setup_port5() will never run from
> mt753x_phylink_mac_config().
> 
> Address this by not running mt7530_setup_port5() from mt7530_setup() if
> port 5 is used as a CPU, DSA, or user port. This driver isn't in the
> dsa_switches_apply_workarounds[] array so phylink will always be present.
> 
> To keep the cases where port 5 isn't controlled by phylink working as
> before, preserve the mt7530_setup_port5() call from mt7530_setup().
> 
> Do not set priv->p5_intf_sel to P5_DISABLED. It is already set to that when
> "priv" is allocated.
> 
> Move setting the interface to a more specific location. It's supposed to be
> overwritten if PHY muxing is detected.
> 
> Improve the comment which explains the process.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

