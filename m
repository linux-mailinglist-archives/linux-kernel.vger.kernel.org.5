Return-Path: <linux-kernel+bounces-9097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B0C81C06A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3F228630C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A4F7763B;
	Thu, 21 Dec 2023 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZDd7CR/Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2758F768EF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7ba97708c38so5200439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703195093; x=1703799893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnneZFzTlHoKpJav6pEJp8aS2hixrEs69ZIqivt6hIA=;
        b=ZDd7CR/QKngp8eIJy37FgFsozuboDa7s0JJ++M+9i4AWIoDeAOobCa7GjEgWta+5BY
         bLViSAxwci49FDwKW2P+LAOPPYh7AYg6TZ/5DWyhvd1o89ZZWSiZGWQf2fRGxkc4MjV0
         +9WxUfz0DmPX8eaXO8i8rUgzHE8+irtETEWsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703195093; x=1703799893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnneZFzTlHoKpJav6pEJp8aS2hixrEs69ZIqivt6hIA=;
        b=lOq2KBlYEtSdoWGDM9lxwO4YbHiU1yLz0B5NTu89+hPEPZbAJvR4AIJEv/QHO0TKEe
         cNNkGo4ViBxdpzLbRsTwZ1dksi7+xqCedIkWZx3u09oqYpg7Ti0LSnZobJ+ZTXOBSk6e
         4akberKkkXyvwwM/htf/CeXjQZvErUnI0F+teeexfcSLYc74adNPjH6syKsNRcppF49s
         uZkYYkqFmZCJlwUmOpMDmNvW2Att7yqUmjgOKhO8A+G5XJASxfJokBq0mEiIQqHZ/efx
         Rb/RJpI0/rj9VqHRlhi8/ZTXimt5+H9zZY/e7wCpWh3el/+XoGVvdgPLFfwlxM4DaBD0
         OYnw==
X-Gm-Message-State: AOJu0YycobR8B690D9CNqK2nXoaWF7TryI/spNEXbB1i1KJx5PTlz/ek
	NIbsBdQnvbcYP/oHB+Wvi9hfBVcbnyphgA==
X-Google-Smtp-Source: AGHT+IEYgGoYkLnYECtboI3j/v5GUOG7Gg8Lu3bCOZrY6xy2jYmBgojj3Q7otHob1Gx4HWvSA2oBMg==
X-Received: by 2002:a05:6e02:174c:b0:35f:b559:c2c7 with SMTP id y12-20020a056e02174c00b0035fb559c2c7mr653248ill.3.1703195093260;
        Thu, 21 Dec 2023 13:44:53 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id a8-20020a92d108000000b0035d58d00b7bsm713639ilb.56.2023.12.21.13.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 13:44:52 -0800 (PST)
Message-ID: <f38374bd-bb1f-451e-9d34-9c38029ffd15@linuxfoundation.org>
Date: Thu, 21 Dec 2023 14:44:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: uevent: use shared makefile library
Content-Language: en-US
To: Antonio Terceiro <antonio.terceiro@linaro.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231221204908.341677-2-antonio.terceiro@linaro.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231221204908.341677-2-antonio.terceiro@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/23 13:49, Antonio Terceiro wrote:
> This makes the uevent selftests build not write to the source tree
> unconditionally, as that breaks out of tree builds when the source tree
> is read-only. It also avoids leaving a git repository in a dirty state
> after a build.
> 

Why can't you do that using make O= directive.

> v2: drop spurious extra SPDX-License-Identifier
> 
> Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
> ---
>   tools/testing/selftests/uevent/Makefile | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/uevent/Makefile b/tools/testing/selftests/uevent/Makefile
> index f7baa9aa2932..872969f42694 100644
> --- a/tools/testing/selftests/uevent/Makefile
> +++ b/tools/testing/selftests/uevent/Makefile
> @@ -1,17 +1,8 @@
>   # SPDX-License-Identifier: GPL-2.0
>   all:
>   
> -include ../lib.mk
> -
> -.PHONY: all clean
> -
> -BINARIES := uevent_filtering
> -CFLAGS += -Wl,-no-as-needed -Wall
> +CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
>   
> -uevent_filtering: uevent_filtering.c ../kselftest.h ../kselftest_harness.h
> -	$(CC) $(CFLAGS) $< -o $@
> +TEST_GEN_PROGS = uevent_filtering
>   
> -TEST_PROGS += $(BINARIES)
> -EXTRA_CLEAN := $(BINARIES)
> -
> -all: $(BINARIES)
> +include ../lib.mk

This change doesn't get the intended result of not writing to
source tree. Binaries will still be written to the source
tree unless O= is specified.

thanks,
-- Shuah


