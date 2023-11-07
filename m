Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02017E4584
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344229AbjKGQKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344257AbjKGQIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:08:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0AF27C0F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SA6l50GOPQJbx5V/XeBq9jkSVdxSGlflJzkPFxFjI7A=; b=YTSGytBMomxcyRDFZr4nmNOHLx
        OLnFA2B4lz+dqLV8/kJbAgDUlIeTsf++VIeulJixDlkJZeO4/7xqzhG/wJczjUl6oXsVr9uSyJBHR
        Xl7Roe1I3r16fox5fXXL0zZmPHoDTeqWI6Vd2R/TQ2uLab4RquBJzA4qIPer4GoPx9FCpZoMaCrWc
        tOyyeGUhpC5nBmVzrvl3dJhvV+jzLCul3I0LFKKFjXCFig+ZL07adx/6MZwhFPtclbVX+iXV18eBr
        YMqnFRq1UG4PcfkiJAIIVMgzU54S4ZkOG6B1eaSaDylnnJtsdRlmMSornNr8rV3yrn/WQ8MEtXzTh
        VMcgCyDQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0OVG-001wrP-16;
        Tue, 07 Nov 2023 16:00:37 +0000
Message-ID: <756c9659-5c7d-4e29-b5d1-76b26dd3e0c8@infradead.org>
Date:   Tue, 7 Nov 2023 08:00:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kismet: WARNING: unmet direct dependencies detected for
 SM_GCC_8550 when selected by SM_CAMCC_8550
Content-Language: en-US
To:     Philip Li <philip.li@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kernel test robot <lkp@intel.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <202311062309.XugQH7AH-lkp@intel.com>
 <CAMuHMdUPR2tZmE9AKxa0QWrJJd=tju8=2bPBWQgcPs6_d0sOag@mail.gmail.com>
 <ZUoxYETfECoiqooN@rli9-mobl>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZUoxYETfECoiqooN@rli9-mobl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philip,

On 11/7/23 04:45, Philip Li wrote:
> On Tue, Nov 07, 2023 at 11:11:54AM +0100, Geert Uytterhoeven wrote:
>> Hi Robot,
>>
>> On Mon, Nov 6, 2023 at 4:06 PM kernel test robot <lkp@intel.com> wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   d2f51b3516dade79269ff45eae2a7668ae711b25
>>> commit: ccc4e6a061a21d75b96d82fc4b084a8d96df6eb4 clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550
>>> date:   7 weeks ago
>>> config: arm-kismet-CONFIG_SM_GCC_8550-CONFIG_SM_CAMCC_8550-0-0 (https://download.01.org/0day-ci/archive/20231106/202311062309.XugQH7AH-lkp@intel.com/config)
>>> reproduce: (https://download.01.org/0day-ci/archive/20231106/202311062309.XugQH7AH-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202311062309.XugQH7AH-lkp@intel.com/
>>>
>>> kismet warnings: (new ones prefixed by >>)
>>>>> kismet: WARNING: unmet direct dependencies detected for SM_GCC_8550 when selected by SM_CAMCC_8550
>>>    .config:7280:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
>>                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> Where is this coming from? I have seen this warning in several build
>> reports (earliest 2023-01-31), but cannot reproduce it with the provided
>> commit and config.
> 

I'm pretty sure that what Geert is asking about here is the warning (".config:7280:...") with
the truncated kconfig symbol 'ONFIG_ARCH_MMAP_RND_BITS_MI'.  I have also seen several of these.
Is this a bug in kismet or a bug in the robot or something else?

thanks.

> Hi Geert, this was detected by kismet tool developed by Paul Gazzillo and Necip Fazil Yildiran.
> It can be obtained at [1]
> 
> And the issue detected by it can be reproduced by make olddefconfig as well,
> the detail can refer to the reproduce instruction [2]
> 
> I give a try as below inside mainline repo
> 
> $ git checkout ccc4e6a061a21d75b96d82fc4b084a8d96df6eb4
> $ wget https://download.01.org/0day-ci/archive/20231106/202311062309.XugQH7AH-lkp@intel.com/config -O .config
> $ $ make ARCH=arm olddefconfig
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/confdata.o
>   HOSTCC  scripts/kconfig/expr.o
>   LEX     scripts/kconfig/lexer.lex.c
>   YACC    scripts/kconfig/parser.tab.[ch]
>   HOSTCC  scripts/kconfig/lexer.lex.o
>   HOSTCC  scripts/kconfig/menu.o
>   HOSTCC  scripts/kconfig/parser.tab.o
>   HOSTCC  scripts/kconfig/preprocess.o
>   HOSTCC  scripts/kconfig/symbol.o
>   HOSTCC  scripts/kconfig/util.o
>   HOSTLD  scripts/kconfig/conf
> 
> WARNING: unmet direct dependencies detected for SM_GCC_8550
>   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=y] && (ARM64 || COMPILE_TEST [=n])
>   Selected by [y]:
>   - SM_CAMCC_8550 [=y] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=y]
> 
> [1] https://github.com/paulgazz/kmax#using-kismet
> [2] https://download.01.org/0day-ci/archive/20231106/202311062309.XugQH7AH-lkp@intel.com/reproduce
> 
>>
>> Gr{oetje,eeting}s,
>>
>>                         Geert


-- 
~Randy
