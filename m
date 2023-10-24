Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2427D4547
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjJXCCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjJXCCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:02:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA81DC2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:02:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B32C433C8;
        Tue, 24 Oct 2023 02:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698112928;
        bh=Y0IDUpPqy/a+gLZUhsDxolAh0A7iBwDaXATelPs27XY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=d81FuffP6LqRV0kD+T0iDlD7x/fGhw4AWhfKsjzDya9/E4MnNhBxSRuiXEgzNkC/n
         JiamCuc72hAVx3awQat3slnb68K6UbKEjhmwtTZyzGLJR9yj2pV0/VCIfKIC2/I2Q8
         pyt5iJlJ7NYb9OsJ8DSl9NbRnUo2ePemjwHf8aX1pB2710sTQL/fL8uPhW5qRSQ25T
         hAj555k8fiuXyA34+s+BOVrMk/uWkXxVMn+h2OljuJW7ARz3MQ1Q1tfisLdZlSMq1R
         +Swis2ZYVIXvchTWHtG9/fOsNe/UflxFkJZvTGGEauvao6dQmAN3VXVqKeGUB+Gk7O
         sUiqjNnAE+RHQ==
Message-ID: <b94f70395de969227b814f45b0907b86.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230824104101.4083400-1-fshao@chromium.org>
References: <20230824104101.4083400-1-fshao@chromium.org>
Subject: Re: [PATCH 0/5] spmi: Add and use managed resource helpers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, Fei Shao <fshao@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Chen-Yu Tsai <wenst@chromium.org>, Fei Shao <fshao@chromium.org>
Date:   Mon, 23 Oct 2023 19:02:06 -0700
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

Quoting Fei Shao (2023-08-24 03:40:07)
> Hi,
>=20
> This series adds and converts to the devm_* helpers in the SPMI driver,
> based on the suggestion in [1].
>=20
> While at it, I have some patches fixing other minor issues as well, like
> reordering the remove sequence in spmi-mtk-pmif and using proper error
> return code etc.
>=20
> This patch is based on next-20230824 and [2] which is not yet applied,
> in order to avoid potential conflicts.
>=20
> [1]: https://lore.kernel.org/all/20230821033532.GA21555@google.com/
> [2]: https://lore.kernel.org/all/20230717173934.1.If004a6e055a189c7f2d072=
4fa814422c26789839@changeid/
>=20
>=20
> Fei Shao (5):
>   spmi: Introduce device-managed functions
>   spmi: Use devm_spmi_controller_alloc()
>   spmi: mtk-pmif: Reorder driver remove sequence
>   spmi: hisi-spmi-controller: Use devm_spmi_controller_add()
>   spmi: Return meaningful errors in spmi_controller_alloc()
>=20
>  drivers/spmi/Makefile               |  2 +-
>  drivers/spmi/devres.c               | 61 ++++++++++++++++++++
>  drivers/spmi/hisi-spmi-controller.c | 32 +++--------

Applied the series to spmi-next.
