Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B1076A50E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjGaXtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjGaXtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F8710C7;
        Mon, 31 Jul 2023 16:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D57A61342;
        Mon, 31 Jul 2023 23:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B84C433CC;
        Mon, 31 Jul 2023 23:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690847383;
        bh=ix4fwezJZKpOygoVgwB37pKoX9KQblLLs8L6ubd3u8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMuRuq9pT6XeAnwau1oAKmmNyUJDfng2nEtAl6Ojxwx0R4+6zNGUuLFaTqiH1mkBf
         dgUgJ9OG3yqcJSRxWpipBBH3jrqQ/0zyMOSOW+biYlcv9pSTjqE2+gKvDyQVXBqlfH
         tK0BXFLK91r0IT2eoBdSYz+kXzH2LL+UwyEIgePqTuQgv4rS4mhDhrTCiTZtjTBuGf
         EfZkN5GFNIbdu3aiu0tOgyH+GTONdrfPu2FiGwTeLq03Dy6fysM8FncOhPQdM9M6UK
         fhTdMKc1a971J2eqczpvphUydmq2euEWgrTwXaS+PPQ6hN19ipFtXjgVokTgdD6YEE
         GPhzKeQR6reEA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 0/2] Add SC8280XP videocc
Date:   Mon, 31 Jul 2023 16:52:41 -0700
Message-ID: <169084756378.3010488.2068262180256497590.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703-topic-8280_videocc-v2-0-c88269806269@linaro.org>
References: <20230703-topic-8280_videocc-v2-0-c88269806269@linaro.org>
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


On Mon, 31 Jul 2023 21:21:31 +0200, Konrad Dybcio wrote:
> SC8280XP largely reuses the SM8350 VIDEO_CC block. Add the missing pieces
> to make it work in preparation for adding venus support.
> 
> 

Applied, thanks!

[1/2] dt-bindings: clock: qcom,sm8350-videocc: Add SC8280XP
      commit: dfe488d99da728a1cea58ef7a4a5d97b89eb0413
[2/2] clk: qcom: videocc-sm8350: Add SC8280XP support
      commit: e5e527d1ed02fec0310d1e1574557781360e4418

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
