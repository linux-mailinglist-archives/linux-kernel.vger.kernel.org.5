Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0F676DC86
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjHCAUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjHCAUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:20:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD3BE4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 414A961A6A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726DFC433C7;
        Thu,  3 Aug 2023 00:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691022000;
        bh=sZptYRYDFoHAb+wOsSizNCW/jt+/ft7PFZewKheT524=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rYZh2Ou5eiiksaJ0lkp7mNnqK/3Vw3Dw5erd0OqvNvnhXHUAejIjuL7ZtxgMylygM
         uNVn9tZ3XjAfglxx4DqZgZQuUvpQbpZ3CyC0OsVCQa+TsapDwQr2qoG8czG7YwXgzi
         QH4AnUtu0m29L7ibQliudSn1aPbOqKm9oqODFVWPS/Rr0EkGHamcgudwlJ0eUmD9vi
         UUY4JQTAk1AyA9tQ4zneX/WRwWkSDonb+eXT1geqlUescolNTMmh8ETndow1MvXqYC
         6SpbsvnqTRnYMG91iVfqCyS5RpNEQwRLoJT42Afo1LLHBbNgKA5EWgQYqSWxBKEmqi
         EI5zL15FKhrOQ==
Date:   Thu, 3 Aug 2023 08:19:57 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Rob Barnes <robbarnes@google.com>
Cc:     patchwork-bot+chrome-platform@kernel.org, bleung@chromium.org,
        groeck@chromium.org, dtor@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Sync filesystem on EC panic
Message-ID: <ZMryrehtCouCCngA@google.com>
References: <20230726181738.1.Ic6b8e25120b2aec95e3d0f4ac92c2a35fc7a40e8@changeid>
 <169079822136.24246.16960757983645261559.git-patchwork-notify@kernel.org>
 <CA+Dqm30s282gcs6PHkZkH92mhndLi5YP=NPwS0duorizJfx+oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Dqm30s282gcs6PHkZkH92mhndLi5YP=NPwS0duorizJfx+oQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 12:16:35PM -0600, Rob Barnes wrote:
> Note: This change is being rejected upstream due to the use of
> ksys_sync_helper. Apparently it's discouraged. I sent a new patch to
> replace this one:
> https://lore.kernel.org/lkml/20230802175847.1.Ie9fc53b6a1f4c6661c5376286a50e0cf51b3e961@changeid/

Do you have any links about the rejection?
