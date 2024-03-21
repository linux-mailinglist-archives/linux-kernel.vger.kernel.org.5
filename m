Return-Path: <linux-kernel+bounces-110745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB65488631E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EF51C2255A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFB5136669;
	Thu, 21 Mar 2024 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gq0n5LP4"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E9134CC8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059374; cv=none; b=PE6qvaQcrPEd3DQLji8BM2zQdw0Y0xEBlD9wxmKgCX7AAg0hhNEGuns8hsLhSEVbFnv64yT0js8tajnoNZwDYrNxsxOkY/tghweWpW2p27LT+qEBkO3h36KK0XPfBwiFtCAdZ1eIqN+gNmczRhcBgvHaqvF1rWxiPF7doP8CQLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059374; c=relaxed/simple;
	bh=T4gQUy6GE487NDr7K2Z8n60Xt0Mrnj2glineNFHELZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQmhjRWaB19uP4mU6gjC3ku6lXqenTlnY68o0BODa6OiW0Xz70Cx1b7cOtSZjDEUXrs3of4qOGXQ4mWMqrepabpLZkKi/Y34FDR8LYUhcxnOoENw6i0Eztr0sxeooTJ8r05WHzmzwhhfIcMVMBleS30ryEQRQp4mLYIKc/ZgkEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gq0n5LP4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so24964211fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711059370; x=1711664170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l24MGdMtmEc55Y3D3O3L6cnTgOl07hyHW0ijrxfPF1o=;
        b=gq0n5LP4Ft7UgeAP9pzrzVf6mcFU2KZOTUdo79lM9DJTFjK0BqFS2pXXCFTel6RYNM
         ObPH/PAbLgrrlfJuZdCadDza9Fh0MtKg6UIrgOPHfwKqfRAw8oo2MjVvWfb02HFI5mZM
         iTiaH3YbbyolhTnBF/f2aDtERTTnnG7Y0XAXzTJmD8JEEuTynx6pE1V8c1tp92XmDDJ0
         iyvC2bd598DImo7FmQMz/z0VxjEnl6kitZGSDOUxwjfo4yfzifMgj3HyrCYQvK3arwn1
         4HctAfAHc0uNBba75rhONrmL7LQkuH2Jmu9CmYzMnoH/Ie/irK+/5P5we2fyeGu5JVgr
         jVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711059370; x=1711664170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l24MGdMtmEc55Y3D3O3L6cnTgOl07hyHW0ijrxfPF1o=;
        b=OrZzfyha3JicrWHzNEmmbbYOeugik8Nn6/ExoNCwyUoIMoAgtMupE5u8WsC9moj2s4
         32UvTi5NhZqAVjAJWPL3KzD6yz8+uE7DKnOdYBleS5uvkaNEG7fNjmJUn3XllAkPKxDn
         2UyShwVPgKPTfZxIF25ZUVMH8zp+nlGA6J/U14rbYWKoTEhcmaPdgx2OI+HILg2+NMHU
         VeoghjQfECY7AzMKhzNJ9uqhx6SSsNcppSFBykE72qTG1iT/R6BRdNxAEQowyylZyeCK
         iKgnTIv6jNDtzsshnDgqES5AVFx4qKSTe8JQpVO3Hk5EMYhXurBhOzWuiitLknX+SH9w
         Y2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXhMYub+hc44FRbr1Q/B9ToSAB916pdnXyjIgyTEA+kQZ4t+M3ptrdq6+IXY4cQjP5hmsZqhW5Xzvjet8lMSOkRZoo/p3wELWJgbf+y
X-Gm-Message-State: AOJu0YxSG1ze9rOj1Dg4/fx+RYDohRcgTmhvAu5c2nng1U+sVUT3IbLY
	jrVypXY5jpFee5btPYHtd5RDdEvs18IIfaufaHz6uX5jnWKY45bAi10F56XU8KU=
X-Google-Smtp-Source: AGHT+IEJOeEtKpT8giAsQGkM9VfDOK2goDjgR9nWAd9qF+iBwbxHtXbzsfn5raJtcAv2looKI/KtpQ==
X-Received: by 2002:a19:5f4f:0:b0:513:26e7:1b13 with SMTP id a15-20020a195f4f000000b0051326e71b13mr374359lfj.14.1711059370203;
        Thu, 21 Mar 2024 15:16:10 -0700 (PDT)
Received: from ?IPV6:2a00:f41:1cd8:f7de:b242:8a9a:60a8:6758? ([2a00:f41:1cd8:f7de:b242:8a9a:60a8:6758])
        by smtp.gmail.com with ESMTPSA id cf36-20020a056512282400b0051596587421sm97211lfb.108.2024.03.21.15.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 15:16:09 -0700 (PDT)
Message-ID: <76cee9b9-36fe-44ee-ad05-bb90a79b809e@linaro.org>
Date: Thu, 21 Mar 2024 23:16:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINER: Split Qualcomm SoC and linux-arm-msm entries
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240319-maintainer-qcom-split-v1-1-735d975af2c2@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240319-maintainer-qcom-split-v1-1-735d975af2c2@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/20/24 01:01, Bjorn Andersson wrote:
> The Qualcomm Support entry in MAINTAINERS has served the purpose of both
> defining the scope of the Qualcomm support, and to make Qualcomm-related
> patches show up on the linux-arm-msm mailing list.
> 
> While this continues to serve our needs, it occasionally do create
> confusion about the ownership.
> 
> Split the entry to clarify which components are maintained under the
> qcom-soc tree.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

