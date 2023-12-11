Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBC080C7B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjLKLJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjLKLJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:09:31 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EAD118
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:09:30 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1caddd6d28so536571066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702292969; x=1702897769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LyfE8VPP+jKkzsqzZmDn4AjOdgAMsVW+As3oZ2Yyxl4=;
        b=a3hEqw1Yg/nEpgJ8h8k+rvyI4ZLjVBLlgtZogyPvGDcCGM4fq8yn7eN8Q+d4zDbaDE
         ZyIUgt5btbd1xsQoVO2vyMiKOEx7L9aXMViusIsWRp3i/nfWcKZJlkVN3mWR5NvkX0VP
         XY3DASgfHGDzK0W7KUDjY+NTNY7BawwVkIkEHu4Iq2IujugQSgLay2oZepzqJyA3yNEk
         Mt4uOHDx1H29QR5NG3Qq5RBRxqsajnyV9mLnQeXWGOA1Fnd4asxqRsmNqkBW1b5sQxve
         TTfW4wLfrNRrtMTJtmTCJMUMLfNCCeB5rbM14QJUORv02I6HiFOu+HfbSA7AmGqj9iYD
         nwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702292969; x=1702897769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyfE8VPP+jKkzsqzZmDn4AjOdgAMsVW+As3oZ2Yyxl4=;
        b=IEZGAHCJYH1K1fnOK2x4ESepc0svEdg3ylJd6WvQnRSGKDnXnXtSLWsbnN0El2cgCp
         N03hILARPj8I5EdZz9gbtzfw3j7mjRdLzhhXAB/4ULBS8rGE1zRvxDrPCn1I3JrlnuaO
         o+CfJP0HU4AlFunKJF/ET/nW4I6ZlBblZ/G5mQ2CKCkTdtWnsYSsr8PJBL3ov6VUmLKB
         2cIRkbghGQchEhDU2/9shqPrZSCjVTAQI0zuGjPTfa9jeQ+aXgucwqkjsNXGF6a+o+dV
         KlgVoakTmQBloX2qvbOuFffedDbEyM/2Q+rE8GxW1KVPcpqYWh+Jo9RuuXRa2BjBPS0a
         639w==
X-Gm-Message-State: AOJu0Yw//SKtCM8sgQuD5rqASZAdYfVzVGhAcabELWZuIHLlG2WO+tsk
        iXUxNgw7/CJoSN4aOG7tj1CbHw==
X-Google-Smtp-Source: AGHT+IG7flMXnvGlsXDEnxloKTWGQBrZghilaVMWEWQvYtmZTUzuVKEKyJWzBNz+Ke99Xe/GWbImyg==
X-Received: by 2002:a17:906:fccf:b0:a19:9b79:8b47 with SMTP id qx15-20020a170906fccf00b00a199b798b47mr1164955ejb.88.1702292969116;
        Mon, 11 Dec 2023 03:09:29 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id tr6-20020a170907c58600b00a1f73d6f079sm4028469ejc.84.2023.12.11.03.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 03:09:28 -0800 (PST)
Message-ID: <dfc3d1f8-79fe-494d-a946-0e317d36d51c@linaro.org>
Date:   Mon, 11 Dec 2023 11:09:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patch in the nvmem tree
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231211084841.11b2ee48@canb.auug.org.au>
 <20231211113419.327947a7@xps-13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231211113419.327947a7@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/2023 10:34, Miquel Raynal wrote:
> Hi Stephen,
> 
> sfr@canb.auug.org.au wrote on Mon, 11 Dec 2023 08:48:41 +1100:
> 
>> Hi all,
>>
>> The following commit is also in Linus Torvalds' tree as a different commit
>> (but the same patch):
>>
>>    05349b48e254 ("nvmem: Do not expect fixed layouts to grab a layout driver")
>>
>> This is commit
>>
>>    b7c1e53751cb ("nvmem: Do not expect fixed layouts to grab a layout driver")
>>
>> in Linus' tree.
>>
>> Also, please keep all the commit message tags together at the end of
>> the commit message.
>>
> 
> This is actually fine, Srinivas needs this fix in his tree for
> applying other patches, but he anyway sends a big "series" to GKH at
> -rc6 who finally applies the content of the nvmem-next branch.
Or I can merge or rebase on rc5  which should ensure that there are no 
duplicates.

--srini
> 
> Thanks for the reports,
> Miquèl
