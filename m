Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2DA7EE284
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344612AbjKPOQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbjKPOQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:16:44 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C84D57
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:16:38 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso647519b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700144198; x=1700748998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ElVUWhYwhjUaz+i5fxEQgGZtu9viVprV+RDlHgmr48=;
        b=FUyb3MzKKf8sKso181FdukXYjmlAGo52VsiRtEcJZwEUIAoIcUa3tNse0UuBq2VnwO
         eqTqxqjGhKLuRHiz0mOyFA8ZEjRG4hC5CX1t753rUAb+BgrTrwxL1QqwJ5puuCjp2BCw
         0d9SJkOHKCmLAIwr5xfFPK+Az4hQ7CJ1BZr3TTQq99chUMTnxikCgrHyHlWZVDgl9mzO
         USl5FjbASWq5lXZ1cQd9OIKNUM7RIvSyDjLJdjZ24D/gefh09nPHuCaRIAqvOrA9V0br
         wjKmcqLyk5smkdYOpw6b6vwq7n5OCDnjWkGVQsEdt0eZQk7V9Y062wJ2YMrPeQpc5EpW
         Fg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700144198; x=1700748998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ElVUWhYwhjUaz+i5fxEQgGZtu9viVprV+RDlHgmr48=;
        b=a+xHERoB08pvC49higpigKmDEjG9s/0w+5CcE1FUWyX5Gfa5Oy7M48WJihNakRKBvz
         5klp41Hd3+bGV+p3Auzy5f8dvgYNfCmsDje3cC/2+Y6l7ipYZ/v8CPPTfRyWA82sYNpR
         f+rQYuUZ7B/ziX3wDF0oKgfcd/8kl736ArcaeSpu+n4JZoICEO+vQA8m1Kq0g39GGqVN
         Vpi2KaFc+2a/BF+oDp4IXBO3ZEcVJxjgiKKwHJ/TNduPueTQ15UXB2gGer903bP6H/lW
         lRDF4zmV4X/lD8b44NRX8OiYo9gN/Og9+eG2rSG8Boy18IZmhWNHyDqt2/6CuDr6jsEG
         aVYg==
X-Gm-Message-State: AOJu0YxveeJ4/GLAeCXEz8IFn2HgcGB0By48cVq3s7WBap6nWLn37lu1
        /RKjH+e2LRovP7svEb0QFo2kdw==
X-Google-Smtp-Source: AGHT+IHDYa9f557GBCK0UPvCuPl32X8DJWwFlfDMqHlVxXeXT1+T6P8lzVTGSa1++YUZJ4RgeZzmLw==
X-Received: by 2002:a05:6a00:2d04:b0:6c3:3cb0:d85 with SMTP id fa4-20020a056a002d0400b006c33cb00d85mr3029770pfb.0.1700144198163;
        Thu, 16 Nov 2023 06:16:38 -0800 (PST)
Received: from ?IPV6:2804:14d:5c5e:44fb:1a83:7b97:b72d:6c9a? ([2804:14d:5c5e:44fb:1a83:7b97:b72d:6c9a])
        by smtp.gmail.com with ESMTPSA id c15-20020a62e80f000000b0068ffd56f705sm4560377pfi.118.2023.11.16.06.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:16:37 -0800 (PST)
Message-ID: <f9f772dd-5708-4823-9a7f-20ae8536b5e5@mojatatu.com>
Date:   Thu, 16 Nov 2023 11:16:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [selftests/tc] d227cc0b1e:
 kernel-selftests.tc-testing.tdc.sh.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
References: <202311161129.3b45ed53-oliver.sang@intel.com>
Content-Language: en-US
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <202311161129.3b45ed53-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 03:42, kernel test robot wrote:
> 
> hi, Pedro Tammela,
> 
> we reported
> "[linux-next:master] [selftests/tc]  d227cc0b1e: kernel-selftests.tc-testing.tdc.sh.fail"
> in
> https://lore.kernel.org/all/202310251624.5ce67bed-oliver.sang@intel.com/
> when this commit is in linux-next/master
> 
> now we noticed this commit is in mainline, and we observed same issue.
> 
> we noticed test can pass upon parent commit, looks like:
> 
> # timeout set to 900
> # selftests: tc-testing: tdc.sh
> # considering category actions
> #  -- scapy/SubPlugin.__init__
> #  -- buildebpf/SubPlugin.__init__
> #  -- ns/SubPlugin.__init__
> # Setting up namespaces and devices...
> # Test d959: Add cBPF action with valid bytecode
> # Test f84a: Add cBPF action with invalid bytecode
> ...
> #
> ok 1 selftests: tc-testing: tdc.sh
> 
> but after this commit, seems test cannot start as below details.
> want to consult if there is any prerequisite to run
>      kernel-selftests.tc-testing.tdc.sh
> after this commit?
> 
> 
> Hello,
> 
> kernel test robot noticed "kernel-selftests.tc-testing.tdc.sh.fail" on:
> 
> commit: d227cc0b1ee12560f7489239fc69ba6a10b14607 ("selftests/tc-testing: update test definitions for local resources")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linux-next/master 8728c14129df7a6e29188a2e737b4774fb200953]
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-60acb023-1_20230329
> with following parameters:
> 
> 	group: tc-testing
> 
> 
> 
> compiler: gcc-12
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202311161129.3b45ed53-oliver.sang@intel.com
> 
> KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607
> 2023-11-15 20:15:35 ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
> 2023-11-15 20:15:35 ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
> 2023-11-15 20:15:35 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
> LKP WARN miss config CONFIG_ATM= of tc-testing/config
> LKP WARN miss config CONFIG_PTP_1588_CLOCK_MOCK= of tc-testing/config
> 2023-11-15 20:15:39 make -j36 -C tc-testing
> make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607/tools/testing/selftests/tc-testing'
> clang -I. -I/include/uapi -idirafter /opt/cross/clang-4a5ac14ee9/lib/clang/17/include -idirafter /usr/local/include -idirafter /usr/lib/gcc/x86_64-linux-gnu/12/../../../../x86_64-linux-gnu/include -idirafter /usr/include/x86_64-linux-gnu -idirafter /usr/include -Wno-compare-distinct-pointer-types \
> 	 -O2 --target=bpf -emit-llvm -c action.c -o - |      \
> llc -march=bpf -mcpu=probe  -filetype=obj -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607/tools/testing/selftests/tc-testing/action.o
> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607/tools/testing/selftests/tc-testing'
> 2023-11-15 20:15:44 make quicktest=1 run_tests -C tc-testing
> make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607/tools/testing/selftests/tc-testing'
> TAP version 13
> 1..1
> # timeout set to 900
> # selftests: tc-testing: tdc.sh
> #
> not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 900 seconds
> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607/tools/testing/selftests/tc-testing'
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20231116/202311161129.3b45ed53-oliver.sang@intel.com
> 
> 
> 

Hi!
Thanks for the report.
I'm trying to address this issue and others in this series:
[PATCH net-next 0/4] selftests: tc-testing: updates to tdc

I have seen this timeout in other CIs as well, but I cannot reproduce 
locally, even with the CI build running on my laptop. I did notice in my 
local tests that KVM is a big factor for test completion, so it begs the 
question, is it running on a KVM enabled instance?

If there's any document describing the runner instances I would be 
interested too.
