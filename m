Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36957BD772
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345892AbjJIJpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345920AbjJIJpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:45:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE86FAB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:44:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3296b49c546so2423647f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696844698; x=1697449498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7F5z1ejI4DwSbBF/5sYVbYhJBhpzbjwBWa61oFyv20=;
        b=fqUxwdam7v4JRlRuhk7t0vWzjesfW1yjgHBhVEsssolNktdbMahAz/Nsr2zaUPvLxA
         eP7PT01oGYg/c+bPptToQgIjxXCK822IyT/JGmsoypGShJXfJDKvISo3vYlwyASl0VLU
         twwLBfzBAegWhrEDhf2mWazn2MwgPbbFRz/WLgsc9jHpHx/XIEfwpM2NHRT2tOSe21C2
         07K6Ttfp2bTVDuYzxhfQXC7VeOPo6kacwpO+9ubgoZqqMdR0m0OqdwxRq7H4Kj5Qaya4
         601+1DhmgrTPR4Kuhi3564CAQs3F/VkeFYnuoS7idXnNkGSJJfvdIMPGgJmkrM9RllMl
         nBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696844698; x=1697449498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7F5z1ejI4DwSbBF/5sYVbYhJBhpzbjwBWa61oFyv20=;
        b=FCGkhYALVf584O87vPCbDWFFlD5FCTljNg9IOEvLIlUn0lLp6KHunCpKAQZevIkvs2
         TFrFCiQ9t7sVAZ5RB+g8EdXJLGEduDApsIdvNS0CUlz5I5sAZbSrN6VBu5/gdU3jKQK4
         zOTIF919YMT5WhU7nPN9ppoAY79ZIMVYUyY2KENR8A5Q9c6iVvf+agN5/gk/Fb0sKAYH
         LRWX7RzxUvgeWfeRt4Cg4J4OF/W9n/5GYxAJKT8HDvfE+udZsUukXaNWBSsPu9GTICUa
         bklkUFB35nF3lh5/07mMYCWjpHWJnHcJVLKSGspcgbncciML8Aq+/ttS/ECrEAZyftTs
         9JDg==
X-Gm-Message-State: AOJu0YyCuvdOJrm+y/ckJe8kWXhWXzjFiQx27Fe7IhjL8UyYly4TAYIC
        ozG4z7EXshhRXjIPgop4Qfx55WB9+SSorc/rxcOmVw==
X-Google-Smtp-Source: AGHT+IFZpE7+YDLtVH5qrxPdmegf2DjrvmZBpIYXZGkVU9Nte9Rr1VA6/bPR/CFPc+ek6EOCrjQQyA==
X-Received: by 2002:adf:f9cc:0:b0:320:1c7:fd30 with SMTP id w12-20020adff9cc000000b0032001c7fd30mr11959396wrr.17.1696844698248;
        Mon, 09 Oct 2023 02:44:58 -0700 (PDT)
Received: from [192.168.86.24] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id t2-20020a5d6902000000b003250aec5e97sm9239992wru.4.2023.10.09.02.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 02:44:57 -0700 (PDT)
Message-ID: <affdcc33-7ffc-5368-727b-1382ec92007b@linaro.org>
Date:   Mon, 9 Oct 2023 10:44:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v12 2/7] nvmem: Clarify the situation when there is no DT
 node available
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
 <20231005155907.2701706-3-miquel.raynal@bootlin.com>
 <05cd4592d0cfe0fb86aeb24db01de547@milecki.pl>
 <20231006183229.51cd8e60@xps-13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231006183229.51cd8e60@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/10/2023 17:32, Miquel Raynal wrote:
> Hi Rafał,
> 
> rafal@milecki.pl wrote on Fri, 06 Oct 2023 13:41:52 +0200:
> 
>> On 2023-10-05 17:59, Miquel Raynal wrote:
>>> At a first look it might seem that the presence of the of_node pointer
>>> in the nvmem device does not matter much, but in practice, after > looking
>>> deep into the DT core, nvmem_add_cells_from_dt() will simply and always
>>> return NULL if this field is not provided. As most mtd devices don't
>>> populate this field (this could evolve later), it means none of their
>>> children cells will be populated unless no_of_node is explicitly set to
>>> false. In order to clarify the logic, let's add clear check at the
>>> beginning of this helper.
>>
>> I'm somehow confused by above explanation and code too. I read it
>> carefully 5 times but I can't see what exactly this change helps with.
>>
>> At first look at nvmem_add_cells_from_legacy_of() I can see it uses
>> "of_node" so I don't really agree with "it might seem that the presence
>> of the of_node pointer in the nvmem device does not matter much".
>>
>> You really don't need to look deep into DT core (actually you don't have
>> to look into it at all) to understand that nvmem_add_cells_from_dt()
>> will return 0 (nitpicking: not NULL) for a NULL pointer. It's all made
>> of for_each_child_of_node(). Obviously it does nothing if there is
>> nothing to loop over.
> 
> That was not obvious to me as I thought it would start from /, which I
> think some other function do when you don't provide a start node.
> 
>> Given that for_each_child_of_node() is NULL-safe I think code from this
>> patch is redundant.
> 
> I didn't say it was not safe, just not explicit.
> 
>> Later you mention "no_of_node" which I agree to be a very non-intuitive
>> config option. As pointed in another thread I already sent:
>> [PATCH] Revert "nvmem: add new config option"
>> https://lore.kernel.org/lkml/ba3c419a-6511-480a-b5f2-6c418f9c02e7@gmail.com/t/
> 
> I actually wanted to find again that patch and could not get my hands on
> it, but it is probably a much better fix than my other mtd patch, I
> agree with you.
> 
>> Maybe with above patch finally things will get more clear and we don't
>> need this PATCH after all?
> 
> Yes. Srinivas, what are your plans for the above patch?

for_each_child_of_node is null safe, so this patch is really not adding 
much value TBH.

--srini
> 
> Thanks,
> Miquèl
