Return-Path: <linux-kernel+bounces-153592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 727A78AD010
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1749E2820DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA4315219D;
	Mon, 22 Apr 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DmMqnutF"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B6136988
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798146; cv=none; b=iM7LMOiKpOfM3jVMxF8iBKopLYVQA2Mr7lGiBXOYd8MC0mRsjNswIstOg84bOuReRd+0cV3OxVnDdgurNsyImeOFUFfSfPes6/kqeZSNurDIUu/G+ecRxSq6pUwnChjA/Um+XF2c1jrsUK1P2fo63seve7h6DL8CwYBl5hbc/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798146; c=relaxed/simple;
	bh=uC7c7kYqSmVQGZp+YTPHZbbns+rkpE7UQYVX9hYf4mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVBvQ3IihuVSVrx4cx/+cRwnlJKHv9pdWqj1zYYVRm9KuHnMBjYohBrTkazPUjP2gQpoGReDfT+f9yuJQWKmyvi2aif1rzQ6fQ2CXFbqnaejJyh1F4J3t7GAHMfgsBrjzE3vXc+h2//3RG8NwTZKxCcgzVGjHDtSP89OQn0wdLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DmMqnutF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a55bdf477e5so87907866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713798141; x=1714402941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LAekVfGSUIYeilrCxStRbd53k4+SbtJAs1TjJ6PPZkc=;
        b=DmMqnutFFEh4xUj5lKI7xGsFfLxGvvnKM6KNWmkwyJax5Hesh2N7vblaeQyW/tsd7m
         ws5emYdL3VGdWhYphxF9HVyUA0NKT313Vzwt5axw9qQFkCZdYGuFHP4IVzY2lsqTMA81
         kDvOCXsNkkM5RcLqUPSba2OMPkI/0VMc0KzI/nZ45804Gf1R7DnAwnM/18t5guT4QN6w
         cpMM5s5owTll0qGRcssqQqdtseFiUbVwydVPJzQBRnqxnoQ9oYFtQWVPkpb9tChslu0I
         4b/HEZPVLm04nuIB9nropcd/wkkfRaBqhHPjiaIi6HltwFZ1iHxsyoZ1fy/fuqN7ftaU
         aEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713798141; x=1714402941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAekVfGSUIYeilrCxStRbd53k4+SbtJAs1TjJ6PPZkc=;
        b=k23PqQEctS3XEqUBDoIPOCsKG4vilVPmmUEIN/D/UDTyHFQGvNU45WLxGf5nJpCyC3
         uWYR3OsyGOxEfzWHw1Ljz7Y9eoRdVxfg/+5HYvICWhV9bvgZSodE9YZA7p8wGYeSOtLo
         PsStpKV7s24aD0dw04JrpCHStlmzG7tgzQR+4UbG81jPFOqLGNqama9gHQQmTUHp3hBw
         8i6CHPIG4tkyh7uDahD0hw9/R9yh9PI/WipFvTVcxijj+VgIg3AgvoqpK0zge2PgEnpv
         s98/RdHipAkbtmZGws/S4YB8+wzpXZ/0UxbDuyhp8efw1/MZOcA3Wk1qWF5F7vu0HKC/
         eixQ==
X-Forwarded-Encrypted: i=1; AJvYcCULPjttbkgw0Q5f8qwlp8OrnUvYeXx57b6s3GnYGIGimFXJahqhel4YBtvgTp6lpyWBkS4/Fz/O3PwzDLk4uKumGstQ16BDKfhlS/1q
X-Gm-Message-State: AOJu0Yw/oRExTmi+HeApi8DFhONQGs6gXISrY7Pf3XBw4T2zzx5+G5XF
	z2x0E3qQVVA9cBMdNlwSTBesT8LqVDGVu2UheXLJmi6ilu7Bu7Du0FSFjZtr9bM=
X-Google-Smtp-Source: AGHT+IHS6BZ9qlEluvP//9IwElLogHji7WqEThNxj1fC3U2GxC+dWUDgoMi5vcDNYySA8T2tWjoPlg==
X-Received: by 2002:a17:906:830f:b0:a52:3b6a:ab43 with SMTP id j15-20020a170906830f00b00a523b6aab43mr8149446ejx.67.1713798140345;
        Mon, 22 Apr 2024 08:02:20 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id h5-20020a170906590500b00a4a396ba54asm5866471ejq.93.2024.04.22.08.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:02:19 -0700 (PDT)
Date: Mon, 22 Apr 2024 17:02:18 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next v2 2/3] net: pse-pd: pse_core: Fix pse regulator
 type
Message-ID: <ZiZ7-n5q3COmPRx6@nanopsycho>
References: <20240422-fix_poe-v2-0-e58325950f07@bootlin.com>
 <20240422-fix_poe-v2-2-e58325950f07@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422-fix_poe-v2-2-e58325950f07@bootlin.com>

Mon, Apr 22, 2024 at 03:35:47PM CEST, kory.maincent@bootlin.com wrote:
>From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>
>Clarify PSE regulator as voltage regulator, not current.
>The PSE (Power Sourcing Equipment) regulator is defined as a voltage
>regulator, maintaining fixed voltage while accommodating varying current.
>
>Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

This looks like a fix. Can you provide "Fixes" tag please and perhaps
send this to -net tree?

Thanks!

>---
> drivers/net/pse-pd/pse_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
>index bad29eaa4d01..795ab264eaf2 100644
>--- a/drivers/net/pse-pd/pse_core.c
>+++ b/drivers/net/pse-pd/pse_core.c
>@@ -294,7 +294,7 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
> 	 */
> 	rdesc->id = id;
> 	rdesc->name = name;
>-	rdesc->type = REGULATOR_CURRENT;
>+	rdesc->type = REGULATOR_VOLTAGE;
> 	rdesc->ops = &pse_pi_ops;
> 	rdesc->owner = pcdev->owner;
> 
>
>-- 
>2.34.1
>
>

