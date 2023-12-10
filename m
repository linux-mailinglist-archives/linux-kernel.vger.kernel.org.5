Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E6080BE24
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 00:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjLJXVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 18:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJXVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 18:21:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759D1EB
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:21:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D189C433C9;
        Sun, 10 Dec 2023 23:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702250473;
        bh=g0Kbp/5XgQ6d460QwkD98MGAnWFUj5029aJTPRWIMlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a0CF8kSlK21LdgR4jMk5K3WjXb/ww+SXaQDTTADhd8fl1zs3QsEtCPABkRyMJfthk
         6SItBWwoA+OHwPjzK+EHNp4PnqnnGBzTpysawN7mjFtPy58BCD4gIw9eFn/9HjEW1N
         r+mpIde0LcLhcYnOFpmJy2VdHyo0I1BnED/4Pg11l+FkfsCSkFZ8TBCwD3I5p/9MJC
         vkzyaYUpp4jGkiYjuNr0shqX5C8PJO6oiXERC5l2TwRejWFid+ZqKLmBjS0izcvTSq
         SEFLttcYqRvxbT7v2FjdaQjQCss7xlROPEIbrysmGs5468RGrmQh+LRZ3E3uBnKv00
         tttTZ+8FwwTKA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable UFS
Date:   Sun, 10 Dec 2023 15:25:36 -0800
Message-ID: <170225073881.1947106.2789378693379094414.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231002-fp5-ufs-v2-1-e2d7de522134@fairphone.com>
References: <20231002-fp5-ufs-v2-1-e2d7de522134@fairphone.com>
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


On Mon, 02 Oct 2023 14:30:41 +0200, Luca Weiss wrote:
> Enable the UFS phy and controller so that we can access the internal
> storage of the phone.
> 
> At the same time we need to bump the minimum voltage used for UFS VCC,
> otherwise it doesn't initialize properly. The 2.952V is taken from the
> vcc-voltage-level property downstream.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable UFS
      commit: cad7c46ae2d75b42aa8f1e3f741b203ed796eee9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
