Return-Path: <linux-kernel+bounces-153744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9898AD29B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E6B1F21CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302C0153BF5;
	Mon, 22 Apr 2024 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClmOenp0"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF524153BEA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804260; cv=none; b=i63H4To6neyS8Y2pWOiGa5KJVCirrcrW8NeT81oGLak0DVOJjUpFx67/M4InGLTGA3NuC082uEkoXKel+1mfX9DIZaO+4yyQv9RL+zCOZdcgcRNQ27l5HTDaczMtrwmrLGmmI1Oks546CMWswekwjA7f1y5ahLf9YxudWgdtYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804260; c=relaxed/simple;
	bh=OLIXdSdWyYDbVVGKfMKB5COs4TOKhQUHpd4n73zkPmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNVkClZwkDNlRWtcxcY+Vz9aP6XVeWFIgR/SyLq2iqKkeEqhK65BXmweYW3Gf3FetfaXWJnWlXGAj0Y2FnGwyLrRCnOkkqenNiUpRfUfX86SSJX39ZZrEEl6dAvWoAtJOBYzPyplzdq9ISri3dCFaqNx4Earj1t1vQy5eZNW7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ClmOenp0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41aa2f6ff01so1157765e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713804257; x=1714409057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6Igkul0EwY2j/aQPEzUDfSBugLceVua3YOJOdTVDis=;
        b=ClmOenp0YzTqL6CvF3y0p5zORolypxIV0C+NopHZUi6RkUdgzcjzePk3gs5WVveTI1
         Uo6iP+WGTGq6X/lS65dIdAicQlANZH5rQjC8lzj+4wF8XLO6yjFGwyOHXOXndCkNfgGp
         z5mjYZBn0+Paw6gnrbYKl2IuycnT5gbHJbRq24yBLc+gboWC1wgs5vTtp1AlQE387xHj
         n2g46hFrlYGwHuMqDoNmALsNsoBXbk6FgHgZJ9dDquFNp6L31y+FTbWqUThAD1y1ZSIA
         xUaMIRAI8WEBCw77R+95aUEPSDBz/gOjylu37HOfSunW29Vl+NFcTT8+IRTw+2EQNGnz
         zicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713804257; x=1714409057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6Igkul0EwY2j/aQPEzUDfSBugLceVua3YOJOdTVDis=;
        b=iOeRXBanE41d3CtAvpDlM+G1+V+49rzaEXwSbahEOtBnQ3sL9lc6r68Tjjmq1XkeE+
         pW6e/m7cZ1SAsZuaQEhHmJf0cTnGEG9mrAK2zFxIBBUDeR0Hz5OC2Vcw4n8c0uw5ggMF
         67DPbb8OCQ0FOWvW5+D3HJfZXs5neIgDWUA+FbjPabGkxKVZdqtZP4XCWKbLtmiFAQih
         5CtJ2mCh/gp6G9aFl1w+V4I6TIZRCHli9T0koVHcUfHv6a7vsh2sEzi3IeQpDRQgzXAY
         IkkO/aEcicD6oXdkJLQ3hej0Nx+GsbSE9fypiLECpm6EVSmMYIHrc/VFU1S3iYYpBnt5
         qjbg==
X-Gm-Message-State: AOJu0YwEZM2xmomcKqyQt1dpe0Tm5Gc4PRPLVqMmc+pNvTsGW3RlEOkt
	15eWE9kcGzf68WmZ4kIwq0nvnqgdN68aR4uMRq6aqE2lKgs5UsXM+uD/eBrpmnk=
X-Google-Smtp-Source: AGHT+IF2L5+lrLgaqC7ydR1b2YumbNI161DVVAbfMpg1U1grbIoqOICMThHm60FmuT1h116XNolFUw==
X-Received: by 2002:a5d:6acf:0:b0:346:d2c0:7682 with SMTP id u15-20020a5d6acf000000b00346d2c07682mr5989895wrw.30.1713804257244;
        Mon, 22 Apr 2024 09:44:17 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id d4-20020a5d6dc4000000b00341ce80ea66sm12414035wrz.82.2024.04.22.09.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 09:44:16 -0700 (PDT)
Message-ID: <8fcac485-d280-4753-88af-b9b8c58bbb64@linaro.org>
Date: Mon, 22 Apr 2024 18:44:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: k3_bandgap: Remove some unused fields in struct
 k3_bandgap
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <206d39bed9ec6df9b4d80b1fc064e499389fc7fc.1712687420.git.christophe.jaillet@wanadoo.fr>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <206d39bed9ec6df9b4d80b1fc064e499389fc7fc.1712687420.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/04/2024 21:56, Christophe JAILLET wrote:
> In "struct k3_bandgap", the 'conf' field is unused.
> Remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


