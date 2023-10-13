Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D496B7C88AC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjJMP3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjJMP3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:29:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B035BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:29:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBD3C433C8;
        Fri, 13 Oct 2023 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697210949;
        bh=YtIXXuRf4Lngx6rJrU6npwrdprczxA5ErBSuQkN9z/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FtZ7HgeJ9AIA+lJcUXvlNAilfyLw0+TojW7zslHmLBOiYRL99jhyvQz9RQU4Dx6KG
         4ZShTnAHwZerbiynGbpOsk1uEn5HT3owuo6/RFZsx537AA64nShjMzAxrR57HH9j6u
         llnVYcmavGWTVnT/lTVfr5yDpXvuZXqi911TOn6nUxksuKCPAVLFt+Co5GyLj+VFq4
         5IElbJA/RYZeKFdyiQt6K+5kJ/2j1vDioJtefwzyWn0Xqpzh33ILKaDV2q3u+aoYkQ
         adiHOmvh5tBMWdHgpg8L+AfRpKwFWPxz8erfmtbzZFFTWylh7J5T1kHI5vlxqKTg1x
         VYalMBe4XyT3w==
Date:   Fri, 13 Oct 2023 17:29:04 +0200
From:   Simon Horman <horms@kernel.org>
To:     Sai Krishna <saikrishnag@marvell.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com,
        gakula@marvell.com, richardcochran@gmail.com, lcherian@marvell.com,
        jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com
Subject: Re: [net-next PATCH] octeontx2-af: Enable hardware timestamping for
 VFs
Message-ID: <20231013152904.GM29570@kernel.org>
References: <20231011121551.1205211-1-saikrishnag@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011121551.1205211-1-saikrishnag@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 05:45:51PM +0530, Sai Krishna wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> Currently for VFs, mailbox returns ENODEV error when hardware timestamping
> enable is requested. This patch fixes this issue. Modified this patch to
> return EPERM error for the PF/VFs which are not attached to CGX/RPM.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>

Thanks for addressing my review of v1.

Reviewed-by: Simon Horman <horms@kernel.org>
