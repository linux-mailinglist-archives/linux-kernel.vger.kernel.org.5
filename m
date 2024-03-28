Return-Path: <linux-kernel+bounces-122630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 921C788FAA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26161C22C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654AB5A0E4;
	Thu, 28 Mar 2024 09:02:49 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6B45024E;
	Thu, 28 Mar 2024 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616568; cv=none; b=eneVz9lrttgX0QqePcc+GcAF15mxMaTgfEHfR21ZEysLq54xeQBwWC5fvYIgfW0gRJ+AR+q8IegjqWGO1oNoqf3pD5ayLdIvfQivlm4l0uXj5KYPIq2F+p0hnOi64K95TJ6JZlSJa4HOBhb8CrwZXQnYOcVWCGrRs1DI8cmfAn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616568; c=relaxed/simple;
	bh=xXKAKa461tS7heJrO1tiCk3yWmnxZb0FebuFA1FpwBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7/zz4PAf1qUIquPZnQoxIlfrII7VK0JM6KpwsJqls+ubg3YUW0ti6PdlsjnFl6D+wp7283qMncxYcQHfe947AfdILbiaVp8gxIlXLysLZHJTtHJ/92m2ffsxRO1AIPjbu9oqi/8Ngjgb7/7b/urYC/vbLtMB0JZS1/2oDr+YaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c4ca65dc6so795866a12.1;
        Thu, 28 Mar 2024 02:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711616565; x=1712221365;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bqYXlCwIs2wM5lxl+u/GBLyORU2sWUj1TtKfTDIg6o=;
        b=n2HYUwQ0HERc6rsn6DeiD89NfvtL6sloFypSDnKFWBS7HLPczqDL9p7VYshnTug+eC
         rYKlIrxubHI+QhAkCmzYV23jHXah2pRgcQSfJfnIq6+1b/1n2ppVCIH+N8ybQXIFKpxG
         SbufMR5D+ARxKSX3Qs3lgCyT9up1NpwDnZ1zEazC28eQPCIibife0283DndOwsPVOS7w
         +DL0BOkhCOCEce/kY6MI9UGW9pVBvMxXJ58nGSFj16QCngbTRABYH3rgRTCiSoSCUnl4
         VtmBPdVcJk7YEW68FNbwhkaciaRDd9+238T2KbhYvxUXeP72naFIL5IgHuUC6yUOT9OJ
         Krug==
X-Forwarded-Encrypted: i=1; AJvYcCUrNAlE6+I0tlpUWabqmBrIVjlDsnYfaBt0AKRu7ieYXuOl42lNTd53KHkt0fclXiB9oOwBRdILOpO38iFHoPgewRiZhOc5V+tjLpE6FlMKHOsNIsMUzB1x6oCyFP76+Z/eKGRqSL4v749dz7trXw/zfRD+a5+rqI/rQ08iN1++
X-Gm-Message-State: AOJu0Yz+Zj7di3JMqkne1fXgoRSiQvzRDAnHMV6TRPyAbRmZ1JyEzW7P
	wRuJrXMOssInEwopsYQZbOYhSsK2K/vdJNRj8oGxburgEGBYt/c+
X-Google-Smtp-Source: AGHT+IFOjI652gqr39QAfZc8oGELUdiRXBh3F8C3zUj/MqRmHFhhviBXstnTYlinyXx660dJ5OkYvw==
X-Received: by 2002:a50:d604:0:b0:568:231e:5e9f with SMTP id x4-20020a50d604000000b00568231e5e9fmr1537821edi.26.1711616565282;
        Thu, 28 Mar 2024 02:02:45 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id t35-20020a056402242300b0056c2d0052c0sm578654eda.60.2024.03.28.02.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 02:02:44 -0700 (PDT)
Message-ID: <f9f0fb8b-2261-452c-878d-8b0f831bdf5d@kernel.org>
Date: Thu, 28 Mar 2024 10:02:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer checks after
 RX/TX submission
To: Kuen-Han Tsai <khtsai@google.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: quic_prashk@quicinc.com, stern@rowland.harvard.edu,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240116141801.396398-1-khtsai@google.com>
 <02bec7b8-7754-4b9d-84ae-51621d6aa7ec@kernel.org>
 <2024012724-chirpy-google-51bb@gregkh>
 <CAKzKK0oEO5_-CBKvYSw4DKY4Wp5UPrrt1ehBFRd79idy7FsUuQ@mail.gmail.com>
 <CAKzKK0pmswLnGa8zabp_wo=6BcvCd9DR368FCJ5mcpZ38i4Jdw@mail.gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <CAKzKK0pmswLnGa8zabp_wo=6BcvCd9DR368FCJ5mcpZ38i4Jdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08. 03. 24, 12:47, Kuen-Han Tsai wrote:
> Hi Greg & Jiri,
> 
> On Sun, Jan 28, 2024 at 9:29 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Jan 18, 2024 at 10:27:54AM +0100, Jiri Slaby wrote:
>>> On 16. 01. 24, 15:16, Kuen-Han Tsai wrote:
>>>> Commit ffd603f21423 ("usb: gadget: u_serial: Add null pointer check in
>>>> gs_start_io") adds null pointer checks to gs_start_io(), but it doesn't
>>>> fully fix the potential null pointer dereference issue. While
>>>> gserial_connect() calls gs_start_io() with port_lock held, gs_start_rx()
>>>> and gs_start_tx() release the lock during endpoint request submission.
>>>> This creates a window where gs_close() could set port->port_tty to NULL,
>>>> leading to a dereference when the lock is reacquired.
>>>>
>>>> This patch adds a null pointer check for port->port_tty after RX/TX
>>>> submission, and removes the initial null pointer check in gs_start_io()
>>>> since the caller must hold port_lock and guarantee non-null values for
>>>> port_usb and port_tty.
>>>
>>> Or you switch to tty_port refcounting and need not fiddling with this at all
>>> ;).
>>
>> I agree, Kuen-Han, why not do that instead?
> 
> The u_serial driver has already maintained the usage count of a TTY
> structure for open and close. While the driver tracks the usage count
> via open/close, it doesn't fully eliminate race conditions. Below are
> two potential scenarios:
> 
> Case 1 (Observed):
> 1. gs_open() sets usage count to 1.
> 2. gserial_connect(), gs_start_io(), and gs_start_rx() execute in
> sequence (lock held).
> 3. Lock released, usb_ep_queue() called.
> 4. In parallel, gs_close() executes, sees count of 1, clears TTY, releases lock.
> 5. Original thread resumes in gs_start_rx(), potentially leading to
> kernel panic on an invalid TTY.

If it used refcounting -- tty_port_tty_get(), how comes?

thanks,
-- 
js
suse labs


