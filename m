Return-Path: <linux-kernel+bounces-155250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A6E8AE778
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012D41C23513
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3704135403;
	Tue, 23 Apr 2024 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ting4AdE"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1001353FB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877692; cv=none; b=CMBW3KpRkjULBaUo08OiA4Q311M2eRuFJYMj5KnazXsusDCGPiR4tmbVbZkA8wLti8uWkI+z6v+zr7IxX6StUqWKxoVYhRquUYKOaHLSAqKRg4vv8Tj9OJnEYFww45PXGNKZgXM2vWWJY7fQtAeBey6HBXJZKtFKQDEJP7LLOiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877692; c=relaxed/simple;
	bh=BeIUqQAJFNDOpF7ht1GQmR6wVW1LPDbJ/XROhUKljBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/kWKmU+Qr/FRKOz1eomJJ2KDsiSmyZ46iidk4n2Lxr+P021D5ve+GoEI5rFdIBDZ9rnizZ33JzK+NbUrFr3iUomgMupNRZz1XHChYvhMiJN2h4/rYpVVQIrYPWPBUcf0ZRg3IL5KxU4pL478UJjBdRkke+RMFDEdW/ldglNVbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ting4AdE; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso85257591fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713877689; x=1714482489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BeIUqQAJFNDOpF7ht1GQmR6wVW1LPDbJ/XROhUKljBc=;
        b=ting4AdEyo60Uc45ePzamwPNjTyqc0LE1KIsTEOF4E8J8XTRjgyqRMupeNTLrsspru
         duR4fu9Yt2rGDCsmuyjcY6bLaBzQvZ/rDwWnGSRT+zXw7yeLXBcGomgUcOjoFA3oqjNA
         /RU3J+nfgZ1yf2UY4ah/ZjrwJ2CQpdiy4vi25NfFFXec0Yk/qCOTAJrOp26mps3g9B12
         Cf8jvqxtBLz5II6o9xIImf1zYLVbFcqjP87cLbDzHflAt9p6N7PfUQ0o41vTK5Af74yO
         5RA9OuivQ0SIC8mBBnyS4B7S7d6tIHgY3tuCUXEMLE6Djgqpi/ilJu4bxTB65lLecdB1
         wARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877689; x=1714482489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeIUqQAJFNDOpF7ht1GQmR6wVW1LPDbJ/XROhUKljBc=;
        b=E+Goh66giZpTtAoOSAPkgT0FKGYjdY3CONr6dIc2rq4sqpv/o6rxpjyRwa3Yqc7gZq
         6eGyYu8oanvVxLyYolrzo6VUMl+PYRJ0ICaanM21D0jL7/KufIJW1rFYdg41KlCzUgUa
         FpZ09G5SaADyUxwlidtlhbDSsKUETE/PzImVKXDkC0AdvZc/dXK3jQ6f+Te38dSCJN+n
         XfbN4xG9d6QEdK4bW0g0gXxZBFdC75MI/Kdq9LDeqqTPOuHP0nJ9ciwAyDACo8uroG0Z
         gRXUOlY1aUKG+RKebWlk5/DHNE4X6HPICRtcpZluJPhghNc8kkUqGw8kYjJLlF/RxXP6
         U4kg==
X-Forwarded-Encrypted: i=1; AJvYcCU/+a3+TCYX9dvE+QA5IfIerosZFD3zhFqTQnd76jmNG/QLvaZuGthLgIGfLMwGmMXeZKl+N8cgl6p56E24lZ3w81RBZax6bFGDPpw8
X-Gm-Message-State: AOJu0Yz/kDIjoxb34o+QZbBUBa/rI2s+sgAMvcaVbFJLhcheEknDvozR
	6NAImQOMx97ydgt1srDHh+meyq1DoEjO5VVYAkESBbu5M/lMcv+jbVGqUwfR7UA=
X-Google-Smtp-Source: AGHT+IE63dqBihv/nXAaphUKhm4QoRx8cccrUbZIncSaNE5pK7FBZ6/h8B/ymrmWiFGABv0uHgk0Og==
X-Received: by 2002:a05:651c:1a06:b0:2d8:34ec:54e6 with SMTP id by6-20020a05651c1a0600b002d834ec54e6mr9435410ljb.33.1713877688746;
        Tue, 23 Apr 2024 06:08:08 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k11-20020a2e888b000000b002dd92e1ae00sm542013lji.26.2024.04.23.06.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 06:08:08 -0700 (PDT)
Message-ID: <8cdcfa2f-7a8f-4f63-b919-df0afde7d9de@linaro.org>
Date: Tue, 23 Apr 2024 15:08:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/3] PCI: qcom-ep: Add support for SA8775P SOC
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 manivannan.sadhasivam@linaro.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
 quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
 quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
 quic_schintav@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1711725718-6362-1-git-send-email-quic_msarkar@quicinc.com>
 <1711725718-6362-3-git-send-email-quic_msarkar@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1711725718-6362-3-git-send-email-quic_msarkar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/29/24 16:21, Mrinmay Sarkar wrote:
> Add support for SA8775P SoC to the Qualcomm PCIe Endpoint Controller
> driver. Adding new compatible string as it has different set of clocks
> compared to other SoCs.

So is it the only change after all? What did we conclude on the NO_SNOOP
saga?

If the difference is only in the consumed clocks (and they're only supposed
to be "on" with no special handling), I don't think a separate compatible
is necessary at all

Konrad

