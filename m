Return-Path: <linux-kernel+bounces-45766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FBA843606
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749C62873E6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C635F3D54F;
	Wed, 31 Jan 2024 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yzzl1MsB"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81FA3D550
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706678620; cv=none; b=qiz4+o2wIVmqDz+UVbxa1F4RNbmdb7L9Zh38HXakIOsE1G4/+vlH8QHSci4b3VUgQ9LhZps+Dj67O00Vdc9Znlz+fA8JroYxzFRBdTmzPtUHBSN0NbZfJipDDJxeIm2PE83f2p9R8HqgeK382EIUkvmIs3Aef19QkmK3oLilwBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706678620; c=relaxed/simple;
	bh=L0p7ixoYzTuLRVQ7tvm91KGfjN08Kl6GBFk8OqLI6OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzL3Mq5vyh3KiZW5A8gF+tE6fR72cs/+GrP5yE1oWDeCTw6ybUdqzCpIAhgzM/T7ND6un0xzHheDwx8fOBgX0EAyjTjPF7kCHbTeElwLRf/arKDLnahI8Gam6jAMfqyPu6lHnk+AYLp9qvkswQaF9TPD47nWHxCWki0qb7nuFBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yzzl1MsB; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-295d22bd625so526671a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706678618; x=1707283418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cB/uX9Ocu3GZVsO7k6nFsrnvwZVXV/HVGYWM4rZmpjk=;
        b=Yzzl1MsBjGDQhRf1Dxixh/bOPYher167GDaQePCdnp9NSjqghUeBE8t88T0NYzOETv
         Akm9YZxh5tBZQbKeTFge/lPlbtj2lBuxZBY3vIJCL9SdkC2AME1nMNJRIcVmkcISIqPs
         kQzVZllpW/bmjsEKKsEc3+CeNKmakaiM0+di5WpTKiaRrvP9R0KZm1O0kxOKL0Jf0zf0
         6vEQcrmwCDSUWEgTYVbXgixe1RJ1OpSHmMb5D5iTVGZBjZljmzTJkRwWR8irhntnDlX5
         H2xQA8dPggf4KQoB5DEq4UOYyfBe82s0rhcxaNOFu7DABBdIbvnx+lpvRGot3es/beDr
         4xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706678618; x=1707283418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cB/uX9Ocu3GZVsO7k6nFsrnvwZVXV/HVGYWM4rZmpjk=;
        b=wDilZ8N4VSzlnyIUptZ4vCQ706+hJPofxv1Vz9V+Xv+bCx7ZBarg8gIyBpBpPaFzqL
         IxYP/0mmi067U4tq2YFWPu7R7nDFB034I5ZhOt7PNBsSLhCz0Dq7cHbs93V5T7PCAFQa
         5LnSyOvBjjqeB3bWiwz0nUU1YpnfdlwuALB0J6hhnf5mxns7LIHZwkF9uTcLXLU7+3Ax
         n9UtcpukTLb/zSb1NwTxX8WvI1LPLMSa2NM8K6mD+w3meoy7Ww/bKTPRnaFZUFdj0YhZ
         VqCtHQX2aeWlrP13v+JCsjLC2zShpzeWnJY6LGQLK7Zxw5VayrbI2uxRRVEHYMRKu1Ju
         l75g==
X-Gm-Message-State: AOJu0YwesBmtgkOJy5M3p5WpsOeJedRnbI/NiCRuW6HA7/FkxytA12dI
	fZWsfu8+GnxTeh/6bS83kBD6bOUI73O9azx9/dAnNWw8/JcIRt6Er/7FebBOWzI=
X-Google-Smtp-Source: AGHT+IFVUXicyliLtZJ8DOMkazOx8shXzWZk/TfrCAd+7gzTLSrdbtiAadd8bgzl+WwpG8GaYqrLiw==
X-Received: by 2002:a17:90b:507:b0:295:bea4:a16e with SMTP id r7-20020a17090b050700b00295bea4a16emr723201pjz.23.1706678617971;
        Tue, 30 Jan 2024 21:23:37 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id rm13-20020a17090b3ecd00b0029494384eaasm393119pjb.43.2024.01.30.21.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 21:23:37 -0800 (PST)
Date: Wed, 31 Jan 2024 10:53:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: sm8450: Add opp table support
 to PCIe
Message-ID: <20240131052335.6nqpmccgr64voque@vireshk-i7>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-5-77bbf7d0cc37@quicinc.com>
 <20240129160420.GA27739@thinkpad>
 <20240130061111.eeo2fzaltpbh35sj@vireshk-i7>
 <20240130071449.GG32821@thinkpad>
 <20240130083619.lqbj47fl7aa5j3k5@vireshk-i7>
 <20240130094804.GD83288@thinkpad>
 <20240130095508.zgufudflizrpxqhy@vireshk-i7>
 <20240130131625.GA2554@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130131625.GA2554@thinkpad>

On 30-01-24, 18:46, Manivannan Sadhasivam wrote:
> Agree. But what I'm saying is, right now there is no DT property in the
> interconnect consumer nodes to specificy the bw requirements. This is all
> hardcoded in the respective ICC consumer drivers.

I thought there are a lot of users already in there..

$ git grep -i opp.*bps arch/arm64/boot/dts/ | wc -l
864

> But when we use OPP to control bw, the bw requirements come from DT. This is
> what I see as a difference. Because, only nodes making use of OPP will specify
> bw in DT and other nodes making use of just ICC will not.
> 
> Maybe I'm worrying too much about these details... But it looks like
> inconsistency to me.

Right. So is there inconsistency right now ? Yes, there is.

The important question we need to answer is where do we want to see
all these drivers (specially new ones) in the future. What's the right
thing to do eventually ? Hardcode stuff ? Or Move it to DT ?

The answer is DT for me, so the code can be generic enough to be
reused. This is just one step in the right direction I guess.
Eventually the drivers must get simplified, which they are I guess.

-- 
viresh

