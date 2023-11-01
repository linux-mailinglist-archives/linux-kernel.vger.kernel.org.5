Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49E97DDCC9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343954AbjKAGm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbjKAGmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:42:25 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEADDA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 23:42:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc29f39e7aso30298325ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 23:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698820939; x=1699425739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=osCkAZShR5taCW6SV1HsSXC0KNTVnjVownZWdu919kU=;
        b=Io6Qj7yNgoPY1FdaUDOUOhnpUIR+bWHmoe5xrw3ld5PsIWhyzZCfPIVubd2ZPvw61K
         WAAZp3aQBj3rNejnT092QVRA+Ocb4Ce+0iPiGEzAVOzB/vyoFQoPHj6Xw6Q2R5Sc4AL1
         kkSJls6bBk4H0Rgx5+eBSGpvziKsmr3r6zZGeOOElyOelWTZ7tyXdW47fXXqgoYndELw
         SLTyONe5+DPMoR7aFw+RrbSga8BEk4s0p4PKt18rpywNYTbgRyWcNYA6KvyJ7eNFmFOU
         WqTfzlHuGoN3pCJ/9Z5Q3PJ29wIkmDn9h8CcBlFihhm1NHBuTe/16Zirjg7DTVR0BFv6
         Ekaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698820939; x=1699425739;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osCkAZShR5taCW6SV1HsSXC0KNTVnjVownZWdu919kU=;
        b=VDY4vKzq5Lsy6tHjNTwjVkoHKmIr9uL4lw4qWk+MGgHysbIdeEffAbPfrcf01a4i2F
         MmHLYGXdwC2/zIGbDwRpFbyD6Rw4obf3bGjtrwX7txCjVFpUWskr6rQUuEaw7PZb2PIg
         XNSnjdrB9sMYFB2oxDK3yAnbH2LSIrxn+JoBQc4agVNxJwpRhRoswARegBsNud0YvjMT
         TRn2ITMCr9Hq1jvFzSNQ89mYJgyujukXBN4EUo3qi9HYxcgZZ3qzcYKXXIBEvwELLP5e
         M8IkC4DGuf+Zzd9Hfcg0Kqi1CH5TTJXAxJ0zdz26NcRrAXe9t+Zzv1BU4a2hL/2MPuRi
         gTiA==
X-Gm-Message-State: AOJu0Ywhotw9l/Pe63pdwu06/GTF2NDtPPd0GKdXluA1sGzn0u3/0/O+
        TRXLbBur2hWyP5CQDgiVbL4=
X-Google-Smtp-Source: AGHT+IE/xBdJG3FdMjRMwmd2VFlP290FD035x4hYgrrl8p8Rnijmg1W6YwuFF+MOaVxffZq50NAlGw==
X-Received: by 2002:a17:902:cf46:b0:1cc:6cc3:d9ba with SMTP id e6-20020a170902cf4600b001cc6cc3d9bamr2807830plg.4.1698820938942;
        Tue, 31 Oct 2023 23:42:18 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902f1d300b001b898595be7sm624620plc.291.2023.10.31.23.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 23:42:18 -0700 (PDT)
Message-ID: <a63a6936-8422-47d5-9fc5-5c40a9915665@gmail.com>
Date:   Wed, 1 Nov 2023 12:12:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix shift-out-of-bounds in dbJoin
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     dave.kleikamp@oracle.com, shaggy@kernel.org
Cc:     Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+411debe54d318eaed386@syzkaller.appspotmail.com
References: <20231011143937.31996-1-ghandatmanas@gmail.com>
 <50a32ba6-0051-6b70-aa8a-f565f8119a69@gmail.com>
Content-Language: en-US
In-Reply-To: <50a32ba6-0051-6b70-aa8a-f565f8119a69@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, can you please review this patch

On 16/10/23 20:30, Manas Ghandat wrote:
> Just a friendly ping :)
>
> On 11/10/23 20:09, Manas Ghandat wrote:
>> Currently while joining the leaf in a buddy system there is shift out
>> of bound error in calculation of BUDSIZE. Added the required check
>> to the BUDSIZE and fixed the documentation as well.
>>
>> Reported-by: syzbot+411debe54d318eaed386@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=411debe54d318eaed386
>> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
>> ---
>>   fs/jfs/jfs_dmap.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
>> index 6b838d3ae7c2..baa97bda1c7a 100644
>> --- a/fs/jfs/jfs_dmap.c
>> +++ b/fs/jfs/jfs_dmap.c
>> @@ -2730,7 +2730,9 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
>>    *    leafno    - the number of the leaf to be updated.
>>    *    newval    - the new value for the leaf.
>>    *
>> - * RETURN VALUES: none
>> + * RETURN VALUES:
>> + *  0        - success
>> + *    -EIO    - i/o error
>>    */
>>   static int dbJoin(dmtree_t * tp, int leafno, int newval)
>>   {
>> @@ -2757,6 +2759,10 @@ static int dbJoin(dmtree_t * tp, int leafno, 
>> int newval)
>>            * get the buddy size (number of words covered) of
>>            * the new value.
>>            */
>> +
>> +        if ((newval - tp->dmt_budmin) > BUDMIN)
>> +            return -EIO;
>> +
>>           budsz = BUDSIZE(newval, tp->dmt_budmin);
>>             /* try to join.
