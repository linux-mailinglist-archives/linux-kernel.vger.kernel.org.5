Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0077B7B1065
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjI1Bcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjI1Bco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:32:44 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2C1AC;
        Wed, 27 Sep 2023 18:32:43 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D07D6901E34;
        Thu, 28 Sep 2023 01:32:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 39D709012B1;
        Thu, 28 Sep 2023 01:32:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1695864762; a=rsa-sha256;
        cv=none;
        b=EObbCsYePKJdFgdQ3aR0jhf1Zc4+RwEWqb306qQ3SJnbf3RoLMDeUpxLX8JfIGucJoD039
        cJfxx3zyqqHg2XSVIk2hvR00yIQkJQQDoptSpS2AEW2c5iwI5Zapsf06MGMFVoZSEvaNiL
        RWnn5gubEI5QZXMCRp6f9IfesyoIdSe+z59rxmeKzGqMpq7IjRmziQt7rfRmVcy3fhCaGe
        n8ILrBgi9Yg4ooVizOsQhAiRaLczhJSc0seLbqT2wuz7AvvcRZQ3lgTiop53MPvVrc6Z/q
        CqPWbLWcHPw1dYp31uBjTp2yKla4UKeoe6ltROyUEgWCkIdAQWCvVl1KPanS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1695864762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=aoMM+ecrUHruHy0xNndpz4cJ9IdeHiZqtMr+bAYPNcU=;
        b=I93n44Le0NvDjV/gK4LuHWJv9vBwlF0EySyeNaYcXyQv3fv8P7iIvGMrga9/nEtv7AUaul
        0FI5a7waegx/YykAyOOfoRnWQQSPrksDRMTkyDXoOtFL6hM+06Avc181wxwu8blxZB4sp9
        QKIO6xEoLOIRbt2VgGqO2RaAVYYBrpvO2ue/O4An3cGEyJyxj5EJFwIT/G0j3jx8TdqQNM
        VRMwBv24Oc5zk0Mxpr/vq9zoxZcCjfywZcyGYgv/iDL6aTDuFbUsf0iyTmCvYwDfRF2XER
        2KkAdE81YVtbIZw/NDB9c0MeIYQUFPmleUf8r49sz0gzh567UCTmGfvjPeSQEg==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-qxxm7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Little-Minister: 7ca387024b77a229_1695864762639_230044770
X-MC-Loop-Signature: 1695864762638:2213682086
X-MC-Ingress-Time: 1695864762638
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.101.166.200 (trex/6.9.1);
        Thu, 28 Sep 2023 01:32:42 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4Rwwvs0kwhz2l;
        Wed, 27 Sep 2023 18:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1695864762;
        bh=aoMM+ecrUHruHy0xNndpz4cJ9IdeHiZqtMr+bAYPNcU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Z/DLACN/18M6imAt+EFXbYxWWkjAVBX3GqQ1aysyAb0TuEAqTRo0pFQ5AV1DWCRfr
         DK7GamF+cAUz/9bJmpeFLmnPuNYcFKq9qWrnFkingF2mteWFDlCKmuFbzrh3z9jXzS
         nKeR2XAWN/vB2SglKKWys89DC1HrRZ+lU1jQiLfrTjDOoup8vKTeRR0qYC+pzfCEJf
         I/Q1iLvY0IeP9KmFgglu0sIMeFnd0SdU8v1ashvIZTC3h2X+VUdsg8cYsKrZgkKpcV
         0iapjx5KDk4+DYlBxS4cZW7WwgWu3m1KXyFPQS/glFjDmle9kjwtk8BaBqXkBBp+gA
         hXer2q7C4czSQ==
Date:   Wed, 27 Sep 2023 18:32:38 -0700
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
Subject: Re: [PATCH v2 4/7] cxl: Fix a checkpatch error
Message-ID: <cuhdyshfzw6mt64ohfbuxmoic5fvaayn73gx6be2vvjtezzwgm@lwqe2dyfmw57>
References: <CGME20230922113317epcas2p4f6b9ee86aeead4ce8b19473379ecf4bb@epcas2p4.samsung.com>
 <20230922113604.3300468-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230922113604.3300468-1-jtp.park@samsung.com>
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

>ERROR: Macros with complex values should be enclosed in parentheses
>
>Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> drivers/cxl/cxl.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>index 76d92561af29..545381355efb 100644
>--- a/drivers/cxl/cxl.h
>+++ b/drivers/cxl/cxl.h
>@@ -142,7 +142,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
> #define CXL_RAS_HEADER_LOG_OFFSET 0x18
> #define CXL_RAS_CAPABILITY_LENGTH 0x58
> #define CXL_HEADERLOG_SIZE SZ_512
>-#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
>+#define CXL_HEADERLOG_SIZE_U32 (SZ_512 / sizeof(u32))
>
> /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
> #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>--
>2.34.1
>
