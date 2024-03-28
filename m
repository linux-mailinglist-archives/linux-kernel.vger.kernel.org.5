Return-Path: <linux-kernel+bounces-123154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110AF890316
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD32128FE59
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4612F599;
	Thu, 28 Mar 2024 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D76hPW6n"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6B12F384
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639949; cv=none; b=GaXJ/fp5Nn210UBUquF/3YQM4rW/f7ET+ST5CMp5Am3+ijyN6IsRKsbImHtyxWVP3I6mj9VbNvd19d0N/ClOdMfckLJFMRDzXC2QDl42WU3pauRO0sHrjFywdKSxQebfjwZTXZj3cFOkhO5qk5KDjn2K4F6guUx2F72AP9sqjtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639949; c=relaxed/simple;
	bh=MxJfELHb/ZTHQmCUFrKhSwgtmJ0UUkjaK/hhdG86Tbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeUKLkSlwB3GRFVABvYrNG/nzSbojsQ+pjcMa8awfPFn7Edrnl7EK04V3U6m1IZ/Man9dG/yzOpIdUNdQpYlT74Z7P0qAYfFjLtAMZoGfFiw8dLSvZjA5TAz0Ct+f+3qguD3rL/NXkg6d1crZrDL6d5IKIL2LghjYUvIe+xe9Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D76hPW6n; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513d599dbabso1395139e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711639946; x=1712244746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXM/B0D5ELcLLV0Ges/OZ3bWdZ/dJWeP2NzZMjp2T8A=;
        b=D76hPW6nFroPOzm9ZqZZ2GI1tTIYRhUqFtFUxOjK/lXkgu9E7qw9G53VFEVNlFQM2u
         G8ccgsfV+c1eBXQc8BFT25jH5rdLoAnCGeUKYUiuXIFQap/BtVCcTOSCjlIrXtcm39Fm
         F9MtwxUZcYVB9Vaz1/NOy8V88+VoFPmoxz2BHgcjEU1+XtUP64w/OWO0ltzF6YyLCr1D
         +4GXqjR3PbfLX0Qqo7vuThOFaLrF7st8ZXXXpAIRFU70X4vmBSlPJjQ8GjKmUMrEg/1T
         U2vl03NUjq0BCQWPptP1Vz8kgPAB9Vd57YikDpYGrRcVs1IZ873Uu+08A9xW1Z2zXtdH
         yZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711639946; x=1712244746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXM/B0D5ELcLLV0Ges/OZ3bWdZ/dJWeP2NzZMjp2T8A=;
        b=WqevUATubVIa2TUCEKh9gn5DMegE2ffHD5oz11AVN09CFmCGITmzgazEQz6a0TBjyh
         v1FeGXPmIFfm9/bOu3fFqz7t7FcUl60RgfJZECtbyvVjhG9p8Ye5RoLpqj9YvaUN0jwg
         Cq99B0zRV8+ijAr//VPmPckRwlTHzBeQOgCzq7Dy1z5NSaOhWhuxX7/8WiSBG1pvbQRL
         YABn4SEsVA5GQHjr/FgqodZTJRxGj8afTB7BJ3gTxzcoHc4Hs0BpdFPi/FpC/eopUMx5
         tWLMc77Utl6VFOQWlvUyYLYuidckkaYbvAt9LE482h0E65lpk0fDhUkz/hnvFrAAyXn2
         4tFw==
X-Gm-Message-State: AOJu0YzbzaHh8wbqcnS1Goziu/mRI4fHhmJEwI0H/EuL0Ds+tQOQubmd
	EdBeC0JUhmyS1UDDWJYXPwxBI1IBY91iJyMN2qCDVFUPk0Gtlow1VVo/XIGj/xE=
X-Google-Smtp-Source: AGHT+IGjkuFmHs+Dy7UnY42ArmjBqrezgKsmPQ7Wh0/do2fY1/2ILRqdBpaOiiniwgbug+NLTvlShw==
X-Received: by 2002:a05:6512:534:b0:515:a876:68a0 with SMTP id o20-20020a056512053400b00515a87668a0mr2226473lfc.14.1711639945799;
        Thu, 28 Mar 2024 08:32:25 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a00e:a300::227? (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id j11-20020ac2550b000000b00515a6e4bdbdsm238086lfk.250.2024.03.28.08.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 08:32:25 -0700 (PDT)
Message-ID: <1b040be3-acd7-40dc-bc9b-24ea6d4b8377@linaro.org>
Date: Thu, 28 Mar 2024 17:32:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] platform/chrome: cros_ec_ucsi: Implement UCSI PDC
 driver
To: Pavan Holla <pholla@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
 chrome-platform@lists.linux.dev
References: <20240325-public-ucsi-h-v2-0-a6d716968bb1@chromium.org>
 <20240325-public-ucsi-h-v2-3-a6d716968bb1@chromium.org>
Content-Language: en-GB
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20240325-public-ucsi-h-v2-3-a6d716968bb1@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/03/2024 01:42, Pavan Holla wrote:
> Implementation of transport driver for UCSI. This driver will be used
> if the ChromeOS EC implements a PPM.
> 
> Signed-off-by: Pavan Holla <pholla@chromium.org>
> ---
>   drivers/platform/chrome/Kconfig                |  14 ++
>   drivers/platform/chrome/Makefile               |   1 +
>   drivers/platform/chrome/cros_ec_ucsi.c         | 247 +++++++++++++++++++++++++
>   include/linux/platform_data/cros_ec_commands.h |  19 ++

While it's fine to use platform/chrome for platform drivers, please 
place drivers which have a subsystem into the subsystem dir. I think we 
don't want to hunt UCSI implementations all over the codebase. Please 
use drivers/usb/typec/ucsi/ location for your driver. This also removes 
a need for a global header.

-- 
With best wishes
Dmitry


