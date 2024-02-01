Return-Path: <linux-kernel+bounces-48987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD83846465
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765011F24F8C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF03B47F4D;
	Thu,  1 Feb 2024 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buJUkL4I"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8876E3D566;
	Thu,  1 Feb 2024 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706829986; cv=none; b=GNDZbsZySjcSZSGV7DyXBKSM7xMEAY/F3LJgFsrlLZ/drRe9w+w4XumXO8yj1lqiGhpKOjFv+QmevmpEo/565C5TmvWdPRXXIUJQODJoW+Ul+UpOGRjElAAJgxiYIFb84zPSgVqfqGycOvwTrOu3I+3W8gvXhWiDwUNFHXeRMYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706829986; c=relaxed/simple;
	bh=t0P9U/fdDr35SHvrZhkQig6KKzFDue8UOlQKPLPl61E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8CE380B39iB+DRobitjvh62WkrPGcPMuTO8r1349BIJo3ZzPmUZTUrrxPCffomNcF4BzV6iWfDhaNCF1zQqOhEw7Mt8DIYfc8KSgtvl5xb8kwAMb+071BdCWA0MkvIkEcVV9qTBfOorPbbz+PCqRXT4jndagnF/9EEtNy4u4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buJUkL4I; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so40600166b.1;
        Thu, 01 Feb 2024 15:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706829983; x=1707434783; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uqOCCFMzBcZ2VL5Z1Pts5v3IryEZHh1IG9XimJuKSKk=;
        b=buJUkL4It/LjQ1N0TYe30v712v+x8Rhx4RCCxF8pyzUy3AVzVjr2Ad2Vs5pRN5UyC4
         knZhRfkJvxWC7t5foXN+eLXm/IY3N9t++TY1wvQ8jHl89nrtMGkiJHJKzDCFLpucJZ2T
         aiic7USNeJof9jrrHeYcSBRD++KiAxX/GQ1IcHwTTpBqFWXHdJjKboQfatsLLtv06s1m
         gD8/86lFzbZeknB0m+bXtz/Ot8LGMZ0KLU6rzyOgFrbXBgL6r7SH4NOMAiWKIp/966ok
         bhgL/jp8WLBl5lUDmwCGz9d5aGvtjkIz/kUuvI5jH5uO0qsVO5LPPBS4H4ZGEaafWBo+
         h8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706829983; x=1707434783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqOCCFMzBcZ2VL5Z1Pts5v3IryEZHh1IG9XimJuKSKk=;
        b=FMbYJe3KGp5tskkTnnlokHUxQOlvUBnf3PxufyU9jgCzYA1rH41bcEYTC9gqcyFqyC
         I1oJkSXwd26ovxjKcf77iq+i5w0+ZVqRbHs3+c2YdniAoO1+m/4gUWsXWW4qixDC+Yow
         aPKhArb7FtK3ToQMdjlQUKcoOFDcnUTjJ8RUyq1iyKV1mNXBYOaHToQVLe3lcewlEa+7
         kXf+gq9zfx//7yiJwUac9sEo/fnfzIqiPO4ui4qfQcuOGDS0yiCiyId2aBL5XiUeEXYv
         3ryu2UkHEauPUTMcc6ONe5yLg9K/zbX8djfSUn3PhiBsbUN2lRc/H0qEkNuKT+NE+KhP
         H1FQ==
X-Gm-Message-State: AOJu0YwToM8hIoPlcfpMRfy4paml5SugbDO3m658tJGOWoEYNzVroiqs
	AmzmClxG9o71T89poRvXFkExnM2kim816U5M6B3nAwEQmkz2G2Hx
X-Google-Smtp-Source: AGHT+IFlrCxvvGTG0ycgv+W52pIwYEVlf4h1Tfg/JJ6vHxl/5vIGyFMylIp7dWVzsKX6fEKWC/DX5Q==
X-Received: by 2002:a17:906:553:b0:a36:f672:5dab with SMTP id k19-20020a170906055300b00a36f6725dabmr386277eja.16.1706829982626;
        Thu, 01 Feb 2024 15:26:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWf9289hy9yd1LiVZoV/ca+hZT4+cy+waP8Oy6do+fAz/MsGVbV6hbPTCBaKrvJGoSy+zYREmdkv+XfqXuB85+aaU+n8WHC2ieU/OdQ98Xr8/e1lXR4BgwBcO/biw67hjdzzzbRmcSh4GAnJ7uFmd/jSBe0XHg+neiXfNF2v/VunmEkb6CTDrW7FG9upTbyxLo9qnbt/wTDRYEDx99huRNMIQO3SkEX6092jqyOPcNYaC0sPOyUF0H4d3/zrxfSGOG96nMQc6zrnX+z7n/fbprIqM1sDp9i2UT6xnnr8MSZAeeEQfot4lx5J01me2Pm26lgyBuxCDKBveGhy7JIVo2qb3ESGE7HzCpFaf72OAH4CqasqkviUFaiHqkuF45mje0O51iouslEwIo4eDqIKKn3y0aFkq+ewLDxr8TbBJVR/XikgvclpPoZswh8B2CC/Pt9acUKY8owqJQeHsdr2PU5xOFlIueZaQ1Aqd5vQhC6BTP3gy0n+3a17UPlshj3v5o58Ca9lJQaRCsH1JWyOrGwuJR93mQSDU5wToSMBkgke57yaVQ2ppru1pR/27j0EgjhI+MD3v6VjsmHtUPCOaaNkPbn9b1Oo4XHf57wQgRojIlIqGczt8e3n/DWEMfiVqs/fUzuj3M1OEIn0m2uNNzyTIGRCWj+HXApPUIJNo3oPdtlY8qAy1O5t5vhsK3W
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id vi4-20020a170907d40400b00a3702ab71f6sm56765ejc.206.2024.02.01.15.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 15:26:22 -0800 (PST)
Date: Fri, 2 Feb 2024 01:26:19 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: arinc.unal@arinc9.com
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net RFC] net: dsa: mt7530: fix link-local frames that
 ingress vlan filtering ports
Message-ID: <20240201232619.nsmm7lvafuem2gou@skbuf>
References: <65bbf40d.170a0220.a87f4.becdSMTPIN_ADDED_BROKEN@mx.google.com>
 <65bbf40d.170a0220.a87f4.becdSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65bbf40d.170a0220.a87f4.becdSMTPIN_ADDED_BROKEN@mx.google.com>
 <65bbf40d.170a0220.a87f4.becdSMTPIN_ADDED_BROKEN@mx.google.com>

On Thu, Feb 01, 2024 at 10:13:39PM +0300, Arınç ÜNAL via B4 Relay wrote:
> One remaining limitation is that the ingress port must have a PVID assigned
> to it for the frame to be trapped to the CPU port. A PVID is set by default
> on vlan aware and vlan unaware ports. However, when the network interface
> that pertains to the ingress port is attached to a vlan_filtering enabled
> bridge, the user can remove the PVID assignment from it which would prevent
> the link-local frames from being trapped to the CPU port.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> I couldn't figure out a way to bypass VLAN table lookup for link-local
> frames to directly trap them to the CPU port. The CPU port is hardcoded for
> MT7530. For MT7531 and the switch on the MT7988 SoC, it depends on the port
> matrix to choose the CPU port to trap the frames to. Port matrix and VLAN
> table seem to go hand in hand so I don't know if this would even be
> possible.
> 
> If possible to implement, link-local frames must not be influenced by the
> VLAN table. They must always be trapped to the CPU port, and trapped
> untagged.

Isn't this, in effect, what the "Leaky VLAN Enable" bit does?

