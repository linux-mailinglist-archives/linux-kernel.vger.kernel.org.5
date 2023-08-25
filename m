Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF0B788452
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242332AbjHYKLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbjHYKLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:11:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A29210B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:11:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAA96615BB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5ADC433C8;
        Fri, 25 Aug 2023 10:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692958260;
        bh=YmW35iV9RR6C5qLFh0XMh3A2cKMtU422JhbQaQsDM8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MTpbnqDk888dmnCbR+qIx5JUar6rwhfF59vaybYlzxM6Q7VOxo0j/lYQpjRZvr3JG
         c+2TFzUeZZxfngfVdUNAZcLhw59SmDw/mskR3dPuqDu4OutOdMAQAZAAmhPRSgKafH
         OdP/iQNuG0HTOMssXDeP+YQ9whJkAMfjJOKOlvhWdlloQ6zZ6c6dlCv3oWIiKJ2cFO
         YYepKXKnRGR9n3dUtKxZv50A8m1PJpggpMqh9MQV9siTyR7G0kysrcif6qtgf9Wca8
         J8aofXCmqaZPYdmK7szIWdfww8JP7Xrn20HihIrN1mZgNVTLYoBOmCpIv2SOZ+TBY1
         Rg6J/9Lg8jeoQ==
Date:   Fri, 25 Aug 2023 12:10:53 +0200
From:   Simon Horman <horms@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net PATCH V4 0/3] Fix PFC related issues
Message-ID: <20230825100638.GL3523530@kernel.org>
References: <20230824081032.436432-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824081032.436432-1-sumang@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:40:29PM +0530, Suman Ghosh wrote:
> This patchset fixes multiple PFC related issues related to Octeon.
> 
> Patch #1: octeontx2-pf: Fix PFC TX scheduler free
> 
> Patch #2: octeontx2-af: CN10KB: fix PFC configuration
> 
> Patch #3: octeonxt2-pf: Fix backpressure config for multiple PFC
> priorities to work simultaneously
> 
> Hariprasad Kelam (1):
>   octeontx2-af: CN10KB: fix PFC configuration
> 
> Suman Ghosh (2):
>   octeontx2-pf: Fix PFC TX scheduler free
>   cteonxt2-pf: Fix backpressure config for multiple PFC priorities to
>     work simultaneously

For series,

Reviewed-by: Simon Horman <horms@kernel.org>

