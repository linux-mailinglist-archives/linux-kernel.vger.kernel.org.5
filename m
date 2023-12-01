Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C4B8001B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376736AbjLACmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjLACmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:42:53 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F6510F0;
        Thu, 30 Nov 2023 18:42:59 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 46e09a7af769-6d63e0412faso308369a34.1;
        Thu, 30 Nov 2023 18:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701398579; x=1702003379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MM6zOSHfotTy5a3LWtQadC0cfDBk1X3drmNbLjZWVJ4=;
        b=a7LoTtFOeFoZn/FFM8bmEft14BvGtOiqDYlj7t5verf7jao3HBO5LSpW/EM2I4RJZm
         hMWkSULWWhi4tIEnkdnUUuSiRgzBmvNyHE6wDTMjWyQsUleOkxwWAQ4m9qmJlMxX29qQ
         k0vo20xWVV2J+1Tfo2d45Wh/bzSa7SceM46ONCn3E1kIXn+W2HhzAYB5pwqoKb47RKwv
         HaFKhB3BpJqUWqNSaaH0SDXCZzm7FWp1iKmz+CvuO6Q0dr2jIDBmpjVLnbYx2MIioNr0
         GInPaixyk0esyYsGB6uvxCX6nKgcwQt5qmWb7RlvoZOYPHnfks8siVOdkPRzJUC46Ph8
         gO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701398579; x=1702003379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MM6zOSHfotTy5a3LWtQadC0cfDBk1X3drmNbLjZWVJ4=;
        b=phOqSWPSQ5R+1RlfoMWEjTBQ00Z0SgV6dxvLzS6GdqUwrEVpxsvrA3nDTV4hD0xIfo
         f4Z4V2duYTxD7OqReDrXXpUmOig+mVg7YTLZnqehxz1wAReB/prJf/sZ9wvlJgD4ZsLB
         nTOSC75m7aN9rRpBpVJ28FDO0I/tTLL+GoaDJys0eINgX2S+ohOvmjwpypEvCpQ8oPQx
         YzXMC0krI9qrTw8LNJP3YkHVAXOA/mVmuspHUlSZBnwsyITsWTYe8qwqm9XU3m3WONxK
         cZn3QwLSZt+b2D26A16Fk1Q1tMTSkMJQWE01iYxfRKP/6MEZzaghrGm5As1yFEYP+9H1
         7U1g==
X-Gm-Message-State: AOJu0YwAQsFt7WJe9UJfv89a/qh8mUIzsUPYlrzHng3dGfXAVEz2Aq3f
        isHWSV4IGFplXCyQS2TY0JQ=
X-Google-Smtp-Source: AGHT+IGAmKyOWThKwBSLYYZ7hWRY5tfC/8Cayt9qi7FXH3blX7nQbeynFVsLjcG/JK2m7QrnKT03Yw==
X-Received: by 2002:a05:6808:2121:b0:3b8:5fb1:3574 with SMTP id r33-20020a056808212100b003b85fb13574mr23156182oiw.0.1701398578738;
        Thu, 30 Nov 2023 18:42:58 -0800 (PST)
Received: from [127.0.0.1] (059149129201.ctinets.com. [59.149.129.201])
        by smtp.gmail.com with ESMTPSA id c14-20020a62e80e000000b006cdf2097fd1sm1292442pfi.151.2023.11.30.18.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 18:42:58 -0800 (PST)
Message-ID: <27ad4e0d-ba00-449b-84b9-90f3ba7e4232@gmail.com>
Date:   Fri, 1 Dec 2023 10:42:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: fuse: dax: set fc->dax to NULL in
 fuse_dax_conn_free()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     vgoyal@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com
References: <20231116075726.28634-1-hbh25y@gmail.com>
 <CAJfpegvN5Rzy1_2v3oaf1Rp_LP_t3w6W_-Ozn1ADoCLGSKBk+Q@mail.gmail.com>
Content-Language: en-US
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <CAJfpegvN5Rzy1_2v3oaf1Rp_LP_t3w6W_-Ozn1ADoCLGSKBk+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2023 18:54, Miklos Szeredi wrote:
> On Thu, 16 Nov 2023 at 08:57, Hangyu Hua <hbh25y@gmail.com> wrote:
>>
>> fuse_dax_conn_free() will be called when fuse_fill_super_common() fails
>> after fuse_dax_conn_alloc(). Then deactivate_locked_super() in
>> virtio_fs_get_tree() will call virtio_kill_sb() to release the discarded
>> superblock. This will call fuse_dax_conn_free() again in fuse_conn_put(),
>> resulting in a possible double free.
>>
>> Fixes: 1dd539577c42 ("virtiofs: add a mount option to enable dax")
>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>> ---
>>   fs/fuse/dax.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
>> index 23904a6a9a96..12ef91d170bb 100644
>> --- a/fs/fuse/dax.c
>> +++ b/fs/fuse/dax.c
>> @@ -1222,6 +1222,7 @@ void fuse_dax_conn_free(struct fuse_conn *fc)
>>          if (fc->dax) {
>>                  fuse_free_dax_mem_ranges(&fc->dax->free_ranges);
>>                  kfree(fc->dax);
>> +               fc->dax = NULL;
> 
> Is there a reason not to simply remove the fuse_dax_conn_free() call
> from the cleanup path in fuse_fill_super_common()?

I think setting fc->dax to NULL keeps the memory allocation and release 
functions together in fuse_fill_super_common more readable. What do you 
think?

Thanks,
Hangyu

> 
> Thanks,
> Miklos
> 
> 
>>          }
>>   }
>>
>> --
>> 2.34.1
>>
