Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D87B7CF8B6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345516AbjJSM1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbjJSM1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:27:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA9B121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:27:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67101C433C8;
        Thu, 19 Oct 2023 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697718464;
        bh=6pLtasYutjsQq5OHpq4USMERf4M+2OpzADP2WRftPh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNsTLVhE1DiIT6iCpLU2mPTrlzxXXXgtBTRQP0L7NT0GtwPwo5O7WH9heGe5EDkqc
         0G4zqWNDK4j4tYb5y5BWSgiIm36j2sGOUDSaoHE74Yk8SahZoGuEZySMsorGVLO5bG
         kvLZhP8c0bK41Io+r/mHQwsfyDWR1MouHiRp/gPgSHH4cJ2lPrdp2vWT7K8GpFLLsc
         ZbwcTt6gFL5Y1rFW/IqzugorVTlbxnNJn+l3XiEKQ4bxISw9F6/bOKI0rXRWvWhhJq
         kNkJdIuEv+sTLdD6P3UeJJVahYJS0y3AZx0ffiBfavr+V4TXvRUl1goN/Cr8wahjtY
         3RuyAvXpnu9QQ==
Date:   Thu, 19 Oct 2023 14:27:40 +0200
From:   Simon Horman <horms@kernel.org>
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Coiby Xu <coiby.xu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH v2 1/2] staging: qlge: Fix coding style in qlge.h
Message-ID: <20231019122740.GG2100445@kernel.org>
References: <cover.1697657604.git.nandhakumar.singaram@gmail.com>
 <cec5ab120f3c110a4699757c8b364f4be1575ad7.1697657604.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cec5ab120f3c110a4699757c8b364f4be1575ad7.1697657604.git.nandhakumar.singaram@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:46:00PM -0700, Nandha Kumar Singaram wrote:
> Replace all occurrnces of (1<<x) by BIT(x) to get rid of checkpatch.pl
> "CHECK" output "Prefer using the BIT macro"
> 
> Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>

Thanks Nandha,

these changes look good to me.
But I would like to ask if not updating
Q_LEN_V and LEN_V is intentional.
