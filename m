Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149C4752FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjGNDKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjGNDKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF4C2D79;
        Thu, 13 Jul 2023 20:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C077D61BCE;
        Fri, 14 Jul 2023 03:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8144FC433C7;
        Fri, 14 Jul 2023 03:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689304214;
        bh=5BiAHoQrMXVFGK2y88m1p5rxNFrlfm6togR8WBdiPzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5Z8F0bojb30ftX4eYrtpztZ+E+Q8wDW6CuUkAzohButY0tqtfYyHXJlJnU+LviD/
         5ppTtiBGE4a/IlzAAejSr1l0hFNhpbdaTC2+EZKecpmHoo6WdEqVRxypxIMSe80KWx
         7EXZ1taUSLG+ElAxfvWgMXGV2G8rRwnobiobNEN/nofrq3WUN7cu2VTAdyJS2nnwuw
         ozZ+ln8wMoKPvhM+mLntb6lj1c6e3abuY/8Evj3+yNfIXp/lLW6eRyP8B6p/v9IvZE
         KNITN8ei36/Z2YSVZ9VLwrk3lS5bJMRH4QTPvTADkyOE2U7NSlUk7lynrncuUrFHQB
         I3OzJ+KTmOq6A==
Date:   Thu, 13 Jul 2023 20:13:44 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 08/18] soc: qcom: Move power-domain drivers to the
 genpd dir
Message-ID: <dapyfjkwlrdyybshbidrpuotz7eqsj27mr6z6rx7qekbps34lh@5swfpbhpzgf6>
References: <20230711142124.751652-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711142124.751652-1-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 04:21:24PM +0200, Ulf Hansson wrote:
> To simplify with maintenance let's move the qcom power-domain drivers to
> the new genpd directory. Going forward, patches are intended to be managed
> through a separate git tree, according to MAINTAINERS.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: <linux-arm-msm@vger.kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
