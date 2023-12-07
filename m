Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8096F80871E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjLGLyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjLGLyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:54:13 -0500
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4160210C8;
        Thu,  7 Dec 2023 03:54:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 050902084B;
        Thu,  7 Dec 2023 12:54:19 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g1AA3E5yqbnw; Thu,  7 Dec 2023 12:54:18 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 6981820799;
        Thu,  7 Dec 2023 12:54:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6981820799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
        s=202301; t=1701950058;
        bh=vHv2uiIJHFa+oEnwl8Qg+nF1oDhGEIZ83vb7AQ2qMT4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=vpHrysFS3qfhS3tNx1+U3dwrm52+rTHD2Tw735x3IdISWPOeb307vONBxf+x+ZBo+
         vgsuden0nZPxZlye6dmSzhk3cziKo9OuM2+kEA3Si/Jz7ZUBHibxLh6Y9H9wQmt0iW
         xsznjPbTBzA6OJ/EZxUiAPy//PKg8ZspjcvvI5ZQ2xDiqXTPST90nMZJEMlcyWOS5W
         cbN2+VJ3tq2es4nsSZG9qPdlhMSjDnHgqoI6pIBWKv7+i6zWCIsI4URQhCzNjM5ZVl
         rDZBDZ2wP2HL4ggwLxTTMAFfbV2bsxgpx5VtxdQnb/TwisfbhTEREACM/h3vUpZM7p
         VT2f9nfKcylRg==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
        by mailout2.secunet.com (Postfix) with ESMTP id 6447980004A;
        Thu,  7 Dec 2023 12:54:18 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 7 Dec 2023 12:54:18 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 12:54:18 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
        id AC32B31848F7; Thu,  7 Dec 2023 12:54:17 +0100 (CET)
Date:   Thu, 7 Dec 2023 12:54:17 +0100
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
        "Herbert Xu" <herbert@gondor.apana.org.au>, <pabeni@redhat.com>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <antony.antony@secunet.com>,
        <alexei.starovoitov@gmail.com>, <yonghong.song@linux.dev>,
        <eddyz87@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <devel@linux-ipsec.org>
Subject: Re: [PATCH bpf-next v4 03/10] bpf: xfrm: Add
 bpf_xdp_xfrm_state_release() kfunc
Message-ID: <ZXGyacGEeV64J/PE@gauss3.secunet.de>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
 <66e92984df48e03a518580f2d416a6fdb5bd4b0d.1701722991.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66e92984df48e03a518580f2d416a6fdb5bd4b0d.1701722991.git.dxu@dxuuu.xyz>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 01:56:23PM -0700, Daniel Xu wrote:
> This kfunc releases a previously acquired xfrm_state from
> bpf_xdp_get_xfrm_state().
> 
> Co-developed-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
