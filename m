Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B39F7A75E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjITI2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITI2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:28:42 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCCF90;
        Wed, 20 Sep 2023 01:28:36 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38K3GoRR018911;
        Wed, 20 Sep 2023 03:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=2mUUdPy7jw/Cp4z24ox1QCdZ6furGQesq7BQE2tMYdk=; b=
        FfmtAmGXvtnAlGGMP0rkqRc645T8cHDRIQb/bypsfSNp3jmaJf7v8wqwCBATeQ0f
        RgF0KSX3R8A69EBHTVVTW/cXAyDEzT6reEnNzAd6tuVBsxnL+k2VV1qcO5Hqz3+Y
        f84oDNTgYY1W/uVOoI9vBWS+6E1sV1hIFc5Dhg9jBSuDMStXZxyD8O2PTRRrNvD+
        yABeniqCQvzIvTeQX1ia4OffQo5apKwSkiiVyzebaPf2xC4xcs1yhPzvvn7NZ/Bq
        L07wYOEYaRwgPqe3TLMKo12xzaukYlDwoHOsoqdpJYi3IKq6BugJRU9AYjaPm+az
        gGLHDMo4dfdeu/O6sQaqiQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t59ry560p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 03:28:01 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 20 Sep
 2023 09:27:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 20 Sep 2023 09:27:59 +0100
Received: from [198.90.238.129] (unknown [198.90.238.129])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4E9DF2A1;
        Wed, 20 Sep 2023 08:27:58 +0000 (UTC)
Message-ID: <9e2291c1-9a6c-ba6b-ea0f-ad130d2596f4@opensource.cirrus.com>
Date:   Wed, 20 Sep 2023 09:27:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] ALSA: hda: cirrus_scodec: Add KUnit test
To:     Takashi Iwai <tiwai@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        <linux-acpi@vger.kernel.org>
References: <20230918095129.440-1-rf@opensource.cirrus.com>
 <20230918095129.440-3-rf@opensource.cirrus.com> <ZQoILN6QCjzosCOs@google.com>
 <874jjpwd4i.wl-tiwai@suse.de>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <874jjpwd4i.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LoBxW4WqzenvOlLWFwJnG4bcxNWLjdo3
X-Proofpoint-ORIG-GUID: LoBxW4WqzenvOlLWFwJnG4bcxNWLjdo3
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/9/23 07:51, Takashi Iwai wrote:
> On Tue, 19 Sep 2023 22:44:28 +0200,
> Nick Desaulniers wrote:
>>
>> On Mon, Sep 18, 2023 at 10:51:29AM +0100, Richard Fitzgerald wrote:
> (snip)
>>> +static void cirrus_scodec_test_set_gpio_ref_arg(struct software_node_ref_args *arg,
>>> +						int gpio_num)
>>> +{
>>> +	struct software_node_ref_args template =
>>> +		SOFTWARE_NODE_REFERENCE(&cirrus_scodec_test_gpio_swnode, gpio_num, 0);
>>
>> I'm observing the following error when building with:
>>
>> $ make LLVM=1 -j128 allmodconfig sound/pci/hda/cirrus_scodec_test.o
>>
>> sound/pci/hda/cirrus_scodec_test.c:151:60: error: initializer element is not a compile-time constant
>>    151 |                 SOFTWARE_NODE_REFERENCE(&cirrus_scodec_test_gpio_swnode, gpio_num, 0);
>>        |                                                                          ^~~~~~~~
>> /builds/linux/include/linux/property.h:291:37: note: expanded from macro 'SOFTWARE_NODE_REFERENCE'
>>    291 |         .nargs = ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1, \
>>        |                                            ^~~~~~~~~~~
>> /builds/linux/include/linux/kernel.h:57:75: note: expanded from macro 'ARRAY_SIZE'
>>     57 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>>        |                                                                           ^~~
>> /builds/linux/include/linux/compiler.h:228:59: note: expanded from macro '__must_be_array'
>>    228 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>>        |                                                                ^
>> /builds/linux/include/linux/compiler_types.h:366:63: note: expanded from macro '__same_type'
>>    366 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>>        |                                                               ^
>> /builds/linux/include/linux/build_bug.h:16:62: note: expanded from macro 'BUILD_BUG_ON_ZERO'
>>     16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>>        |                                                              ^
> 
> Hm, this looks like some inconsistent handling of the temporary array
> passed to ARRAY_SIZE() in the SOFTWARE_NODE_REFERENCE macro.  LLVM
> can't treat it if it contains a variable in the given array, while GCC
> doesn't care.
> 
> A hackish workaround would be the patch like below, but it's really
> ugly.  Ideally speaking, it should be fixed in linux/properties.h, but
> I have no idea how to fix there for LLVM.
> 
> Adding more relevant people to Cc.
> 
> 
> thanks,
> 
> Takashi
> 
> --- a/sound/pci/hda/cirrus_scodec_test.c
> +++ b/sound/pci/hda/cirrus_scodec_test.c
> @@ -148,8 +148,9 @@ static void cirrus_scodec_test_set_gpio_ref_arg(struct software_node_ref_args *a
>   						int gpio_num)
>   {
>   	struct software_node_ref_args template =
> -		SOFTWARE_NODE_REFERENCE(&cirrus_scodec_test_gpio_swnode, gpio_num, 0);
> +		SOFTWARE_NODE_REFERENCE(&cirrus_scodec_test_gpio_swnode, 0, 0);
>   
> +	template.args[0] = gpio_num;
>   	*arg = template;
>   }
>   

The tests must generate sw nodes dynamically, not a fixed const struct.
I wanted to avoid directly accessing the internals of the SW node
structures. Use only the macros.

I can rewrite this code to open-code the construction of the
software_node_ref_args. Or I can wait a while in case anyone has a
suggested fix for the macros.

Its seems reasonable that you should be able to create software nodes
dynamically. A "real" use of these might need to construct the data from
some other data that is not known at runtime (for example, where the
ACPI provides some information but not the necessary info).

