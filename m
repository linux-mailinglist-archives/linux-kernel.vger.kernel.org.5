Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28640784B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjHVUW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjHVUW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1E4CE5;
        Tue, 22 Aug 2023 13:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE95B651BE;
        Tue, 22 Aug 2023 20:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBF2C433C7;
        Tue, 22 Aug 2023 20:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692735774;
        bh=VN6UbrzxU3/tiuKAUGglA+ntmPXczUDP6h8hs5I/Jeo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nQ5zC2VwByHevveqEV3GftNQx7bHYHKnmz7qjnv3hOzzEIx69J1KNszwQC5taVoKg
         Fq+PKpEpB9aVZSaz3F7lJhpRN69EBwqEentgGDCzYhlHnzw3I8YPFlITcAmlSw74oa
         6jgNJgAQ3snkI4pBEBWBIvEACo9Peb8BFsyammwIx5DDT2RpEpR2ZtODwd3EJOWJDD
         L38iVqfeIUuFa64XQAXB7yfHyk6eCMLmUpc4JOgLb72QfETl5FIvHnIGnpLAQfbAQ+
         2I2GjJCzdUpQeb0rF5PJMdo0iD32aLnnPVQU6sVnV0B5w3vtVtN0oJ6OkIlCYrhavv
         aXVEnUIRmeWHA==
Message-ID: <98a734c6b1c9d8dc0bbdf976389c8af6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230811161446.636253-6-cristian.marussi@arm.com>
References: <20230811161446.636253-1-cristian.marussi@arm.com> <20230811161446.636253-6-cristian.marussi@arm.com>
Subject: Re: [PATCH 5/6] clk: scmi: Add support for .is_enabled clk_ops
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@linaro.org, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 22 Aug 2023 13:22:52 -0700
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

Quoting Cristian Marussi (2023-08-11 09:14:45)
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
