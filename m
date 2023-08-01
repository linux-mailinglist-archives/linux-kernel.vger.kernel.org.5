Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEDE76B055
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjHAKGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjHAKGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:06:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F9DBE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ABE961505
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D42C433C8;
        Tue,  1 Aug 2023 10:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690884371;
        bh=q4WMkjTaZT940k8v/3UokpHQEL5OOBvQGiMemA8FEks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=srFyPeIpWbFw81W51LGBRhTrfwfFVdrDW4ErDSObjj1u3MwvKP/aRucJQKqz9i/3z
         EoxUyyHIPf8rfbkDlZetklatXWufSIKR2VfnmJrBA7ZZV6SA57oi0hPeuMjzq6+T3S
         LCsM0HqxqCnWW04EtzEULH+xuc3W6LNP6T79g+Ak7UStuvxlP/VdCso5PUu9xoFA/V
         +4R/h1B0+o+LGv5l8gIZw1O5Xu58IIpVTJrHWcJVG6iZHPNtO/z2+TNtJc7PTutVQ5
         o/o1fQSQTATnf+82xNWNU9oICKBHVyIOc6JkL1lJhKxuN0GVrpJRa1TZ+tBRRQaBNv
         YLsWn7tNktHag==
Date:   Tue, 1 Aug 2023 12:06:07 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     madalin.bucur@nxp.com, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, sean.anderson@seco.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH net-next] net: Remove duplicated include in mac.c
Message-ID: <ZMjZD9Ce5dSTI5Et@kernel.org>
References: <20230801005041.74111-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801005041.74111-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 08:50:41AM +0800, Yang Li wrote:
> ./drivers/net/ethernet/freescale/fman/mac.c: linux/of_platform.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6039
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Looking at git history, I think that a slightly better prefix would be
'net: fman: '.

	Subject: [PATCH net-next] net: fman: ...

But other than that, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
