Return-Path: <linux-kernel+bounces-38226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA2B83BCC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D701C28225
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D51C296;
	Thu, 25 Jan 2024 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfyL9dtI"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCFA1BF43;
	Thu, 25 Jan 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173428; cv=none; b=cdfX4289wj/GyfiAYgCrx8bwFOWz20mVnAOwdXY5anSZ8XjjaD86ZoFsgONIUalhEf/Ue6cvbxRQvO0hEWg/RT2C5pgXoSCWM58lnRhx9KboNyknmAn/kCaaToJfHbYjAyXL22TO4LTyjk6MH1QrtGr30E3H0mBq9UGiDX0fjqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173428; c=relaxed/simple;
	bh=3Ta5jPPhKqYXus4RlVQYchqTN+T7KUFRVFd6guY0QRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toB6UNr4wXa3MPjZ6Sy/BQMHtQAk+Ihsaay3MliD+S+8ujQZwJfCJoKkVTFr3aDvmSyjn7l8THwXwEoLkziJkwKTFG0C7j4Rmpx5uW7OOc8uUNJbF1yKnaReXfIYu5CZ4Xq0vsdhZOck98F6lIBu7qUHhozhuoLmwitN7jCpzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfyL9dtI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55cd798b394so962322a12.0;
        Thu, 25 Jan 2024 01:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706173424; x=1706778224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=REcRr9U0F+uAhsIG75MoYjc4CaoIuwNexNXpisfICY0=;
        b=nfyL9dtIOf+3yBmfj1+Gat9Is/yVkOXl1j49JKvQcIpb5fAbRBwKHbKbZSYucXJx1X
         8C2DgP4yTcXTEwSPn9t6CXG8SCu7c6pN2tMttdkerIghVdOZRcReiSOuMfJ3r9NWAz8U
         JlE8JomoY6Pcc9kGGoTfA/UMr1roNG5epTBb0ev6nBd9eRpLV5aDcnqp9zM9ImW+8PV1
         naVvPfiFOXxwlc+rsuC0T/Nuhz5GgP+SWbSxXZPSrQM9Z38dDYJ9eqb/9c8NR2n2J++E
         VBNCg9Jl5nh7wR1EVXecJT23aAWVS8zQ0N3mOiwvE1R0UXtkxdQyRfD5HkG2u0/sd0W/
         WVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706173424; x=1706778224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REcRr9U0F+uAhsIG75MoYjc4CaoIuwNexNXpisfICY0=;
        b=NBVr4THF3eB1mqLyZ6zHLH5xy1D0LfO5cwDRDGl4H1PEoRM09WBrX4CK2DSMbspFnK
         xI9adVRc+CTbtzwe54B563tiHTUrSPr9XjTO65Jot89QO5Gqg4F6EyfSRD3gH/ZCwIns
         ueMGSTOb0wXxwRgB/LB4S9ZEPCPn8hyMSKfDEC/O69agZnQobYPQTJAr/iB8cuAgMOIK
         7uixd9MJbWiw+KDToQuLUT/PQT7WDqpntWiZLC80+Q8yKACd1/v2Ha6W+ReCBS2qIGlP
         mHvnP6ptqu5Lm3/U3AqDT9h0cb5fVvKkQPati/RZlayc48nNvjlJIJajPaly5oiHeIPp
         s1UA==
X-Gm-Message-State: AOJu0YxjE7egoyT5FuN5erohesvCfm0JHIK79uQaYSoKgTnupVNDkoNc
	5zkjRwDMWNFAGNz6muC+56Gfe+S2swxyYsouMyOni3tjOhob/4b2
X-Google-Smtp-Source: AGHT+IEvLD0YPmKsAENgPb4yCsXotokzbjkbwCO0DMdsJYZJ84GO6F8LKt67QIb0MyH/EPrjVVqW1A==
X-Received: by 2002:a17:907:bb8f:b0:a28:b34d:8694 with SMTP id xo15-20020a170907bb8f00b00a28b34d8694mr631558ejc.62.1706173424308;
        Thu, 25 Jan 2024 01:03:44 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id wh22-20020a170906fd1600b00a30fc529f25sm797099ejb.199.2024.01.25.01.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:03:44 -0800 (PST)
Date: Thu, 25 Jan 2024 11:03:41 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: dsa: mt7530: fix 10M/100M speed on MT7988 switch
Message-ID: <20240125090341.jl2qadhrd2y5yqiv@skbuf>
References: <a5b04dfa8256d8302f402545a51ac4c626fdba25.1706071272.git.daniel@makrotopia.org>
 <a5b04dfa8256d8302f402545a51ac4c626fdba25.1706071272.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b04dfa8256d8302f402545a51ac4c626fdba25.1706071272.git.daniel@makrotopia.org>
 <a5b04dfa8256d8302f402545a51ac4c626fdba25.1706071272.git.daniel@makrotopia.org>

On Wed, Jan 24, 2024 at 05:17:25AM +0000, Daniel Golle wrote:
> Setup PMCR port register for actual speed and duplex on internally
> connected PHYs of the MT7988 built-in switch. This fixes links with
> speeds other than 1000M.
> 
> Fixes: ("110c18bfed414 net: dsa: mt7530: introduce driver for MT7988 built-in switch")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

