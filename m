Return-Path: <linux-kernel+bounces-8992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A3C81BEFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D1D1C214F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C41745EF;
	Thu, 21 Dec 2023 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w3X21CNi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A5651BA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55361b7f38eso1438422a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703186000; x=1703790800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Z8HlsA+ZFH2JyuCGsV664waiNnQgr/VP2ZwaaSFPWU=;
        b=w3X21CNiBIqn9Z2cSxqnVjp6iIytjD32oKMZiRX/kLJYy60iPZZZG2MD8YjGYBn13J
         dpVcDIwDA8ZK1vYj87C/SHXBJZIhqXnRHwqqntPuQEIFDeeakdMSW3Mg6kgCSTtnMB7p
         f9DiCmqQpQ0C4BmFmY/27wOanNjeHwfO7dCeJQmiODml8PGU00wTpYfG4Ui/ZiVb71pi
         T6hN3lJ9oDrpu5ikmR0HSIXjDtEBvE37bUb31Dv2aIv+m6gVIoAkw5YQG9FMdw0CTwRy
         7qGWS0ME3zNlRUEQ/lAG2TWY8QDvgqWeN9V87ETTSuTPipIzfAKgz2W6GnLlyV4CPKg4
         r3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703186000; x=1703790800;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z8HlsA+ZFH2JyuCGsV664waiNnQgr/VP2ZwaaSFPWU=;
        b=eMC1dPgUo6Zn92DMqJrDpGhdsclWGTzBpHhSS3m5kE+tegJRlnmflYKGzi9RsDrw30
         IhvIMr5AMvOaoMtrfDxT9OYACHQUpBn3OTHQnDm6ta5x5HVKPX9KsCzn6rl8HgZ7xktX
         0L+xYH7HZ1Le623ar1Aa6KDSiYM/m5WDgSMRYv2H8K4qKO9uUzEzyrjFegJOolmAPVhK
         ge76jKOrk+U5S5s3YhefUMSMaC8iXGu1Tg1iEzz4jmEpzhKjVJ7sC+cdGz1HCGpNasa9
         f02E3vPZUH+MbBtXRFOeIkA5Fb69kJtLXdvDW9yOv4VAzEl/aK0T2+Ufky8MBgPGDWHl
         EiIw==
X-Gm-Message-State: AOJu0YxNkiqmFwEnKi7iHge1bVT5BDiIIpWTXzYFh5NrMlAbj7E1ZvBY
	j1h425n6WG5gnJ4QvU9w9+8+G0QB6D65+g==
X-Google-Smtp-Source: AGHT+IHBHjiWP8rEfPGu9Au8Y453hOjmfqRFtUUaNY+mxA1ENsJWkYWGv55ne3/J6a9fnbcdQ9pgYg==
X-Received: by 2002:a50:9e87:0:b0:553:8989:f8a9 with SMTP id a7-20020a509e87000000b005538989f8a9mr20202edf.92.1703186000103;
        Thu, 21 Dec 2023 11:13:20 -0800 (PST)
Received: from [192.168.199.125] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id b3-20020aa7d483000000b0054c7dfc63b4sm1545232edr.43.2023.12.21.11.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 11:13:19 -0800 (PST)
Message-ID: <2382ff87-0635-4ab2-bacb-1624d8238e32@linaro.org>
Date: Thu, 21 Dec 2023 20:13:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 00/11] scsi: ufs: Remove overzealous memory
 barriers
Content-Language: en-US
To: Andrew Halaney <ahalaney@redhat.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Janek Kotas <jank@cadence.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, Can Guo <quic_cang@quicinc.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231221-ufs-reset-ensure-effect-before-delay-v3-0-2195a1b66d2e@redhat.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v3-0-2195a1b66d2e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.12.2023 20:09, Andrew Halaney wrote:
> This is an RFC because I'm not all the confident in this topic. UFS has
> a lot of mb() variants used, most with comments saying "ensure this
> takes effect before continuing". mb()'s aren't really the way to
> guarantee that, a read back is the best method.
> 
> Some of these though I think could go a step further and remove the mb()
> variant without a read back. As far as I can tell there's no real reason
> to ensure it takes effect in most cases (there's no delay() or anything
> afterwards, and eventually another readl()/writel() happens which is by
> definition ordered).
If I understand this correctly - and I'm no expert - it's probably good
practice to read it back in critical places, so that if the code around
it changes, the most crucial writes arrive when expected.

Konrad

