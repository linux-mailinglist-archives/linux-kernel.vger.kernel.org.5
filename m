Return-Path: <linux-kernel+bounces-5152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AE2818736
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDC31F2493A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF6D1799A;
	Tue, 19 Dec 2023 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="RAneCU9w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE31199AD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso180347a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702988199; x=1703592999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdERbfWd8axs3o2A8KOivOOsBTH7eU7jDtQCQU5TR64=;
        b=RAneCU9wXoqkp9sJKB3vJwk+9/S5DscO15PpEqNV94MOxjOqcGkbmJq92FLtm07lf1
         btXH/h2kapHoettWj7tXmDhw8BybJ3HwzCFMIYT3KB0nAAR1TwaP96hFHo0vF9GsGt+w
         SMjITtrm39RTTdE/UTAmaNAu6Fee/tYjvknt3QHI5vYw2HiTc5d0mUDpgNidFidPUUR3
         2DVAxwx3hZ1Opa9qTJl64XXAQvgzGSezCQPKoomV/OTK6Pt6gX71ng0zBC0FVrR3xUqC
         2vdZ4Toauj1JoRWM48Ba+HC3+dJNA6VFdA8yn7HIhjdmQIyLIvy23etcwNDXmP3k9WTD
         8NsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702988199; x=1703592999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdERbfWd8axs3o2A8KOivOOsBTH7eU7jDtQCQU5TR64=;
        b=ZX6Gb9gnZud9UnzKQB2StvSOB+FC1hrdLIE72SbHOGEtPrNgb8TCJkJRR9Ph1G2vGY
         a2qmrcMdYGVQ+1hITcXWlUp+B2AxqXu3NDmXFCb5u5q/UgfWkfpgfh61ZWq0w1fDq05R
         33iFdp9II8s5SwDc+kIq0ec58ajZqdZO/ThITjFEv9+TemVvEQ6T/rYudMD1ZOXg6mPP
         lhWBC0zEVcJtEMMc3czRn7sRRbhVgM1R1DsB37EIk9oI2Khz6nFZ425YcEecJgkTMyN0
         kLzZ7zY+Bd3DwpH2M+5cirJpvZMo7V8la2vRAzuwnYkVC9JXMQJak1z5BVqa8wxzqyK7
         +qew==
X-Gm-Message-State: AOJu0Yxjr/RuCCkV+jMSZfcDpe0WtdyO/Z0nQlFqXvY+dNrEWkIl55Xg
	buEMz3ESQKypH9WEGqswfYBD0g==
X-Google-Smtp-Source: AGHT+IFYjl+Fut6DF10AvB+rC8c9j309BtUc82beTcI2OpnuUGu9er2HNCKWhRNTJ7qi3gFQPi0b+g==
X-Received: by 2002:a17:90a:303:b0:28a:f0bc:2a9f with SMTP id 3-20020a17090a030300b0028af0bc2a9fmr2996731pje.21.1702988199587;
        Tue, 19 Dec 2023 04:16:39 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
        by smtp.gmail.com with ESMTPSA id g15-20020a17090a4b0f00b0028bb87b2378sm1385953pjh.49.2023.12.19.04.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 04:16:39 -0800 (PST)
Message-ID: <87ae3eae-84b4-40eb-a637-b65161bdc1ed@daynix.com>
Date: Tue, 19 Dec 2023 21:16:32 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should I add BPF kfuncs for userspace apps? And how?
Content-Language: en-US
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Yuri Benditovich
 <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>,
 Benjamin Tissoires <bentiss@kernel.org>, bpf <bpf@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kvm@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
References: <2f33be45-fe11-4b69-8e89-4d2824a0bf01@daynix.com>
 <CAPhsuW6=-FK+ysh_Q1H7ana=A6v9d0Rsn+2hpJpm5n2dB_A1Qg@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAPhsuW6=-FK+ysh_Q1H7ana=A6v9d0Rsn+2hpJpm5n2dB_A1Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/12/19 4:56, Song Liu wrote:
> Hi Akihiko,
> 
> On Tue, Dec 12, 2023 at 12:05 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
> [...]
>> ---
>>
>> I'm working on a new feature that aids virtio-net implementations using
>> tuntap virtual network device. You can see [1] for details, but
>> basically it's to extend BPF_PROG_TYPE_SOCKET_FILTER to report four more
>> bytes.
> 
> AFAICT, [1] adds a new program type, which is really hard to ship. However,
> you mentioned it is basically "extend BPF_PROG_TYPE_SOCKET_FILTER to
> report four more bytes", which confuses me.
> 
> Can we achieve the same goal by extending BPF_PROG_TYPE_SOCKET_FILTER
> (without adding a new program type)? Does this require extending
> __sk_buff, which
> is also not an option any more?

It is certainly possible to achieve the same result by extending 
BPF_PROG_TYPE_SOCKET_FILTER.

It is not required to extend __sk_buff; we can repurpose the cb member. 
But I think such an API will be error-prone than new members dedicated 
for this particular purpose.

Regards,
Akihiko Odaki

