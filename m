Return-Path: <linux-kernel+bounces-122645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F3688FADC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27AAF1C2D4BB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776085FB8C;
	Thu, 28 Mar 2024 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OH80L1Pm"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FB85FB90
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617264; cv=none; b=nOpEPpXk72TjSdMTp278t7uUd7w2ycstgRnx4oVhOAP6UEDHGKy1jNUhlhdY+Q79dC4gnnYD3q50bZ/vAvGYX2lTG8pnAl0ZzYipOsAXXJB9dbPQ7iMx3mXDX+kvGov2E7UBJ5JUhB6ORq6DTH6854KtG8EZKuznfvvezwALXGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617264; c=relaxed/simple;
	bh=lrFfsBE8SNHNpE0GWqb+vFLJEah/81JylKDe/YcmDyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kU9W7j1wHjlaGL47h1Wh4NfJ+LHt1SZ00tnlOS8HO5uUeTQVlOed3WfpO44IKAu9jKJiwnA041f+12JZMhD+kq22m8MtbEidFQ0j9FIRlxo9r16ry5iYVvmBek+SyUjdLOVsCQpbL8PcjTxwkE3c3pQWdX9IlUyOhNdhkgRKkQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OH80L1Pm; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so432340f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711617261; x=1712222061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn2TKuOzYzu1YNu0SEpdtuh1RniZXi87HtRvpP+WrdA=;
        b=OH80L1PmERmoLwxZ2JOM5vzi3zMxsWm3N2UHdiCXfOYqI+810sHG/JAcgWCjgz+8gv
         Ckp6N8ltvC5Wmv91t+A+YHFylNjX0CjB46eH13TeEVCKLde7SzC8fD64iTz8aGjG1ume
         CGcYdd4c9E6HyA19RK79Dm03cID0nOvXEqzIoVt1/ChMp6EwBuoflXzN5+NeQapteP3b
         ObHwjT9mVwKBN37QxHxlYE+bF4EcOYHBBVMVhSUr9k+Nra0a9AhArWkzTJqasFYgaWL9
         rtTIGcXt0+Bmn4c0mhzuH7LlLzzC9UfAs48jfHgPdHpephgZlJnjJO7Iye4PkLIYuCpM
         +rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711617261; x=1712222061;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn2TKuOzYzu1YNu0SEpdtuh1RniZXi87HtRvpP+WrdA=;
        b=KUrdazI38alIxUcn1jeUSyp7uyDjxyi4wbQ4NvwHx3E6G0xSxH+43xVbbqSkcOngeE
         HEtuq72gZ6C2egJeZ+qZivuFX42mzwvg2rSTLL1kG7dkWLjYj5xWDG9etwPxWeEPLlRD
         B8K9N1BJx8mF4tWl2mY/VZ11jrwHqlrJQd4Vc0PJO4s47hfKcZAFYHhdnvRe21HDty7W
         h6HzFxp/N6+/bHeRdAXrjcz3dMrolsBNqzxys6o8ROvsUDVi/5PElg/Le54t7JqixDoK
         T8jWfpQudSY1XctYFe4u9GaDSkftLHraUKarqZBms13kDRxQzLBmsOpMqXeQkts7HmDc
         qdyA==
X-Forwarded-Encrypted: i=1; AJvYcCVIBovDWFmFPABWeJFaV0HAZmavCkfKuInB2jpWBkubLOBcbPscp6QyJGEv6fibGf0VRFtokr12F1PTfXtZNK+EciZSJpEEsI7qwJCM
X-Gm-Message-State: AOJu0YxqUiw+SyFtRzvNYU5g7kBEIwvrZ7TLDlUkVu8p0mARhs8FAtpm
	j/RzqVHFdVASN7eM7e07CAUZdRGI/6CCA7l1XzUbtQ0GIqDtldQoJ0L7Qe+m3ho=
X-Google-Smtp-Source: AGHT+IGm9r4lCtfs1iCP9mMlNtyIqCOzVFD2wnYmgyoumpE5k7PEtlNd2UVIYM1FDvHe8dV3F3OBCw==
X-Received: by 2002:a5d:690c:0:b0:33d:d7be:3bec with SMTP id t12-20020a5d690c000000b0033dd7be3becmr1930909wru.58.1711617261329;
        Thu, 28 Mar 2024 02:14:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.148])
        by smtp.gmail.com with ESMTPSA id bq21-20020a5d5a15000000b00341cb22a8d4sm1212605wrb.108.2024.03.28.02.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 02:14:20 -0700 (PDT)
Message-ID: <539eaf79-cff5-4bb7-84c8-7c9943c6d8ae@linaro.org>
Date: Thu, 28 Mar 2024 10:14:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-1-711127a409ae@solid-run.com>
 <0f7ca0ed-a1c1-41d2-a1fa-27431d14c056@solid-run.com>
 <e1836cb6-64cd-4866-9c0a-f0dda096aa18@linaro.org>
 <6a6e7c4d-d5fd-42ae-bc3d-a3978d65e8e4@solid-run.com>
 <b086a02c-624f-4225-a9fb-164095742ce9@linaro.org>
 <6af08a38-5239-4f5f-9e87-108e3400a6e6@solid-run.com>
 <62242f04-c18d-4da0-bd40-1be26886e41a@linaro.org>
 <1153cdd4-ed86-4a1f-ae4d-d9da1161f763@solid-run.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1153cdd4-ed86-4a1f-ae4d-d9da1161f763@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 11:55, Josua Mayer wrote:

>>
>> I don't even understand what is your case.
> I see :(
> Yes there is a disconnect *somewhere*.
> 

Your way of quoting, including removing blank lines, weird wrapping,
does not make it easy to answer anything here. Use decent email client
which solves all these problems.

> I shall try again:
> Marvell is selling two chips:
> 1. CN9130, High-Performance Multi-Core CPU, System on Chip
> (can be used alone)

So this is the main SoC?

> 2. 88F8215, SouthBridge Communication Processor, System on Chip
> (only usable in combination with a CN9130)
> 
> Now, in terms of compatible string, what happens when a board
> has multiples of these?

Multiple of CN9130? 2x CN9130? Nothing happens, does not really matter.
Anyway the compatible is just to uniquely identify the device for users,
not represent some programming model, because there is no programming
model of a board.

> 
>> What is 9131 and 9132?
> I have no idea who came up with 9131 and 9132.
> But explanation is given by Grzegorz Jaszczyk <jaz@semihalf.com>
> when he submitted cn9131-db.dts (Marvell evaluation board):
> 
> Extend the support of the CN9130 by adding an external CP115.
> The last number indicates how many external CP115 are used.

You use the compatibles in your patchset, so you should know, not me. I
have zero knowledge, also actually almost zero interest, in learning
your particular platform. I tried to fixup some bindings and maintainers
for Marvell: failed with not really helpful comments. Therefore I don't
care anymore about Marvell.

You or your platform maintainers should know what is this about and come
with explanation to the community.

Best regards,
Krzysztof


