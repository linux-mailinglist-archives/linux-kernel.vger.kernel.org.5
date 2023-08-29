Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AE578D0B1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 01:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbjH2XmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 19:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbjH2Xlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:41:53 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A873E1AD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 16:41:49 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 7B661240104
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:41:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1693352507; bh=D6AYcLbD9pyug1LRusmbFmyIx8d1u0ojE0a7WGxPfcI=;
        h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:
         Content-Transfer-Encoding:From;
        b=E1UA3umtxlMcu7FDgeUIryd/e3tYyoRICaaJb5wQEeLUq0GLbKaLl158Uj1BAYCNy
         TjR/rQYBcpolQqFtmH+8gs36Z3y5DCkFQMDRK2oTVLSi402Jsz3qGItmjP0KpeEfhJ
         ZdK4whamNe3clJRDIaagv9GPvFLak4aN8oNakphqGpOxffCr31fmru4Uk2IgcpeGik
         fyVBe1+QrS+zs7M5F/SyntFiu6BCGxopnlT/MnsFMDF3Anp7kJg/6/EcnJMFk90F+8
         R0AjPFAOJdMuryqMf1aH40ySGTGJp+1DAxpIYemrP+VFS5mjHivJJdpJ6EXwpBEBFZ
         l9Tx2rBqEgKNQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Rb3qD3BwDz6twJ;
        Wed, 30 Aug 2023 01:41:44 +0200 (CEST)
Message-ID: <08a9b45b-f1e8-3fac-3d02-54b7bb31d954@posteo.net>
Date:   Tue, 29 Aug 2023 23:37:15 +0000
MIME-Version: 1.0
From:   Mark O'Donovan <shiftee@posteo.net>
Subject: Re: [PATCH 1/2] nvme-tcp: auth success1 msg always includes resp
To:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
        kbusch@kernel.org, hare@suse.de
References: <20230828212033.3244512-1-shiftee@posteo.net>
 <34c159dc-c534-2329-4049-7e9e8a53cd4d@grimberg.me>
Content-Language: en-US
In-Reply-To: <34c159dc-c534-2329-4049-7e9e8a53cd4d@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 12:47, Sagi Grimberg wrote:
> This is not nvme-tcp specific.
> prefix should be "nvme-auth: ..."
> 
> I'm assuming that this passes blktests?
> 
> Nonetheless looks fine to me.

Yes, the nvme auth blktests all pass with this change.
Sorry about the prefix. Will fix if doing another revision.
