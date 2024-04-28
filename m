Return-Path: <linux-kernel+bounces-161421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C148B4BBF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09DA2B213E5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40BF6A35A;
	Sun, 28 Apr 2024 12:38:40 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE653E0D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714307920; cv=none; b=Vs/UlFJWk7oKiDQujpx86NyBCZKg+pn+TFLTDMSfY4PtC6szPmOPCJ1f9/ZKOxXoHUUFfV0ynjHH9SJD72U6CPDEZ4As0TlFVf6Mb0QEqoT6DcngempF3EM4+R82NAfzc1wzVEn3C7Yz1zc/6Po8bL9tUtEOM9PG6pBmDT/D6Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714307920; c=relaxed/simple;
	bh=a3C3w/l9Jk1EM3ykAh3xpeCqiIxLu5anbdm5krjQwRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lE1Mxzp3q19ak+nMglqo+Iqeq3JW4brE8o9I8OHBZCzY6JoUPxd65IQZM2minGVf6DohAWuyKfyDSvTQu6xB2FN/yQc0bQpzWR27uRoYyb5KtjwKf6LQ/Y66NNPRvFVOL6G/giGR8x2I164aQ0pYOPnKg59j2uVTxGUIWUltcSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-346407b8c9aso952909f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 05:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714307917; x=1714912717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qrkhLGFiOhJUvJx8Zd/ZRGYvnBujxufO0mRfURt1kw=;
        b=bsvb4nNRzIh+wLwzkNrpVZOQDxvdOClWkAgpIWa1Bg8BFLGFLve0DOxr5TBV925mmX
         Wvi/r5aZRd7orkFRA5icbtViifkAh3jTPkgoqJnhgXF5kl+Mkloj1xNccNd7WipHg3iV
         5H+HsmJK5jczoiV7/jh84HtqUnIIsQggujHFPEFk9EUnICaM1bgtPElJOm3TEcgx3kQ2
         BwRWldTbWPd6ikVVB4ZgT9eGgfmhxlEb5bRL7Y8WLEWVFye44D69wBSV3UQ358olGCfC
         63sIeoq+rfsyCHch8PJFJr04IgYtjmem4vL7NcJ3rXqYBoBlBl1vduG8MkXlcH3hLzQU
         eaNg==
X-Forwarded-Encrypted: i=1; AJvYcCVhTc68aunj+t7ojRrTw3RZRUyJf/K+wIqSfw3ZSsLxVFqfssqfiuovYRmJGV/v3SgLXwAKBYSIGsKVJ5EgQlDr8EfG22kKJ2lBXHjx
X-Gm-Message-State: AOJu0Yz+64b5+o37TiPT5mJSi+dRCVJ0rhLiGeXcbm2H7bAaal2VYcwY
	4V8urtlnXvX0aZGOif5SST+jxF5T1j3g7h0rnLEsqEn4qaJT3GRu
X-Google-Smtp-Source: AGHT+IFBe0UM3OUjH2RryrS/FQjB51e2yJzBYqU6NhjEKAauDK5BgRjfVpwg/rezbQeRw2Zny/aCbg==
X-Received: by 2002:a5d:5f52:0:b0:34a:a754:eb51 with SMTP id cm18-20020a5d5f52000000b0034aa754eb51mr6222293wrb.3.1714307916652;
        Sun, 28 Apr 2024 05:38:36 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm26983632wrs.53.2024.04.28.05.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 05:38:36 -0700 (PDT)
Message-ID: <fd92f659-f96c-4e48-b4be-3156a9616dab@grimberg.me>
Date: Sun, 28 Apr 2024 15:38:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] nvme connect deadlock in allocating tag
To: kwb <wangbing.kuang@shopee.com>
Cc: axboe@fb.com, chunguang.xu@shopee.com, hch@lst.de,
 james.smart@broadcom.com, kbusch@kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <d200fc7c-c781-49f1-8277-bdb5d537b1f4@grimberg.me>
 <20240428102527.37462-1-wangbing.kuang@shopee.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240428102527.37462-1-wangbing.kuang@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/04/2024 13:25, kwb wrote:
>> On 28/04/2024 12:16, Wangbing Kuang wrote:
>>> "The error_recovery work should unquiesce the admin_q, which should fail
>>> fast all pending admin commands,
>>> so it is unclear to me how the connect process gets stuck."
>>> I think the reason is: the command can be unquiesce but the tag cannot be
>>> return until command success.
>> The error recovery also cancels all pending requests. See
>> nvme_cancel_admin_tagset
> nvme_cancel_admin_tagset can cancel requests before stop admin queue, but
> cannot cancel requests before next reconnect time.

the error recovery does quiesce + cancel_admin_taget + unquiesce, all 
following
admin I/O should fail immediately upon submission as the ctrl/queue is 
not live.

> The time line is:
> recover failed(we can reproduce by hang io for more time)
> -> reconnect delay
> -> multi nvme list issue(used up tagset)
> -> reconnect start(wait for tag when call nvme_enabel_ctrl and nvme_wait_ready)

failing all admin I/O should not be associated with the next reconnect, 
it happens
way before that, in the error recovery work. Hence it is still not clear 
to me how
you are seeing what you are seeing.

It is possible that 5.15 is missing something.

>
>
>>> "What is step (2) - make nvme io timeout to recover the connection?"
>>> I use spdk-nvmf-target for backend.  It is easy to set read/write
>>> nvmf-target io  hang and unhang.  So I just set the io hang for over 30
>>> seconds, then trigger linux-nvmf-host trigger io timeout event. then io
>>> timeout will trigger connection recover.
>>> by the way, I use multipath=0
>> Interesting, does this happen with multipath=Y ?
>> I didn't expect people to be using multipath=0 for fabrics in the past few
>> years.
> No certain, I did not test on multipath=Y.We choose multipath=0 cos less code and we need only one path
>
>>> "Is this reproducing with upstream nvme? or is this some distro kernel
>>> where this happens?"
>>> it is reproduced in a kernel based from v5.15, but I think this is common
>>> error.
>> It would be beneficial to verify this.
> ok, test need more time, but we can first verify it only in v5.15.

We should not be spending time debugging an issue that might have
been addressed in upstream. The first thing we should do is to understand
if this reproduces in upstream, if so fix it, if not identify the 
missing patch(es)
in 5.15

