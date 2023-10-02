Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B66E7B4C5D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbjJBHMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjJBHL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:11:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF63E8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:11:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5046bf37ec1so15571014e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696230713; x=1696835513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvfMaUkoqxOdai7I7ecvncHhXdnmpTh02eP9PeaUV+0=;
        b=Bx0oH+gaAzGHwpnu21F/xh1xvusJxMxQDKBaVf+SGBHeC9pEidsRV1c36j0KTAqGZX
         wqXQWK8lyUFAJq15TlBPSW3MsKsqUJ81lw5Kdb+G031sb1mJ7s48LTM519KRfb3/5ZBl
         ZbSwYLjzWhFG0sigUPaMYc4yokM7rDIu3ony2k7oy7i6e/bF60YFrOYZENjYuW6iRNYI
         Wy+0MNzPJtxqrHzNxnHhvF9XdzQNRm9op/rZtfoeYwkWWzYcJfgC82bekPCTdVLWsaF4
         vUlSnhP4hUA/2oJTV4bWaOVmV+GHE02KedX1wXps8VDgAdyl6oV2SI0aAL//F7/zsSOu
         PH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230713; x=1696835513;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvfMaUkoqxOdai7I7ecvncHhXdnmpTh02eP9PeaUV+0=;
        b=QWVD9n6oRkF6MgOFuKYGiD1GMpnczwH5IrOWC6PDpAn14osH9AZ/A6Rh80Kb3vdOk9
         Pbzm/sNVKZ6t8oa54WS9pWvbNDv+W0awqKSJPxdvlE2IjbdpkGx1vIBVhc7UnN0iVecv
         Oj1nYtIERlQtrblMMdiXSEtweSwS3p0at7eynxdpFf4EfxW0PlfJAcKivVnOVOqdZ36V
         k03i1O05lYOmBVRbu2Az6b3WfySx9kWwHcTb/tf2kqMWR4mt9UugIq2a17TrXxBlxW4t
         YxsLzNJLZmWpD0eku17HDkKdp3s3G3DRHzjQfs2ZiS7TgYXTCRTucdYyWoGQn4EoNfSJ
         6pEA==
X-Gm-Message-State: AOJu0Yya52fLyyZZf/eqSYg2aLLWzlzDaJbZ87X0HBFV8B8Cgb2jp6Be
        SGLrNqdzq1Bc+eSGB4yR3nnXIA==
X-Google-Smtp-Source: AGHT+IHZV19ronjlsIZ1rQLIh6Ioa9BRStyicQzU6glUdgfbV7Oc5uN1rCLPUA5MZ2qFHquSCZ0gRg==
X-Received: by 2002:ac2:4101:0:b0:503:2924:f8dd with SMTP id b1-20020ac24101000000b005032924f8ddmr8105031lfi.47.1696230713379;
        Mon, 02 Oct 2023 00:11:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c025900b00405623e0186sm6601371wmj.26.2023.10.02.00.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:11:52 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Mark Brown <broonie@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231001-drm-sn65dsi83-maple-v1-0-5519799a55e5@kernel.org>
References: <20231001-drm-sn65dsi83-maple-v1-0-5519799a55e5@kernel.org>
Subject: Re: [PATCH 0/2] drm/panel: ili9322: Minor regmap improvements
Message-Id: <169623071250.3600226.7069510990814929570.b4-ty@linaro.org>
Date:   Mon, 02 Oct 2023 09:11:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 01 Oct 2023 11:24:12 +0100, Mark Brown wrote:
> These two patches provide some minor improvements to the ili9322 regmap
> API usage.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/2] drm/panel: ili9322: Remove redundant volatle_reg() operation
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c8c575ebf6daaf1fbe029cc04c845e2fad462320
[2/2] drm/panel: ili9322: Convert to use maple tree register cache
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=800c1ff7d1b12b6309eb877542367b94f376acbc

-- 
Neil

