Return-Path: <linux-kernel+bounces-52900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 831BA849E06
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57991C21CCD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EBA2DF9D;
	Mon,  5 Feb 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sAoqS10W"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7F23A1CF
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146731; cv=none; b=IbPqJWxBGTQTPlUkRdndKFqlI2rI7dGpLU5r2P6CH1mwmpdbF9CNgthlczW66Rj8LPcSArkd9Ov8c1AvkFUGmPoWars0JfOUNKaZJLyK/qjrrhEZ9o8ioqe7s7bRcPoZJXzuSTG7b0UC68JYF/GjpVP9AjZIuZK8yKFBXtKfkNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146731; c=relaxed/simple;
	bh=4KcubRPRLUqgqIoz5G5H+XPel1vrIIpMYFvwjaw9uKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByA8bB7MDb/K2ato5PGp0fWtXsDtzBCblIa2SX7quZEcU8kyUSfIC601vdAdqoYnVSdzwWSUcQFBeBVcHCUitgCu50m9t2dTPB3Ebk9TIBzw9pN9VQ5AC5jY1v4KWjOL+yHLviZbguXef3zMNafnjl1w3mCuvdNdgxPBGlEcFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sAoqS10W; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56077dd7936so1022180a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707146727; x=1707751527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4KcubRPRLUqgqIoz5G5H+XPel1vrIIpMYFvwjaw9uKE=;
        b=sAoqS10WJHJI2Fk6qNhhy72Kz0PgZl7A/mdvMk8hbtAf3uMeMi7mWi0RhlQKZfNDEK
         JgWwedqF6je0KSWvm9xmn91PfbOpU8WZZKYhu+qjdDn5vXluyw2ng63+ouNH7obcY8Ms
         c5/F/tpjpaDgdAUx8XxUsD78Lm3vfgvbFtmyGxyrWGVylG1iMcxohPPMsdhFuvT4rV1T
         EDqIGUfhickbzISEVES5KxXzdIhiib1xkGq95l0mWTkIXOu7qSClUdb8jf/xrOr3g8gp
         QieNq2n0XSIzjK9gFsohWdJ6K1TVYmVNGSNr1WNmwotHZ8BpkFNp40FGX2MoJ/OyX1B/
         QVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707146727; x=1707751527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KcubRPRLUqgqIoz5G5H+XPel1vrIIpMYFvwjaw9uKE=;
        b=p+OQ2v+YcioEcokyAgCshzm4pECxwb6pt4CPAYzQQt1lSg9/jSBGjtyBV72WgcYLjl
         l7yQIjHF8cR5+5mFmyNV/9T7JQsQrOsJ1PTr31Rt6kOenAZdq7jpj2RL47rT+fCnW8fn
         kMMO7j+EXVW6kIG3cRb+mriV89JgLfJKxCjj3ke9VC0XAcsf71VHDGm32oPgRGmLL+MN
         l2YI5QhKdK5i7jpk1C719fZbNtJnIZ2GVkhFZEaON3SZHdyc8ArmIMqn1HeyHfDfvXTl
         fTkUsLhIX3yBpD6ejV+bqnNYzGi80yWPWokRNMcS4JDUL35VQxKVHEmFbT6qRylksm8Y
         TIjA==
X-Gm-Message-State: AOJu0YwHs/lkP5ZNsGX3/+bvo8kp8TfFe11vUkCsCnM+7NxwUas/MXEM
	L45ghYpy8Duv50y/8yu63FPTedEKEHsmjbvSL6hwhtUdR6Wj5K0ZcOtmeOar6w446DpIdLhTP2N
	iFxxMuadg/KdoTghJ64jOMXddbi9qQx8SpswSew==
X-Google-Smtp-Source: AGHT+IFeqlPRCRFT539kKDucD25/pT46c5dq1Ga3tjDQ/YWMpKk08QvDrTE6BcrLEWcMlA/MyLH6je9sLL1ST1lEwzY=
X-Received: by 2002:aa7:c0d1:0:b0:560:32f:4360 with SMTP id
 j17-20020aa7c0d1000000b00560032f4360mr4634382edp.33.1707146727621; Mon, 05
 Feb 2024 07:25:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205124513.447875-1-tudor.ambarus@linaro.org> <20240205124513.447875-3-tudor.ambarus@linaro.org>
In-Reply-To: <20240205124513.447875-3-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 5 Feb 2024 15:25:14 +0000
Message-ID: <CADrjBPoBTAQdKTyBUkM7rLMZUY-YEc9P20HbSwNNrkYao2V+-g@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] spi: s3c64xx: explicitly include <linux/bits.h>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, semen.protsenko@linaro.org, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 12:45, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> The driver uses GENMASK() but does not include <linux/bits.h>.
>
> It is good practice to directly include all headers used, it avoids
> implicit dependencies and spurious breakage if someone rearranges
> headers and causes the implicit include to vanish.
>
> Include the missing header.
>
> Fixes: 1224e29572f6 ("spi: s3c64xx: Fix large transfers with DMA")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

