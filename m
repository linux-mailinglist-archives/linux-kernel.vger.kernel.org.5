Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E7476B2A0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjHALFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjHALEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:04:51 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9E63C0D;
        Tue,  1 Aug 2023 03:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690887528; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=riU0iAR+POSddJyJ9VTQav1aJPUMIqjF/LwpFKhsXnkZFMjkTbSixJitrSll6mOVS6
    4DnF51L/zvuOnJSfdh8bbeCbL0/4uAb+jlC8WrsJtV5n5KvZ55r1x5+KGAxqjemEkiwT
    LjEX77OBAEYTRAKme6EkPFoeL121yagphgulZIwgK8uL9SlQz3q90rSXFl5kgZwEzAyR
    PZ//TixDbYIF2yS1BPb8Y71VKzZOu6HsVpArr6t2V15ZHacMHlC7kWWRYdpEQi3IY+3y
    jjzNB1P0+Wu1bsxHtK+XyrIQ4MB78xNCCoTwibrcxzVDgg2nlhcnQLYg0QhnjX2qH86H
    uQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690887528;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DHbOBvCZgYYvNTOE8eCfcIFSVNt2pXB9oMJnvEr1yMQ=;
    b=XrkLabBs7byytSRo7gsNP//omSSbGGic7O+WVTyxbJpX4+ykYdiSGB5oQSjxKlf5Bh
    uaJDEDBpOT4NA4gMLvKWo8JIoz5TQNjYUtFYTZScqRgzBR91khpifLeGC0LZn9eJAa3K
    0cBC3QAuJp/YVSXDFiuOshYUZiqMKAPfie+yPIMEJU9/ec0KOYBf3PsLV6gJi4uBtf2t
    CPc7Fi3G3QDI9RVCw4p1KqRtd0r2pBfxLi8UHZxdtGwHKB/0LHjCSyAnj/5UWtxn6nGw
    qf82zoQejHksBJGU3IvHqvuEbc7IOjqVyRTGfFUv2akqhd4dujhqDWY6OqdMjQmkzp1g
    1wbA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690887528;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DHbOBvCZgYYvNTOE8eCfcIFSVNt2pXB9oMJnvEr1yMQ=;
    b=dn1Ej/kf59bpcPHppSQZRMNxuxNvI19hG54oYMhot/dlzhhcBF2Y4x1PC+QCkb68Hi
    3FxE6VSdJIpgNnJcHrQ+Y3LzxMV+e7+NS6WM424cs0v7ylX3u9I8CCfyZD49Hsm7yxRK
    s6D9h0bra0G8+jig20BRns9gb5zxmFaldCoLeovy/SgRAtYc87epbN+XHtKeltZb92Ga
    JhBtmzy3GzyKIuQZk9j3GhhqGdizDNOIhxht/OzuJ9clrZrDdZJ/g9GXid32QO5ZVzGg
    z77CTx93s7ZZo1t4+bI7ZzJRb06cwGwiEDLGaWtezRwIjutY0OPvzV1RdJ7mtVK0Ym6q
    Pflg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690887528;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DHbOBvCZgYYvNTOE8eCfcIFSVNt2pXB9oMJnvEr1yMQ=;
    b=m38koJhuqGI76tLhYWjbcwJHCFjyjcjgsErBVIfGl9+Hh7CmCS15i7wiYeW+/kf4gR
    /Ceun0nyDo9kQ1aX19CA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8p+L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z71AwmNkR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 1 Aug 2023 12:58:48 +0200 (CEST)
Date:   Tue, 1 Aug 2023 12:58:47 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 03/10] interconnect: qcom: icc-rpm: Let nodes drive
 their own bus clock
Message-ID: <ZMjlZyFcB9IFEG60@gerhold.net>
References: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
 <20230726-topic-icc_coeff-v2-3-8c91c6c76076@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726-topic-icc_coeff-v2-3-8c91c6c76076@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 12:52:19PM +0200, Konrad Dybcio wrote:
> If this hardware couldn't get messier, some nodes are supposed to drive
> their own bus clock.. Presumably to connect to some intermediate
> interface between the node itself and the bus it's (supposed to be)
> connected to.
> 
> Expand the node struct with the necessary data and hook up the
> allocations & calculations.
> 
> To save on memory (not very many nodes have their own clocks), allocate
> a pointer to an array instead of allocating an array within
> qcom_icc_node.
> 

Only on ARM32 though. On ARM64 you waste extra memory:

u32 bus_clk_rate[QCOM_SMD_RPM_STATE_NUM];
sizeof(bus_clk_rate) = QCOM_SMD_RPM_STATE_NUM * sizeof(bus_clk_rate[0])
                     = 2 * 4
                     = 8

u32 *bus_clk_rate;
sizeof(bus_clk_rate) = sizeof(ptr)
                     = 8 (for ARM64)
                       + 2 * 4 + malloc overhead
                         for each node with bus_clk_desc

which is > 8 from above.

I'm not quite convinced this optimization is worth it.

Thanks,
Stephan
