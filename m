Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F2C7D81E5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344815AbjJZLgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZLgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:36:52 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E8E1A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:36:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ad8a822508so131128466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698320209; x=1698925009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWYalsuNl0GeQaeoBCkFUvRNJn+nLsde/vTacVego88=;
        b=yTIgMX5bryGl0i1x9TUOkBQE9Gc2luBG5YqBBRiGfhFJk3JxwQ0NIRnJMMpA/MJbd/
         IzEWyz9lS9kTjQmOYxziERNjb1plnPEwfAWfb4FptCkH+EDqtU+IXZefPA/rBVsztnq/
         neseqPHXCpq1BRrfrkY+KPzCkKV5HVeBuG9X91I+Aluc4P/CKlfK4jfYqI7dp4/diiwM
         C7/jAxiBWPAOqTGQqhO80fDiXQtR6xaGeZcPDWr1LPS4h4dvSjEb91MkNhO0mGyKO8gk
         UcLBsQWtom4LchH3H7xP6wrorVEPg7DYy5Dmiu0VEC25u+7LEjXRI0upyp+9kYsVlN8b
         GOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698320209; x=1698925009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWYalsuNl0GeQaeoBCkFUvRNJn+nLsde/vTacVego88=;
        b=Sfk40jU2+K348OB1AueBYmVgjXec0lJ1F4QBajlaUO6d048GYOmPftphgyv3HWpgDu
         LlYRhqdaFUDn8Z0/9wWzXAyv/Eu/7S4ajvBKnSK+v9r71ffGYb5GLMabEhQ6XF9+FLuc
         82d2fMkJROLBw+efjl40ZnSkVPFuJnqAUKKcHmpgNNaaPfIotHWfD0eZ5x5yXvt12lBN
         VI2QS/jS+NwIrCpY89YmwQ/zSvvJ+STdStSodZ3JaA5vLDpLFsnteEmpUxLk8+GhHl2k
         hDV8Z9uxX0+0zwFGoNQ7mxEUIYX2Q50aO+FRmL/uCu/JlLIsVRglc3vRTTzPNnPjl5NO
         /rJA==
X-Gm-Message-State: AOJu0Yxze3W8kY66AxSZcERF8wWeUBxtUFJ2cHSy1Sz9PUek5TJK5CBG
        6lJrmlsagfhpJHE4WgCHFxXHLEeBT+4PDom8/+E=
X-Google-Smtp-Source: AGHT+IHXwIFVuNxcH7UCbPkIezQHWYd4SBnppICs6qQor099TsfDj9s962Ec5yeaukOYXULEnOSmkA==
X-Received: by 2002:a17:907:31ce:b0:9be:ef46:6b9c with SMTP id xf14-20020a17090731ce00b009beef466b9cmr15859738ejb.70.1698320208894;
        Thu, 26 Oct 2023 04:36:48 -0700 (PDT)
Received: from [192.168.69.115] (aif79-h01-176-172-114-150.dsl.sta.abo.bbox.fr. [176.172.114.150])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906221600b009ce03057c48sm2209258ejs.214.2023.10.26.04.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 04:36:48 -0700 (PDT)
Message-ID: <b50e4d3a-5b9b-4f3e-5660-69ec96831790@linaro.org>
Date:   Thu, 26 Oct 2023 13:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MIPS: process: Remove lazy context flags for new kernel
 thread
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        syq@debian.org, stable@vger.kernel.org,
        Aurelien Jarno <aurel32@debian.org>
References: <20231026111715.1281728-1-jiaxun.yang@flygoat.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231026111715.1281728-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/23 13:17, Jiaxun Yang wrote:
> We received a report from debian infra team, says their build machine
> crashes regularly with:
> 
> [ 4066.698500] do_cpu invoked from kernel context![#1]:
> [ 4066.703455] CPU: 1 PID: 76608 Comm: iou-sqp-76326 Not tainted 5.10.0-21-loongson-3 #1 Debian 5.10.162-1
> [ 4066.712793] Hardware name: Loongson Lemote-3A4000-7A-1w-V1.00-A1901/Lemote-3A4000-7A-1w-V1.00-A1901, BIOS Loongson-PMON-V3.3-20201222 12/22/2020
> [ 4066.725672] $ 0   : 0000000000000000 ffffffff80bf2e48 0000000000000001 9800000200804000
> [ 4066.733642] $ 4   : 9800000105115280 ffffffff80db4728 0000000000000008 0000020080000200
> [ 4066.741607] $ 8   : 0000000000000001 0000000000000001 0000000000000000 0000000002e85400
> [ 4066.749571] $12   : 000000005400cce0 ffffffff80199c00 000000000000036f 000000000000036f
> [ 4066.757536] $16   : 980000010025c080 ffffffff80ec4740 0000000000000000 980000000234b8c0
> [ 4066.765501] $20   : ffffffff80ec5ce0 9800000105115280 98000001051158a0 0000000000000000
> [ 4066.773466] $24   : 0000000000000028 9800000200807e58
> [ 4066.781431] $28   : 9800000200804000 9800000200807d40 980000000234b8c0 ffffffff80bf3074
> [ 4066.789395] Hi    : 00000000000002fb
> [ 4066.792943] Lo    : 00000000428f6816
> [ 4066.796500] epc   : ffffffff802177c0 _save_fp+0x10/0xa0
> [ 4066.801695] ra    : ffffffff80bf3074 __schedule+0x804/0xe08
> [ 4066.807230] Status: 5400cce2 KX SX UX KERNEL EXL
> [ 4066.811917] Cause : 1000002c (ExcCode 0b)
> [ 4066.815899] PrId  : 0014c004 (ICT Loongson-3)
> [ 4066.820228] Modules linked in: asix usbnet mii sg ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6_tables nfnetlink_log nfnetlink xt_hashlimit ipt_REJECT nf_reject_ipv4 xt_NFLOG xt_multiport xt_tcpudp xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter sch_fq tcp_bbr fuse drm drm_panel_orientation_quirks configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic ohci_pci dm_mod r8169 realtek mdio_devres ohci_hcd ehci_pci of_mdio xhci_pci fixed_phy xhci_hcd ehci_hcd libphy usbcore usb_common
> [ 4066.868085] Process iou-sqp-76326 (pid: 76608, threadinfo=0000000056dd346c, task=000000001209ac62, tls=000000fff18298e0)
> [ 4066.878897] Stack : ffffffff80ec0000 0000000000000000 ffffffff80ec0000 980000010db34100
> [ 4066.886867]         9800000100000004 d253a55201683fdc 9800000105115280 0000000000000000
> [ 4066.894832]         0000000000000000 0000000000000001 980000010db340e8 0000000000000001
> [ 4066.902796]         0000000000000004 0000000000000000 980000010db33d28 ffffffff80bf36d0
> [ 4066.910761]         980000010db340e8 980000010db34100 980000010db340c8 ffffffff8070d740
> [ 4066.918726]         980000010946cc80 9800000104b56c80 980000010db340c0 0000000000000000
> [ 4066.926690]         ffffffff80ec0000 980000010db340c8 980000010025c080 ffffffff80ec5ce0
> [ 4066.934654]         0000000000000000 9800000105115280 ffffffff802c59b8 980000010db34108
> [ 4066.942619]         980000010db34108 2d7071732d756f69 ffff003632333637 d253a55201683fdc
> [ 4066.950585]         ffffffff8070d1c8 980000010db340c0 98000001092276c8 000000007400cce0
> [ 4066.958552]         ...
> [ 4066.960981] Call Trace:
> [ 4066.963414] [<ffffffff802177c0>] _save_fp+0x10/0xa0
> [ 4066.968270] [<ffffffff80bf3074>] __schedule+0x804/0xe08
> [ 4066.973462] [<ffffffff80bf36d0>] schedule+0x58/0x150
> [ 4066.978397] [<ffffffff8070d740>] io_sq_thread+0x578/0x5a0
> [ 4066.983764] [<ffffffff8020518c>] ret_from_kernel_thread+0x14/0x1c
> [ 4066.989823]
> [ 4066.991297] Code: 000c6940  05a10011  00000000 <f4810af0> f4830b10  f4850b30  f4870b50  f4890b70  f48b0b90
> 
> It seems like kernel is trying to save a FP context for a kthread.
> Since we don't use FPU in kernel for now, TIF_USEDFPU must be set
> accidentally for that kthread.
> 
> Inspecting the code it seems like create_io_thread may be invoked
> from threads that have FP context alive, causing TIF_USEDFPU to be
> copied from that context to kthread unexpectedly.
> 
> Move around code blocks to ensure flags regarding lazy hardware
> context get cleared for kernel threads as well.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Aurelien Jarno <aurel32@debian.org>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Folks, it might be helpful to check ST0_CU1 in is_fpu_owner
> to catch this kind of problem in future, what's your opinion?
> ---
>   arch/mips/kernel/process.c | 35 +++++++++++++++++------------------
>   1 file changed, 17 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

