Return-Path: <linux-kernel+bounces-1419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76438814EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9671C2094B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A7882ECC;
	Fri, 15 Dec 2023 17:26:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E330103;
	Fri, 15 Dec 2023 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c60dfa5bfso10695795e9.0;
        Fri, 15 Dec 2023 09:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702661195; x=1703265995;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnBMaI9OwEyge6LD3Y7W4/plP/FrjCIL4hFBnIukh68=;
        b=qPJkQlMj4whP7cD1PsowV69Nt1v2+M4m6ke06mKkOTqZHdCVBsS5Ef5DOAASf+NIxq
         O19ZqQXcE4BKZhMVuvS/17tAh8T04EPctgqN3wPuZeroPeKmVulyPpbhl/b5KCEYdnH0
         kv4tSv3AZNmEaPs+KgF08UhS+wvRecIBLI4j86VbTP9tZP8KpR748VCyxdvXHPhn2HFL
         eRl7DL/BxfB+K4obMGa7rOR3hYHLjUGwEMvQrRinEoMDTIjNvMiowmVp3yg1K7+Temn+
         DQZND0xQyLWQREWKRNfL1vJurHqjqTvGdXZ97u11qVlVjnvHt3ptYYWpRm+5PnTaykGl
         jPPQ==
X-Gm-Message-State: AOJu0YxhJonRs4pY22SU1ICGchmZCmADhlw2KbQMIphlEJg4Yo82dXN/
	UxZZ+YlLH4NTaHbnDtx4fkE=
X-Google-Smtp-Source: AGHT+IFV8EUEhJ47Hm2OtL4qGNldn3VBw4rF2JFCIvJ4HyDByOPZZsFjzD7KnqtaqgYaVXajD0rcXQ==
X-Received: by 2002:a05:600c:5189:b0:40c:3f25:83ba with SMTP id fa9-20020a05600c518900b0040c3f2583bamr5561415wmb.187.1702661194736;
        Fri, 15 Dec 2023 09:26:34 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:57? ([2a0b:e7c0:0:107::aaaa:57])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c4f0c00b0040b4b2a15ebsm29963754wmq.28.2023.12.15.09.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 09:26:34 -0800 (PST)
Message-ID: <6401ff24-c82d-4d69-9aaf-b219af9d4db9@kernel.org>
Date: Fri, 15 Dec 2023 18:26:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: Add comments for tty-ldisc module loading logic
Content-Language: en-US
To: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
 Zijun Hu <quic_zijuhu@quicinc.com>, gregkh@linuxfoundation.org,
 quic_qiancai@quicinc.com, quic_arandive@quicinc.com,
 quic_saipraka@quicinc.com, quic_eberman@quicinc.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1702640236-22824-1-git-send-email-quic_zijuhu@quicinc.com>
 <1702647690-6787-1-git-send-email-quic_zijuhu@quicinc.com>
 <de1181fe-a948-a1e2-04c8-dcd88085f1df@quicinc.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <de1181fe-a948-a1e2-04c8-dcd88085f1df@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15. 12. 23, 15:19, Vijaya Krishna Nivarthi wrote:
> Hi,
> 
> 
> On 12/15/2023 7:11 PM, Zijun Hu wrote:
>> Current tty-ldisc module loading logic within tty_ldisc_get()
>> is prone to mislead beginner that the module is able to be loaded
>> by a user without capability CAP_SYS_MODULE, add comments to make
>> the logic easy to undertand.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>> Changes in v2:
>> - Remove condition checking changes
>>
>>   drivers/tty/tty_ldisc.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
>> index 3f68e213df1f..34526ffaccbc 100644
>> --- a/drivers/tty/tty_ldisc.c
>> +++ b/drivers/tty/tty_ldisc.c
>> @@ -150,6 +150,10 @@ static struct tty_ldisc *tty_ldisc_get(struct 
>> tty_struct *tty, int disc)
>>        */
>>       ldops = get_ldops(disc);
>>       if (IS_ERR(ldops)) {
>> +        /*
>> +         * Always request tty-ldisc module regardless of user's
>> +         * CAP_SYS_MODULE if autoload is enabled.
>> +         */
> 
> Without much knowledge of this file...
> 
> 
> What the if condition below accomplishes is evident,

After a bit of thinking, sure.

> it probably doesn't require a comment.

I would not add a comment there at all. I would rewrite the code so it 
is obvious to everyone. Like:

static inline bool tty_ldisc_can_autoload(void)
{
   return capable(CAP_SYS_MODULE) || tty_ldisc_autoload;
}

And then:
if (!tty_ldisc_can_autoload())
   return ERR_PTR(-EPERM);

> A more useful comment would be why it does so?

 From an insider, the reason is obvious. But maybe not so much for 
newcomers. Well, one could document the new inline above. Like:
""
We allow loads for capable users or when autoloading is explicitly enabled.
""
or alike...

thanks,
-- 
js
suse labs


