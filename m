Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30627B1064
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjI1Bbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjI1Bbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:31:44 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB64FBB;
        Wed, 27 Sep 2023 18:31:42 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2000D2C1110;
        Thu, 28 Sep 2023 01:31:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 731102C134A;
        Thu, 28 Sep 2023 01:31:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1695864701; a=rsa-sha256;
        cv=none;
        b=EBhIFSEkdqaJy7NiBaHnix5cEIfrIG9WARuMIX5RpVgcevBmuVgs5IURcFqUbjRJJuOnHn
        T9C6WtgKr5uSx5LeC65b1TEqEAI5vDS0lfiBE17IgMBtyZwwSQT+FcWlSiv345Y4b9C9do
        xWufu6UHBZfccGaaPsn7LrQC/VfiFKxi7y+AbY6oEIF2K+HeUZ7fdDTLjaio1Yjy9UcsT1
        cr4rhyk+9f8UA7yPX6S5svSdBY31AJX+dgxOeexl5Fyuf7+eeD59sBtiIJ94ImhwHZKnyQ
        oMd68FGzDawmtnneeKIr0tdmPKHRppOV/qMXrZ+2jZRJJcpHreIMBJxbKjZerQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1695864701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=2RufNGDmtSmhrHyIV//zp+KGm/+2/llNbQZbrG1IKno=;
        b=XWYm3QfcUMAFl6Q1/I5q3Lkmnint5E4TAHirsnKqGAlxIlHYKaTWQ8smwkHd5co0i+xbZq
        9wvEEY2NDm2l1LheBh0cWEGyPo1QW0XtkxPfyNyOX+6Ss9jjoyAbT3tQaSFfaphG6NqKAD
        oEM/wfkU8QNwucxOrZqCq6zehG9W34o9GhkmEbVXK62Q0Wo2Ll4gEc7hEPUfS8ilSfoFNd
        0MGo03QwYnwkDNgB9tGcB2nmH34eHye/Z2Chjtkix4s6Mm5sQRr0QKAriYdLOw/EbJlmTB
        QmGgWGuEhDZyrG61RCU5Qp+4G0JNJgdmr1Sl7B0j4o2xBU9RBjVZH2XmjAaSjg==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-ng27d;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Rock-Troubled: 3bcd23e333892077_1695864701958_206748006
X-MC-Loop-Signature: 1695864701958:4120678417
X-MC-Ingress-Time: 1695864701958
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.162.150 (trex/6.9.1);
        Thu, 28 Sep 2023 01:31:41 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4Rwwth38JyzDV;
        Wed, 27 Sep 2023 18:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1695864701;
        bh=2RufNGDmtSmhrHyIV//zp+KGm/+2/llNbQZbrG1IKno=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=nITo8LpsUdGl6aVqEsf0vM0o60ErbSZ4nJ5tMN2F8HODFQ5j+Zd6V/1AaofYUojDp
         ib95kGf/dD0vp9gPq3DC5VIfVZ7c5xNS16MXa8pUWWhlsuyl6+4JzcLFBixYNJFP77
         yRX/2xOQezTcAM/kEOfX78RFKqBF2HgA3WcCxpi7h9CIcA2Yqz0b2IjmOaYrOSuQ07
         enPWQgSzrnCnxSbCESWJmcf+637DBqJ3QpQsKXULT5ESaF3S4j1/TQ4CLWDenxPjgs
         66jghqf3QPXXiP9M9KmlQWBppR320WXUgFeljsV6VMw/gz4P+OAOpcswbmwu6GZkxw
         RpCW524krvi7g==
Date:   Wed, 27 Sep 2023 18:31:37 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jeongtae Park <jtp.park@samsung.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>
Subject: Re: [PATCH v2 7/7] cxl/memdev: Fix a whitespace warning
Message-ID: <zj4pigcxmpycmqqrfym7hhvc7s3gk5juhkziehvyjduydlt226@bke4pkczaxyt>
References: <CGME20230922113404epcas2p3995ec7890319931c33b0a549214c95ca@epcas2p3.samsung.com>
 <20230922113650.3301992-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230922113650.3301992-1-jtp.park@samsung.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023, Jeongtae Park wrote:

>WARNING: please, no spaces at the start of a line
>
>Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
>---
> drivers/cxl/core/memdev.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>index 7e8fca4707c0..ce67df163452 100644
>--- a/drivers/cxl/core/memdev.c
>+++ b/drivers/cxl/core/memdev.c
>@@ -1010,7 +1010,7 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
>	}
>
>	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
>- }
>+}

While nothing wrong, I do prefer this being corrected via

https://lore.kernel.org/linux-cxl/20230811025755.15103-1-dave@stgolabs.net/

Thanks,
Davidlohr
