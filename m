Return-Path: <linux-kernel+bounces-88712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4F786E5BC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9998B2823A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E71C16FF40;
	Fri,  1 Mar 2024 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eLfuyKAU"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570981FDB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311037; cv=none; b=CRhl7reW7PnpoPwDwgieNjHgWSf8GdGB0mCpK785TEWUIgzJCo8IowXrMXqDzCxVqaJu4bnEy/QTYWeWFG0we49VxseczElV08MPy0PYTE6NDmzeRq7UYbKwoMjM54ghNK+CZTOv5G197hsqeLh5uhoFKvIiH5mzVp3/zyCt+8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311037; c=relaxed/simple;
	bh=W8ekqyFDNdERMviLQlmLPvASDFIuRXeZIKAz6X0wpqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpCGDlITlYP7pKWc3PfCbioBjsXB+Dgm6G2Z1WDoTeY8CXMhYqZK4FGZ+kCh30zdkOsj7CiuOmNUjhYDyKMs/jYUVHbMobfXBSwldgWvg3PVndoqtzz4bRaUDk9gsJzpP71ekMXhR8L8B1u8F6c9O+GHRnhI3g8KFJyx6vQQUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eLfuyKAU; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c19b79535aso1399068b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 08:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709311035; x=1709915835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0S1pjMIEbQhahvKt9V4WgWqNibwCApPjl+YvM8irZw=;
        b=eLfuyKAUbffS/v/1thMq1zcsFshSGOAusKjCOTeSBvM+LNqqRpeC12IF7Z3bpJ5lge
         7I4OMes0RnWOBSRuVMJYfGn+5vFd5SVpnF25hXTEOk2jc+UOLZYBgUnDFTk3GxTGuTvO
         yuipT3DZVvOKftLZe0myhbCwyVPzXAj8hcB16QYTPpNkSgT59xRwBGDvs+tq6zIpBfLR
         LCvlqNnMoSyaIDOIE6HA8/XTkPvLw07NVCjyotq2D8gQKo9x5i9oqijSWg7Uw0GJXvzp
         lbjU2JBjClRe5U1815i+Jk+xEF3DZo4VHrD7J5po1kF3ENLhbMn8JYJ9SE1BMQolhmNp
         6cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709311035; x=1709915835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0S1pjMIEbQhahvKt9V4WgWqNibwCApPjl+YvM8irZw=;
        b=uScodQlz318MliQsZQYohlhYU0FzqmcgyhHR5Mas9PNuXF2auD4pgsGSAmEILD7kSB
         8pSjU+HLfyyJoP0Uz2UQFBZy8pSWkD2q2K/DZRrOBC1gPzwyE/BMmbjA5rNjbdsynvvX
         ximVxGMFiPE2N6w40ja4PlkqY31Xuq5Q8aXfnna8/PtIXU8rb/6Xn/CtpzKrsMEp3wJe
         VkQTGQneNM0dyY4xjyGYwB/WEgqUjYpW6JwU8VOPNiUTrZ3Nnc7JzHQbxgynb8IZ5ate
         me0OSLEBq2ouO428+McPCLtQiVYAS2v1lk1U298d19WA3tgNyAa2wIOeVw4dUAKK7fOL
         jm+A==
X-Forwarded-Encrypted: i=1; AJvYcCXY2cv2y7Vzkm5Sbxo/BV+Fj7dBrXVLmdLGddVJ1yUwKqj94vqXE8iI2+c2QSgzCl5/a9Z6X6IS/KcgPlamxSaZ9f0RyUsJJi4QLpie
X-Gm-Message-State: AOJu0Yy+kLPS//cnqtiWfb/eeyHht1j+nHkMybeVjdDnJAy5tYLgjZh3
	ZCNav0o4eTk9Xqhp5i15VTDycwGLRTE4pUTw9HrrEh8/6Di2nbGiHclfs6x+/xg=
X-Google-Smtp-Source: AGHT+IFj0GoRPprx2GuYPkyopZPppe0fMe+bFr3Nqv8uhWiYNQXQ99+Hhzb/IA0zdNSDj3aIomVZgA==
X-Received: by 2002:a05:6808:13d3:b0:3c1:7c55:373f with SMTP id d19-20020a05680813d300b003c17c55373fmr2061160oiw.6.1709311035461;
        Fri, 01 Mar 2024 08:37:15 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id bq16-20020a05622a1c1000b0042e8f150417sm1857674qtb.45.2024.03.01.08.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 08:37:15 -0800 (PST)
Message-ID: <30604225-dec5-4ba7-9e7d-4c845c8ee9d6@linaro.org>
Date: Fri, 1 Mar 2024 10:37:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/7] net: ipa: change ipa_interrupt_config()
 prototype
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mka@chromium.org, andersson@kernel.org,
 quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
 quic_jponduru@quicinc.com, quic_subashab@quicinc.com, elder@kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229205554.86762-1-elder@linaro.org>
 <20240229205554.86762-2-elder@linaro.org>
 <20240301162628.GF403078@kernel.org>
From: Alex Elder <elder@linaro.org>
In-Reply-To: <20240301162628.GF403078@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 10:26 AM, Simon Horman wrote:
> There are two cases where this function still returns a pointer.

Yeah I saw that.  I'm in the middle of testing v2 right now.

I'm very sorry about that.  My process includes testing
every patch but somehow I missed these errors on patches 1
and 2 this time.  (The netdev CI doesn't report all the
problems with patch 2; I'm not sure why.)

Anyway, a new version is coming.  Thanks for the note.

					-Alex

