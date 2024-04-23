Return-Path: <linux-kernel+bounces-155246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A79A8AE74E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0E328D491
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D10134CC8;
	Tue, 23 Apr 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="I3r8Gp3j"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9585978C6E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877484; cv=none; b=Ux4TNzqGgoMwu0q4drSrPJZqaZx6towiteh8dqfOejIEpRrwpPtG1aYf3tG2ZUwmzFQPBOxLhbDRniWjbeEmKCQN54KUrDMssSSejS1C18owWPzPXw0048oguL6SMXyFruguvXfGuq1UFkDIYYMQlHmZgA48qB+GHi2bNrH07Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877484; c=relaxed/simple;
	bh=4PayvcCQahx+h/YDh/dNOsNcPVTkJJLHrFkqYUc4Rwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNdk16rHjPrmOFGSi1kBs2BOYy6vtwMT1hgiA9+Zzo4GBgEPWwMLQDe+e6Erg1wJWaFMZDk3v3YSJ4DT1fLJMfv2MBVkRs2xmEXxBWZN4LpxXWh9tg5KhpaHZizAV4HLQFvINDOK3iYp/k8I0Rr+HyYJRqDnS2rLc7ovQR2q0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=I3r8Gp3j; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4715991c32so608901266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713877482; x=1714482282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKO5eiafgqhKAWmwCBGeybrOv3ldefy8ZOECZrE5TO0=;
        b=I3r8Gp3j7fuVzAInrRyB2RGTkxIlt/5Z4F7zra6/50Y4O3n6qWLIsFXNwzaNNLFYVS
         4VZjXqrZl0mhwlWvBTK61OXGlS2FF0GRTj7f2IwN/GHHspNJacJsgM1qWxOWf7YEABu7
         mLdhzaou0Yo4OOGiyMC8LO9PxPyLeOGdzE/aH6AFqZM5rSQepllgMNXli1VN3tLkPluy
         XuQhJ3R4hjiJ+0AqtNf+csagjvmLIpMMJV0VoBvh/LeYk3Th4xxMmEXd/NRAN+C4qg3s
         c8ErtXBbI03yczaAnsx4KiyVsqVU0JmBTFQYCpC0o614F7nEg9WRugmkqduJSttYKZII
         4x1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877482; x=1714482282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKO5eiafgqhKAWmwCBGeybrOv3ldefy8ZOECZrE5TO0=;
        b=q3hTWzjQoZw5TzHa8DaNgSatj0dU95KK0AsP1sZMCxmh+dKcIYOlWpf6RtDWKNr64v
         8O/Fiss83JgdWSZL7kw3d//Nu9Bu84oPDQ40uxtyKioyOwM7+NTyo+v4RgOZ/7/xCcOK
         /ylsnX9c4nwioghJKlcoo32FPVLMCi5EgL/VGmZQ37UN5Z84F710JnQ5Xo44oEwAZI7p
         x+466qjlelV+qlE7Kvs6L+U38Bp7GBCAcKhiOnN7HOGKdu0TbFW0SZRxOo7TLJzfD2Bp
         /FSHcZOdeAezL2ZToh1ZFpCgwpkypp0LhdRFvjaqAwGvq0nRAHRFVl0wvmDqUv0gZVB1
         IkNA==
X-Forwarded-Encrypted: i=1; AJvYcCWOX0bxg3e8UBlueW2jGTq8+HafTU1t3kMnQO7SpG2w2lP4+NtRTamui2cqrL8AT8Z07tKAKg+47SWkqZtbtqtuX2GvXnGQAm4eZDaY
X-Gm-Message-State: AOJu0YxscwJ/UofoYtt81P8gGAikMl+MeD9PKclk+g37lPnHY7PCpodV
	c2Sta81LfGOsZq7kj4zjQSfa4DDD4aLvN5yhFnd9783TRM8cBBF00ijp1bfz4Rc=
X-Google-Smtp-Source: AGHT+IF6LtpiKpdCpU719YcKxu9nj8OoIklDYjPATVZCNPyyvGmEyrYn1Z1ks9R9E0zgmHl1ekjL7w==
X-Received: by 2002:a17:906:d20d:b0:a55:914a:8b4 with SMTP id w13-20020a170906d20d00b00a55914a08b4mr6639402ejz.37.1713877481719;
        Tue, 23 Apr 2024 06:04:41 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id i7-20020a1709061e4700b00a52244ab819sm7154788ejj.170.2024.04.23.06.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 06:04:40 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:04:38 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v2 9/9] octeontx2-pf: Add representors for sdp
 MAC
Message-ID: <Ziex5kCf3XwNQzjK@nanopsycho>
References: <20240422095401.14245-1-gakula@marvell.com>
 <20240422095401.14245-10-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422095401.14245-10-gakula@marvell.com>

Mon, Apr 22, 2024 at 11:54:01AM CEST, gakula@marvell.com wrote:
>Current silicons support 2 types of MACs, SDP and

What's SDP? Care to elaborate a bit here?


>RPM MAC.  This patch adds representors for SDP MAC
>interfaces.
>

