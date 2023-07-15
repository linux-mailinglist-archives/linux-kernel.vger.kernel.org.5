Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408CB754CB3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 00:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGOWKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 18:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjGOWKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 18:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB21272A;
        Sat, 15 Jul 2023 15:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDC6260C4F;
        Sat, 15 Jul 2023 22:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C477C433C9;
        Sat, 15 Jul 2023 22:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689459013;
        bh=R3JLhxp8E7MAdE1jpo2wLjwlc8BVuGmnFZYu8Dd6Fcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ev1bU2GuaesGySv4RbMZu5UfJT1ffWIUvWwWqSJ+SjYMUPBlcEk6hnfpeOqaH+5hF
         /ovlGhiAlPSGEihZkRS2Vkr5UCv0Qg/GngHHn3fO8H2bo+jMbHNXk3I/COa6GRACLk
         hueTZ0cR84XS2EsdNmD/iqzzptzU072O18FwV16hHVDr8yll0fr2auA+iQgvWo4lI2
         ez4fFz0e/OQwpvQ5rCNXULnN9xHf92uH/ZtJXpgCiAsBbg3ouMlSqKnx43ErJg4DTm
         T8sFCqbsVVq+QiBZn2GKllvZUj9pmsTz5If4/I3kP0YlFmfBYCdzZaah6pq0CFfwPV
         HRa5cZd/eV/gg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     marijn.suijten@somainline.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: remoteproc: qcom: sm6115-pas: Add QCM2290
Date:   Sat, 15 Jul 2023 15:13:29 -0700
Message-ID: <168945921472.1805013.7150009491706711250.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230315183231.3562580-1-konrad.dybcio@linaro.org>
References: <20230315183231.3562580-1-konrad.dybcio@linaro.org>
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


On Wed, 15 Mar 2023 19:32:31 +0100, Konrad Dybcio wrote:
> QCM2290 is more or less a fork of the same design that SM6115 is based
> on. As a result, the ADSP and modem found on it are identical.
> 
> Add compatibles for the QCM2290 with SM6115 fallbacks so as not to
> require any driver changes. Change the allOf:if:properties clauses
> to look for the presence of SM6115 compatibles and not an exact match.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: remoteproc: qcom: sm6115-pas: Add QCM2290
      commit: b352033e19c4591df299a8f623508c5c2ce4c5b3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
