Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D408278FEDF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349959AbjIAOTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349950AbjIAOTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:19:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE1A10F8;
        Fri,  1 Sep 2023 07:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 51A74CE201A;
        Fri,  1 Sep 2023 14:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E5DC433CA;
        Fri,  1 Sep 2023 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693577973;
        bh=JAauFWIxKYvceN+T1u/1aK8XkdIL/hConDHTAsdEqd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OSa7PA16/mnS00v9z+cjDXi2IRRhf2kc6p7h43OvPbwarST4BivFQHwtJYING4//Q
         odSlT6rbcM4dt0SDTSvPrK9MMx5tdtM2v9hC/VJQfJbHXldq9GrVcoCInq1u6Oau7q
         cudZhpsQ8c2RVp0m2DTAo3CeeKDXgLPZPF2Uf+G2+5s83vOTMt+bO7Zr6wJ9HBiAQS
         iouyY2qxi04OJ3guY6MGO0FpJy9g4I+PjLJXNVkG66pf5bYfEfyxbEMxonfQWMHoIh
         X8htAA+OzSpRbV8fOCC6g4m4hBylwtRL34SMycZG1j61QgTkleWBYNkErlcXR6gG7p
         oZnusXnemJpSQ==
Date:   Fri, 1 Sep 2023 16:19:05 +0200
From:   Simon Horman <horms@kernel.org>
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     mani@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        quic_viswanat@quicinc.com
Subject: Re: [PATCH net-next 0/2] net: qrtr: Few qrtr fixes
Message-ID: <20230901141905.GJ140739@kernel.org>
References: <1693563621-1920-1-git-send-email-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693563621-1920-1-git-send-email-quic_srichara@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 03:50:19PM +0530, Sricharan Ramabadhran wrote:
> Patch #1 fixes a race condition between qrtr driver and ns opening and
> sending data to a control port.
> 
> Patch #2 address the issue with legacy targets sending the SSR
> notifications using DEL_PROC control message.

Hi Sricharan,

if these are fixes then they should be targeted at 'net' rather than
'net-next', and consideration should be given to supplying Fixes tags.

If these are not fixes, then please don't describe them as such.
In this case targeting net-next is correct, but it is currently closed,
as per the form letter below.

In either case please consider:

* Arranging local variables for new Networking code in
  reverse xmas tree order - longest line to shortest

* Avoiding introducing new Sparse warnings


## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer
