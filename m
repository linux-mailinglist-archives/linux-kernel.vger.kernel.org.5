Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF5E7CF7B4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345464AbjJSL5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345407AbjJSL5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:57:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2101181
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:57:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982A1C433C8;
        Thu, 19 Oct 2023 11:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697716657;
        bh=aN/DfaqxW2mupzGZTQqq7LpMPtxnK8oADvUqMvSY65g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JqzwZLWyRQTjQWXcatMe0Uv+b1vOa+q/PZuds8jO8WS9CX67GqR5iVjMRhlkYVQo2
         BMMI8yUiXqpO8sVJ5shE+RQb9nHNcJLIJYsnuexpXqow/JI8/z0T1W6OIzWewApdiS
         lmoYiC9/8feR7dvTBbaQA4j4N2nHiCpbnu9xUcbpwfOyD8I/meiGk3I6NtMMLeXuKk
         ljPIDVZ6yeahzAe5ErgyK67L1QhRkac73YdQ1SXOvC0VgyOLRC1mcfcHC/iZp8hFJ7
         Qes6EwTy1f+7ohwHxZWf7rFV3vhrX++y0iL3vgP3kqe+3ic3OX7z7RSxwvX2nwjFGj
         1/8UuaVIRJM5w==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20231014205414.59415-1-hdegoede@redhat.com>
References: <20231014205414.59415-1-hdegoede@redhat.com>
Subject: Re: (subset) [PATCH] mfd: arizona-spi: Set pdata.hpdet_channel for
 ACPI enumerated devs
Message-Id: <169771665635.2458961.325195699541047126.b4-ty@kernel.org>
Date:   Thu, 19 Oct 2023 12:57:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2023 22:54:14 +0200, Hans de Goede wrote:
> Commit 9e86b2ad4c11 changed the channel used for HPDET detection
> (headphones vs lineout detection) from being hardcoded to
> ARIZONA_ACCDET_MODE_HPL (HP left channel) to it being configurable
> through arizona_pdata.hpdet_channel the DT/OF parsing added for
> filling arizona_pdata on devicetree platforms ensures that
> arizona_pdata.hpdet_channel gets set to ARIZONA_ACCDET_MODE_HPL
> when not specified in the devicetree-node.
> 
> [...]

Applied, thanks!

[1/1] mfd: arizona-spi: Set pdata.hpdet_channel for ACPI enumerated devs
      commit: 76a2f781da567a0ff7bd064d3ede064b29973b01

--
Lee Jones [李琼斯]

