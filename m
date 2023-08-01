Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD31576BD8A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjHATSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjHATSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:18:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C811BF5;
        Tue,  1 Aug 2023 12:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E512B616BF;
        Tue,  1 Aug 2023 19:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341FAC433C8;
        Tue,  1 Aug 2023 19:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690917523;
        bh=qowmyx7qyYO1UJKvfD1fnYIELO95ZZkMKXJeQVTxmmQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UTZT4d393BEYbKTTMdUCo2FH8HZw+gFUG0nZWQmn2PK2+pl0pfsUbCiiPTT2JOsnA
         YcyphCZ6g0sol5ThGEMTutWaV0WL9XeT/MibgPc1kVtyhmf4SIVmqSMw8xE7CEDwTM
         bchfPxwVWA8cW4NJr4C5SHx21PGSXYb9VrhOtWme46vgJU9YAhKNvNwp6L9EndiirM
         1iJiGDAWlfAku5EWnMJDSy9ASYz05YpgufkDYSKYmUsCxotdoSW6HMDsDgsENYE0Qh
         +Fj8OrbidYbTNOraM4o96K7cy7pJV6IpfesUjsAUVD+VzXTjJn4GJYcY+dbkkERdgN
         2i6W6Ogocc4SA==
Message-ID: <02abeb64fb360245791b467b371f1491.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230801085352.22873-2-quic_luoj@quicinc.com>
References: <20230801085352.22873-1-quic_luoj@quicinc.com> <20230801085352.22873-2-quic_luoj@quicinc.com>
Subject: Re: [PATCH 1/3] clk: Add the flag CLK_ENABLE_MUTEX_LOCK of enabling clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com, Luo Jie <quic_luoj@quicinc.com>
To:     Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de, robh+dt@kernel.org
Date:   Tue, 01 Aug 2023 12:18:40 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Luo Jie (2023-08-01 01:53:50)
> Support the clock controller where the HW register is
> accessed by MDIO bus, the spin lock can't be used because
> of sleep during the MDIO operation.
>=20
> Add the flag CLK_ENABLE_MUTEX_LOCK to hint clock framework
> to use mutex lock instead of the spin lock.

Why can't you enable the MDIO bus clk in .prepare()?
