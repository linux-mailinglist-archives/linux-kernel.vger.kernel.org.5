Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C0476E0FD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjHCHMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjHCHMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:12:08 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A47A194
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Tm4Es6YpMOQ78FtrpipmSk0OqxRLHuMuywdKtTR77cI=;
  b=GF/Wq+NethTGNSL17sHAGhTLFZQeq6Eleh5ShSDjd0nBbIhDiRYPfE8T
   ouCjF1zBSuLy34jj4l/4FetHpUXfDPkDiWdjSy6ywWucFkGe4pHAIxOGZ
   quCtSlvO4+bwYM6inU8oo2nnE58U+Qk4F0sQATepkQVhoTClktFJWnpTt
   4=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,251,1684792800"; 
   d="scan'208";a="62906655"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 09:08:56 +0200
Date:   Thu, 3 Aug 2023 09:08:55 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Wu Yunchuan <yunchuan@nfschina.com>
cc:     kvalo@kernel.org, yuancan@huawei.com, simon.horman@corigine.com,
        marex@denx.de, peter@n8pjl.ca, johannes.berg@intel.com,
        alexander@wetzel-home.de, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next 0/9] wifi: rsi: Remove some unnecessary
 conversions
In-Reply-To: <20230803070042.3654049-1-yunchuan@nfschina.com>
Message-ID: <alpine.DEB.2.22.394.2308030908020.3083@hadrien>
References: <20230803070042.3654049-1-yunchuan@nfschina.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Aug 2023, Wu Yunchuan wrote:

> remove unnecessary (void*) conversions and other unnecessary
> conversons in the directory drivers/net/wireless/rsi.
>
> Wu Yunchuan (9):
>   wifi: rsi: Remove unnecessary (void*) conversions
>   wifi: rsi: Remove unnecessary (void*) conversions
>   wifi: rsi: Remove unnecessary conversions
>   wifi: rsi: Remove unnecessary conversions
>   wifi: rsi: Remove unnecessary (void*) conversions
>   wifi: rsi: Remove unnecessary (void*) conversions
>   wifi: rsi: Remove unnecessary (void*) conversions
>   wifi: rsi: Remove unnecessary (void*) conversions
>   wifi: rsi: Remove unnecessary (void*) conversions

Shouldn't these have unique subject lines?

julia

>
>  drivers/net/wireless/rsi/rsi_91x_coex.c     | 11 +++---
>  drivers/net/wireless/rsi/rsi_91x_debugfs.c  |  3 +-
>  drivers/net/wireless/rsi/rsi_91x_hal.c      |  2 +-
>  drivers/net/wireless/rsi/rsi_91x_mac80211.c |  4 +--
>  drivers/net/wireless/rsi/rsi_91x_main.c     |  4 +--
>  drivers/net/wireless/rsi/rsi_91x_sdio.c     | 39 ++++++++-------------
>  drivers/net/wireless/rsi/rsi_91x_sdio_ops.c | 15 +++-----
>  drivers/net/wireless/rsi/rsi_91x_usb.c      | 20 +++++------
>  drivers/net/wireless/rsi/rsi_91x_usb_ops.c  |  2 +-
>  9 files changed, 40 insertions(+), 60 deletions(-)
>
> --
> 2.30.2
>
>
