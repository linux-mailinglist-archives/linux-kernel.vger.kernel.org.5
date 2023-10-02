Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B444D7B4B08
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 06:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjJBEfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 00:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJBEfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 00:35:23 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ED6B4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 21:35:19 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1e12f41e496so1856157fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 21:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696221318; x=1696826118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xW3a1nINnEbWotZ8VGaoeFipO2l6o5xih0v3ERc7HM=;
        b=BjlldH3UQmeUjo8tjWhTRIsV92Is6K9NpiWgTBdgQX5pP35xDOigxjZFbJiOE192r+
         K/K/ZWrm/1VWyiHRDmlj5tF3h93ypoWft7qZn75x3g7QQWhh2pldYw97p6TSnxXHj4CC
         CQg9xs98G3J/ygRd23ljnGYaJznWdOCp424QlB4jz5hKnZRn2bBimUmicJwAv142bgCQ
         qcwRjrHsTbLR/cL6dnBUydHyP7ctdh89ezLCa3voymBt+oZOYoM+yZ2TZs2gj0Clcr+B
         xr9wAgTpQIgBccTYzSvKe13t6yQnpuPRa4PY1yw6kckrYuC7+9L4506iTVck9Yu2B1f0
         OcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696221318; x=1696826118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9xW3a1nINnEbWotZ8VGaoeFipO2l6o5xih0v3ERc7HM=;
        b=wxY9ZQVljR9RT/kVUrhkVk+Ov7MRb6azIyGVIvB9FiOf3y/SWQzXjpF8KEjNu39z+C
         FXHkRZbKxNbQoTWsdbDzjMrHbw1SVdhsmXjZERDpAAJJCCgZ86ZuhcAucX/1oNoCJySK
         yP9dxwvQs47psuVZBfxASE92xt6KZPhYsUqe0jzkuUh2NeLCDvHkNrKIG14s1WJU4A4Y
         xbi0UFbfvg30bbQya+IAPT3ZlgaCzYwf3BdI3v3mThe4alNzLsOLivzq50+k0uXUHdwj
         ojgNhvVuD/SQHbttrd+0SH4lsIuPAskoh5R9Yvpaj7EY7KRvFxgUNChPDLfsJeXud9lA
         Xaaw==
X-Gm-Message-State: AOJu0Yy6N++moSshcxDKPpW15T2tRcEH5IUi20Zqk85YUw0MaH47iDO3
        qB6oTRahwfneicQaLrP67n5kzG/qilIw9Q==
X-Google-Smtp-Source: AGHT+IEkNi/NNt+Pv2tFLsCHn+2hQDf1i9nxZM4iCql6G03AqLmJwsazn8elKpMjniaKfvVyPHFnUQ==
X-Received: by 2002:a05:6871:811:b0:1dc:723d:b8d0 with SMTP id q17-20020a056871081100b001dc723db8d0mr13014714oap.27.1696221318480;
        Sun, 01 Oct 2023 21:35:18 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id k67-20020a633d46000000b00577bc070c6bsm17446832pga.68.2023.10.01.21.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 21:35:18 -0700 (PDT)
Message-ID: <cc9825ac-1f5f-a15b-70f1-bdf238e78d32@gmail.com>
Date:   Mon, 2 Oct 2023 10:05:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds in diAlloc
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-kernel-mentees@lists.linuxfoundation.org
References: <20230926071312.14086-1-ghandatmanas@gmail.com>
Content-Language: en-US
From:   Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <20230926071312.14086-1-ghandatmanas@gmail.com>
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

On 26/09/23 12:43, Manas Ghandat wrote:
> Currently there is not check against the agno of the iag while
> allocating new inodes to avoid fragmentation problem. Added the check
> which is required.
>
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> ---
>   fs/jfs/jfs_imap.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 799d3837e7c2..ace8a1506380 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -1355,6 +1355,8 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
>   
>   	/* get the ag number of this iag */
>   	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));
> +	if (agno < 0)
> +		return -EIO;
>   
>   	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
>   		/*
