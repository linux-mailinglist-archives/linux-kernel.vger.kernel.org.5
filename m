Return-Path: <linux-kernel+bounces-31442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC723832E66
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8BC289CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F41855E76;
	Fri, 19 Jan 2024 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk6c3C3n"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088BF1E87C;
	Fri, 19 Jan 2024 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686859; cv=none; b=g8WbwaP0O1EmYA+5/+dA7DJV8NI3TXbive00l/VtXqC2vKMIIofvi8owoExkEhwPVbTRABnqCSA1vDvsxhRuMybLfBtTa8ubrO0w0me0OUJ99j2oqzpacTX0yAsyQjPYTdPFt3UDMRiT8+wa+9KKuFu+uQDPu6D4Hz9wtH9aaEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686859; c=relaxed/simple;
	bh=E98o89P8+R8YAOCQwVZNOu3BKNa62BrRxKH6/6qwefY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LKIc2e+/DQ5k4s+YW3tbHALV2d1edLXbBWLXXudTrk/c0VjhlxOsf/qk/Q/CW0g7UYFs/sjvI4K5WxLtQUKWJe8P1zm0x/1gjP7uP7kMjyS5SC8a3/Kpv+SZF9yShPK4oNwW6JVjwajZLy0AdILRkfsgDukqgA3AuEpKN5tZpwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk6c3C3n; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cec32dedf3so753409a12.0;
        Fri, 19 Jan 2024 09:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705686857; x=1706291657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FKtHrE1aXZwBWr0DhHzM7pDrpBjBv62gCYMzeiuv8I=;
        b=Lk6c3C3nMxaNidTHOP3amABgUxCQolWDf5WY2PYH/gRhXPwRW11WFU6DdHXOIf/2QQ
         +dpi7BGKTXfenPcLN1BDeZCtm2CDugiJccyHfiUahf10zzieGVJc49BA3CmTyIMMPc4W
         RPJs5qNEFT4K0ydw0UWQnkX7SIKA+XtZJIaZpWCp/jKP/sHrlellSSlumNIwpeTkGRk8
         jJIlfsnMuYgwIH++DXDisVZX5K/QoZqsQ+ZNe//bH69gtzZ4FI5blIhGNPV0zXKlkCnS
         UOp35Sk1qV8DyOgz5IIhuYQ6IfuCSY0bb5PEX3mfzu/ItDL2g50ZStCWI5leOsulG39I
         o+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705686857; x=1706291657;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FKtHrE1aXZwBWr0DhHzM7pDrpBjBv62gCYMzeiuv8I=;
        b=ksHpnWEVZbRgWb7Ok99tuU2Kafk1JomktB/vju49kXcpLt7DA+NsnRD8LmOvkIggjj
         Pbbb/M3Qi7TG7p3qjRM8NfkhxkIdyw+PQqukCL+UhKugrcGKNVm5C+vLBb7Zu5bXkqFJ
         Df6HYPltrkQ57RhzMiSKDH+CpVPAdai+vDBAjDdpkLZuJatiJ5THOFnh6P1W3V8SQzFu
         Tj14JoKUfychnk7+E4+MkBUYdnATR5XllXkFPo77NHoMej5blFiM2WL/RMMk/QUJEyrk
         CZjwAAPlZkZjkXczIUhoZ3eqHY2VdEr6utuYRv1l4x9c1kbj1LRX9YxgrFkYCFYmt9c9
         W7LQ==
X-Gm-Message-State: AOJu0YxBnN1/yL61LPCdLCwT0Cij185cTSRPpAYvcwz2cTe2WkwE4guW
	PR3ISzVt+1rj/WQDof7Jysfz6yAIVOzefe3A05AoEsGFc9mEGgfK+dPi7Ki5
X-Google-Smtp-Source: AGHT+IEt4VmqIUe/VhRjbnK3usqLmrNWQ2R6dIVG6HfwlqryiDMyULoar3g15PVmOTWKMLHhe0EJmw==
X-Received: by 2002:a17:90a:1344:b0:28e:6f44:46d5 with SMTP id y4-20020a17090a134400b0028e6f4446d5mr135498pjf.52.1705686857245;
        Fri, 19 Jan 2024 09:54:17 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id nb17-20020a17090b35d100b00290394b25d5sm2953663pjb.22.2024.01.19.09.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 09:54:15 -0800 (PST)
Message-ID: <ea0e69ab-744b-4e75-8a17-6c0b59b16db3@gmail.com>
Date: Fri, 19 Jan 2024 09:54:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MIPS: sgi-ip27: Fix missing prototypes
Content-Language: en-US
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240119133216.83220-1-tsbogend@alpha.franken.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240119133216.83220-1-tsbogend@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/24 05:32, Thomas Bogendoerfer wrote:
> Fix missing prototypes by making not shared functions static and
> adding others to ip27-common.h. Also drop ip27-hubio.c as it's
> not used for a long time.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian


