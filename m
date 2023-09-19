Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80477A6F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjISXEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjISXEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:04:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D577A197;
        Tue, 19 Sep 2023 16:03:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEB7C433CD;
        Tue, 19 Sep 2023 23:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695164634;
        bh=br79oaeny2FbS6lhsSZYJBCqMgnlgLd0kKtmMUQENsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=geFHmtDXb/2iEh2e73YYvFaFvNmjuYHhyCqQGE9bAqhvCWsK0OPNVF1ZCV8x1aXJI
         9Xt6IKxjFNhY/0py+c+QBTbcFp4FszspWZleOiQZ6CNQmslMXDFd2EUMFAFqVOMrFu
         +TbcVc2h1bW/gLNG7yRj5PJVG2wR2bsD+Z2w4KnqnxQ2aDLPP74YYfMQ0Hna4z3GqN
         1+VsEwMdqOJjw096LJYUFzt1Vq5/6ARbLHtjiKm26xTW7bsGkQPdamkcRAa3jOSqUa
         ZuV9z2PAgfxDchODG5wzHMe/95KG1o8qYa1ThgjVkQI8Qk+UOoK66xLcmg5SVAKV9n
         J89gGpYsfjtuQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] firmware: qcom: qseecom: Add missing AUXILIARY_BUS dependency
Date:   Tue, 19 Sep 2023 16:07:42 -0700
Message-ID: <169516485975.787935.2205696566865441276.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230915-qseecom-auxiliary-fix-v1-1-38a46cfbfdb0@quicinc.com>
References: <20230915-qseecom-auxiliary-fix-v1-1-38a46cfbfdb0@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Sep 2023 15:50:14 -0700, Bjorn Andersson wrote:
> The newly introduced QSEECOM driver fail to link if the system is built
> without CONFIG_AUXILIARY_BUS, make sure it is selected.
> 
> 

Applied, thanks!

[1/1] firmware: qcom: qseecom: Add missing AUXILIARY_BUS dependency
      commit: d74612b6da61aeb32e81bcf762b8be4e3c41bda5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
