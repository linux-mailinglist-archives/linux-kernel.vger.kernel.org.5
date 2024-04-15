Return-Path: <linux-kernel+bounces-145898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5549E8A5C80
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B21F2837C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14667156977;
	Mon, 15 Apr 2024 20:55:00 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE5156961
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214499; cv=none; b=SZHNvtHMHcj++g4UlQsHlHLH18d4gRGUZpFMiuhERMx+hJHU12n/uW192Qtdy+kDAh2eAb+oI2DlTKTwPJlfVzV5xCIYzUdvuQS1ZxuYIjFIQ1jD0twsKVwXPsHTgkopM/kKxpkIzjpeJmJD3Sw04xLZBGsTl1F94dWkxpu//7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214499; c=relaxed/simple;
	bh=R0BVcMyAX0yyUmOHjKt7F46lAfNlP4crD4z4H9AjoEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqvoxn+KrmZWXzW0zf9YyGWnWZroCXJuzlqT/cK6CfZNWeudB5S9/SrJFtl9/gYttMiK3yOQYXhQXwvt+OAFzBH4G4as5w/gvO+OzDTs67m5Hin4V5GIEuLnbZC01LQiW+TcCLYrnvtmOb3K7bWkZWoFNzUxRxUIKY55iXa8QQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-346a5dea2f4so937709f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713214496; x=1713819296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0BVcMyAX0yyUmOHjKt7F46lAfNlP4crD4z4H9AjoEE=;
        b=CcHmJnGdge6yCqUJeaLYLX3LQxVt1M0WkeBJsG5rQeTvIBZbtTtKM4xwPH1ZkQBb5z
         Vk66Js8qfHnYBoG718ESXgFxIX98G8avH249bTnENWckXVIgoVwE/oVg8r4zP3VLDyNF
         RqitBKnAwLP0RGxCEOM0NtPf5SxaTu6ME/XuJkcwWtXuInWIoCYieQWhST2gR1dikDFR
         H8hJatlHQNmS3e5SwdJuemxwNsKIKuHuo13hu5snqszUSZWIVfBKb/xbfL0f1JWvI60O
         Y3UYQo+kHBOcVABJlgyV1N9LkH4Cx9dLqbiXRsLnt9ZNOqkauBx+dQ0W9oYZmKe2a1bx
         5uXg==
X-Forwarded-Encrypted: i=1; AJvYcCVx60dm2n717/wE94BMNSRGwznnKMgMH98SyKhWrUxuXn/tBQ+3E1a+N8YOncGualdLORygDJRUzXBkquKUMzY27E4EK8Vp/885fxWY
X-Gm-Message-State: AOJu0YyjdnzaCUFR3Cna92O0hKvJAk4qfA+P0FpNKH/ohID1HSzwnF6k
	kHcdlwfa9V3TsifizBOyJR3V6ObtiMgZENq+KcJLMtkArXp/dlse
X-Google-Smtp-Source: AGHT+IE/paPUbrIslqaXJKLp+/BJsQEW7OGj14bOiph44kp5xaK8bC6EH7BWoj0LyO4kd3XMNFi2Ow==
X-Received: by 2002:a5d:5985:0:b0:346:408d:42e6 with SMTP id n5-20020a5d5985000000b00346408d42e6mr8828519wri.2.1713214496534;
        Mon, 15 Apr 2024 13:54:56 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600000c900b00346c0062b0dsm12601268wrx.11.2024.04.15.13.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 13:54:56 -0700 (PDT)
Message-ID: <1080e784-154e-4308-8186-a672a6803ec9@grimberg.me>
Date: Mon, 15 Apr 2024 23:54:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] nvme: authentication error are always
 non-retryable
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240415124220.5433-1-dwagner@suse.de>
 <20240415124220.5433-4-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240415124220.5433-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/04/2024 15:42, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Any authentication errors are non-retryable, so use negative error codes
> to ensure they are not retried.

The patch description conflicts with patch 5 no?

