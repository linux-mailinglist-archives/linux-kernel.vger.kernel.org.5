Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7F178E351
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344502AbjH3Xht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbjH3Xhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:37:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B590CBE;
        Wed, 30 Aug 2023 16:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F0ADB81F91;
        Wed, 30 Aug 2023 23:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23539C433C8;
        Wed, 30 Aug 2023 23:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693438663;
        bh=EBBfqRmY3BhAoEpud+z57dT8K7YcXhRn5JQw/MctUbk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nbPufsO091/9+Kc9UOMF1XK5hbnt5nFGRZkob3ldiVh4urTMX28LEOLDZu9s1WUxF
         Nw9xbPclA6wFguBAGZl9638rYfAWBFbiCkqDljCv4+y59cJ0rQRjmLvIYuGd1DEZqO
         nlw5LJw6F86UfPLMH0/N6oxcnHaoPs2VmEMxFpiLBso1zXSGa7LbD0WIfKZ40YtHy2
         uy8OTlztwR4ARvDn9V+SPEq+wfxr/3Ykfwap/Mv0zoTSgrtSGDbjY1tMGwKmlAcAu5
         M9++lCjMpQCGNhAEkamH7IzaliyRYvydQhq5gxh0UtAXK4+t/EP8E/0WwGt1uLzCQh
         wsdQHoTA/5TBg==
Message-ID: <12a65758db2058322898cc505fcb8cf7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1693377310-8540-1-git-send-email-quic_varada@quicinc.com>
References: <1693377310-8540-1-git-send-email-quic_varada@quicinc.com>
Subject: Re: [PATCH] clk: qcom: ipq5332: Drop set rate parent from gpll0 dependent clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
Date:   Wed, 30 Aug 2023 16:37:40 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Varadarajan Narayanan (2023-08-29 23:35:10)
> IPQ5332's GPLL0's nominal/turbo frequency is 800MHz.
> This must not be scaled based on the requirement of
> dependent clocks. Hence remove the CLK_SET_RATE_PARENT
> flag.
>=20
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Any Fixes tag?
