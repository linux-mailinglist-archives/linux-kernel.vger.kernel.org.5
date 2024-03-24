Return-Path: <linux-kernel+bounces-112609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB42F887BE9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 08:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866B3281C80
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 07:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C7814AB7;
	Sun, 24 Mar 2024 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSPTS4RW"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD213ADC;
	Sun, 24 Mar 2024 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711265366; cv=none; b=hhSLbOe1cm6qpZKFG8PeqdgsdhhzcCuPxgG99ZI1gwO1uwmPPCzLF3e/TkGwMALHcfeJLbb/IOR7g/3ut9DT6sBKlAULRL+3khlsmBsxk0bAnpuP5uw+dirGLCZyArwdRIhrlBBypjKeicThfh7LH1uDoHjCKX+L/LgkFN9MgY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711265366; c=relaxed/simple;
	bh=SdkXQNKsE2/qhJMvNDtYBJB9f3aiNuFPtR7iqoYjiA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNl50Q8/KWRGUkLCqSJygqQ1zUUs0D7GrOw6IB63u6eE9vbc+Kdu5aGpg+225bzRHrB0F+hW6afYygP2VbrDZPwhbu1tXbF6TRB3Pys/SwaIY0Ftsz0TR4JpMhczrrEL9O1jqi8+2YP4UEp3Tm19mz2AgcXIMnNTZDEzWKua6wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSPTS4RW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a466e53f8c0so455277166b.1;
        Sun, 24 Mar 2024 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711265363; x=1711870163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D49Qn2msKItnUi33/LMsV1dIRFPRT/6vZPhs84DUoLA=;
        b=OSPTS4RWaLRQvqXPVLSUWWqO0bR7dh6CquEzX/VnL97nyRFOA4SqsjLqJ9yiM7PQKz
         ISXhlDPGg5It6oFlwpgfgmd5JGvqoyuMAlaz3aGui08LWdq2CcF2UL7vtxvgJjkWps31
         4WIc+AScg4C20pmdWiw16CKNk0MWfhuCtzaa+nnCaC6GG3/lynuAjV8ocKREbPHY6Ye/
         p3AjZAGPZrQPwPqS0i3sk1+DjzsNY+fsu+ETapxxxLujTkmgC15+06ICEIn41UBXVUly
         v4Uvf844Omln7Wqa33DapnoO93QYg6qvHQpKY4wqS6XjwSOrObnNBtB6wTx+wQjkCDAz
         lyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711265363; x=1711870163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D49Qn2msKItnUi33/LMsV1dIRFPRT/6vZPhs84DUoLA=;
        b=Wl1RFpW9Xb1JhUxYPuTojYDyFbpYr/ws4kzSVtkkYrYYGNR3ef0N+bLotDlAylypFq
         5AURVrhC693Qem1WcJqo0Wfy3h7JtEywrpwrYcqQXZx91NM45zPM0nY03o66XD6emR07
         Br4Cx8RESPaasOpYznyM9waom9aAUr07STHv7nrnvz4019FsokTd/TTmCIzL/Hg6BnKE
         RStkaf6BADUuj691F8rB9c6NuSLsmdcFchmkc9WJPAsUaEzDoKgZ976ZT6mKNYjMzv+e
         JgPJkgcpoUqHJYatAyCNhE8JBj3f53tK563yrISlmfMQhSXWQ+ectZQbluSfLTOoTCsn
         dSBg==
X-Forwarded-Encrypted: i=1; AJvYcCW+/4I+KO4UKW3CgqQ8ML/G0yIWA7RSSi8tfj/Wx514LVsXvjlj0eAxGTTYhmv8lOhreAlL8PA4GtDPxYL29yQprXDYjTi2z2MST0qFvYcA0LPStiaCWdbGmO5BLQSkonofISgAu0/3iv5Ikqz8SE9sX0hUhryNanphCXhFzSLivu4Gg/5B2Q==
X-Gm-Message-State: AOJu0YwL9VMhTWQWIke/l7bTxF4r8Kcq/P4LU74PG4mFKQdySs/MkWtg
	bbj27pZhzA7ECFMlvd2OG9TTIxOZJSygGzbyNw3J4JWJ8woxZSpJ
X-Google-Smtp-Source: AGHT+IGTZwQMZGXXJ2CLleWx7pI5ooh/+0Pzju6b3SRr3z/ugbsn01hY2jVNUgrmxSK3IS/yRzC2/Q==
X-Received: by 2002:a17:906:6a16:b0:a47:4c99:ee68 with SMTP id qw22-20020a1709066a1600b00a474c99ee68mr1304516ejc.23.1711265363097;
        Sun, 24 Mar 2024 00:29:23 -0700 (PDT)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id jo16-20020a170906f6d000b00a44e2f3024bsm1705373ejb.68.2024.03.24.00.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 00:29:22 -0700 (PDT)
Message-ID: <a34f1ab4-e505-4281-9a8f-b72c62beed5d@gmail.com>
Date: Sun, 24 Mar 2024 08:29:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] clk: qcom: apss-ipq-pll: remove 'pll_type' field
 from struct 'apss_pll_data'
Content-Language: hu
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com>
 <20240321-apss-ipq-pll-cleanup-v2-3-201f3cf79fd4@gmail.com>
 <CAA8EJprr4E1CM4f+eBzdRN41nm33xY-hRPQDn3peR94vLyJsYQ@mail.gmail.com>
 <ca4d85f1-397e-4c43-8548-436b9238e85e@gmail.com>
 <CAA8EJpp9jyCHgMSEBMumSz7xXUkMRm3wapjUdjzeOuJSpH5g5w@mail.gmail.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <CAA8EJpp9jyCHgMSEBMumSz7xXUkMRm3wapjUdjzeOuJSpH5g5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024. 03. 22. 23:33 keltezéssel, Dmitry Baryshkov írta:

..

>> Although my opinion that it is redundant still stand, but I'm not against
>> keeping the pll_type. However if we keep that, then at least we should use
>> private enums (IPQ_APSS_PLL_TYPE_* or similar) for that in order to make it more
>> obvious that it means a different thing than the CLK_ALPHA_PLL_TYPE_* values.
>>
>> This solution would be more acceptable?
> 
> This looks like a slight overkill, but yes, it is more acceptable. The
> logic should be type => functions, not the other way around.
> 
> 

If that is overkill, it does not worth the change. I will drop the patch and
send an updated series.

Regards,
Gabor

