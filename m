Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D327709E3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjHDUld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjHDUla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:41:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287904C3B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:41:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9872A620A7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A863C433C8;
        Fri,  4 Aug 2023 20:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691181687;
        bh=xcsViil0DGLXaWdiuVDPCxOVUlw+P8Xq3hHgt2h9jaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKp9R/cJgL+kEeGwHIXbHHblJtel4OuIyrNgsdzLS6d182eIkNfc5/8YnPDlNPEK3
         c4oGvUPStMf6kOHhP8xE98/9uKBnRFnPIuEFg9g8pVWK7VsuPHzSOoNsMz+mi0PISQ
         mPKzbLHFY+HHeU120+jawOOHRfhObjUEhEWUB0acBhjF0ySQGSIKD9Ndl0v+zB7xfu
         Johmm/LzB5E2sNYx4ezxv+t1+XSruYi5EHqEeNz4gTViCCtzIrBLo6Q5huYcoxqT9i
         guCiZ/HAbhK9QM//ws/vrt8o6kja4gGEjdHFpuTQs9qBFsmK0VjJwNqa1gANZacRPf
         25Ay99oWkeY+A==
Date:   Fri, 4 Aug 2023 22:41:21 +0200
From:   Simon Horman <horms@kernel.org>
To:     "huangjie.albert" <huangjie.albert@bytedance.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Richard Gobert <richardbgobert@gmail.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [RFC Optimizing veth xsk performance 01/10] veth: Implement
 ethtool's get_ringparam() callback
Message-ID: <ZM1icavv+8XeMcQL@vergenet.net>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
 <20230803140441.53596-2-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803140441.53596-2-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:04:27PM +0800, huangjie.albert wrote:
> some xsk libary calls get_ringparam() API to get the queue length

nit: libary -> library

Please consider using checkpatch.pl --codespell
