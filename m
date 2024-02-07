Return-Path: <linux-kernel+bounces-57234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8C684D569
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CC72850CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4BD137C2F;
	Wed,  7 Feb 2024 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWFJeGWk"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B412BEA4;
	Wed,  7 Feb 2024 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341547; cv=none; b=QtfG/LWwh5a9G44xFiYq2EvixZaZcTEZ7wLPmAWqXxpqf3xhufu9km9gT3ARlhmY1X0tJ+S+VPuu7LvPJFrvnBhB8JAqjyTS072Dbl2OjZCQIBZSlFvJ2rGNGIfwc7uR5P+9d1av6/Dophsd+ve+XAFDu1rZIGFauaq+1KE/7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341547; c=relaxed/simple;
	bh=9+hKGsDihNv76nJokNTTmBYkhDtrKwveNJLjYVSzZkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3ZX+ZkGhe3WnlZpqCuiJaS6ZiaDAr+v1kPxbXJhR281PNO8hFPWam7Hjs8sCVZ23p1xsL6MXZFLUEWudnxvtcV83sDa/GFyDNJoVsd5jD/9wlrXQ4MzkNq99OGk3JxERTY6lEn0zSzYFL76PkbfNLIDShBzSRJaELfRmKvPFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWFJeGWk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d8aadc624dso9222885ad.0;
        Wed, 07 Feb 2024 13:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707341545; x=1707946345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jY7jlxemTvyAAOoBoDUnhvdei8qq3JR7h5T3KXgL/2E=;
        b=YWFJeGWkLzNxtOnGj4OgLaHImAC2XqZ8ZcZq8+FZcfxyERqUW0pSi9GVOZw2hwgJt0
         f+4ElotY09o8tD5NkLhypQH+IMZ0sYs6XYOn/gDqsUFtfBwU5YLx05VyWhBsqaTsuzpS
         mEG7gudmydEdrhm66oTcVh2xx/eqDCEtjYhqjDp8eklkZLQpWIqvfpPdelC9KYJ96LoS
         Hm9NYjuqKFL04jamLG7upflY7r86hGkeqzy8JO9yImABh+QUCPUtVb2ch2lgXJ6tEBvO
         vJUTQiR7+jVRleJTrs9l3n5pCBs/3tRiwWieMj7ecYbxrn5NdIz4ggkwiv3j9iC7oJ3w
         vo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707341545; x=1707946345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jY7jlxemTvyAAOoBoDUnhvdei8qq3JR7h5T3KXgL/2E=;
        b=d9lkvQOhu8nT6AsEb45hrANytE10GtSBFiBE0IQ1rwTCc64n9B1pX3QahUNFlUSU6X
         YCsuQh9KKGEc9/szFP9QLylqmbV/Usiip3DIV/UpQgQcEcDQfkKA8BbbRPmABVo/IByF
         cuS7PQfwe43stDy4oWaS2oGBPco6WAGbI468WV0x2kjP1UwEACI19s7QQ3tVP1fsfg10
         6auZZze+Qf2AjLVsEkSx2WnZATRSly/ednFrell37O8iAXCie1RyDx4CI9aaAiLyqdfn
         ByBpw2CfBAcJqR4L/PDfNphYXq0k12CogPU+x/qLkaObiopVznO30AD+OiDtRIijt10S
         FcHQ==
X-Gm-Message-State: AOJu0YyW9qYzZuOzDJ4Et5hE8efNvY4dTS2YvAzOD0OEHD+sLmUyZixj
	U8j47a9x9CjXGM1cyCE+b0wgnBi9G5Oltr56CDoBMHgC3fCNWJyBVjhsg9Ps
X-Google-Smtp-Source: AGHT+IGCuS4PrqYfMwhdldpChinQrTWWDGzhOVUIvY1Hq4/uUHrlSTAUtUnhCoznAKenrfSvVSpiWw==
X-Received: by 2002:a17:902:ecd1:b0:1d9:b739:a5aa with SMTP id a17-20020a170902ecd100b001d9b739a5aamr7894981plh.42.1707341545518;
        Wed, 07 Feb 2024 13:32:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/QaLoKYQVEUZJ+d4/DtkBarJQM/cmfjbixgE5MqU2ZGTFPHg1L6NNDTMl/ybSe2s96nt7YEFjYmffpSj+k32a6Om/dPFpvxFAtNOECt2YWp0i8tu9zdnsszUz7+psCxSHSaZWNjzAuj9ucA403cKmCKTyw2+2Uz+hepsAKmSjLrCgzQ==
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f2c900b001d910f0ac3bsm1945231plc.246.2024.02.07.13.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:32:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 7 Feb 2024 13:32:24 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: chipcap2: fix return path in
 cc2_request_alarm_irqs()
Message-ID: <dcd18c2f-716b-4bc8-8ae9-9aa240a7e5d0@roeck-us.net>
References: <20240207-chipcap2_init_vars-v1-0-08cafe43e20e@gmail.com>
 <20240207-chipcap2_init_vars-v1-2-08cafe43e20e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207-chipcap2_init_vars-v1-2-08cafe43e20e@gmail.com>

On Wed, Feb 07, 2024 at 10:17:09PM +0100, Javier Carrasco wrote:
> The return path can be improved by returning upon first failure. The
> current implementation would try to register the second interrupt even
> if the first one failed, which is unnecessary.
> 
> Moreover, if no irqs are available, the return value should be zero
> (the driver supports the use case with no interrupts). Currently the
> initial value is unassigned and that may lead to returning an unknown
> value if stack variables are not automatically set to zero and no irqs
> were provided.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-hwmon/294e4634-89d4-415e-a723-b208d8770d7c@gmail.com/T/#t
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

