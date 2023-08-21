Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47573782ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjHUNlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbjHUNlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:41:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E9CBC;
        Mon, 21 Aug 2023 06:41:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BF7F628DD;
        Mon, 21 Aug 2023 13:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAD5C433C8;
        Mon, 21 Aug 2023 13:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625302;
        bh=llcWAky7/0VeprxT0Gji6lhNX28k6inu87hMNuVO7Io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Duz3brgrVzq4Vc6da+rOIyvYRJ1x75AftCzmwv78iF9MHPOLns2FMDB4HXTukcU2B
         Zbf2PxWHwY6HICh3fpEwoqwjkaszpW54cmiowxSGycXiXYg6/V5YBsE89dirNdAPMC
         Yc9Syn4U2GnCGAVji9KR7Dg+AG6QZQnAPuYbSeIxHmMw6HEVxFX8Iw/RDAG8Ry++xW
         vSSo7MPPiOwM2LLtjhPwnr1u1KCvlcM7SZQA34yoOy8ZDZIKL4bmrJjZMp/MXR6wVS
         WjOpZ/uISHH+HZnb2ZUxu6kL1+pSRiC5Rpg54JKIs8ZjXtCsYhs17w09SuJ6WpbyiG
         AWyZB7dEsnHBQ==
Received: from johan by theta with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qY5A1-0000xg-2T;
        Mon, 21 Aug 2023 15:41:37 +0200
Date:   Mon, 21 Aug 2023 15:41:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "Revert "wifi: ath11k: Enable threaded NAPI""
Message-ID: <ZONpkVU1ORHj-zFH@hovoldconsulting.com>
References: <20230809073432.4193-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809073432.4193-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalle,

On Wed, Aug 09, 2023 at 09:34:32AM +0200, Johan Hovold wrote:

> Disabling threaded NAPI caused a severe regression in 6.5-rc5 by making
> the X13s completely unusable (e.g. no keyboard input, I've seen an RCU
> splat once).
> 
> I'm supposed to be on holiday this week, but thanks to the rain I gave
> rc5 a try and ran into this.
> 
> I've added Bjorn, Mani and Konrad on CC who may be able to help with
> debugging this further if needed while I'm out-of-office.

Back from my holiday now, and this regression is still there with
6.5-rc7.

Any chance we can get the offending commit reverted before 6.5 is
released? 

I'll take a closer look at this meanwhile.

Johan
