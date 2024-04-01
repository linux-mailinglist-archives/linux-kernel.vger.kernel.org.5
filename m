Return-Path: <linux-kernel+bounces-126397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AF28936C3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C739281A67
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 01:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACDB4683;
	Mon,  1 Apr 2024 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBCn9Q/e"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58509138A;
	Mon,  1 Apr 2024 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711935617; cv=none; b=iCx0y7xbVxcKyk+sf+gTju1pKOLsLPFkrW1xQ2SvWe568QsP1t8z7a4UpmA2Rr09PMCgOGcRKIDdPayKbYi7I1Yg1YAMbcuze/DjV+a4GB8QjNiGaC+hkj70gTgJ2CjqfhuTwZBibnIkAnoSQLYNcShL9QNqTce7OwhCkZF6m6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711935617; c=relaxed/simple;
	bh=TI6IuqC+nGLzZt+tVLR6gojEYG3t41oEALcDGbjbp+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdHjetB4MFUpqzXMKi15b1nrhvTuvmOwvSBWiIYGQeQHY00/oLEBxeACZdmYsl+JJK7lM35mqA2VGwB7FYvWL5AhLQ54ZpR0y2lx6PXO5ZN4ixRaoqhuvPxA5+I8sIcQTc9kZEUsTngoV8mIDRI3P7rDQ/TF5+zuyg1HO+OCV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBCn9Q/e; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a20a9df742so2153238a91.1;
        Sun, 31 Mar 2024 18:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711935615; x=1712540415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uWl2xXHYY6auDvtgz0DFj69yz84J8dM6ZFmwWmtkGUk=;
        b=bBCn9Q/ev8eaVOr3A2angAxH4M2Sjo2vEeYOmkNAyLqVzitkOr80pPADnN0apmvCK9
         sHw9OAX5hHwh46+DjM/yYGgTqRPRebkv0oPGih+AvkvV8RSqcAek4kqWAOZtPy/Z0TAF
         w+JQIfG/Dy7HDUlnDabDCGkTNF0hfhbUc43RJaPy/TjZVEk39o53XaRzHMEgdV89ZA7t
         Z9SdHkqMEgTJ+1YM0L1ktKOPQgQd0uf9l26mnKU+t8QJnO4hmURVu6UuXEIDz5RQL2wq
         /UalbgUdMYxFBCnkK4+psOcADekV5LAhT2OR51rfyNvP5gE+3aAU2xbDQCUqoVYlI83F
         6H4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711935615; x=1712540415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWl2xXHYY6auDvtgz0DFj69yz84J8dM6ZFmwWmtkGUk=;
        b=pb/HtWsQ1EHsWAERzJCfnBppbXXkDdGjN8pkhD7+GfVWBu7cZaUrjRM9xr8p8c9mcy
         kMlXMUFOJ0CpN9Wf5rThNQUgwPb06Hva2Tuaa/Gcbh8C3CswVLcT4rvVtPi+iLfsoPkT
         aQ/wZ0NnNzrhX4cdYYfBu2Z+kSwCJwgQyggpLdneaoj6Toruzr2H3r68yld7dK8fD54D
         3fTThYgRrKGY0gHqilJ0pqbeA5ex8MbIdVVEpugB1AD1RoUOFNrqH2KmNausZBI5mpvf
         wNp+t/RDDbOYHBolbK4UZhr4ZC4sYiQBe88Y7YwSMKhp84yPxGNTs5wZE1t0J0vN9XD5
         8NXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwRlLfdRtA938nDmzpQF21ZJGsqceVlY/TnfwtNF9rb/k25VBlNG6oWv2FJkJMwDRtjs72tpukQlTN/XOl41gurN/6UTYppmkqlb81
X-Gm-Message-State: AOJu0Yy77oH0M587nVon2Nk4mo9OB9ZrdpjIGj1L5tAdJ6yIAuEnPHug
	2xOMmqaeiY1/c1/S3/TB+iiL4MEUhff7EtKVeU64RmKdmT2atk5uyM8ZeYN1
X-Google-Smtp-Source: AGHT+IG83zdomN/hFBS+E1Jq2ahe+Md52OeV3igeFtvyvHK4h8JT+yEGUyy9puL3kaFMNJ0y5YfADg==
X-Received: by 2002:a17:90a:bc95:b0:2a2:13ec:fc6 with SMTP id x21-20020a17090abc9500b002a213ec0fc6mr5646207pjr.10.1711935615351;
        Sun, 31 Mar 2024 18:40:15 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id w1-20020a17090a15c100b0029facfb3f25sm7176086pjd.45.2024.03.31.18.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 18:40:14 -0700 (PDT)
Message-ID: <339b5603-c09a-41de-af75-cf0f196a6310@gmail.com>
Date: Mon, 1 Apr 2024 09:40:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh: Fix Cc, Co-developed-by, and Signed-off-by tags
Content-Language: en-US
To: Geert Uytterhoeven <geert+renesas@glider.be>, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Jonathan Corbet <corbet@lwn.net>, Hu Haowen <2023002089@link.tyut.edu.cn>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <22892a8ab5c17d7121ef5b85f7d18d8b1f41e434.1711715655.git.geert+renesas@glider.be>
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <22892a8ab5c17d7121ef5b85f7d18d8b1f41e434.1711715655.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/29/24 8:35 PM, Geert Uytterhoeven wrote:
> The updates from commit ae67ee6c5e1d5b6a ("docs: fix Co-Developed-by
> docs") in v5.0 were never applied to the Chinese translations.
> In addition:
>   - "Cc" used wrong case,
>   - "Co-developed-by" lacked a dash,
>   - "Signed-off-by" was misspelled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

LGTM 
Reviewed-by: Alex Shi <alexs@kernel.org>


> ---
>  .../translations/zh_CN/process/submitting-patches.rst     | 8 ++++----
>  .../translations/zh_TW/process/submitting-patches.rst     | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
> index f8978f02057c164c..7864107e60a85c58 100644
> --- a/Documentation/translations/zh_CN/process/submitting-patches.rst
> +++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
> @@ -333,10 +333,10 @@ Linus 和其他的内核开发者需要阅读和评论你提交的改动。对
>  未参与其开发。签署链应当反映补丁传播到维护者并最终传播到Linus所经过的 **真实**
>  路径，首个签署指明单个作者的主要作者身份。
>  
> -何时使用Acked-by:，CC:，和Co-Developed by:
> +何时使用Acked-by:，Cc:，和Co-developed-by:
>  ------------------------------------------
>  
> -Singed-off-by: 标签表示签名者参与了补丁的开发，或者他/她在补丁的传递路径中。
> +Signed-off-by: 标签表示签名者参与了补丁的开发，或者他/她在补丁的传递路径中。
>  
>  如果一个人没有直接参与补丁的准备或处理，但希望表示并记录他们对补丁的批准/赞成，
>  那么他们可以要求在补丁的变更日志中添加一个Acked-by:。
> @@ -358,8 +358,8 @@ Acked-by：不一定表示对整个补丁的确认。例如，如果一个补丁
>  Co-developed-by: 声明补丁是由多个开发人员共同创建的；当几个人在一个补丁上工
>  作时，它用于给出共同作者（除了From:所给出的作者之外）。因为Co-developed-by:
>  表示作者身份，所以每个Co-developed-by:必须紧跟在相关合作作者的签署之后。标准
> -签署程序要求Singed-off-by:标签的顺序应尽可能反映补丁的时间历史，无论作者是通
> -过From:还是Co-developed-by:表明。值得注意的是，最后一个Singed-off-by:必须是
> +签署程序要求Signed-off-by:标签的顺序应尽可能反映补丁的时间历史，无论作者是通
> +过From:还是Co-developed-by:表明。值得注意的是，最后一个Signed-off-by:必须是
>  提交补丁的开发人员。
>  
>  注意，如果From:作者也是电子邮件标题的From:行中列出的人，则From:标签是可选的。
> diff --git a/Documentation/translations/zh_TW/process/submitting-patches.rst b/Documentation/translations/zh_TW/process/submitting-patches.rst
> index 99fa0f2fe6f414e1..f12f2f193f855cfb 100644
> --- a/Documentation/translations/zh_TW/process/submitting-patches.rst
> +++ b/Documentation/translations/zh_TW/process/submitting-patches.rst
> @@ -334,10 +334,10 @@ Linus 和其他的內核開發者需要閱讀和評論你提交的改動。對
>  未參與其開發。簽署鏈應當反映補丁傳播到維護者並最終傳播到Linus所經過的 **真實**
>  路徑，首個簽署指明單個作者的主要作者身份。
>  
> -何時使用Acked-by:，CC:，和Co-Developed by:
> +何時使用Acked-by:，Cc:，和Co-developed-by:
>  ------------------------------------------
>  
> -Singed-off-by: 標籤表示簽名者參與了補丁的開發，或者他/她在補丁的傳遞路徑中。
> +Signed-off-by: 標籤表示簽名者參與了補丁的開發，或者他/她在補丁的傳遞路徑中。
>  
>  如果一個人沒有直接參與補丁的準備或處理，但希望表示並記錄他們對補丁的批准/贊成，
>  那麼他們可以要求在補丁的變更日誌中添加一個Acked-by:。
> @@ -359,8 +359,8 @@ Acked-by：不一定表示對整個補丁的確認。例如，如果一個補丁
>  Co-developed-by: 聲明補丁是由多個開發人員共同創建的；當幾個人在一個補丁上工
>  作時，它用於給出共同作者（除了From:所給出的作者之外）。因爲Co-developed-by:
>  表示作者身份，所以每個Co-developed-by:必須緊跟在相關合作作者的簽署之後。標準
> -簽署程序要求Singed-off-by:標籤的順序應儘可能反映補丁的時間歷史，無論作者是通
> -過From:還是Co-developed-by:表明。值得注意的是，最後一個Singed-off-by:必須是
> +簽署程序要求Signed-off-by:標籤的順序應儘可能反映補丁的時間歷史，無論作者是通
> +過From:還是Co-developed-by:表明。值得注意的是，最後一個Signed-off-by:必須是
>  提交補丁的開發人員。
>  
>  注意，如果From:作者也是電子郵件標題的From:行中列出的人，則From:標籤是可選的。

