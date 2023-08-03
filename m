Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D1A76F3D7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjHCUIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjHCUIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:08:48 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC111712
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:08:47 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-790dcf48546so10044639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 13:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691093326; x=1691698126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQeAMbt65qkBHwe/tbfCgd8rUoOau7L1U4Og1toSHTM=;
        b=Vp/DvDQ1CB0SLB/6YTXikAUiG5iZXRXCS2gHqgPgqGhPJk1AjYHVXFKSH5hek7xG9v
         1Du1JBhAKcpk+slDhw7ZnS9D9yZHMhFjXVw6lPVSBXf/O0pVcVHJHAUCsPSpagB5PAWQ
         P9fI6zigXvetP0HVqCT9vPOeUkQxeMkBtPuGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691093326; x=1691698126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQeAMbt65qkBHwe/tbfCgd8rUoOau7L1U4Og1toSHTM=;
        b=HA78J92wG96xD2+YohVCHdblSp6V0V+koGhz/87+JBB5z49qhhy1KYfMnhJXASxVDy
         ZrLTib76OjdvEnQLDcfRlOhNptqaGh4j68L7q87BCtkoEE7Uu/4vR8WW0ADkcAxZde76
         p/6qf6tn0PP1LYCJYdugui+zdJdptzAyIkAoYtsgSXExzIMLVZ7fDxJQAzSlTCEilm3e
         H0Pbh/BJ7NKkiiQ41KvZla/qcIDdgHvB3K/9g7QpnBuG2qmfSYM923+lte3FQ2yRLhWT
         PVNoPR9dLD7FBwSMAQGiI7pKkthKZF/ei7fNaa55OhlnH+5z4zbFaMJpjbdND1N3tLlN
         xq7g==
X-Gm-Message-State: ABy/qLbfLfMIN2V9THmZhQlnbH7W3Anh4CrcQwshadsMNSch75URcJGc
        KXdj8d5oNmEvLzIDqTL39OtmHuvrpQ2ROSNHRwDNeA==
X-Google-Smtp-Source: APBJJlHiSStLkAAMnvnYnzMG+SR9C8qGxiGHwP0uA5/Ecl3R/ISP+HxAFhoqM9OGCqDI02Xwga7Y2g==
X-Received: by 2002:a92:c9c3:0:b0:349:1a2:f699 with SMTP id k3-20020a92c9c3000000b0034901a2f699mr15164930ilq.3.1691093326418;
        Thu, 03 Aug 2023 13:08:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l4-20020a922804000000b00348c7e5e915sm193587ilf.5.2023.08.03.13.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 13:08:46 -0700 (PDT)
Message-ID: <29ba0002-0c2f-ff5c-bbf3-fca167f77b3d@linuxfoundation.org>
Date:   Thu, 3 Aug 2023 14:08:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: nolibc: add myself as co-maintainer
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230728-nolibc-maintainer-v1-1-5f13daaebf4c@weissschuh.net>
 <1f85e8c3-e07d-482f-aa90-5e6631bc7873@t-8ch.de>
 <884b4415-2b6f-44be-aaeb-da1d9d85ea01@paulmck-laptop>
 <20230803191533.GA25279@1wt.eu>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230803191533.GA25279@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 13:15, Willy Tarreau wrote:
> On Thu, Aug 03, 2023 at 11:43:17AM -0700, Paul E. McKenney wrote:
>> On Thu, Aug 03, 2023 at 08:31:50PM +0200, Thomas Weißschuh wrote:
>>> Hi Paul,
>>>
>>> On 2023-07-28 23:21:52+0200, Thomas Weißschuh wrote:
>>>> As discussed with Willy, Paul and Shuah add myself as maintainer for
>>>> the nolibc subsystem.
>>>
>>> it seems I forgot to send the nolibc maintainers update patch to you.
>>>
>>> My bad!
>>>
>>> Willy and me wondered if the patch could go through your tree?
>>
>> It could, but why not just include it in the batch going to Shuah?
>> It is not all that long until the merge window opens, plus it is hard
>> to argue that this is a regression.
> 
> OK, I'll take it in my queue and send everything at once to Shuah.
> Thomas and I didn't know if the file had to be updated quickly or
> not.
> 

Sound like a plan.

thanks,
-- Shuah

