Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98327D453B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjJXB6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJXB6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:58:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124CBD7E;
        Mon, 23 Oct 2023 18:58:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71603C433C7;
        Tue, 24 Oct 2023 01:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698112723;
        bh=FCj15onWO4Pj26BCcOfBuErxi6hCiBoXycGd23U/srk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ml5wqcXm4BZIOj+ipqEDM+i2hAUAKPHyRBYhvV0ZZOReDOB3Clp3vVrQ+W2B1/B+k
         u4RsDC+18z0iY7DJDX+0B6FwA6g2i7QR0SzdhaM98fKwL3hwTVpHf9MmiPqTnpEn1M
         /e2gWUqmDzHYTQyRPQnIgwPrp/Eu6NRM+g2g8X2QPU/HKkEDJ7CZ+w5E6CZmmMxJ2g
         Pz/roEd2LaVgqvCWIaF3JuAZTUFAzE7o2uhnzd6CcvtAydoXg7+ZKHIXstkhc8nNfk
         SDBOJfTSeaeL4bmmIoIYlvbl8DdUF6PHlg1+mS+OC0nIco5d7/TQd2gtibc3o9vw80
         490FGtGfynPGQ==
Message-ID: <97cfa2dae94d1abf12d9abe5374569f1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231003152927.15000-5-johan+linaro@kernel.org>
References: <20231003152927.15000-1-johan+linaro@kernel.org> <20231003152927.15000-5-johan+linaro@kernel.org>
Subject: Re: [PATCH 4/5] spmi: document spmi_device_from_of() refcounting
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>
Date:   Mon, 23 Oct 2023 18:58:41 -0700
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

Quoting Johan Hovold (2023-10-03 08:29:26)
> Add a comment documenting that the spmi_device_from_of() takes a
> reference to the embedded struct device that needs to be dropped after
> use.
>=20
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
