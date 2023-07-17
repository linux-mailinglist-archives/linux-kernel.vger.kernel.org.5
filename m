Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BFD756912
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGQQ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGQQ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:26:40 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C240A130;
        Mon, 17 Jul 2023 09:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689611196; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QVbDOm9T1/eZemCIbbN7zfSwXDhyCIb+MjF5Ms25zOROvdiX7NvPBzjiTmzD8SUpye
    oV0EiUUOFCmkHekwCU8cX6whNANex5c/RC9llizXcyz2LMs2v9LBvbRk89BSB8+ErBtZ
    OmnSR2MKmGEKK7vL/dh2gmEiUkQ+erOkWcnHc0zwONLggNkvk+MV7oGRdO+3izFnNI9P
    gxD+3iG3wzZ/dzVGW1yqkBFNoSGknJdF+7AIHte/qD7C6yWOlGzYfOcsJwBjuPNTP/no
    Z/nbQsEktQ6K3c2rsWaFCKtUdDY2T4qX1ocvlUcJeHwjWhmo3g9sJLyPmUIbnma5WgXe
    8JlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689611196;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=O98qDLMJ/G7bcyZeLAHWml5uk/qDNSzk4LE86nK2TL0=;
    b=Vu5LVbW8zhKROfWRga4j6zDjwLuGfUBDuU0Q1K8RNXklI5ZXz33/womuZ/mLbNOYf+
    EZlVQhH6vYqEinI9e9S30tQUzH9f5RL+fWeuX2ewwfwFh2Ewlfe52FYL1jRUiaKj198X
    gQ5gDBHmFP/2LyryIFSgkbFeVXLaux2h9OT1dTGK3/LWUsWnML75vLYc8TexQcfx1S5c
    zfZD3IMZwSiMFQ2cg91wC52s7gWi7C6rIdo5xUpMoUZKhIfBzwZdO0GqNIpO/7CDSrXg
    IgEZI9IPfa/V4Wv1RKtHLqJsXyIYmEPu/b5jYfH5k+pRf1qHrv6iY5wQM3UTXltE5q2X
    zR3w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689611196;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=O98qDLMJ/G7bcyZeLAHWml5uk/qDNSzk4LE86nK2TL0=;
    b=kEGro6C7Ic8Yyfxb0cLrAEc28tLl02bxJoK0XE0dQtU63QqW06L6f1aX05NRqn43MM
    loyh5uXE+9vNd1rlS4pcA1Vl7tr7UAmDYjk5IlNGm3McfaDciXxi3g7oocOG/VBF46oU
    D6hYIB/XhMygHdLJXbDe+KV3QZzhyQASswCrpgExXEc6gqSJDUAhgf/cHGP4iHR1rd68
    V68HMOkK+vTYg2HaaHbFjFQXjbIk9PSK7toTPo9nmEtHFEDAW4RYnanmnRCWTUuc+p3G
    wcS/eNzYXQ6A4PrD/esp8wyrK630hpOPPccEGqZHGVO85qzLBxeRDpPp8DsJFZyr2Qx2
    gvkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689611196;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=O98qDLMJ/G7bcyZeLAHWml5uk/qDNSzk4LE86nK2TL0=;
    b=VLxMrAb3DfRFu3tYoygzsdQrZKvmMwtG0ROeSnJ5PD3TUbECIfFgPEmwdBFd0or3jD
    WvbVsJeha/z5/x56fmCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6HGQaZCI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 Jul 2023 18:26:36 +0200 (CEST)
Date:   Mon, 17 Jul 2023 18:26:35 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 04/15] clk: qcom: gcc-sm6375: Add runtime PM
Message-ID: <ZLVru50N2ukdXnsW@gerhold.net>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-4-27784d27a4f4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-topic-branch_aon_cleanup-v1-4-27784d27a4f4@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:19:11PM +0200, Konrad Dybcio wrote:
> The GCC block on SM6375 is powered by the VDD_CX rail. We need to ensure
> that it's enabled to prevent unwanted power collapse.
> 
> Enable runtime PM to keep the power flowing only when necessary.
> 

Are you sure this is necessary? If VDD_CX was really possible to fully
"power collapse" then I would expect that you lose all register
settings. This is not something we want or can even handle for GCC.
You would need to restore all frequency settings, branch bits etc etc.

Otherwise it's a retention state, but these are covered by the
corners/levels, not the enable/disable state.

I think most of these power domains are effectively always-on. The
important part is voting for minimal corners/levels so they can go to
minimal retention state with vlow/vmin.

Thanks,
Stephan
