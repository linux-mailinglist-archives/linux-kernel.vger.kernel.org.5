Return-Path: <linux-kernel+bounces-95231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3015A874AF7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C494C1F2ACA0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1945E5B1F5;
	Thu,  7 Mar 2024 09:36:19 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F0883A03
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804178; cv=none; b=XW14xrbLFXJ59n0pxvRqTeHE2v0DtXUKeCXUX6xpwYw1pTxPeTBKknoa7IVBMbCFaJqnTWwHgpbM3tHUawrz3Q+YGmUL22C6Kf/0doB+PIv6be6EPGR9E8684ooDR7XCyvmLRm62j1fwbECicjIplpvi68lK9lnYgDAn0lRLe0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804178; c=relaxed/simple;
	bh=P5xG7fHkgrGR5tgOHafwG7T4K3Ym7sMnppLoHfjyBVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsuEMx9vK4uSMGLy4wRfH/LBt/oQc8d2IfaBIMfwSTYT1Bn8VKYDiBjPy7YLdbq4fiAqO7tqwhPZsSXTB3YdBCnJ6iQ4JF+s4JRVxW+45ZGTvN2TmT+bEde/7S2LrorRf1UgNbucjXuK/SlLcGXSsXMof5O62JxEEp7vUaX9044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e12bcf6adso215561f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 01:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709804175; x=1710408975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5xG7fHkgrGR5tgOHafwG7T4K3Ym7sMnppLoHfjyBVs=;
        b=O9NwCwYJAiOnosCfYI8usErsMsy9HcGjWLq2z3KteqhNh4b17Wzg4x2cGw6L7sRMI7
         /Eu1Vpl4lN5OUOtMhmtqkoy/Zhag9ca57Zz7aOZWaZAWD9Q001bu0lh2UCQuVnlkzIO6
         e9lnss2VWu8IrqD+UnxtfX1Q5oeTYSVSOX3hXiyDoOTmRywvj8rwP+rAvEa6TunChCqu
         CDu8HKLcOdqceGWZ7TKJMbHgilGq31Ys7+F8P31gYW3w4x0vk8Vr2SCAGIRiMHezmuhN
         1DmfV/LvLm6v+g7wmELycWYOQwbAjlcESw5WMnbT7+MHByqqVBL2hy08MzNtT6CJhUSg
         lfpQ==
X-Forwarded-Encrypted: i=1; AJvYcCURZTGBPEln92jPV1e5az6llQhV7hldx6DROB1dAjO8bpo8GHdmwJig6ArV5xWTZsF+jmHKguN/3PR1amqa1/tM+qiEijLd4zQ+grUu
X-Gm-Message-State: AOJu0Yxw/YkYL0mZNDDte1fJf4dB53GIl9wtqF96nU99zmRfrfLEhWLy
	dyJZYGRVMvvuY2HJesmmUUQpAIX7Qa+oPBytTFZRzAWNjddRilQx
X-Google-Smtp-Source: AGHT+IER5fyyCEGeRHzEBz5P6KXRMAXSoOMMr+MyscX0gh0YKIWcM9CMf7/EyUieT8NaEzsi8E5+RA==
X-Received: by 2002:adf:e883:0:b0:33d:9e15:12bf with SMTP id d3-20020adfe883000000b0033d9e1512bfmr4090018wrm.3.1709804175143;
        Thu, 07 Mar 2024 01:36:15 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d59c7000000b0033e475940fasm7451170wry.66.2024.03.07.01.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 01:36:14 -0800 (PST)
Message-ID: <6eae3879-f9d2-4fe3-96b1-c9e2aa939264@grimberg.me>
Date: Thu, 7 Mar 2024 11:36:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix reconnection fail due to reserved tag
 allocation
Content-Language: en-US
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240228091417.40110-1-brookxu.cn@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240228091417.40110-1-brookxu.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/02/2024 11:14, brookxu.cn wrote:
> From: Chunguang Xu <chunguang.xu@shopee.com>
>
> We found a issue on production environment while using NVMe
> over RDMA, admin_q reconnect failed forever while remote
> target and network is ok. After dig into it, we found it
> may caused by a ABBA deadlock due to tag allocation. In my
> case, the tag was hold by a keep alive request waiting
> inside admin_q, as we quiesced admin_q while reset ctrl,
> so the request maked as idle and will not process before
> reset success. As fabric_q shares tagset with admin_q,
> while reconnect remote target, we need a tag for connect
> command, but the only one reserved tag was held by keep
> alive command which waiting inside admin_q. As a result,
> we failed to reconnect admin_q forever.
>
> In order to workaround this issue, I think we should not
> retry keep alive request while controller reconnecting,
> as we have stopped keep alive while resetting controller,
> and will start it again while init finish, so it maybe ok
> to drop it.

This is the wrong fix.
First we should note that this is a regression caused by:
ed01fee283a0 ("nvme-fabrics: only reserve a single tag")

Then, you need to restore reserving two tags for the admin
tagset.

