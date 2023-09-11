Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459A579AE4E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355057AbjIKV4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244435AbjIKUbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:31:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC17BFB;
        Mon, 11 Sep 2023 13:31:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78406C433C9;
        Mon, 11 Sep 2023 20:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694464289;
        bh=377+1V6Tv6JYTAiugUCOFQVdbsCc62iMLppW1xTy8D4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kdLmXHAo+Wg9ksR2yKwxupnfv6klUME4sKSV64I15MtgZ0QilfsPqa87YIAmAypB9
         T7eNtVWqIgwv1f6oLbhn2cSKf9GDCK6LZ18bfnoV6ASNlkDij9iTtsmz/TXI1hkky4
         EJEHL2Tasmzl43KnEnPrA1wjb+QmgZTR1W67I49B8ZkcSPhg+eXcN31png0+wett0v
         w6Y+2RsimXVSOL71iHzDxWyNlMZudKGrvo5R4LSppjatPaaRsMIk4TyXX7lasHtdbb
         a5aBrJFadJ4Rt/sYoh2cOjPkL+FpRLOCpgb7iBYP0k+/B2G2fUg8lNGF28IUdWmxuw
         8jHTZYN1i+L2Q==
Message-ID: <6c6c6564b92a838ecb4325ecd9f768c4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230824092624.20020-1-zhifeng.tang@unisoc.com>
References: <20230824092624.20020-1-zhifeng.tang@unisoc.com>
Subject: Re: [PATCH V2] clk: sprd: Fix thm_parents incorrect configuration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhifeng Tang <zhifeng.tang23@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Zhifeng Tang <zhifeng.tang@unisoc.com>
Date:   Mon, 11 Sep 2023 13:31:27 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zhifeng Tang (2023-08-24 02:26:24)
> The thm*_clk have two clock sources 32k and 250k,excluding 32m.
>=20
> Fixes: af3bd36573e3 ("clk: sprd: Add clocks support for UMS512")
> Signed-off-by: Zhifeng Tang <zhifeng.tang@unisoc.com>
> Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---

Applied to clk-fixes
