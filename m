Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4947FA00D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjK0MxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjK0Mw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:52:57 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDBC10F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1701089581;
        bh=WSl+QHzAtYy6sQQZvZFHvD5JXIRKPvHVb76cAb3EPMM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T/b6WydylQPSDPwnZryY/4LIdmNEvSWIeSNeOCkmOa6BPdCro8a0Z5rsvqgrz3Udi
         ZzhOk6+6Bk1FHYRHCNjgmw/e1jiBj4IrobkRWfvsgT6/2o19+sUcrDIZKjGIoW1Jh0
         E3797ED0tSDGLD6Z7ZBbf0jcu8dajFtrv2Cxk4FZ3p630DBQBC3R2XDcPfM5PX3m7o
         MI6cYUFxaOkdyfsFyEKIYlG/EqYmawnbj4wZTanwK37QjEkxwdJYbwrfYo/qsBHbJT
         s4fUH8jDMNWwXooAQdnM4T8p/uPPvMJTzl+1fhLlcJWP/d5RZ1V4LMlMgc/P+RHZsS
         tiltlaabC5uTg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Sf59870zLz1dCj;
        Mon, 27 Nov 2023 07:53:00 -0500 (EST)
Message-ID: <1a9275e7-db07-42e8-9c34-8cd6ffe185d3@efficios.com>
Date:   Mon, 27 Nov 2023 07:53:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] locking: Introduce prepare_sync_core_cmd()
Content-Language: en-US
To:     Andrea Parri <parri.andrea@gmail.com>, paulmck@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
        charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231127103235.28442-1-parri.andrea@gmail.com>
 <20231127103235.28442-2-parri.andrea@gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231127103235.28442-2-parri.andrea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-27 05:32, Andrea Parri wrote:
> Introduce an architecture function that architectures can use to set
> up ("prepare") SYNC_CORE commands.
> 
> The function will be used by RISC-V to update its "deferred icache-
> flush" data structures (icache_stale_mask).
> 
> Architectures defining prepare_sync_core_cmd() static inline need to
> select ARCH_HAS_PREPARE_SYNC_CORE_CMD.
> 
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

