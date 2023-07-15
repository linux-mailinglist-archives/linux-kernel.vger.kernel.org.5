Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B815754BF5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 22:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjGOURd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 16:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGOURb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 16:17:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BFA271E;
        Sat, 15 Jul 2023 13:17:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D31B60BA6;
        Sat, 15 Jul 2023 20:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E038C433C7;
        Sat, 15 Jul 2023 20:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689452249;
        bh=HPC1CiCJ3hA7X46XwWU5N8E/GTBSejDzt/BzCWJXaZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+olWtykaoG5qNyT5SNceQKSe3jyuZz6Wl9Y5qvNqF9B8Fg5luagTU2zjmLmIC+mj
         RnEhc1pfsVk1w6XscLqMmw5H1BxuUbWlDuuDbe4rM4XhjBJNC6sjPWhwgfDTyvCW/0
         4EhatFs4mpzaGoZMRmHpLpMVdIqLOOPJPlw6mrG2lLww7x6+FwtfIaFFRFxOzHx37E
         nLgTiavvyQi+bWb+o1fBp5r1/AGjrEzmeDR/Fg/irCgNm2Lqw8X/1HQCXkBW3WIpuh
         V2Dk55CWz3IICbU3RMhXOArdbW6AP0+7UXeXgzyrnVaIfXHFtPeFhiGqAp7yOP0VXS
         GH3lb8ps98N0w==
Date:   Sat, 15 Jul 2023 13:20:56 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Vignesh Viswanathan <quic_viswanat@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        quic_srichara@quicinc.com, quic_varada@quicinc.com,
        quic_kathirav@quicinc.com, quic_devipriy@quicinc.com,
        quic_sjaganat@quicinc.com
Subject: Re: [PATCH] remoteproc: qcom: Add NOTIFY_FATAL event type to SSR
 subdevice
Message-ID: <egnmb647g7x7e74j4g2jddwho23ulmbap2q4eimcyj7y4qvdlz@zmaydxodu2a6>
References: <20230503062146.3891-1-quic_viswanat@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503062146.3891-1-quic_viswanat@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 11:51:46AM +0530, Vignesh Viswanathan wrote:
> Currently the SSR subdevice notifies the client driver on crash of the
> rproc from the recovery workqueue using the BEFORE_SHUTDOWN event.
> However the client driver might be interested to know that the device
> has crashed immediately to pause any further transactions with the
> rproc. This calls for an event to be sent to the driver in the IRQ
> context as soon as the rproc crashes.
> 

Please make your argumentation more concrete, I can only guess what
client driver you're referring to.

You can do this either by spelling out which actual problem you're
solving, or better yet, include some patches in the series that actually
uses this interface.

Regards,
Bjorn
