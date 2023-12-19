Return-Path: <linux-kernel+bounces-5988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D318381928C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703B91F25CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA633B797;
	Tue, 19 Dec 2023 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L4pWeTm2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0073B786;
	Tue, 19 Dec 2023 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=OPsDtSH0h57ggP/qkMey9XPgpDBsMSDwy2BsxZjvi+w=; b=L4pWeTm2EiAaTLELNMoKdLNe2T
	Ti0MMjaiOL+aRrXQIbutRgZk+uCWXWGjhkWN3/7N+iGUPNBbq7iZqiSGTJYJPG0DQ3tCilpLfroc3
	zWLa8fLa/Tut06doC0+uC/R6YMdX/QcEOpmlW1pto/aXp/vPR8S28aNNtDa4ClX/kesfK0hb4C7XE
	I6VQim4B4+8/sj0yABV0qOKu2t6MokkhHSIATvD4YdS9shO2i9jaDuSodyNU8P1hqEH+iA0Sog2tl
	L+Aph8pXN0u6toRjEPkJu3Lv+w8zb+lllzVaPDH+HrU/F7Edc5ghe2oNI7W195jKLhSz6PBf4M0tn
	Z25vdYLg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFhzv-00FWry-24;
	Tue, 19 Dec 2023 21:51:31 +0000
Message-ID: <0f3bb667-a458-432e-b6bc-1ae8c4277b8e@infradead.org>
Date: Tue, 19 Dec 2023 13:51:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: video: logo: use %u format specifier for
 unsigned int values
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>, Helge Deller <deller@gmx.de>,
 Nikita Romanyuk <ufh8945@gmail.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231219151436.368696-1-colin.i.king@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231219151436.368696-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/23 07:14, Colin Ian King wrote:
> Currently the %d format specifier is being used for unsigned int values.
> Fix this by using the correct %u format specifier. Cleans up cppcheck
> warnings:
> 
> warning: %d in format string (no. 1) requires 'int' but the argument
> type is 'unsigned int'. [invalidPrintfArgType_sint]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  drivers/video/logo/pnmtologo.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/logo/pnmtologo.c b/drivers/video/logo/pnmtologo.c
> index ada5ef6e51b7..2434a25afb64 100644
> --- a/drivers/video/logo/pnmtologo.c
> +++ b/drivers/video/logo/pnmtologo.c
> @@ -249,10 +249,10 @@ static void write_footer(void)
>  	fputs("\n};\n\n", out);
>  	fprintf(out, "const struct linux_logo %s __initconst = {\n", logoname);
>  	fprintf(out, "\t.type\t\t= %s,\n", logo_types[logo_type]);
> -	fprintf(out, "\t.width\t\t= %d,\n", logo_width);
> -	fprintf(out, "\t.height\t\t= %d,\n", logo_height);
> +	fprintf(out, "\t.width\t\t= %u,\n", logo_width);
> +	fprintf(out, "\t.height\t\t= %u,\n", logo_height);
>  	if (logo_type == LINUX_LOGO_CLUT224) {
> -		fprintf(out, "\t.clutsize\t= %d,\n", logo_clutsize);
> +		fprintf(out, "\t.clutsize\t= %u,\n", logo_clutsize);
>  		fprintf(out, "\t.clut\t\t= %s_clut,\n", logoname);
>  	}
>  	fprintf(out, "\t.data\t\t= %s_data\n", logoname);

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

