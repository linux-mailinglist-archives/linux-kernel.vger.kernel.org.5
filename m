Return-Path: <linux-kernel+bounces-54421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFDC84AF0A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8A51C22465
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB7A12883C;
	Tue,  6 Feb 2024 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fyuoquNF"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E254128818
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707204830; cv=none; b=EcRguvRzsIkw7PaEpqtZw+zI1Kz/dnJgvDadfNbDBeAD6/uj3psVDzXFFPx/3rDwlpwpjAzh6fVtxGsBX143O7p3W8Qzu7AMqSQT0qDLwtSoufBXtBrivTHhpKzazpF13Dr78qlcIGL1dVS6Ym01ly8qjIdx/5PCt50pTsy63Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707204830; c=relaxed/simple;
	bh=CNpEweTFv5oCaBP1luQEX8qTi0+T9RtH73gxUzyo/DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHGrT2sK3OoIAtTu9Gn0vXNH44WPr2BnQ/Ju/+jZqokZ6gvshmIxUUcdYQoRMKBt47CyTDYwlLrL66wSwG9SlLycZOjlspPj/UGwRfPgY6AXzDelZJ0NTLYjatGeFRkRYnNMuOkZecmTJ5vzXnDFd/xw8AyrXho8PXamtCvUJj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fyuoquNF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51109060d6aso7544313e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 23:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707204827; x=1707809627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=epm7YcjPaDPPivdSKs9f+kqj2TGWyrJAF+NqwefGpDg=;
        b=fyuoquNFHmd4/xlxBO0q/CsHdfclSVQQOMpsVkz6S0WYjt+iR4t+eZ3X42uAKtm8P4
         OicTMTfk/PQobkt2p718AnmL75ZxrJHiLrMfnOIEndJg6w6Po/f+aynvfK8XIx5/XoW3
         4JkKfkAgcvFO/BChmK35DJ8OdjrJ+uZCeU4lexOWSXOWuyYTHB0eKOuE+T2SNIMXHYcZ
         tGgr0ArDyDLpo+azgR7Ko483NCL9GOlwVjkS2vF5PN1oi8iU91vEp1h7LRU5qb+HFkqB
         6GR0OA8PtrD1uqLMe+DaSqdFyypn1tRa3u2xtOqs3XiV1ITJvvpS2GQ7RvDwZMLvsKf8
         WxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707204827; x=1707809627;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epm7YcjPaDPPivdSKs9f+kqj2TGWyrJAF+NqwefGpDg=;
        b=esIi0RhpzY2otoQ5Zz7SNvglGAy/9wem2T05h/dx5EM3RktO6XgGGw3mjw+5IRPGE/
         JHdmnsaF/VtfjKCf5AKE3DG6N3YwJg5nR+ZAKgpXgeyjLnyHwVIsGYPcF96R863i9FU4
         dyrTtngZ3VfSwTR1ZQsPNspRCOOu0MpIjx0RJAqk4OJmf3l38pcHk2KNPAiWTB0ZfJ2o
         DATymHQI2/7OhTHPNhlJ5JXdByIT+Fuw8eOtZ172/9m+L7NuKkw0eulwCVP3DoDltOCT
         sn5PYGeSUcny0N+8SuSMY69ILTDmZDREKIscpprDumnprD4Fn6arJfVFMvCLQAcUa29O
         k9uA==
X-Gm-Message-State: AOJu0Yw4Pb6N9DFE1ivltFs7sPrBfydwQIl0eSIacPkGXGUj4fvKArFU
	PEzoxpadoiG7o0heahDpJcEx2hrB1h07W2wKomPhogG3+GtaYq0fF8v80j00V+Q=
X-Google-Smtp-Source: AGHT+IF8wLS2DKRYZAjdNAxararBHRigMxvVvwyxWeqjbMxCAwTnW5t3EJJEj/tZBJtZBqCVC1uwoQ==
X-Received: by 2002:a05:6512:288:b0:511:4c52:ff53 with SMTP id j8-20020a056512028800b005114c52ff53mr937074lfp.53.1707204826618;
        Mon, 05 Feb 2024 23:33:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1hD4Ys0qLW4LI9vPGfiKkkPFfmdd1Gs9gfaGcuiyl/jJ4iXLYtJ5LRKu4m3P1autVp5OhDPwen669TiFyDcKwGwx6u+e9Hw4xUFhmK6ESuL4CQMFRO+/87utpKwP2zaH1Rwavq4XFYZiA+xcGZfkpP8cMQqD3FWMA0i2mBtLpMkM2jd2SUko9wzM8JL7EenjjEj6gA/4/gMZxHFrc/FT35gvlpny6Hp4VFEg5S3lvuVEsqMYJUoi5/busUpo0/cHkjNVv/7tLvO+1++HTI7lWiQJomeQM6/SYIgprWiA3Il9bF5lHcUFovAagxIG+qu8jDCuql3hQ+VBv9JIiElC6YyTF2kcCaSgbGXmSD91tqRe9G6u2rVrh7N9rcC5toXIhjU90vPQjnXHAaeG7wEkI0PKbLmfSMOi9AOIi5R1rvPBcislqqB/WGTxuRSf2nib9bX8BKhiSwzeoW6sIh0IIVwkgT/b/kqxDR6Z0CekVnr36lKBpxTVUJAilP9/cvWdagNEVdVfD40kEYLJMLmGptCj/hbRis84wQ/erwrmEBkMUe3da21+TVfcQLRH+KC1rOo4FvpIxXIOgeXlDhbBM9A8cH9NzJdK4St/9VLRTcqVienEN0YZlAGIzcXr084v2NnrnDp1iCeCw9oDGkk3CvFRHUoTKctJIhfpIxAFH0NgjPCY7UD6USbEK5VzoBoYIAlL+WB+lAW0DCuxOSjUlB4O3xVZW8MO0PLoff+7efpKW1saMAkV9XZWLLhIgvA92+F64+V9vTFHiWraBVXxo9eo3arnjmbpwcw3rL5mSkjPKYcijSjJOBlvefPVcfQ96JbWH2qDxOyiZlg==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id fc16-20020a05600c525000b0040feb8c71a0sm191266wmb.13.2024.02.05.23.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 23:33:46 -0800 (PST)
Message-ID: <027fddd4-d572-4f9f-bf7a-1980c73017fa@linaro.org>
Date: Tue, 6 Feb 2024 08:33:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] hwmon: Add driver for Astera Labs PT5161L retimer
To: Guenter Roeck <linux@roeck-us.net>
Cc: Cosmo Chou <chou.cosmo@gmail.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jdelvare@suse.com,
 corbet@lwn.net, broonie@kernel.org, naresh.solanki@9elements.com,
 vincent@vtremblay.dev, patrick.rudolph@9elements.com,
 luca.ceresoli@bootlin.com, bhelgaas@google.com, festevam@denx.de,
 alexander.stein@ew.tq-group.com, heiko@sntech.de, jernej.skrabec@gmail.com,
 macromorgan@hotmail.com, forbidden405@foxmail.com, sre@kernel.org,
 linus.walleij@linaro.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, cosmo.chou@quantatw.com
References: <20240205152013.3833940-1-chou.cosmo@gmail.com>
 <20240205152013.3833940-2-chou.cosmo@gmail.com>
 <99a1a309-41d6-448f-b622-b62dbabb2c52@linaro.org>
 <b932533c-d1fe-46bb-8187-b0560861e982@roeck-us.net>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <b932533c-d1fe-46bb-8187-b0560861e982@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2024 17:15, Guenter Roeck wrote:
> On Mon, Feb 05, 2024 at 04:26:08PM +0100, Krzysztof Kozlowski wrote:
>> On 05/02/2024 16:20, Cosmo Chou wrote:
>>> This driver implements support for temperature monitoring of Astera Labs
>>> PT5161L series PCIe retimer chips.
>>>
>>> This driver implementation originates from the CSDK available at
>>> Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
>>> The communication protocol utilized is based on the I2C/SMBus standard.
>>>
>>> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
>>> ---
> [ ... ]
> 
>>> +
>>> +static int __init pt5161l_init(void)
>>> +{
>>> +	pt5161l_debugfs_dir = debugfs_create_dir("pt5161l", NULL);
>>
>> Drivers don't need initcalls. For sure any debugfs should not be handled
>> here but in probe.
>>
> 
> Lots of hwmon drivers have init functions, for basic chip detection of
> Super-I/O chips (example: drivers/hwmon/nct6775-platform.c) and to create
> a parent debugfs subdirectory for the driver. The probe function then adds
> subdirecties per chip instantiation. Example for pmbus, in
> drivers/hwmon/pmbus/pmbus_core.c:

Core bus components are a bit different...

> 
> static int __init pmbus_core_init(void)
> {
>         pmbus_debugfs_dir = debugfs_create_dir("pmbus", NULL);
>         if (IS_ERR(pmbus_debugfs_dir))
>                 pmbus_debugfs_dir = NULL;
> 
>         return 0;
> }
> 
> static void __exit pmbus_core_exit(void)
> {
>         debugfs_remove_recursive(pmbus_debugfs_dir);
> }
> 
> Are you saying this is all wrong ? What alternative would you suggest ?

Just create parent directory in probe and only keep remove in __exit.
But you are right that might not be much better approach.

Best regards,
Krzysztof


