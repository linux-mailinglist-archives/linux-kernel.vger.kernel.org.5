Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60827E1D5E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjKFJlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjKFJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:41:50 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE2CEA;
        Mon,  6 Nov 2023 01:41:45 -0800 (PST)
Received: from i5e861912.versanet.de ([94.134.25.18] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qzw71-000719-Sd; Mon, 06 Nov 2023 10:41:39 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-staging@lists.linux.dev,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Alex Bee <knaerzche@gmail.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH 0/9] media: rkvdec: Add HEVC backend
Date:   Mon,  6 Nov 2023 10:41:38 +0100
Message-Id: <169926364317.186242.13700711914348898172.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231105233630.3927502-1-jonas@kwiboo.se>
References: <20231105233630.3927502-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2023 23:36:07 +0000, Jonas Karlman wrote:
> This series add a HEVC backend to the Rockchip Video Decoder driver.
> 
> A version of this HEVC backend has been in use by the LibreELEC distro
> for the past 3+ years [1]. It was initially created based on a copy of
> the H264 backend, unstable HEVC uAPI controls and a cabac table + scaling
> matrix functions shamelessly copied 1:1 from the Rockchip mpp library.
> 
> [...]

Applied as fix for 6.7-rc, thanks!

[8/9] arm64: dts: rockchip: Expand reg size of vdec node for RK3328
      commit: 667a89fe8383de1be44a8cdf22716448f84ee510
[9/9] arm64: dts: rockchip: Expand reg size of vdec node for RK3399
      commit: a31d776cccb98e0763dadce023ad5caa1a6dce2c

Expanding the range up to the start of the MMU should always be the
correct way, so this doesn't need the rest of the series :-) .


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
