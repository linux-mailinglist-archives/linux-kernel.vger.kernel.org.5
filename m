Return-Path: <linux-kernel+bounces-43136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C45840C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83EF5B2461E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD11A156993;
	Mon, 29 Jan 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OwF4pNCZ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F36156989
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546799; cv=none; b=UrSi/ZhwTuyozvqq30b3RkbBzOkE6ZOKfEjdueP+2RMgtXBU/dTyrE8NGKvua4h7qO+rqNebo1mBH27ZOt+buGYLzVMakZ4KIqzDyM+XpFhGLku2WjYfHh7d2+vshoPpzWSTSJJ8VbSLz2iHzNOmm/DWlkdPUqGt8Rq6jff7BXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546799; c=relaxed/simple;
	bh=mbENMP6ALwn3I6z8Y/mXtvTa2m+2zY7iKoHkFhuJDc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFlLkvyHuQ50kT6KklDFiOGm3oywGyUC9rpsGQ8oE8vUuKTUqH1sr0d4pcPXddhIl2ZqmgKMsVNhrYi5X7g5SdaNeAydeN89Ls0f+wmNDhZgCQATs5+UG50qG9hJcNZQcasi+KMCl7D6+5lrjQIbPojRvnpJgUIuzQz6oehBalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OwF4pNCZ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a35e9161b8cso103406666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706546796; x=1707151596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+f1+9NV9x1H6HYmKDscBmLQc10yQKPAhIN9I9MCfkQ=;
        b=OwF4pNCZfnV9A/Pdsjytx3AX7yX4m/jyHqPKuoONZtlWqv9N5oRr1uWinxZVTqPSKu
         rm9WahLftPjhRDOFKmWW+HXI7WEuJ+Z/tpQ0Sj+3XgoCVHENWXo5Livz1BYnQGIuUmlB
         OWUlNq55iPGY9kbCqHHn/G8pxa2K0qSe59n4bLicgO5wzB35K5ZF8zx0ak/0NxnXG/5b
         b1EFxLmBOhatShNT2eDbKP62BIuTbkSr/LggBpaCYW0rAToqVMjnmpc5tXA9zU5PLmUd
         uam2lr5ooBW8Qwv3u8zKG300hH+lgtgu3Kbrrqj6hR/F8KZqVJLVSBcc6Fc1NEWUqZmI
         ygrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706546796; x=1707151596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+f1+9NV9x1H6HYmKDscBmLQc10yQKPAhIN9I9MCfkQ=;
        b=piqWpGgUF3RY43UCNGG9AJqDmBud3CQCPyER8BjME/GKyPkRpBq/fGnv2Fu3sgrfPq
         qpRSFgJUGP2d9Gn4yYo0XiTBnP2D/i4GofX42NVGCA7OQq9D9yC3zUaIHl9XEMokiS0X
         o+5JY4JNlo25kV+qYPUlVbH3pSvP/h6ahCyBgCZzfREkBWRi4l9VX7gr+gsHGVa58/A4
         X6a752M9Dd11XNYAtTzLjjCxQGEI24MYXFnYBOnbcupgkLbVbwvNGn5yA6pdwTeNbNSI
         XjlmzWojDJkMcU0TkPyJeJZGEKglxWlEIzHVWOyLGRMIny1oAPZampHdGjnL8Nftco+z
         D6NQ==
X-Gm-Message-State: AOJu0Yzqm+N+adst2gMdVuZPIvRCGotavpL6cieE9ohCzH3SkreO887P
	bvtWbA3xNTMHCRsXDpz6IZTYzQzEFJD6+ZNWDgd3+Hp8CbddRhPpsR79+7Lf/ZI=
X-Google-Smtp-Source: AGHT+IEAgNenRs7ZgVCn7z/QNduayBhI1e4zb16MJM4JFkdHotSTBXrMQjRH9PgRvYrvY7DsFi3P7w==
X-Received: by 2002:a17:906:6c90:b0:a26:98ee:9fc0 with SMTP id s16-20020a1709066c9000b00a2698ee9fc0mr4624982ejr.43.1706546795890;
        Mon, 29 Jan 2024 08:46:35 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id tx18-20020a1709078e9200b00a3551f727d1sm2744582ejc.68.2024.01.29.08.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 08:46:35 -0800 (PST)
Message-ID: <6dd93b49-359c-45bb-99d0-b380882ce739@linaro.org>
Date: Mon, 29 Jan 2024 16:46:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: clock: google,gs101-clock: add PERIC1
 clock management unit
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 willmcvicker@google.com, semen.protsenko@linaro.org,
 alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com,
 cw00.choi@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240127001926.495769-1-andre.draszik@linaro.org>
 <20240127001926.495769-3-andre.draszik@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240127001926.495769-3-andre.draszik@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/27/24 00:19, André Draszik wrote:
> Add dt-schema documentation and clock IDs for the Connectivity
> Peripheral 1 (PERIC1) clock management unit.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

