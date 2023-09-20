Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E37A8807
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbjITPTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjITPS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:18:59 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1FEAD;
        Wed, 20 Sep 2023 08:18:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-564af0ac494so5044412a12.0;
        Wed, 20 Sep 2023 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695223133; x=1695827933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvIkPnTGjA9TvBMyuBkisN/scCEl8tlz0F2bE1tw4V8=;
        b=eQ5Xp5+2chfD116Vt2cQmf3gXI6Ei6CDDCQBLhCWiyOzUvV+1Bvtl0qLjaP5t6mBkO
         Uhg6N7hTF5hujdhCxxnE7ZqJj+c7dNdWS6R1HcpSrkCau8drsRn4XwAMUXY1uT7bM7Ha
         1bPJL9CnTpTTkVzn905JqDNDpkECpYQepgerZygbjg923OVlChDIDxRUnAz6HkAyB8nc
         0uwSrjLx/Qt287+/D3/ImkHtRVjb/DZR5aAb5quWjFs33sxLPCCMiwubaQh3uedU/gAM
         ig+/c+BzZRRXeJ2Sh7OhoQ8M+PzNoNUNVf9Zai9Tnp/ED1vuWtiy2lNEquBrHkleeJQt
         Mbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695223133; x=1695827933;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvIkPnTGjA9TvBMyuBkisN/scCEl8tlz0F2bE1tw4V8=;
        b=B07lwOUVlWsQNPORUs7ewqrrLsDNF3So8qm4HjAzweyUwpcddBvj80SMRB5+ZaTePz
         xEC1KWoSP+LsfRT3UHObMDi4ie51vewnWhFsJL6wHlY+bmBfnhlEKcKqkn0S4lVyK1Un
         Hm8OlX2ZQeN8fojTH2t1xmnxpHN5hx1b7dy8o1U8w2DgrrVDOZ74dpM2onTirjOLHNkg
         MzHwiCY5umSmy/TCjl8bn7rwR9s39DvEFo8ehWOjV20f/pS4dPyxtmtJyyxBySfd/o8l
         j+vPvzQSNG0gigbCD8/HtDWvIQdjMVu9tzUVX/h4coXXY2SsZeMZiQXky376i8vRWzZh
         UDVA==
X-Gm-Message-State: AOJu0Yw3ThX2+NFV1dtT/wjEKq+ptM8S7CEY34BsegepgaLiun3tan7M
        XTrkMrW/vJrZpxKWcF99E+Khf91KRz8=
X-Google-Smtp-Source: AGHT+IGCBsAwAwTXPdN9DNx7Pd57SrP01DlRc9rIKrwjQ1cHujamzucUqKtQzKLV8keq9QmyAS8Lwg==
X-Received: by 2002:a05:6a20:552a:b0:140:c838:2b2e with SMTP id ko42-20020a056a20552a00b00140c8382b2emr2401423pzb.22.1695223133090;
        Wed, 20 Sep 2023 08:18:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090a670900b002630c9d78aasm1460942pjj.5.2023.09.20.08.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 08:18:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <27f978f3-11ca-6054-5160-ab66d4c918bc@roeck-us.net>
Date:   Wed, 20 Sep 2023 08:18:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Zeng <zengyhkyle@gmail.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230917191101.035638219@linuxfoundation.org>
 <07a04540-554c-4394-1e79-46ea665f8c03@roeck-us.net>
 <2023092009-angriness-sank-ae4f@gregkh>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.10 000/406] 5.10.195-rc1 review
In-Reply-To: <2023092009-angriness-sank-ae4f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 01:11, Greg Kroah-Hartman wrote:
> On Tue, Sep 19, 2023 at 09:57:25PM -0700, Guenter Roeck wrote:
>> On 9/17/23 12:07, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.10.195 release.
>>> There are 406 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
>>> Anything received after that time might be too late.
>>>
>>
>> chromeos-5.10 locks up in configfs_lookup() after the merge of v5.10.195.
>>
>> I am a bit puzzled because I see
>>
>> c709c7ca020a configfs: fix a race in configfs_lookup()
>>
>> in v5.10.195 but not in the list of commits below. I guess I must be
>> missing something.
> 
> It was part of the big patchset, it was posted here:
> 	https://lore.kernel.org/r/20230917191101.511939651@linuxfoundation.org
> 
> Not hidden at all :)
> 
> and was submitted here:
> 	https://lore.kernel.org/r/ZPOZFHHA0abVmGx+@westworld
> 
>> Either case, the code now looks as follows.
>>
>> configfs_lookup()
>> {
>>      ...
>>      spin_lock(&configfs_dirent_lock);
>>      ...
>>          err = configfs_attach_attr(sd, dentry);
>>      ...
>>      spin_unlock(&configfs_dirent_lock);
>>      ...
>> }
>>
>> and
>>
>> configfs_attach_attr(...)
>> {
>>      ...
>>      spin_lock(&configfs_dirent_lock);
>>      ...
>> }
>>
>> which unless it is way too late here and I really need to go to sleep
>> just won't work.
> 
> Kyle, you did the backport, any comments?
> 

After a good night sleep, the code still looks wrong to me. Reverting
the offending patch in chromeos-5.10 solved the problem there.
That makes me suspect that no one actually tests configfs.

Guenter

