Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFFF7E3B32
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjKGLnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKGLnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:43:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBEA113
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:42:57 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4079ed65582so41659145e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 03:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699357375; x=1699962175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGEhvTNxvZ+h5Fkt3dC7zUDQ3XMREvl5ehstpoBinnw=;
        b=RMmsv0OIsg4TdNKekMswuxc+vP26J4tzrXBgNLbPOYU/gyciK4VuItbzBJtskkEJe2
         z3rmmJQ/+gYtL1+l3HdcV18suQtBa0cQSZy1Il2/tCwg1KChVURzaQctREbj33ZJ+3B2
         /OWDN6rbmur1MS1MhILrmbsm0Q/f9nj5RrCRQh2KkSYL1ERtkskdTmYe0ZR3s7aUrpEb
         1YhiLApm/x39+LQeRS3rfqtK161lrOO6J7trllfYzKiSnebfoJsogvre6DeE1sJanA64
         TOt1DT+5NowqjBkzcRMz1vj0A6BEmVD6+dUsY/at7OtB0BTn0elmeKbS0wEYVY4y2Akb
         rcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699357375; x=1699962175;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGEhvTNxvZ+h5Fkt3dC7zUDQ3XMREvl5ehstpoBinnw=;
        b=dFlx5m5jlL7DJ2AuPwzVK5ftxRacD1llpVCZToEyjK77zdFoEbnp2yOi+NDyY94uQ6
         s3OA6iV6MzpEy0sf2JLgdblDSj2gcq9B2RkyhoExGR0ct7Vi+A37prNNcML+Kp4FFQlB
         dtWiRRraSxrt0RCrWKieu36Qkw5Da98DMx7abJzFjiZLoxyejKb9rI53pbJj4eXlXqdT
         QjvvtEZj4sVHjQKbMh2FwVatil/YpkTPVvLZBi9BDaqhCdqwpT+eZrwJLGU1FhbWJ8QR
         pcNtX8AmLdwb6uuNuBNFs+cVXJsPvOPe6NBA6ar+tyrKnbzNv2dO2Bk/WNIK5jDuTb2Z
         zvPw==
X-Gm-Message-State: AOJu0Yy+ygxfX3LZxDMLUl1GQrav76lZdxMUtX8rlhkicoJ/uw6lMPo5
        0C6TVHHrFBFI7Veh4+vcTr1GvA==
X-Google-Smtp-Source: AGHT+IFQm+hjdtB132m69rSJ4kVRTuI8mxFwCRQqrnTpYUp2PSe9s5IudWPhcJJNHt4IRDBYB1VO5A==
X-Received: by 2002:a05:600c:4f91:b0:401:a0b1:aef6 with SMTP id n17-20020a05600c4f9100b00401a0b1aef6mr2528408wmq.2.1699357375591;
        Tue, 07 Nov 2023 03:42:55 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c1c0800b004063977eccesm15656575wms.42.2023.11.07.03.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 03:42:55 -0800 (PST)
Message-ID: <f2de1860-4f7d-4ca6-8e77-649cf0be10fe@linaro.org>
Date:   Tue, 7 Nov 2023 12:42:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] memory: tegra: Add SID override programming for MC
 clients
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>,
        kernel test robot <lkp@intel.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, dmitry.osipenko@collabora.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231107052824.29418-1-amhetre@nvidia.com>
 <202311071607.IzbwSn2f-lkp@intel.com>
 <1bf51dd9-459a-466f-8b82-a55f7b84bda3@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1bf51dd9-459a-466f-8b82-a55f7b84bda3@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2023 12:40, Ashish Mhetre wrote:
> 
> On 11/7/2023 2:46 PM, kernel test robot wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Ashish,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on tegra/for-next]
>> [also build test WARNING on linus/master v6.6 next-20231107]
>> [cannot apply to tegra-drm/drm/tegra/for-next]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Ashish-Mhetre/memory-tegra-Skip-SID-programming-if-SID-registers-aren-t-set/20231107-133149
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
>> patch link:    https://lore.kernel.org/r/20231107052824.29418-1-amhetre%40nvidia.com
>> patch subject: [PATCH 1/2] memory: tegra: Add SID override programming for MC clients
>> config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231107/202311071607.IzbwSn2f-lkp@intel.com/config)
>> compiler: aarch64-linux-gcc (GCC) 13.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311071607.IzbwSn2f-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202311071607.IzbwSn2f-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>     drivers/memory/tegra/tegra186.c: In function 'tegra186_mc_resume':
>>     drivers/memory/tegra/tegra186.c:78:17: error: implicit declaration of function 'tegra186_mc_client_sid_override' [-Werror=implicit-function-declaration]
>>        78 |                 tegra186_mc_client_sid_override(mc, client, client->sid);
>>           |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     drivers/memory/tegra/tegra186.c: At top level:
>>>> drivers/memory/tegra/tegra186.c:85:13: warning: conflicting types for 'tegra186_mc_client_sid_override'; have 'void(struct tegra_mc *, const struct tegra_mc_client *, unsigned int)'
>>        85 | static void tegra186_mc_client_sid_override(struct tegra_mc *mc,
>>           |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     drivers/memory/tegra/tegra186.c:85:13: error: static declaration of 'tegra186_mc_client_sid_override' follows non-static declaration
>>     drivers/memory/tegra/tegra186.c:78:17: note: previous implicit declaration of 'tegra186_mc_client_sid_override' with type 'void(struct tegra_mc *, const struct tegra_mc_client *, unsigned int)'
>>        78 |                 tegra186_mc_client_sid_override(mc, client, client->sid);
>>           |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     cc1: some warnings being treated as errors
>>
> Fixed all of the warnings and errors in V2 of this series.
> V1 wasn't applied properly in our testing because of which these build

I would suggest to test what you develop, not apply it somewhere else.
Unless you develop on entirely different tree, but then this is the problem.

> errors weren't caught. Sorry for sending V1 with build issues. Please
> use V2 of this series for the reviews.

One version per day. Anyway you could wait till merge window finishes.
Nothing is going to happen with your patch now.


Best regards,
Krzysztof

