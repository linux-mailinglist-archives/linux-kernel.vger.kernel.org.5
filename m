Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD6177F66C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350855AbjHQM2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350913AbjHQM2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:28:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56891210D;
        Thu, 17 Aug 2023 05:28:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8BCD66EA9;
        Thu, 17 Aug 2023 12:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0DDC433C8;
        Thu, 17 Aug 2023 12:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692275323;
        bh=Q4jkaB2Wjtw4fT0NRjZYyMmUWOQgjyU51XqeLeC7dR8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Ac3paWwHJUn/paqyCgeLrPSxQLyqaDssAMmfHbb7GHLXjaXg0UjK6awQouVwKhbq6
         D6PgfvGnWaDnG1pcxXYuRqX4VOFFnNaruoY+HM47TraiTwps+zWAGyjeNKQ4e4SCPu
         TCUB5l45V1PAPuQiOqhOTR3YckozUX6l8WTqRHHCjnKKDl+mV731bxVZ4RERUT84F1
         ydisBK+nYkJfRQenZR4K8GrKfiYX1RfGCk+C+ZHwmUhsVSpVcVKw110EblTA6aKpuU
         MBK2qIbk8oitMhtJXH4Miocuq8gNDslEVYsMMI+IoEz3VVmxRheUNP3YvllmSVgwix
         VBS+S5hMZsBjg==
From:   Lee Jones <lee@kernel.org>
To:     pavel@ucw.cz, lee@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhu Wang <wangzhu9@huawei.com>
In-Reply-To: <20230808111108.24262-1-wangzhu9@huawei.com>
References: <20230808111108.24262-1-wangzhu9@huawei.com>
Subject: Re: (subset) [PATCH -next] leds: remove redundant of_match_ptr()
Message-Id: <169227532205.1025442.8435779800286880194.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 13:28:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2023 19:11:08 +0800, Zhu Wang wrote:
> The driver depends on CONFIG_OF, so it is not necessary to use
> of_match_ptr() here. We remove both CONFIG_OF and of_match_ptr() here.
> 
> 

Applied, thanks!

[1/1] leds: remove redundant of_match_ptr()
      commit: 3d590af89b1e61568395ab37e9b5f88fd711f638

--
Lee Jones [李琼斯]

