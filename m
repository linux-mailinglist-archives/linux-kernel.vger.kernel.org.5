Return-Path: <linux-kernel+bounces-33578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5BA836BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AF61F24404
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599DA5A0EF;
	Mon, 22 Jan 2024 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpxXo7HQ"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369465A0E3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936937; cv=none; b=cJYofbw8pRysZ7ld6DgtKuqJe9Aa4Gw4wH6xu5uTBxMbBFjsce4++QjqYpFc2Gpyv2f3aQaazrYqVqIP/EKlWe2/xxew5eZhp2w92b4TZ4kwJTxCLEOH3wrb5jkwVDZMzQxsHYRH7Zclm3so2eFhI9GwbiiGcBTIBlPXg7enm54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936937; c=relaxed/simple;
	bh=xeP58IH4kb9w8GJL/zzLJNHDo+3mbpiqzZNNn2ybr7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hboC/bASd0pvWA7gPXG7z8xH2+Hk1jZBaTd/W7TSbT5Cack5jCDb/rcsHoZJa4d2d0L5RJ5NwV32tgSrRDNFW8n3DhFqmPQiw+XzMNhSHGr7G/OKkcbNhlUgYnU7FSQJIURrSPOJvP4+xlumrBViOC/MWlmsZ6xAJ9nRLDzzAQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EpxXo7HQ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ff7a098ab8so23641897b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705936935; x=1706541735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QCAhKhxlNboSP5z3UoLufXQw9Hdms1pvWA9BruMBgy8=;
        b=EpxXo7HQEufR54TXn2VkNYzt4mBYN9pCBjJzLKkhB8b4J/05jpK0AfRFQVJazVnQ5o
         Kv2C5YQqq2fhKe5/5tWIAo6qvdg4JGWaW8dmlauq7zAj60tEPhCeKcPB9lMgetn0v6q4
         XYMOxRHsft+nw8zU6b0z7vbD+TJ3ypyMXyzLo2mS25hKX6Vy64TgTtrQYuuDR++Oj+QX
         rasuQqARBOBlJjOzkD+UBZJuw6KVXPiiAPhT0Sn6FJBpyLZk9kbPNel2Z4iBQFAxp6VY
         jQtqlDaZZoQ3BspnP56luzGh7WnH14WwmHmIO75s2vfEhu75iJbGqUO4Ssk+xZrWPlEY
         qNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936935; x=1706541735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCAhKhxlNboSP5z3UoLufXQw9Hdms1pvWA9BruMBgy8=;
        b=WkWAiBqM1iVM5w333TvacPPMOapzI/nNwdNieggSxjp9xW7VbxTWUACcjrUX7PSTvD
         oXjHS+ElBkvDwPGSHGBegGSm3ionVhpX3GLO/9AtgigElvPOcLFnkaYblAeOHFg9x80O
         tIOr4N0ni0vkWOwqMf592L/1J3L4NGW/MLDJSKiqoEBQOk19w3hplhipnhR9r2gl4CA+
         Ay1DDrVGs5mS1RtCXdDUVSOQ77Mu/O4jeUIiH0NvkSKxqDDZtNnn6TIp0AIHxhPdV6Ou
         u+tgsw0QIGRtJXXf0t5ysGSEAlOLBDN44RZhUpVF+Wg9SlfL3NsPQGbkxKnQwZhm9TMK
         oP2g==
X-Gm-Message-State: AOJu0Yx2CGtGqo09meHDwLA5Uyn1xTAPx7p7Lal67IZ9/4tK4jIaRs1v
	0k2OB18U+CIXhRawasy/Rew5wxrQ9FWkT8r4TiTYdoNI69rWQ0IErqXeDIhrW3cXRu319VW1Tud
	xiQm0KYNSN0xOEVDkgxhVpPrAcY2tmtOFrelHcw==
X-Google-Smtp-Source: AGHT+IED38eHjjKsKwTwHlake7WIjAFshwwfrqlbYigahn2tybClh+eS/93P97aG2765xCGlzD7m+AzmNArNegd8TVk=
X-Received: by 2002:a25:d607:0:b0:dc2:2b0c:2113 with SMTP id
 n7-20020a25d607000000b00dc22b0c2113mr2277335ybg.77.1705936935251; Mon, 22 Jan
 2024 07:22:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227-topic-pmdomain_spam-v1-1-ff0410086b36@linaro.org>
In-Reply-To: <20231227-topic-pmdomain_spam-v1-1-ff0410086b36@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 22 Jan 2024 16:21:39 +0100
Message-ID: <CAPDyKFr1+vnrhQgSLhD7Kp9WAoJ6qNA0k2WP53wJ0GigdC6P+Q@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Print a message when unused power domains
 are disabled
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Dec 2023 at 16:18, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> In a similar spirit to commit 12ca59b91d04 ("clk: Print an info line
> before disabling unused clocks"), print the message in both ignore AND
> cleanup cases to better inform the user (and more importantly, the
> developer) when it happens.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index a1f6cba3ae6c..69902797a5bb 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -1100,6 +1100,7 @@ static int __init genpd_power_off_unused(void)
>                 return 0;
>         }
>
> +       pr_info("genpd: Disabling unused power domains\n");
>         mutex_lock(&gpd_list_lock);
>
>         list_for_each_entry(genpd, &gpd_list, gpd_list_node)
>
> ---
> base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
> change-id: 20231227-topic-pmdomain_spam-2e86227bf02f
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@linaro.org>
>

