Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D3D754CC0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 00:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjGOWKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 18:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjGOWK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 18:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6A52D63;
        Sat, 15 Jul 2023 15:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7F8C60C57;
        Sat, 15 Jul 2023 22:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1143C433CA;
        Sat, 15 Jul 2023 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689459022;
        bh=aU0mKUutTIFMQ6L/V+iIykyDAx15QoMOui4F4M943gI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrcPLFtdSLLq0Af0tNIqVkPE1EqOV0DxCD1O4sOZ5x6Rt+YN41oXdv/Cd3jL6vXZS
         JytRcpjGWPz5eenGbqk7wlgSYw6qAG5Vjz+LNPZTJlqYPOerMpo6sLL7UlszQwFBUF
         gp1fHH1ibEez6s3SRH8mYWT+k39hNKWykuVsdJkeW77A/lK/vY/204df8mG8I8+x5X
         W4NRP6wkMWdUzDQz3bzcRLXdjwGC2k4ic0bjXN/sOsKtLov3mr6SQM3rJH0dNly7z0
         rVXg5SoDj0/XJi1GneF3/kBgH7BO9TBYy8xj7njGK//DEeiBEz4nabuqTVlbB8O89L
         TCR4YEMUM0Uyg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: q6v5: use devm_platform_ioremap_resource_byname()
Date:   Sat, 15 Jul 2023 15:13:37 -0700
Message-ID: <168945921473.1805013.4055192239650829730.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <202303221115145068959@zte.com.cn>
References: <202303221115145068959@zte.com.cn>
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


On Wed, 22 Mar 2023 11:15:14 +0800, ye.xingchen@zte.com.cn wrote:
> Convert platform_get_resource_byname(),devm_ioremap_resource() to a single
> call to devm_platform_ioremap_resource_byname(), as this is exactly what
> this function does.
> 
> 

Applied, thanks!

[1/1] remoteproc: qcom: q6v5: use devm_platform_ioremap_resource_byname()
      commit: 5b2b675adf8f302f89ad2624bc4ad2327b669ec2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
