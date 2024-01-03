Return-Path: <linux-kernel+bounces-15930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955838235C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB309B248DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FD01CF95;
	Wed,  3 Jan 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0UgTBL4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A731CF8A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4283f7d53f2so58161cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704311126; x=1704915926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08K7LhOetDPdy9c3bhAy6SA1r70KyGek06ME+qynwdY=;
        b=n0UgTBL4y2n/PiBseo5zbymMZVI6t+Sw7Z6flus8BZYjULgc2RBNU/493QHFsiFmL0
         QJJzKmD28Lfmu8DWrSDN2W/NWaB8cHAJGxgJl9qZJefLJlfweDEMbDU5i+mO38UjUcd6
         YmtVNDds5F0EwT6V/EiNqlUIxDhlQURRmOIYFhdZd25mJm0tWgueagyaQP6B6D8qI6yJ
         JJxo+bOjfDZ77rgnxnde7+NWo/dPu8ImdIyUz30iO+qXF1+FRR2eHTQP6qE1F3nL9IuY
         wBs4ufXs6nAsw35FXgmphUcCfy8Q1sFxUeFteU5QZbUBdf6RzgnhI/LKjxyjjfd7JNQE
         ttag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704311126; x=1704915926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08K7LhOetDPdy9c3bhAy6SA1r70KyGek06ME+qynwdY=;
        b=J0/1ED3SOvebrpYiyp2Qwtyi/Xz7hAxhFzkToOBO4lwSX10dZRN+XXF3qG+TlBFDuU
         ytuKzarHFI1YZlqtGHvk4ze/JfnzsxANqw9o+jzif5VJqBniGXirMRA/ag2sRAExP9yz
         HbseroHNt95bNjU+dd5adK02HZHV/kKoEVocXjyqODRag7pf3P2NawQvGckhPN/zkbpf
         hkUIbJUXiQVt7s15YSDU1EmlqtUsVmpHsVIJOi6pHKMyMS74mb0CaQbPW9BhXXLrejxS
         fKbjLpCbFXiJEKHp9tPBUj3jIZK4cyb1C6repSKDSu/qR+ZL8INeAveYvo7wZuLenfMu
         Oudg==
X-Gm-Message-State: AOJu0Yy6AB7frjwdxqvZeeQmAPPWeQVlKTApxfaVl5g8E/hn5VkDBAFs
	sW4eMhoOKkKy/bSyrBoLfaj5iydviGgv
X-Google-Smtp-Source: AGHT+IHpdeWDTUGFEoYyWXGKPiAy09Orm5WIgHCQnHBAQrhtE/UKeD5p5zrafXMQ0T04zPyVziVRGg==
X-Received: by 2002:a05:622a:1ba0:b0:427:9b36:d8f with SMTP id bp32-20020a05622a1ba000b004279b360d8fmr24323985qtb.93.1704311126144;
        Wed, 03 Jan 2024 11:45:26 -0800 (PST)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id bt13-20020ac8690d000000b0042834ec3e46sm1440448qtb.7.2024.01.03.11.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 11:45:25 -0800 (PST)
Message-ID: <d2f30155-ba00-4f10-9d05-c6cba3bcb1ef@google.com>
Date: Wed, 3 Jan 2024 14:45:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: add helpers for mmapping maps
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240103185403.610641-1-brho@google.com>
 <20240103185403.610641-2-brho@google.com>
 <CAEf4Bzbyn8VaMz8jWCShDDMtwif5Qt+YTEih0GEzULFeAAS2LQ@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <CAEf4Bzbyn8VaMz8jWCShDDMtwif5Qt+YTEih0GEzULFeAAS2LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 14:42, Andrii Nakryiko wrote:
> this is specifically ARRAY map's rules, it might differ for other map
> types (e.g., RINGBUF has different logic)

good to know.  will drop it.

