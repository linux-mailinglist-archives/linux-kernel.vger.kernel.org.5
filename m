Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DC07662C1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjG1EGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjG1EFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:05:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82A030DB;
        Thu, 27 Jul 2023 21:05:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D73761FB7;
        Fri, 28 Jul 2023 04:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2187FC433C9;
        Fri, 28 Jul 2023 04:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690517149;
        bh=oWiRj1R1cpMLs9Tunx3fjwiwA74RNcshBVqp0I0kAH4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=r4SrajcEvt++opH73mtEvJyNAL9vo5aoUK/if5clj1TlxYKasp/Uq4hwC3VPAEb4V
         ERlpnfX01z47aiW0fPWyGUU+PVY3o14Pgd9Fq0+o2uVhQZbZiSDzi0eU6bb/YNkw9g
         qMxu35GHnj0jMqvPVirP0QBmWx7U6AktiKom7iRgSkPYrWEKa08g63kc/MTmZILIOI
         rghfNeSzZhJxm7/UPRCXwTHxiZjEhC5dcTCkIXErlb1VGMnlGKwVLEDsxwiSZx95Om
         hv8betxvQcODTd+sPHnehHxii1AFbRe1w7jsTys2MXBOuQA4wXjmy/946zr9twbgFD
         GyKNQUYUc37mQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: Re: (subset) [PATCH 1/2] firmware: qcom_scm: Convert all symbols to EXPORT_SYMBOL_GPL
Date:   Thu, 27 Jul 2023 21:08:54 -0700
Message-ID: <169051733325.1270972.10445201035158192895.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <19d9ac0bf79f957574ef9b3b73246ea0113cc0fd.1690503893.git.quic_gurus@quicinc.com>
References: <19d9ac0bf79f957574ef9b3b73246ea0113cc0fd.1690503893.git.quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Jul 2023 17:42:48 -0700, Guru Das Srinagesh wrote:
> The `qcom_scm` module is GPL v2-licenced and so there is no reason why
> the APIs it exports should not be, too.
> 
> 

Applied, thanks!

[1/2] firmware: qcom_scm: Convert all symbols to EXPORT_SYMBOL_GPL
      commit: 2784e3b0cc028f5f996e7b86ea6fbaf13b5f23d8
[2/2] firmware: qcom_scm: Add missing extern specifier
      commit: d5d9bca2219d78c652d340079945f0f2071e1219

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
