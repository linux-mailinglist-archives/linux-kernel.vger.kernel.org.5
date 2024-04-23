Return-Path: <linux-kernel+bounces-155228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024208AE725
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3DD2876DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95E312EBF1;
	Tue, 23 Apr 2024 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vdqtVQuZ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD16A127E1B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877077; cv=none; b=QdE2b5a/K1Ks3oijJ9pS1sTyya5IrCnlxhHCtgNlL4VXFb5ALVSigy61TH/D2aaFRFcbpL2YLxC1q5IszBWgIlXzOfBYlt5esRpzGT/0nKjuU+8cB6SWDuA2TquULeH9+fZ9ydPqrqke2MbC/kgXcQxAuyYCBusR3iqKpqom3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877077; c=relaxed/simple;
	bh=gbFgDHYOBjwAfydbjKzLfsqSEneKrhMKkq47E7/9+Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2O9Pp974tRQ56hvy8HDCBWzE9XY2lr+Iab6FUoAarXBv5HerZ0oE8Aq5kbnjQBoGa6KAbMQ082fMcShPlV8t9/HhtZg16deMV0sOph3J0r5NRF2wmh++/4MznHQhIlCtzUOUTwDjGmgVuB0gU4AsJj8c/Z+fG3bgNCBMp5Mdo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vdqtVQuZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-571e3f40e31so2967362a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713877074; x=1714481874; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gbFgDHYOBjwAfydbjKzLfsqSEneKrhMKkq47E7/9+Js=;
        b=vdqtVQuZD9tFB9h0Nfz7aHsrwc9rvtODwHmbPDKo4vg+R3yiOf+2zue38azPuFLEkb
         JNfy1aUwgnBUBQMre3s+pZMcPTpxEhGFXxwIFoYRrEihme5xH38fKRPHziZxVOiPEcFc
         FKpjcIfwql8ht+MgwhpYe9IAtIPZfwyBbcw3+R5PBTcODc+ZXBr290piPQIJG9fu9clf
         8dClUZeGWzsclaVvKmzqYbID4Hxq0xP8yjjbjkfWz/CaB3TRO4MhtsJSm8PrOevFe5jR
         CBeN6lAuC4NneN5kU6l02BXv8XtuTsxY+wdWKIy9OVpAHpUi9TiNwaW4xgV/L1lbupZz
         fyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877074; x=1714481874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbFgDHYOBjwAfydbjKzLfsqSEneKrhMKkq47E7/9+Js=;
        b=TO71vX2dTwZDTTm8FhbTX7OQrg9DeZBDAS8ah2nvZZUsw5b+xI8RVtyd8aDTyZPZMB
         yGuw3kSwbLULKo+9qok4mmzo4HU320D1Ij6/h/k4OuI1tbLAF6Y7dJgmPIgldCEhkXTY
         QSbIw2PAiXZd5b8ukFfiukHbrAWLZ4QRDPwFou2+4CiQaX3QQqTUkImObv/7T1u23dz6
         aOurQOP5yLfU+V/5RsGtihbaV7Az9On6UccTB7RUSvdfkbFyeHReu2kC/zxtyclk0jWT
         J+BB7vCjIebrFRrb3HCa0kdGpnMN9qMKxvifbAsOblS25hs/6SNipmyedhiqort++hn4
         CPmg==
X-Forwarded-Encrypted: i=1; AJvYcCVbi2I6uPh5zMHRQoHoO/rweWbG030b0EHpGxFnsiQNXZqaUxOpvZNPW1UUFaGKv7Uau0F62LQ+J1wcOWeQx8txoo2stama3kLLK4Zk
X-Gm-Message-State: AOJu0YwYrq09EWeK27Dn5BxrXlhintRAHxJ0LvBPrGX2yT3Y4AX6Iy+w
	yqRafs5mzjeVtV3oz9dW7B0G7cQexEl7z+O93OWDH+TlKXLUqiG8mDe1OPXHrRo=
X-Google-Smtp-Source: AGHT+IFySFld+JzBlc/qIbMllcHbAhPwGnkEfsEEOeb+myQHVp2LmwKN0wccqMzwrKNJyY3qCzWuBw==
X-Received: by 2002:a17:906:b752:b0:a58:771c:1a93 with SMTP id fx18-20020a170906b75200b00a58771c1a93mr1707687ejb.45.1713877073741;
        Tue, 23 Apr 2024 05:57:53 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id q26-20020a1709066b1a00b00a53c746b499sm6996080ejr.137.2024.04.23.05.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:57:53 -0700 (PDT)
Date: Tue, 23 Apr 2024 14:57:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Roger Quadros <rogerq@kernel.org>, linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: flower: validate
 control flags
Message-ID: <ZiewT6N2fjhFwrpW@nanopsycho>
References: <20240422152656.175627-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240422152656.175627-1-ast@fiberby.net>

Mon, Apr 22, 2024 at 05:26:55PM CEST, ast@fiberby.net wrote:
>This driver currently doesn't support any control flags.
>
>Use flow_rule_match_has_control_flags() to check for control flags,
>such as can be set through `tc flower ... ip_flags frag`.
>
>In case any control flags are masked, flow_rule_match_has_control_flags()
>sets a NL extended error message, and we return -EOPNOTSUPP.
>
>Only compile-tested.
>
>Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Next time, could you please bundle similar/related patches into
a patchset?
Thanks!

