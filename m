Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A77C7912D3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347316AbjIDH7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbjIDH7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:59:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E5FE58
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4426ACE0E12
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9765C433C7;
        Mon,  4 Sep 2023 07:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693814337;
        bh=wshyRHP09R8yIfKuZEEfRI3UmWKQ5VuTL5f4lHcN7xs=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=JIacjII79U2oHT6JEn5aP51LQjnGqqVrh2n6Y0A1PUpKsNQOoH/8sjAunOtu82Ksz
         2G4dA0ZjeHxiK/ie3Tn3l6zKafdB6yiOcbg399T/4UcQFTGsbkDBn9bCgCTdPYWRRc
         G/NWixIYMPCSplvDrwDin9lsV0sir/m7IF0Vd01cb8mvuF3QoxeZrmJ+j+jp38ynhK
         2Ib9PyYeOZLYKZJlkVUoN/+9E9ejfUm5yClAVhRUVC3+i5Jh4Ia/kTk7/dJJ+aSmpj
         chpSxgkCLQSh4U7twO9w6mkvzbKVFbYo7oQvhVGgBKxyZ0s807x76ZkciglyDZrWon
         r/zP86uF/Z+Ng==
Message-ID: <84acd2a9724fd45a5dff355b3b699b49.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:58:54 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 3/6] drm/vc4: Call drm_atomic_helper_shutdown() at
 shutdown time
In-Reply-To: <20230901163944.RFT.3.I10dbe099fb1059d304ba847d19fc45054f7ffe9f@changeid>
References: <20230901163944.RFT.3.I10dbe099fb1059d304ba847d19fc45054f7ffe9f@changeid>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, emma@anholt.net,
        linux-kernel@vger.kernel.org, "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 16:39:54 -0700, Douglas Anderson wrote:
> Based on grepping through the source code these drivers appear to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
