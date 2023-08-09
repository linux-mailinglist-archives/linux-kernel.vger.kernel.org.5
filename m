Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F61577543E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjHIHfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjHIHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:35:20 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E7172A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:35:19 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RLMKD6qZSz9v00;
        Wed,  9 Aug 2023 09:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1691566512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DEzjFcmaNxZugcucpOuDAjcZ34NVz+o1bZiw2+i32OM=;
        b=R29Dtl0S1qAUj0JAGUt5pGA9u6ILeV85p8T9JYHMhnC39jns2UGHKleZmk9QQkcRvBTO6p
        kZoX0MI7lTOEcraNsrKV+d+NLtyjTreUK8LAhKwxzmhY8mypZXp7PWl7OoBh1hOHG98qx2
        /XrF/03v7niPWKnhZWewyn+1NIHMIG5qCKJKq0pYb9riQiP7Aqe/aLYPR4QHoGzRLYYSDX
        NaCkb/sNVuqyKCZpk2zu5K4dmiIET8vgHUaOQpIYvmcz+zoPMEzIdf/AbOijzqLA2e1upb
        29G0gcGn6yxfM+fRNZlDaZku0TEPvK4f8AC44UMK+wC/VlhkWp9IihoJLNiwSg==
Message-ID: <3ca7a141-1385-351e-9186-00874e254165@mailbox.org>
Date:   Wed, 9 Aug 2023 09:35:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/1] drm/doc: Document DRM device reset expectations
Content-Language: de-CH-frami, en-CA
To:     =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Sebastian Wick <sebastian.wick@redhat.com>
Cc:     pierre-eric.pelloux-prayer@amd.com,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        christian.koenig@amd.com
References: <20230627132323.115440-1-andrealmeid@igalia.com>
 <ZMz3IXIzXS5gNK3G@phenom.ffwll.local>
 <CA+hFU4wbn=efbS10c14A9sLTf9GYJ_O12kowh76ELLdo2+x5fA@mail.gmail.com>
 <CAAxE2A48uybsU6DY+fLTzQ9K2b0Ln+SW6bt3capbGAGb7L8fvQ@mail.gmail.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <CAAxE2A48uybsU6DY+fLTzQ9K2b0Ln+SW6bt3capbGAGb7L8fvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2bdccb62d3f6edce11c
X-MBO-RS-META: xh66k1zp6rbw13e8n5k4ceq5xbddgups
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 19:03, Marek Olšák wrote:
> It's the same situation as SIGSEGV. A process can catch the signal,
> but if it doesn't, it gets killed. GL and Vulkan APIs give you a way
> to catch the GPU error and prevent the process termination. If you
> don't use the API, you'll get undefined behavior, which means anything
> can happen, including process termination.

Got a spec reference for that?

I know the spec allows process termination in response to e.g. out of bounds buffer access by the application (which corresponds to SIGSEGV). There are other causes for GPU hangs though, e.g. driver bugs. The ARB_robustness spec says:

    If the reset notification behavior is NO_RESET_NOTIFICATION_ARB,
    then the implementation will never deliver notification of reset
    events, and GetGraphicsResetStatusARB will always return
    NO_ERROR[fn1].
       [fn1: In this case it is recommended that implementations should
        not allow loss of context state no matter what events occur.
        However, this is only a recommendation, and cannot be relied
        upon by applications.]

No mention of process termination, that rather sounds to me like the GL implementation should do its best to keep the application running.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

