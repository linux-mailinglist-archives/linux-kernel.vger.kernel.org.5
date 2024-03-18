Return-Path: <linux-kernel+bounces-106319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BADB787EC56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342D91F22C87
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333E94F5FE;
	Mon, 18 Mar 2024 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGRpKAyV"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC491524AD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776483; cv=none; b=hU5T5ojUbc1Ck5GyHnZ/FMIpq/GQvK0TXbI48xkMqaW6I8jLohDOGQE5+Q99zTcLcBokMIjmVX0qjXfAyfHA8wV8/SmrDs12wNhcafv8VZ/l4E1zLZ3vu//oKtIyNnwhmzzYbSlN4H2nalMutdxRv3hPJzJOFbcwzFgLQ0W4rUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776483; c=relaxed/simple;
	bh=y7pTHlOEFdkEJGEQJ2SGDR/z/kLUt3axolalibLrBXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLkSRV+jk9qrJocOH/494Aiz0Z4vUl8+uJOKcIVo7ZK5IMUgq/kO3HxpGfw9zcbH1QfQ5SutG70koPJll91J510ANh5/Y9GyVHxfJV+NE5z2zs+O4BpvXNwPLluSt7Fo5cOhyFSlbnzKvS5rIJTFtWq5fE3v8UjhpxC/iL2QD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rGRpKAyV; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513c8b72b24so4988588e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710776480; x=1711381280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y7pTHlOEFdkEJGEQJ2SGDR/z/kLUt3axolalibLrBXo=;
        b=rGRpKAyVSt6nYiMFLwU/CtDgzG3aOH1TTP9bQDQQorJFjM8LC9j01Z56pmUBDmO3zK
         xtarQ5CFsDSSv003tYT4iB5xZpfBQOJ8aepgvE2Mdk7KVKokb48u/wSMvEe8WeY37GtN
         6Ix5tdYKhoxK0VsXVR0BU+9Bzw8TPS4scAVZiZkBYB7+XxnzQQlT03bBpNa2eXZwhTlb
         eUYBqecirMqAbvK06cBItW/NQW7Ho3cYPa7mpZdWKWLNkgh2g9tvt2tpZx+51NFcAMbJ
         6lGLYA6cDNvfu6hGIshR6AJVCGGSLV/1z/24AzfUtn8ZUDdOu6J8jyw1c9pHiMvnjWtq
         AGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710776480; x=1711381280;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7pTHlOEFdkEJGEQJ2SGDR/z/kLUt3axolalibLrBXo=;
        b=BPTzTIxuRRrEbQSWjZK9zfI0GHZ/Wizt6yj1mLZpSD5fEjnK4pOTT05vEtq75obPXa
         xjyvdPvePWpC26Kg5AFOuv4/2p/CfZrOZPG8tUK2mGFvFm2/xG0z7qx39iIMq5lcsQR0
         V5SxHu8WMGClchf6sd89Tr2nXF8QG7YOhh32U8duWgtKbTF7qJhNSOlOpWtuqGcl8X1I
         I1SJH48Hf6xu0XwQVCkABeJR9SMMftXVpwzMBoscVDBB2JJ+pmWQRUsJ2JJiANKCgb3F
         PzhrJHKIX4wYl5OarS9zNn95GNh6S6Rrk/CRy3NsfmwF0E5TPH50Xk836EjnvFmNSMaF
         UFmg==
X-Forwarded-Encrypted: i=1; AJvYcCWCOx8H8cliH1cETbXNbnZfaiUNHJOkzwNqVetKa0hjKzVQHoPbNe+jIonkN23iRE4MzwUgtmkH//oU/8ONN/DKoPpEZNDGD4H7dOFR
X-Gm-Message-State: AOJu0Ywea9119gpSTkZw/ChlqjRpbBkvbGBNpS9V1r/wsrBtgeDfIgUp
	/2Rc6kPRXQs6+s3B5MrILGqEN6jaM7l//To5CxAeZIsZlNmRrw+g3jNy5DBj508=
X-Google-Smtp-Source: AGHT+IFb0AEqWaRxMz93fKPNwYFIC3RDq1Nl3Hx3yhLUTMz0fjmBAMObjTqhY0qm96Vb/mNK+Q8PUg==
X-Received: by 2002:ac2:4ac6:0:b0:513:5af1:9d7b with SMTP id m6-20020ac24ac6000000b005135af19d7bmr8184241lfp.47.1710776479851;
        Mon, 18 Mar 2024 08:41:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id l22-20020a1709067d5600b00a469e550472sm3129771ejp.60.2024.03.18.08.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 08:41:19 -0700 (PDT)
Message-ID: <d3376204-0861-449f-b043-7a27e18d3eba@linaro.org>
Date: Mon, 18 Mar 2024 16:41:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: media: cnm,wave521c: drop resets
 restriction
To: Ivan Bornyakov <brnkv.i1@gmail.com>, Nas Chung
 <nas.chung@chipsnmedia.com>, Jackson Lee <jackson.lee@chipsnmedia.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
 <20240318144225.30835-4-brnkv.i1@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240318144225.30835-4-brnkv.i1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2024 15:42, Ivan Bornyakov wrote:
> Different designs may have different amount of routed reset signals.

You changed nothing. This commit msg does not match code at all. I don't
understand this.

And your subject is entirely wrong - again, you did not drop any
restriction.

But in general: we expect restrictions (constraints).

> Drop maxItems restriction, add a small description instead.


Best regards,
Krzysztof


