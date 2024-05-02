Return-Path: <linux-kernel+bounces-166865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A748BA112
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02497283A8E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B669017F37D;
	Thu,  2 May 2024 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGYiwi4L"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF7B171066;
	Thu,  2 May 2024 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714678036; cv=none; b=pZxoRudUuYD+ONAj2GBQB6F+GRHuX1yxrIh6K3X3jCZmUolKFgoyEm4u07D1jrRWQRKDdo5LOf8f2L+KBpH1mC9mIV3kdUW6CWPuBG4v35p3hV8lCSsZOgba51G7tA422cjYa5NHskiJzqRxPozx5Ll/CdzOx61tHHOvnPOiysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714678036; c=relaxed/simple;
	bh=QbczoPrifkh7vgCscDvY8svclrvHS6duuU5pa69+I/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GK9hr47caS9gv29i6Wah4rARRKBngxcJuNffxt399nn5V6/04Im/kpvBn9cERObKQJHtCMugITrB9i50Y+npyN9W/W5+y2sd4nkUzc2BxNX2irQCvIKSuR892+KVXF1OHGN2jP+XL1dz4u8F9mIkEu/wfBqz4qalOhMl0f2PBec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGYiwi4L; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f036e9f4dso1581634e87.3;
        Thu, 02 May 2024 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714678032; x=1715282832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtKJAto7Q3Nrk05RW97KRPIs8n7BxL20FUpybZ4BUYg=;
        b=SGYiwi4LtGw4Epev6rVv/7uTzYlIAha4m5W76q6ZKI/mOD6lTDxtFO64eNjLVxK3RC
         mDzWbcCkdyUnOqFmM/LwIihDmt7DiIFt6A+tGNpl0A+TlC6uFOCwYo0PtLVwUIRlGimV
         VPbx08BALBBbgGso6vIDBuYiJ1Oyt80sxVxsHq6jj/spm+w+mlAF2UEdDey5tYVPnbz8
         kNZzhZJMTlxb2usZ+S4DxLhsoBivA2swKAYuawZhZE5xmiFL5/n426kjN7woUiv8Q/yC
         1t9Mb1wmW4bvjEt3POzYB+9XeFoOJioW3KYiAC+UzeWC/L4mcaRnmCRhEI5cN+O4dPKs
         JuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714678032; x=1715282832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtKJAto7Q3Nrk05RW97KRPIs8n7BxL20FUpybZ4BUYg=;
        b=VfpoNzC0RMPn25CqpUx6ZeknVEs8NTdhIrZwXjr85b86q3sKX63O9Tt9jrtHLRaP7M
         47nav5mbw/ISL+xZCXkceazgYvkkCPQZNYvxuy/kHGHMNfxFNgQNoq025G7acFw772NQ
         onVZhAvRis/rCsqw0BFXZtxn1AP+FR7cudXEc0JMka9Ph0mGWtt0N8D+Iu2Jq+JzC92P
         iDwWHLDXZhvcSrO2tVbgVT6v9eSM9sgdbykJpUVd7un/ibViTw2DRWj+AcV1E9pQvM/0
         C4kQsZGxNoeSUURN+zU0j+Xf9qRod8fJ0peC9zHpCBxQjT5WxKh3A794Uu/XEUdtVzyc
         QOWw==
X-Forwarded-Encrypted: i=1; AJvYcCU+jo3LUXUlpq9qOnesOdRsRV4QPO9hoYwV7+sK1jwylv+1OxKp+AsxQ4QHig8b7fUi271NAoQwqS1/PJKHr6EzDim2+qR8LDTp10oZAI+SsrkU5gbY2z7jzX6+psm6FwvY+sbByjhMOh12Ru8=
X-Gm-Message-State: AOJu0YwM25HO38PgT56d/WJPYIkdscznadgnH4AVB01H9o8GdVZxnK8v
	3itxk6JCmpUkpLhWbL9nE+b8ZyEZ/GoyEZIlEF81GetVFKSoWsA9lczEmw==
X-Google-Smtp-Source: AGHT+IFFNDxSJm2KpR0fG5ZXjxpbPk+Pv4p9QZiBiaQUu/wqpNaZUPQ+qYlm5jagNz+nyDjmWHB11A==
X-Received: by 2002:ac2:428a:0:b0:518:dfed:f021 with SMTP id m10-20020ac2428a000000b00518dfedf021mr494477lfh.24.1714678032304;
        Thu, 02 May 2024 12:27:12 -0700 (PDT)
Received: from [192.168.1.105] ([188.113.43.9])
        by smtp.gmail.com with ESMTPSA id s12-20020a19ad4c000000b0051c5570f573sm277186lfd.23.2024.05.02.12.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 12:27:11 -0700 (PDT)
Message-ID: <b3999eec-e370-4c85-80b9-759f25ed98bf@gmail.com>
Date: Thu, 2 May 2024 22:27:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix remapped ce accessing issue on 64bit OS
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Ziyang Huang <hzyitc@outlook.com>, kvalo@kernel.org
Cc: jjohnson@kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <TYZPR01MB55563B3A689D54D18179E5B4C9192@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <6336ffc7-d8ae-4cfd-8b66-d6d91cb0d15e@quicinc.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <6336ffc7-d8ae-4cfd-8b66-d6d91cb0d15e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

On 01.05.2024 19:56, Jeff Johnson wrote:
> On 5/1/2024 9:14 AM, Ziyang Huang wrote:
>> On 64bit OS, when ab->mem_ce is lower than or 4G far away from ab->mem,
>> u32 is not enough to store the offsets, which makes ath11k_ahb_read32()
>> and ath11k_ahb_write32() access incorrect address and causes Data Abort
>> Exception.
> 
> Are you actually observing this issue?
> Or is this a hypothetical situation?

Yep. This is the real issue. I faced it on IPQ5018 with 64bits kernel.

>> Let's use the high bits of offsets to decide where to access, which is
>> similar as ath11k_pci_get_window_start() done. In the future, we can merge
>> these functions for unified regs accessing.
> 
> Performing unnecessary tests and masking for every ioread/write operation will
> potentially impact performance.
> 
> What other fixes were considered (i.e. did you consider making all the
> register addresses u64?)

Probably, making argument u64 could also be too much. I/O address space 
of this chip fits 4GB so u32 should be enough. I have a bit different 
fix for this bug. It introduces an indirect call for the CE registers 
access and a dedicated set of accessing functions for chips that has the 
CE region outside the main I/O area. I am going to publish it in a 
couple of weeks, when I will come from a trip. The patch still needs 
some polishing.

--
Sergey

