Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11487E5489
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbjKHKwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344609AbjKHKwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:52:22 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1242D62;
        Wed,  8 Nov 2023 02:51:00 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6bcbfecf314so2038932b3a.1;
        Wed, 08 Nov 2023 02:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699440659; x=1700045459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bt2bvDjEv0HiaQYd0c4TjFAx6Nfzvf1eIcmbOTXqPwE=;
        b=L4WumBKwd3Xiu+qcVNTplL6kt4zI8x4RfMx43qlF5Pnft1F+7NpEE86Wav4Yl83jfc
         ItzREtZ65wxcGBYYNIk5iNQ36b6MED0CZh/ygGaINwSO1rehfba2R7sKWagp7brHHKf5
         rg79Ez7uqfQA/BHsOHsR4hGyRDfaEtJsnuRGBoKkKmzowPPbHhww848wcJ0wseG4d6wC
         Xge3yMztth3N/2Vu6mQTE2vxfmDV5v8SpIwBhoGU3L5UP6q+ISmOCvipaAYj/P5ZZF8I
         IgJ1o8eVW74HKrPEoMPptZ89cmk0oDxrIsg18s/Rg7vqdHfUAvhCKbc5roQe7bnKIbrs
         SjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699440659; x=1700045459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bt2bvDjEv0HiaQYd0c4TjFAx6Nfzvf1eIcmbOTXqPwE=;
        b=ZqCxks+tqC9rsvkZb33MCXEbRSluw64ul6Gsrx9UOUtDEO/FLZ76OBV9R547uWs7Ht
         67bJLmEvW2BHq/EfgZfw/XTe+HVa6GDjIeGhousxd8tO7BazcrtkJFUPbprMzqua1tOE
         BSlG4z4XMkHw3dRMaYJexKRFVYvOFC/Tk36gkMuIfW9hsV+1kqfOIWxMRFBhGOIXtCzL
         KkRkHtOYzIJ3VDL1MX07jhuiu+uOd/Jo8lldcRLqG4jFWcwVHLwvgw+PXx3SwDVIEpf8
         NAMiKa8TB+tyv0ME8qUKJxUbj4QLq4dH+xvHWgDqBC43DRD4uuejx3gETK7IunS0gvDo
         8y6w==
X-Gm-Message-State: AOJu0Yz0guWA7Hnnqa6wjaCCVmW09SCnVhBA7BdaX9x1NtdYQ+DfJVFx
        6f+qupQCtpJtFlOzDvx2C9c=
X-Google-Smtp-Source: AGHT+IELClSbAQz1V/0drxjg1UD4ziQ+8CYyLr/3Fhum171i0Mlj3ge6042agi3t4nhAvWOeigTzjQ==
X-Received: by 2002:a05:6a20:4304:b0:16e:26fd:7c02 with SMTP id h4-20020a056a20430400b0016e26fd7c02mr1709920pzk.2.1699440659349;
        Wed, 08 Nov 2023 02:50:59 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id fn3-20020a056a002fc300b0068fe9c7b199sm8728468pfb.105.2023.11.08.02.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 02:50:58 -0800 (PST)
Message-ID: <35c77f16-d01f-4dfd-96a7-2f6210e40e94@gmail.com>
Date:   Wed, 8 Nov 2023 16:20:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs : Fix warning using plain integer as NULL
Content-Language: en-US
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231108101518.e4nriftavrhw45xk@quack3>
 <20231108104730.1007713-1-singhabhinav9051571833@gmail.com>
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231108104730.1007713-1-singhabhinav9051571833@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 16:17, Abhinav Singh wrote:
> Sparse static analysis tools generate a warning with this message
> "Using plain integer as NULL pointer". In this case this warning is
> being shown because we are trying to initialize  pointer to NULL using
> integer value 0.
> 
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>   fs/dax.c       | 2 +-
>   fs/direct-io.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 3380b43cb6bb..423fc1607dfa 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1128,7 +1128,7 @@ static int dax_iomap_copy_around(loff_t pos, uint64_t length, size_t align_size,
>   	/* zero the edges if srcmap is a HOLE or IOMAP_UNWRITTEN */
>   	bool zero_edge = srcmap->flags & IOMAP_F_SHARED ||
>   			 srcmap->type == IOMAP_UNWRITTEN;
> -	void *saddr = 0;
> +	void *saddr = NULL;
>   	int ret = 0;
>   
>   	if (!zero_edge) {
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 20533266ade6..60456263a338 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1114,7 +1114,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>   	loff_t offset = iocb->ki_pos;
>   	const loff_t end = offset + count;
>   	struct dio *dio;
> -	struct dio_submit sdio = { 0, };
> +	struct dio_submit sdio = { NULL, };
>   	struct buffer_head map_bh = { 0, };
>   	struct blk_plug plug;
>   	unsigned long align = offset | iov_iter_alignment(iter);
Thanks a lot  maintainers for looking into this patch and accepting this 
patch.

BR
Abhinav
