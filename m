Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5C2808BFB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443561AbjLGPfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443509AbjLGPfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:35:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0817610F2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:35:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DED9C433C8;
        Thu,  7 Dec 2023 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701963322;
        bh=+zfjQi8iFYxQ1XqThCcwk/c3AH2+riGtH+b0LPOSIzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=skRHYHMDxLiFKOLTrHNOHah/wqB2plWPQGFhUuWNm62TGxdR0hKss9PLzeBikvuvA
         Y7uFRK5sTGBPpeI7roMn3NEnDuiguXMIguuUwOutCMGLjl2RLemzFr+VcIbo02fYG6
         Bl4NirJSbEOGpRVs5MeAPliIN8Y7dc053KgGKq+mNJxWj8kLEbqEXJ/JF+LPlwZycI
         bLctMsaSiRS3n/O6D4rPHDy5qq6/5TsfgJG7UhdTYpD3dTOlYNoS/4YrtmV9eAQpBZ
         udnw6bjtJXvAH/xkCS7JQnGoFgNE5OCiD9vMT46/dfaft3AIKSEIylvXUPhTuXdUNH
         RnjvXjoF3gBRg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rBGQ8-0000rl-2y;
        Thu, 07 Dec 2023 16:36:12 +0100
Date:   Thu, 7 Dec 2023 16:36:12 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: Add missing interrupts for
 qcs404/ipq5332
Message-ID: <ZXHmbCyK35g2_emY@hovoldconsulting.com>
References: <20231204100950.28712-1-quic_kriskura@quicinc.com>
 <20231204100950.28712-7-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204100950.28712-7-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 03:39:50PM +0530, Krishna Kurapati wrote:
> For qcs404 and ipq5332, certain interrupts are missing in DT.
> Add them to ensure they are in accordance to bindings.

Here too you can say something about the remote wakeup functionality
that this potentially enables (at least on ipq5332 with the current
Linux implementation).

Johan
