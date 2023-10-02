Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B497B4B0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 06:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjJBEgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 00:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJBEgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 00:36:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83C2BF
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 21:36:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 41be03b00d2f7-578a62c088cso1822771a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 21:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696221379; x=1696826179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IHZ4PtEqrEU6U7oDYDeV4BnN3Q2RTj1pjtCAgfvs8s=;
        b=VcCwfPsGAKWsN7H8wC46LR13Cp5C7amc24dXFGC8egQd6cyKZnxSROnLAk36xP42ZL
         NRJg6stx1JNYTUQ+JhYPYeZ99c76seuBVPmnjEViNZvlU4TUJ4xbjMfiPMJE4fEjJ/u8
         zlTsigZFrmupwVGdz8yJUzKP2cY4T84W35WeRgKmYscsMjGCr5pMCZQ4c1b2br7mJz/i
         5AM9xEKSGNfx4Sc87/KzZkiCC3sGN36B/PRXPstZ4cAOjUVcw0e3X25B5XgQsG/Ik3xg
         FpDFRX2OugLOKwjA7MSG4ASXsHc4T9iLFRHZYUbRJ/C10329Nba9Gkkezq5lFzO7KiGS
         aVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696221379; x=1696826179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IHZ4PtEqrEU6U7oDYDeV4BnN3Q2RTj1pjtCAgfvs8s=;
        b=wLaUpSGYFmKIuFutkrqarr9Kq2VsLwndFcpyjFhgMVdTGx7S4wkQbSJuZWoukk5Llv
         hvm52Qobvr6FKxwdAyA3MTmxYee+/M7IjiQRuTTAoPWFrXfFSNw0vQ693upZA0rkVLh9
         Bol4bs9+am1a0Bb7f+rlml6hIYGreywsLAN2OAWpcLPXGDm81DQSmRWrjjLIe+JJrRdP
         Mbm9GMYt9I/EtswRgWlvkWuQlEfG7CgbLUHu/r9KoOwunasLjfQg9RnI1CJXQXAr75A2
         MOM0BuO+IcAdAgEUsH6zl6q0jmX10AnmRUK3/t0m3Kzr4g6rx5522KdpOUazuM5N/z26
         IeHw==
X-Gm-Message-State: AOJu0Yx7ugmt+fwvLyHcUI4vfjCSw4Fp/XvvLbs0T+9bsoEn9LKW4ciu
        b3NDycl9GDNznJq3lc4lXybfvawsMa+VnVgfkUw=
X-Google-Smtp-Source: AGHT+IHFok1OE9tef/GciC4pOQQCJxcF6Yj34Zg1x8reHcJYXd10NdfQB1RG7Zgj4Wc1aWBHjbkjeg==
X-Received: by 2002:a17:90a:d254:b0:271:78a0:8ab2 with SMTP id o20-20020a17090ad25400b0027178a08ab2mr15024414pjw.24.1696221379098;
        Sun, 01 Oct 2023 21:36:19 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090a2ac600b0027360359b70sm5885636pjg.48.2023.10.01.21.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 21:36:18 -0700 (PDT)
Message-ID: <f03509ef-4501-e686-f484-416a6200fbeb@gmail.com>
Date:   Mon, 2 Oct 2023 10:06:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] jfs : fs array-index-out-of-bounds in txCommit
Content-Language: en-US
To:     shaggy@kernel.org
Cc:     linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+0558d19c373e44da3c18@syzkaller.appspotmail.com
References: <20230919155542.4354-1-ghandatmanas@gmail.com>
From:   Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <20230919155542.4354-1-ghandatmanas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

just a friendly ping

On 19/09/23 21:25, Manas Ghandat wrote:
> Currently there is no check for out of bound access for xad in the
> struct xtpage_t. Added the required check at various places for the same
>
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> Reported-by: syzbot+0558d19c373e44da3c18@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0558d19c373e44da3c18
> Fixes: df0cc57e057f
> ---
>   fs/jfs/jfs_txnmgr.c | 4 ++++
>   fs/jfs/jfs_xtree.c  | 6 ++++++
>   2 files changed, 10 insertions(+)
>
> diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
> index ce4b4760fcb1..6c6640942bed 100644
> --- a/fs/jfs/jfs_txnmgr.c
> +++ b/fs/jfs/jfs_txnmgr.c
> @@ -1722,6 +1722,10 @@ static void xtLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
>   			jfs_err("xtLog: lwm > next");
>   			goto out;
>   		}
> +		if (lwm >= XTROOTMAXSLOT) {
> +			jfs_err("xtLog: lwm out of range");
> +			goto out;
> +		}
>   		tlck->flag |= tlckUPDATEMAP;
>   		xadlock->flag = mlckALLOCXADLIST;
>   		xadlock->count = next - lwm;
> diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
> index 2d304cee884c..57569c52663e 100644
> --- a/fs/jfs/jfs_xtree.c
> +++ b/fs/jfs/jfs_xtree.c
> @@ -357,6 +357,9 @@ static int xtSearch(struct inode *ip, s64 xoff,	s64 *nextp,
>   		for (base = XTENTRYSTART; lim; lim >>= 1) {
>   			index = base + (lim >> 1);
>   
> +			if (index >= XTROOTMAXSLOT)
> +				goto out;
> +
>   			XT_CMP(cmp, xoff, &p->xad[index], t64);
>   			if (cmp == 0) {
>   				/*
> @@ -618,6 +621,9 @@ int xtInsert(tid_t tid,		/* transaction id */
>   		memmove(&p->xad[index + 1], &p->xad[index],
>   			(nextindex - index) * sizeof(xad_t));
>   
> +	if (index >= XTROOTMAXSLOT)
> +		goto out;
> +
>   	/* insert the new entry: mark the entry NEW */
>   	xad = &p->xad[index];
>   	XT_PUTENTRY(xad, xflag, xoff, xlen, xaddr);
