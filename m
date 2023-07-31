Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE97768EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjGaHei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjGaHeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:34:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440151BCF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 504E260F32
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001D6C433C7;
        Mon, 31 Jul 2023 07:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690788785;
        bh=ZwKZS0bLTyf8mihvJXFDGn7ylNI9iRCV2TKg/Z6yhBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KshohDWOy8x6NeVf+J0o2gYUY2KTWH51sQsBsaMOGiZGxk/H8AGKJOVECpOo8U8Op
         vzdZJzD9DDSaA/NjU3Z38TlY0J6MaTcXPVWFwLiPZVTh9frdRURiI4wPtK+w/nYzLT
         mrqKgtHxNk5PHOOl3k7zH8X3halVF3G+2bEdWn49yk9BLraw4Et2wGERf4vdueWuin
         pp7K9/L8miD5uhC8z1CqfyCnJUiOr2ikQjsCjK60S0kKQlm9liDQi8Bl+CvBWdRAAY
         6B2k2z5ZkHL/RsCNfVtcjtfrNC3kkLsVCfNZybg1ryOBoPecnjhp/viRhQFDrC4qUY
         fSBPpKIE/eckA==
Date:   Mon, 31 Jul 2023 09:33:01 +0200
From:   Simon Horman <horms@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: bcmgenet: Remove TX ring full logging
Message-ID: <ZMdjrXBiyfixTGRn@kernel.org>
References: <20230728183945.760531-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728183945.760531-1-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 11:39:45AM -0700, Florian Fainelli wrote:
> There is no need to spam the kernel log with such an indication, remove
> this message.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


