Return-Path: <linux-kernel+bounces-91788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0308716A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C583F1F216FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30367E11C;
	Tue,  5 Mar 2024 07:19:32 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757917E101;
	Tue,  5 Mar 2024 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623172; cv=none; b=mk31qsp27jRw/GLyB3OqselgZ+adFpyQAx1ByvebjMVrmNibneZZj8XTpEyle0Wegm/XN05EAKvfAkAkoOc4SFdgzGtyZEepjPJM/iAM9kvF7Zoi9AlCRmm3bXCOmNorFtsG4anwvsoMrzPDPLfwqqJEeCD3KDhkPncBPgA6v3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623172; c=relaxed/simple;
	bh=NcwVel1z7ZcoEyr8WPUWvegmKx13ucuVguofS4a7H/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M++qe432tNqdkETpypQr2ZLjjF32nkf8HlhRPZphnzWyAK+zc6ae20VhoWC9S9SFsrkTfJoApz4DxBr15HhMmhvrkfaX+MQwguHpxKk4nXOKmk28x7otvZp8nzgQQ/XVLouge0nSIpAsRjVjYBXPY9e3TxaqDe141aABET6Rbt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so7291737a12.1;
        Mon, 04 Mar 2024 23:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709623169; x=1710227969;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+1baBckT7OXImwCfZaZCxZUfFd5GSKEsCREenSuOjg=;
        b=GFQn8viwuehVmvHuHEOdfbPmw7DHwBh58QPaZPfdCixzI6LbcfXdsXfJIJjO9T07PD
         0fZAq/Zr5RH31YiVem6viM7T+25xPK45PmKK4wTK69ccrRK9S/Sy5nLVkaGhraY0Hr7x
         YLBcr48KHfCMhePi+9iQO/GMnyxnmod9X81/UR0u6WAaq9xo/OU+5cJh8eCNe+nNoo71
         J0jUl5mt/2GG7JxJ5xPdii/KmT2GZPiCBA3Si6om404RxsDKj5C0IBEePV3L4Km66gte
         1OPyab34/Wag8zSA0CPFUbxRqAUC5SioUIeGvkUePGR3g08zZYzb2YS+iWsGw/7GNPpI
         WJpA==
X-Forwarded-Encrypted: i=1; AJvYcCVYCMt9iLUZVHaEaobwWUnd/Dn5/hNQylrv98HC+LOPqMbRyoaxtudfAx7kPyFVCan6H0IZhMGSBWgBy0V91M0WuKK2kHQ6RWo0q+B4ybDPCBERryPKWU49eGVdAb5dNhQnJ8yhHfXr6wNO
X-Gm-Message-State: AOJu0Yz7tLsk4T1NBB1R9AthHle3JR7483SiTRAs0gyhrO43J4kD7RCS
	W4kNXUhBQb6aEEWCf0N1zvid6Ls7xPj0TNrozYY+idezsl10HRBzyqe2+ltE
X-Google-Smtp-Source: AGHT+IHclhwaEt9hqmjKLRPcvn6J4CM61NaIoNux57lWnJWK6Hq57lryW1XeTdc4g/QchZ+JMkZFWw==
X-Received: by 2002:a17:906:37d6:b0:a45:f05:7e10 with SMTP id o22-20020a17090637d600b00a450f057e10mr4497803ejc.24.1709623168600;
        Mon, 04 Mar 2024 23:19:28 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709063e1700b00a42f6d48c72sm5766587eji.145.2024.03.04.23.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 23:19:28 -0800 (PST)
Message-ID: <1cc70895-b520-4dde-971e-692041dfbcce@kernel.org>
Date: Tue, 5 Mar 2024 08:19:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code
 to use pre-existing APIs
Content-Language: en-US
To: Rengarajan.S@microchip.com, linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org, Kumaravel.Thiagarajan@microchip.com,
 UNGLinuxDriver@microchip.com, Tharunkumar.Pasumarthi@microchip.com,
 linux-kernel@vger.kernel.org
References: <20240222134944.1131952-1-rengarajan.s@microchip.com>
 <5bf4ba6d-d8e3-4ba6-a889-cfae8c3ddabe@kernel.org>
 <e93048e64c3f8aa2731575d4b296c473e8dadb82.camel@microchip.com>
 <254db026-5f9d-497f-ac44-c81d9d5947cf@kernel.org>
 <53dd0d89466f0f06dfd2d63ab1ff29462a09aabb.camel@microchip.com>
 <e8b49c34-90a1-4610-b7cd-8eff1b1a312a@kernel.org>
 <f3b627f1d03c8db3d09f56a836e8733004b2287b.camel@microchip.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <f3b627f1d03c8db3d09f56a836e8733004b2287b.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05. 03. 24, 5:15, Rengarajan.S@microchip.com wrote:
> Hi Jiri,
> 
> On Mon, 2024-03-04 at 07:19 +0100, Jiri Slaby wrote:
>> [Some people who received this message don't often get email from
>> jirislaby@kernel.org. Learn why this is important at
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>
>> On 04. 03. 24, 5:37, Rengarajan.S@microchip.com wrote:
>>> Hi Jiri,
>>>
>>> On Fri, 2024-02-23 at 10:26 +0100, Jiri Slaby wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>>> know the content is safe
>>>>
>>>> On 23. 02. 24, 10:21, Rengarajan.S@microchip.com wrote:
>>>>> On Fri, 2024-02-23 at 07:08 +0100, Jiri Slaby wrote:
>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless
>>>>>> you
>>>>>> know the content is safe
>>>>>>
>>>>>> On 22. 02. 24, 14:49, Rengarajan S wrote:
>>>>>>> Updated the TX Burst implementation by changing the
>>>>>>> circular
>>>>>>> buffer
>>>>>>> processing with the pre-existing APIs in kernel. Also
>>>>>>> updated
>>>>>>> conditional
>>>>>>> statements and alignment issues for better readability.
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> so why are you keeping the nested double loop?
>>>>>>
>>>>>
>>>>> Hi, in order to differentiate Burst mode handling with byte
>>>>> mode
>>>>> had
>>>>> seperate loops for both. Since, having single while loop also
>>>>> does
>>>>> not
>>>>> align with rx implementation (where we have seperate handling
>>>>> for
>>>>> burst
>>>>> and byte) have retained the double loop.
>>>>
>>>> So obviously, align RX to a single loop if possible. The current
>>>> TX
>>>> code
>>>> is very hard to follow and sort of unmaintainable (and buggy).
>>>> And
>>>> IMO
>>>> it's unnecessary as I proposed [1]. And even if RX cannot be one
>>>> loop,
>>>> you still can make TX easy to read as the two need not be the
>>>> same.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/all/b8325c3f-bf5b-4c55-8dce-ef395edce251@kernel.org/
>>>
>>>
>>> while (data_empty_count) {
>>>      cnt = CIRC_CNT_TO_END();
>>>      if (!cnt)
>>>        break;
>>>      if (cnt < UART_BURST_SIZE || (tail & 3)) { // is_unaligned()
>>>        writeb();
>>>        cnt = 1;
>>>      } else {
>>>        writel()
>>>        cnt = UART_BURST_SIZE;
>>>      }
>>>      uart_xmit_advance(cnt);
>>>      data_empty_count -= cnt;
>>> }
>>>
>>> With the above implementation we are observing performance drop of
>>> 2
>>> Mbps at baud rate of 4 Mbps. The reason for this is the fact that
>>> for
>>> each iteration we are checking if the the data need to be processed
>>> via
>>> DWORDs or Bytes. The condition check for each iteration is causing
>>> the
>>> drop in performance.
>>
>> Hi,
>>
>> the check is by several orders of magnitude faster than the I/O
>> proper.
>> So I don't think that's the root cause.
>>
>>> With the previous implementation(with nested loops) the performance
>>> is
>>> found to be around 4 Mbps at baud rate of 4 Mbps. In that
>>> implementation we handle sending DWORDs continuosly until the
>>> transfer
>>> size < 4. Can you let us know any other alternatives for the above
>>> performance drop.
>>
>> Could you attach the patch you are testing?
> 
> Please find the updated pci1xxxx_process_write_data
> 
> 	u32 xfer_cnt;
> 
>          while (*valid_byte_count) {
>                  xfer_cnt = CIRC_CNT_TO_END(xmit->head, xmit->tail,
>                                             UART_XMIT_SIZE);
> 
>                  if (!xfer_cnt)
>                          break;
> 
>                  if (xfer_cnt < UART_BURST_SIZE || (xmit->tail & 3)) {

Hi,

OK, is it different if you remove the alignment checking (which should 
be correct™ thing to do, but may/will slow down things on platforms 
which don't care)?

>                          writeb(xmit->buf[xmit->tail], port->membase +
>                                 UART_TX_BYTE_FIFO);
>                          xfer_cnt = UART_BYTE_SIZE;
>                  } else {
>                          writel(*(u32 *)&xmit->buf[xmit->tail],

If you remove the "tail & 3" check, you can use get_unaligned() here and 
need not care about unaligned accesses after all...

>                                 port->membase + UART_TX_BURST_FIFO);
>                          xfer_cnt = UART_BURST_SIZE;
>                  }
> 
>                  uart_xmit_advance(port, xfer_cnt);
>                  *data_empty_count -= xfer_cnt;
>                  *valid_byte_count -= xfer_cnt;
>          }
> 
> Testing is done via minicom by transferring a 10 MB file at 4 Mbps,
> 
> After the minicom transfer with single instance:
> 
> Previous implementation(Nested While Loops):
> Transferred 10 MB at 3900000 CPS
> 
> Current implementation:
> Transferred 10 MB at 2459999 CPS



-- 
js
suse labs


