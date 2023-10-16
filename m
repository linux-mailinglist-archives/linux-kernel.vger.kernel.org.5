Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AEA7CACC0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjJPPAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjJPPAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:00:42 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD02B9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:00:40 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 46e09a7af769-6c61d955161so2771824a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697468439; x=1698073239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fE5UoW9vdKH2feO+bDEwIT8Ft2NGameqkjIHnMibMyQ=;
        b=aYTKT7MvJlPtDeqeCy5An16Y2ZWjwAp6bdsGfkfdsRN3KfxX6yTWavrITFPruxf2Dj
         w+HtXohKrTIhuA8h2lteOGIeCREGVduPpnrK4ht9ieBVSANbBiD/4znC+SPUYSdJM+Fy
         WXT+BH4XQn0UbdNklsDlxNYpMC21TYerEYPLRChCG0gHPiHBxFhyqXERdviaAlwGW1YX
         coBEF48pLN/2kU80yykXwcgnaiafVDuwyCkyrDexkWgG/ZsJnJXExcD5d4NmYITkxGLt
         R7J5hkrSohUOYs0VsCjWFXKZnxaMr02Yf5n6Hsw2AxKYTrUSH3AGQ32Hp5cE3FLUz7Oh
         fkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697468439; x=1698073239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fE5UoW9vdKH2feO+bDEwIT8Ft2NGameqkjIHnMibMyQ=;
        b=H320NKFklZR6lK06JhgwgaNLfoZuYRh5hSI0ilq3GVMvbD89pk0Z7Z8zGL5xo3v9wY
         pwf+2a//206ZpdYnU9qAAh4yVcVbus2o3xs/cLMCzA7pWUi1ooMSQvPtCON6fkPb6mDg
         6FEvQbDcpGOyLBP5e8eTwtSn/HX0HL0ZaHH0X0taPMvU86fnsZ+bdCcLlWmxXoXBAvBi
         NiZLlLQixYYj7WwYg/O6EX433fTX7hI/ENrNSN+j3Ey/UiJz939V7GkHmhUw94b2XU23
         6cLCklNGVSrKS39mcqjKpy3sA+mS2QTajE8i9ULkXc3KlFDESYEAxKM+JkWrAT9duWN/
         PgPw==
X-Gm-Message-State: AOJu0Yyq9F1BTpPOEWBqnBh/m8Pxm7lUtN0YfE/m9bJ+rXeB/dXvxbak
        WYxHoqcE4htwknY6Uhq9Zz8=
X-Google-Smtp-Source: AGHT+IG+nSpv7E/GZMd53ppQO+XRAkVwTQ5NdDnDdqv/DnwRvoEQjEn3reBSiU5yAuUwdF5DsqdadQ==
X-Received: by 2002:a05:6870:2c99:b0:1e9:a5f2:aab3 with SMTP id oh25-20020a0568702c9900b001e9a5f2aab3mr13474131oab.57.1697468439317;
        Mon, 16 Oct 2023 08:00:39 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id k9-20020aa79729000000b006bd6a0a4678sm3037911pfg.80.2023.10.16.08.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 08:00:38 -0700 (PDT)
Message-ID: <50a32ba6-0051-6b70-aa8a-f565f8119a69@gmail.com>
Date:   Mon, 16 Oct 2023 20:30:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] jfs: fix shift-out-of-bounds in dbJoin
To:     dave.kleikamp@oracle.com, shaggy@kernel.org
Cc:     Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+411debe54d318eaed386@syzkaller.appspotmail.com
References: <20231011143937.31996-1-ghandatmanas@gmail.com>
Content-Language: en-US
From:   Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <20231011143937.31996-1-ghandatmanas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a friendly ping :)

On 11/10/23 20:09, Manas Ghandat wrote:
> Currently while joining the leaf in a buddy system there is shift out
> of bound error in calculation of BUDSIZE. Added the required check
> to the BUDSIZE and fixed the documentation as well.
>
> Reported-by: syzbot+411debe54d318eaed386@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=411debe54d318eaed386
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> ---
>   fs/jfs/jfs_dmap.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 6b838d3ae7c2..baa97bda1c7a 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -2730,7 +2730,9 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
>    *	leafno	- the number of the leaf to be updated.
>    *	newval	- the new value for the leaf.
>    *
> - * RETURN VALUES: none
> + * RETURN VALUES:
> + *  0		- success
> + *	-EIO	- i/o error
>    */
>   static int dbJoin(dmtree_t * tp, int leafno, int newval)
>   {
> @@ -2757,6 +2759,10 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
>   		 * get the buddy size (number of words covered) of
>   		 * the new value.
>   		 */
> +
> +		if ((newval - tp->dmt_budmin) > BUDMIN)
> +			return -EIO;
> +
>   		budsz = BUDSIZE(newval, tp->dmt_budmin);
>   
>   		/* try to join.
