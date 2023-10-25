Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46687D6B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbjJYM0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjJYM0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:26:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98215C1;
        Wed, 25 Oct 2023 05:26:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3611AC433C8;
        Wed, 25 Oct 2023 12:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698236776;
        bh=cHUrccN7fXiRcS7yUlCSEnQli9FvN2GxQnGR+MMlk0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBxMFi5IsvHNJCRE7uT3jxIgh7tHwPqhCVKKMkprmCadTtQn/Y4mEAB899H2sMsyW
         6FN51RHaR1chZR0mBRKFomGQl6XcTEDwAD7Ap+MnSO8GQ7ZIzEV6oRAoly7KYOuXO4
         kkb2mMNcHkv7muHwjWdrZMXF/TpJ+iQL0ZVbjGOdKzYlz7F7ANRQbbj10/PmW2tQlu
         BrmRvpq8JBATmhnwzBKa60FSicSy8xdrlESvCvzr8ae7fLQ5MwfSE6PXIgyibqFfgq
         EVwgsK+XUrKpGPt/zfdp4JbUjW8FZiuwRiYjxSy+Uq6b0kzG4p5Pg2QUvLFCzyULJ2
         tyVV4YKYsJM+A==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvcy4-0006F7-15;
        Wed, 25 Oct 2023 14:26:36 +0200
Date:   Wed, 25 Oct 2023 14:26:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] wifi: ath11k: fix temperature event locking
Message-ID: <ZTkJfGhCRpy9ESth@hovoldconsulting.com>
References: <20231019153115.26401-1-johan+linaro@kernel.org>
 <20231019153115.26401-2-johan+linaro@kernel.org>
 <87sf60xgs8.fsf@kernel.org>
 <ZTfUswqVkAgJvnye@hovoldconsulting.com>
 <87bkcnxc6p.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkcnxc6p.fsf@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 12:51:10PM +0300, Kalle Valo wrote:
> Johan Hovold <johan@kernel.org> writes:

> > I hit this on the Lenovo Thinkpad X13s and I guess the tag should be:
> >
> > Tested-on: QCNFA765 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> From ath11k point of view QCNFA765 is WCN6855 so I used this one:
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> > Note that I've only been able to test the ath11k fixes (not the
> > corresponding ath12k) and I only tested this particular patch fully
> 
> Thanks, I added Tested-on to this patch 1 and for the rest I added
> "compile tested only".

Thanks for fixing that, I'll try to remember the Tested-on tag next
time.

Johan
