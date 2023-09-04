Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A183C7912DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352441AbjIDIBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346896AbjIDIBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:01:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ECE19B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 359F5CE0E3E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8251C433C8;
        Mon,  4 Sep 2023 08:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693814450;
        bh=E2sdQ3VRZz3ffzE37I9XdXa3InB+72fEKo9Caj92rks=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=lGHu3MaezN0uZe/YAn6VmTf1ABx7OeJls8Nu8zSTwlu3Zzn1YrT66LrpsAWedGpW2
         OKaZ1acUSVGs0eY9FRdXM1s3KoO9EVLwh1X7X+7yQBogV5WBUfZSbuyv0EXBtmlEO9
         fdHXndrxwKMGtvNfcQTXZhfRBdNNuF6wrich4VRqL2JAfPikHeEdenZS3RIJD+/3cp
         fW4hypAu9WRGGk2C0f3xIt5FuDHbpA9ZDOSL+oVu+c5imKXlv5GNskX6b6Chv1fj4U
         klRzu6aJuEdXQwhwlwZESGiB73G52SGhOXjav+KN6HNv4K1Ih3yxnHh651WhpcfhyL
         s2XQDdJcA8Jww==
Message-ID: <fa6a0d6500369b831ce0329a2fe43571.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 08:00:47 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 6/6] drm/hisilicon/kirin: Call
 drm_atomic_helper_shutdown() at shutdown/unbind time
In-Reply-To: <20230901163944.RFT.6.I21e0916bbd276033f7d31979c0da171458dedd4d@changeid>
References: <20230901163944.RFT.6.I21e0916bbd276033f7d31979c0da171458dedd4d@changeid>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, javierm@redhat.com,
        jstultz@google.com, kong.kongxinwei@hisilicon.com,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        steven.price@arm.com, sumit.semwal@linaro.org,
        tiantao6@hisilicon.com, tzimmermann@suse.de,
        u.kleine-koenig@pengutronix.de, xinliang.liu@linaro.org,
        yongqin.liu@linaro.org, "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 16:39:57 -0700, Douglas Anderson wrote:
> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown time
> and at driver unbind time. Among other things, this means that if a
> panel is in use that it won't be cleanly powered off at system
> shutdown time.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
