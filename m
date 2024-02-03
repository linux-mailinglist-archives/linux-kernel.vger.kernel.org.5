Return-Path: <linux-kernel+bounces-50894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BC1847FF0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA011F24B11
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF3EF9CE;
	Sat,  3 Feb 2024 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEBqtfNb"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB027DF41;
	Sat,  3 Feb 2024 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706931531; cv=none; b=h2sxxO7PZm5gUYDme6IhSDhQ7qjRxHgWMIvYDz8F525/1QSg5RtX+C0d9figb66dbmDCgpPreFGlvwJrgTDUoWXo6rapVmeEAylvcxsenTtr3FdLlmHZGeSCWfxBiezy8rpt1egHeMQS5I7tEPOsYtKBF3MEdOK4MjyNPggGURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706931531; c=relaxed/simple;
	bh=nqwWgtE/fL2ujj4lvfVA6NZd4fGbX9uqHZHUZXbGDew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/rEJz2ZuA0pYiDb9Ql6uCNxWIHvBseoWyITKjkJHou0CVOjLDmixprc3P5Y5Zm7AemQKQbG98yTcZuxbeZc99f58z1MiNPoUROZBTqBS+qUjzc1d9cWClj/GrRVgLwiZG8FkDtfYC48eNJgg7aFMA07Jr+C5bDAhP2wLapruHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEBqtfNb; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a99cbb4bbso29927211cf.0;
        Fri, 02 Feb 2024 19:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706931529; x=1707536329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKsrvAsitikwOuhyQLAP2x4wUfjKHQsvIwe/3J/7rb4=;
        b=UEBqtfNbqI0X59H7HrnK9EzHa8SvxydZAIxQnRWOEmktra7ibTuYYlx2KaSv3wyNnN
         EQYRndZftVEOB7vBwB9WQLkGFZplSiZ4lZ7N1Y1m+ljxSa1rC3IMg/LfiQNV0pFFktY8
         tjQvIqzK0KG+vxgUAd2O+vjaaQiQlrqrNackqMPx8972mhNVRPXwGGFA/oROZrbwlHTm
         wjggQYDVNf7P7oA5mT92ZigQP8YWqSKIxaqIt3hjNH2MbhDdHcYj3XL5w+KsUCz5NmTI
         dIH6Ry7Ud2PGtVdK/V3cxk/lUvtudt6d/kgxxEzXK+HQgYgUAPowGKl9ooj+uHTHL2P/
         9TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706931529; x=1707536329;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKsrvAsitikwOuhyQLAP2x4wUfjKHQsvIwe/3J/7rb4=;
        b=Hv0zEsOAbO+poYFQG72vne17NUb4t4msBWvem8EosgM25L/Fwaq3JeKkaY7QTGDSw8
         TExHd/7nhgHwE2F9EblcCV4oXkpGnWgfRflWs/m0Bpt7wPgjNE1HLaqwV/NA9k+fBxOj
         wDd4q9IPXwGDiEvSIb0okQn5gb2KaXqbR/2U59mMpFwyAuoTyt3aM7THvqa7bl0dx4Ei
         4Qp6QbFJ3F/2eFENLvyq0POgXWrUka6f6X2yI+AssD6Ost0zw37T21SZGAMiEVjMgM/E
         TP03W4dSzjr1LfFQmo8xH5SxKkLztkXgaR2Brf9wyOZYEXKvZAhNFQyVadoAo/VrPDNB
         1pig==
X-Gm-Message-State: AOJu0Yx4+8bZhyjYN7TfI1OX1JfEV8xZWF2Vkfn6cFM1zdakcGskWrVg
	4zCujrqS+pGgx9iaO0tczHEI0fS1khMxs0uFWJ2KMikBWI1kYAFO
X-Google-Smtp-Source: AGHT+IGGM9dkY/+brysTYvKeQ2xlY6m32JxdG+ngvzBn6srE7ShrGEqwBA1vsZP/fK31POdr/3PwTA==
X-Received: by 2002:ac8:45cd:0:b0:42c:e85:f414 with SMTP id e13-20020ac845cd000000b0042c0e85f414mr191804qto.2.1706931528594;
        Fri, 02 Feb 2024 19:38:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWX/VstDSdFOUfKfJK+/tpIVO82m2Mzq1tL/rYVSfDM00zHwcIVMmJ9oVwzLVYR5v4RgbSIis+TNjDPPhwhctQgxJWBKduv8G4lTKhxXbbpyK9r0Y9xhDThX2BR7DJKf0+7wIBulxW15bal8o7JHN0btAapUAOZom7aCRT1/y8umv1XPLO5Cmm0EI2+mS8e9VQeF9W+cXwTgR4qPfnQYPweMFdTY5yO0D9k+xEVY5pEXNPRMAWI7wuduSLg9iW7PV89bVnwsCAHqlbieCnOVYZOOVXwXSFc
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id eo8-20020a05622a544800b0042ab4a129easm1445402qtb.73.2024.02.02.19.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 19:38:48 -0800 (PST)
Message-ID: <231a894b-c982-499c-9d9b-2f56ebe97240@gmail.com>
Date: Fri, 2 Feb 2024 19:38:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: sysfs: Fix /sys/class/net/<iface> path
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>
References: <20240131102150.728960-1-leitao@debian.org>
 <20240131102150.728960-2-leitao@debian.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240131102150.728960-2-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/31/2024 2:21 AM, Breno Leitao wrote:
> The documentation is pointing to the wrong path for the interface.
> Documentation is pointing to /sys/class/<iface>, instead of
> /sys/class/net/<iface>.
> 
> Fix it by adding the `net/` directory before the interface.
> 
> Fixes: 1a02ef76acfa ("net: sysfs: add documentation entries for /sys/class/<iface>/queues")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks Breno!
-- 
Florian

