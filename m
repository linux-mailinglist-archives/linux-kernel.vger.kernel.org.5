Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAFB801116
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjLAQRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378234AbjLAQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:16:55 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0041738;
        Fri,  1 Dec 2023 08:17:00 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50be0f13aa6so140885e87.1;
        Fri, 01 Dec 2023 08:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701447418; x=1702052218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRyIK44k8WakD7ulTyl1AC/ua3tTG7/92vD0ifCxVf0=;
        b=XtP2tlorFoEfLRdFeQjeWday0lIulV1BUrFiA3Ale0So92qnyR7VLbwLoTAr78Ivli
         aLcFHnhjEpHIIoao2XyaywwhkSyeN5tOrM3kcL+zq6zKRMRqWvakc09vcCpghHfpY7OD
         w9GF/8qXedRP5nntPftKV/PRqN6Fy2Xyh2qBkybPUU4TvLpceNlD7V7FH1H/amDxVQaY
         ULjNdwPdUUgOtw7GcmvP4qgjkucldmCcePpaHfqaI7vl0+56Kfl1PumrZhfwpSv/Ey3D
         wtLwdKIID3Ke4qurlFR4u8TJwAYxj/50qie38JMZgPjmPbgn6D5PByzhPwuD/BLO1+GP
         HX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701447418; x=1702052218;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRyIK44k8WakD7ulTyl1AC/ua3tTG7/92vD0ifCxVf0=;
        b=aXtWOFMT0Zk9JASzWQowyMajVzHg9Z4HWkd5FoRXpBcG7arIJcpXzjd4EIo45B41KS
         USYtJNK2M9mlj2YVVffjplpZvBewH/mmVX2LJjqohyq6mzTVxkko4ohWW54oZOhgtmfj
         Pv30DR0ZJqYZM7RVSBB+QURu69w8FqbU2W/J3W+Y/bFzsfvPEAZP6OmEO7Qw6FymeyLf
         893V+5AqAHALhM+W3KUj5EvJtEog4pGUZ95KeQHQ3bXvbJrIw+4Y8SHtU706MAVGBuSa
         E4gWh3tSpyHW/RwwofFz1VL07EIToFFXoD6Eecfhd1/1l5RbkA5sPDX3o/4WBJ5FAOkh
         LhtA==
X-Gm-Message-State: AOJu0YydElWI4zTt7vqnq35WGa4k9829h6YsMGEIMG1VCodftlpn//P4
        UV1G6cpho50fgl5UgNrchl8=
X-Google-Smtp-Source: AGHT+IGPoDbhjTgg1gjXEy/ZiylHE7XfDBS8oO2xBNvPmw2r/iBpeDXMcy6VWWNXXwBJBrhAuCtHIQ==
X-Received: by 2002:a05:6512:3e22:b0:50b:c7bd:2352 with SMTP id i34-20020a0565123e2200b0050bc7bd2352mr1264861lfv.14.1701447418382;
        Fri, 01 Dec 2023 08:16:58 -0800 (PST)
Received: from [192.168.1.104] ([31.173.84.39])
        by smtp.gmail.com with ESMTPSA id e7-20020a05651236c700b0050bc45777absm457838lfs.113.2023.12.01.08.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 08:16:58 -0800 (PST)
Subject: Re: [PATCH v2] usb: storage: sddr55: clean up variable type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Karina Yankevich <k.yankevich@omp.ru>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <53bc0584-51eb-8bb7-de48-ca07fccafc19@gmail.com>
 <20230227112541.14849-1-k.yankevich@omp.ru> <Y/yaB2A8qwgRkqVO@kroah.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <a1296b9a-c27e-3b35-e256-32350fb2a83e@gmail.com>
Date:   Fri, 1 Dec 2023 19:16:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <Y/yaB2A8qwgRkqVO@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Sorry for the really long delay! Your reply scared off Karina
(it was her 1st kernel patch), so I'm trying to pick this patch up
where it was left back in February...

On 2/27/23 2:54 PM, Greg Kroah-Hartman wrote:
[...]
>> SVACE static analyzer complains that we're possibly
>> losing information by shifting an 'unsigned int pba'
>> variables in sddr55_{read,write}_data().
>> It is a false positive, because of the card's total capacity
>> is no larger than 128 MB. But 'unsigned int' is more
>> suitable in this case.
> 
> Please wrap at 72 columns.
> 
>> Found by OMP on behalf of Linux Verification Center
>> (linuxtesting.org) with SVACE.
> 
> What is "OMP"?

   Open Mobile Platform, LLC. The website is in Russian only:

https://www.omp.ru

> What is "SVACE"?

  The patch description said thst it's a static analyzer.
Here's the link to the Institute for System Programming web page about it:

https://www.ispras.ru/en/technologies/svace/

> And why change anything if there is not a real issue?

   We needlessly use 64-bit type on 64-bit arches.

>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> That's obviously not the correct commit id for such a "fix" as this is
> not a real issue.

   That's correct. We'll remove this tag.

> thanks,
> 
> greg k-h

MBR, Srrgey
