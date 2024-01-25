Return-Path: <linux-kernel+bounces-38270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0FD83BD65
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2783029291E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9FE1BF38;
	Thu, 25 Jan 2024 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC6nwv1D"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB81BDC2;
	Thu, 25 Jan 2024 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175070; cv=none; b=HWWdlR9Ela3GmY78BPGkTnDSNfMOGd4yIIQbgtdJPegMGvando+tn9mxk5L917ccodxNWBfNitW6JqswHC2hdf7Ir5DhMdeEJ0hxxvBCRGkVv7ykzqG5nHfMQdlosdHB90sapVAx2dF94z6xiOxeQ5z0Bgtn7FE7OGyKJScsSw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175070; c=relaxed/simple;
	bh=OeShpqzxJE7yLOFxxvK9qlbC3YgMT04WmY+0Pht28xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Au+ocbJG9zAQQ/1BP/abWhjjKXBTCPse79oSeqvf0isYpDgT5pj2ci4q62gCno5fYBFxs9ubv/+FR5d3nHHZkMuLCEFojPiMOnXe0IMkyNqovWLq/7nq2pJ4dI7vrIupwtqZwh7Xz6FyrZrFBcuvll1lT7l4r8ZJahl3+SkbgyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC6nwv1D; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a50649ff6so7183035a12.3;
        Thu, 25 Jan 2024 01:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706175066; x=1706779866; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yF1vj6bD4OantSklaxQBfzwibMkOXYYkC5p2/Evicfs=;
        b=WC6nwv1DAO+WUe+jGRSDhXj418Jv6mU5tgpHLkd0H3J7o3Gm1xSZO5zqe1Ip5T6tLC
         NtzykAejh7caOGjFOlx4OPOiLOY4ItlU8pu+d4SdggA+fzIEuJ9noVh1dzpZv16EL/mu
         N0DG83jgISRlexCdtMTQaOlhAs7MxcTGOXc7MjSW/7Exe1SxNKOnd04Bd9H3442nAB/I
         7OPswA8ah8BU9//oY80Xg826daKgOSkrU2R6q19YKpjgFkQRaM52pP93acMQEj1CPeqb
         yzxvbDcSj8squdYcp4C3pkC2J7FhjpSjQXmfJf8Ip0fIhLbkqRIW2oVl+mwcYLVtTDEU
         4ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706175066; x=1706779866;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yF1vj6bD4OantSklaxQBfzwibMkOXYYkC5p2/Evicfs=;
        b=fMJBiT/cta7JZJXeE2jduWz3Hnx8plJQDVrCrmfOmPnFoANczfpoZL3O2qKjlHc24g
         UgFyMimlaL1U8HpDdYhcCBmCa2Eppuang0/krClFw/Sn98IRqry1RpfUnmmvovfytqZP
         R6MZ53kFvh6Lr7wgmVEZyLwCf4s5t4I/218rSQuAls1ONsvuR2+L3AHjbUigNuQTxGwT
         H7Aybz7E4u6rAjXlrlnPdQ9teMhgkqVn7GIZiC7svIXhNBrOjv64WMVpQ2vb3iIm50RD
         ARupKc6YvtbfnyrDAF/yjATMKwwVd0MgsJ3N1j211QdsLo/vY7XGG2vPfsy4GAuGOb29
         emwg==
X-Gm-Message-State: AOJu0YyInI1Ny839wb3zVP1+FYQeuTCzOq07q37ZGDPavK87kXAlbwd1
	9Btpe5Z5v2ywLEHPT26XBdyY7ZZSOD0nTotPMDZxBQjGfXhZu9R1
X-Google-Smtp-Source: AGHT+IFD9l2XpZg6gJ3Y5v2cAtGMf4TOPGAa0HvVrsoqEDBhW3/sdNPJABjpXIj+kn4fncD/5XKE+A==
X-Received: by 2002:a17:907:8693:b0:a2d:d05e:5704 with SMTP id qa19-20020a170907869300b00a2dd05e5704mr456600ejc.30.1706175066341;
        Thu, 25 Jan 2024 01:31:06 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id k14-20020a1709065fce00b00a28aa4871c7sm809849ejv.205.2024.01.25.01.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:31:06 -0800 (PST)
Date: Thu, 25 Jan 2024 11:31:03 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: arinc.unal@arinc9.com
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
	Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/7] net: dsa: mt7530: always trap frames to
 active CPU port on MT7530
Message-ID: <20240125093103.xlf46pezqj6d5ij7@skbuf>
References: <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
 <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
 <20240122-for-netnext-mt7530-improvements-1-v3-1-042401f2b279@arinc9.com>
 <20240122-for-netnext-mt7530-improvements-1-v3-1-042401f2b279@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122-for-netnext-mt7530-improvements-1-v3-1-042401f2b279@arinc9.com>
 <20240122-for-netnext-mt7530-improvements-1-v3-1-042401f2b279@arinc9.com>

On Mon, Jan 22, 2024 at 08:35:52AM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> On the MT7530 switch, the CPU_PORT field indicates which CPU port to trap
> frames to, regardless of the affinity of the inbound user port.
> 
> When multiple CPU ports are in use, if the DSA conduit interface is down,
> trapped frames won't be passed to the conduit interface.
> 
> To make trapping frames work including this case, implement
> ds->ops->conduit_state_change() on this subdriver and set the CPU_PORT
> field to the numerically smallest CPU port whose conduit interface is up.
> Introduce the active_cpu_ports field to store the information of the active
> CPU ports. Correct the macros, CPU_PORT is bits 4 through 6 of the
> register.
> 
> Add a comment to explain frame trapping for this switch.
> 
> Currently, the driver doesn't support the use of multiple CPU ports so this
> is not necessarily a bug fix.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

