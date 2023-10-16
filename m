Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23417CB298
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjJPSfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjJPSfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:35:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8489BAC;
        Mon, 16 Oct 2023 11:35:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2574C433C7;
        Mon, 16 Oct 2023 18:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697481332;
        bh=NpIaTvuHw8Le9ChpmPmnRspLxE9CIeioI03Nv4mZ9zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5TuNaew8UyYa92+nB9zmq6FI1jsWRiB0dl5SWe7Ch5b/Hs2KPDJGZCq4PRBB+Oxx
         FXzH2BdJF1dQo0XlIoJ/kjFM/eItqKTy+kHrs7C3z/IbS8GEKlPOacpyhdt6xQf/IR
         /h1vwzAle8iipeF//iwFP04/zzwty7DugLSuLjuObx2unrrWZ4WGLmHgQh2Q9wnsrI
         4wpKP5e7KC3v10kCk6TIJu3/r5Oe67SErZzdoktLOGL4NHY39GDmjwSJfl6pKVxIO8
         gNZDn6PAM+gmyFzDJ24OAOQ++Y2t2xuvyco0lk8LjnWNlLVlOuxLh0jo9Dpqh3x5+y
         EZYOyzN18SVig==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Priyansh Jain <quic_priyjain@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_manafm@quicinc.com, kernel@quicinc.com
Subject: Re: (subset) [PATCH v2 0/2] Enable tsens and thermal for sa8775p SoC
Date:   Mon, 16 Oct 2023 11:39:18 -0700
Message-ID: <169748155481.1250452.18230103775371703582.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926085948.23046-1-quic_priyjain@quicinc.com>
References: <20230926085948.23046-1-quic_priyjain@quicinc.com>
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


On Tue, 26 Sep 2023 14:29:46 +0530, Priyansh Jain wrote:
> Adding compatible string in TSENS dt-bindings, device node
> for TSENS controller and Thermal zone support
> 
> Changes since v3:
> - Correct the unit address of tsens node
> - Updated tsens nodes in sorted order by address
> - Moved thermal zones outside /soc node
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: Enable tsens and thermal for sa8775p SoC
      commit: 4e7870360366b79f8a37ab0809895359105e5b78

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
