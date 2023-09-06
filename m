Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD5D794534
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244813AbjIFVir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244223AbjIFVip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:38:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF381BC7;
        Wed,  6 Sep 2023 14:38:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2701C433C7;
        Wed,  6 Sep 2023 21:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694036320;
        bh=aDQGJDCMtGaOqhnrLofefzZQbrTsD2xBYhu/GStXyWY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=j68qJLZvc3KZScwndStpdSteTY9TCR4fsPCiaBsl9MkpSJHOnX1xvidYQ5ISacnZb
         4VfPyaapvizkroFty7yLbi/KbX2rn5HJsYK1dAFcNwbsXiEDm7uinkR5jTHaZn4qLs
         TG9rMrI42d0+pH0XlWDaLT3a3rtrm9OFGuHJw/kTX0MaEIdzBt5fPx4DeReOKmvjqY
         6MUffV8ViAhiVTqfcu3YvL2yKlAwMuJfSB+U3QMFHec7ZruVUwteYwCY/5LBmk3Ez/
         LxgvtIg73oKlTnzVGP7tzpOMcaFJYx7g1X35z0rjvqRrH6VPoWC+VwMapqql6s7E97
         SfKHOUTyDMlDg==
Message-ID: <a72a5774dc94ec0fda8766fe278a3c15.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230826125308.462328-6-cristian.marussi@arm.com>
References: <20230826125308.462328-1-cristian.marussi@arm.com> <20230826125308.462328-6-cristian.marussi@arm.com>
Subject: Re: [PATCH v2 5/6] clk: scmi: Add support for .is_enabled clk_ops
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@foss.st.com, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 06 Sep 2023 14:38:37 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cristian Marussi (2023-08-26 05:53:07)
> Add support for .is_enabled atomic clk_ops using the related SCMI Clock
> operation in atomic mode, if available.
>=20
> Note that the .is_enabled callback will be supported by this SCMI Clock
> driver only if the configured underlying SCMI transport does support atom=
ic
> operations.
>=20
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
