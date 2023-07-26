Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6695762B31
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjGZGOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjGZGOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:14:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722B3C0;
        Tue, 25 Jul 2023 23:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0269C611CA;
        Wed, 26 Jul 2023 06:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A91C433C7;
        Wed, 26 Jul 2023 06:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690352071;
        bh=dFBiRUa1PUFx/bkBA2j6cE/Og15W429JYSgQYgBCddE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hbxq4eQuOLhDrPYAicRMhxkcpz74LBA/dMpk8NYZSzu5QypEGf4O+75AOm5vX7gwc
         sanlY5BOigAC69//EOmcQ7tXfYVwHoZp9KDMh5/tLZg09VoF3E4nguSa309a+Yn97g
         MzX7c6fl4bvi49lFA+amMV8WD/3R79vI9DYCOphGk+NC6vFV1OaQiVtcLL3PrOcLKh
         tyM64mH3JrDv43yI0Amjw6CE0QXpK7pUFbaUBCAAdR/yYm8VH7ql0TYpXtcI8irA7s
         H0qNsqlU4muX+4gP5ZF4zdYCAlGGZiG87c/eC4ETWLbCG6gKM+vUK8TT4yusxTe+sV
         5zPP/RrLN9FIQ==
Date:   Tue, 25 Jul 2023 23:17:44 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support
Message-ID: <jnyn2wppuvn3b3tgssavuoyihbgr6mmmlz5ddsj3rhbrchk5ig@5qbuu22tw22t>
References: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
 <20230724083849.8277-3-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724083849.8277-3-quic_kbajaj@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 02:08:49PM +0530, Komal Bajaj wrote:
> For some of the Qualcomm SoC's, it is possible that
> some of the fuse regions or entire qfprom region is
> protected from non-secure access. In such situations,
> Linux will have to use secure calls to read the region.
> With that motivation, add secure qfprom driver.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
