Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A397FA0D2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjK0NWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjK0NWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:22:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618EDAA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:22:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEC7C433C7;
        Mon, 27 Nov 2023 13:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701091330;
        bh=VMQtEdCOVaS38Wu6iEj4lCJRQZ4TyTyCmYz+FNCaYOs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YC2PyYm4dkKVLgr7iY+QbR57yyY3WkKWh05Vumr0W2xzgOAPDikIYQys0hoceviqD
         V0PhTMls3rZLnalsDFEvc1EGbtwf5HKhf9lXXdei/NdCNV5IgZFfXwLBqmG6V3YsRG
         MCXEOPht9SodhovpMQqve5pJHcTis1f/Jtz/qPF8chRQaMZIwLebhj0bBD5RHFqqKI
         XDNRylIZvGV9XbfhpywsssvCGyPyAJY8F60aHK3eaL0FTeT8sS41WVUPnt7zOPTpN8
         n0sam5Q1P6Sss6B00aa9gKFBOgc1r7zp7PJtK3URzHyETTk7fHQC60DKpPNzIG09Lf
         8KC63klPATSbw==
From:   Vinod Koul <vkoul@kernel.org>
To:     vincent.sunplus@gmail.com, kishon@kernel.org,
        Su Hui <suhui@nfschina.com>
Cc:     linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20231120091046.163781-1-suhui@nfschina.com>
References: <20231120091046.163781-1-suhui@nfschina.com>
Subject: Re: [PATCH] phy: sunplus: return negative error code in
 sp_usb_phy_probe
Message-Id: <170109132717.42536.11844523525705275991.b4-ty@kernel.org>
Date:   Mon, 27 Nov 2023 18:52:07 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Nov 2023 17:10:47 +0800, Su Hui wrote:
> devm_phy_create() return negative error code, 'ret' should be
> 'PTR_ERR(phy)' rather than '-PTR_ERR(phy)'.
> 
> 

Applied, thanks!

[1/1] phy: sunplus: return negative error code in sp_usb_phy_probe
      commit: 2a9c713825b3127ece11984abf973672c9779518

Best regards,
-- 
~Vinod


