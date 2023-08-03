Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A527276E9EC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjHCNTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjHCNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:19:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E3C10EA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:19:33 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso10136145e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691068771; x=1691673571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mOCS+sHZ9OYDGZ+r3hB6DlHjCqnsHVrb+8LC3PIeLA=;
        b=PeX1O+MQ0GDfWJv3PQcxKw3P5iWOgPtQncqFp4s7R0CpVhkf18J9HLu3HzBlasw/Rw
         cFzJOqMt4ndjrYbi8nenxl6/xN84sbeyx6RQxa7PguCCmlfrK4aa4V80C9hMHc8ZLlHl
         OIlveqitXLJoSXXClxCiWKQ1+1zuL71X1EPoe/BQk3GWkPV9lKUZJpylsIxVpIVluSt6
         xv6ix8OxtLHgTABd5Y48F7rtnNzZrQevQU3c0dIzI7ziC/K0HAw6CmcZuZUQJ9y8QA11
         whnZgTWzJk/W6lQkCsmRAQZGx2s5iHJdUd0yoNUlWKVJ0lM7LOQf8CrIqYtcMqAX/tH2
         nFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691068771; x=1691673571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mOCS+sHZ9OYDGZ+r3hB6DlHjCqnsHVrb+8LC3PIeLA=;
        b=Twu2ppBmLCbMB3vV7odoslkkbm8WKV1FhnZfhHUKRODvKkgTZcE/3dlQCmN5heVXxY
         LWhfAxecJdQnonejbSfZ7oqrZfxTmG7YIBW9D0oxZi8C0SSsiaDzWjykb7Tgfa7ZAW4k
         kXJsDXDk9wubFFgphuduzhfwAQiKLyaqLY7AYXNcuyrjcCXgkh7V5DqrqltRHCp21b+H
         xPbzEBVUIc/LKfdL40LaWAenl8HfmnSkbcPFqRUtaeqzc3f4rJm+Hv9mMa2z03vagC01
         gjr8owQY+XnBeZXqNSt7j4L9donJVcKtpSa+BnLnBFK66K+mKI/0/fRzH/NtTJX//JGf
         9bKQ==
X-Gm-Message-State: ABy/qLaOBUqfEpXYIFtzhMmLxmTBmnNZf13MzfdmFFl+epnHxWDMaHLw
        CGiAmF8m+0epii2NJSoXcw9XfP2Bi+80RkieslE=
X-Google-Smtp-Source: APBJJlG80gudR9LU0/3zq7coND676L3IK21c5s2iw2yBqdiqauL+wz/tpF8p/JXxwsJxejMflM9+qg==
X-Received: by 2002:a05:600c:2048:b0:3fe:2bb1:11ba with SMTP id p8-20020a05600c204800b003fe2bb111bamr6423174wmg.27.1691067974611;
        Thu, 03 Aug 2023 06:06:14 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w11-20020a05600c014b00b003fc16ee2864sm4221824wmm.48.2023.08.03.06.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:06:14 -0700 (PDT)
Message-ID: <5c93d78d-835e-c740-280b-9d76456aaeda@linaro.org>
Date:   Thu, 3 Aug 2023 15:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/8] thermal: core: Add mechanism for connecting trips
 with driver data
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <4501957.LvFx2qVVIh@kreacher>
 <2d0315d4-35b4-84db-4dcb-c9528abad825@linaro.org>
 <CAJZ5v0iQDOsTOqWFvbf5nom-b3-pbHPRzJQC-1DM9eoh=0AKjg@mail.gmail.com>
 <eb279cf1-0605-3b87-5cb6-241a91977455@linaro.org>
 <CAJZ5v0i48=oawDJHoaHhiZRaO_CJokKsOHyNvu2v4PUbS6CH_Q@mail.gmail.com>
 <f8029547-6851-7e0c-00e6-4963ccbc2702@linaro.org>
 <CAJZ5v0gDQMNSeEU1J7ooJk4Ec=Hw_JuZAtL5k215v7Lf67iTgg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gDQMNSeEU1J7ooJk4Ec=Hw_JuZAtL5k215v7Lf67iTgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 18:48, Rafael J. Wysocki wrote:

[ ... ]

>> Let me check if I can do something on top of your series to move it in
>> the ACPI driver.
> 
> It doesn't need to be on top of my series, so if you have an idea,
> please just let me know what it is.
> 
> It can't be entirely in the ACPI driver AFAICS, though, because
> trips[i] need to be modified on updates and they belong to the core.
> Hence, the driver needs some help from the core to get to them.  It
> can be something like "this is my trip tag and please give me the
> address of the trip matching it" or similar, but it is needed, because
> the driver has to assume that the trip indices used by it initially
> may change.

May be I'm missing something but driver_ref does not seems to be used 
except when assigning it, no?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

