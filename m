Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F82475885B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjGRWSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGRWSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:18:05 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E8BBD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:18:01 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id ca18e2360f4ac-77dcff76e35so57995439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689718680; x=1690323480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69DCNkNewNKMgQotvKNc/GosqsMW82kV8HC9kw4hzgQ=;
        b=cPHinmaEYoGEtvYV2Vy7VI5g3M1QVkrWTKG38z7qSmHKKEau0/vvVXN58utkwiu42O
         O5PBwd9TmVEz0nSUAcxqpUVmTH0ot6gC/rnOLYeRsggQIzQI7UbKWtJcKP+i0t5WuPes
         CKNbzTpYee6dOqFFyPSWEZykLEg8IvZiOARq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689718680; x=1690323480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69DCNkNewNKMgQotvKNc/GosqsMW82kV8HC9kw4hzgQ=;
        b=TNb4do6yHWdPapjQgWnR1Y/n6TiMK5N121fXimPcJPaQitA539w/8WEyuSHZ/e6qqj
         YRR4+50r130Fu++LMHjqLU5wn3gE3yHmJ9oqohO5RryOO84Qyrs4EEBFHGnrp25u+nGA
         EMQ4qNmRSb0HHAF72c0M1GWjm1zjLLoUlTjPtC+23WD79AVGbzfD9C1YK+IyFLvPUnE4
         o5cpKkqEcnvceCAII/jc2/4AT5tr3+9VnLXoK46Vfjq+QyE9HTl3csFCe3ma9mmLrhfT
         NyojRma2eSpEnHGJc41IAnN+t3tqQdeBC2hlk4xonXe0W88qPu/2YIQncYk7DUztOcOT
         056A==
X-Gm-Message-State: ABy/qLbN8xvMF6F+sg/20dzFiyM/lRyQ7XLDTDJtNPOpdO/EMJ6STc+4
        tYYgdE9CH8f++yesgBipgpTVFA==
X-Google-Smtp-Source: APBJJlExqWzPfvPYmcqlV9zjtRnhYP8LXJVFFjOzTqh04DaqPK0/IGtXKGYblTEnHgYzivP8boQmKA==
X-Received: by 2002:a05:6602:3a83:b0:780:cb36:6f24 with SMTP id bz3-20020a0566023a8300b00780cb366f24mr3114447iob.2.1689718680729;
        Tue, 18 Jul 2023 15:18:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b10-20020a5ea70a000000b007870289f4fdsm897822iod.51.2023.07.18.15.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 15:18:00 -0700 (PDT)
Message-ID: <9e51ace9-02c9-8dfb-c092-4158415a9821@linuxfoundation.org>
Date:   Tue, 18 Jul 2023 16:17:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/5] cpupower: Add various feature control support for
 amd_pstate
Content-Language: en-US
To:     Thomas Renninger <trenn@suse.de>, trenn@suse.com, shuah@kernel.org,
        Wyes Karny <wyes.karny@amd.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, gautham.shenoy@amd.com,
        Mario.Limonciello@amd.com, Ray.Huang@amd.com, Perry.Yuan@amd.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230619190503.4061-1-wyes.karny@amd.com>
 <1896655.g5d078U9FE@p200300d2573c9800520d172709106850.dip0.t-ipconnect.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <1896655.g5d078U9FE@p200300d2573c9800520d172709106850.dip0.t-ipconnect.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 05:19, Thomas Renninger wrote:
> Hi,
> 
> sorry for the late answer, I wanted to give this a test, but could not
> make it (yet).
> 
> My 2 cents on this one:
> 
> what Ray already mentioned is greatly appreciated: Find common APIs, not only
> AMD vs Intel, but general ones, outside of the driver specific sysfs dir, e.g.:
> /sys/devices/system/cpu/cpufreq/...
> 
> But not at all costs and if the epp part is (AMD) specific and varies to others
> in meaning or in values, it has to be a specific file/API.
> 
> (Another Example/Request at the end)
> 
> And...: It would be nice to see some documentation in form of manpage
> enhancements. At least for the newly introduced arguments.
> If not yet, there should be: possible value range, which machines (CPU flags,
> Zen 4, ...), if more complex technology, some kind of introduction or
> reference where to find things would be really great.
> 
> I wonder whether it could be possible to connect this with:
> Documentation/admin-guide/pm/intel_pstate.rst
> Documentation/admin-guide/pm/amd-pstate.rst
> 
> I guess there is a static web site address people could rely on where above
> kernel docs are hosted forever?
> Then it would make sense to link the cpupower manpage with it and keep the
> description short and avoid duplication?
> 
>               Thomas
> 
> 
> Another Example/Request at the end:
> 
> One example I recently got asked for, the bug is private:
> "cpupower is not returning max turbo active cores information on latest Intel
> processors."
> 
> Here are examples of 2 newer cpus that don't return the active core
> information like this:
>      3600 MHz max turbo 4 active cores
>      3600 MHz max turbo 3 active cores
>      3700 MHz max turbo 2 active cores
>      3800 MHz max turbo 1 active cores
> 
> Not sure whether there finally is some kind of consolidation on turbo/boost/
> dynamic/hw/bios interfaces in respect to turbo/boosting technology. But if
> anyhow possible and it makes sense, it would be really great to see one sysfs
> file exposed to userspace to read/enable/disable.
> 
> Possible cpufreqs (including or only) boost freqs, maybe with active cores if
> this is a general technique optionally added if avail?
> 
> Nothing which has to be implemented at all costs and right now, just an idea
> on how things could be consolidated at some point of time which might be wise
> to think about now already...
> 

I applied these for Linux 6.6-rc1 - ran quick tests.

Please act on feedback from Thomas and send me patches on top of

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah


