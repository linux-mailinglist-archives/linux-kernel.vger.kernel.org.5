Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B8A76E233
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjHCH4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjHCHzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:55:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188769027;
        Thu,  3 Aug 2023 00:44:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CC6161C43;
        Thu,  3 Aug 2023 07:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7231C433C7;
        Thu,  3 Aug 2023 07:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691048617;
        bh=/hgr6mMOKbSw+U1Z3SAu/2Ni0oaFk+vRP0GrI/mnCGY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RzDxoy1xbUQ6qxh2d5jDbrTjIbwbwuEC84Ni1nJDXAQh3xOz62VLby5/OTrRMYm1e
         qJ5v7xhDvsAEErt8pLcP+yMos1ACUM+R3FdF529onpTDiuaWcre3Rl4ymD7RbOe/H3
         PQmeh9ZkVX9ac42gfVEXFDFz7jk84JPFXun32+UaK3/vz827p2R59iwfdTX3SlbROj
         +3+ggvRIgMdHGrs6mrfwq3af26iZNVUHcCRaFfjudZLuI70WSawlZNYGVXGO2fx8xe
         OsjzeZGvH1HFQVcnb5crjFWODY6jOYkR3Jv+z18wUshp1bXK96eAbXwI0pGPWvPckN
         rZhKS4WGdoBfw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wu Yunchuan <yunchuan@nfschina.com>
Cc:     simon.horman@corigine.com, yuancan@huawei.com, marex@denx.de,
        peter@n8pjl.ca, johannes.berg@intel.com, alexander@wetzel-home.de,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/9] wifi: rsi: Remove some unnecessary
 conversions
References: <20230803073417.3666063-1-yunchuan@nfschina.com>
Date:   Thu, 03 Aug 2023 10:43:32 +0300
In-Reply-To: <20230803073417.3666063-1-yunchuan@nfschina.com> (Wu Yunchuan's
        message of "Thu, 3 Aug 2023 15:34:17 +0800")
Message-ID: <87zg38tvtn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Yunchuan <yunchuan@nfschina.com> writes:

> remove unnecessary (void*) conversions and other unnecessary
> conversons in the directory drivers/net/wireless/rsi. 
>
> changes from v2 to v1:
>  - modify subject lines
>
> Wu Yunchuan (9):
>   wifi: rsi: rsi_91x_coex: Remove unnecessary (void*) conversions
>   wifi: rsi: rsi_91x_debugfs: Remove unnecessary (void*) conversions
>   wifi: rsi: rsi_91x_hal: Remove unnecessary conversions
>   wifi: rsi: rsi_91x_mac80211: Remove unnecessary conversions
>   wifi: rsi: rsi_91x_main: Remove unnecessary (void*) conversions
>   wifi: rsi: rsi_91x_sdio: Remove unnecessary (void*) conversions
>   wifi: rsi: rsi_91x_sdio_ops: Remove unnecessary (void*) conversions
>   wifi: rsi: rsi_91x_usb: Remove unnecessary (void*) conversions
>   wifi: rsi: rsi_91x_usb_ops: Remove unnecessary (void*) conversions
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

These patches go to wireless-next, not net-next. No need to resend
because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
