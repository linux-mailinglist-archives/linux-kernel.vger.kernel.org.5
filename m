Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC65E7515A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjGMA4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjGMA4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECE826A5;
        Wed, 12 Jul 2023 17:56:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C5C4619E4;
        Thu, 13 Jul 2023 00:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C64C433C7;
        Thu, 13 Jul 2023 00:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689209727;
        bh=aCZYR0LmWlN9sSkfeilkskDKIFbQhyEmAW03O19rxUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HLwIxN8OXFRBK4hp+EoG/9vNXZB3hWed4N4JKygh/9+moV6+qt7eSuxxlJsMty/G6
         B8r0sJpRIAlw5L5cJDpnmHhW41r4kgEeAuaMx+JGZ1XiMGd6fvxEu5+AMVeoEY/dMD
         bMQcLO4I1bnCsA2vsnb3lyp2LAOCoCG1k17AKfz9DpDxftf5XfoLuoOMkKTiq6GGYY
         HRBiBRtUP2AUZKWdVLV8X3K3qMf7zK66M26UQcoBRs0xJwFor7KXSwZxeeOtXc2gx2
         EqE4xnndLBJW5D6Pnp1dCgGc1RSJPiaBUd6slocfFuyQj5E72Dwxk+B5+81wo1Esa8
         kkY7P9wT+efOA==
Date:   Wed, 12 Jul 2023 17:55:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     amitkarwar@gmail.com, ganapathi017@gmail.com,
        sharvari.harisangam@nxp.com, huxinming820@gmail.com
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, kvalo@kernel.org,
        dkiran@marvell.com, patila@marvell.com, bzhao@marvell.com,
        linville@tuxdriver.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mwifiex: Add check for skb_copy
Message-ID: <20230712175526.55709bfd@kernel.org>
In-Reply-To: <20230707095121.10453-1-jiasheng@iscas.ac.cn>
References: <20230707095121.10453-1-jiasheng@iscas.ac.cn>
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

On Fri,  7 Jul 2023 17:51:21 +0800 Jiasheng Jiang wrote:
> Add check for the return value of skb_copy in order to avoid NULL pointer
> dereference.
> 
> Fixes: 838e4f449297 ("mwifiex: improve uAP RX handling")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Amitkumar, Ganapathi, Sharvari, Xinming please review.
