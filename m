Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC43791219
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351935AbjIDH2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348936AbjIDH2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:28:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C6411A;
        Mon,  4 Sep 2023 00:28:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D50CB80DB4;
        Mon,  4 Sep 2023 07:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485B6C433C9;
        Mon,  4 Sep 2023 07:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693812487;
        bh=vv1R6EaW7tEtWylwxWVKrsPq//31aiakhEZ4nF2yOtk=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=OdVJ9D5h85L1MPnu9JSDK/8+2EPO4I3Z4kY1PMpn+97l/phlhuCh0rRgGQpbrU7S+
         M4jES4FVTInTA2aWcZaO9EI5Cg2d2IUIow+IiL5B86wc0GM0NHIG8J2tRLiLGDvGON
         M0jTxEjwM3tOvltgYidXVTdOhZH7larSXjaunRSL1V+dG05XysCG1zVj7nvUJzMRbX
         uB+49/FrEhNisMhQVcXuENb2+yMolNGv/TyNDpmJKG6YOH2axEgxmPp9qM1TPAAiM0
         +bhFRLomg7rWRNsmB72OuHE1+vhxK5qWd17AbHEgy9AlW2Jt/jEtJOrzOrb76HVKYb
         BNecyVrO3XtBA==
Message-ID: <45638a5a3ccc08a7f55036d15b75b7c3.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:28:04 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 07/15] drm/tegra: Call drm_atomic_helper_shutdown()
 at shutdown time
In-Reply-To: <20230901164111.RFT.7.Ifb4450979b62976fd5a98847dade2e5b377d47c8@changeid>
References: <20230901164111.RFT.7.Ifb4450979b62976fd5a98847dade2e5b377d47c8@changeid>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        mperttunen@nvidia.com, thierry.reding@gmail.com,
        "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 16:41:18 -0700, Douglas Anderson wrote:
> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
