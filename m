Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C797C8275
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjJMJt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjJMJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:49:57 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BE895
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:49:55 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57ba5f05395so1062465eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697190594; x=1697795394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8MkPWND7FIkLGaSpYdCJBetKFsUpZ+ghS1+KD9FYO1o=;
        b=RGqBYNKDyc/5d0B/BO7536+ukuFlMmPAuq+admErSsxEcZQ04EAaxxl11Uc5XdZI85
         NBX293QIkq01D37VlJnWvejqH1a5qmRnRjJZqOR0oMoUHncp+glwccQQdgEfuvzeEAQX
         OfOw1YKjK6tmNeFTz5XkO8+6RbszyCnPurJBuUcCggjs06nxMWspSW5KDtvWyfU+daKb
         xI71C0iXCfJV0ye7wIWJWF9fxtkDrIxVPtjXOX9+V5nLK02e6NYm4RcZ/uGQiTd1apMd
         pKbXHhBbtXHlMH0o0m4LwbyN1/Oewp9kBvrQaKBxaeFxb1zx5dflHmOvNqE9dkz9mNgV
         aEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697190594; x=1697795394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MkPWND7FIkLGaSpYdCJBetKFsUpZ+ghS1+KD9FYO1o=;
        b=Ob55/LYAabTfTHS6/X7bdz9JEXRINg6fhPEaXU957me+Rjm6Z0ZIfirwkbVlZvM1/E
         7faab481xqxZeFJXM4bfmo0Ippec+EAiknGjejNSta1t4Reyh9jZ701g9Polkfzh2u/r
         KoQn8XHfHvhgFnS2dCZJJUmXKEnPlCM3qwOFM4IxKG5D+gri037bxXGfJyXBz39NZ1hX
         yRyDaPddLfVRE6056TZAZnjD7EVin8NGCom9Rd8z9n4fh+VYbqRHLfRYM9OP0ciW8W73
         JZ/Wls06NBjvZpA60HlDk/4n6eblFKiwQrVkNROMKzaf41EzFSO68HpQmUSSZv+TeSYu
         WNVw==
X-Gm-Message-State: AOJu0Yy4f5N54QBPZEf81ze5Y+iW7wNJvspA38R9syoKhxInsW2E54D9
        oxoP6ck1s7z2mkv8zRNNYMw=
X-Google-Smtp-Source: AGHT+IGIXctYQD3YbPZTMQ8Deht71+5hv/JyjFhdZPDyakxzik07y6xT2JwDpoQhOrITnjwqYHKjpw==
X-Received: by 2002:a05:6358:3994:b0:145:794e:ac30 with SMTP id b20-20020a056358399400b00145794eac30mr28075515rwe.17.1697190594478;
        Fri, 13 Oct 2023 02:49:54 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78283000000b00692b6fe1c7asm13559396pfm.179.2023.10.13.02.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 02:49:54 -0700 (PDT)
Message-ID: <4266e5dd-39d8-05ec-d420-4f4c78c5f016@gmail.com>
Date:   Fri, 13 Oct 2023 15:19:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] jfs : fs array-index-out-of-bounds in txCommit
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+0558d19c373e44da3c18@syzkaller.appspotmail.com
References: <20230919155542.4354-1-ghandatmanas@gmail.com>
 <423182d1-3d75-4a73-9011-da24658a40cc@oracle.com>
 <3d4e0f62-35bb-4b18-a64c-191c88415032@gmail.com>
 <52616ab2-6f8a-4313-a687-91a8d1081c8b@oracle.com>
Content-Language: en-US
From:   Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <52616ab2-6f8a-4313-a687-91a8d1081c8b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/23 19:50, Dave Kleikamp wrote:

> On 10/5/23 12:15AM, Manas Ghandat wrote:
>> On 04/10/23 00:46, Dave Kleikamp wrote:
>>> The size of the xad array can be either XTROOTMAXSLOT or 
>>> XTPAGEMAXSLOT depending on whether it is the root, imbedded in the 
>>> inode, or not. It is currently declared with the smaller value so we 
>>> can use xtpage_t within the inode.
>>>
>>> I had promised to address this, but haven't gotten to it yet. I'll 
>>> try to carve out some time to do that.
>>>
>>> Thanks,
>>> Shaggy
>>
>> Can you guide with the workflow of how things should be done. I can 
>> try to work on it and resolve the issue.
>>
>
> I was able to cobble this together. It compiles cleanly, but I haven't
> tested it yet.
>
> In order to make array bounds checking sane, provide a separate
> definition of the in-inode xtree root and the external xtree page.
>
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>  fs/jfs/jfs_dinode.h |  2 +-
>  fs/jfs/jfs_imap.c   |  6 +++---
>  fs/jfs/jfs_incore.h |  2 +-
>  fs/jfs/jfs_txnmgr.c |  4 ++--
>  fs/jfs/jfs_xtree.c  |  4 ++--
>  fs/jfs/jfs_xtree.h  | 37 +++++++++++++++++++++++--------------
>  6 files changed, 32 insertions(+), 23 deletions(-)
>
> diff --git a/fs/jfs/jfs_dinode.h b/fs/jfs/jfs_dinode.h
> index 6b231d0d0071..603aae17a693 100644
> --- a/fs/jfs/jfs_dinode.h
> +++ b/fs/jfs/jfs_dinode.h
> @@ -96,7 +96,7 @@ struct dinode {
>  #define di_gengen    u._file._u1._imap._gengen
>
>              union {
> -                xtpage_t _xtroot;
> +                xtroot_t _xtroot;
>                  struct {
>                      u8 unused[16];    /* 16: */
>                      dxd_t _dxd;    /* 16: */
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 1b267eec3f36..394e0af0e5df 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -670,7 +670,7 @@ int diWrite(tid_t tid, struct inode *ip)
>           * This is the special xtree inside the directory for storing
>           * the directory table
>           */
> -        xtpage_t *p, *xp;
> +        xtroot_t *p, *xp;
>          xad_t *xad;
>
>          jfs_ip->xtlid = 0;
> @@ -684,7 +684,7 @@ int diWrite(tid_t tid, struct inode *ip)
>           * copy xtree root from inode to dinode:
>           */
>          p = &jfs_ip->i_xtroot;
> -        xp = (xtpage_t *) &dp->di_dirtable;
> +        xp = (xtroot_t *) &dp->di_dirtable;
>          lv = ilinelock->lv;
>          for (n = 0; n < ilinelock->index; n++, lv++) {
>              memcpy(&xp->xad[lv->offset], &p->xad[lv->offset],
> @@ -713,7 +713,7 @@ int diWrite(tid_t tid, struct inode *ip)
>       *    regular file: 16 byte (XAD slot) granularity
>       */
>      if (type & tlckXTREE) {
> -        xtpage_t *p, *xp;
> +        xtroot_t *p, *xp;
>          xad_t *xad;
>
>          /*
> diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
> index 721def69e732..dd4264aa9bed 100644
> --- a/fs/jfs/jfs_incore.h
> +++ b/fs/jfs/jfs_incore.h
> @@ -66,7 +66,7 @@ struct jfs_inode_info {
>      lid_t    xtlid;        /* lid of xtree lock on directory */
>      union {
>          struct {
> -            xtpage_t _xtroot;    /* 288: xtree root */
> +            xtroot_t _xtroot;    /* 288: xtree root */
>              struct inomap *_imap;    /* 4: inode map header    */
>          } file;
>          struct {
> diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
> index ce4b4760fcb1..dccc8b3f1045 100644
> --- a/fs/jfs/jfs_txnmgr.c
> +++ b/fs/jfs/jfs_txnmgr.c
> @@ -783,7 +783,7 @@ struct tlock *txLock(tid_t tid, struct inode *ip, 
> struct metapage * mp,
>              if (mp->xflag & COMMIT_PAGE)
>                  p = (xtpage_t *) mp->data;
>              else
> -                p = &jfs_ip->i_xtroot;
> +                p = (xtpage_t *) &jfs_ip->i_xtroot;
>              xtlck->lwm.offset =
>                  le16_to_cpu(p->header.nextindex);
>          }
> @@ -1676,7 +1676,7 @@ static void xtLog(struct jfs_log * log, struct 
> tblock * tblk, struct lrd * lrd,
>
>      if (tlck->type & tlckBTROOT) {
>          lrd->log.redopage.type |= cpu_to_le16(LOG_BTROOT);
> -        p = &JFS_IP(ip)->i_xtroot;
> +        p = (xtpage_t *) &JFS_IP(ip)->i_xtroot;
>          if (S_ISDIR(ip->i_mode))
>              lrd->log.redopage.type |=
>                  cpu_to_le16(LOG_DIR_XTREE);
> diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
> index 2d304cee884c..5ee618d17e77 100644
> --- a/fs/jfs/jfs_xtree.c
> +++ b/fs/jfs/jfs_xtree.c
> @@ -1213,7 +1213,7 @@ xtSplitRoot(tid_t tid,
>      struct xtlock *xtlck;
>      int rc;
>
> -    sp = &JFS_IP(ip)->i_xtroot;
> +    sp = (xtpage_t *) &JFS_IP(ip)->i_xtroot;
>
>      INCREMENT(xtStat.split);
>
> @@ -2098,7 +2098,7 @@ int xtAppend(tid_t tid,        /* transaction id */
>   */
>  void xtInitRoot(tid_t tid, struct inode *ip)
>  {
> -    xtpage_t *p;
> +    xtroot_t *p;
>
>      /*
>       * acquire a transaction lock on the root
> diff --git a/fs/jfs/jfs_xtree.h b/fs/jfs/jfs_xtree.h
> index ad7592191d76..0f6cf5a1ce75 100644
> --- a/fs/jfs/jfs_xtree.h
> +++ b/fs/jfs/jfs_xtree.h
> @@ -65,24 +65,33 @@ struct xadlist {
>  #define XTPAGEMAXSLOT    256
>  #define XTENTRYSTART    2
>
> -/*
> - *    xtree page:
> - */
> -typedef union {
> -    struct xtheader {
> -        __le64 next;    /* 8: */
> -        __le64 prev;    /* 8: */
> +struct xtheader {
> +    __le64 next;    /* 8: */
> +    __le64 prev;    /* 8: */
>
> -        u8 flag;    /* 1: */
> -        u8 rsrvd1;    /* 1: */
> -        __le16 nextindex;    /* 2: next index = number of entries */
> -        __le16 maxentry;    /* 2: max number of entries */
> -        __le16 rsrvd2;    /* 2: */
> +    u8 flag;    /* 1: */
> +    u8 rsrvd1;    /* 1: */
> +    __le16 nextindex;    /* 2: next index = number of entries */
> +    __le16 maxentry;    /* 2: max number of entries */
> +    __le16 rsrvd2;    /* 2: */
>
> -        pxd_t self;    /* 8: self */
> -    } header;        /* (32) */
> +    pxd_t self;    /* 8: self */
> +};
>
> +/*
> + *    xtree root (in inode):
> + */
> +typedef union {
> +    struct xtheader header;
>      xad_t xad[XTROOTMAXSLOT];    /* 16 * maxentry: xad array */
> +} xtroot_t;
> +
> +/*
> + *    xtree page:
> + */
> +typedef union {
> +    struct xtheader header;
> +    xad_t xad[XTPAGEMAXSLOT];    /* 16 * maxentry: xad array */
>  } xtpage_t;
>
>  /*

I tested this patch and it has not triggered any bug.

