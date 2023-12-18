Return-Path: <linux-kernel+bounces-4441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D57A7817D24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2BA1F246C9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9810A74E19;
	Mon, 18 Dec 2023 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFtFzGXy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF974E01;
	Mon, 18 Dec 2023 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a233828ab91so261141366b.1;
        Mon, 18 Dec 2023 14:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702937635; x=1703542435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3pE3xgJ4Ga43NcB8fmFEHrOzN3+P+p5+/e02oaAboc=;
        b=kFtFzGXyoQ4TsMtg6C8YADqcsgZqNtRF9Lg989wl0El0rS7sDdjxz4eEUWVV5zT+HY
         uYXadvW90lcpLRVOvBu/N9Kam1+paqfv6DNRQ8zkfRRjmcfAD1yyitK3mZPR1TS5WdQ1
         DW3cWqQb6Mu2QUsZ7yR5CAF85px1l/7EI/5Jd8WzPkp682OBIEPL3ylVn0UZ5HS+SzTo
         CbWRvjQw5pfHuHrvcQQSk/NyDb9s1UCHi5/UuK/y9l1eioPoZvB23YeM6oPWPph0XAv+
         ttQcxXRCEAneovLjLpYkdVEx4XEHi6OGSbUnLve9w3wqiav6VJJ2RycHAWZDDwBtxWS4
         ODcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702937635; x=1703542435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3pE3xgJ4Ga43NcB8fmFEHrOzN3+P+p5+/e02oaAboc=;
        b=RRD0wTaoHkEO1UCmyMlhic9mGEyrGo1Gg9GsqSeDc1U4lWcWVoVVg5X59UKWa9raLV
         4l65gzWVjgtZR6tMms+0yjYSJ7AXCFtxAzID/M4iNMz80hsCIoOHOUZ9b28zZ12i9ao/
         T7unLdeDrMt6F8FVNcMkeS9ZgzhKbB5tM/gYmWG1oBhZfsSQFMiAziUfVcugF9rRLgVV
         NsJlPhBCHvbGPK89RPyvV7X5EzA418yOs18b+x3vCvapFBQyYLyzjFqVyORKDH18TaSs
         2F3ulSXfK1AGW1d73vVhUf8Waf9y08c8iSGHLM7Iy7DoOqzlj38itSEpDIh8/BR0TdYc
         qXJg==
X-Gm-Message-State: AOJu0YzblSLDWyS+8Icq+ACVy/0WhbkrQTkHBRTNVVHz+KzEt0J1S5ri
	zpUx48BdvBFYEJ4TyIylJfY=
X-Google-Smtp-Source: AGHT+IEzAgc0r4/Eycn/fmBbjmEeiAm2EBAahpSSLJ/wbqBmmehAvWVE9DTA5PhXrRJziFX5yn22qQ==
X-Received: by 2002:a17:906:1043:b0:a23:6d24:94cd with SMTP id j3-20020a170906104300b00a236d2494cdmr417718ejj.14.1702937634859;
        Mon, 18 Dec 2023 14:13:54 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id i14-20020a170906a28e00b00a2332116b3esm2965234ejz.152.2023.12.18.14.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 14:13:54 -0800 (PST)
Message-ID: <5cc586e2-c510-42c0-a451-73a8a129a30f@gmail.com>
Date: Mon, 18 Dec 2023 23:13:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: layouts: add U-Boot environment
 variables layout
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Michael Walle <michael@walle.cc>,
 linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, u-boot@lists.denx.de
References: <20231218133722.16150-1-zajec5@gmail.com>
 <170291091219.3792434.8389294947030479112.robh@kernel.org>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <170291091219.3792434.8389294947030479112.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.12.2023 15:48, Rob Herring wrote:
> 
> On Mon, 18 Dec 2023 14:37:19 +0100, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> U-Boot env data is a way of storing firmware variables. It's a format
>> that can be used of top of various storage devices. Its binding should
>> be an NVMEM layout instead of a standalone device.
>>
>> This patch adds layout binding which allows using it on top of MTD NVMEM
>> device as well as any other. At the same time it deprecates the old
>> combined binding.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   .../bindings/nvmem/layouts/u-boot,env.yaml    | 55 +++++++++++++++++++
>>   .../devicetree/bindings/nvmem/u-boot,env.yaml |  6 ++
>>   2 files changed, 61 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/u-boot,env.example.dtb: partition@40000: 'ethaddr', 'reg' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/u-boot,env.example.dtb: partition-u-boot-env: 'ethaddr' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env.yaml#

I checked my binding independently using using dt_binding_check and
missed that. I'm not aware of any way of limiting possibility of
applying binding to specific cases (like "nvmem-layout" node) so I
guess I'll just have to avoid duplicated "u-boot,env" compatible
string.


> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231218133722.16150-1-zajec5@gmail.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 


