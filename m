Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322047A83BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjITNqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbjITNqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:46:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8488DE4;
        Wed, 20 Sep 2023 06:46:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BAEC433C7;
        Wed, 20 Sep 2023 13:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695217561;
        bh=Af/2hG8Rettl0ksgOXBNHtUqLQxI55gP+9ND2DeTVIo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ogFLbZAprynFzuWPsOYcf3ijDaslsOyOwEWAXskXuFQiisw2fyFotXVRqwRZM0Tko
         rKbUo5QHujkA/LGhyMnYjjBrknPTupyJwwvxtnd4kzWbUUlcUb+ycfGpCOrRtLIwBf
         NQJxFVFqhVLcHtXc0ph6a5MQbiJNlgm27N0cAenUmOaJYZm0WVcQOubhdJN0Q0sL4I
         kd4Hzbgrjw6JBgrOy2GaIVLJpdky3sQbTcYArwyQWtEiaMl6aBp4OGkDIC1q6L7L94
         zq0VRBu+UKN03h6bA/LWAUNDVt453WlnD+mZgPqP/NsSTTn1daT9qX5a9rLMSBfz9t
         epQ5Fo4VswRQA==
From:   Lee Jones <lee@kernel.org>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lee@kernel.org, bcousson@baylibre.com, tony@atomide.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20230916100515.1650336-1-andreas@kemnade.info>
References: <20230916100515.1650336-1-andreas@kemnade.info>
Subject: Re: (subset) [PATCH v4 0/5] ARM: omap: omap4-embt2ws: 32K clock
 for WLAN
Message-Id: <169521755809.3445505.9877509885722763259.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 14:45:58 +0100
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

On Sat, 16 Sep 2023 12:05:10 +0200, Andreas Kemnade wrote:
> To have WLAN working properly, enable a 32K clock of the TWL6032.
> In earlier tests, it was still enabled from a previous boot into
> the vendor system.
> 
> Changes in V4:
> - use dev_err_probe in clk probe()
> - R-by
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: mfd: convert twl-family.txt to json-schema
      commit: 098e2d6fd72fc99097af33e6e8cb4cd0921a26ac
[2/5] dt-bindings: mfd: ti,twl: Add clock provider properties
      commit: eb9fba08e386ff98818de12b40a5ee1443129229
[3/5] mfd: twl-core: Add a clock subdevice for the TWL6032
      commit: 3e359099b245227c6729dd5f81f2757dea5d4656

--
Lee Jones [李琼斯]

