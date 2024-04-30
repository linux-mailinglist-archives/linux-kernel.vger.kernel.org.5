Return-Path: <linux-kernel+bounces-163719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4A28B6EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB2D1F2352E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C9312882E;
	Tue, 30 Apr 2024 09:44:29 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADA2FC02
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714470269; cv=none; b=mX8BVP1hBP3UTGv9OgVxCkoXRQ4dlvjeepPstubcdybrXTLW3r16sRUvRAtnXSXjqroYsN8WhwIuiKAqfGB5RVGx4lrbYXFRr7JJ7Q56Rx3WdAGl62K4Y/0pKLmaRLHOuxgjI3slvmCCxzWKjH4i9P65KsneamfH5xfdDme4bi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714470269; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlGLZShIqhs55G3kVw25QdQanxCG6VZ6IwnXGDhkkrpU8mb2eoHNg2K4Miw+qvf1RCgn1+FuWQysE5l+b4zA/Xd/ZBshVas7T12cIEF9DmvsEW3ZZ2eyuV5FPfRpfcstiA9Uhr/KU8jGD/J4ZCwVOHh9SQ9YhGzDMWxjEBgzD6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-346407b8c9aso1190330f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714470266; x=1715075066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=AtvvcDr4oVU8QKPPRelSqUizRt0bSwf1OKAgInVqh3o12kqm0JsEViIYGmKIS5FIA4
         jsPihsJK/MpbKF9f8asI8UbWDx5DyrjXt4BB7nuTsVvvm+F5qZElaej2mvdE202m4Xdj
         OqtFtb/DEQdrRlM++POBiQWpTEdCZFFHiJxXrpK987HO5BTElZPaiVBXZpE8+V0Q3MEN
         6TYLc5h4A362H6/qgt0HFKJQMmlD6nCmroUSiMme24sy9rGWllSeC0FTlorp+H67x65y
         HmCCv/dJII5LWP2sdz45eI6V5N2EsrCYcQbbBKHi/OzC3TTxtePy/aNsc8tA7gibf9mQ
         paAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTvZsrb5hgCWKCKRA2xjLcvu3ss+yqeXe8os1Ps47gK0odsmX8Qknd9gIRaVdPMZ3ipMAdDZlzNBdQf9MQMq+S16LAvV7/5aZcFUYS
X-Gm-Message-State: AOJu0Yzx9ZHAnG7dvKcX+JjpM8mecUeFgy1o6ZVmJ92izB4oL+QFSq0s
	xYscLM6tMXr/11FKWeXpntBMxEVQDi06kWBf8UGCukBRQnXwImxr
X-Google-Smtp-Source: AGHT+IFS04wTgqa0IYe3y3a3f/GOKbZm4K9dD19fJ+08CDnEmgnJyLJz4JGTwurQc7btDIEUZLLW2Q==
X-Received: by 2002:a05:600c:1d26:b0:41a:c04a:8021 with SMTP id l38-20020a05600c1d2600b0041ac04a8021mr9216511wms.0.1714470265951;
        Tue, 30 Apr 2024 02:44:25 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id bh18-20020a05600c3d1200b0041bd920d41csm12130042wmb.1.2024.04.30.02.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 02:44:25 -0700 (PDT)
Message-ID: <4f95ac4c-4243-4de6-b397-adf4637d5aa4@grimberg.me>
Date: Tue, 30 Apr 2024 12:44:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-fabrics: use reserved tag for reg read/write command
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240430021753.385089-1-brookxu.cn@gmail.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240430021753.385089-1-brookxu.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

