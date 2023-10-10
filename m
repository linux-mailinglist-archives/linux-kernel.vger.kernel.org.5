Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1689A7BF0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441874AbjJJCd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441893AbjJJCdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:33:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50038B8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:33:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2E3C433C7;
        Tue, 10 Oct 2023 02:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696905203;
        bh=wEYcgGQVtUTfORpCNvBb2la3+23xg1zdIxa3uz8FPw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTEGWxrtzeaVft2cUpn0DSaTYOm+quKuWCcoElJ+3j2DCvUGimykhc4A9n0Ic0m6M
         oeK6PVYnQvOLPCWgA5P4ssiCik7SY51DO+1ISnRGhGh5oIBpV0bkEYZPm8eLGaiB+1
         M46ZdhTNdiO8K8yEFrwO12MnrCblWEnOTcSbua0sS0QSuEszLLidgsF3dj1eprbeax
         nZ4QURgBYfzlG0zzzABOnSP+wVpI4Rz5xxLLu4CGsSKgV1FgyWwWsQkOrWcq7aBv4s
         47ljqGsf0buCMY5Rn99z0iqdsdoAIo+rjsMMwpq6NapZy+gKjR/MQL8xXPN/Yc8ywS
         olZNh1oxm+Dbw==
Date:   Tue, 10 Oct 2023 10:33:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hao Ge <gehao@kylinos.cn>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, christophe.jaillet@wanadoo.fr, robh@kernel.org,
        treding@nvidia.com, daniel.baluta@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gehao618@163.com
Subject: Re: [PATCH] firmware/imx-dsp: Fix use_after_free in
 imx_dsp_setup_channels()
Message-ID: <20231010023308.GM819755@dragon>
References: <20231008032908.11448-1-gehao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008032908.11448-1-gehao@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 11:29:08AM +0800, Hao Ge wrote:
> dsp_chan->name and chan_name points to same block of memory,
> because dev_err still needs to be used it,so we need free
> it's memory after use to avoid use_after_free.
> 
> Fixes: e527adfb9b7d ("firmware: imx-dsp: Fix an error handling path in imx_dsp_setup_channels()")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Applied, thanks!
