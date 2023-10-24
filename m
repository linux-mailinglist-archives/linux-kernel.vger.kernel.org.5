Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA3B7D45D4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjJXDQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjJXDQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:16:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDDB10C2;
        Mon, 23 Oct 2023 20:16:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D32C433C8;
        Tue, 24 Oct 2023 03:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698117378;
        bh=p1hhuvIPakueBhPkMTsnJZD7jEV0fRvqzqRBD6XqoAY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SE3dOp5CnQIijBCv2/Tuk2N4/tJy1tJRKwkt4QY2fAckQY3nvjFfuOk/rWdfS2hsa
         4hYgfVdHEpLBPAL18XB/epo72m//06issvriq+/QVME8U9xbsJIlgDS2Ox/TNUMYYQ
         OsTJigJIEFNtPRbfYFCJPIu3fPdVGqvF3ghSKKRZZQ28d3pDzWQFipgl1XzEoI+agd
         OF5SGEipUz11F8M4oe/FTq+UHsEqJQzFNHe4edOCzzooKRCzIH9IzTi7TIMv/TBZVy
         5DTp3R/X75YtHc6ds4iQixbF8azq9YERs0H6291L0+7ZfHv0al2AMscD9A8zgCp65R
         QwRjPV6RdN/OA==
Message-ID: <d5fb4c972273c5e18662e5d6914b04fe.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231006213959.334439-1-robh@kernel.org>
References: <20231006213959.334439-1-robh@kernel.org>
Subject: Re: [PATCH] clk: Use device_get_match_data()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        David Lechner <david@lechnology.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Rob Herring <robh@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tero Kristo <kristo@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Date:   Mon, 23 Oct 2023 20:16:16 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2023-10-06 14:39:58)
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
