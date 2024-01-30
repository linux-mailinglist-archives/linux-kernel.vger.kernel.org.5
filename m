Return-Path: <linux-kernel+bounces-43777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A87758418C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E019283E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E16364BC;
	Tue, 30 Jan 2024 02:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9aOdTlz"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12517364A1;
	Tue, 30 Jan 2024 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580477; cv=none; b=KNWPRG5HCh8oX+4UaI8tky60VVREysVzBE3wW3cLiYhIyxFFmRRczhfvGNnzirwvTMNl1X3oCyl0IPvr2ChwmyhR2KF1hPzr89q5IKBnvVIru8n28Ec57nEmK7hP/uwCZqZHxd5aTE1HtJ4KRa2fnE+LUYrnqYpey+cBRy6TmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580477; c=relaxed/simple;
	bh=9GzqtiRjGBRI5jGkP9zBfLvJ/U7cSQC8XrrVKMAH+7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIMEgze0PWu+b+4SDCDMN4ii4ljOgGg/Ydav+QfmTUKjBh2JB55BUvQ6YAB4ovx+U7+eJ8yj8rMUhKPeqiP2tyDIzA+MTMydmjMQHHMgaatQi2hvntF46shb2JzT7Lvttk+HUb/5MUNutRjIowiOqFTSfrGwUOIjV0dH4Zm3Eyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9aOdTlz; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc22597dbfeso4357357276.3;
        Mon, 29 Jan 2024 18:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706580475; x=1707185275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QxXagm8xITJ7OwBXa8Smn2e2QqnkiUXPmL/3U/yUOKI=;
        b=T9aOdTlzf01kO2UrAglqC/Kc+sz/PUNbgdVLOF4abc5QsaFIyetE/OJGE3qhaKPZL4
         u6hcvlze5kt/BnmMLpoWmXLD/FfZ0zStaCwewPUOzungLVvMdt/jzXXINNIxUGnCQMO4
         Zq5Umy0u3gYcHUkzJc4esAg5t0Xd1HWD3nLB7b1TonvHT8pAyDYTMrMys/EfxEpVztha
         THwLxfySs+pPEvdPXqZMdZvlykqI5WwKtTQjfiFMijK7hRGJ4kNXCtiBrMOGtyPi43Wb
         Zr0ouwHaWS1rbJFh2U27I97DdJvsztx/SZUbqoQyzITFrYyvNSGYbMvJL7BXVD+wyG4X
         uIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706580475; x=1707185275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxXagm8xITJ7OwBXa8Smn2e2QqnkiUXPmL/3U/yUOKI=;
        b=YsDGPrTCW8HBN6db1HJ8NX/GZF/II3KVyJn/HlHHqFuUH1l51GN7XUUDOJbzYWOXoG
         G/RnJPMGA7jtIBaIM4mh+kyQx7tUzYNYXfbjXlkm4TNOjqrjaoc0Uv0X9gwrr5nmL6Oh
         OuHthRsLkCxM3pHnuX0RleQxpe6TZi1W4uwQF+qDiqDrZY//lLGGx5mmNEFVCsBdJ4oj
         ef+K3KuHlO07mvcp2CW4pYMXFWXHdBTbUSKftoFqGdnWH2FLQmcW7SxSFA5F6lpYPLr2
         J+HJ+gonfbpglRDWQ1YF0qm0kYKCPSzuq7ReJB6jOAnW20md9FQDgp+v+2NfOzGxY7qU
         XSHQ==
X-Gm-Message-State: AOJu0YzSe6deSM+hzE1LgnY+8kiosq6MX3+qLZXyNpIGQCLr4U+1zEu6
	m7lEcBm5HzQT1ydlcP06P88WBcp5RJP8JME6C+WBWTcQfmI4cs94
X-Google-Smtp-Source: AGHT+IGAeLUYS434ljSyphmBdqAspTf6zakWUEVUce2RSJ/LTvuMle37qQWfKujEeNODO+9kg5PqxQ==
X-Received: by 2002:a5b:d0d:0:b0:dc2:66ab:84b0 with SMTP id y13-20020a5b0d0d000000b00dc266ab84b0mr5506555ybp.64.1706580474969;
        Mon, 29 Jan 2024 18:07:54 -0800 (PST)
Received: from [192.168.255.10] ([43.132.141.23])
        by smtp.gmail.com with ESMTPSA id 4-20020a630804000000b005d8d431d3a1sm2191535pgi.42.2024.01.29.18.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 18:07:54 -0800 (PST)
Message-ID: <8366973c-f7bc-494e-a0d8-70c26d284008@gmail.com>
Date: Tue, 30 Jan 2024 10:07:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] Docs/translations/damon/usage: update for monitor_on
 renaming
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Hu Haowen <2023002089@link.tyut.edu.cn>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240130013549.89538-1-sj@kernel.org>
 <20240130013549.89538-10-sj@kernel.org>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <20240130013549.89538-10-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

LGTM

Reviewed-by: Alex Shi <alexs@kernel.org>

On 1/30/24 9:35 AM, SeongJae Park wrote:
> Update DAMON debugfs interface sections on the translated usage
> documents to reflect the fact that 'monitor_on' file has renamed to
> 'monitor_on_DEPRECATED'.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  .../zh_CN/admin-guide/mm/damon/usage.rst      | 20 +++++++++----------
>  .../zh_TW/admin-guide/mm/damon/usage.rst      | 20 +++++++++----------
>  2 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
> index 17b9949d9b43..da2745464ece 100644
> --- a/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
> @@ -344,7 +344,7 @@ debugfs接口
>    :ref:`sysfs接口<sysfs_interface>`。
>  
>  DAMON导出了八个文件, ``attrs``, ``target_ids``, ``init_regions``,
> -``schemes``, ``monitor_on``, ``kdamond_pid``, ``mk_contexts`` 和
> +``schemes``, ``monitor_on_DEPRECATED``, ``kdamond_pid``, ``mk_contexts`` 和
>  ``rm_contexts`` under its debugfs directory, ``<debugfs>/damon/``.
>  
>  
> @@ -521,15 +521,15 @@ DAMON导出了八个文件, ``attrs``, ``target_ids``, ``init_regions``,
>  开关
>  ----
>  
> -除非你明确地启动监测，否则如上所述的文件设置不会产生效果。你可以通过写入和读取 ``monitor_on``
> +除非你明确地启动监测，否则如上所述的文件设置不会产生效果。你可以通过写入和读取 ``monitor_on_DEPRECATED``
>  文件来启动、停止和检查监测的当前状态。写入 ``on`` 该文件可以启动对有属性的目标的监测。写入
>  ``off`` 该文件则停止这些目标。如果每个目标进程被终止，DAMON也会停止。下面的示例命令开启、关
>  闭和检查DAMON的状态::
>  
>      # cd <debugfs>/damon
> -    # echo on > monitor_on
> -    # echo off > monitor_on
> -    # cat monitor_on
> +    # echo on > monitor_on_DEPRECATED
> +    # echo off > monitor_on_DEPRECATED
> +    # cat monitor_on_DEPRECATED
>      off
>  
>  请注意，当监测开启时，你不能写到上述的debugfs文件。如果你在DAMON运行时写到这些文件，将会返
> @@ -543,11 +543,11 @@ DAMON通过一个叫做kdamond的内核线程来进行请求监测。你可以
>  得该线程的 ``pid`` 。当监测被 ``关闭`` 时，读取该文件不会返回任何信息::
>  
>      # cd <debugfs>/damon
> -    # cat monitor_on
> +    # cat monitor_on_DEPRECATED
>      off
>      # cat kdamond_pid
>      none
> -    # echo on > monitor_on
> +    # echo on > monitor_on_DEPRECATED
>      # cat kdamond_pid
>      18594
>  
> @@ -574,7 +574,7 @@ DAMON通过一个叫做kdamond的内核线程来进行请求监测。你可以
>      # ls foo
>      # ls: cannot access 'foo': No such file or directory
>  
> -注意， ``mk_contexts`` 、 ``rm_contexts`` 和 ``monitor_on`` 文件只在根目录下。
> +注意， ``mk_contexts`` 、 ``rm_contexts`` 和 ``monitor_on_DEPRECATED`` 文件只在根目录下。
>  
>  
>  监测结果的监测点
> @@ -583,9 +583,9 @@ DAMON通过一个叫做kdamond的内核线程来进行请求监测。你可以
>  DAMON通过一个tracepoint ``damon:damon_aggregated`` 提供监测结果.  当监测开启时，你可
>  以记录追踪点事件，并使用追踪点支持工具如perf显示结果。比如说::
>  
> -    # echo on > monitor_on
> +    # echo on > monitor_on_DEPRECATED
>      # perf record -e damon:damon_aggregated &
>      # sleep 5
>      # kill 9 $(pidof perf)
> -    # echo off > monitor_on
> +    # echo off > monitor_on_DEPRECATED
>      # perf script
> diff --git a/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst b/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
> index 6dee719a32ea..7464279f9b7d 100644
> --- a/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
> @@ -344,7 +344,7 @@ debugfs接口
>    :ref:`sysfs接口<sysfs_interface>`。
>  
>  DAMON導出了八個文件, ``attrs``, ``target_ids``, ``init_regions``,
> -``schemes``, ``monitor_on``, ``kdamond_pid``, ``mk_contexts`` 和
> +``schemes``, ``monitor_on_DEPRECATED``, ``kdamond_pid``, ``mk_contexts`` 和
>  ``rm_contexts`` under its debugfs directory, ``<debugfs>/damon/``.
>  
>  
> @@ -521,15 +521,15 @@ DAMON導出了八個文件, ``attrs``, ``target_ids``, ``init_regions``,
>  開關
>  ----
>  
> -除非你明確地啓動監測，否則如上所述的文件設置不會產生效果。你可以通過寫入和讀取 ``monitor_on``
> +除非你明確地啓動監測，否則如上所述的文件設置不會產生效果。你可以通過寫入和讀取 ``monitor_on_DEPRECATED``
>  文件來啓動、停止和檢查監測的當前狀態。寫入 ``on`` 該文件可以啓動對有屬性的目標的監測。寫入
>  ``off`` 該文件則停止這些目標。如果每個目標進程被終止，DAMON也會停止。下面的示例命令開啓、關
>  閉和檢查DAMON的狀態::
>  
>      # cd <debugfs>/damon
> -    # echo on > monitor_on
> -    # echo off > monitor_on
> -    # cat monitor_on
> +    # echo on > monitor_on_DEPRECATED
> +    # echo off > monitor_on_DEPRECATED
> +    # cat monitor_on_DEPRECATED
>      off
>  
>  請注意，當監測開啓時，你不能寫到上述的debugfs文件。如果你在DAMON運行時寫到這些文件，將會返
> @@ -543,11 +543,11 @@ DAMON通過一個叫做kdamond的內核線程來進行請求監測。你可以
>  得該線程的 ``pid`` 。當監測被 ``關閉`` 時，讀取該文件不會返回任何信息::
>  
>      # cd <debugfs>/damon
> -    # cat monitor_on
> +    # cat monitor_on_DEPRECATED
>      off
>      # cat kdamond_pid
>      none
> -    # echo on > monitor_on
> +    # echo on > monitor_on_DEPRECATED
>      # cat kdamond_pid
>      18594
>  
> @@ -574,7 +574,7 @@ DAMON通過一個叫做kdamond的內核線程來進行請求監測。你可以
>      # ls foo
>      # ls: cannot access 'foo': No such file or directory
>  
> -注意， ``mk_contexts`` 、 ``rm_contexts`` 和 ``monitor_on`` 文件只在根目錄下。
> +注意， ``mk_contexts`` 、 ``rm_contexts`` 和 ``monitor_on_DEPRECATED`` 文件只在根目錄下。
>  
>  
>  監測結果的監測點
> @@ -583,10 +583,10 @@ DAMON通過一個叫做kdamond的內核線程來進行請求監測。你可以
>  DAMON通過一個tracepoint ``damon:damon_aggregated`` 提供監測結果.  當監測開啓時，你可
>  以記錄追蹤點事件，並使用追蹤點支持工具如perf顯示結果。比如說::
>  
> -    # echo on > monitor_on
> +    # echo on > monitor_on_DEPRECATED
>      # perf record -e damon:damon_aggregated &
>      # sleep 5
>      # kill 9 $(pidof perf)
> -    # echo off > monitor_on
> +    # echo off > monitor_on_DEPRECATED
>      # perf script
>  

