Return-Path: <linux-kernel+bounces-14226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F042821970
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF421F2213D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB0D291;
	Tue,  2 Jan 2024 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXmgNEeF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F00DDAD;
	Tue,  2 Jan 2024 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d5d898162so40626245e9.3;
        Tue, 02 Jan 2024 02:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704190116; x=1704794916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dpc6DLWIrPxzCu9FbM53oVf2cxVoZey1VGjFQBWiI0o=;
        b=gXmgNEeFZDRUIKxmMW+p/zYguW3gWoQYwJ6B6CagQrLk5RR/3v9fZW1twkHnmQih0f
         WyXJnMc54PfmSVdJDBTw8PdWRDVACWjn1XxTioOr7e9v7OrPILmA0giUlDWylNe1uSXz
         /eo18mPOShStuS5U6Vm1q04z8Aw0Dm2Yl2uEGc8YVVVBQcdhfQ4zlz7l9pPCtIvnWYSH
         oyD4i/cNRL8+AHw+Kbi/mws0QP6zVCxHjry19b2Oom93qXlG9NIMcYieUEK3TdEaLAeT
         7vrz/UtWiMK2fJWXH0YFH3TPPOUe/xzeIu2w9OaJYVsS4wSihPPM6A/xyugTulpgpRKj
         z8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704190116; x=1704794916;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dpc6DLWIrPxzCu9FbM53oVf2cxVoZey1VGjFQBWiI0o=;
        b=w0bOwVOH1oK5W0w7dT3F77Xn7N9Dcex2fsUOpbIMh3RneH/VbrHtULSkt49L3E7bal
         OfTk644vR2MnkacuRm7w49GnK6A9+EwIplePUGlpY8By+n67bjOI68aGEyIWcYzLa9aB
         xQXt6KjjOIMZCOjvNMiPwj79pxqe+IR8fqRNzm2ank3k5QoQJHTrUY0XOPEKz0suLaDa
         bDjwCpymRDtzq8GzrTda+Nh6zYv3Uh3mWRRCLfKhgeJ/pDt9pyq0b3GZVeOrQ/m/xkS+
         tIqZQPP6mvN7X3EHUwfYTAAzblNbFzQzf1JLq3X6E2Fbs3Vd7F03h06fh/EnSBUO10JV
         qLkw==
X-Gm-Message-State: AOJu0YxFvNexsgrWzrZRafEk+71Tya1HSbHyErqlRauBRqo4FVgt8jt9
	IeDbnFQzrFPVlvhjbcbr3xA=
X-Google-Smtp-Source: AGHT+IFazNVLxT/OuqmVZMCn5AzeEeZrraKYZ82bmTf+5NsyI7Rl/W2vE8iplRgQqwTcAnTGxxvyVA==
X-Received: by 2002:a05:600c:34d6:b0:40d:8bbe:a720 with SMTP id d22-20020a05600c34d600b0040d8bbea720mr757213wmq.116.1704190115886;
        Tue, 02 Jan 2024 02:08:35 -0800 (PST)
Received: from Ansuel-xps. (host-87-21-250-146.retail.telecomitalia.it. [87.21.250.146])
        by smtp.gmail.com with ESMTPSA id i16-20020a05600c355000b0040d5a5c523csm25317030wmq.1.2024.01.02.02.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 02:08:35 -0800 (PST)
Message-ID: <6593e0a3.050a0220.5c543.8e12@mx.google.com>
X-Google-Original-Message-ID: <ZZPgopkuvmgpKeRA@Ansuel-xps.>
Date: Tue, 2 Jan 2024 11:08:34 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jie Luo <quic_luoj@quicinc.com>, Andrew Lunn <andrew@lunn.ch>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, corbet@lwn.net, p.zabel@pengutronix.de,
	f.fainelli@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
References: <60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch>
 <a65ad12d-b990-4439-b196-903f4a5f096a@quicinc.com>
 <f5c5cbce-c36e-498a-97e2-35f06d927d74@lunn.ch>
 <a9798333-3105-422f-8033-76c0b1d4f439@quicinc.com>
 <7c05b08a-bb6d-4fa1-8cee-c1051badc9d9@lunn.ch>
 <ZX2rU5OFcZFyBmGl@shell.armlinux.org.uk>
 <6abe5d6f-9d00-445f-8c81-9c89b9da3e0a@quicinc.com>
 <ZX3LqN8DSdKXqsYc@shell.armlinux.org.uk>
 <1bddd434-024c-45ff-9866-92951a3f555f@quicinc.com>
 <ZZPeHJJU96y1kdlZ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZPeHJJU96y1kdlZ@shell.armlinux.org.uk>

On Tue, Jan 02, 2024 at 09:57:48AM +0000, Russell King (Oracle) wrote:
> On Mon, Dec 18, 2023 at 11:01:03AM +0800, Jie Luo wrote:
> > 
> > 
> > On 12/17/2023 12:09 AM, Russell King (Oracle) wrote:
> > > On Sat, Dec 16, 2023 at 10:41:28PM +0800, Jie Luo wrote:
> > > > 
> > > > 
> > > > On 12/16/2023 9:51 PM, Russell King (Oracle) wrote:
> > > > > On Sat, Dec 16, 2023 at 11:21:53AM +0100, Andrew Lunn wrote:
> > > > > > > The following is the chip package, the chip can work on the switch mode
> > > > > > > like the existed upstream code qca8k, where PHY1-PHY4 is connected with
> > > > > > > MAC1-MAC4 directly;
> > > > > > 
> > > > > > Ah, that is new information, and has a big effect on the design.
> > > > > 
> > > > > This QCA8084 that's being proposed in these patches is not a PHY in
> > > > > itself, but is a SoC. I came across this:
> > > > > 
> > > > >    https://www.rt-rk.com/android-tv-solution-tv-in-smartphone-pantsstb-based-on-qualcomm-soc-design/
> > > > 
> > > > The chip mentioned in the link you mentioned is SoC, which is not the
> > > > chip that the qca8084 driver work for.
> > > 
> > > So there's two chips called QCA8084 both produced by Qualcomm? I find
> > > that hard to believe.
> > > 
> > 
> > The SoC mentioned in the link you provided is the APQ8084 that is introduced
> > in the link below:
> > https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdragon-8-series-mobile-platforms/snapdragon-processors-805
> 
> So the one mentioned in the rt-rk article and a load of CVEs is _not_
> QCA8084 but is APQ8084. Sounds like a lot of people are getting stuff
> wrong - which is hardly surprising as there are people that seem to
> _enjoy_ getting the technical details wrong. I haven't worked out if
> it's intentional malace, or they're just fundamentally lazy individuals
> who just like to screw with other people.
> 
> Sigh.
>

Hoping to give some clarification with the naming.
- APQ8084 ("Application" SoC for 8084 family)
- IPQ8084 ("Internet" SoC version of APQ8084)
- QCA8084 (Integrated PHYs in the IPQ8084 SoC)

I guess?

Considering QCA8084 is only in in IPQ8084 SoC, the confusion with
referring to it is in the fact that it's all the same thing, and
everything related to APQ is also related to IPQ since they are the same
SoC with minor difference (different DSP, presence of NSS cores)

I can totally see sencente like "The IPQ8084 PHYs..." referencing the
QCA8084 PHY.

(Just to put how the naming is confusing there are PMIC with the
same exact naming)

-- 
	Ansuel

