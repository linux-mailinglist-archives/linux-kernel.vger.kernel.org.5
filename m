Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D407719FE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjHGGG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHGGGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:06:21 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [134.58.240.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993401708;
        Sun,  6 Aug 2023 23:06:17 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 2981320034.A8C05
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 2981320034;
        Mon,  7 Aug 2023 08:06:12 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691388372;
        bh=BFQM0e7g+mI/8gIBbpN6sEd4TZoiADa3E5JrjbshxvE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=bKd0B19c7f8BBHCHu0EJvXcKc7C5DXY5jLT18Od+QjWSk0d5Pz0nMJ+IvZDGlctWn
         fLUMsejlSExP9BqdTV0TWC1JN+G8o4CLx+lS+LJnOm5B/R2uYebk4xGh1Uuvldu49Q
         v6ln2pfALadcIdDzcTp9Z6XfSjfLlZJ7sQgbcdcU=
Received: from [10.101.1.242] (ip-185-104-137-32.ptr.icomera.net [185.104.137.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 77FA8D4F64538;
        Mon,  7 Aug 2023 08:06:11 +0200 (CEST)
Message-ID: <d3ad2bfb-2d64-73f5-7e37-0119eaa89c93@cs.kuleuven.be>
Date:   Mon, 7 Aug 2023 08:06:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] selftests/sgx: Harden test enclave
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com
References: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
 <CU76BC9V7H3Z.TQ3L8AZY1WD@suppilovahvero>
 <a6e26927-acb0-c967-10c4-90a41d9a8cad@cs.kuleuven.be>
 <CU8WIZGB01DT.2YX12UG6QRTA@seitikki>
 <707e662f-5aed-ef86-a2e3-dda3959d6f7d@cs.kuleuven.be>
 <CUE17WOKP8HH.39KZQV0H8IRBV@seitikki>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <CUE17WOKP8HH.39KZQV0H8IRBV@seitikki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.23 20:54, Jarkko Sakkinen wrote
> It should be relatively easy to relicense the code as most of the
> commits have Intel copyright.
> 
> Personally I would not mind because that would give opportunity for
> code that I wrote to have a wider audience but it needs to be forked
> with some other license first.

> I support also the idea of refining the selftest as a run-time, which
> could perhaps consist of the following steps:
> 
> 1. Create a repository of the self-compiling selftest with GPLv2. You
>    could add also AUTHORS file for the initial content by crawling this
>    data from the git log.
> 2. Create a commit with sob's from the required stakeholders, which
>    changes the license to something more appropriate, and get the
>    sob's with some process.

Thank you Jarkko, appreciated! I plan to start working on the fork from 
next month onwards. However, I think GPL would be the best license for 
this project and I'd prefer to stick to it for the time being.

Best,
Jo
