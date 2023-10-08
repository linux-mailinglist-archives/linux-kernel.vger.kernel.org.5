Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956FA7BD0CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 00:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbjJHWS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 18:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHWSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 18:18:24 -0400
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF368A3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M+Il/UbRpv2hwbJYh84vfo4sM0bgLWrVwAVsRhP4+Gg=; b=koC2+ANB36O0hWWF/Tz+r2qSOZ
        MHsU/cfxKI3ApvIuuwI3j02KxfeRos4VQwcdSlGAfcXg5t8eaKY+Rc6QesbVc9da1RUbzSj2CgYjH
        qPdH2I+H+yLxbv3rwIgpMNOh/g5+FYVxLBSQ2hJPUY/x5aSgrVs2YBlFBWOtoiPrnyTwM1+oSegkJ
        QtYanRk62idrwjvC0kl1V/sCnn4RjVc8kRdoVgoQrWLFEfNfSLQClnrzZJuu9posktvDUjcmPRHWZ
        cfMbGT/SK4R7rMSjet/rWfSt9nEKrqt2uDyOPeIiVR6LkfsvCmveicsqTRHgkfxU9k0SeLVsarliJ
        c6bm6V2Q==;
Received: from ip98-183-112-25.ok.ok.cox.net ([98.183.112.25]:41498 helo=[192.168.0.142])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <david@lechnology.com>)
        id 1qpc6L-0005ou-0F;
        Sun, 08 Oct 2023 18:18:19 -0400
Message-ID: <a324b19f-b40c-480b-8a76-1f37c54bc9cc@lechnology.com>
Date:   Sun, 8 Oct 2023 17:18:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: Use device_get_match_data()
To:     Rob Herring <robh@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
References: <20231006213959.334439-1-robh@kernel.org>
Content-Language: en-US
From:   David Lechner <david@lechnology.com>
Autocrypt: addr=david@lechnology.com; keydata=
 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
In-Reply-To: <20231006213959.334439-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/23 4:39 PM, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: David Lechner <david@lechnology.com>


