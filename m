Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15019758914
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 01:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjGRXfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 19:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGRXfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:35:09 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E69DED;
        Tue, 18 Jul 2023 16:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=t4CzHGovSABTgIh64kLj32qzRe4v0lqRdgdSkdo+55A=; b=HSH6uQNRtCcC+SiW5zh6IRJLeo
        5gyXUeST70K3ErK+LEZcy8hyd6ExUvl4oytnMW7RBT7uVoqZz6dac4b526g5g8WggDFmfQji6xQUK
        W7IDcIPXqOlBzg/M3Hbn6/i3QkspCxeZMs4wiOg+JLxLTXbn31DiNxu2zQ63j9ZuLY3o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qLuDT-001fln-6f; Wed, 19 Jul 2023 01:34:51 +0200
Date:   Wed, 19 Jul 2023 01:34:51 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 06/11] net: phy: add error checks in
 mmd_phy_indirect()
Message-ID: <9820dc4b-5fb2-4432-9156-a6ac7e52557a@lunn.ch>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-6-9eb37edf7be0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-feature-c45-over-c22-v3-6-9eb37edf7be0@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 05:07:06PM +0200, Michael Walle wrote:
> Add missing error checks in mmd_phy_indirect(). The error checks need to
> be disabled to retain the current behavior in phy_read_mmd() and
> phy_write_mmd(). Therefore, add a new parameter to enable the error
> checks.
> 
> This is a preparation patch to introduce a new C45-over-C22 access
> method which will make use of the new error checking.
> 
> Regarding the legacy handling, Russell states:
> 
> | The reason for that goes back to commit a59a4d192166 ("phy: add the
> | EEE support and the way to access to the MMD registers.")
> |
> | and to maintain compatibility with that; if we start checking for
> | errors now, we might trigger a kernel regression sadly.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
