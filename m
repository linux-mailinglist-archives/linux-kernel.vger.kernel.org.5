Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30CB7D6B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343963AbjJYM3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343822AbjJYM3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:29:49 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD79C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1698236983; x=1698496183;
        bh=b7f1p7v4IPk9TLdlMpg0hUuSOsaHLDgWkqrooNiV9wk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=jy59f/ZkCee2bLGRnHVg6g6CX68UCj9a8NVwVI0ICMdirIhvdFlP5+eNjfu9SV0su
         /oJHO6ZSqNeHqeyRX0I2/Fzw5z3IXNThqhemaOC0myO8kXuzMpWXQcSo2FcALYDvUV
         FEr8SrmnqJS5SfVDy5puJ09yAoAtr8vV1GK5zE7oyKn3znZUtWpGm7nAYPwyDOtFg4
         wPXCXMFrgCuduplg6dftl8UMmjz+e/q6s8jaoBdbuU2Bk5iBUv2tu0EzoN3Vr7A3jc
         BBupHU1taO1hpNfPMYepInDRSct3pGAYCCduE8+Y7lc3GaULLNU8nQUUzeLqBIH1au
         +SoQd80BMNASw==
Date:   Wed, 25 Oct 2023 12:29:26 +0000
To:     Johan Hovold <johan@kernel.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink: fix connector type to be DisplayPort
Message-ID: <NDl6Ye92jJDp3fm20AwcuUKWuP8tzQ9CyWGGRltZ_DxYgxep2DO8Wil0Nmsfmhp1j4vAp9Yu1duiHeQkjBG-bcAdFoW3ZbWxvVqrCEpQe_4=@emersion.fr>
In-Reply-To: <ZTkIpMWpxKzSE7gQ@hovoldconsulting.com>
References: <20231010225229.77027-1-dmitry.baryshkov@linaro.org> <ZTkIpMWpxKzSE7gQ@hovoldconsulting.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 25th, 2023 at 14:22, Johan Hovold <johan@kernel.org> =
wrote:

> I was just going to post a patch fixing this after finally investigating
> why the DisplayPort outputs on the X13s were annoyingly identified as
> "Unknown20-1" and "Unknown20-2" instead of the expected "DP-1" and
> "DP-2".

Note, ideally userspace should use drmModeGetConnectorTypeName() from
libdrm to figure out the proper name for a connector type. That way we
only need to update a single spot when adding a new connector type,
instead of patching a whole bunch of programs.
