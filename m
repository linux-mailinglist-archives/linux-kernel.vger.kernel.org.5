Return-Path: <linux-kernel+bounces-22135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CC68299D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E211C25AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9241548788;
	Wed, 10 Jan 2024 11:48:14 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D643482D3;
	Wed, 10 Jan 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so2918264a12.2;
        Wed, 10 Jan 2024 03:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704887291; x=1705492091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9Zq9GKWqta6ICAtqEU6fr3Wjl7exxbBxBD4kWvF4dU=;
        b=GdEidBTiQ05EJ9Or91814Oz2VGlUe7cDUDyWyOX+F7RXXK//zjopVZm66JKbD5BQjR
         kIOQw2HzV/WUxIT/eslpaC273A5WSuqXpZJOwCz/VDphUPoNV7AHvx+1opKDsAb3GCL/
         4BCOCiUUcsvvmgh7vsMPDN12niszPyJWVTPcDc2dEGiNyZhzMe7ezUHqlvwceeRrZ4vM
         6f2tFRHN8Cq7tuOGYUa9VKqcY99iinUcLAvq7N2WAPp0Fq4anQUml7v8f625JRTdI6Sn
         cou86kDtcHW3EgU6cWOYrTtRynKlZzWo8JZZPbEo9+Wt8LDyQ3X5HXdGq4Sok52s4mcb
         eF1A==
X-Gm-Message-State: AOJu0YxI5Bj/xm29J3ITfLAfgM0ZV0a+r1kRNz59C8E8C/OmfJHRt3M2
	emW4nooVV4FdFTtpVOOID1k=
X-Google-Smtp-Source: AGHT+IGjzvnapI0zijY7x5/NYywNVV1ffVnagAX2zyHlUgtQbten23Ytlf8qlfI9RIg1uAtJdyiFDg==
X-Received: by 2002:a05:6402:26c7:b0:557:91e1:25aa with SMTP id x7-20020a05640226c700b0055791e125aamr410983edd.78.1704887290635;
        Wed, 10 Jan 2024 03:48:10 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-017.fbsv.net. [2a03:2880:31ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id x3-20020aa7d6c3000000b00557463cdc76sm1894746edr.69.2024.01.10.03.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 03:48:10 -0800 (PST)
Date: Wed, 10 Jan 2024 03:48:08 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next 10/10] net: fill in MODULE_DESCRIPTION()s for
 PCS Layer
Message-ID: <ZZ6D+AylYTNDW9F9@gmail.com>
References: <20240108181610.2697017-1-leitao@debian.org>
 <20240108181610.2697017-11-leitao@debian.org>
 <cf825e28-cceb-49e1-9880-7971cc955b2c@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf825e28-cceb-49e1-9880-7971cc955b2c@lunn.ch>

On Mon, Jan 08, 2024 at 08:21:03PM +0100, Andrew Lunn wrote:
> On Mon, Jan 08, 2024 at 10:16:10AM -0800, Breno Leitao wrote:
> > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > Add descriptions to the LynxI PCS MediaTek's SoC.
> 
> Does pcs-lynx.c also have this issue? It can be built at a module.

Absolutely. I can see the warning in pcs-lynx and pcs-pts.

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/pcs/pcs_xpcs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/pcs/pcs-lynx.o


