Return-Path: <linux-kernel+bounces-165659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AB38B8F27
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5A9B211AB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E581304B0;
	Wed,  1 May 2024 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUPQZn5d"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79231AAC4
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714585426; cv=none; b=QAl1anrMcb4DGTc9z29f/75DbvL2b1O8qQgyaZwpoVUNtP0os5uhahZwGYiFs3/7jYXj82PTiZJTJPdo/kSmkbFXOeqXpjLpoBnkhAhThGdkKDX17IzMAVL8Nw0YwFdYMb1sPtBog1wvUcuvTN9dWeTkxt4WFen1qCTw73Wy3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714585426; c=relaxed/simple;
	bh=3bmTWYwRFWLcqerdJa5XqE+bQEiJYPRaVhoVBhWPBHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0NpOkiYpduRQWO0Z5VLh9U7h5DWENM8ZTzO2aw32GLWapSy3IvoGIT4nC7xJUpJRTIL5/3DHrXcYofUYdXGVUNOkSwT0E+qjRAWzg53DphxsWWEkDWniTkE9RpH3aOlhTy7rNUq+CA3kaoW3pq9Tpl/PEBLGy3ABZxfsRDMhcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eUPQZn5d; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso11060501e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714585423; x=1715190223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3bmTWYwRFWLcqerdJa5XqE+bQEiJYPRaVhoVBhWPBHU=;
        b=eUPQZn5d7TaEoJSsjp25jtx5rg24DhMR4W3IErzep++MHMNOXuhjd6NvpVSKMnfD9h
         rQKPXgZ2yTuLdTi/CfX5xCCDONQ1KaJ+r9cGfA6qQ8pI85hP878bIKTIGHLL54QUYtWj
         7XbaotcFIBR9yID2Wt88+uenUlqXW4gZDVseFiShCE4ZXLFJ/hDMhuI9PjzQcFqBMv8W
         jS6Ip9nsARfaCXNYnA2jTOt/8HH85VLcUIZkc4+KF6kFYLKyyqDPAOwEx6OWHS2AGP4P
         s2CSq71js5XPP7h9FndO1C62XnEn0OwanCYV8LkX1SndpoQhSlEhy+fJiynNzHg+PL62
         RXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714585423; x=1715190223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bmTWYwRFWLcqerdJa5XqE+bQEiJYPRaVhoVBhWPBHU=;
        b=drAdIt3OWZfwJ1VQOojLgYp+WKc5Kkl4oKkYNiAyIjFN2Ml7Z79HwGK8CivhI/SUiF
         Zxb7pGzXjDcrpU/QBaTYRPPYiHrJ2cWGnUhl5ua5Z6xpAL9UsbU9Nv/IXfYNleHXksyq
         6TBNPSTOwjTA8Xi9N9hZdgTQl4nF89FKagN0a8YG9zBKgLUPw5meTPvol6/FnfkP/6vK
         mA/jfeikNOtA++rTi//FVWsSs29PQ+XEeefPsI38AvROArrrCF5T/bouSqf1N6Ri5tRj
         WAMUoSDR4TZbNepIbQKmZ6bH/CCNxn8yopkoW9OdFgC7+3T4MACfMIFILBADyBZNYDES
         1VLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIpFHYOh3CSlio+edOV6A56OABWhSd5AbqNPEKhgrRTCcFCikCqseoVVYHfOTFd1dUAe+WBDThAb1CA2DwUU5SJgJWOacTfykS59bC
X-Gm-Message-State: AOJu0Ywir/NLwWQqQfD535hjpSrzoIiQl8ynXTTQUPbHPPZ/IcJ6eySK
	NZeh7SYYtapMMHDoQZfj4issrlO4HU0pWE6+g6igeGwKCn8L6zFmZS/i73SEM6ILuInxgue2s6m
	S
X-Google-Smtp-Source: AGHT+IEfCIWUVgqYXG41TceguPXTQ+LH1imEyNeUiPyIb+1mgoogJOusr6dty/3f0bMhz+BELrLJZQ==
X-Received: by 2002:ac2:48a1:0:b0:51d:9e17:29f0 with SMTP id u1-20020ac248a1000000b0051d9e1729f0mr2326819lfg.24.1714585422462;
        Wed, 01 May 2024 10:43:42 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id c15-20020a056512238f00b0051c76aff880sm2212482lfv.43.2024.05.01.10.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 10:43:42 -0700 (PDT)
Date: Wed, 1 May 2024 20:43:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, jreuter@yaina.de,
	lars@oddbit.com, Miroslav Skoric <skoric@uns.ac.rs>
Subject: Re: [PATCH net] ax25: Fix refcount leak issues of ax25_dev
Message-ID: <7fcfdc9a-e3f3-49a1-9373-39b5ad745799@moroto.mountain>
References: <20240501060218.32898-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501060218.32898-1-duoming@zju.edu.cn>

I'm always happy to take credit for stuff but the Reported by should go
to Lars and Miroslav.

Reported-by: Lars Kellogg-Stedman <lars@oddbit.com>
Reported-by: Miroslav Skoric <skoric@uns.ac.rs>

Lars, could you test this please and let us know if it helps?

regards,
dan carpenter



