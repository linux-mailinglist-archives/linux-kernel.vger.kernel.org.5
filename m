Return-Path: <linux-kernel+bounces-31447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45733832E73
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8B81C214D7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80A555E7D;
	Fri, 19 Jan 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHVJ0WtH"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E904C54BE2;
	Fri, 19 Jan 2024 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686942; cv=none; b=Mcg8XPNjSaIpJEK3AUOPQ2NESuG6+T/EseIgkCsCeaRFOD1+7xiOX8rGzHvYUkBpP6H2e3XfwAvX4eZydH3ydRPH13MDnagOT60ntAKYVDEnmxQ7AkHTAGsLKg3tNLwXBbskEMVmuJcmU7wEBF3j1c4WOwBAWELVRoigzdHvwvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686942; c=relaxed/simple;
	bh=8p1zwhjPgha6d+fPABkjKL0JHmh3zcwooFif/S91g4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dRwzgwKlIDeuDe916DYGmbPr1DGer0Z3DO22AFOrGb1UHkzCK9/tu9TefYzLjG3sRNkV3KMPYk+yRVudPckz4Qy956POlRRAlQ03lu2S5+pgK7ulRTmDn+vp1Us7SK8Zd3p43YEKqL9Q4aJ1RqiQLJN62rl4kgb2N1hMUiD1nAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHVJ0WtH; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cf765355ecso756180a12.0;
        Fri, 19 Jan 2024 09:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705686940; x=1706291740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=//85YOI+SorJ5Qrj2oSRN/MglMKMgpBC2qBxv9agt8U=;
        b=VHVJ0WtHZm8qxrBeueAAwbHvHzlhlBqFvtyMB8szmNB2VEWNQ+3F04krkyM+2W0JDy
         tWe4JBhhn+YsViEIAzU1GYsEnCivNTOe8hBUxn0joynBtMjl+koX/cjj6z0WWR6MkYTD
         5GOg0uus6pQ2TiBIlrH55ReRJduNimTWZRVHmGtXSB83UKrbRh2RfAVeiJRisizWKHVN
         wNnbzVAtX4lv6zrFQyLx2OXECtHRHARY79yQjI0/n3EXAHsYYbd7eSvhKwkPaFkKhNvE
         kJNtcUrnixoHTbW6FZ+Q0SKmC5DjWZJz7w6aG2Eg3vEHYcMkz8X6ZVd/61Tp0Hb9QlnK
         II2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705686940; x=1706291740;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//85YOI+SorJ5Qrj2oSRN/MglMKMgpBC2qBxv9agt8U=;
        b=SIbhvuCCdzH7/eD4XoCIyzT3xYDjoOaUi3GD6TI7qK1ZgPJMOTGYflnSKcCQOAMc4C
         Mb/TGApikhLUAj+kVAVaZp041LzOx81w5lWyY5JfkQoGGp9Y1iiaa1BwsC7X56CxKRpp
         BHP0tCGjA6/2Y5DFh4lef8k8Z+Q2KpwEjWn8n6sFtgvMxRKsKuGhseiLxnEiUObG7/8B
         7XO63AqoTVrcIfYyAuvv71FCA/1uW/qdi5+vRDryLmz459o6uJKXrXMSIbCjclY4qPyq
         gJ6OMlK0AvJ7RcKCFUvrj8nqHZYo0oJY/6+vRs1ey0RF3OSVJHp2A4qbphFa+zll/RU1
         UEhg==
X-Gm-Message-State: AOJu0Yx8OliD7Zjtkiy6WsULwlbi5m4G8yWcC/3c2INy3kZuVoDyoPgB
	y0HSixUea6TMftWu+cghqRsDyXoedCkO8kvhniwczKPplCrjHj7zbv2Qgcjm
X-Google-Smtp-Source: AGHT+IH1ZcX4Btw5vBaWDkbKXdGI5vGR7vY6EOMFyL5SERzT9iBozzbktbAzNEIQruIvK4hASeV+LA==
X-Received: by 2002:a17:90a:fc88:b0:28e:7b91:5792 with SMTP id ci8-20020a17090afc8800b0028e7b915792mr129357pjb.3.1705686940202;
        Fri, 19 Jan 2024 09:55:40 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id nb17-20020a17090b35d100b00290394b25d5sm2953663pjb.22.2024.01.19.09.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 09:55:39 -0800 (PST)
Message-ID: <29a88f07-b1f6-45ea-b950-7c25c4872775@gmail.com>
Date: Fri, 19 Jan 2024 09:55:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MIPS: sgi-ip32: Fix missing prototypes
Content-Language: en-US
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240119135252.112460-1-tsbogend@alpha.franken.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240119135252.112460-1-tsbogend@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/24 05:52, Thomas Bogendoerfer wrote:
> Fix interrupt function prototypes, move all prototypes into a new
> file ip32-common.h and include it where needed.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian


