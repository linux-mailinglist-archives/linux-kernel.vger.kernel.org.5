Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F117FA6BB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjK0Qqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjK0Qqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:46:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1942198
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:46:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3125C433C8;
        Mon, 27 Nov 2023 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701103600;
        bh=mLe0gFKTqc2ujYOMWLzEWOwtQZ7yEtsKOX/Y3ZtEMag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wwin34v/rl5inaqew20VFCHFgxSa6Qt9c8J8qo0GJjHmEnoW5QaxK4lVbkHvWbcgz
         fu8MIvmt8oWoJDDn6vj0EmPXWzL3JiN3lxC1i3Ny98TsmLDOSRFujU3ArdsZcL9z2d
         jDYWBRglHz+hqXxgdXEAljEbc3M3GpYGSO02/sw08F1Pu/URQ699q3Z3PRa+p4U+J6
         JIk8OliHVqMQ/NxgKNLxBGv2cRXM4Cj1sru2SYGXPR05xu8ZMKPzMJAgZ3/9XZGfJA
         DEPLk8ONqHa3OZo4aFMU7ZgPipPEZOfNynOjDQE6iQnoZcwAcTkYDXvE5pG3cQkRuw
         WDEhCsYD+mTjA==
Date:   Mon, 27 Nov 2023 08:46:39 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v2 0/2] Add MHI Endpoint network driver
Message-ID: <20231127084639.6be47207@kernel.org>
In-Reply-To: <20231127060439.GA2505@thinkpad>
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
        <20230607094922.43106896@kernel.org>
        <20230607171153.GA109456@thinkpad>
        <20230607104350.03a51711@kernel.org>
        <20230608123720.GC5672@thinkpad>
        <20231117070602.GA10361@thinkpad>
        <20231117162638.7cdb3e7d@kernel.org>
        <20231127060439.GA2505@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 11:34:39 +0530 Manivannan Sadhasivam wrote:
> I think you made up your mind that this driver is exposing the network interface
> to the firmware on the device. I ought to clearify that the device running this
> driver doesn't necessarily be a modem but a PCIe endpoint instance that uses the
> netdev exposed by this driver to share data connectivity with another device.

Doesn't matter how many legit use cases you can come up with.
Using netdev as a device comm channel is something I am
fundamentally opposed to.

> This concept is not new and being supported by other protocols such as Virtio
> etc...

Yes. Use virtio, please.
