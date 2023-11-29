Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AA37FCE0A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 05:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376913AbjK2Erv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 23:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjK2Ert (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 23:47:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25820DA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:47:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB815C433C7;
        Wed, 29 Nov 2023 04:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701233275;
        bh=YI4fuxLiITTplMPMdCUaoMC9gkukDp8WeBYUthwy3Es=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=X5O51FlSMIA8mrnaokXk/71U+U4uj+W37AvfVjLvchhEkGGtPbGDchtTkq+qZ+bXF
         U+Z9cVy6RpYC/Op3qo4bYnucpy31LKh50Nj1jqYoSOEz6+FNAYHtanysrqBaaXQ1Qz
         v3XFfvpTvZwkC50YY9o+KzzuyAFgfEkX9N3wPvuCap7O+VTnhChN02dbCkh+Omwa9s
         gTvjDdASLkinOJUqYc4D9vIg7afjn+uN9skV4nIBAyBiSrkm8KCDN7xHkmg2gTwer9
         Z40vnH6f+my/jAzqlV0lPYpGEOgtpV+JP1ASWi0amJTKwxKFMLNdeamq73DgKSONIM
         IxYPH7MjhhzLA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-58d521f12ebso2458906eaf.2;
        Tue, 28 Nov 2023 20:47:55 -0800 (PST)
X-Gm-Message-State: AOJu0Yzep1ftciDa8dDGQTuG6d8b1HYF2QuXXgrBWqaH+2cK0aBTj8nN
        evqhAJfpNDe/VMg5VnbNjh4uqYoAWty6uxQPYU4=
X-Google-Smtp-Source: AGHT+IGb0ugC9E+RvEgS0yj8ZkWshxvDoCAwhaaRXF7Avjz5Pqv71cN5VMYLSwe0bVDR5MICFgpLD2bS7hrmaxhkRY4=
X-Received: by 2002:a05:6820:228c:b0:581:e303:807c with SMTP id
 ck12-20020a056820228c00b00581e303807cmr20742246oob.5.1701233275064; Tue, 28
 Nov 2023 20:47:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:5bce:0:b0:507:5de0:116e with HTTP; Tue, 28 Nov 2023
 20:47:53 -0800 (PST)
In-Reply-To: <328ad7a1-7c54-4028-ae79-eb25c8c7399b@kylinos.cn>
References: <20231120023950.667246-1-zhouzongmin@kylinos.cn> <328ad7a1-7c54-4028-ae79-eb25c8c7399b@kylinos.cn>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 29 Nov 2023 13:47:53 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_FtiMghZ=LCLmOmJer8dHQS-unnVH5cG+75dnAGjmVqA@mail.gmail.com>
Message-ID: <CAKYAXd_FtiMghZ=LCLmOmJer8dHQS-unnVH5cG+75dnAGjmVqA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: initialize ar to NULL
To:     Zongmin Zhou <zhouzongmin@kylinos.cn>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-11-29 12:31 GMT+09:00, Zongmin Zhou <zhouzongmin@kylinos.cn>:
> Friendly ping. I think this patch was forgotten.
Sorry for not sharing it, I have merged it into another patch from
you("ksmbd: prevent memory leak on error return").

Thanks.
>
> Best regards!
>
> On 2023/11/20 10:39, Zongmin Zhou wrote:
>> Initialize ar to NULL to avoid the case of aux_size will be false,
>> and kfree(ar) without ar been initialized will be unsafe.
>> But kfree(NULL) is safe.
>>
>> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
>> Acked-by: Namjae Jeon <linkinjeon@kernel.org>
>> ---
>>   fs/smb/server/ksmbd_work.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
>> index 44bce4c56daf..2510b9f3c8c1 100644
>> --- a/fs/smb/server/ksmbd_work.c
>> +++ b/fs/smb/server/ksmbd_work.c
>> @@ -106,7 +106,7 @@ static inline void __ksmbd_iov_pin(struct ksmbd_work
>> *work, void *ib,
>>   static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int
>> len,
>>   			       void *aux_buf, unsigned int aux_size)
>>   {
>> -	struct aux_read *ar;
>> +	struct aux_read *ar = NULL;
>>   	int need_iov_cnt = 1;
>>
>>   	if (aux_size) {
>
>
