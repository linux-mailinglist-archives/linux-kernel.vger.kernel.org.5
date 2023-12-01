Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1B08009DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378525AbjLALYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378500AbjLALYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:24:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9832EC4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:24:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B97C433C7;
        Fri,  1 Dec 2023 11:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701429890;
        bh=rYqBSjamQXtlSslFcg8gvLvU5PS9WpJZS4rNYHLG+H8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YmIm5RK3ckUH4e9RsSXlclJRgNNR9mlCL9AKQLWj9hZf4oLIQenz7MCKvfqLFX3Sj
         N2DBN1jm7uEugLNJ9FQ+AYwDG5kLS+s60SrO5hlE2r1C8ECpoaP6S4f05RysULzBS+
         DU1YciJ+coOKpPHlVZbn5ym2UigN41+EWF31uGX/Yl1pVWpk3iyGUJBcbv/LY6960v
         DbTff0rpJ4PIeaH5Gg7q6oHYgEVjnht9IF9J1KOkNtlg1uIml63qY6mVo4+l335UJt
         TieIg18K1mCrrlwPYr1kIvME+Kg60VRlZYSRIUViVde97kwNHLybC/8iloKqfi0/tm
         Z6dZ/19r9yApw==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231129164514.2772719-1-f.suligoi@asem.it>
References: <20231129164514.2772719-1-f.suligoi@asem.it>
Subject: Re: (subset) [PATCH v2] backlight: mp3309c: fix uninitialized
 local variable
Message-Id: <170142988824.3370898.14636793712947246293.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 11:24:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 17:45:14 +0100, Flavio Suligoi wrote:
> In the function "pm3309c_parse_dt_node", when the dimming analog control
> mode (by I2C messages) is enabled, the local variable "prop_levels" is
> tested without any initialization, as indicated by the following smatch
> warning:
> 
> drivers/video/backlight/mp3309c.c:279 pm3309c_parse_dt_node() error: uninitialized symbol 'prop_levels'.
> 
> [...]

Applied, thanks!

[1/1] backlight: mp3309c: fix uninitialized local variable
      commit: ab47505ce45b869ab649024dc932e981fcdd6e5f

--
Lee Jones [李琼斯]

