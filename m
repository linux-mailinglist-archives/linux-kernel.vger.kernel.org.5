Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4001477B639
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjHNKMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbjHNKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:12:22 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD53199F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:12:00 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RPVYW6kb9z9shD;
        Mon, 14 Aug 2023 12:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1692007903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRmekkgzYD+ywS0c9zPB8cc4nrdPTbQZm63uTZVZSHY=;
        b=f/y5bHDQs/AO8BpFCZNWo7L/AsZywOE2HEm/AqCzLvcmVXHVMGdlco5KE914O1JLyjeYyF
        NoFl/bJ4tWra/C9n/n1aPlEtl0GH1dybmNgAsRR4TOxlab2robBUY+DPICkg5K/S7w9amB
        WcKYL78aLdy4nJTCmTQzykXyNwBPRYKH4MGHWOYVBhMGSca8ABOYIpyHMHv7jcrnYsZi5i
        pOQPpC1TfXqdEH2BnE/tIym4UtA3tE5yatUp2yrQ+RjSH27vMqm4C+XZMhzTzhbh9MwJBC
        16CHfuyFFUgmWAJhwkdLnsPrRvRKeZX7M5P6l/wuP2yrrOD88Ginp/62eIy7qw==
Message-ID: <8e560379-4bdc-a3f0-591a-435833bfacda@mailbox.org>
Date:   Mon, 14 Aug 2023 12:11:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v6] drm/doc: Document DRM device reset expectations
Content-Language: de-CH-frami, en-CA
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pierre-eric.pelloux-prayer@amd.com,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com
References: <20230811185508.252194-1-andrealmeid@igalia.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20230811185508.252194-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qjyhhe5pbxmotxcc3nc413xfdj3mkqrm
X-MBO-RS-ID: 1b65540c5e13e99182b
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/23 20:55, André Almeida wrote:
> Create a section that specifies how to deal with DRM device resets for
> kernel and userspace drivers.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>

[...]

> +Robustness
> +----------
> +
> +The only way to try to keep an application working after a reset is if it
> +complies with the robustness aspects of the graphical API that it is using.

"The only way to try to keep a graphical API context working after a device reset [...]"

If a graphical API context stops working properly, it doesn't necessarily mean that the application as a whole stops working.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

