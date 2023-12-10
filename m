Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC7180BA54
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjLJLSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 06:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJLSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 06:18:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBE6CE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 03:18:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FD7C433C9;
        Sun, 10 Dec 2023 11:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702207107;
        bh=Mw5kA6PMe+ZvyKQlipStk5punFjg+9Pr9d05A2L1hbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q76oVVW2iIehrIoEA8eEUlj4ummxe3MSsPsc1RnGJGzbjkLTCA2+LkOjVd6rIKS+a
         t5Shq2mZJisdNP24G1xOmOzqHNEqLxZIE4qxCgIczs/4bKZL8iK1OPqPdzuk5BgQvt
         N0zUEvy3kgn3ULpvf8JbbakhYocahqZoNVpaaoVGBdKKYHXMwJJb8R5U5QcEl14mYo
         zwhIqjNnN9XyNLS021RboG0NHHkBBQZe8acGheiLFMkRX4ublkaXEFFvOKRs5riUaP
         x+R+NS2vZqOlUvEgqCIosMUIGKiZ+4W77mhY9CPi1C9e6xQ4y13kBKJqySCctGwngb
         NUF5DV6D00qPA==
Date:   Sun, 10 Dec 2023 11:18:20 +0000
From:   Simon Horman <horms@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, egallen@redhat.com,
        mschmidt@redhat.com, pabeni@redhat.com, kuba@kernel.org,
        davem@davemloft.net, wizhao@redhat.com, konguyen@redhat.com,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Subject: Re: [PATCH net v3] octeon_ep: explicitly test for firmware ready
 value
Message-ID: <20231210111820.GE5817@kernel.org>
References: <20231208055646.2602363-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055646.2602363-1-srasheed@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:56:46PM -0800, Shinas Rasheed wrote:
> The firmware ready value is 1, and get firmware ready status
> function should explicitly test for that value. The firmware
> ready value read will be 2 after driver load, and on unbind
> till firmware rewrites the firmware ready back to 0, the value
> seen by driver will be 2, which should be regarded as not ready.
> 
> Fixes: 10c073e40469 ("octeon_ep: defer probe if firmware not ready")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>
