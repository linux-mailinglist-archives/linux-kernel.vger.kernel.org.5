Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFC0802100
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjLCEx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjLCEwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:52:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1DC1BCC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:52:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED74C433C9;
        Sun,  3 Dec 2023 04:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579122;
        bh=7fwoAq1Nxg2nO9O4kxbtpvBac+C2ltWlwTbj6a6iAZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1LjHFHzpn1B3Hp2+ULu24wF1BmgF+XQmVsbZ8qveUDdkh5uPaSiYz940o+6woWj/
         W2x3yociHVLBao9XmhAsxAhtn3/o2a0JCL/cTNJGgTMg7bmqHSWmCKpCSu3w1CpiDx
         ZTy3a5BFQPT6hEyvzlnsQGTA1951e4BLhIGQweiIqcw16KDHknwVsH4ngOo+RP5sqF
         HU0um2pAuD9n9Mo+pl1TXgfDxKRcgJAi/TmOTZw5H8S+sJYxfFjVqhJ6C00ksUS9ps
         8ptIV2xblKk7KoZVhO6q/TMaCo+Yn9LJFmwFZuuU5k/F0uQXki1fB3pn6YF4Du/SBf
         ZSXVi3gw2+RCA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x-primus: Fix HALL_INT polarity
Date:   Sat,  2 Dec 2023 20:54:48 -0800
Message-ID: <170157925835.1717511.7071965404233684888.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130-sc8180x-primus-lid-polarity-v1-1-da917b59604b@quicinc.com>
References: <20231130-sc8180x-primus-lid-polarity-v1-1-da917b59604b@quicinc.com>
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


On Thu, 30 Nov 2023 16:11:10 -0800, Bjorn Andersson wrote:
> The hall sensor interrupt on the Primus is active low, which means that
> with the current configuration the device attempts to suspend when the
> LID is open.
> 
> Fix the polarity of the HALL_INT GPIO to avoid this.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8180x-primus: Fix HALL_INT polarity
      commit: 1aaa08e8de365cce59203541cafadb5053b1ec1a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
