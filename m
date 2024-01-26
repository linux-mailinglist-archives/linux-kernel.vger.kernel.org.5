Return-Path: <linux-kernel+bounces-40441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B73D983E037
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6791F21946
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5399320324;
	Fri, 26 Jan 2024 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKbUZTqr"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0001FAD53;
	Fri, 26 Jan 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290395; cv=none; b=ZZh7K5kV1DajDoRZvLpnwmfvlDa261EmcqF2KV8HvnovYIX8H7ALeI286XDf++Pa9UFonvBf9nzwsMlzSSSv/hFMEsRNquVTeN6kWrxKbX3pd3R2j31b2L0EzhMJO4weAo8X++KuOFFEMbS60NSWN9NItIMdWSa9oKJ5GU6XNbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290395; c=relaxed/simple;
	bh=4u61sqqjZehBxh646F6DdVxKle3BO2zveqlaAYOzXnw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADwSUsMYQKa/F/FXUqfWl2mqjxyOFw3VsHgsa7HDOiodPAb/Ywc8nyaOhXdvBpqJSGAWRI4QB6/pEdxM0P7KVcU0uiTRNvoDscSX/hPdjOF0GRJl6aUObC0KJwhn6HxscWc20WHuQSd4TgrpAOmWNpsIl8N0xFhSmNKynIjQnDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKbUZTqr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eacb4bfa0so10002515e9.1;
        Fri, 26 Jan 2024 09:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706290392; x=1706895192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mtd4bbyPik4Tr8inGnsulES64tjmNsuS5Px5C2PS44A=;
        b=gKbUZTqrz+/TuBOj6Ay1k+u/Uq+rMyv5TX9cNu4YGN8xCvzwnsYqC7/rlnD3FigyJk
         XIXXT88LP4RR4c7ppI6oRpm04TPtcbNmfn4f80hi+o8x9NkMAJ/eIMpleTWeDL19cwHS
         7FiPx1Go7vvotdyx53bvBt1fgUpTeCAOz2LZmz554vUJxNwvQmQfNCpC3kSMM75y7X6A
         wh4RYq5ttZ7FI6de4xd6jSwwCT6zsOGobhToEfeob7/FnNkTLQxhAx+pQvcdLdFITfrv
         /LrQVWhpdE/hFDTFVb8+HjG7XQlNPOm9F/eKwwNe/1Pb5zSM8vQnnWXm8gOcfVEADLLK
         7F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706290392; x=1706895192;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtd4bbyPik4Tr8inGnsulES64tjmNsuS5Px5C2PS44A=;
        b=huxcilzTe8qOovWJ8S05UuVDbz5FqCEMkqEMUj83Sd+YYI+0aBOIpBamZh9bS+1X/K
         Xw0FpuB6syB28y+86q9mK5nj+VhNc59+yxSf8Im6OffuiHevtcv06F8UbmDtKu50hF3g
         C93Bzr4LeLNw1zpxMoMQOyt4atfcv4TVWnVH+WUjpLJn2BSH/1Pk/zPyLdAsexYwO5O6
         6nofGVZOlLaKtPAoRjM/4YVqob0GBmVAiuzi3XfNDe3KQDZotK2okq1JnoVq/08+5IhK
         6QW6Gv9ASCKOSwMH5b3LDwTeDjB5krunNHSGjDEgJ27r1RFOvbzkgy1lZiGpdyAwAdbO
         uigw==
X-Gm-Message-State: AOJu0Yx017vITtyAZ629t9NMkghI2BTgNiH7w0A5CBC8A+5FqTlKYIbI
	q9KS2wqqZ/VwlM9uRfKtWnKp2nSPwMc4ABK3FiFVq9k9wzOzeIgG
X-Google-Smtp-Source: AGHT+IFof7OOdjCrgJ+9I4dpAkTsGOjftPfHPwjQ+3moL1LjwkET//fFevHF1KYyZciQD87s2w+fvQ==
X-Received: by 2002:a7b:c448:0:b0:40e:455f:fdbd with SMTP id l8-20020a7bc448000000b0040e455ffdbdmr104571wmi.66.1706290391918;
        Fri, 26 Jan 2024 09:33:11 -0800 (PST)
Received: from Ansuel-xps. ([78.211.30.147])
        by smtp.gmail.com with ESMTPSA id ay17-20020a05600c1e1100b0040ec7a6d39esm6295704wmb.16.2024.01.26.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:33:11 -0800 (PST)
Message-ID: <65b3ecd7.050a0220.9e26c.0d9e@mx.google.com>
X-Google-Original-Message-ID: <ZbPs0v3DaDivmzSR@Ansuel-xps.>
Date: Fri, 26 Jan 2024 18:33:06 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jie Luo <quic_luoj@quicinc.com>, Andrew Lunn <andrew@lunn.ch>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: Re: [net-next PATCH 0/3] net: mdio-ipq4019: fix wrong default MDC
 rate
References: <20240124213640.7582-1-ansuelsmth@gmail.com>
 <53445feb-a02c-4859-a993-ccf957208115@quicinc.com>
 <f8a9e328-5284-4f24-be5d-7e9804869ecd@lunn.ch>
 <5d778fc0-864c-4e91-9722-1e39551ffc45@quicinc.com>
 <CAA8EJppUGH1pMg579nJmG2iTHGsOJdgDL93kfOvKofANTGGdHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJppUGH1pMg579nJmG2iTHGsOJdgDL93kfOvKofANTGGdHw@mail.gmail.com>

On Fri, Jan 26, 2024 at 07:20:03PM +0200, Dmitry Baryshkov wrote:
> On Fri, 26 Jan 2024 at 18:03, Jie Luo <quic_luoj@quicinc.com> wrote:
> >
> >
> >
> > On 1/26/2024 1:18 AM, Andrew Lunn wrote:
> > >> Hi Christian,
> > >> Just a gentle reminder.
> > >>
> > >> The MDIO frequency config is already added by the following patch series.
> > >> https://lore.kernel.org/netdev/28c8b31c-8dcb-4a19-9084-22c77a74b9a1@linaro.org/T/#m840cb8d269dca133c3ad3da3d112c63382ec2058
> > >
> > > I admit this version was posted first. However, its embedded in a
> > > patch series which is not making much progress, and i doubt will make
> > > progress any time soon.
> > >
> > > If you really want your version to be used, please split it out into a
> > > standalone patch series adding just MDIO clock-frequency support, with
> > > its binding, and nothing else.
> > >
> > >      Andrew
> >
> > Hi Andrew,
> > We will rework the patch series to include only MDIO frequency related
> > function and frequency dt binding, and post the updated patch series
> > on the Monday/Tuesday of next week. We will work with Christian to
> > ensure he can re-use this patch as well.
> 
> Can you do the other way around: rebase your patches on top of Chritian's work?
>

Would be ideal, also I have to send v2 that handle the 802.3 suggested
MDC rate (ready I just need to send after this has been handled).

Also I can see some problem with Lui patch where the divisor
value is not reapplied after MDIO reset effectively reverting to the
default value.

If it's a credits problem I can totally change the from or add
Co-devloped, I just need the feature since the thing is broken from a
looong time on ipq40xx and ipq807x.

-- 
	Ansuel

