Return-Path: <linux-kernel+bounces-125785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9FE892C0E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FBEE1C218D2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B7033CC2;
	Sat, 30 Mar 2024 16:36:24 +0000 (UTC)
Received: from mail-m17249.xmail.ntesmail.com (mail-m17249.xmail.ntesmail.com [45.195.17.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C3B2B2DD;
	Sat, 30 Mar 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711816584; cv=none; b=mEg4Xw1+iJQIDNpSHf6+lrVlyHHAwRj0XpJcf6Wj0SumMxZRLZ/pLZBKQRIy91Y1xe+Gh50wzdJ8ZWRX0XPCuZ2prqox3A+IlpepEM83tjGjRJv74ZcXtyDDG4i7CyqNJ7mgQ0bJbGiu5vJKayHi9F13hKtDsT3s3d9VWfbOhT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711816584; c=relaxed/simple;
	bh=SZqUiQo5OKj8nmtGbzQ4Ypg3gkJp96clS4Euxj5TXIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmQebZM3cqLdupl+YFvQ9ie4BzakMCg3uoY0K+VY/xJQHABRrhxZPDrhxJ74NqNdivS1oWOJ/0bYEHQFNSWTCtB1RCW4Z6EyvPo0s5Jb8WztFbWh1/81GpQSIjRheuOSzrhP845c+ACoxj+zuJAqhySyEMXSXyMg89uvsmcJuvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=link.tyut.edu.cn; spf=pass smtp.mailfrom=link.tyut.edu.cn; arc=none smtp.client-ip=45.195.17.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=link.tyut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=link.tyut.edu.cn
Received: from [IPV6:2409:8a0c:26d:73c0:9b07:dfee:fd9c:bf7b] (unknown [IPV6:2409:8a0c:26d:73c0:9b07:dfee:fd9c:bf7b])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 1EDD892010B;
	Sun, 31 Mar 2024 00:35:56 +0800 (CST)
Message-ID: <c4cbd8f8-01cc-4be6-b469-31173bffb952@link.tyut.edu.cn>
Date: Sun, 31 Mar 2024 00:35:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh: Fix Cc, Co-developed-by, and Signed-off-by tags
To: Geert Uytterhoeven <geert+renesas@glider.be>, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <22892a8ab5c17d7121ef5b85f7d18d8b1f41e434.1711715655.git.geert+renesas@glider.be>
Content-Language: en-US
From: Hu Haowen <2023002089@link.tyut.edu.cn>
In-Reply-To: <22892a8ab5c17d7121ef5b85f7d18d8b1f41e434.1711715655.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSUoaVkhJGUIYHUlPGh8eGVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPS0JBQxpLGEFJTR9BTEgYS0FCGUtMQR8dHh5BHR9CGEEZHUwZWVdZFhoPEhUdFF
	lBWU9LSFVKTUNMTE9VSktLVUpCS0tZBg++
X-HM-Tid: 0a8e9037bf9403a1kunm1edd892010b
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAw6Oio4ODMUTjgaF0oqEE06
	I0tPFDxVSlVKTEpKQ0pNTk5NQklMVTMWGhIXVUlLSUhLS0lLQ0I7FxIVEFUPAg4PVR4fDlUYFUVZ
	V1kSC1lBWUlPS0JBQxpLGEFJTR9BTEgYS0FCGUtMQR8dHh5BHR9CGEEZHUwZWVdZCAFZQU1NSko3
	Bg++


在 2024/3/29 20:35, Geert Uytterhoeven 写道:
> The updates from commit ae67ee6c5e1d5b6a ("docs: fix Co-Developed-by
> docs") in v5.0 were never applied to the Chinese translations.
> In addition:
>    - "Cc" used wrong case,
>    - "Co-developed-by" lacked a dash,
>    - "Signed-off-by" was misspelled.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   .../translations/zh_CN/process/submitting-patches.rst     | 8 ++++----
>   .../translations/zh_TW/process/submitting-patches.rst     | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
> index f8978f02057c164c..7864107e60a85c58 100644
> --- a/Documentation/translations/zh_CN/process/submitting-patches.rst
> +++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
> @@ -333,10 +333,10 @@ Linus 和其他的内核开发者需要阅读和评论你提交的改动。对
>   未参与其开发。签署链应当反映补丁传播到维护者并最终传播到Linus所经过的 **真实**
>   路径，首个签署指明单个作者的主要作者身份。
>   
> -何时使用Acked-by:，CC:，和Co-Developed by:
> +何时使用Acked-by:，Cc:，和Co-developed-by:
>   ------------------------------------------
>   
> -Singed-off-by: 标签表示签名者参与了补丁的开发，或者他/她在补丁的传递路径中。
> +Signed-off-by: 标签表示签名者参与了补丁的开发，或者他/她在补丁的传递路径中。
>   
>   如果一个人没有直接参与补丁的准备或处理，但希望表示并记录他们对补丁的批准/赞成，
>   那么他们可以要求在补丁的变更日志中添加一个Acked-by:。
> @@ -358,8 +358,8 @@ Acked-by：不一定表示对整个补丁的确认。例如，如果一个补丁
>   Co-developed-by: 声明补丁是由多个开发人员共同创建的；当几个人在一个补丁上工
>   作时，它用于给出共同作者（除了From:所给出的作者之外）。因为Co-developed-by:
>   表示作者身份，所以每个Co-developed-by:必须紧跟在相关合作作者的签署之后。标准
> -签署程序要求Singed-off-by:标签的顺序应尽可能反映补丁的时间历史，无论作者是通
> -过From:还是Co-developed-by:表明。值得注意的是，最后一个Singed-off-by:必须是
> +签署程序要求Signed-off-by:标签的顺序应尽可能反映补丁的时间历史，无论作者是通
> +过From:还是Co-developed-by:表明。值得注意的是，最后一个Signed-off-by:必须是
>   提交补丁的开发人员。
>   
>   注意，如果From:作者也是电子邮件标题的From:行中列出的人，则From:标签是可选的。
> diff --git a/Documentation/translations/zh_TW/process/submitting-patches.rst b/Documentation/translations/zh_TW/process/submitting-patches.rst
> index 99fa0f2fe6f414e1..f12f2f193f855cfb 100644
> --- a/Documentation/translations/zh_TW/process/submitting-patches.rst
> +++ b/Documentation/translations/zh_TW/process/submitting-patches.rst
> @@ -334,10 +334,10 @@ Linus 和其他的內核開發者需要閱讀和評論你提交的改動。對
>   未參與其開發。簽署鏈應當反映補丁傳播到維護者並最終傳播到Linus所經過的 **真實**
>   路徑，首個簽署指明單個作者的主要作者身份。
>   
> -何時使用Acked-by:，CC:，和Co-Developed by:
> +何時使用Acked-by:，Cc:，和Co-developed-by:
>   ------------------------------------------
>   
> -Singed-off-by: 標籤表示簽名者參與了補丁的開發，或者他/她在補丁的傳遞路徑中。
> +Signed-off-by: 標籤表示簽名者參與了補丁的開發，或者他/她在補丁的傳遞路徑中。
>   
>   如果一個人沒有直接參與補丁的準備或處理，但希望表示並記錄他們對補丁的批准/贊成，
>   那麼他們可以要求在補丁的變更日誌中添加一個Acked-by:。
> @@ -359,8 +359,8 @@ Acked-by：不一定表示對整個補丁的確認。例如，如果一個補丁
>   Co-developed-by: 聲明補丁是由多個開發人員共同創建的；當幾個人在一個補丁上工
>   作時，它用於給出共同作者（除了From:所給出的作者之外）。因爲Co-developed-by:
>   表示作者身份，所以每個Co-developed-by:必須緊跟在相關合作作者的簽署之後。標準
> -簽署程序要求Singed-off-by:標籤的順序應儘可能反映補丁的時間歷史，無論作者是通
> -過From:還是Co-developed-by:表明。值得注意的是，最後一個Singed-off-by:必須是
> +簽署程序要求Signed-off-by:標籤的順序應儘可能反映補丁的時間歷史，無論作者是通
> +過From:還是Co-developed-by:表明。值得注意的是，最後一個Signed-off-by:必須是
>   提交補丁的開發人員。
>   
>   注意，如果From:作者也是電子郵件標題的From:行中列出的人，則From:標籤是可選的。

Reviewed-by: Hu Haowen <2023002089@link.tyut.edu.cn>


Thanks,

Hu Haowen


