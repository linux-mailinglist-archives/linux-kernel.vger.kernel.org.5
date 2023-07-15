Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBEA754CC1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 00:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjGOWKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 18:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjGOWK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 18:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641B630C6;
        Sat, 15 Jul 2023 15:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95ECC60C4C;
        Sat, 15 Jul 2023 22:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEC9C433B9;
        Sat, 15 Jul 2023 22:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689459023;
        bh=e8FHqBjC7t4K+fiSbVZQ4Dc9mTf6Nj9RB265+pVGF7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T4l4cvDp505PkOMr5GnUU+m3u8e2Ku234P9Sg488FyO0Z22BORkPNJyNnAyc48oy5
         resIQFMIj31kxTM87QzrV0Kp7Ted548MtWnEoGRwQ4LSzF4zK3CL/XDcY3QhtWYL0Z
         IkVbHzv3TBEyrscnDbZlestlLr+axxjkXRJo/X/RVIs3Bn0Dm6woJhKkPkl77P705f
         HcCtv70qPG+Mf75SzVx5H6woWKdJKX/J3XpJpO2Sm/rkpi1hXBV3PGmvpVezlfesCe
         L+45HiclweJ2+I5kS+h7E6GBQBrBEHVnBPf97ToL/aaVFmPm2Qx6bDgs/bAczT6/sr
         fNxoBjftQFhaA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: wcnss: use devm_platform_ioremap_resource_byname()
Date:   Sat, 15 Jul 2023 15:13:38 -0700
Message-ID: <168945921473.1805013.9798519389753165257.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <202303221116427329010@zte.com.cn>
References: <202303221116427329010@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Mar 2023 11:16:42 +0800, ye.xingchen@zte.com.cn wrote:
> Convert platform_get_resource_byname(),devm_ioremap_resource() to a single
> call to devm_platform_ioremap_resource_byname(), as this is exactly what
> this function does.
> 
> 

Applied, thanks!

[1/1] remoteproc: qcom: wcnss: use devm_platform_ioremap_resource_byname()
      commit: 92d24d0927bc4399cbb6bca9d7c410cd849c6a1d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
