Return-Path: <linux-kernel+bounces-15884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3078234F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B408B228D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23341CA94;
	Wed,  3 Jan 2024 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ewtxdL48"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65071CA84
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7815aad83acso53183485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 10:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704307838; x=1704912638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0sp+4Z7esZg8dAno6EaL5qNMmirNN9ujAQ8N5Wo+DTU=;
        b=ewtxdL48wLxxYXE459UuBKZmWgbR49nx9oQMAx7KIg0z71/1kk8jiZJfHfrkzK9CGv
         Px/Xst3hSZIKWK04KjWIh2qHbi1vFOVRku8zxQnU8U39tndr7IL2UrmcW+s7rstT9IBy
         Zsc4fKb1bySxTvxhz7bys6Kj7Kc9d4fyRLh34Tsx88v8zVzUvx/cO82D2v0m+dJ+B3Wj
         PULxuSuWioG/zXqKK1yqyNkiqxilnScSUdTm8akiF2+rmPu215bZH0zNLj2r9tC7oZLo
         YobyrOytID9QgLyWcvXcK2WK5em0awjUbB3hU8L7pf2cDwW5uqr9Ulc/FSlor3kaDMGk
         RkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307838; x=1704912638;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sp+4Z7esZg8dAno6EaL5qNMmirNN9ujAQ8N5Wo+DTU=;
        b=rLIcPAvAcX8M8/hf4t4ELbzgk/76Bl1w63Ww2BTXNZCMkwnE0ontVP6QVPRQ13nHOY
         67U3Xosz8ML51XRcg3/5fn7pHOccFcVIkUNQKbd3rT9jx64kb4m2otwSNWQdQJRTJptj
         pSpCFnoyrkiBM7oklOXary5pjdxPCd8Q0FIWZWMcZhxcpmH6QNSTPSCobDmMjRmecZhy
         jg7szPuydZAm6JkpPqXnppxY23cpMY+kv4ddABjWSyn1cQD713dYyipQWTUo0JxtFb7t
         +zDp7Hb5VoFJEhCv9IklfxrblPfSBa5nNNA5TSNqp/hAPSk2SK2TFwOeGmEFHURi3dtg
         8wDw==
X-Gm-Message-State: AOJu0YyDJlg6cqZWS39tQARUCq7//znAa3TyddMUzPZiD1hPNu1O+qBw
	V3MxyyjqMZnIO1VkwfF7aC81J/eTnX0v
X-Google-Smtp-Source: AGHT+IFhK5HzEBypbiw2Gsi3IVQysSC7aJLPPL5r6iRQGh6gl6E0AW+L11Me4oxE3WyJuEJADNgCnQ==
X-Received: by 2002:a0c:e885:0:b0:67f:9c35:ada3 with SMTP id b5-20020a0ce885000000b0067f9c35ada3mr1804323qvo.59.1704307837704;
        Wed, 03 Jan 2024 10:50:37 -0800 (PST)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id v5-20020a0ced45000000b0067f40a725c3sm11146261qvq.33.2024.01.03.10.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 10:50:37 -0800 (PST)
Message-ID: <1364bc77-bbeb-42d2-96e6-7054507d0320@google.com>
Date: Wed, 3 Jan 2024 13:50:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] libbpf: add helpers for mmapping maps
To: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240103153307.553838-1-brho@google.com>
 <20240103153307.553838-2-brho@google.com>
 <65959200a747b_2384720814@john.notmuch>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <65959200a747b_2384720814@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 11:57, John Fastabend wrote:
> Should bpf_map__mmap_size just calls bpf_map_mmap_sz with
> the correct sz and max_entries?

will do, thanks!

