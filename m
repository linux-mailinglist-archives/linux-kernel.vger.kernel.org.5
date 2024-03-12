Return-Path: <linux-kernel+bounces-100457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3460B8797C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667B41C21998
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AA67D412;
	Tue, 12 Mar 2024 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnNij+wl"
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEB17D3ED;
	Tue, 12 Mar 2024 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257916; cv=none; b=e2caNAd7g0LQPrzf/W6bC8HZaRVpzrwNc9eaM2nblL9ECBlPj1g/GE7ZypWj/BmMng7s3R8euC2gmb0zOMbCZMST+miENl0xI43wT4B0KBgm+pIiE1QY6KHj1d2i7I9anoo+fWfkghDbTU0DUQnegInaQIlShILhbbv3upqQnqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257916; c=relaxed/simple;
	bh=0Rva4MDeT0xT+wbucis/QAB8TKQhRHatjKufsZEJH3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t27EQ7Y88oAFZLYX7xYYSb3ReHsUnn1YuM9MHYgZvl4EG3s50wFJJ09SuacuLdwyylMeIEtG5G5P4BmvZeAi3bu9kH4mcmjdLNYa3Fp260+kQhJVE06ZF1j1pHpjpBduTg20n7sagcfyfMBCSvsrqqogTTRV8XLhhJqA/czHE6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnNij+wl; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-513c1434283so14537e87.3;
        Tue, 12 Mar 2024 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710257913; x=1710862713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpYZYXFYiMHqF9KEGRX59SN9aENbkML8CEYB3aujr40=;
        b=RnNij+wlv0+dXUi2I+0i9grp5iBwU3ez8eNnPCmmSZ7+0OIK7cHwlnAkLqiLEtqHMR
         ZJJk7UPxk4vIriH/QU8L6PPOd+AZRddLutNPa+MaAl+i7yIfoZ6VnApCCKxEBy3gXXOL
         xt+Cye2cHeru0BCSAmuTjzDz1ydnJd55Sr0EJNoYX1d8W7Cry19SErscQN3qcZHpc/3/
         Q9gKuLDtPAL4YwLIhvmLQrncm2uGXk/PHvSI4W5uwgE+uzyB7lnayaf+rbgbJuLOzijl
         X3tg/ecEU/dveDPtEDMhqgR376OZomKprbrczP8/PWUBv33uSPqZFEamE6YDM0/I+ms8
         BWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710257913; x=1710862713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpYZYXFYiMHqF9KEGRX59SN9aENbkML8CEYB3aujr40=;
        b=ttoLXbVJwXShDE+xeqX0fa1ERhVpMu3LqG4l4Hib7A7Y3ZXoVQ85ScpyXd5Jvz8Qkz
         JJ1i2cMg2pLH663H0siNhwLpF6nN5vvyfH+jp2cDHUbFgmkH0HkrhuHiMbQF8mDw9IqQ
         z+uf0LWkLFXnCzSbrwbmyD33bwEnKN/9zw6aVYeX3rmGiXYwyXpBSa7L1nKDEhYz7JkT
         yPiuAcB1D8OhJKOPSawzS8wU/AEK0rXZ8oxWPs7PqmM0NBHL4xERUjGapmL0wNdzf9j+
         uE5zhfbZN1sVBK/dZmlwyPHVtaq1zRb4RZEOyrx3U++3Fxh5nSff0E+augOPjHgLIRFW
         2tfA==
X-Forwarded-Encrypted: i=1; AJvYcCV3aGERnI5SQZBbGlW4gUEPB4L5J4WXwpiOLZO9TF1FojhPYUQgY/u4WFuUgh5S5vBtuDQBr6YJxijF67UKIXclfBxFu2YZ0xPS5Uv4
X-Gm-Message-State: AOJu0Yz2BbMEJZ7T7E9c9LHqzolYH5Bg6Oyx6dGNvvOMdpQcEdtDVbz5
	e6uijurxGpqcFxCfA9ahKD8LtWzj7IjZEyujXBemlTsEnxufZ3nS
X-Google-Smtp-Source: AGHT+IGzuHtxEkX2jKr0g66lDy+8pZDNTTQ1lJX6sCTXlKhXXHyfZMozBdZQyQCScO/+JaftgPGEsw==
X-Received: by 2002:a05:6512:46e:b0:513:c5b7:9ee3 with SMTP id x14-20020a056512046e00b00513c5b79ee3mr417013lfd.6.1710257912789;
        Tue, 12 Mar 2024 08:38:32 -0700 (PDT)
Received: from localhost ([217.212.240.67])
        by smtp.gmail.com with ESMTPSA id i17-20020a05600c355100b00413079f9065sm12813145wmq.8.2024.03.12.08.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 08:38:32 -0700 (PDT)
Message-ID: <e1167dbc-db51-487d-bf6c-9bb5c73539d0@gmail.com>
Date: Tue, 12 Mar 2024 16:38:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/4] net: route: improve route hinting
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, willemb@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240307171202.232684-1-leone4fernando@gmail.com>
 <9ce73c04-ee8f-4aa5-ab15-c31dbe409401@kernel.org>
From: Leone Fernando <leone4fernando@gmail.com>
In-Reply-To: <9ce73c04-ee8f-4aa5-ab15-c31dbe409401@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

David Ahern wrote:
> I have looked at all of the sets sent. I can not convince myself this is
> a good idea, but at the same time I do not have constructive feedback on
> why it is not acceptable. The gains are modest at best.
> 

Thanks for the comment.

I believe an improvement of 5-8% in PPS is significant. 
Note that the cache is per-cpu (e.g., for a machine with 10 CPUs, the improvement
affects 10X the conns mentioned).

Could you please provide more information about what you don't like
in the patch?

Some possible issues I can think of:
- Do you think the improvement is not affecting the common case?
In this case, it can be solved by tweaking the cache parameters.

- In case performance degradation for some # of conns is problematic - we can
find ways to reduce it. For example, the degradation for 1 connection can
probably be solved by keeping the route hints.

Leone


