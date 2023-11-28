Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDF67FB672
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjK1J6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjK1J6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:58:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5282CDD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:58:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C22C433C8;
        Tue, 28 Nov 2023 09:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701165522;
        bh=5ArrUEd+VDRb8Mp2oGnmeMS9uZXS+0nOcVm4HzoTmAE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=m6C5rTA2jAjEF8afeKlTB6aBB9Y5ULymK2S/fsN64B3SFI91nsJ6ePILQZqYd9eSY
         mAweO/BFcgEkt6UqPYBX19PmJ9vxOQxLdfXLtsFMAX8HtzdA6prob5zH4W3nN2oyUF
         32SQbTFqlZMIog6XdU2X9+hJzfbcM+E01OpMIjjqnDBcn5qRsN9q97q+AmZByEioxm
         a+SpdW2IGa9U3m/Vrgdm++h0wKzuNkN8e6SCsicjYGJivIlw1fa0eZzxG16nM+r52N
         T0oPjRqtiodzRpUZi2YQKOPcCvydBjMfi4neVq8Fo62ly1aHxVRJ33yKgYalYvsw0w
         Gt2MLo5g/4Brw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Shreyas NC <shreyas.nc@intel.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     stable@vger.kernel.org
In-Reply-To: <20231124180136.390621-1-krzysztof.kozlowski@linaro.org>
References: <20231124180136.390621-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] soundwire: stream: fix NULL pointer dereference for
 multi_link
Message-Id: <170116551879.73476.11576514501948917974.b4-ty@kernel.org>
Date:   Tue, 28 Nov 2023 15:28:38 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Nov 2023 19:01:36 +0100, Krzysztof Kozlowski wrote:
> If bus is marked as multi_link, but number of masters in the stream is
> not higher than bus->hw_sync_min_links (bus->multi_link && m_rt_count >=
> bus->hw_sync_min_links), bank switching should not happen.  The first
> part of do_bank_switch() code properly takes these conditions into
> account, but second part (sdw_ml_sync_bank_switch()) relies purely on
> bus->multi_link property.  This is not balanced and leads to NULL
> pointer dereference:
> 
> [...]

Applied, thanks!

[1/1] soundwire: stream: fix NULL pointer dereference for multi_link
      commit: e199bf52ffda8f98f129728d57244a9cd9ad5623

Best regards,
-- 
~Vinod


