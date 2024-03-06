Return-Path: <linux-kernel+bounces-93851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565F08735AA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C10D1F22183
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707847FBA1;
	Wed,  6 Mar 2024 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="IGVZHo3V"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4677F7D3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709725191; cv=none; b=o434gkX1wDDbC0k9i31rmKjLnERhuCCIjfadO4Zmvt81NJxjUWdkvZbUGHVHRfrPAtBTmsFTIlH26Wa8MgL5eOQrXpb0MN6SKc5IemEmFp+g6zw8rOD32/nQeoZgoCR6qNlMFwPvMXAeSIlxWl17fkciH2MVZ//B6KVknLmbWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709725191; c=relaxed/simple;
	bh=jmXJMGcRnQBUkk1Q0aNQZjxooTTiMnOAaGrBdZhF9R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJJx2zEoZr9JKvfKJGvXuzGlQz6qtCnUl+ybMYSN2OQgFgK2SfKxmtHhqRJXs/TQ6v7GQhJoiWqBI3qovmY+h/+51Ip2bHuip/O9heoSoxCC3lroCdAFHe1LyyxJ/2KTApyfKxVTwPEHYwjBx9oMpejTrgihi+dx1a8pAiVugT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=IGVZHo3V; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412f8bf3718so2270255e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 03:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1709725187; x=1710329987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EQiUTBtPaCxK46oIKmaHtXvFz0YBoimK1cXyVz0Jy0=;
        b=IGVZHo3Vecpaycq97xGHIDeVLngWHvWVZ2lCs1axAoMBcHSQyKNUgu1eLEo2AJccXx
         Lxeg78fixDIouS2pRxJ7NDN9K2LJ0zmDRf8I8jeavkN6PtWjzhJAtN8MlPo0dZHiguVV
         JMyRaH/bqugjA4cGAMXyO+1TGrIRs38hI+z8euZfnCcaqkw8h2sShY4Sub9rL3GYysnm
         tOts0HXsstnBrqYjX9fhNzU9dAAxhTGncvYp80xZd41QT4sbtActNCNgAVmUaYYaIPFu
         Qq71EuDY2YWof3h7OS5vyGaBVQfdnp60cP7KXIp0AIUmvdRXHMb0Rw+XV9XXwtPQJzXY
         O12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709725187; x=1710329987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EQiUTBtPaCxK46oIKmaHtXvFz0YBoimK1cXyVz0Jy0=;
        b=kq9HwgoL+bJh4+0KNly4fDtDeVR3YpKrnW7bEAsk+i19MK8mzFQWFwkmMUc9mnieVZ
         4GFSFCuTYoq8tJ29t+dm7Ja/irYk5DgjpHCY3hWcyVlX7bk24nooZ1/Zk2GXpAiq16ze
         Ae/1JfC6UWvOgV+IZdZcqOmcwUvIq+B12X5mgUB7Yv3ws+cAf3QgPfFE6YyRWmtdrnj/
         sThXcVMqevrXzcAYMjfqU8cWGSlJkqo8YIZ0oGrRUBKdKlqYatreeQo2b0rjrzB1mA32
         /FqjaMgSZzO1gm37OjGGuBCF72hTNIhwck4qsslrYwECX6xOGXZLO/t6TVCK+LT3UFGg
         UWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxxA+xWPitOAfsFhzHPvWkp2mlbPXVpkDrwUi+xvqCDfkONeHCRmu+sCTEfwhBa+/hzguTEp10X11JxwSUMqOC7XkIfPBTPwhv3plW
X-Gm-Message-State: AOJu0Yy9S+FHZEnOkgEEviM1ChGnNsDrD0UyeY7bVOpdOFm5WwvBovYJ
	DsmlQGCEgeYUFaC4uZMDS0pjD9CIUh8GopyeuzzScfwBtG1hCd9SvwS0tsa4qAI=
X-Google-Smtp-Source: AGHT+IE0yeWy2wQap7b81/nBlb9F/2UDgBWy2qDnR9pAcy2ADsqmaYAoNU2UIpfNdXJJMmuJgSuHmg==
X-Received: by 2002:a05:600c:4ed2:b0:412:7218:bda4 with SMTP id g18-20020a05600c4ed200b004127218bda4mr10157714wmq.19.1709725187383;
        Wed, 06 Mar 2024 03:39:47 -0800 (PST)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600c198b00b00412c8117a34sm17072539wmq.47.2024.03.06.03.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 03:39:46 -0800 (PST)
Message-ID: <70e2b458-6cf1-4953-b9a6-2c03a0d7965a@nexus-software.ie>
Date: Wed, 6 Mar 2024 11:39:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: venus: avoid multiple core dumps
Content-Language: en-US
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1709704406-22501-1-git-send-email-quic_dikshita@quicinc.com>
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <1709704406-22501-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2024 05:53, Dikshita Agarwal wrote:
> Core dump is generated whenever there is system error reported
> by firmware. Right now, multiple such dumps are generated if
> recovery fails in first attempt, since the sys error handler is
> invoked again for every failed recovery.
> To avoid it, add conditional check to generate core dump only
> once during every system error notification from firmware.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

