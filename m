Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4960777447
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbjHJJT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbjHJJTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:19:17 -0400
X-Greylist: delayed 508 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 02:17:09 PDT
Received: from isrv.corpit.ru (isrv.corpit.ru [86.62.121.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B453C02
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:17:09 -0700 (PDT)
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
        by isrv.corpit.ru (Postfix) with ESMTP id C86E31982B;
        Thu, 10 Aug 2023 12:08:43 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
        by tsrv.corpit.ru (Postfix) with ESMTP id 10BB11D1D9;
        Thu, 10 Aug 2023 12:08:37 +0300 (MSK)
Message-ID: <38e69323-0185-32bb-2de1-8e5b36de2abc@tls.msk.ru>
Date:   Thu, 10 Aug 2023 12:08:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: LTP test related to virtio releasing and reassigning resource
 leads to guest hung
Content-Language: en-US
To:     "longguang.yue" <kvmluck@163.com>,
        qemu-devel <qemu-devel@nongnu.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <461df15f.15e2d.189deaa6eed.Coremail.kvmluck@163.com>
From:   Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <461df15f.15e2d.189deaa6eed.Coremail.kvmluck@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.08.2023 11:57, longguang.yue wrote:
> Hi, all:
> A ltp test leads to guest hung(io hung), the test releases virtio device resource and then reassign.
> I find device’s mem prefetchable resource 64-bit is changed.
> 
> ltp 
> test: https://github.com/linux-test-project/ltp/blob/522d7fba4afc84e07b252aa4cd91b241e81d6613/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c#L428
> 
> Do you know what cause the problem?
> 
> Thanks very much.
> 
> --------------------------
> ENV: kernel 5.10.0, qemu 6.2

Current qemu is 8.1 (well, almost, to be released this month;
previous release is 8.0 anyway).

This might be interesting to test in a current version before
going any further.

Thanks,

/mjt
