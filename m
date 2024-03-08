Return-Path: <linux-kernel+bounces-97324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BBF8768C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04723B21DE0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A12412B8B;
	Fri,  8 Mar 2024 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZbD6e0X"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837881CD2A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916488; cv=none; b=FAq3cvDqIK7NlD3i+CfmwAX0b740YyCDi1jIR5KszRzd707EWhP8g+RTKqZXjAExGeEFY3skzG1f60W8j8m7BKfdUbkupO3TZrWA7H2Pya6jAfUMqoNcG6KGIHDUY4GeL791igA0jhFclHbZ1IQlwXO4JjOq0bcLLaTXRWbfqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916488; c=relaxed/simple;
	bh=Y3+J+DGthX9LLnIZodenrbd6SIsoFqZdJRXiEVqxb64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3ULbpqh3Si6jMDmXqo/Sya2iwBRh/KaDVq28kg5XV7djzaU84H24yXMEaNVoBwAYm8Er3hBRZhwmeRs3dtoGoDYX4iJKH5yl9y1uUYByEUm3dmd4bDycD8rDSGT+/pi260PjT4WdPZ+xx511zfGZQlwk5I4uXWrJ4YBjuLCFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MZbD6e0X; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d4141c4438so26915331fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 08:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709916484; x=1710521284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=av2fWGGqod21kKXmBF9bISMvMli5hmBzFo0FJK4YLYM=;
        b=MZbD6e0X4kNlG0tHobiwM2fXqdq/Y/fESmtA0NpLnnz/UtHsaAfy0G2iUMUAhDluAk
         RecP4Sfz3NpGETMALz2z0rifyPKc0bdx9KL6fqQmxEepaC8wAgFccSBIaHc02IUUjyxn
         JTIBzOP04crvyCVcnclIGFiCMKxJcTRVY0/ko59nKh1b3GL6xfqJNK1gntYbSAfgKA6n
         U1n7+NlWxOEgI59GSiHt7pHP0zukT5nHqwIxWBFNxoxqx/Nhu0e6a0rexlhcuDaiJDX8
         mQNUdGs/WclQkcI0p9fpaF66aR+A3sNiJ+dqvCo/zH9ej63VJclnUfhpCL/cQjAW9nNE
         XNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709916484; x=1710521284;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=av2fWGGqod21kKXmBF9bISMvMli5hmBzFo0FJK4YLYM=;
        b=S7I7LGmzMLM34rS4C9Ym9KKQSjXB0bBMrvLcVtIuVTkwl5TioFZ08Crf+6Z/ASmi+w
         tdorTcJdmJtQ3aGzvHU2kTETlagAJkyefE9nYckgD0Ko2b3W5Vim0/HoI7ly1NOTHAUG
         dvfbrcxEZhtJB/hGsg1xsTSAefYlUHL+EsPChJSYWQdYYTAV4AjXeGkdm9SlRzU3Nkll
         NNWuJAMuvwZ9SKg5I1Fp/XKfeF0IOWyCl+QBgMso3TaNgZ2i638P43XWQD5GVb4HNV0c
         4YdFSYFh829KEZmcSxXP6i4fmOoVw8f7zyKs+Pp1/ftMgIhTDqxdkOOzoACOXUs2iz7o
         oEcA==
X-Forwarded-Encrypted: i=1; AJvYcCUh6ZRYZ/hicm3IpxLifczeLlxr+9GR3XaT8Zue3Uw40taYBVjwQ4l5KDepPmqbk4niNZBdnZXAfOvlU1UnS+UgkyJoziNB0uTyb0U8
X-Gm-Message-State: AOJu0YxiE0P2Y5lBebkjQ3Y4w2gvpoLx2OjUeaOfeqb4tfFQQXO9+vKN
	jrEX2wbeBOYgba1qOmJ9jqB+xaKjz1wBGWGzNBGpW+dMmNEYglA945uKPbAiLg0=
X-Google-Smtp-Source: AGHT+IFe8Srdtyu3rPnldUQz0JOkKdxVj/KoBjSLaX2+JKOghRs5toQOXAnTUD4RkmIe7t1r66pGjA==
X-Received: by 2002:a05:651c:1049:b0:2d3:24cb:f273 with SMTP id x9-20020a05651c104900b002d324cbf273mr3898204ljm.36.1709916484586;
        Fri, 08 Mar 2024 08:48:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id wr8-20020a170907700800b00a4553c6d52csm5611824ejb.35.2024.03.08.08.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 08:48:03 -0800 (PST)
Message-ID: <bbc16b3c-7e76-4f0a-8ada-42d2da3426fd@linaro.org>
Date: Fri, 8 Mar 2024 17:48:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: omap-gpmc: fixup wrongly hierarchy of the
 sub-devices
Content-Language: en-US
To: Brock Zheng <yzheng@techyauld.com>, Roger Quadros <rogerq@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6fftq2zlkpaf7xptyff6ky63cinr76ziyvdbm5jhj2apubr5vf@l4gvbdax3l2e>
 <f45b3195-38a9-4c49-b873-01e5a0b275a3@kernel.org>
 <20240301133809.0d26865e@aktux>
 <f59c9450-2784-46fa-afc9-4f194055cb24@kernel.org>
 <laqqencookmgwesfaetd5xw5wfmjdffmjvyjitapfehmu7zy5y@k7gsdexf3jcv>
 <beacb55c-951b-4177-83ab-94fda44cd2b7@kernel.org>
 <yxefg4ie4vxblxvr272jvzncxvj2t6xjfuisvmkt2jk663xgsu@o2ogbyepmg3z>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <yxefg4ie4vxblxvr272jvzncxvj2t6xjfuisvmkt2jk663xgsu@o2ogbyepmg3z>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/03/2024 09:18, Brock Zheng wrote:
> On TI-AM335x，FPGA under GPMC local-bus can not work on 6.x kernel.
> 
> GPMC <--> FPGA  <--> sub-devices....
> 
> I found that the platform sub-devices are in wrongly organized
> hierarchy.  The grandchildren are now under the GPMC device directly,
> not under it's father(FPGA).
> 
> Signed-off-by: Brock.Zheng <yzheng@techyauld.com>

Your SoB still has '.' between names. I can remove it while applying.
It is too late in the cycle for me to pick it up. I will take it after
the merge window.


Best regards,
Krzysztof


