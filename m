Return-Path: <linux-kernel+bounces-76355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB17E85F609
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CA91F25301
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1E53FB1F;
	Thu, 22 Feb 2024 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBLobr3R"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9549E39859
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598894; cv=none; b=dslNcgpxAkV75WBPWizDV/x/yMwLaUFGVwIrtCuy6Q01E5J1qCiGafWbzoNQIRZRTNzhSC9Aa3/XaZEyWg7URAQoID+wXAFiuKRZbTWBY2d6YSx2USn80X3dYhs51jdRnBwdknFnjRSONop9nK3HRLz+4ckZ8FpXvwBw0QXh2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598894; c=relaxed/simple;
	bh=k9sBpNexw7nybOFrsaBxJZModR7TqqGCIuG7UPZ6EhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ka0yRiE6k+SzL4KCyEj83vOdRzkRB3kJmFx3YsFBexoBi+Fj+f0T7EDti3V9EK55s4S+UqfFtHZqB6bn6I/CRBNS6agchdbENYCzYP3zElCSsDN4uw5q5l0O9vlXr0m8qCVlnHMJy5cwjl0cwsQZyl7Ngbs4PFaF5jv5kqdXVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mBLobr3R; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d18931a94so1333819f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708598891; x=1709203691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PaPZ0gnges6CixkiAGzHAtGp1CFRPMZ1FV++RtCtVaQ=;
        b=mBLobr3RwgxRwmjJ6C6pGjWeLll/UuRAdN3grNYuemLmfVEx42+JKPMtQ97FAkw83G
         7fVq//dmWMWykfgi2pLNN3iJOrVqZtpkO6EpthzMlFYBdOaYLUHkYkFJEDamqaJK8x1p
         MPkps/msHSLbhteapxVDYtKB5vsflLXdOTYiKHOQHkilevdcpRVOu9xAuO8nmU6IUK/+
         tsGmJUZ1KhBIQ9d6MucJMGXfbwEMvx33v63TbP+FdlXKPH7pL0Ki4W13RUUKOAwJwU+t
         mO/MQC1FsxVanbhdNqoNangqLrsH7ZHuO/wbs0GDEhU1WahgQrs4RhhUa550G/8/jKpR
         9UWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708598891; x=1709203691;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaPZ0gnges6CixkiAGzHAtGp1CFRPMZ1FV++RtCtVaQ=;
        b=f706rc3s/8we7DOfPBvOdpiYb0pPDCrGsiE+vy38scqFd0guPxSbVIBziJ2E32DOo+
         ZsQ6xRaBnn/1nun4NSIdYPAoUf6K4pC7GuPVyYYpYzN+aQeg6fJG44NoXkkpTK5ZPyGb
         mhCRuCWJ5DuWY1R/9jD2FPpEhgqKJkqyIV/5OHb9y3ZTKXyiZnUD3um0VyYTtCXBprEP
         5Nz06F/rSVxZxoxqVjSAIZ2dnmti3QfcyeWNTXTJ7bK98f0PhIOVKW8hwR4SuSq6MZR4
         75baNLK26Pmrc08jCBxJphTJfT49ljq0U1unMpt8gEZDTBQjodINSzZCXTQfM5NAM69T
         jkaQ==
X-Gm-Message-State: AOJu0YxgFaVjPpeChHQYPOQrBsUXXm30r4Llle62kRSX+te9NQarlTdy
	MlN3efd9C+3n3kT8JvW9S/GMZe6Uqc0cxq/S8wR8wjRanNhYc4jl7CGy7bLaA1Y=
X-Google-Smtp-Source: AGHT+IEaKbEQ4+W/yPiy+1ShUDPbgwywFQu2bABbwGjGz/RHC4KkDOiCPxT4IkLM8a9aGlSqpMx/7Q==
X-Received: by 2002:a5d:6051:0:b0:33d:3ab8:2da7 with SMTP id j17-20020a5d6051000000b0033d3ab82da7mr8525002wrt.11.1708598891121;
        Thu, 22 Feb 2024 02:48:11 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bo29-20020a056000069d00b0033d5f5571b4sm11278754wrb.44.2024.02.22.02.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:48:10 -0800 (PST)
Message-ID: <53878b7e-6477-4cab-901d-1da64e2dfdc5@linaro.org>
Date: Thu, 22 Feb 2024 11:48:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] thermal: ACPI: Constify acpi_thermal_zone_ops
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
References: <4551531.LvFx2qVVIh@kreacher> <3552599.iIbC2pHGDl@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3552599.iIbC2pHGDl@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/02/2024 13:48, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because thermal zone operations are now stored directly in struct
> thermal_zone_device, acpi_thermal_zone_ops need not be modified by
> the thermal core and so it can be const.
> 
> Adjust the code accordingly.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


