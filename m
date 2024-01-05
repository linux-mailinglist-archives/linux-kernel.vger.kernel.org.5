Return-Path: <linux-kernel+bounces-17692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B0D82513B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3EE1F22036
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DACE24A16;
	Fri,  5 Jan 2024 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Fyj3efj3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24982249FD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e3712d259so6845355e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 01:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704448341; x=1705053141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9fdcXf5kNw5pAib6+EjvxqLFSwTtkC1qqnDPXlQVj34=;
        b=Fyj3efj3gnzv/9RAgLIurOmIW0O8j3ENs4ks7HhTw5HcocnZV0J0kSIKgxlB9QRo0B
         /Q6l+nlgQMZlNPs+fxwVgHAIUDB4WHgh28Nj41PQw6hWc7EDZvrxF1xLZUkjIgvbOb9R
         tiL26VPyTOBS+welLkQR1/sXHKT//ZpWr0/LJMSyWkYO0KBQKnpu8enOwx/6E56e/6sP
         zg+h7jf1sgQoV619ou4FBmn3BYGkRRSisIt0Xag/uslPCLW4d3HG473KeZDKDQ9MstX9
         JxzbA3emQc5Bq//rk0rXA9jJYtiQDyAxxPZpAaCT8B+3DWOuQD3yjOU0jGYbJcwOXk+V
         6ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704448341; x=1705053141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fdcXf5kNw5pAib6+EjvxqLFSwTtkC1qqnDPXlQVj34=;
        b=BQjold9kO0MxQ0hA7/Snvn1ElBbzqQuliDtTXTRRvKub3iGZ4WAwlW3TNrlXpA/Xlo
         ZK8jxs5qtMmWJzObbyoaD71yYOstzpFkBL1W6lnrrUm5DNvWRCvlaoQ7XMI1pMfH+2fB
         sLI1x0HXnGvP3nLTPjlEuWdMBAlmwgba5Z5oNjgNBJeJfsDKALx7fXp8OD7lVpYvcMZe
         C0TQMWJU5MGazxANdsSEk6/H2I5s0J7Zk7aRT9V/u97PrCH2poa0RXrTfeZf2fv+BrTq
         N6HWu97WsaJQA/k5LTOTWgjutPwaU0ERbdgVyeuicSgfoo2tK0BdoY8nCTroXbNMvuTc
         V1LA==
X-Gm-Message-State: AOJu0YxXQQUuefyaVyFSQOM64ILGHpT7faDtAPQXk+DAkZse4kXvBydU
	z8wORKZU915REj8+KBlFuqA1UuvvltyXTw==
X-Google-Smtp-Source: AGHT+IHN3La8Ka39AylALgS+htu9ifu9DmLkoFo5uE/kOV+ysU2rHNBQs0rPKTASfBNPY9p6mnbJ4g==
X-Received: by 2002:a05:600c:358e:b0:40d:8c8e:a495 with SMTP id p14-20020a05600c358e00b0040d8c8ea495mr754410wmq.267.1704448341406;
        Fri, 05 Jan 2024 01:52:21 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b0040d7b340e07sm1022001wmb.45.2024.01.05.01.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 01:52:20 -0800 (PST)
Date: Fri, 5 Jan 2024 10:52:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, lanhao@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 net-next 1/4] net: hns3: add command queue trace for
 hns3
Message-ID: <ZZfRU3QyRIUUUbRi@nanopsycho>
References: <20240105010119.2619873-1-shaojijie@huawei.com>
 <20240105010119.2619873-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105010119.2619873-2-shaojijie@huawei.com>

Fri, Jan 05, 2024 at 02:01:16AM CET, shaojijie@huawei.com wrote:
>From: Hao Lan <lanhao@huawei.com>
>
>Currently, the hns3 driver does not have the trace
>of the command queue. As a result, it is difficult to
>locate the communication between the driver and firmware.
>Therefore, the trace function of the command queue is
>added in this test case to facilitate the locating of
>communication problems between the driver and firmware.

Use imperative mood in the patch desctiption so it is clear what is the
intention of the patch:
https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes



