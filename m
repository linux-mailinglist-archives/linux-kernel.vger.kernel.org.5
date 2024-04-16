Return-Path: <linux-kernel+bounces-147358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C3C8A72E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AC3282967
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E94D13667E;
	Tue, 16 Apr 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF+Shdl5"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1FB13343F;
	Tue, 16 Apr 2024 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291164; cv=none; b=q7EZJtaOb8pKbLLHMfVpHjIMPcsWiyzd5Zqn2iEyp5vkbrWONQJ7IDtleiYAtFVTj3jPW7H+rcvKzdhHv9Ph55dVsXsHgG3gErnvfyqLeSINJanf9PLAyfG8eSrfPaPw5w4ktKBDDYUT3StS6gynndhPU+i94fqUDb/s6UED+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291164; c=relaxed/simple;
	bh=w2WOdK+HDz1fazSED3Oxm9eq69k3yabhpN25jQHSvKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDpQb7pMfVHw8t/uM5cgMjxda9n5Z7BKViHaGKw5AREb5Mnjjtsr25zAblcy24lxWiGzGUS+uCWQwUaAjca7VxL3IzfjzAJoaRaRAhv8tPAyajgAA2dXioi2bGz3nGcsr1KdC09ACqLZ4jCyEqUse4tgB4W+SZDOsSLVTIPSmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VF+Shdl5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-570441bc23bso1277774a12.0;
        Tue, 16 Apr 2024 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713291161; x=1713895961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+DxrBa0GRP7KC9Ck4Q7bz92lpzIac44ohmTeC1MwbNU=;
        b=VF+Shdl5n2le2uTJdl36RR5bNLp+CkcxIvayYDceMyc9EJIUT7Hfl1NJh/NM85uVNA
         jgBvTwbXV41UO3eIpmc3zH9430JhdoqSjontKYilq1FphhXG499naUbJ+EDGO9YOf2hp
         3aMKR0hIUfMWUeG67KTbd4EzI+K4BOwX7H1fMz4yV2NoYqC2ipG/2oJ1pGe42P5HCB/U
         G2LLqVmvEdujyf/5AhNHVZA4QfBk6TggK/tSvK2lJpRO3C3IT6cZinvRhzuZ62waxon2
         BVNz0TUJe4ppOEIjMbUMR0snl4fsNejVIfPVw5IyO/hm3bKFov+ORclaelypYccO58+4
         QHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713291161; x=1713895961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DxrBa0GRP7KC9Ck4Q7bz92lpzIac44ohmTeC1MwbNU=;
        b=aonmYTLdawPJSco9uFP+1kg0y8Q17nXoFN1Eq1Ae70SFbmNuF7aJXwPZCNxA0r0Lkp
         mzgysVgb20vQpZ+GgE9m1jdAXzG/96nrjuCGC99dEC9kSCo1HZuxbWnPWXGzZbe9EQRm
         GmExDOUMZ8okVVtjYGeowPiUYATHF7JDcOb4uy/lS8j/P2LCvTIWe+u0vlAiGbPA1XNH
         CMHct8+v+gvBR39bPnTakipDgJuc5ZcMkt+d8LOS10o2xu+DugVCLcQeGx7CV5Wwb6H3
         2qrAWzF579cDb5A03UTDMzf2dgypA1iSAxmbk0Qy4WjahHDr934W9kcTutnAeindn+h4
         HeEg==
X-Forwarded-Encrypted: i=1; AJvYcCWya67GB6X5riUHQXdQf0qF0yRM60dwD157FMQPG1lu08lnqCzqbC8yFonWc8pZwH6m0QsfWbNVsd9dbpBd3Vt5Vcgh2UohAryTxBKGFg1D9uqvpuO3gid7SZkUkDtQyEeu/3OPetQqQCRcM/oTlCIMMe46Kwl71XIREYsASZ8ATkkujlsS/4D4ZZE6gk9M
X-Gm-Message-State: AOJu0YzN/7JQDFMEq69qCP9+pDjJTalGorQVSbvQgYxMjxFvEg8PZr4Z
	J8LZF0Epx17g+lX+hYkiSpSOKg/qTuthhI99BWxIf6vBgWx5OPdN
X-Google-Smtp-Source: AGHT+IEi27VqQOVvq3KICDHbzcbhpfiY9hUDzKEjxbQmObbqYcwoFQmAo/mQ7qL2GxHkuGyWZ+kFDA==
X-Received: by 2002:a17:907:d2a:b0:a52:2f19:f1d7 with SMTP id gn42-20020a1709070d2a00b00a522f19f1d7mr9931916ejc.53.1713291161232;
        Tue, 16 Apr 2024 11:12:41 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id lb10-20020a170906adca00b00a526fd6362asm2616106ejb.117.2024.04.16.11.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 11:12:40 -0700 (PDT)
Message-ID: <ee8c39ab-d47a-481d-a19c-1d656519e66d@gmail.com>
Date: Tue, 16 Apr 2024 20:12:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Ivor Wanders <ivor@iwanders.net>,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240330112409.3402943-1-luzmaximilian@gmail.com>
 <20240330112409.3402943-2-luzmaximilian@gmail.com>
 <7ba2554a-4f71-4ca0-ab49-59dbd03e1968@roeck-us.net>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <7ba2554a-4f71-4ca0-ab49-59dbd03e1968@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/24 3:27 PM, Guenter Roeck wrote:
> On Sat, Mar 30, 2024 at 12:24:00PM +0100, Maximilian Luz wrote:
>> Some of the newer Microsoft Surface devices (such as the Surface Book
>> 3 and Pro 9) have thermal sensors connected via the Surface Aggregator
>> Module (the embedded controller on those devices). Add a basic driver
>> to read out the temperature values of those sensors.
>>
>> Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> ---
> [ ... ]
>> +	hwmon_dev = devm_hwmon_device_register_with_info(&sdev->dev,
>> +			"surface_thermal", ssam_temp, &ssam_temp_hwmon_chip_info,
>> +			NULL);
>> +	if (IS_ERR(hwmon_dev))
>> +		return PTR_ERR(hwmon_dev);
>> +
>> +	return 0;
> 
> 	return PTR_ERR_OR_ZERO(hwmon_dev);

ACK. Will fix this and the blank lines.

Thanks,
Max

