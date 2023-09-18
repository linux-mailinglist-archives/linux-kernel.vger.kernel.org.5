Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AA77A4BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjIRPVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjIRPVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:21:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E91B118;
        Mon, 18 Sep 2023 08:17:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68fbd5cd0ceso4082977b3a.1;
        Mon, 18 Sep 2023 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695050266; x=1695655066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81F5bCn6l0BRx0w8BQQ9iQyXJ5D/anBMfPMtaxEr1bY=;
        b=lngoXJXSEQ7orSWO53FHWUP/8fXxl4OR6PDRaO1KvLfSNI1Ji8U3EtBYi+wmP+J/va
         vcGF9s7GBveOZUpWx8SVA6lIzwQ6tFSMpfB+99kkgYQ3nvh9NpXiLmbG2Pa0jHbJK3yT
         DncaEPCCAuNZJE13XvqAH0T0Zpl0QSy/eJutNUSydIhTJHCaNQLIslFdpx3YvS0Dc3fQ
         +/6c6dPhe+9v1TsFgni32Hfz5hxZNQmjrLiFqJBZmBObzxxjp+BFIrp8LJEQabtkUqJQ
         acYU0te/hJV7wtc8GF0fc7/OWamTq6QOZia5aLACuyykYqNOS4SS42NJD/eNl92oEa9U
         REbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050266; x=1695655066;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81F5bCn6l0BRx0w8BQQ9iQyXJ5D/anBMfPMtaxEr1bY=;
        b=lM/dic5aaWjPrwcJRwQ8a5EO5YtoYOQwL7xQWy/3ihCctliV2K6Zd7rXYIILnQQAgp
         f0J0BK8tQ3gK+w/JdfXYinj8yAAHopzIpdy9zYx898WE7TOIQwCFuh+uiChipRioaQa0
         Tu1aKSQAQ6LfiWxUlccif7fHHvOAg6S9a1N/nvq6pAPFqGwRlwOMiK9YONuMlqiT1vLz
         9IsxNID+9Oyq9AIoI4Di5+KkY2PeYz444XaPgWCLTOQFykn/u5cpn/bIadfgJsYAT5KE
         SK4N2eNmkd5+9yH9UDlnTTq4qZQBNxwYAHMmtgLvHElyboXIORB/C397i0H4wXyKqqS5
         WODw==
X-Gm-Message-State: AOJu0YymIBnCA6APRzjnhygw5rEsHIe7SRow7neYQm8Dh0qVJ2DgmM7h
        FU2LPwx1S3TiekrM+hPzwWI=
X-Google-Smtp-Source: AGHT+IEEHnstItrfV2ospP26Zbe9echZD3JFu/HZ+3QxynojEh6WWiPS31m7MAaP+EWyKGulJBd4Xw==
X-Received: by 2002:a05:6a00:1912:b0:68e:23c9:b306 with SMTP id y18-20020a056a00191200b0068e23c9b306mr12385588pfi.30.1695050266548;
        Mon, 18 Sep 2023 08:17:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p15-20020a62ab0f000000b0067aea93af40sm7310632pff.2.2023.09.18.08.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 08:17:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bae1a61f-ab9d-2560-9c70-e09092363467@roeck-us.net>
Date:   Mon, 18 Sep 2023 08:17:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Sameer Pujar <spujar@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230917191051.639202302@linuxfoundation.org>
 <dfe78c1a-8322-413b-f1b7-3a6a307a831c@nvidia.com>
 <2023091846-cabbage-imagines-3fde@gregkh>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
In-Reply-To: <2023091846-cabbage-imagines-3fde@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/23 05:56, Greg Kroah-Hartman wrote:
> On Mon, Sep 18, 2023 at 01:52:10PM +0100, Jon Hunter wrote:
>> Hi Greg,
>>
>> On 17/09/2023 20:10, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.5.4 release.
>>> There are 285 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.4-rc1.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>> -------------
>>> Pseudo-Shortlog of commits:
>>
>> ...
>>
>>> Sameer Pujar <spujar@nvidia.com>
>>>       arm64: tegra: Update AHUB clock parent and rate
>>
>>
>> Unfortunately, the above change is causing a regression in one of our audio
>> tests and we are looking into why this is.
>>
>> Can we drop this from stable for now?
> 
> Is it also a problem in Linus's tree?  Keeping bug-compatible is always
> good :)
> 

Sorry, no, it isn't, especially in the context of at the same time suggesting
that everyone should start using the most recent stable release immediately
(instead of, say, selectively picking security patches).

I don't think Tegra users would be happy if their audio stopped working,
and it seems unlikely that they would accept the argument that they should
be happy to be bug-compatible with the latest upstream kernel - even more so
if that latest upstream kernel is a release candidate and the problem was
introduced in the commit window.

Guenter

