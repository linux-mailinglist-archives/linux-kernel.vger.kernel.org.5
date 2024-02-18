Return-Path: <linux-kernel+bounces-70436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B4E8597B5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3703A2817B3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379856D1B6;
	Sun, 18 Feb 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFTFXikO"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074661E534;
	Sun, 18 Feb 2024 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708272143; cv=none; b=RaJ7G1JZsXJJCVyE/CSuiEW5ffzOhDM1Hj0hSkDhdKaKjrlaoaQf2ZKTBhDOvEuupzASJRBkstGxOe3+ghgNi23PL/0lYhJis1TzscE6Jhjw5t9hoExsi0B16TAhcACZKpQF6rGvjkFJylcNZXmHBnM3mcRHjaY2inuYAlHwtWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708272143; c=relaxed/simple;
	bh=jFXeP5DOfUwj9Q0l5p1vPN6O8Sx+lmqQycqgTdkil48=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SeJwcTcFQBRnLDSXCLVmXCH3aaxEwqNnL9rjfHM2/xGp/tkLjRU2y94/lY8jpy/xN1C7AbX05GFeKUD2hjELfUiZi30ewz9Qpbfaxdi1s2sj9W0GKeut+0m7z7aQhLnlNhGoUzTArHANJQCJlOUXyGbCYwt2ktvAKoBU1lqdCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFTFXikO; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso3101134a12.2;
        Sun, 18 Feb 2024 08:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708272140; x=1708876940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AtYTDa1Lhl+B0ws7FJiPos9NKcWS7fkqx50JTS9on7c=;
        b=PFTFXikOwYkyIQI9l2HpsbdSf3hd1lGiYX84uC6dH6fNMLB/k9MgVP4iN68kTPrDMD
         6DqCF251KvwWVWHJP621v07OWd9mJ/PtwxKcqARoPNbwRkHmuBFEwAX2kuU6UNFGI7Ss
         +94wsNdIc66P9Ge52OGxUm6G/A3ValdbzNPR789BjHloBMr9+mFZ1XVwFybUTprAwmjQ
         W6OTFP5FJQbgK/K2JVVeVssW5XLNYTGLlOFje/jelrIGzZ+62ZhzfbwEkRppmW3dH8/V
         JiLh+4bs+W+/LEtYX5t9K4vEPj0/y/w0eptMdxtEwz62u/AxfMrg2RWitjvKv+T8Z1/V
         AM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708272140; x=1708876940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtYTDa1Lhl+B0ws7FJiPos9NKcWS7fkqx50JTS9on7c=;
        b=u4hoBp6pWvkhpaQ4FOFy4ymZuTx0rPr31o3ZEyTxwXsHxW63iBp5CAejGFB7jvHQ4K
         dF/xQvStyp17aARvfsaNFweXlHC4YdgIFZXGhZ/uJ/ChGb85/yaz/qqxMDxbI5AQBGDE
         H1HEbgrp51ld2EyC5lPIVu36Aqc1LcgBDubNwYhWgTpgkqYqDgJaX11eKN3uwGzixvOq
         DXRawojt9kOm/YcaQ2kkJbgJMyw+ixI7SJY3bBN2m921NIw7MIrB/4AE46w5TpO+64UH
         ipvxqsEaEOZX3CeBBK21ExdxUxJaJrPxbfypDRvcesC274z/8ENNLo9iXaOR1DhWP5UN
         M10Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDnN0i9IAR5XWA1HU/ZM1vyAdFfVrlKgO0785A0EyqkUMOjCJekxMtPZeFFRzZtM3wg4U+ADwBMifDqsWrd8MHNuB8LZJGT5TEJB2joULVPChHkNTIotIRAnyl6qOwKX4AUQrSJQx6+j4=
X-Gm-Message-State: AOJu0YzSMGrJblmFvlW2PPdgXFGs6DY38KQKv4sv9EabbsAlH/Y8hJkU
	sLJ+hsNyrMGHZwbkXoWl25WbODBGzBh4+vRB2oTWRw66kcGicLfl
X-Google-Smtp-Source: AGHT+IEZ3CR9bdgRr3Udwyg4JBaBEy18MSvs+2swHpxksNf329JsNC9YdSucrOE676n13PDqw94EZg==
X-Received: by 2002:a17:906:859:b0:a3b:7216:3091 with SMTP id f25-20020a170906085900b00a3b72163091mr6887010ejd.20.1708272139847;
        Sun, 18 Feb 2024 08:02:19 -0800 (PST)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id th8-20020a1709078e0800b00a3daadea882sm2024675ejc.56.2024.02.18.08.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 08:02:19 -0800 (PST)
Message-ID: <d04f6b6c-d15b-46e2-b518-a9a940827f68@gmail.com>
Date: Sun, 18 Feb 2024 17:02:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: savicaleksa83@gmail.com, Jack Doan <me@jackdoan.com>,
 Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Set fan to direct PWM mode
 when writing value
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
References: <20240217181536.344386-1-savicaleksa83@gmail.com>
 <718f0dd9-121a-4885-8976-aaafa7c44f2d@roeck-us.net>
Content-Language: en-US
From: Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <718f0dd9-121a-4885-8976-aaafa7c44f2d@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-17 19:24:50 GMT+01:00, Guenter Roeck wrote:
> 
> You can require that a device is in manual mode when setting pwm
> modes, and return an error if it isn't. However, changing the mode
> to manual automatically when a pwm value is written is not acceptable.
> 
> Guenter
> 

Right, thanks. Will implement pwm_enable, then.

Aleksa

