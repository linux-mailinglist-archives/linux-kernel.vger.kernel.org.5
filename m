Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E06753A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjGNMUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGNMUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:20:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498901FD6;
        Fri, 14 Jul 2023 05:20:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0c:5a83:9100:a000:f3b4:c45b:fd64:e7b9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7574E6605954;
        Fri, 14 Jul 2023 13:20:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689337241;
        bh=/QK1CvoIj4sPYbE24wl2osdOcD4Lks2qAy78j0SBdy4=;
        h=From:To:Cc:Subject:References:In-reply-to:Date:From;
        b=KI+v8ICaXYe0qBHunUu7ifXsoZFh1r1SckVzT9hMQMwjecy5kF+NRZAAbS9gav9y/
         SCbi8kn9r/2R+/4Nc1wjt6JANiMyAPLZgZy7XOu20jzoCeZ8wl59PvmfU6YevsO3SX
         ofYQUvoaGD68Qz1iUEkO1pUHV3petdAOlvQKBcVR5vLwDYTwwewTAmEdH7YjUdmIHd
         ZYoG/MHdayycywJpSlPyA74BCC17CNdrcYHjd+jRMiSOy2By4PizahiOktBb9xo/k2
         xIWtuP1b2++ufZgcQnS5yOHfFvKwQvRMnCnhCpFl8Fxkro45hbT7oFk3MI/g2DbHha
         1pkEmWD0Xss8g==
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alexander.deucher@amd.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: replace 1-element arrays with flexible arrays
References: <20230712083137.1080883-1-ricardo.canuelo@collabora.com> <CADnq5_OUS=JDfCdrCsuzTB0xD5yeX7piEDEqkRO-ffPTFVYs3g@mail.gmail.com> <ZLEmDBfklhfGCLGa@mail.google.com>
In-reply-to: <ZLEmDBfklhfGCLGa@mail.google.com>
Date:   Fri, 14 Jul 2023 14:20:38 +0200
Message-ID: <87ilamit0p.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paulo,

> I didn't review all struct changes but I reckon that you got the train
> of thought to be followed by now. Please count on me for reviewing those
> changes :-)

Thanks for reviewing the patch. It turned out that making these changes
properly isn't so trivial as I thought and I'll need to spend more time
working on it. Unfortunately I can't right now and I'll be away next
week. Since this isn't really urgent I guess I can keep working on it
after I come back. I'll take your suggestions into consideration for v2.

Cheers,
Ricardo
