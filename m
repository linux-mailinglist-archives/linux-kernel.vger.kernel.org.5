Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413F379B207
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357088AbjIKWE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244394AbjIKUUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:20:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7798185;
        Mon, 11 Sep 2023 13:20:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5231EC433C7;
        Mon, 11 Sep 2023 20:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694463628;
        bh=t+7z6sKacC4bNsdeAQDIrInU1BgKBgiThKa36hekUHM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vIA7WWczePJi65XG6iZtGohn8yGNCzh3/cU2eYLsksjybLNOvWmnArQt3wxDYNQS1
         SF5roN/gdpcp9fOyl2dovpcqOthXqzPsJE/+iIqLHcmN4XyeHHr8GvWeIwsIKEnrae
         zDVZtvLR8zSsL1k51qQl34iQpvhUDrtz30Gxb2sMCseAz6scW40t7Eib2PLwdndVhL
         SOVxXWFzz6KclxMRfHZLDnIPvt3FU26jgjckhXOESfWfNVPF8XBVBD+mLX1JiZTyzD
         oF8Jqac4h5svNOooBowUX7LEhi0/AAWpnbKZ7YZ4Uqk2/uWNQif/AEmxemdwOZRSlq
         6XSJyrR/2ArwA==
Message-ID: <a1b8a5bcbddc57cb3c62d3d81fdc4c4a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230909000703.3478902-1-sboyd@kernel.org>
References: <20230909000703.3478902-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: asm9620: Remove 'hw' local variable that isn't checked
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        kernel test robot <lkp@intel.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Mon, 11 Sep 2023 13:20:26 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2023-09-08 17:07:02)
> The 'hw' pointer local variable in this function became unused after
> commit f5290d8e4f0c ("clk: asm9260: use parent index to link the
> reference clock"). Remove it to silence an unused but set variable
> warning.
>=20
>  drivers/clk/clk-asm9260.c:258:17: warning: variable 'hw' set but not use=
d [-Wunused-but-set-variable]
>            struct clk_hw *hw, *pll_hw;
>                           ^
>    1 warning generated.
>=20
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: f5290d8e4f0c ("clk: asm9260: use parent index to link the referenc=
e clock")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309042014.IWERPl09-lkp@i=
ntel.com/
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
