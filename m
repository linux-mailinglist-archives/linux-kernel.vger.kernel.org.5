Return-Path: <linux-kernel+bounces-161346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2AD8B4AFE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E34C1C209CD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0815354F8A;
	Sun, 28 Apr 2024 09:30:36 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C854BCB
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714296635; cv=none; b=eA0Hp58YleH4+6CUz2/uMP/PSjjtbdmTFMEA8x1vjUMSeyLtli8lUu7H3PO7Rd5KbWJIG/vr8ZhdYFrjVIhk7qsPp/IQ/qImH2UKIqrR5fbq5DdA40gt6ifhjvRo2ZmeK9j332QLKAd8YqAnhIhG7IoUSgmd7+g3GQBMuonvrKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714296635; c=relaxed/simple;
	bh=hnUAp2WDKyiObcMdsrFeo3ocN7uAoYQ8xV318g1ejRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2NBKcoHddGWhqF5GTZbf+m32+aJLfX3D9JoKZsE6s7KKRxJFfVIu7Vh+piPEi7gsiIyVm1GZoTuC3ijOduVq+V3QY/78+JYueeTcFLC4F0/JL1DTf4107Nq2yqClM7BmwARZ7JEgKqlQLHeSx5MqPu9l8CUbgiVhg0DmDmnajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-349bd110614so653840f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 02:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714296632; x=1714901432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiKNDgQsfHZbm+O/UaLu7MdhwiG+0tZh6lGdIYblQQg=;
        b=XkaX2GPbXuWPy002KKyyyy8iQiRRKIhIqVC05IwWHjtdZJJA3NDhwN/AH2+kkES134
         vQ3X/DvRlYe2GSw3MMBSbxm5DV3s5cEFOFhhfbMhX0jSM7ccD8XlnpqpBH0xvOiSa0+3
         MexZmOdhzKcDAMIgTFKR7aGj+lfWFbDDaBgnpIDC15jMMuAvi2pVyMHnFaCmQniiXbSI
         TLWT7U+vubNrZPZbUASalTfluOwFdkixgnHMTFBqUepqi9J6tqDXis1SJk1WsdTcg+lS
         gbmIg9aaxsWdgGYY8Nwhs8/Ro3MrdTgtkTR9dWDL3pQO6dN+hwZpxNRbNdCGh6faXzQT
         VUSg==
X-Forwarded-Encrypted: i=1; AJvYcCVB/xSof1i5/Dg3syU9eJVLQRZYJL8BwDV/WqFh53/VZiZIs+cHFWLEqN0iMEosjVyIKIIDow7MQTx8sU5D96SpzaSG9JXPajcdMcjG
X-Gm-Message-State: AOJu0YyjhHHj8u/aC2jQ9zEfOwiId1rrjaHFkMMWGqnnU46fn0813maU
	k1P96wXwz5PFratJBET6hm6vAGnRQ0CdwxYMLX6aqku2JnBrpTFv
X-Google-Smtp-Source: AGHT+IGUUB4NZod29j0kMAukLhnu1vGK5/0QbtkzyfX+BfXcXARP3X/rtYYP16Z/G6kmP2SlXRbtoQ==
X-Received: by 2002:a05:600c:3b04:b0:41a:3150:cc83 with SMTP id m4-20020a05600c3b0400b0041a3150cc83mr5327499wms.2.1714296632291;
        Sun, 28 Apr 2024 02:30:32 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id k29-20020a05600c1c9d00b00418948a5eb0sm41394558wms.32.2024.04.28.02.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 02:30:31 -0700 (PDT)
Message-ID: <d206c1d0-5935-476e-be19-9bec537af1b8@grimberg.me>
Date: Sun, 28 Apr 2024 12:30:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] nvme connect deadlock in allocating tag
To: Wangbing Kuang <wangbing.kuang@shopee.com>
Cc: james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 chunguang.xu@shopee.com
References: <20240428063147.88058-1-wangbing.kuang@shopee.com>
 <d200fc7c-c781-49f1-8277-bdb5d537b1f4@grimberg.me>
 <CAG89T6Yyx4f6Dt__L=Ku4AwCzuEUhEOOEjuXbdE+GSSqVJVZ-g@mail.gmail.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAG89T6Yyx4f6Dt__L=Ku4AwCzuEUhEOOEjuXbdE+GSSqVJVZ-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/04/2024 12:16, Wangbing Kuang wrote:
> "The error_recovery work should unquiesce the admin_q, which should fail
> fast all pending admin commands,
> so it is unclear to me how the connect process gets stuck."
> I think the reason is: the command can be unquiesce but the tag cannot be
> return until command success.

The error recovery also cancels all pending requests. See 
nvme_cancel_admin_tagset

>
> "What is step (2) - make nvme io timeout to recover the connection?"
> I use spdk-nvmf-target for backend.  It is easy to set read/write
> nvmf-target io  hang and unhang.  So I just set the io hang for over 30
> seconds, then trigger linux-nvmf-host trigger io timeout event. then io
> timeout will trigger connection recover.
> by the way, I use multipath=0

Interesting, does this happen with multipath=Y ?
I didn't expect people to be using multipath=0 for fabrics in the past few
years.

>
> "Is this reproducing with upstream nvme? or is this some distro kernel
> where this happens?"
> it is reproduced in a kernel based from v5.15, but I think this is common
> error.

It would be beneficial to verify this.

