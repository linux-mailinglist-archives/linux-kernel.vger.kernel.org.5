Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2689C7AD4DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjIYJx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYJx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:53:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ADAC2;
        Mon, 25 Sep 2023 02:53:51 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BED5866072FC;
        Mon, 25 Sep 2023 10:53:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695635630;
        bh=9wVVMeW0iA/EuwP7KjcnyVlsmaFHBI4yGmfpP4XGrqQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ekA3onxVHDOjI6teW7l8DaE4DjKhVBGp5ZrZX12NiDJnolL1QPg2FTgfcLh4Mz093
         8/lHOJbMCjyOSTsLhO9J1nov9S4XvxxkC4q6Rsjx4LPOIQ/o/kykwJDM2rpmFEPLlH
         3n3jnH42Gtq4JziLqIftQCqGM+QYWt/RJ5hTpbLLFf+kq4y0i1JRCdyeY5x3J4a+B0
         1roPFVMO3DMZtIIe+FUsAd6R0hssXtuQ0Jzbd4fzk8e0nZUOKQh0mGGoiyyd1p8j1z
         IIPec14m4/WOFNmBKwIAZv/LvG/ijI423E175z7Hg9pLlKewOZO+1y/l0Tp6ZpwQdm
         SZPr1dL/axotA==
Message-ID: <9fd97bac-d180-14bc-09ce-878575f0cef7@collabora.com>
Date:   Mon, 25 Sep 2023 11:53:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] thermal: core: Check correct temperature for thermal trip
 notification
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel@collabora.com, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230922192724.295129-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230922192724.295129-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/09/23 21:27, Nícolas F. R. A. Prado ha scritto:
> The thermal trip down notification should be triggered when the
> temperature goes below the trip temperature minus the hysteresis. But
> while the temperature is correctly checked against that, the last
> temperature is instead compared against the trip point temperature. The
> end result is that the notification won't always be triggered, only when
> the temperature happens to drop quick enough so that the last
> temperature was still above the trip point temperature.
> 
> Fix the incorrect check.
> 
> Fixes: 55cdf0a283b8 ("thermal: core: Add notifications call in the framework")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

