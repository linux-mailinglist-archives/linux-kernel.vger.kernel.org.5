Return-Path: <linux-kernel+bounces-24944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526B082C51A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63041F2395A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176FE1AAAE;
	Fri, 12 Jan 2024 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/rqv0lp"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A4117C85;
	Fri, 12 Jan 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33677fb38a3so6125533f8f.0;
        Fri, 12 Jan 2024 09:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705082217; x=1705687017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JqFsKecuSBrO3jxaxuNvcAexfgq6FB4LiqKsGB+p+Ao=;
        b=A/rqv0lpoU2jEZ50hsU0WL4MbmbBlYijMkrBwRKVxfOG4OlAe9YIuImYaYGJETFKtg
         O8dSn2xyFn6T55crran0I9r1pwo2HaLHWSpmvdPyml8WxVAXx/LXJEWURBxnLmo/nS0t
         xvoADAERWZQJjoeRxX6i567i6C+8Puvd85zh7z4x1CGaYBp8mg+KT7RL7h+dlA7BXy6P
         3o/vddzY55CzuJNInvH689pd+S/SMqOQ+7T1QevkmrLZAfjxXHV0qfrXauIn1ODW2Ydh
         HIPYVvu/yvHbCiBb2aEBdImk8qfLaFt6qoiXO6L9kMA+zdRv0K2xNapHTPtR5ZXbcZmg
         JiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705082217; x=1705687017;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqFsKecuSBrO3jxaxuNvcAexfgq6FB4LiqKsGB+p+Ao=;
        b=g0jxa2NIfpZDjFqa8SZILOSYAAXVfvY19BmP2udug7mYH9rDK3jPZzkgXDjakzEGLH
         kocO/j50o0ixfefZgbs5y+V7YdYD9mQgJ9iyD8aRtDK2gKX6/XZe2mN7vRiUS3qaLJfK
         82a7Jklw1oOtA/uU+H9vtz22sOID2lkWaSOs3vddozzdf7u758EfCo7g07I+aGvHD7jl
         lnqaeQyxRbQ7hiWId8xixmzesoyP65MaGwC6pVAxleBUwihaVy11N/l5ocMYFDJIxbPl
         VHvFrHDFO9W0bngPTzXIn1fFtXJgIlU50xhSjaaYHc9IXiNVACr/k4ghEeNmRxNaWjRz
         RXpg==
X-Gm-Message-State: AOJu0Yzxw9FgJgmuocOJ/BEmQXaUzDgj1bsFkmTDxXWja+LFNHSf3G5W
	wB/JwkHI7AI0A3aiznSQSxM=
X-Google-Smtp-Source: AGHT+IGPZIgGiqiQoRnTNwSkb1n4FM8VBJoZC4UuFdNhrP6t/RZ2bgvGvgxmNKODX86VaJLUmfX0Sw==
X-Received: by 2002:a5d:614d:0:b0:336:7b51:63e0 with SMTP id y13-20020a5d614d000000b003367b5163e0mr793114wrt.72.1705082216767;
        Fri, 12 Jan 2024 09:56:56 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id e13-20020a056000178d00b0033743c2d17dsm4528385wrg.28.2024.01.12.09.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 09:56:56 -0800 (PST)
Message-ID: <65a17d68.050a0220.cf6ea.e78b@mx.google.com>
X-Google-Original-Message-ID: <ZaF9Z2upRACKxDZI@Ansuel-xps.>
Date: Fri, 12 Jan 2024 18:56:55 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Jakub Kicinski <kuba@kernel.org>, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
	p.zabel@pengutronix.de, linux@armlinux.org.uk,
	shannon.nelson@amd.com, anthony.l.nguyen@intel.com,
	jasowang@redhat.com, brett.creeley@amd.com, rrameshbabu@nvidia.com,
	joshua.a.hay@intel.com, arnd@arndb.de, geert+renesas@glider.be,
	neil.armstrong@linaro.org, dmitry.baryshkov@linaro.org,
	nfraprado@collabora.com, m.szyprowski@samsung.com, u-kumar1@ti.com,
	jacob.e.keller@intel.com, andrew@lunn.ch, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ryazanov.s.a@gmail.com,
	quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com,
	quic_soni@quicinc.com, quic_pavir@quicinc.com,
	quic_souravp@quicinc.com, quic_linchen@quicinc.com,
	quic_leiwei@quicinc.com
Subject: Re: [PATCH net-next 00/20] net: ethernet: Add qcom PPE driver
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
 <20240110142428.52026d9e@kernel.org>
 <5ec26378-a5ff-4de3-b69e-806e36907db6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ec26378-a5ff-4de3-b69e-806e36907db6@quicinc.com>

On Thu, Jan 11, 2024 at 11:49:53PM +0800, Jie Luo wrote:
> 
> 
> On 1/11/2024 6:24 AM, Jakub Kicinski wrote:
> > On Wed, 10 Jan 2024 19:40:12 +0800 Luo Jie wrote:
> > > The PPE(packet process engine) hardware block is available in Qualcomm
> > > IPQ chipsets that support PPE architecture, such as IPQ9574 and IPQ5332.
> > 
> > What's the relationship between this driver and QCA8084?
> 
> The PPE (packet processing engine) is the network processing hardware block
> in QCOM IPQ SoC. It includes the ethernet MAC and UNIPHY(PCS). This driver
> is the base PPE driver which brings up the PPE and handles MAC/UNIPHY
> operations. QCA8084 is the external 2.5Gbps 4-port PHY device, which can be
> connected with PPE integrated MAC by UNIPHY(PCS).
> 
> Here is the relationship.
> PPE integrated MAC --- PPE integrated UNIPHY(PCS) --- (PCS)QCA8084.
> 
> > 
> > In the last month I see separate changes from you for mdio-ipq4019.c,
> > phy/at803x.c and now this driver (none of which got merged, AFAICT.)
> > Are you actually the author of this code, or are you just trying
> > to upstream bunch of vendor code?
> 
> Yes, Jakub, there are two authors in these patch series, Lei Wei and me.
> The patches are already ready for some time, the code has been verified
> on the Qualcomm reference design board. These are not downstream drivers
> but drivers re-written for upstream.
> 
> > 
> > Now you're dumping another 10kLoC on the list, and even though this is
> > hardly your first posting you're apparently not aware of our most basic
> > posting rules:
> > https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
> > 
> > The reviewers are getting frustrated. Please, help us help you.
> > Stop throwing code at the list and work out a plan with Andrew
> > and others on how to get something merged...
> 
> Sorry for trouble caused, will learn about the guidance provided by
> the review comments, and follow up on the guidance and have the full
> internal review of the patch updates before pushing the patch series.

I renew my will of helping in any kind of manner in this, I love the
intention for EDMAv2 to have an upstream driver instead of SSDK, hoping
in the future to also have the same treatement for EDMAv1 (it's really a
pitty to have a support hole with ipq807x not supported)

Feel free to send an email or anything, considering this is massive, an
extra eye before sending might make things better than reaching (I can
already see this) a massive series with at least 20 revision given the
complexity of this thing.

-- 
	Ansuel

