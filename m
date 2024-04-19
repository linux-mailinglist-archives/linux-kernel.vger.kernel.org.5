Return-Path: <linux-kernel+bounces-151566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6247A8AB081
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8625B1C217F0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC0012DD93;
	Fri, 19 Apr 2024 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOOcmZfs"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E24B12D76F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536079; cv=none; b=WTSg1I550TaxZ08nlVEL8q7RaBkK0o02HHf1NEwimtDsya2cdOpaQP2nIZs09ooG8uoGCe1Xq2Tk4+RXhO0myLDAE/AArgxSOTO+8LPBm5HXbTtE+zL10dhbPCN9kmf4CHgwqOPOBnmW1C3CXy0k7cT+k14xSoAJ//esDcS43GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536079; c=relaxed/simple;
	bh=QqQnuHiz4fzgQdoqXqZMmFJdMdcqow82TtrUrElMWH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmM2xGc1cLuNffgY4FOqQxEieBe4w+D4fgQKHyVwmjaZuQJNoOCpm97JNe3906tq2wFQ3WqSFq4EEfl16qMI0IWku18KyJ6iM4b22rZDZs2h0SCS4I+cdY00lJz6ynoo5++PqVOrCG8dhofRrjfzaFJT5/StPMUV3l6EqDTN8dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QOOcmZfs; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a4df5d83c7so1459074a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713536077; x=1714140877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BkXVLdEYc8rPNPdXIYzU3bnFYoFdvBFsVpE81virAVI=;
        b=QOOcmZfsWQi7tDUEY9aFe6NUCbGchMxMISUgskk6q1F2h7NY+TS7ulNtoXsk1AvOgN
         98p0eB3TIzIFacpB3ztCufuAn37LzHlUzmDjbMKaiKhnptSoRpH74sIXEDJXEouqKU4e
         4RyUutg6qzd2QY2vGDCQ8BRr/tRFIVMAv3uPD9KLy/7YHf4pUrVzMTBXlqrU/ZkPYgpx
         sc5wB+kpxT6u7/G/4QzMloUfBhHUOcHLhKI8yCMZhrdSGMrsvA4UJfU/jmwUi/MCDgU+
         n8FLlV054eUsabBVkAFpijFZ9Nr7F9AWz0fNRL5NFi0BZqJVvYsRdCcoI+botX+h0meu
         CXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713536077; x=1714140877;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkXVLdEYc8rPNPdXIYzU3bnFYoFdvBFsVpE81virAVI=;
        b=NCs8BZK06SLt/MrRNpKXpTD6uxoGdIkpRAQbgSzYKW0nJ8u8bkVkOs2WRk+uNNfZnE
         Cf2kWdApw7HE9MwIlA3ebHf6Tb0sDLnfmyK1ORFVaXdnYy6L+Ql3mgft4oK/s40oAqVn
         P2w2HRQnxNnLhquJMTt7GRfoPfTEREBArMNsRgHupyAernKbfWNNtn9iByfvQREiCtGj
         SyjQI2FPRDPagdv6OlQVtdBaztSd5Hm7kzmyc/X7sOi+bfZleB31LnZU3HmLHz36ldok
         V1Pi6lpapiNUnoUqIE4do06p4lr3k7V3BPQTe1b+YOMRMFtUF1NwE41bBASXQJAnvnLp
         bnYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9NE//+q+T6KxV9BCKpZmQSVzX6vnxL+2eqKnKL9gtllnH+FedxWjJBR6kiOC4pw1XJ5hu4uWkllUC2yFYdaRQGAoHCiy2foS/V3lb
X-Gm-Message-State: AOJu0YzOFuSTPF75/XcZHagvOq1oifPfqWlL3zwFt1RYTRCx+je2/8Oj
	0KBiC5Calxt4FYJjF2utbpZPO3kD0oMdIb9KiVntqNtHHEptNZNQ3torBxTdoGk=
X-Google-Smtp-Source: AGHT+IFbcrTJ4yrR641yj38GdWPTqPDaHOz5jYGcxSb6T9o3hr5r+99EyH1jfx1YlpHuY41ICoMQ4Q==
X-Received: by 2002:a17:90a:e2d6:b0:2ab:c769:4e5f with SMTP id fr22-20020a17090ae2d600b002abc7694e5fmr2647044pjb.6.1713536077536;
        Fri, 19 Apr 2024 07:14:37 -0700 (PDT)
Received: from [172.20.9.36] ([209.37.221.130])
        by smtp.gmail.com with ESMTPSA id mm24-20020a17090b359800b002a25bf61931sm4913860pjb.29.2024.04.19.07.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 07:14:37 -0700 (PDT)
Message-ID: <e2de24bf-d154-4b11-b322-8bad7de8a0a6@linaro.org>
Date: Fri, 19 Apr 2024 16:14:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] virt: vmgenid: add support for devicetree bindings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, robh@kernel.org
Cc: tytso@mit.edu, krzk@kernel.org, "Landge, Sudan" <sudanl@amazon.co.uk>,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sudanl@amazon.com, graf@amazon.com,
 dwmw@amazon.co.uk, xmarcalx@amazon.co.uk
References: <20240418121249.42380-1-Jason@zx2c4.com>
 <20240418121249.42380-4-Jason@zx2c4.com>
 <e4cbb6ab-975a-4d91-9bde-6976b4d84eba@amazon.co.uk>
 <CAHmME9r8+ULD74ehz-LOpuAXb57BDFCD9Gr3Aw-JPJfTLC5OCw@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAHmME9r8+ULD74ehz-LOpuAXb57BDFCD9Gr3Aw-JPJfTLC5OCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/04/2024 16:02, Jason A. Donenfeld wrote:
> Hi Rob,
> 
> On Fri, Apr 19, 2024 at 3:30 PM Landge, Sudan <sudanl@amazon.co.uk> wrote:
>>>   config VMGENID
>>>          tristate "Virtual Machine Generation ID driver"
>>>          default y
>>> -       depends on ACPI
>>> +       depends on ACPI || OF
>>
>> Version 2 of the patches had these flag but were removed in version3
>> following the below review comment from Rob:
>> "One of those is pretty much always enabled, so it can probably be dropped."
>> reference :
>> https://lore.kernel.org/lkml/CAL_JsqJoB5CYajWuntMdQrJZir+ZA-69Q0cwvxcVZAqs-mXC+Q@mail.gmail.com/
> 
> Are you sure about that? I see other drivers that depend on `ACPI ||
> OF`, and this driver is totally useless without either disabled
> (right?), so the dependency makes sense. I think? Not an expert in
> this area, so I'm happy to defer to what you know is best, but I did
> want to lightly pushback a bit.
> 

There are just 18 cases, so I would argue that it's not a real pattern
but could be just growing organically, without really thinking.

The driver could still be probed on some !ACPI and !OF system via driver
name matching.

Keeping it as is seems harmless, but OTOH, if this stays, you miss ||
COMPILE_TEST

Best regards,
Krzysztof


