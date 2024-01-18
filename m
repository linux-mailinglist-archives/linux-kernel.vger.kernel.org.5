Return-Path: <linux-kernel+bounces-30557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D757283206E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4E31F25096
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBC32E83D;
	Thu, 18 Jan 2024 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mskg0gi6"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88DD2E657;
	Thu, 18 Jan 2024 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609267; cv=none; b=U38Z+M/9//LfE7uhxg6adh7dSJn/AGcAKAg8kU66+y59dVpW2FrZ39+mN40rCqwADW3FlSucDIbTSlz9nHZWn4B5+Z/SOXvlGQ0Wq4cfsqHId9pUuKMwY05fRi4yPfEmFSA7zdaq25xmc/6GcZPljQXS3ZNv/Fvq0jvK3vmNLOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609267; c=relaxed/simple;
	bh=A+sDgBWxWmMWbOK9CH13QLvCtmTIP6OXbPS4uCAFh3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krxVS/rd7d7Ufq29dsEUDo449Ybq3EwkprksP/eaFaiIu2hcYBuxfAFZyiiNEj3CQjtvypoQTxvJW/62cthCATbUI/tiWvfnuEb3fZao0kgbOvE59SyiiOUR1u5O+y7H9SfdmYNLB7CDgHxsrHyQJ0p7FWeFm1RM9Gs/mnsXFnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mskg0gi6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9cdd0a5e6so94176b3a.3;
        Thu, 18 Jan 2024 12:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705609265; x=1706214065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZ9pZpCAzsJnyZjUQhh/duwy73BtRwk7HFO6DtWYWZU=;
        b=mskg0gi6qwMrAi2R6xh2s4mSwPO6YmvU15/O5VBZITYgYhEqEMsXjCTlAPvS4ZKWmT
         W16OAbVn86AStoRo0beigLDweyAHHHA62hzcstOyz78NF56qlYR8H6oWzny0aXc+CS1a
         ErJ+o66yDyr83IS9FqKO+CoFYVhAm6ttRzBWqdrfJPwBtmv//J82C6pVc7hZQ99Gf2Iu
         0yroKvEWmhDB7Lc5CnhgNAY7xW4upb+hRK5VWvJHVSpD6bkEbv5/Zb5jF4wxj+/+KY7z
         KOeccFGzAa8hfCalR9MBx6U7dx9UCn43FFepI27flMrbgX8yY3XRoviQIkdJVnDpc/OL
         7BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705609265; x=1706214065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ9pZpCAzsJnyZjUQhh/duwy73BtRwk7HFO6DtWYWZU=;
        b=oMi4qrYv3DN9LvGLN8b2jL1yhUYfcKZs19JH6CKAO/OOJhA1wq0HvqnXG7hC2o+E0P
         0nfBsGxxnCrzWupnqlElXeXRRuCh3N6OuDLV80JZLDXhnYjYOBbmctp94wVoBMtEVDE/
         B37phca01ued6Nft6/X9JHUDllDrySH+/UPTYi05kPR03xvu/qRnEc9a78VBPlowbNb9
         YTco3I+f0Quz50YWKU41TozkwXzWATu82PL2ZiqQ6WNipmm+n2I5SPbesSXMCAnxkQdr
         wvEZlVCulLT8swf9YupSG4uyNxwRt/PeUhozAXfYZN3HhJ6mribJP7uMOvRBZ1WsNBW4
         G7fw==
X-Gm-Message-State: AOJu0YwoyndUFBPMWRVuMevGr2jcLyuXvkKSQavYrqynaJorBqaWaIPE
	jn2q+gtOPkduAoxSecxbBZ6aVXNzsTv1aD7uTAJ5AErWwhLBxZR6
X-Google-Smtp-Source: AGHT+IH9atTBPry6zGhjvZkxevU6L3eia12NqM5JUMvS4WYiKqaKHiaQNlqsGdVUzJod4zwoXb+xkg==
X-Received: by 2002:a05:6a00:3993:b0:6db:b9fa:ec2b with SMTP id fi19-20020a056a00399300b006dbb9faec2bmr408772pfb.62.1705609265105;
        Thu, 18 Jan 2024 12:21:05 -0800 (PST)
Received: from [192.168.0.228] (c-24-20-51-242.hsd1.or.comcast.net. [24.20.51.242])
        by smtp.gmail.com with ESMTPSA id a19-20020aa780d3000000b006daf1ded817sm3695296pfn.209.2024.01.18.12.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 12:21:04 -0800 (PST)
Message-ID: <9f246fbc-b2e4-4585-912d-a5a00ac8cd04@gmail.com>
Date: Thu, 18 Jan 2024 12:21:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: ibmvscsi_tgt: replace deprecated strncpy with
 strscpy
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
Cc: Michael Cyr <mikecyr@linux.ibm.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231212-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v2-1-bdb9a7cd96c8@google.com>
 <202312121321.E15E09BF@keescook>
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
In-Reply-To: <202312121321.E15E09BF@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/23 13:23, Kees Cook wrote:
> On Tue, Dec 12, 2023 at 01:20:20AM +0000, Justin Stitt wrote:
>> strncpy() is deprecated for use on NUL-terminated destination strings
>> [1] and as such we should prefer more robust and less ambiguous string
>> interfaces.
>>
>> We don't need the NUL-padding behavior that strncpy() provides as vscsi
>> is NUL-allocated in ibmvscsis_probe() which proceeds to call
>> ibmvscsis_adapter_info():
>> |       vscsi = kzalloc(sizeof(*vscsi), GFP_KERNEL);
>>
>> ibmvscsis_probe() -> ibmvscsis_handle_crq() -> ibmvscsis_parse_command()
>> -> ibmvscsis_mad() -> ibmvscsis_process_mad() -> ibmvscsis_adapter_info()
>>
>> Following the same idea, `partition_name` is defiend as:
>> |       static char partition_name[PARTITION_NAMELEN] = "UNKNOWN";
>> ... which is NUL-padded already, meaning strscpy() is the best option.
>>
>> Considering the above, a suitable replacement is `strscpy` [2] due to
>> the fact that it guarantees NUL-termination on the destination buffer
>> without unnecessarily NUL-padding.
>>
>> However, for cap->name and info let's use strscpy_pad as they are
>> allocated via dma_alloc_coherent():
>> |       cap = dma_alloc_coherent(&vscsi->dma_dev->dev, olen, &token,
>> |                                GFP_ATOMIC);
>> &
>> |       info = dma_alloc_coherent(&vscsi->dma_dev->dev, sizeof(*info), &token,
>> |                                 GFP_ATOMIC);
>>
>> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
>> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> This looks good to me. The only question that I haven't seen an answer
> to from the maintainers is whether this is a __nonstring or not. It
> really looks like it should be a C String, so with that assumption:

To reaffirm the assumption, as I mentioned in my response to v1 these are
intended to be handled as C strings.

Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -Kees
> 


