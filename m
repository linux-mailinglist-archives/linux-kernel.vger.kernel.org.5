Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51037A16E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjIOHG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjIOHGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:06:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F147EF7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:06:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so2220917a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1694761576; x=1695366376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZe/76vQ5HQXY75ssS2Oaysyi0zH2iJKZW/pjIi7njM=;
        b=K1RIicayhVLoN8PllzdgRDznmRNW4eju+ulyebdlDWDPGQdNOvnKvxEP+i6Ao+5cKA
         DRuCmurY9wbasbYtTZKgdB/gnc03HJIms0htI0HKr3kLqIWwUM6PdDsT3qtZwL3uVH3h
         H7oQC7VCiFZJwlEdaQk65+dQUNHQ5gapJpH1kX8abSl/0FRMhQYWsRP4pIGGbRS8S632
         zlwlHvEckDNh8qobRAnAPl3CTXv6qlcU/icfncaX8pbR8N/EgReYhzSLBkJ36Q3LQ7ff
         PkXZRg56HlmQOzyfGmlaKWXYYxCuzBvHGeLTQWkTpSDy585hC3V0fSmfnaqRHXZAXTrJ
         qMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694761576; x=1695366376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZe/76vQ5HQXY75ssS2Oaysyi0zH2iJKZW/pjIi7njM=;
        b=uP1J5fbCONbMj1Ev/y6bdk2lPe7AkaBalbTP4KIKFiyzQd44HhVxsk+CxhHQPHmsP9
         IhVHS3r2uxVJN0V1Q2D6194Vgdf6HvFxm6oNdD1hgjy2Cd0xRy7zysk31CctgJ7rgSqp
         AerWdW0lpTocs9l7rX5NYWHXZe3D6haRLRFAAd9Pwkw2v6707gmp7GS6YJUtbvR4Q5yz
         0KyAFp9E2Ouwrxil09uPGuDWvyalvprCjTs0y6KfFMLKJ9/jwvHdcbF5mXmpFRUOr4Iq
         Bnp7fOVFKoKAFEocPe7NHaLh970j5nJcY3oeJEB90UF3kbVr7TfAJVC6J6UJYE0DIyJE
         WAoQ==
X-Gm-Message-State: AOJu0YzrQUqRn5HbjijeG4HMYpdi5+/DEKck1Vl1cQmlTOgThYxmjeWI
        6zrbIEMbOy90aP0moajRYFCJJA==
X-Google-Smtp-Source: AGHT+IFjTdhbbRBWkinRu9hafMJAySVNAho/ZxW0RAdT/t/nmM256x/l1JolKpXpxLMQPLQ6qb7EDA==
X-Received: by 2002:a17:906:20cb:b0:9ad:7f13:954d with SMTP id c11-20020a17090620cb00b009ad7f13954dmr550736ejc.31.1694761576254;
        Fri, 15 Sep 2023 00:06:16 -0700 (PDT)
Received: from ?IPV6:2003:f6:af2c:1500:c7bb:d28e:613f:8cb7? (p200300f6af2c1500c7bbd28e613f8cb7.dip0.t-ipconnect.de. [2003:f6:af2c:1500:c7bb:d28e:613f:8cb7])
        by smtp.gmail.com with ESMTPSA id p25-20020a1709060e9900b00992b50fbbe9sm2001336ejf.90.2023.09.15.00.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:06:15 -0700 (PDT)
Message-ID: <92c52af3-085e-8467-88bf-da4fbc56eeaa@grsecurity.net>
Date:   Fri, 15 Sep 2023 09:06:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] x86/hyperv/vtl: Replace real_mode_header only under
 Hyper-V
Content-Language: en-US, de-DE
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-kernel@vger.kernel.org, stable@kernel.org
References: <20230908102610.1039767-1-minipli@grsecurity.net>
 <20230908150224.GA3196@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ca1a5950-9092-6caf-471c-ebda623173e5@grsecurity.net>
 <20230913052714.GA29112@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <20230913052714.GA29112@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.23 07:27, Saurabh Singh Sengar wrote:
> On Mon, Sep 11, 2023 at 10:00:59AM +0200, Mathias Krause wrote:
>> On 08.09.23 17:02, Saurabh Singh Sengar wrote:
>>> On Fri, Sep 08, 2023 at 12:26:10PM +0200, Mathias Krause wrote:
>>>> Booting a CONFIG_HYPERV_VTL_MODE=y enabled kernel on bare metal or a
>>>> non-Hyper-V hypervisor leads to serve memory corruption as
>>>
>>> FWIW, CONFIG_HYPERV_VTL_MODE is not expected to be enabled for non VTL
>>> platforms.
>>
>> Fair enough, but there's really no excuse to randomly crashing the
>> kernel if one forgot to RTFM like I did. The code should (and easily
>> can) handle such situations, especially if it's just a matter of a two
>> line change.
> 
> Thanks, I understand your concern. We don't want people to enable this
> flag by mistake and see unexpected behaviours.

Unexpected behaviour like randomly crashing the kernel? ;)

> To add extra safety for this flag, we can make this flag dependent on
> EXPERT config.

Well, if you want to prevent people from using it, make it depend on
BROKEN, because that's what it is. All the other hypervisor support in
the kernel (Xen, VMware, KVM, ACRN, Jailhouse, even plain Hyper-V) can
perfectly cope with getting booted on a different hypervisor or bare
metal. Why is Hyper-V's VTL mode such a special snow flake that it has
to cause random memory corruption and, in turn, crash the kernel with
spectacular (and undebugable) fireworks if it's not booted under Hyper-V?

Thanks,
Mathias
