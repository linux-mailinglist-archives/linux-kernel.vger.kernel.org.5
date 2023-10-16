Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645D87CACCA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjJPPCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjJPPB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:01:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EF4FC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:01:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1bdf4752c3cso26027885ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697468515; x=1698073315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JnnS58IgMMW37G00hlv3uANnt69yT13t13Z0Wl0btSI=;
        b=AQIayMJa2kmwZh5LUNdZm2a2awGREzOBWg2wtGfqwnq5OBCs0paKErKiXrXfz79Q1d
         NqhAdC1NHQQPc5AecKTFTxu3HKSmnK/tUXgYSX/p1L6kWeY4ItNRc6XK+FWrg9fQE2LE
         9/zLtgWb2/I0OqJyGOQOqRR0KuNu3P3Hs2USS7qfLg7fYKuAMTXQlTqshJTkY1j+QL3N
         o015M0b6JJqKfySqgXh7SNsX5pxnDGYavLECcBTJ3G7uNmdwONu7kzyluWVqoaolEwJU
         rQTSiecdliwwdAJnUwySMRo0FNXX/Ek5OK+mquFBw2NpwBo9Lu42hPh3evezC85v/4Ho
         uuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697468515; x=1698073315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnnS58IgMMW37G00hlv3uANnt69yT13t13Z0Wl0btSI=;
        b=LTNZ4mY0p6qM6V53seYwVBNn6trKLDJIQK70GpG8Vw2JuTXgCYxT3+xBQqpKvsujjm
         iYMN2LgrlUpTkbly/4gvXPog/z8QxfxUh8qeZRCnvKKvUtwxsGY4+nZvW677iLGgHwnL
         aMPnYy1dRacYRV0V1nJFnrRW/Bh7vDJvIy4eOdJvhoO7MaAy/gduSXBr1veJy48nzJQW
         SVZk1hPIzvIHhHU1CS5bdq8cQU3nKS/sOQ8+CzOA3mLPOuK++3wv2kPIWYbufR1URoJG
         qC7upqLOsty0L1q/hNHYA/cEaYl9Ibp7pzj7arzYM9JeNRsyKfFixut6+Z8BGCn3YlDa
         CeoA==
X-Gm-Message-State: AOJu0YyEXvJqJruofcSgnIg62yxQJeBTuqrgl5ZceB2HNddM88G5Ih65
        +YyciD7PPwUyevNEUxRdntQ=
X-Google-Smtp-Source: AGHT+IFT6Dq4J/EVcOv+em6QWTH7/Ht//OA+UE5IFyVPLa0/LDab/gjnaYbmFu2DaSdjzjdENCEB5A==
X-Received: by 2002:a17:902:988d:b0:1c9:b207:d412 with SMTP id s13-20020a170902988d00b001c9b207d412mr15460340plp.37.1697468514526;
        Mon, 16 Oct 2023 08:01:54 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902eb0d00b001b890009634sm8574379plb.139.2023.10.16.08.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 08:01:54 -0700 (PDT)
Message-ID: <c4af0ef6-56e2-089e-e1b3-55574f6964c6@gmail.com>
Date:   Mon, 16 Oct 2023 20:31:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] jfs : fix array-index-out-of-bounds in diWrite
Content-Language: en-US
To:     dave.kleikamp@oracle.com, shaggy@kernel.org
Cc:     Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com
References: <20231008174745.27342-1-ghandatmanas@gmail.com>
From:   Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <20231008174745.27342-1-ghandatmanas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a friendly ping :)

On 08/10/23 23:17, Manas Ghandat wrote:
> Currently while copying dtree root from inode to dnode in the xp slot
> there is a out of bound memcpy. Added a bound check to the memcpy.
>
> Reported-by: syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com
> Fixes: https://syzkaller.appspot.com/bug?extid=c1056fdfe414463fdb33
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> ---
>   fs/jfs/jfs_imap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 799d3837e7c2..d1f897848be0 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -746,7 +746,8 @@ int diWrite(tid_t tid, struct inode *ip)
>   		xp = (dtpage_t *) & dp->di_dtroot;
>   		lv = ilinelock->lv;
>   		for (n = 0; n < ilinelock->index; n++, lv++) {
> -			memcpy(&xp->slot[lv->offset], &p->slot[lv->offset],
> +			if (lv->offset < 128)
> +				memcpy(&xp->slot[lv->offset], &p->slot[lv->offset],
>   			       lv->length << L2DTSLOTSIZE);
>   		}
>   	} else {
