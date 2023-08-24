Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6891C7864F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbjHXByF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbjHXByE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:54:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21091E59
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 18:53:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B507B638A9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255F3C433C7;
        Thu, 24 Aug 2023 01:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692842038;
        bh=dUjRC96Y34euUDSaNA/h1pSNeZPTmkLzu7c2FEi2qA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pbk12ZrmqI8Ci5eZuW+fGynBf6JIzCY4Q3k6ZB/HU78f2Jdkaz9ZN5xraaI3HGsMP
         pDJIYewooAbY+9jxcNTA5wpiyUPFF/es9Izng350BdxnNrYf2zxn3v3icKa38RRTsP
         mSCLqHG/EfmUURRhWnoRta6McKOGaIsEOJsNmyj3cexzyIboKmoUvWkOziY5RK71OQ
         o+OrQZ8qJ0qS55rkPQtoefygY5aMAy/qx60L99qjRrBo8USvU1VP8FmETEBrXUY1yu
         DWMXlp9qcUZ7bnJ3unE+cN18tQsrJn2O56YMlyvIEHql0MYoWbDeqIjwtMGoRi+/cH
         tfOw2YjmXN9WA==
Date:   Wed, 23 Aug 2023 18:53:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Pu Lehui <pulehui@huaweicloud.com>
Cc:     linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmrDtnJu?= =?UTF-8?B?IFTDtnBlbA==?= <bjorn@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Xu Kuohai <xukuohai@huawei.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next v2 0/7] Add support cpu v4 insns for RV64
Message-ID: <20230823185356.0db6cc1d@kernel.org>
In-Reply-To: <20230824095001.3408573-1-pulehui@huaweicloud.com>
References: <20230824095001.3408573-1-pulehui@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 09:49:54 +0000 Pu Lehui wrote:
> Add support cpu v4 instructions for RV64.

Please make sure you fix the timezone on your system before sending 
out the next version.
