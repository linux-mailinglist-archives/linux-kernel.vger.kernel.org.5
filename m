Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6FD782EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbjHUQzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjHUQzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:55:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514CDEC;
        Mon, 21 Aug 2023 09:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D602B61FDE;
        Mon, 21 Aug 2023 16:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04737C433C7;
        Mon, 21 Aug 2023 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692636936;
        bh=MCuyS6cJya+dunZwz/yrwNzrne9wl0G5N3FRBstgCuI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SGja1V80Kc6h4g4CHqeAGrPIyO46yioT/jY4S77bdzOQu6ERJspEqIfjiJaLLnkky
         qvVKX7kILaWoEtNk4r3a+wXNS1uvtX4hx0EljC2IIFM/KXu31BL5xeY99W8Sx1Sf4O
         m18pFEV0lcs5OYKV6nKHwPqI2zmOa2WZtkokpNzcX7BTXjsO4pG8+PPMuPGSdRErFI
         nsaK0cS3YmzKCuTq3MAvULmvgm1q4Ze09wO33WmDCraPFblO+JL9qbToI0vsmyEyrs
         LlQOvG29UGQkHiPfZzmvQdVu7TF2SSDdLgPEpm9ldxGzV8mo7i4xL7yON1GHMQAZT6
         Ip/PbQyWPxoQw==
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com,
        dianders@google.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, hsinyi@google.com,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230802071947.1683318-1-yangcong5@huaqin.corp-partner.google.com>
References: <20230802071947.1683318-1-yangcong5@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v6 0/2] Add ili9882t bindings and timing
Message-Id: <169263693375.1731411.14798205335759983422.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 18:55:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2023 15:19:45 +0800, Cong Yang wrote:
> Add bindings for Ilitek. The ili9882t touch screen chip same as
> Elan eKTH6915 controller has a reset gpio. The difference is that
> ilitek9882 needs to use vccio-supply instead of vcc33-supply.
> From Dmitry suggestion, it would make more sense to distinguish the
> binging of ili9882 and eKTH6915.
> 
> From The datasheet specifies there should be 60ms between touch SDA
> sleep and panel RESX. so we can add the 65 ms delay in i2c_hid_core_suspend.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.6/elan), thanks!

[1/2] dt-bindings: input: i2c-hid: Introduce Ilitek ili9882t
      https://git.kernel.org/hid/hid/c/7d3b0d9ebddd
[2/2] HID: i2c-hid: elan: Add ili9882t timing
      https://git.kernel.org/hid/hid/c/f2f43bf15d7a

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

