Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCF575B61F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjGTSHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGTSHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:07:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A162709;
        Thu, 20 Jul 2023 11:07:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BDBF61BBD;
        Thu, 20 Jul 2023 18:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96276C433C7;
        Thu, 20 Jul 2023 18:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689876429;
        bh=/aeINl97NxHa8zhqW5FMbQyX7KyYwU/y/589H7gNfzU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hzZVjmeCxL5+X0yC5XjHQjafT0z6iaelXUtN1n9hqEjoWNNqkjfG6CVofTV1tFUAF
         9p1XcCVo7OJet3cfRkkanu5SVgzZBZ6JAqTBMXPUPUvXdVuJOxzioy2/MruWlavkMk
         3kn7Sjcrj+cIStQuiPkG4c13brszYEGSFlrpR4GEc+qns3NErw2h686goEZXjoMsEe
         7XcdkgUSnLG4l3tBBZhpEw6o58Axu+VvhvF++E9iZ2SKpvIxcFcb88QB+0jgcbi9bn
         JCfbDetbUjEMjXhNIfPl/jwVC8xs3pv6I1RPnr6aSsZiCBftrILFPwRDjuEVGmKZmm
         Si6BPx4uuptew==
Message-ID: <be0893d1082bba7c3c8c499f9eedbfa5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230720083304.28881-1-quic_devipriy@quicinc.com>
References: <20230720083304.28881-1-quic_devipriy@quicinc.com>
Subject: Re: [PATCH] clk: qcom: clk-rcg2: Fix wrong RCG clock rate for high parent frequencies
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_saahtoma@quicinc.com
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
Date:   Thu, 20 Jul 2023 11:07:07 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Devi Priya (2023-07-20 01:33:04)
> If the parent clock rate is greater than unsigned long max/2 then
> integer overflow happens when calculating the clock rate on 32-bit system=
s.
> As RCG2 uses half integer dividers, the clock rate is first being
> multiplied by 2 which will overflow the unsigned long max value. So, use
> unsigned long long for rate computations to avoid overflow.
>=20
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---

Any Fixes tag?
