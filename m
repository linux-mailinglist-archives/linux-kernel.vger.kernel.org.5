Return-Path: <linux-kernel+bounces-98124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D8E87756C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B431C20DFC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C23A14011;
	Sun, 10 Mar 2024 05:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/y4et7W"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5721FC11;
	Sun, 10 Mar 2024 05:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710048740; cv=none; b=h/fUpUpnNGQNwN8nYeyrhJWfxYM4D84010Ni6MkURkynGf69Snog6P/lS1l+JDBhbgr/L4vVBoZgHwTc5l76lPSTmWZN+HeK/dat6vWPUEheErv6oe3wZBj9fZf4teHUGnJshk0kwnR5o9n42cYdwZK92DJRH4HFiHWWVvyPW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710048740; c=relaxed/simple;
	bh=zmi2D5cawauZYLgSbivDNleJgobeHKxH/asJarlpOzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ7RWER5qZEuXfo5y/sKHbRWV8E/qyImwq4OKi2SE79RbZaYEo/trGTE2HTOhhkJYeScA2Y/VjahYbNkwMBgfJCjnhUsMjVE3BbcdsvvqvxAJHklPCMYoZvTbe0gfZVGFyXD6wnyqOiierRxX5muVH6iKLWuDy0GkQcXzQUEsD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/y4et7W; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e56787e691so2957233b3a.0;
        Sat, 09 Mar 2024 21:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710048738; x=1710653538; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WIkNRMUcRUKUqluKRZ47NqsfWnL9WVvH9ruTYaADPyU=;
        b=i/y4et7WYSG/utM5eeFCDhWZYBy4F2sErYbzt7uNGggNyxSL6pcdGvETCJzs5BdoGT
         wR/LCP55+3L1FJXS5S3eAV/CKsHJTL61VvGuRTljoZwNzYZN7j31O9LQMUPwMiWwfgCR
         Lij+kM9fGyQSYZ0sWFabzpQHzgypjBdEnMpVhcDgjobtTe1tZTe+J36pkuN6DCNXJh36
         uTEVH/D/n3A9tZ/1PO0Zep5029vBcDHv9IQEj8+XU4j2FoXY0srLnHLXj6FNMuVQSTKH
         pbNeX9uT31FPTvunYE2wKveVeJg01fyTtigxUYgBBh9G2SQSQSKg8KcZmJWWWeyIm2Fo
         7Qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710048738; x=1710653538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIkNRMUcRUKUqluKRZ47NqsfWnL9WVvH9ruTYaADPyU=;
        b=tg7fJaFMuA+ZrIDSAR5OVcLGs8yb2Hc5l8nyUTj5YcrHPWWqo6dGS/caK41/PtUyb4
         Ip4lH4Kcd1M1fYJRmUrXcNMMw/IfvZBW+y2+e18xu0e8ztJgzJU21+4ZAtY9KOzjh/zb
         VHW+eqjGPCi5mafleNrvqJiDOdtrXF+zXcDR2aNhwFQImuMPTc4Da61n428niTMIwUs6
         D/sJiPphtuB7ask+z72kwRDSrtQsRTdZgAvD4WlxXbyYs0xceyRqWVNXjKF3oOzGR0lj
         ksHsj4YXqg/3OMg+/QD7YBKEJWsi0jki1axqYbvB8qu55rVA0UgSp4qTOEHRLdDpzBin
         0TDg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Xsdysps0iQOym411cKqmQdZrgK4MS6CB9oW3rFPx5DDvly7N/OQXWJH7ZvvyPzprZXZmRpFL7XwhwNd/aQfXd/u2U64a/qjUrY6emcjSSIDvW8ZyyLGLPTHykbA5uT+s+86GuSEzGpVOj+Q6uz3WjPs8lxMl6Gbo2E0vNj1UXL13Od4CaDOkNzWgN/Lnp9EbDWaC0fnuLY6SZ0e2litBzqA=
X-Gm-Message-State: AOJu0YzGyX9kUgrFTS5W24lSc4XBB26V8QA5WBXTLgO6RWjvHY9Zueqz
	EIISoWaUebOTtoIwlXOJ3P8FJj9Yb20kwMeQlAw0T7rw+jVBe6Gy
X-Google-Smtp-Source: AGHT+IG6RwDREDzdw3AVjCnkI7AYw/YgDcFcnpDQiW9jhdit1cMv90bLpXVl2caK/PHl2lrTkrWPQg==
X-Received: by 2002:a05:6a20:1454:b0:1a0:8897:85f1 with SMTP id a20-20020a056a20145400b001a0889785f1mr3767726pzi.6.1710048738115;
        Sat, 09 Mar 2024 21:32:18 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5296:fec3:1fa8:a601])
        by smtp.gmail.com with ESMTPSA id o2-20020a629a02000000b006e5736e9e46sm2106973pfe.42.2024.03.09.21.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 21:32:17 -0800 (PST)
Date: Sat, 9 Mar 2024 21:32:15 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Markuss Broks <markuss.broks@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Karel Balej <balejk@matfyz.cz>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Imagis touch keys and FIELD_GET cleanup
Message-ID: <Ze1F3wVBFeVYB-AG@google.com>
References: <20240306-b4-imagis-keys-v3-0-2c429afa8420@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306-b4-imagis-keys-v3-0-2c429afa8420@skole.hr>

On Wed, Mar 06, 2024 at 03:40:05PM +0100, Duje Mihanović wrote:
> Tiny series to clean up the field extraction and add touch key support.
> This version is based on the next branch of Dmitry's input tree.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
> Changes in v3:
> - Rebase on input/next
> - Add changelog to binding patch
> - Fix binding constraint
> - Allow changing keycodes in userspace as in 872e57abd171 ("Input:
>   tm2-touchkey - allow changing keycodes from userspace")
> - Allow up to 5 keycodes (the key status field has 5 bits)
> - Link to v2: https://lore.kernel.org/r/20240120-b4-imagis-keys-v2-0-d7fc16f2e106@skole.hr
> 
> Changes in v2:
> - Fix compile error
> - Add FIELD_GET patch
> - Allow specifying custom keycodes
> - Link to v1: https://lore.kernel.org/20231112194124.24916-1-duje.mihanovic@skole.hr
> 
> ---
> Duje Mihanović (3):
>       input: touchscreen: imagis: use FIELD_GET where applicable
>       dt-bindings: input: imagis: Document touch keys
>       input: touchscreen: imagis: Add touch key support
> 
>  .../input/touchscreen/imagis,ist3038c.yaml         | 19 +++++++--
>  drivers/input/touchscreen/imagis.c                 | 46 ++++++++++++++++------
>  2 files changed, 50 insertions(+), 15 deletions(-)

Applied the lot, thank you.

-- 
Dmitry

