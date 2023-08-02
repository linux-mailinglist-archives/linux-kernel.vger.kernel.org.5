Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355EA76C864
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjHBIeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjHBIef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:34:35 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C595171B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:34:33 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RG4ys2vdcz9sTy;
        Wed,  2 Aug 2023 10:34:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1690965269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fPZCXWwaboiCsosFBV+TGKPHI0NZRD50bC97h4h0b6M=;
        b=xrKrYKWk7/9Bk+7eCol7EaX/N4y3Pz1aH1PnjKD71QZcedm26Jh9Mm9niIonqFhr8MDYkn
        AbjGhgo3g0szGmjT/aAR+YWy764hlSZsWlQFQ4Cmjh9RAcJBUmhQxm9jAmT4sv/V8MNZBO
        UJzI35F4HJ7rIZMtfrUPGaAxwYg8WAKsHeTmdK0tIxfDLzxV1z045Yt2AkOVaq4bc77G38
        Hn+OYwq8wIhN0HgrT6P8A0NghZJOs6mmAR7VHQzyWfGdlA+qrhgdrbjYAj6c8gsFwo5USl
        8te9MAgp+Mk+D3iYHoG4S/WRdVlWsyg7dHktbEof5M2Th6a6N8G1oUqWoad6eA==
Message-ID: <a9f88c90-5777-02b0-09b1-26979432b3bc@mailbox.org>
Date:   Wed, 2 Aug 2023 10:34:26 +0200
MIME-Version: 1.0
Subject: Re: Non-robust apps and resets (was Re: [PATCH v5 1/1] drm/doc:
 Document DRM device reset expectations)
Content-Language: de-CH-frami, en-CA
To:     =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc:     pierre-eric.pelloux-prayer@amd.com,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        christian.koenig@amd.com
References: <20230627132323.115440-1-andrealmeid@igalia.com>
 <e292a30f-5cad-1968-de4f-0d43c9c1e943@igalia.com>
 <45a1e527-f5dc-aa6f-9482-8958566ecb96@mailbox.org>
 <a1fecc5c-30c0-2754-70a1-2edb2fe118fb@igalia.com>
 <8eb58a5f-02d0-fadf-1d5a-790b6af2d81e@mailbox.org>
 <CAAxE2A6xy5yi7yMH-tzEfC2f3AgL7aesYQNpr=1oZ8Rx0K4=Ug@mail.gmail.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <CAAxE2A6xy5yi7yMH-tzEfC2f3AgL7aesYQNpr=1oZ8Rx0K4=Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6a027a11499082f043b
X-MBO-RS-META: qnjcf7y89rjz4khb5t5tdbymgemp7ina
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 09:38, Marek Olšák wrote:
> 
> The precedent from the CPU land is pretty strong here. There is
> SIGSEGV for invalid CPU memory access and SIGILL for invalid CPU
> instructions, yet we do nothing for invalid GPU memory access and
> invalid GPU instructions. Sending a terminating signal from the kernel
> would be the most natural thing to do.

After an unhandled SIGSEGV or SIGILL, the process is in an inconsistent state and cannot safely continue executing. That's why the process is terminated by default in those cases.

The same is not true when an OpenGL context stops working. Any threads / other parts of the process not using that OpenGL context continue working normally. And any attempts to use that OpenGL context can be safely ignored (or the OpenGL implementation couldn't support the robustness extensions).


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

