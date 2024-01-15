Return-Path: <linux-kernel+bounces-26502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C43682E230
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB7D1C2228E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B8F1B292;
	Mon, 15 Jan 2024 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5hhWBHC"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2857E1B580;
	Mon, 15 Jan 2024 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e760e5b49so15809095e9.1;
        Mon, 15 Jan 2024 13:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705353860; x=1705958660; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g4BibwaX8MWABZKTTuvrQf1jMOqo1GohyvM0tbsIEuY=;
        b=O5hhWBHCBTdIL8Ly6Y6tJWMKqQSoaa1EM5kv55ZPFwBvvpKfus/ve+aNZHCz8z5+VK
         jkLxqmqfqEOim4GKZ4m1KcuqYP/MPDhDZ4cKNhDmGoqEXU5XavHFbgLxsqG9BNNM6C8h
         Fv81gpFVdvFt52ThAu2CZxUASYwmaaM7bna0mP3X6XJlJm+KWA51lgwYY6M5XQWGd25H
         /9slXW+BGBZLp2aZNZFBwZ8dseBT+ZegjDCwIwZfUJyILtcChERG62UDQg181FzbaZK0
         oLX4V3MWmTd3eVX0kuLHAVsDuWue/wfL18xB+S0jxcNKQrBTVb5wQCzMJBOaVmAJdPO7
         1HdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705353860; x=1705958660;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4BibwaX8MWABZKTTuvrQf1jMOqo1GohyvM0tbsIEuY=;
        b=iQgYipZlvPF0CrK+d1WyR4aHcO7Z1YIP7aM3vtbEMwEzawXVWfex9fHD4JKwNT0P3w
         Ehkt/LejKAXSn7l8mry+YyUca2P0aF+adWLC1aqqJL2jiyP5HtYZYw+eGIIgWzrj20ts
         7V6/yqZF6wSxbpvC41opIy3Tw53vhtLxN1RwfyZvDFmZ83UTB+enVrGjHV9Lz1Gf1u2y
         0liKFGAY6wfqY1OOolO3id3IP0Hgspr8dtzRFO4YHMBmTSgnUQosNn1tW5NcyPet6oPf
         Ftzqz8x9sWvN5Vlem/k+e1CBDJyKOO9pfj7dFD6QM3qG31IRMRKQgUT5zomVs25xIu7L
         C4DQ==
X-Gm-Message-State: AOJu0Yxm7gnXbjAMSsWSOzEDxwY2B6gPFdrbn3+6g7M6fPJmyXCjDpe/
	IGcq1PPCM2P/aaPhMf//wis=
X-Google-Smtp-Source: AGHT+IGS2DleYsPDxFubSZWuGUfOFBEeJSJbvbS8UfWv276dj6fVdSeHn96g53WwPCorL+XvGdQWyw==
X-Received: by 2002:a05:600c:3c8f:b0:40e:6ddb:2970 with SMTP id bg15-20020a05600c3c8f00b0040e6ddb2970mr1548393wmb.274.1705353860266;
        Mon, 15 Jan 2024 13:24:20 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id v21-20020a50a455000000b005527c02c1d6sm6108008edb.50.2024.01.15.13.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 13:24:20 -0800 (PST)
Date: Mon, 15 Jan 2024 23:24:17 +0200
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
Subject: Re: [RFC PATCH net-next 5/8] net: dsa: mt7530: move enabling port 6
 to mt7530_setup_port6()
Message-ID: <20240115212417.egqyslsbrqw6jp3q@skbuf>
References: <20240113102529.80371-1-arinc.unal@arinc9.com>
 <20240113102529.80371-6-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240113102529.80371-6-arinc.unal@arinc9.com>

On Sat, Jan 13, 2024 at 01:25:26PM +0300, Arınç ÜNAL wrote:
> Enable port 6 only when port 6 is being used. Update the comment on
> mt7530_setup() with a better explanation. Do not set MHWTRAP_MANUAL on
> mt7530_setup_port5() as it's already done on mt7530_setup() beforehand.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

