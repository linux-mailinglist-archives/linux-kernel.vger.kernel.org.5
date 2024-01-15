Return-Path: <linux-kernel+bounces-26510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF4582E24E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3091C222B5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41ED1B29C;
	Mon, 15 Jan 2024 21:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5ufXqjY"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A611C1AADB;
	Mon, 15 Jan 2024 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2821884a09so775981566b.2;
        Mon, 15 Jan 2024 13:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705355193; x=1705959993; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xLysBvDenEQ28MTHoWPLscX8SqHGcwin+UvlB8fQgMk=;
        b=X5ufXqjYFSZUHSyv9RMVhRfVF5boMLQesIpMjsadw1jdrwelsncVPUG99VaPFfSmhg
         ymmR4rRp8FaemgHiKJ6MZ6S1d0hxBw8yUyXUycnGVe70vnxGu+rbl6mXtEJmuZ2p5WzG
         /Boh9qb+zE8linr0+pGTpAm/twh7xxL7J7dZ5POfsA2vTzJ3YLgIlK7qL+VKB9W/9CU4
         pruWlNPXjWWXFF7xZEp6DO/QR9kLx66T6k6PsMF0RjRIr/gpRIknzwyY5sQqAQOTlh4L
         4wK736dI+CKdubSWX2qYQBrVf+15tf0GmSMhHenRIiq5eWniTRnXzRXevsdSVIi3VpG2
         2wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705355193; x=1705959993;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLysBvDenEQ28MTHoWPLscX8SqHGcwin+UvlB8fQgMk=;
        b=TRihfy+ZPL6bw+EdgYbNZV5uwV2B72KRYeNeWeqwL5qfIQPXT2cnkzPE1LworcqL/5
         bT+uCEpF6nRo0TXo+j+FEejVrf2x85avy5k1xsck+lqbcEuEbYQ9Ez7g4CCSQlpXNqLY
         A+j5YAlH+4xnt2AvLpuo0oOrVZ+OMb4+Mneeyb1gsZ7wfj7Oh5E1uxiOQY7oTNM6xNb/
         mbmmuo6dfO+I2oe+S1O4cFi6NxDgwHqFaRoO+1eMrz+dKV2Osf8b8Rp1a0azLNsjKM5W
         vvwfrDa0USW8cyKbWPK+oEhuBXlpKnYbBaV5XjfyjmDYFfd5iFluuM1asqJYY/+m8PE2
         ZsXQ==
X-Gm-Message-State: AOJu0Yzrm6wC1sR4/QGehklZcwokSIiY3JMujSPOBulBhIL9Mc36Khrx
	/qbgiImZX//CFbJ/5g8dFZQ=
X-Google-Smtp-Source: AGHT+IEidDGhYUK34ndwyOKDjPlSGil8Zv56DjOYyVMr22Hkg7xq0uUI0WZPWjrIOhcsnJb4RGTMXg==
X-Received: by 2002:a17:907:a689:b0:a2c:e323:b71 with SMTP id vv9-20020a170907a68900b00a2ce3230b71mr2737988ejc.0.1705355192600;
        Mon, 15 Jan 2024 13:46:32 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id gw7-20020a170906f14700b00a27741ca951sm5678924ejb.108.2024.01.15.13.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 13:46:32 -0800 (PST)
Date: Mon, 15 Jan 2024 23:46:29 +0200
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
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [RFC PATCH net-next 8/8] net: dsa: mt7530: do not clear
 config->supported_interfaces
Message-ID: <20240115214629.ncdzoaawmw4gi7rk@skbuf>
References: <20240113102529.80371-1-arinc.unal@arinc9.com>
 <20240113102529.80371-9-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240113102529.80371-9-arinc.unal@arinc9.com>

On Sat, Jan 13, 2024 at 01:25:29PM +0300, Arınç ÜNAL wrote:
> There's no need to clear the config->supported_interfaces bitmap before
> reporting the supported interfaces as all bits in the bitmap will already
> be initialized to zero when the phylink_config structure is allocated.
> There's no code that would change the bitmap beforehand. Remove it.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> ---

Yes, the "config" pointer points to &dp->phylink_config, and "dp" is
allocated by dsa_port_touch() with kzalloc(), so all its fields are
filled with zeroes.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

