Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C987C75A3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379612AbjJLSGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347352AbjJLSGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:06:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586D6BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:06:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-406aaccb41dso4074605e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133975; x=1697738775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lK5NgA77h0nOOLHZGFVttVlkwT2vE2QqNqIM3cExAc8=;
        b=d7+XB/yjl1IgjgLonaF5GX79oor5uGoqlC0pXleThlKPcKAD4VxiXAANOR0yTj+kHu
         26zhho9BvyiJwiqLkxmaOk96EbhHyh82HhSqb2u+IFzvE8mGWdAuw25tjqIq5yHG7Xuz
         M9Z82Yq/R8DFabtA4TtEI6YboTp0rliYV+fZkXCaegsHXMBdwWVeJspmxbKZ8+V1UCJk
         ihDzOS0rHFBk94TOpAc9C4H7FG+Si5iyZSnBI6K2DyNcMpmhHZy9oJQMzRetpaK1wf54
         tfSjIfhdEGOegQo1WqKbhzEJQOtzcEprAaFsjYTCVjGzU7T1YNywCpd0bCdTf4tldrtL
         lUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133975; x=1697738775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lK5NgA77h0nOOLHZGFVttVlkwT2vE2QqNqIM3cExAc8=;
        b=HxCGouTGaGkW7O7jhqJ00l7ZxxGER+SvPvh8948sonbzynPkasNyOLQVrgYzbX7fhi
         vxMiL/mzBPkVAaWoEy2sLRt4aJ4hMnz81zWrg6pBVovulp4r9w/BjEoe2+VcI2gJ8LKs
         g3XDMpUArxgFNasrdKSQ/GpdRuO+r0QHAWKiPtdfycbKtiYmsWNmroNKKKBnSOn62hEy
         gCvX7tZcciXAuB0w4Eei4r5ENsjDTIkTdC0VHMW5z+upiVUtlcNX9uYQ6SSP9k4gvAHe
         dozZrKBILMP9we5mntooqXvT2SCzlmiRQx86u+3OIaaO8jqdLTsyaaN5Qnips1ODPpj5
         vutQ==
X-Gm-Message-State: AOJu0YwBWIsZIsAZkGie5WFrTie3geYZJTTDDKspoTdh3SD55JG9kaZ2
        U+p8Yaqea6X0k6+cu4Y/vrg=
X-Google-Smtp-Source: AGHT+IFJqG9+w9xeiDLVe2R7TC78GlLJe2aOcgx9jc/397+hakApP4whK0onhHZAZVgY1QmiTDq7Aw==
X-Received: by 2002:a05:600c:450f:b0:405:358c:ba75 with SMTP id t15-20020a05600c450f00b00405358cba75mr22419196wmo.0.1697133974307;
        Thu, 12 Oct 2023 11:06:14 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id x8-20020a05600c2a4800b004065daba6casm434015wme.46.2023.10.12.11.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 11:06:13 -0700 (PDT)
Message-ID: <7122db54-438e-4c41-a1b5-c919e47d8679@gmail.com>
Date:   Thu, 12 Oct 2023 20:06:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging/wlan-ng: remove strcpy() use in favor of
 strscpy()
Content-Language: en-US
To:     Calvince Otieno <calvncce@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Archana <craechal@gmail.com>, Dan Carpenter <error27@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-staging@lists.linux.dev
References: <ZSf8VcH8JQ+L+Z/r@lab-ubuntu>
 <2023101234-extenuate-regain-2e36@gregkh>
 <CADFX3OQWXU0bxe17QmCVdASC2oRzMk3A3SBW=5SnO9SSBzR2FA@mail.gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <CADFX3OQWXU0bxe17QmCVdASC2oRzMk3A3SBW=5SnO9SSBzR2FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 19:47, Calvince Otieno wrote:
> On Thu, Oct 12, 2023 at 7:42 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Oct 12, 2023 at 05:01:57PM +0300, Calvince Otieno wrote:
>>> In response to the suggestion by Dan Carpenter on the initial patch,
>>> this patch provides a correct usage of the strscpy() in place of the
>>> current strcpy() implementation.
>>>
>>> strscpy() copies characters from the source buffer to the destination
>>> buffer until one of the following conditions is met:
>>>        - null-terminator ('\0') is encountered in the source string.
>>>        - specified maximum length of the destination buffer is reached.
>>>        - source buffer is exhausted.
>>> Example:
>>>        char dest[11];
>>>        const char *PRISM2_USB_FWFILE = "prism2_ru.fw";
>>>        strscpy(dest, PRISM2_USB_FWFILE, sizeof(dest));
>>>
>>>        In this case, strscpy copies the first 10 characters of src into dest
>>>        and add a null-terminator. dest will then contain "prism2_ru.f" with
>>>        proper null-termination.
>>>
>>> Since the specified length of the dest buffer is not derived from the
>>> dest buffer itself and rather form plug length (s3plug[i].len),
>>> replacing strcpy() with strscpy() is a better option because it will
>>> ensures that the destination string is always properly terminated.
>>>
>>> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
>>> ---
Hi,

Greg wants you to add a changelog here below the "---". Can look like this:
v2 : description of changes

Bye Philipp


>>>   drivers/staging/wlan-ng/prism2fw.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/staging/wlan-ng/prism2fw.c b/drivers/staging/wlan-ng/prism2fw.c
>>> index 5d03b2b9aab4..3ccd11041646 100644
>>> --- a/drivers/staging/wlan-ng/prism2fw.c
>>> +++ b/drivers/staging/wlan-ng/prism2fw.c
>>> @@ -725,7 +725,7 @@ static int plugimage(struct imgchunk *fchunk, unsigned int nfchunks,
>>>
>>>                if (j == -1) {  /* plug the filename */
>>>                        memset(dest, 0, s3plug[i].len);
>>> -                     strncpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - 1);
>>> +                     strscpy(dest, PRISM2_USB_FWFILE, s3plug[i].len);
>>>                } else {        /* plug a PDR */
>>>                        memcpy(dest, &pda->rec[j]->data, s3plug[i].len);
>>>                }
>>> --
>>> 2.34.1
>>>
>>>
>>
>> Hi,
>>
>> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
>> a patch that has triggered this response.  He used to manually respond
>> to these common problems, but in order to save his sanity (he kept
>> writing the same thing over and over, yet to different people), I was
>> created.  Hopefully you will not take offence and will fix the problem
>> in your patch and resubmit it so that it can be accepted into the Linux
>> kernel tree.
>>
>> You are receiving this message because of the following common error(s)
>> as indicated below:
>>
>> - This looks like a new version of a previously submitted patch, but you
>>    did not list below the --- line any changes from the previous version.
>>    Please read the section entitled "The canonical patch format" in the
>>    kernel file, Documentation/process/submitting-patches.rst for what
>>    needs to be done here to properly describe this.
>>
>> If you wish to discuss this problem further, or you have questions about
>> how to resolve this issue, please feel free to respond to this email and
>> Greg will reply once he has dug out from the pending patches received
>> from other developers.
>>
>> thanks,
>>
>> greg k-h's patch email bot
> 
> 
> 
> Hello Greg,
> 
> I did amend my first commit
> 
> I used the command: git commit --amend -v
> The result of this commit action is what I sent over.

