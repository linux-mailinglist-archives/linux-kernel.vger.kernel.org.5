Return-Path: <linux-kernel+bounces-19260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E58C826A82
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D14B2833D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ABC125DE;
	Mon,  8 Jan 2024 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lma4b9e3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E1101DE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a997f3dfso112511466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704705405; x=1705310205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECLd/WpcPw2jdEyubeKTqp4tnaZugii4WZCdKMR4LqM=;
        b=lma4b9e3vRJ8Hq/vkxAdXsTYFa16qssy1weHMOgee8Rw3WAngOOPvL7O7Q3BdJ5+Eq
         TlHTgKYQfNwcW79F5aPPTlYQajLzJdNd7TQPbfFT6qB01alQFd8QToKA/Tazjc+FmnUx
         wz3i0fxpRIi9vrgJBHIjHgdooumJzBf1R44JkKVmbQn5uFMKCFJkITB1KyQ21nx6SYhH
         ozl4HDTxCy2RWu6elMDgengmC1yZ5oOeLgy/rNFU0kcuCV6vgYBG8vLyPhWrkQZYS9P0
         kmrZOgYi7RASyehKfT8uvqqrHw1kl0H2HtxuXLQXTT6tPqmS39xB7zToMtD9Ea3u8ehI
         PTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705405; x=1705310205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECLd/WpcPw2jdEyubeKTqp4tnaZugii4WZCdKMR4LqM=;
        b=os5DD8+yPalkCCtv4p1dr7DwBBZB5APkAAs17HGJ1jzzskSgPyaioQrJOfsQ+XjCzX
         m7hSSjhRdXTTT1M4a4km2ZPVfpIhfQ2y2/nIsO9XIdxXSwpjhP2TF1dMpEa438W7pxmN
         dFZ9RCQ2ZCQ4HEC8XqNyV9OLKAl5T4qsZ4NA+96mdQ8KSOOPzR3sUIS/zNKXK6luhj15
         OOm1SP/bvMv532xBtZwijhDkj9pRx3ma7EpvGnzehDnjiC80ex8jGC7dZKsVh5lpal2s
         w98L+H0+wk0lK2Upd69+Kpz2Dl/5B05MjLnTaimyldSDSyDKp/4td8nuZj5uTn9lAWSs
         K1nQ==
X-Gm-Message-State: AOJu0Yx2RpSYj9lTv0nNxlMBRmFGQskwqW1VFh7Zf0A876QLBVXIK7Lp
	PHCfOJ/dn4O9NQA9Sil1Bvc=
X-Google-Smtp-Source: AGHT+IEu9NtAYpyzGyz8d2XCrQRfdqVEVGdsp2akdNVMNyNykQ2eIDtSr3SEq5kOLo/EjM75kxEWQw==
X-Received: by 2002:a17:906:c0c9:b0:a29:906e:b8fa with SMTP id bn9-20020a170906c0c900b00a29906eb8famr1526031ejb.1.1704705404732;
        Mon, 08 Jan 2024 01:16:44 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id q26-20020a1709060e5a00b00a268b2ed7a9sm3704600eji.184.2024.01.08.01.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:16:44 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 10:16:42 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: jpoimboe@kernel.org, peterz@infradead.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] objtool: make objtool SLS validation fatal when
 building with CONFIG_SLS=y
Message-ID: <ZZu9eg0dfo5ZP/sv@gmail.com>
References: <20231213134303.2302285-1-dimitri.ledkov@canonical.com>
 <20231213134303.2302285-3-dimitri.ledkov@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213134303.2302285-3-dimitri.ledkov@canonical.com>


* Dimitri John Ledkov <dimitri.ledkov@canonical.com> wrote:

> Make objtool SLS validation fatal when building with CONFIG_SLS=y,
> currently it is a build.log warning only.
> 
> This is a standalone patch, such that if regressions are identified
> (with any config or toolchain configuration) it can be reverted until
> relevant identified code is fixed up or otherwise
> ignored/silecned/marked as safe.
> 
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>  tools/objtool/check.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 15df4afae2..9709f037f1 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -4500,7 +4500,9 @@ static int validate_sls(struct objtool_file *file)
>  		}
>  	}
>  
> -	return warnings;
> +	/* SLS is an optional security safety feature, make it fatal
> +	 * to ensure no new code is introduced that fails SLS */
> +	return -warnings;

please use the customary (multi-line) comment style:

  /*
   * Comment .....
   * ...... goes here.
   */

specified in Documentation/process/coding-style.rst.

Thanks,

        Ingo

