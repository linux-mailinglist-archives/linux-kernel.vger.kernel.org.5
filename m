Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8345D76555E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjG0NzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjG0NzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:55:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D8030D2;
        Thu, 27 Jul 2023 06:55:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-317798b359aso999460f8f.1;
        Thu, 27 Jul 2023 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690466102; x=1691070902;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nozTGLuTxwX4YJWSLgmQ8WaXWgvzozi46ZP3VPVekc=;
        b=TNjxezU2c3sIMI/qT2XvKL3r2oUybJ7vmj5+fcZBeCFYjYYPxztUZCUz3K7KwenyMd
         Rb4eGBez3mlArn6wbfavXwpeXFTNcDpjeK9+WiN7nXV8addMqlJOSDcivjDsx/P8xdvu
         00lIsMOLrDayRxUSz8vMlOvOIc06kVAhSQTygoF+P0NUUKljtuZFp34P7V8C0f8Er9kx
         /AOVOW3W9xPS07vtIbFdHwnaNjc2HH2XhElFPpT8CqvOCMEM/9ADvMrsDrBzh17pfslD
         5fIbmqCDpAwpVkYGNcQmT/9/k/kopiizuEF/yd3rjARUBvI4vH3UHXERr26mE/7BN83V
         KlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690466102; x=1691070902;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6nozTGLuTxwX4YJWSLgmQ8WaXWgvzozi46ZP3VPVekc=;
        b=JfCSZdOpDY/IN+tC8o1Z+pDqYMsVOaqOdbq1RB2LPCz04BmtiVBW88UD2JiYiGesH3
         h7v5aysA2X5q0PxGQLhQWvQWLvERLohMSbfk8eVtKzR6yuq3srAaf48jyR+j8QmNbbiF
         memxAJ/CpjiZ5GQ1p6a8fzxe/UVxICpjaDubQSUaqH4Ip6REWsyuFtLgyGedxo7Tjghw
         DGeKsP52wyzBKnL1tCQrKK8o3DEDWg+nIQfnUWOBhdyFYZMyZmgseggfse2EIZZbXw+0
         E6154QikJktrFZ2V9m/ArAUaDD4jCgoLc7hQLFWr850bvzsmF6Gw/AYcaWgA/Abj7HUs
         iGsA==
X-Gm-Message-State: ABy/qLZp55I8c2xiJSJS98Y+fLkHoEfZLM4MpTYIpUfIJVw3vajERqLj
        qiH0Wewbby7r4h4VSYXSOhnoMNBdiC6SMw==
X-Google-Smtp-Source: APBJJlEwBetgbbB60dyxoBrHKHbl8kWkLb+v4ozb+yHuHulLmItrahjyeOEvDwrELCuhwKxwMmYzSQ==
X-Received: by 2002:a05:6000:1152:b0:314:1ce9:3c86 with SMTP id d18-20020a056000115200b003141ce93c86mr1739331wrx.0.1690466101846;
        Thu, 27 Jul 2023 06:55:01 -0700 (PDT)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id r5-20020a056000014500b0031751d7d8a6sm2167440wrx.18.2023.07.27.06.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 06:55:01 -0700 (PDT)
Message-ID: <21e2ea66-9524-8e34-a2f0-8e16b9617d68@gmail.com>
Date:   Thu, 27 Jul 2023 14:55:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Alexander Antonov <alexander.antonov@linux.intel.com>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: potential return of uninitialized variable ret in function
 skx_upi_topology_cb
Cc:     linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis with cppcheck has detected a potential return of an 
uninitialized variable in function skx_upi_topology_cb. The issue was 
introduced with commit:

commit 4cfce57fa42d277497cd2c425021312eae2f223c
Author: Alexander Antonov <alexander.antonov@linux.intel.com>
Date:   Thu Nov 17 12:28:28 2022 +0000

     perf/x86/intel/uncore: Enable UPI topology discovery for Skylake Server

static int skx_upi_topology_cb(struct intel_uncore_type *type, int segment,
                                 int die, u64 cpu_bus_msr)
{
         int idx, ret;		

^^ ret is not initialized

         struct intel_uncore_topology *upi;
         unsigned int devfn;
         struct pci_dev *dev = NULL;
         u8 bus = cpu_bus_msr >> (3 * BUS_NUM_STRIDE);

         for (idx = 0; idx < type->num_boxes; idx++) {
                 upi = &type->topology[die][idx];
                 devfn = PCI_DEVFN(SKX_UPI_REGS_ADDR_DEVICE_LINK0 + idx,
                                   SKX_UPI_REGS_ADDR_FUNCTION);
                 dev = pci_get_domain_bus_and_slot(segment, bus, devfn);

^^ dev may be null, so ret is never assigned

                 if (dev) {
                         ret = upi_fill_topology(dev, upi, idx);
                         if (ret)
                                 break;
                 }
         }

         pci_dev_put(dev);
         return ret;
}

I suspect this probably is very unlikely, but it would be useful to have 
ret initialized to some value to avoid garbage being returned. Not sure 
what the best value is to set as as default in this corner case.

Colin
