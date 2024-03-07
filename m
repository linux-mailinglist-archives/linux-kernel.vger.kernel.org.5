Return-Path: <linux-kernel+bounces-95328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D513E874C58
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 071C0B21196
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6648526C;
	Thu,  7 Mar 2024 10:25:22 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455B82D83
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807122; cv=none; b=Mim4uqxnVP0S3HNJzMmK1dE5w1m2zOt7KtAyEghXQXStYSEjWEHu+/tYk3dHjYHkzLtU46ihutLsrDlCO9z5veqpeKA3ApO/9Za4mqi6IregRXfTezkeAC4ntS8Y1aW2hr6T6rji5Rr/38kpt0LJXYqJJwzv1HEVG3Ry8TgtSAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807122; c=relaxed/simple;
	bh=LMPDBjPzV/03FWcMVBmr1R3CkjP83OSAXDFLuj0Xg6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOw55r7P77zSOQv9MKXB06X+ad6E6cLRslXflrenE53ln+5NSOR8UFCIVouw9Ohk7jg9/+rXhuLCtKMXq/1SH2ouLI0wsaUN1NRHJHQLgSzksbY/XSSgCGRydqhRGo0rz+nqTeWV8vme15JSVn5P+O9kPFvsRjJ7lQxpMO8gkuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33db19538d0so169988f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 02:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709807118; x=1710411918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LX71Wf074V1/LsC8TNu4ogtheEle/1fxXGYHlIyeoVo=;
        b=rapGnbgEEXlntUAxDLEe67kcFcFtcwYrRt2GabA6XenAipDthf79ETlSpDJVT/q2dO
         QeUZdCHjH9nmdPbqBIcfMXIfoR5zs4kFGcilKw5R0/rLABIbQQD6pamDECCXN/5986f3
         p+xCAdbkmKMQNGAsGSAzV2N83t224zcoEBParntDKAbkkPvuGFcvHdZw+GxFM0cT0Q1i
         jGHNdXS2FOkMOKhEZd4NFYS20Mw8bw2GwH/YfqCq3j/0wE8hGerFkMQw/cGkzpExiclB
         6d7iDEw+RIS435aoEfltXyYUOjXDgCxCPtqwyyeNXKDwLHPvQAMEvL053hMrwpV9yRkW
         wtYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/SlasBJljvz2mibTZclg8RrDpCrDnoZ7JJsKVKOLzbt9Ac3nzwmYAHg4cf3ECg0czlbn7UPwnun7ZMbhCesNdyDb4g8mTZbLnKCLI
X-Gm-Message-State: AOJu0YwKLvorqMi2+az6sbOCRDbLPww4ZVHDYWo5j+qfhkutYcywrUh+
	4Xj79hXPyuQ03vmLQs0dtQFuAsQDH+eu2vkyjZASNZQJKzuXjQbK
X-Google-Smtp-Source: AGHT+IGrxxiU6KmuJ1vc+U5CzL+knJ39wPcNZ/oyZhgYKvZD0scHVdJSNfxfSv1d7eLKlT5APcZ6zw==
X-Received: by 2002:adf:fe4f:0:b0:33e:55e8:5319 with SMTP id m15-20020adffe4f000000b0033e55e85319mr1200107wrs.2.1709807118353;
        Thu, 07 Mar 2024 02:25:18 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id r12-20020adfe68c000000b0033df5710fabsm19854052wrm.44.2024.03.07.02.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:25:18 -0800 (PST)
Message-ID: <83bca01f-fc34-405b-9f2e-8079130400ce@grimberg.me>
Date: Thu, 7 Mar 2024 12:25:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or
 connection is refused
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-3-dwagner@suse.de>
 <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
 <sqmla42yoidail73xukhxb6uoyayo66pxpdlrhns3v533wm7wy@ppyr7t5gk3u3>
 <609e0031-e97c-466b-8cbd-47755374b117@suse.de>
 <3xhhdconprn3vvkky4yj4iazku4eiqxl6l6rw6z5tivvdjwaby@ts7satqbih7w>
 <hxr2hztb64dank3jvbnrlciaebo4k2qkkrg3brhrppizeyelpo@ewupxurl7iqm>
 <5d67a55e-e979-4c3c-8dcc-597cb13c7c9d@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <5d67a55e-e979-4c3c-8dcc-597cb13c7c9d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/02/2024 13:58, Hannes Reinecke wrote:
> On 2/22/24 18:02, Daniel Wagner wrote:
>> On Thu, Feb 22, 2024 at 08:45:04AM +0100, Daniel Wagner wrote:
>>> On Thu, Feb 22, 2024 at 07:46:12AM +0100, Hannes Reinecke wrote:
>>>> On 2/21/24 17:37, Daniel Wagner wrote:
>>>>> On Wed, Feb 21, 2024 at 04:53:44PM +0100, Hannes Reinecke wrote:
>>>>> In this case yes, I've tested on top of this patch. This breaks 
>>>>> the loop
>>>>> where the provided key is invalid or is missing. The loop would happy
>>>>> retry until reaching max of retries.
>>>>
>>>> But that's to be expected, no?
>>>
>>> Why? If the key is wrong/missing it will be likely wrong/missing the
>>> next retry again. So what's the point in retrying?
>>>
>>>> After all, that's _precisely_ what
>>>> NVME_SC_DNR is for;
>>>> if you shouldn't retry, that bit is set.
>>>> If it's not set, you should.
>>>
>>> Okay, in this case there is a bug in the auth code somewhere.
>>
>> With the change below nvme/041 also passes:
>>
>> modified   drivers/nvme/host/fabrics.c
>> @@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>>           if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>>               dev_warn(ctrl->device,
>>                    "qid 0: secure concatenation is not supported\n");
>> -            ret = NVME_SC_AUTH_REQUIRED;
>> +            ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>               goto out_free_data;
>>           }
>>           /* Authentication required */
>> @@ -475,7 +475,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>>           if (ret) {
>>               dev_warn(ctrl->device,
>>                    "qid 0: authentication setup failed\n");
>> -            ret = NVME_SC_AUTH_REQUIRED;
>> +            ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>               goto out_free_data;
>>           }
>>           ret = nvme_auth_wait(ctrl, 0);
>> @@ -540,8 +540,9 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, 
>> u16 qid)
>>           /* Secure concatenation is not implemented */
>>           if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>>               dev_warn(ctrl->device,
>> -                 "qid 0: secure concatenation is not supported\n");
>> -            ret = NVME_SC_AUTH_REQUIRED;
>> +                 "qid %d: secure concatenation is not supported\n",
>> +                 qid);
>> +            ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>               goto out_free_data;
>>           }
>>           /* Authentication required */
>> @@ -549,7 +550,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, 
>> u16 qid)
>>           if (ret) {
>>               dev_warn(ctrl->device,
>>                    "qid %d: authentication setup failed\n", qid);
>> -            ret = NVME_SC_AUTH_REQUIRED;
>> +            ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>           } else {
>>               ret = nvme_auth_wait(ctrl, qid);
>>               if (ret)
>>
>> Is this what you had in mind?
>
> Which, incidentally, is basically the patch I just posted.

Reading this, the patchset from Hannes now is clearer.
Isn't the main issue is that nvme-fc tries to periodicly reconnect
when failing the first connect? This is exactly what the test expects
it to do right?

