Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBD17EE391
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345384AbjKPPAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345362AbjKPPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:00:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E41F1AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:00:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67565C433CB;
        Thu, 16 Nov 2023 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700146815;
        bh=yhaKzC4xxHXc6E+jm/VpLPlXWoQRVF4q21gWBbdXoGQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hm3krBZUbgHv+CA6eFUw5zuEr59VTiYjyeQnPlEEoUNv6/v6FsfOm1V/HxeRK/Riz
         Cf95PF8V5Ukn6d3cq+xdPzXs5Kc3KMikgmQV1pdMtBJgW1q/X9tSV0aXwK9POndwRp
         8A3iHdhHAzHLH5muetLX7WQ568lWCB8iycBaRLVQgtlLQlR2lrcsnS9DaRi63cmHjb
         dO5QCofMZbYb9wIpErXObDmhVG1kkK4dFH0aYIeTR9dkl8V0+g116D+2xHJFGGVN3y
         hQSZqEzvPvLy6BDeozOnDgdQsnloo66emdE6pLuCG4RjNibo3PhXBAKmFW3ma/xRx3
         OUoa4T06rywUg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-phy@lists.infradead.org
In-Reply-To: <d2323636c6cd2ec22f73a0ae6c2d34ac99b4abd5.1698854255.git.christophe.jaillet@wanadoo.fr>
References: <d2323636c6cd2ec22f73a0ae6c2d34ac99b4abd5.1698854255.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] phy: core: Remove usage of the deprecated
 ida_simple_xx() API
Message-Id: <170014681304.545052.17451265867929404624.b4-ty@kernel.org>
Date:   Thu, 16 Nov 2023 20:30:13 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 01 Nov 2023 16:57:57 +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> 

Applied, thanks!

[1/1] phy: core: Remove usage of the deprecated ida_simple_xx() API
      commit: 772dd70a5ed6845d87738f82c788c9ff4e37fd7f

Best regards,
-- 
~Vinod


