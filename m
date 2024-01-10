Return-Path: <linux-kernel+bounces-21621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ED6829205
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D771C24F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143F2184E;
	Wed, 10 Jan 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BbGec+94"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8261370
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4298a0d5922so20965541cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 17:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704849641; x=1705454441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jhu83ztv7XXs80gemSpj46lzPwgn/FbZO9oPLX9bC0s=;
        b=BbGec+941hc7LSsKf9+w8pHUBJ/4jBrc30e1HJDblVjdI49suUDSK79jKLRUbmn/qx
         h8uXUqhkbh++t0iPkGLcgVjrHjiXsOZG2YPxBuBgZWWrNJb64FibRKZcRyFIiZs0dDsT
         sodwmwF/j7cRYjXabMpOsC0KnhywnQsxQLGXcyjcnyCd/ep3SxKBsoq4dDkkv0VjbKRy
         +0XOa405U2qH0vr621EEYflaSpkpZZxPE4za195nn8HM6GlNbeill1WhiRK3e4Jyd7Ql
         QxZ1fqeOVegyk3lLVUdh8S7C8ZkpQuIIAZOfnMZtMVEFWx5Zn4+hGoClV+HKTXIy9aDY
         1NeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704849641; x=1705454441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhu83ztv7XXs80gemSpj46lzPwgn/FbZO9oPLX9bC0s=;
        b=Sr4+3xmk99iopOhH3rPlIikT/6wFPVs+33KJibHPNWj7uYfZyFEAscU0rWqcck/FGf
         EANhak+gAnVkBy2wwcAN47p9ICh2r2O5mrK+09bQ16wGd47R5ZrqiIyNll/k7tsWgb7x
         KceE/+jsir4WRdXA2jnwiT4CSq5EkrRSOh4XAAZZB1rizWgq1SiAp+ECDHRVTGKXAUAp
         StKsIBJYj+hAjHC3Yp4uUgtKxeUIJJu10kINc0J44rSWjyybBmeLBtzULHBnmvpeBbOL
         MNXpCQg51OGaxZVToP1VzASWm0mfDqmEpuxD4qJePqtdNhdG1/9uV+CMBccejxRyP9Fh
         pqxA==
X-Gm-Message-State: AOJu0YwajM75QVa8t+/jnNby/lRCspzQhbamsR3feS6h9xsZoJbZp4HJ
	8I4hNp3/TGXryW/yF6rSpq30tLovro9X
X-Google-Smtp-Source: AGHT+IG3JthpmzCroC79trKvWI51SpB4a24Au9kwhxC6XFa/JxcHMi9dnIvijTd0pSJeo9YOosWPUw==
X-Received: by 2002:a05:622a:34a:b0:429:ae87:6609 with SMTP id r10-20020a05622a034a00b00429ae876609mr459829qtw.49.1704849640872;
        Tue, 09 Jan 2024 17:20:40 -0800 (PST)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id h9-20020ac85689000000b004283595941csm1356094qta.24.2024.01.09.17.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 17:20:40 -0800 (PST)
Message-ID: <f1e86357-4728-43fa-a2d0-e0041415c9f1@google.com>
Date: Tue, 9 Jan 2024 20:20:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add inline assembly
 helpers to access array elements
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20240103185403.610641-1-brho@google.com>
 <20240103185403.610641-3-brho@google.com> <ZZa1668ft4Npd1DA@krava>
 <f3dd9d80-3fab-4676-b589-1d4667431287@linux.dev>
 <e5e52e0a-7494-47bb-8a6a-9819b0c93bd8@google.com>
 <781a86b1-c02b-4bb8-bc79-bfbd4f2ff146@google.com>
 <CAADnVQ+BOBh-XnsCPWHUCkwhAe41TxPRm9Nqi2r39WnJh3iF6g@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <CAADnVQ+BOBh-XnsCPWHUCkwhAe41TxPRm9Nqi2r39WnJh3iF6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/24 20:06, Alexei Starovoitov wrote:
> This is a known issue.
> It's addressed as part of Maxim's series:
> https://patchwork.kernel.org/user/todo/netdevbpf/?series=815208

great.  feel free to drop my patch.  but hopefully people find it useful 
in their own programs until maxim's series is widely available.

i'll keep using them for the time being, since the "spill before 
verifying" was just one of many things i've seen.  that, and it takes me 
a while to get new kernel features in production.  =)

thanks,

barret



