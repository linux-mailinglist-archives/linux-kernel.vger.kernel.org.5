Return-Path: <linux-kernel+bounces-76326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FF785F5A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B0E28942A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1283D3A4;
	Thu, 22 Feb 2024 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfesqtsY"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932623A1AE;
	Thu, 22 Feb 2024 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597624; cv=none; b=MpBlX1Vyx8tWXcW0JH74baKMh8KYxJg4DWVQQ4Fcyg4PQ1+4nuY1ullrsb5x8BaTtyRVib5t9Jt2do2Gpcz8EpeZbVCOxAeI0rFGu5LocZYYRWBG9hu0DaAhJO1cn8o1Iei0mIBaeGMhcLoYqF8Jc1F3H/tga70FA4eDkpQYFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597624; c=relaxed/simple;
	bh=GaQtAt+0ZBuHOH149SkMsTgO5Nb/9QOVByr5ZUaP4EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F449/ksCg85RltIQos2tg4IhH46G0W6vKbSSyqPvp9fJpwJQcPLa3YBjNjemH+4zV/FF6PCTfn/Wlr3mrVilkHo4PcxOeukFR10iimkvl1yVPJOkLktDuN6yhgCmgfHkA02LJ4v0FApRmZKbPdS10VpWBkD9ACJxSmoAEgD6Q7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfesqtsY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4128cfb6b6fso1085765e9.0;
        Thu, 22 Feb 2024 02:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708597621; x=1709202421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flDKL0Jl4YYNTMBfDlt09JDqExll7DCl518ysKuqYuc=;
        b=kfesqtsYh32g98AnegRZwSF0ADaBE74pceYM/nhCjfmpeNTF1Q0GfMDEkU+KQ8661u
         82Jex4IHk/N4qTC9nDAKCtmAzflRdrlYRCB81jcNn1hJaWtzWr8/35Oec4dN6pkORM8s
         yNUSjj2FavxByav9xIJZdLptzW5eqN/qBd/a0rALMGXl3U2nfbAyBYqPBqfeXcdhA6rJ
         iDEeZ9v4QMfy7rL5qoguwKyGz4Hm9kyeGiZKiDavzrBMBjZYUDKr8fkCMPmzcFklHAKv
         L4ltSU5F/Qbo33MbxrM2apsgzU3Ek5BugqlfHh2Z2EdG/rJIJEa6VEahGn0CGKct449m
         Sh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708597621; x=1709202421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flDKL0Jl4YYNTMBfDlt09JDqExll7DCl518ysKuqYuc=;
        b=MY7snsybaI9NPqzTmox8nmVopq7f11MheNbxEMjzG1rq71lqf2lhPDvZ4EVjN9zP2N
         +T+D+SIcMDk3EpsHNkbyU/9RDlA8p4IV9X68biTXKU8nfllxOyHrNJG6dizaqXUbZfVN
         miebt3L2QNUXsuGQGft6cLKzN6FgQy5sBvXtCx5rpUWsADKZfInZiy7Kzhnx72tdImWc
         pU/pdCHRLunz+Oks8jVvczr5Kax+U1hNWG2pHHGGHWRr3TUaoz5qghRC8GHUcIWG73GU
         Qi+SDCGiM2awGrDEM4vPJ/nE0EIXNi6TgeZQ1kvr7knDXRrQHg5R8FzdTCZR+fwXi8Jw
         vznQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIrs+FBp9xotcYv0ggGom2jC4kvt/Rea9bsjReF4owLeSp7aZo7XIcMQWMLSzBzobFqY87kZuu/hTlEccqioePjwaAb6QgtqwSRmlLQuk5fOnaXSpgRgGL45yeR/wlGdHEivG4OwrtoluBUEKrwlmgV7w+EC11vUbepKVvaFai5X9diHkzAJw14Q==
X-Gm-Message-State: AOJu0YwieK+9W8TW55CxZDDrHShcUU+K6UmMyKNmCGFHvfSuVhlZ/G/B
	xxv6xs/apJj6thDjvdFEh/MVtVUWOxDP7iZKYW8/3UWsXgMnXHdG
X-Google-Smtp-Source: AGHT+IGm9OmYvF5AOKI6SIlJ+oFUOFk7gvki3TY7/frQsO3RLmX839J5ayqdHX9tKEsVaelx9yz53A==
X-Received: by 2002:a05:600c:3554:b0:412:78ac:a0de with SMTP id i20-20020a05600c355400b0041278aca0demr2320245wmq.27.1708597620654;
        Thu, 22 Feb 2024 02:27:00 -0800 (PST)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id t4-20020a05600c450400b004127057d6b9sm5749415wmo.35.2024.02.22.02.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:27:00 -0800 (PST)
Message-ID: <7c78e205-d798-4ce6-82b6-9d03737d3734@gmail.com>
Date: Thu, 22 Feb 2024 10:26:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ACPI: thermal_lib: Add missing checks for errors in
 return code ret
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240221123936.3421462-1-colin.i.king@gmail.com>
 <4b78456b-071f-46c0-bb47-919b493cab79@moroto.mountain>
 <68571997-c33a-49f8-b922-4b102e5b682b@moroto.mountain>
 <CAJZ5v0h8_F_Fru13aAzZ27W304gwex1d0NPyitourTaS_-ajeQ@mail.gmail.com>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <CAJZ5v0h8_F_Fru13aAzZ27W304gwex1d0NPyitourTaS_-ajeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/02/2024 10:21, Rafael J. Wysocki wrote:
> On Wed, Feb 21, 2024 at 2:19 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
>>
>> Btw, in real life, in 2024, the compiler is going to automatically
>> initialize "temp_decik" to zero.  So we could just do:
>>
>> -       int temp_decik;
>> +       int temp_decik = 0;
>>
>> That would silence the warning without affecting anything else at all.
> 
> Sounds good to me.
> 
> Anyone willing to cut a patch for this?

will do


