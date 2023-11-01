Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2C87DDC6B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376474AbjKAGQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjKAGQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:16:38 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2612F3;
        Tue, 31 Oct 2023 23:16:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507cd62472dso595148e87.0;
        Tue, 31 Oct 2023 23:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698819394; x=1699424194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9yle7VrmIO9F6x8DetVeUxbscZ9DT3LOEfWagzVsSw=;
        b=RMj3aTIL6/2bDCxX0snbze/zEAqpwF2gERFn9tAMnqOsdfZHRfPu9kDqK/KX9Z/bz3
         I1NIlfRNjB1Yu89Cg1jgmJ4hk73pf92lr9lhYY53fMoVYtVIUpfs0bdsAVhzQwbWuuiw
         wZ9lVGtueX1yT3326cDM0KGSjmGcQ620Kq0H0eCEhLwNpup42aXy/HmxjNSNNx3wgGIs
         j24OV824hMJm0eqlWsLP08IBoILhl79VoM6E5SUMBlajVspU/DrTrJQlDLJjomUOhaOt
         lTOoxRGVm2n6RsDKsMtBM/5ws5usroVSuKe+sNUpEHv5cjIHk2kwPZ7OaUYsCzWJZ//v
         7BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698819394; x=1699424194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9yle7VrmIO9F6x8DetVeUxbscZ9DT3LOEfWagzVsSw=;
        b=X5CEmXK9d8Z5OLnjOFAluURPTXGymPohwWfYRtJcH7JxcgI/S6ybahDlCZ+ZDWXxNI
         P+bWLijEfmAE+ayHNeNR0nTR0S6aNLnMB9TvjD7FQNlL2ODAeFPOPAtgVcZ3DqC/zagl
         50A4qXfl0ZA9phBZFLY5z9UqK792Krj3AMOxYh+w8W193SxZOP41Xd71psDJCHEQG3qK
         GVeolSf90qa0xTrD1OUt2ODMwCSkTDl9DTCqE6cvKPiue8pMXhXhZZ57H8+Te460X5E4
         oZsDL9DIxIIQs8biUUbj7HowP5NpnhKKgnY3xuSef66Drs62ZYaZKPKkZgS3u5B9OvKR
         RgVA==
X-Gm-Message-State: AOJu0YwIUKNYbR9oOJmHkU2bshN6p9R7WwGGcLfSSD4qpWtoUkjqjyyA
        OxFvG8dNnTCz3m8vSoCC1w6wERSY8pI+vg==
X-Google-Smtp-Source: AGHT+IFWsxF2Ff5zf6/CiiCtuLXE3tIiPkLBLUgMyHvwmtbh+xotWxyPgxYtMMAnoTLo6COspJ0rvA==
X-Received: by 2002:a05:6512:3ba9:b0:508:15dc:ec11 with SMTP id g41-20020a0565123ba900b0050815dcec11mr2047875lfv.30.1698819393536;
        Tue, 31 Oct 2023 23:16:33 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id p6-20020a056512234600b005057830c24dsm130670lfu.141.2023.10.31.23.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 23:16:32 -0700 (PDT)
Message-ID: <6d553aaa-279f-48bf-96c9-30fdac1ae372@gmail.com>
Date:   Wed, 1 Nov 2023 08:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
 <20231028162025.4259f1cc@jic23-huawei>
 <84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com>
 <6a697c62-6a7c-4b31-bc8e-10f40db0363d@gmail.com>
 <d528b45c-123d-4ef7-b110-7efbfef91bc5@gmail.com>
 <ZUDZIEY_uTVMHh3C@smile.fi.intel.com>
 <b01930d6-5bec-496c-89de-6cf6d178c860@gmail.com>
 <ZUEET34K7AOkFf4A@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZUEET34K7AOkFf4A@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 15:42, Andy Shevchenko wrote:
> On Tue, Oct 31, 2023 at 02:07:46PM +0200, Matti Vaittinen wrote:
>> On 10/31/23 12:38, Andy Shevchenko wrote:
>>> On Tue, Oct 31, 2023 at 09:11:37AM +0200, Matti Vaittinen wrote:
>>>> On 10/30/23 12:21, Matti Vaittinen wrote:
>>>>> On 10/29/23 17:51, Matti Vaittinen wrote:
>>>>>> On 10/28/23 18:20, Jonathan Cameron wrote:
> 
> ...
> 
>>>> 	tmp = gts->max_scale;
>>>>
>>>> 	rem = do_div(tmp, total_gain);
>>>> 	if (total_gain > 1 && rem >= total_gain / 2)
>>>> 		tmp += 1ULL;
>>>
>>> ...which is NIH DIV_ROUND_CLOSEST_ULL()
>>
>> There is a difference though. The DIV_ROUND_CLOSEST_ULL() does
>>
>> tmp + total_gain / 2;
>>
>> before division - which in theory may overflow.
> 
> Then you can fix it there for everybody, no?

Now that I know of this macro - Maybe. It's just always scary to touch 
things which seem like fundamental building blocks and which may be used 
by many. Odds are something breaks, so I tend to be very conservative 
when suggesting changes to widely used stuff. Especially when I have no 
idea when and why the API has been added - and if the thing I'm trying 
to "fix" has been a deliberate choice.

Yours,
	-- Matti.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

