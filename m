Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3884E7EF772
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 19:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjKQSWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 13:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjKQSWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 13:22:38 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA37AD6A;
        Fri, 17 Nov 2023 10:22:34 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7789aed0e46so141773785a.0;
        Fri, 17 Nov 2023 10:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700245354; x=1700850154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ThSMMdx92RBICUbxUd5gLcrTdFEdBSlHGVFaW7xhfos=;
        b=m5GRRevQ/FUjoOxOIB7QRY1W4vlHcsPiWk0vVuKix1yoKyjPDVDUSF4Rt9H56oNuOn
         DHXhoRK3FYzkPm8q9PjyBgCSMyd9Aa5BnUcO/f9xYrwTpmUw/8vvJRcCWXGtvcBqSyfZ
         o1rMn6fQbtCvtIHpmtqejldtJKag4f0Tm+yP9+kH/2Glw/wd+0qyjDNlhvuw76bSQEBj
         asLhb2XxklR1CYPN0J8C0QUL5F5Gmmb6yvEF2QBHvPWt/3Vq28qoYVp1W+0MWolrPrUa
         TItM3NGth/IW0+MGJzArxhtDzgPepdy7ZmezKdhs7gyOkD3j0vfz4ZVbAEXbs3lxMYVM
         3TxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700245354; x=1700850154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThSMMdx92RBICUbxUd5gLcrTdFEdBSlHGVFaW7xhfos=;
        b=IUPZV09wZFb0J6BrxUCJQotMxC8n7Ll3AnP08LlTCZlcqg9M3jB4oz3xFpouQvR42+
         FmTvc3sUwKgLNdgGa++PA02ty3BlTb74Uykb2mAatJwTZbbPppdGjy5e8/pEwvMXtb1Y
         ILZS/qHzxNDnHs+PQzhjYx/GnutmdzLGLN2Of8bbkznM+ncotpFLyNC7lh7Z8E3RbXdO
         RQyQVCY3RqAZnKsEE+fjgXb/rzGcRf+6ZWCRfgohn7dkWiIqZ71IhFahM8z8lKtg0lJ+
         hY77ryArm2HGbOQNzMgkENFPUfZ9G6uUOaHURcJPVMKWthSdVv/lNaKag0dSh1I8TCNX
         uzzg==
X-Gm-Message-State: AOJu0YwD/kFfMlx4nedA2uJL5EzdeL8Cgjt5VuuKrfvO4FneQtcB0c75
        d5GONAkFBhOmt79DCI5k+7g=
X-Google-Smtp-Source: AGHT+IH1frfKDvH2+FcfmSpdJ9y2edh4aL1OduHzbHEtZF8VA/X5NJpVGmjCcrACj6VpI/5ysqtivg==
X-Received: by 2002:a05:620a:8908:b0:77b:c591:8fa0 with SMTP id ql8-20020a05620a890800b0077bc5918fa0mr310175qkn.75.1700245353951;
        Fri, 17 Nov 2023 10:22:33 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id tp9-20020a05620a3c8900b00775afce4235sm766464qkn.131.2023.11.17.10.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 10:22:33 -0800 (PST)
Message-ID: <9c12b34d-1975-4989-b5e1-4b57be815e58@gmail.com>
Date:   Fri, 17 Nov 2023 10:22:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: microchip: lan743x : bidirectional
 throughput improvement
Content-Language: en-US
To:     Vishvambar Panth S <vishvambarpanth.s@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, jacob.e.keller@intel.com
Cc:     bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
References: <20231116054350.620420-1-vishvambarpanth.s@microchip.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231116054350.620420-1-vishvambarpanth.s@microchip.com>
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

On 11/15/23 21:43, Vishvambar Panth S wrote:
> The LAN743x/PCI11xxx DMA descriptors are always 4 dwords long, but the
> device supports placing the descriptors in memory back to back or
> reserving space in between them using its DMA_DESCRIPTOR_SPACE (DSPACE)
> configurable hardware setting. Currently DSPACE is unnecessarily set to
> match the host's L1 cache line size, resulting in space reserved in
> between descriptors in most platforms and causing a suboptimal behavior
> (single PCIe Mem transaction per descriptor). By changing the setting
> to DSPACE=16 many descriptors can be packed in a single PCIe Mem
> transaction resulting in a massive performance improvement in
> bidirectional tests without any negative effects.
> Tested and verified improvements on x64 PC and several ARM platforms
> (typical data below)
> 
> Test setup 1: x64 PC with LAN7430 ---> x64 PC
> 
> iperf3 UDP bidirectional with DSPACE set to L1 CACHE Size:
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec   170 MBytes   143 Mbits/sec  sender
> [  5][TX-C]   0.00-10.04  sec   169 MBytes   141 Mbits/sec  receiver
> [  7][RX-C]   0.00-10.00  sec  1.02 GBytes   876 Mbits/sec  sender
> [  7][RX-C]   0.00-10.04  sec  1.02 GBytes   870 Mbits/sec  receiver
> 
> iperf3 UDP bidirectional with DSPACE set to 16 Bytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec  sender
> [  5][TX-C]   0.00-10.04  sec  1.11 GBytes   951 Mbits/sec  receiver
> [  7][RX-C]   0.00-10.00  sec  1.10 GBytes   948 Mbits/sec  sender
> [  7][RX-C]   0.00-10.04  sec  1.10 GBytes   942 Mbits/sec  receiver
> 
> Test setup 2 : RK3399 with LAN7430 ---> x64 PC
> 
> RK3399 Spec:
> The SOM-RK3399 is ARM module designed and developed by FriendlyElec.
> Cores: 64-bit Dual Core Cortex-A72 + Quad Core Cortex-A53
> Frequency: Cortex-A72(up to 2.0GHz), Cortex-A53(up to 1.5GHz)
> PCIe: PCIe x4, compatible with PCIe 2.1, Dual operation mode
> 
> iperf3 UDP bidirectional with DSPACE set to L1 CACHE Size:
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec   534 MBytes   448 Mbits/sec  sender
> [  5][TX-C]   0.00-10.05  sec   534 MBytes   446 Mbits/sec  receiver
> [  7][RX-C]   0.00-10.00  sec  1.12 GBytes   961 Mbits/sec  sender
> [  7][RX-C]   0.00-10.05  sec  1.11 GBytes   946 Mbits/sec  receiver
> 
> iperf3 UDP bidirectional with DSPACE set to 16 Bytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID][Role] Interval           Transfer     Bitrate
> [  5][TX-C]   0.00-10.00  sec   966 MBytes   810 Mbits/sec   sender
> [  5][TX-C]   0.00-10.04  sec   965 MBytes   806 Mbits/sec   receiver
> [  7][RX-C]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec   sender
> [  7][RX-C]   0.00-10.04  sec  1.07 GBytes   919 Mbits/sec   receiver
> 
> Signed-off-by: Vishvambar Panth S <vishvambarpanth.s@microchip.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

