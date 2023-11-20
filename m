Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFBB7F1D69
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjKTThw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjKTThv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:37:51 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72B6AA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:37:47 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40839652b97so17535135e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700509066; x=1701113866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJc2P+H4qPjnzt5JpGUrELEszaEwFiAuPe2HRvlRg1o=;
        b=BSC3W9d2II6YaeP88Fgq9d5dJuk76z+Gm37mPB5qIKEO/9IXE2VIeHv6kEsnIRZjLh
         WkdKIcFQjUS7rob2T3Nbj2fxzMdM8m/M4DmBBI/m5EvN370B7iqnxH2MOn6nnCksgxuN
         13/B7T/NkQSBVJrHA+a4bgGtULQHc6bDnrJBSMSsK8mWNbr1CGD2J5vgIZFMvvPuSanO
         +z4o4PAh8Mkwl78urkRTl60K0XEhuZ+EzMLoadg4tPEZpMz/m1GS7Q1QBDqVF6czjgc2
         Vsqw2FmLs6GS6wg81T1/a+L6MKEWNEr8yZI1OMsXa4G5LFaHeiMgvFVFHl/2qwWm0bfT
         J8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700509066; x=1701113866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJc2P+H4qPjnzt5JpGUrELEszaEwFiAuPe2HRvlRg1o=;
        b=Qvhx5N4BHBEVRmRMs3BJX8xnC+jsFDUcZaxZOLY0ayjbzvBsfarNQRHnzGfybaw4yq
         ky2XULREvscf2/HRzrFkteY71RhHlIffVLjhRTKq3Fud+lUIjoLOnw1Up8X5UU4fpW6x
         WIJOeMJAwQeU9RnZQ2g0WaA6Gj6Z99t4D804oCk5RzVxvDSh9giu3jz2Pt6yaU05jKZe
         RY2NjkjpUwQooB/1xReK9+Eg0F2wjjitGk7sDAyURUWWGrWMBycrV2XZfNw8o0qFK6gw
         1yXZ5hnDiQ6u+3bOlH2jwI3JLvFScEACa7b4Z+8BM4SWEkVDuMaRZL047p3ifiZzGTDM
         ezJA==
X-Gm-Message-State: AOJu0YxuOoxbATlBHgy5H0Gu3+5Z6CWTKYWrqOjU0E51F12USyi/fMQ+
        fMv35gT6w8OIEqpfdsK0ntg=
X-Google-Smtp-Source: AGHT+IFe18ytM1aq2L6AaKShOi/qMYrjVdBqfo/o3ScUl/4YH9tqS3A19QEE9XowLa4jOIzMF6gMMw==
X-Received: by 2002:a05:6000:1445:b0:332:ca81:4f2a with SMTP id v5-20020a056000144500b00332ca814f2amr2185283wrx.51.1700509065567;
        Mon, 20 Nov 2023 11:37:45 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id c15-20020adfe70f000000b0032da8fb0d05sm12035201wrm.110.2023.11.20.11.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 11:37:45 -0800 (PST)
Message-ID: <9b5c1aa6-e40c-48f7-8962-ffb029a706ac@gmail.com>
Date:   Mon, 20 Nov 2023 20:37:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/firmware/qcom/qcom_scm.c:1652:34: warning: unused
 variable 'qcom_scm_qseecom_allowlist'
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     llvm@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <202311191654.S4wlVUrz-lkp@intel.com>
 <f7500671-812d-42ab-a16e-3325e13324ff@gmail.com>
 <220a0b53-14eb-445a-9232-f8df314a29bf@kernel.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <220a0b53-14eb-445a-9232-f8df314a29bf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/23 19:51, Krzysztof Kozlowski wrote:
> On 20/11/2023 19:19, Maximilian Luz wrote:
>>
>>
>> On 11/19/23 10:13, kernel test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   037266a5f7239ead1530266f7d7af153d2a867fa
>>> commit: bdac188ec3c71800dd8419620224ee74ef37732a firmware: qcom: move Qualcomm code into its own directory
>>> date:   4 weeks ago
>>> config: s390-randconfig-002-20231119 (https://download.01.org/0day-ci/archive/20231119/202311191654.S4wlVUrz-lkp@intel.com/config)
>>> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311191654.S4wlVUrz-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202311191654.S4wlVUrz-lkp@intel.com/
>>>
>>> All warnings (new ones prefixed by >>):
>>
>> [...]
>>
>>>>> drivers/firmware/qcom/qcom_scm.c:1652:34: warning: unused variable 'qcom_scm_qseecom_allowlist' [-Wunused-const-variable]
>>>       1652 | static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
>>>            |                                  ^
>>
>> Any ideas why this is supposedly unused? It should be accessed through
>> qcom_scm_qseecom_init() and qcom_scm_qseecom_machine_is_allowed().
>> Especially if CONFIG_QCOM_QSEECOM=y.
> 
> And in other cases? The bot reports specific failure on specific config.
> You have the config for this arch attached, so you can investigate.

Ah I see now. It's because of_match_node() is defined as macro if !OF
and not as function. I had assumed it's a regular (potentially empty)
function in either case, sorry.
  
> Anyway, short look at the code indeed tells it is unused. It's not
> referenced anywhere except of_match_node(). I can fix this.

Thanks for the fix.

Best regards,
Max
