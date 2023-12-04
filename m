Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D59803554
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjLDNrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjLDNrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:47:22 -0500
X-Greylist: delayed 487 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 05:47:28 PST
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5400:ff:fe00:d7d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7CFD5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:47:28 -0800 (PST)
Received: from [192.168.10.7] (unknown [10.0.12.132])
        by kozue.soulik.info (Postfix) with ESMTPSA id 85C0A2FEC3C;
        Mon,  4 Dec 2023 22:39:10 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 85C0A2FEC3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
        t=1701697152; bh=d3Lp/TNnXUzOcRevuBcNXWyj9LxF9On0/MBKJPlfPWc=;
        h=Date:To:Cc:From:Subject:From;
        b=i4vLcP+am/8BEznekl2eBT1xNWCCKhD3mEZeL7kXvW71HrMxiHmDzF0wc7AJYDe33
         J0KbVnocUQmK3mCs6pigMo0o/R5kjFHMnODg6KwHBA7WVa9cA6UWg6/VezAwRevoEQ
         0U2iqR6euP/NT/8EDtNafsBP09i1EuDMb9+fYfOM=
Message-ID: <bfba8d2c-646d-4d62-9f71-8e388e70f782@soulik.info>
Date:   Mon, 4 Dec 2023 21:39:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     op-tee@lists.trustedfirmware.org
Cc:     linux-kernel@vger.kernel.org, sumit.garg@linaro.org,
        jens.wiklander@linaro.org
From:   Randy Li <ayaka@soulik.info>
Subject: optee: os: toolchains would include linux target macros likes
 __linux__
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I wonder why Optee OS would use a linux target toolchains but not a bare 
metal target(none os)?

gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-gcc 
-dM -E - < /dev/null|grep linux
#define __linux 1
#define __gnu_linux__ 1
#define linux 1
#define __linux__ 1

That makes hard to share a header files between Linux kernel and Optee.  
We like to pass some structure in SHM, but optee don't have all those 
Linux types likes <linux/types.h>.

If optee didn't choose the toolchains for the Linux, we could easily 
decide which part would use for Client Agent(Linux kernel) side or TEE 
OS side.

Why we don't use bare metal toolchains ?


Thank you

Randy Li

