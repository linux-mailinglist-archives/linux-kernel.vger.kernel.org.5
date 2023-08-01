Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3E776B023
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjHAJ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjHAJ7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:59:31 -0400
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D192185;
        Tue,  1 Aug 2023 02:59:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 2385C2065A;
        Tue,  1 Aug 2023 11:59:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QOUV8rQq0dN5; Tue,  1 Aug 2023 11:59:25 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 3F8D020561;
        Tue,  1 Aug 2023 11:59:25 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
        by mailout1.secunet.com (Postfix) with ESMTP id 392D080004A;
        Tue,  1 Aug 2023 11:59:25 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 11:59:25 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 11:59:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
        id 6E2CA3182AA1; Tue,  1 Aug 2023 11:59:24 +0200 (CEST)
Date:   Tue, 1 Aug 2023 11:59:24 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Lin Ma <linma@zju.edu.cn>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] xfrm: add NULL check in xfrm_update_ae_params
Message-ID: <ZMjXfOIpOXcRF5Sn@gauss3.secunet.de>
References: <20230721145103.2714073-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230721145103.2714073-1-linma@zju.edu.cn>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:51:03PM +0800, Lin Ma wrote:
> Normally, x->replay_esn and x->preplay_esn should be allocated at
> xfrm_alloc_replay_state_esn(...) in xfrm_state_construct(...), hence the
> xfrm_update_ae_params(...) is okay to update them. However, the current
> implementation of xfrm_new_ae(...) allows a malicious user to directly
> dereference a NULL pointer and crash the kernel like below.

...

> This Null-ptr-deref bug is assigned CVE-2023-3772. And this commit
> adds additional NULL check in xfrm_update_ae_params to fix the NPD.
> 
> Fixes: d8647b79c3b7 ("xfrm: Add user interface for esn and big anti-replay windows")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Applied, thanks a lot!
