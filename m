Return-Path: <linux-kernel+bounces-96030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03A487564E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB2A1F21F25
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC45135A78;
	Thu,  7 Mar 2024 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUTx/WA9"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB73712FB3E;
	Thu,  7 Mar 2024 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837251; cv=none; b=ZpysjD5Q4KFAXuWmoZdHL4kMJMsFAg5W2wN8o7FINgW4C2tL6ogC0I8YTVUKBFJQjWK9nx9P33ztmM8lqGuaSFIblVDy50p8LB9wECvJ3VCy8xm+zQiUTHLkA/J7RB9XhHXczLyZvDwDnxxcAdJkNPkxHkPFZuFOv3zIkZktfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837251; c=relaxed/simple;
	bh=/T4rTT60qKW+g0rRzQsOHGSMwabDztCsDYxtMAUk1TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqmAriNN0kR+7whMtEhjJC561WM9NH/iD6FAaYeCJoDBrv+XnH+aI5q80vGPcSqZY3vXyka6L1M1j+w0+JOvSvd4lN0u50llx3A4kwjaXBS0QVXcmDHFJyZqVxsu5p0+G281njSPAArpTTuJ2PU5DMXUcns1vI41umzd3QkQIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUTx/WA9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dca160163dso11633645ad.3;
        Thu, 07 Mar 2024 10:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709837249; x=1710442049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHpzYF/0bnFdQReqCSrANQ8S9kqO60ayYearnoZhqOY=;
        b=VUTx/WA9AKhbd4uTMfxkFjGVVQQv8RI2oNcK9AdeeZ4m7X2zqK6Owl3uMBykoSkSK1
         pll584n7iy3vpMFVzfVoQXpjsR3Sb5K7inrnq+dyU99EVtF8cJqMCMil3zb6roe2TCTs
         Pyo8FNGX2xGoatl0Ji5ZKV3FmTV/Pf4/D+pbwgufQe+hYYwv95ykL4N6ODRLyr5xE46A
         Co9EzEwOGciqcgmrm2YYsT+Xsp/eYBZfAqvwqjKp3Mkf4+WNrj9eJoNYbbxEo3kzwiLi
         R6fljyv336nFWwpc17nBP8z8OnnDCu8eNT0ddOptlxREsGIBYoCRCbER2oSxskCuqXjj
         3W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709837249; x=1710442049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHpzYF/0bnFdQReqCSrANQ8S9kqO60ayYearnoZhqOY=;
        b=BAKCKHFtEzOLtEAemJCYTxbeKmtgM/6BlhOuuB7smkPQuQT0b9vHy/CaRyWwefSuHC
         AHaRS0i8E4Sfy8ZgkhEdASQ3KxcoTRvIpN3K7i8uR/76jDG5M4GsRtQ7kWM2v0YycAvp
         FR5Ow/mtDdCtRxWvCGeXDiKpSCHBkwRbV8Q6ag0j9YnVy+Ol3BGsRtoAdQw5TFAOajy7
         syfOT6XZ5SQFKVqAoxIqA3jo8j5z57us7kZswYOWYyiQbJDSmfhthBo2i3cB3hHYQ+Fm
         C1Bm3U0E7DoHRB0QLLYHweKecFXko/tm6ZZwVAborQF5k65FT72or/MxlW/gMRW03MJi
         1pAA==
X-Forwarded-Encrypted: i=1; AJvYcCVl0hKVKtotxiMINOPpzb9on++Q3KFsiSxk9vxA9DK3l+NIcHu6soTB0ERNfOy2eQ7Sew8xkZ5qCR+E6uGlPBCmjmLgI8yhM69++rEvDjzVCeco5P/ZqFdizM4rSqaesedpzHwgBUhCcj447qiJCVqP/ZAYjCkg2mzfSU2XrTX+7Qq2UmHO2NQwpRTJznLmjABjy90FbEzJJHKCy0RBEexRzgrMYjz7q3m3ApfgLBNDIH2t2k5046D4itLZ
X-Gm-Message-State: AOJu0YyIAdx+/ohNpWprcrkrSijXKxzjQ7buUfLZFdZJADuWklofo2PX
	okyrVlh4yD3e2CK8Nuq4xpK6DAm/4Bfuk3e3ezoHa/GLdM4S4MTJ
X-Google-Smtp-Source: AGHT+IGNvfC7nEsN4ksF8HVdz4D1aKcLKzSw6No+jys7cG8M3k7dVGYWSvmAeqG129djEdvLimQ7+g==
X-Received: by 2002:a17:902:a705:b0:1dc:7887:7723 with SMTP id w5-20020a170902a70500b001dc78877723mr8441038plq.61.1709837249003;
        Thu, 07 Mar 2024 10:47:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001dcbffec642sm14862818plg.133.2024.03.07.10.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 10:47:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 7 Mar 2024 10:47:27 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jdelvare@suse.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, corbet@lwn.net,
	u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
	naresh.solanki@9elements.com, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
	BMC-SW@aspeedtech.com, patrick@stwcx.xyz
Subject: Re: [PATCH v14 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Message-ID: <a7ace5d4-5ede-457b-835a-f2e9a82e5359@roeck-us.net>
References: <20240221104025.1306227-1-billy_tsai@aspeedtech.com>
 <20240221104025.1306227-3-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221104025.1306227-3-billy_tsai@aspeedtech.com>

On Wed, Feb 21, 2024 at 06:40:24PM +0800, Billy Tsai wrote:
> Document the compatible for aspeed,ast2600-pwm-tach device, which can
> support up to 16 PWM outputs and 16 fan tach input.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

