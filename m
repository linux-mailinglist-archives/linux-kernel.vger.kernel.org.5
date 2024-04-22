Return-Path: <linux-kernel+bounces-153283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3308ACBF6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EC91F233C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6540C146A7B;
	Mon, 22 Apr 2024 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz2z7cpR"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B50146595;
	Mon, 22 Apr 2024 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784984; cv=none; b=c2O11r2B2xeNqPP52szC7YOERfPFFAiyKiVvDM6tAajlmAZVl2PN0Vc79ujkoJ7hLsx+YszKZPhlH4zY1lKnVdDy4Nkf6lC+JRyjO0A35qOJU9u3U56P4uA7ORVDEu2+NjikpB+jOgbdHf0/3kAwcPiYLb2ZZMYMnyEziOG575k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784984; c=relaxed/simple;
	bh=bUOAlueYM4Ulknow7uj7NRdEYIRwMnhpc5nRHzH4AUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYyUfV5RysdK9WHlAZgVn17cgD863MRPjXdygT7jAILSVP4HOKYEszzT2271j7vk6nCq/1WaAYvEoj9uOWsr8ZU0F+hSqCTYDbewIJi9WxNlUe8Dvgte281CB4UtO0M9KX1oLIcgGEx0Y3fHnOeOk8KLxEXp3vENLRlQH+tPYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tz2z7cpR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34a00533d08so2612129f8f.3;
        Mon, 22 Apr 2024 04:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713784981; x=1714389781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5OZDatUfQDDM+oVBX1r0/EJ9l0dP7tgNSOOzYFy/HEQ=;
        b=Tz2z7cpR92TPc9dlYhvsYHirXXM6DbUc5libNnnf3e+JyRqpGP5q57EYx6SBOpd1WW
         KAk1u1LwlX9c9bAMdBGPovH2b2xX7n79QHG42fMkfL66bbfN5d8NSrGneKr3w3/YZyNf
         lXJeqC92rfB5ZxiSTB59zKBJq6MVbx15Idb/8joRmYp5VVhoh9g4RKf4f6wil3C9H2O4
         KxAa7cF/6gGvDyPVlJcYjaYOViSjA2PUGGas8ryc+ldNoIKPD4UV+8SfeM9T9cMc+Xn0
         m/O/ZJ5Joxta1yldOyWrJchTAxKjihJUHunwh2csYZsAHjqrJhej97fh/RM1BVHQW2Df
         BNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713784981; x=1714389781;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OZDatUfQDDM+oVBX1r0/EJ9l0dP7tgNSOOzYFy/HEQ=;
        b=cVHW2BcBgNuh79lh0FQARbObnX6WqghwwthShKAQ8g7as6ENuOdVLu7BrTF66izFyD
         /sJmQbvqTdThqppHOzi7uuzib6siu9I8bYrG1iS0M0oA0cntDzWEl+lRHpk8M8rHPeIU
         kTNVgnv4WaPDqauDx7EnPztwGzvMY3OTRi2nc5a5F4lg+HJnRv3MiiuKlVfKFJM2gRAB
         altCOJfTlXBO1zpOZA6hST/o7Y2dzkWXp+FkTqf7krVjglX00wBnH+gDFG3jRZ7aVr1Y
         t1+1VbG7tsPMDpyrsyJUcCViBEtiI9uommS+ewXO+aH468fGpIBiPQMGxmvDklpR1E91
         pd7A==
X-Forwarded-Encrypted: i=1; AJvYcCUlDD+O94xmJpUXcItfiC0SgSnLyQyFT7S+fNoQ0ttMxJ+JBqBqap8PBZ1nx2Ab1kpZuW04SNI1YMVVKkjggarYE+v1bzPHMLEvbauoLEijBtJcU8if7fdCMOGOC8GRYe6XzrznW9Q/CA==
X-Gm-Message-State: AOJu0Yz+ObAaJRXJ5ryNiUqbhaWIbn1JpamaCfnRbo/p24thlW6jnKGI
	ao8lzV4N62h5gcKkjTRlaNK8kwHp7qmL+7gdQGK0iB+Bg88rha6W
X-Google-Smtp-Source: AGHT+IFKevGfAeTp52lfFVp0nsv2RutGj2Qoptf2HvoOGqoY+lTav16WswsSrVXUqukSPea2elZc+w==
X-Received: by 2002:a05:6000:905:b0:34a:77c:e061 with SMTP id cw5-20020a056000090500b0034a077ce061mr7988259wrb.48.1713784981129;
        Mon, 22 Apr 2024 04:23:01 -0700 (PDT)
Received: from ?IPV6:2a02:168:575a:b00b:5299:bf9:946a:f51b? ([2a02:168:575a:b00b:5299:bf9:946a:f51b])
        by smtp.googlemail.com with ESMTPSA id s15-20020adfe00f000000b0034b03d0b94csm3110091wrh.74.2024.04.22.04.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 04:23:00 -0700 (PDT)
Message-ID: <9d898a98-cb7d-45d8-80c2-2ef428288e6b@gmail.com>
Date: Mon, 22 Apr 2024 13:22:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] Input: support overlay objects on touchscreens
To: Javier Carrasco <javier.carrasco@wolfvision.net>,
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeff LaBundy
 <jeff@labundy.com>, Conor Dooley <conor+dt@kernel.org>,
 Bastian Hecht <hechtb@gmail.com>,
 Michael Riesch <michael.riesch@wolfvision.net>
References: <20240422-feature-ts_virtobj_patch-v9-0-acf118d12a8a@wolfvision.net>
Content-Language: en-US, de-CH, fr-CH
From: Gregor Riepl <onitake@gmail.com>
Autocrypt: addr=onitake@gmail.com; keydata=
 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
 DMcsQA==
In-Reply-To: <20240422-feature-ts_virtobj_patch-v9-0-acf118d12a8a@wolfvision.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> In order to generate proper key events by overlay buttons and adjust the
> touch events to a clipped surface, this series offers a documented,
> device-tree-based solution by means of helper functions.
> An implementation for a specific touchscreen driver is also included.

I believe there's at least some x86 tablets that have such a layout, so 
maybe ACPI bindings would also make sense? Or can this be supported by 
your DT-based solution?

I'm not sure if it would really be needed for existing devices, though. 
It's possible they were all handled by touchscreen controller firmware 
so far.

Hans, do you remember if we've encountered any Silead or Goodix devices 
where the soft button overlay didn't work due to missing firmware support?


