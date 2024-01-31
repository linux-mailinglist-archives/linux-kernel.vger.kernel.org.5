Return-Path: <linux-kernel+bounces-46173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CA0843B92
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BCF1F246FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D69E69979;
	Wed, 31 Jan 2024 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D51H5Cg3"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6A769D0A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706695210; cv=none; b=Z+0gCzuG4vFztcyJsoSXUjjtSG04RBe94cR8nLzVTO5XSeWsLGt9J/BsLMlWuz/srjGkhsMYYsr/LY4X4QVtH4B1w0MJd9HTdSrKoYUADNndiOrIa//JbJjWqOnE5eEbTV+rxh/aaJ3sB+WRblB03Tkl2jcn0Ta4zh+WdRt2RUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706695210; c=relaxed/simple;
	bh=EwuXbJl0WAVRXL0rgaIH6Wpsbj6Zid+vX6fkUwJxkqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC7xDu7VilqeoSuXDY04IMbeSP57pztHcYytYJvTuzBDwnk9byAesQv4DFGtdhkRSpDBn0TdQRoPOoToOlq2HJM9D1+CoUf6cMfR/jMl1mNcuuOcCcyWu0GIsrmKEVVNFcILi1WV6XIWH3TncaEaNNGR6WJ4A2TGMYKFJROC2k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D51H5Cg3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso3169976a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706695208; x=1707300008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7FrCT1wwwtLx5u30OBBWaUcf3AdEwyHikp9zVCTIvjo=;
        b=D51H5Cg3RmWbhBDQ0cJyaL1UI2b8lZP91YFn6BRcOCKsQ8hg7AMPlHGX+2hEsRptKQ
         +ZAX6yz0lTZe6Kmo9HNVJAcZBmNhXyK3vgkZwRfRJHPHVO5ky+EpP249B0DnVz7tGf8s
         qiaMJLU9LsTzM0yQZIq7w0dXPUYwLzxUX8+XVWpTkPaD5IKZw8FGIgfyk47gUwDXHnH9
         gHexHuq2hxj9eJZ7/Z5QAOWv+47phSdHTA8MQSbt/8sEkV7jjRUIyZUlZBFJ6L8SBO7t
         pmHOnemcYzIAygSAMXkaYhaIORDbaOdX3nWoc/xHZOvAzLVgdEvB3gsnGSRka3eVDsbd
         SIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706695208; x=1707300008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FrCT1wwwtLx5u30OBBWaUcf3AdEwyHikp9zVCTIvjo=;
        b=MXSHrOYq058Ciq+OKHQnxab7rJQFh8hkF2WqbbmdIiWkKa/JGY4RQNDsEDPqeChr4c
         d7QlHS9BLVF1jdG+mAZFcYIPXiQxit9QOoFJLJSszo35c57fGjqI7Qi/2aIwBoao+H/i
         Cnvqyc3wc6ymkxiEJez+h9/8DBgWhMYXAMWZ5JXSkYn/bRa6UMxDrQkCPrXmTmiMQ1/0
         1NWpsWfPhYz0PbtgCxfixsisafeQunnRQhqXXhm1ILe3okRUKh+sWhEVMAecBMUiWTup
         jjvGFEHKSRTMh39psoB8hu53KjC44r6oc4lbxEovD6HMIUmaSG2StTh9rRDUSOp3uriA
         DKbw==
X-Gm-Message-State: AOJu0Yzjd0gN3ko/nRK0UWllqQUFqXq/pcpAh7Z+crsLmucKyJw1N6J9
	p4MTN8Bw3RAVPWDtQyOQuUO4447GFesq3xz3bIQs9n1r+eV291YmUExGqKUP1nk=
X-Google-Smtp-Source: AGHT+IFPdnmawxrZjR32Kwpt4olxY8wSnNGp0lJYF+asxnz9nLuKsb5bQwlNp9TpbU3kBKTw8BYYNQ==
X-Received: by 2002:a17:90a:e50e:b0:290:6895:aff6 with SMTP id t14-20020a17090ae50e00b002906895aff6mr997001pjy.48.1706695207700;
        Wed, 31 Jan 2024 02:00:07 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id dj15-20020a17090ad2cf00b00295e041baf5sm1051645pjb.2.2024.01.31.02.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 02:00:07 -0800 (PST)
Date: Wed, 31 Jan 2024 15:30:04 +0530
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
Message-ID: <20240131100004.uqx6vaucojqo4kyg@vireshk-i7>
References: <20240112-opp_support-v6-5-77bbf7d0cc37@quicinc.com>
 <20240129160420.GA27739@thinkpad>
 <20240130061111.eeo2fzaltpbh35sj@vireshk-i7>
 <20240130071449.GG32821@thinkpad>
 <20240130083619.lqbj47fl7aa5j3k5@vireshk-i7>
 <20240130094804.GD83288@thinkpad>
 <20240130095508.zgufudflizrpxqhy@vireshk-i7>
 <20240130131625.GA2554@thinkpad>
 <20240131052335.6nqpmccgr64voque@vireshk-i7>
 <20240131084645.GA3481@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131084645.GA3481@thinkpad>

On 31-01-24, 14:16, Manivannan Sadhasivam wrote:
> Most of the hits are from CPU nodes... For some reasons, peripheral drivers are
> sticking to hardcoded values.

I guess the reason for this is that the OPP core wasn't used for non-CPU devices
until recently. And we are in a transition phase where few of the drivers will
migrate to using it and so will have DT based bw values.

-- 
viresh

