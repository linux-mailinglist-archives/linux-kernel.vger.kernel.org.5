Return-Path: <linux-kernel+bounces-68884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBFB858161
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04211F20172
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CBB1487D1;
	Fri, 16 Feb 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+6Caqnp"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326314830D;
	Fri, 16 Feb 2024 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097464; cv=none; b=bZS3HTHJqydgvkJjS3nzLprafwyv3bDd0/4PVLYnrzrC42Spkw8FgLPSeQ4qGuDaLhyw/fZcG8O2JKMq2gkFxlgWcmuvYOJiStUZlvVhjl8ayWUzx0lvRKKu/rxH97bk9yeEwlXFMCUDPOLn6vIIIfxajF95E94nLtk3LYvVafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097464; c=relaxed/simple;
	bh=2bBhhj/QaqwbzNPHueTQmD9VG87w9Epku43Ofb/Leug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0OYLcVrDCwr2+E3w46v1AiI4mhm4Azo2B3oFA8DKr85Dp0Djph7H3khwXL8fJtgHot8O3D0+b2y92OwnPHh+d7rLotsWqYVvf4KfLmG6/bw7US54OaqsWEYH69HLFSEv7jj2pk9XZKJ81Wiomgb1loayS0IWAV1S+ukAoyXzVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+6Caqnp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4121b1aad00so5804065e9.1;
        Fri, 16 Feb 2024 07:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708097461; x=1708702261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JNadx/71R49yGFH6Dmy90ffsy+AmiQ1eqphcJgygK8=;
        b=H+6Caqnpr4JKH0NM177DYXNXXuWSELz4HbabZ6CFl/SsEbmqVSQcDxSLGBIRLdPgoy
         ldfkLN3h6DBfa5LWU7iYAHVURWXP8nGJ2quUaamTO+na/5Gk+Sh5Z1DvVu7KOAfvhPes
         D+aIKbTm4t2lFKutlIZ7/OlPi3bsQ6ks6fqulBi6QbKM2dxclp9nFo6ilH9h5xemw24z
         Q8yoDaYpinzd+WMj4wPf5Zasg6+fQFZWOxz65j0HEab+PY6kwtd0kyqBpu8l+EsMbHQ9
         dauOLFIfJHBSMPlFQWQCki88mX98pDVQxYSEn/R2wzof0GdpCCHRHsxHWtKgPbrQiX7+
         fyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708097461; x=1708702261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JNadx/71R49yGFH6Dmy90ffsy+AmiQ1eqphcJgygK8=;
        b=L5Sbf3n6Pek2r7hmu6vMcc+QrxYJLVp/yxiY6t5qVjxYAeJ/vuOB/6ChxjljdSIB3D
         MbVDy3/i1KBIPKy48drkiN08BDmj+dvpnpS0NMRXzC5r7z9JAz/+fKPzcVfLHCJzhS6a
         oFSa2CZV/3+Zyo2PU7oXAGF2DmnOTiCrHev1fJg2tm+bna4du7hgrCLCoMLf6A4TgSO6
         jcgZQBAmtaGI/yEWyhd+jPK3SZyG46qU1xlO4CgCOD26Gbxkd0qLUYfzS6j9RYeaLqSL
         kS5LfASyHeVADNyfoqRDvq8lKSisx1VbsNyBMdHPM/PkYnvc57XqapNkED62AnkLuubA
         B/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJO18DGbwXUjVnPbHGkYv/2oQHzoeRgH3qkQR+RqE8bC5KDKuVcWaGd9ZWn0D9pvNvfDyYrrXF+VXO/oxUVnM744ObKWZUOzlhEdxHKtaBnN00a+g05rEsNq4HJIFPUeibkrSWLn6uD28pVOgTdLUNcsa+ue8OioQhzb6FZ7bpiPYhBYFg
X-Gm-Message-State: AOJu0Yykh4d3fb8RCwTHW2KmOm6BiktSgMwsv+H/gmq6aFrCsDcHFsZT
	mjJPa3J1NJk0DL391xbOj4ZabSLTjPgc4JAOMqXESo+XnjR0G7Jr4JWhwSBE
X-Google-Smtp-Source: AGHT+IFrhxmizJLaTT2UDH3EzhKGyyUFsHaJBJRaLK/lgAJlamqvdLFCtTuza/WnM3XQMaZjsZ2J7w==
X-Received: by 2002:a5d:6350:0:b0:33d:27b6:68d1 with SMTP id b16-20020a5d6350000000b0033d27b668d1mr53556wrw.34.1708097460716;
        Fri, 16 Feb 2024 07:31:00 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600016c500b0033d200aff9asm1769437wrf.56.2024.02.16.07.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 07:31:00 -0800 (PST)
Message-ID: <4f3bc406-1671-4f37-98e4-38e00590f487@gmail.com>
Date: Fri, 16 Feb 2024 15:30:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net: tcp: Remove redundant initialization of
 variable len
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>
References: <20240216125443.2107244-1-colin.i.king@gmail.com>
 <CANn89iJM=fVSkzz9HRU+HXYm+R+owKqah0TT8sY-soEXf2HiNA@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
In-Reply-To: <CANn89iJM=fVSkzz9HRU+HXYm+R+owKqah0TT8sY-soEXf2HiNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/16/24 13:00, Eric Dumazet wrote:
> On Fri, Feb 16, 2024 at 1:54 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>>
>> The variable len being initialized with a value that is never read, an
>> if statement is initializing it in both paths of the if statement.
>> The initialization is redundant and can be removed.
>>
>> Cleans up clang scan build warning:
>> net/ipv4/tcp_ao.c:512:11: warning: Value stored to 'len' during its
>> initialization is never read [deadcode.DeadStores]
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

LGTM,

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

>> ---
>>  net/ipv4/tcp_ao.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
>> index 87db432c6bb4..3afeeb68e8a7 100644
>> --- a/net/ipv4/tcp_ao.c
>> +++ b/net/ipv4/tcp_ao.c
>> @@ -509,9 +509,9 @@ static int tcp_ao_hash_header(struct tcp_sigpool *hp,
>>                               bool exclude_options, u8 *hash,
>>                               int hash_offset, int hash_len)
>>  {
>> -       int err, len = th->doff << 2;
>>         struct scatterlist sg;
>>         u8 *hdr = hp->scratch;
>> +       int err, len;
>>
>>         /* We are not allowed to change tcphdr, make a local copy */
>>         if (exclude_options) {
>> --
>> 2.39.2
>>
> 
> Cc Dmitry Safonov
> 
> Dmitry, can you take a look ?

Thanks for Cc'ing!

> 
> Thanks !

Thanks,
             Dmitry


