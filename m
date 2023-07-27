Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778FC765A22
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjG0RYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjG0RYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:24:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6EA2D61
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C91F261EFC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4AEC433C8;
        Thu, 27 Jul 2023 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690478687;
        bh=ryxsR8SBS+G5AVKwE0hfRQyvd4EgvaTNE1yKn7kQPcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nojFAarC7yC5j7QpgHvVKIFjO+UFj6QQQM0vOEERP8ONkhHslzJPbSZdwvmQGLbEL
         9TBJZqo2C5BYMvsJ78BXLXN9nsv9Au8vj3NplUC9PdbshDapMhmr2XXZ8rOFPcn3Y3
         WjVmXmw8ZvalWzjmBtIaI+QfJCtOK1vIJeDb74iE=
Date:   Thu, 27 Jul 2023 19:24:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvmem: imx-ocotp: fix value check in
 imx_ocotp_probe()
Message-ID: <2023072719-immobile-favored-3767@gregkh>
References: <20230727170414.18737-1-ruc_gongyuanjun@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727170414.18737-1-ruc_gongyuanjun@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 01:04:14AM +0800, Yuanjun Gong wrote:
> in imx_ocotp_probe(), check the return value of clk_prepare_enable()
> and return the error code if clk_prepare_enable() returns an
> unexpected value.
> 
> Fixes: c33c585f1b3a ("nvmem: imx-ocotp: reset error status on probe")
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>

Why isn't this also properly tagged to go to the stable kernel releases?

I need to write a bot to catch these things...

thanks,

greg k-h
