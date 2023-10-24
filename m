Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF77D4537
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjJXB62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJXB60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:58:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D9910C1;
        Mon, 23 Oct 2023 18:58:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6459FC433C8;
        Tue, 24 Oct 2023 01:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698112704;
        bh=0qPvKrMGMfZJEWgqaG8R72MpPExmTFSPFWOeP3WWhgw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IT1HXDgq0XtDq6YeFjT29pGF7O8E8r7nxnJcaci5IsJ1IujeiyK9Xhc/AUhV0mC9z
         E/S9H3/uhM78YDxpFxzkArE8vA0NGdNdcMRaDiaMiyUw9nWUD9936+eK0vEeVjxw5e
         KysgTUlSPcIu+SOQuHyocoJZ3APBAcG7wq0vuE153+QOKWQScETe2qplQEUiMVEfEj
         AQMS29KHFYRL4xiEEBgsDJ4BoNO6yALbAgFC3TSLmldXD1xnlmJj2Xp96vr+/Elqv3
         iHmGxVsLdNptw9SN9mtHMr7588b1hkzjZrda0F0fLp4SBu4Zf1CVKm+68T4lCAJnK3
         Wp+zjVhZPxmOQ==
Message-ID: <083fc8d9c3f7f72f05e1d668ccd553f4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231003152927.15000-6-johan+linaro@kernel.org>
References: <20231003152927.15000-1-johan+linaro@kernel.org> <20231003152927.15000-6-johan+linaro@kernel.org>
Subject: Re: [PATCH 5/5] spmi: rename spmi device lookup helper
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>
Date:   Mon, 23 Oct 2023 18:58:22 -0700
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

Quoting Johan Hovold (2023-10-03 08:29:27)
> Rename the SPMI device helper which is used to lookup a device from its
> OF node as spmi_find_device_by_of_node() so that it reflects the
> implementation and matches how other helpers like this are named.
>=20
> This will specifically make it more clear that this is a lookup function
> which returns a reference counted structure.
>=20
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
