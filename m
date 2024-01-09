Return-Path: <linux-kernel+bounces-20626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF383828293
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60151C239DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECFB2E851;
	Tue,  9 Jan 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LEAICaiX"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9332E834
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso3091277a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 01:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704790849; x=1705395649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TH0vBPQ7ZCebnduaCtu4eyZcvu00ZmUgY2nQfXfrFUg=;
        b=LEAICaiXk9EoYgo0v971JsF63IUyY84S++uHzr0TvkzXJADzJEnGZc1o9aSAlgdD9v
         e7UaPKyJrryuZi2ow760qU5/BNdNYPuqiXHSxytN1LMWSw5JNoMDYxtAQ7wKSSCdED3+
         U6UIrX76sGCLs7ocrLpUeNe5Tj50W37YIqNdvUJjRqMOnlKSJ0Vo0QcHZFBNXO/V0SR/
         N/lTbU5nUw9LRGgM5XoRszWmx8NFObWIpGXW7XtpleeTTqGwVi2yEnZ0oVHI2jU43apP
         urc5tTdsnZZmhGG39UQfSpwVUwz1rVv0KHRUrKGtqGaXstmqMjzAZnnePi/gFw9vbcQE
         KNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704790849; x=1705395649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH0vBPQ7ZCebnduaCtu4eyZcvu00ZmUgY2nQfXfrFUg=;
        b=qnTi1cpLyjw4fkYrkmo/yE2LMJMFrxXsY+Dp1RspOnwWpNgs41ilEST0VmN4CboZE7
         9qvEQXFxx1CQv/PLhyk1ZDrQ8wwFBTzFTdqXqaiLBM/H4f2auG6bhn05igbKyMT6EUMu
         qkpgqdF0iYe5pVokshHtbtaGjpkXdyW4+fUrZXbp/cD/npZNYMyu9SmwcepbSoKXELco
         4ip+VO1w8x3EO26qCvMb7XXTJFfCdShaO3Kog5Gvf79qbJohRsYk/WL07bhyqLYJye+a
         3XnvbrsGBmXzx5z/FaFMu5CyXiQPH8nEFt/f9n49DKtlRxUxIY+305yMIfFG1oly5iyp
         xs1g==
X-Gm-Message-State: AOJu0YwB9G+3lsy57VpHTB7WIfpZUxzJZthKXk1p93KsRU2j/Gcm3+vK
	ecytavMhkh7/U0TuNmJV8VqcOLFXhlsgKA==
X-Google-Smtp-Source: AGHT+IH30ASTTUP+YrSZh8cY7YN/x67lugONlKiG1xXVGzwP0BKTaZg/KLQlKVoQA9pBxotlfy3L3Q==
X-Received: by 2002:a17:907:7e84:b0:a27:efb8:6d51 with SMTP id qb4-20020a1709077e8400b00a27efb86d51mr194621ejc.228.1704790849166;
        Tue, 09 Jan 2024 01:00:49 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id bt11-20020a170906b14b00b00a27a766c6c8sm794046ejb.218.2024.01.09.01.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 01:00:48 -0800 (PST)
Date: Tue, 9 Jan 2024 10:00:46 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, lanhao@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 net-next 4/4] net: hns3: support dump pfc frame
 statistics in tx timeout log 
Message-ID: <ZZ0LPlVUqkJrDr-x@nanopsycho>
References: <20240105010119.2619873-1-shaojijie@huawei.com>
 <20240105010119.2619873-5-shaojijie@huawei.com>
 <ZZfSJoEsoXceI_2q@nanopsycho>
 <00e5d6e2-168c-4887-8b6d-8498ebaafe6d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e5d6e2-168c-4887-8b6d-8498ebaafe6d@huawei.com>

Tue, Jan 09, 2024 at 09:19:48AM CET, shaojijie@huawei.com wrote:
>
>on 2024/1/5 17:55, Jiri Pirko wrote:
>> > +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> > @@ -2871,8 +2871,10 @@ static bool hns3_get_tx_timeo_queue_info(struct net_device *ndev)
>> > 		struct hns3_mac_stats mac_stats;
>> > 
>> > 		h->ae_algo->ops->get_mac_stats(h, &mac_stats);
>> > -		netdev_info(ndev, "tx_pause_cnt: %llu, rx_pause_cnt: %llu\n",
>> > -			    mac_stats.tx_pause_cnt, mac_stats.rx_pause_cnt);
>> > +		netdev_info(ndev,
>> > +			    "tx_pause_cnt: %llu, rx_pause_cnt: %llu, tx_pfc_cnt: %llu, rx_pfc_cnt: %llu\n",
>> > +			    mac_stats.tx_pause_cnt, mac_stats.rx_pause_cnt,
>> > +			    mac_stats.tx_pfc_cnt, mac_stats.rx_pfc_cnt);
>> Don't we have a better way to expose this? I mean, whenever there is a
>> patch that extends the amount of text written in dmesg, it smells.
>> We should rather reduce it.
>> 
>In fact, we include this part of the statistics in the ethtool -S statistics.
>However, if tx timeout occurs,the driver performs a reset attempt to recover
>it. And the statistics are cleared after the reset. Therefore, pfc statistics
>are added to tx timeout log to determine the timeout cause.

Does not sound correct at all. You are basically forcing user to check
the dmesg to understand the behaviour of stats he gets from ethtool. You
can expose "reset"/"recover" counter through ethtool to expose this fact
rather than dmesg print. Please don't add dmesg print.

>
>

