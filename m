Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644B87A961A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjIUQ6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjIUQ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:58:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8EC1BCB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:58:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4164666072E7;
        Thu, 21 Sep 2023 10:13:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695287584;
        bh=q5YJhSxiDShzZxa0xIGydYZu/ODFTndBpUE8JLIrRNc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U49KQ/44xmIYP4MQa0FYJ0juSJBWTgwHVl5UfqfexBzZXxfjJTQA8xc3wsqYH33bn
         PYql/zoXVQsOSNh3NV+bJrrmR0z4vfRDCz7tBuIui+lZQiEXL8MYKHY2gaE2oQs8cZ
         1G4H/8Vl37DlFdYjR+1WfM1jDAf5ioiPeU4KC2TF+oEBT8NtIgjRtRYX0S2YDxSVP5
         xsALTNYLQbfAIIW/CSc3ja+PmGZlFfPOnUFBw3J+dNanpIyp3HMoXvANGzLDLgnRyq
         YzzAUkQpplN7MmX99iK1ytA5LDdTyBHI38xSOfBploxmZborTdYew7i2tpWmhP1DF4
         xFVqsuZ4FYTTA==
Message-ID: <71906f4e-8875-7431-aee5-57eae1f55d65@collabora.com>
Date:   Thu, 21 Sep 2023 11:13:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 3/3] regulator: mt6358: Add output voltage fine tuning
 to variable LDOs
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230913082919.1631287-1-wenst@chromium.org>
 <20230913082919.1631287-4-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230913082919.1631287-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/09/23 10:29, Chen-Yu Tsai ha scritto:
> Some of the LDO regulators in the MT6358/MT6366 have sparsely populated
> voltage tables, supported by custom get/set operators. While it works,
> it requires more code and an extra field to store the lookup table.
> These LDOs also have fine voltage calibration settings that can slightly
> boost the output voltage from 0 mV to 100 mV, in 10 mV increments.
> 
> These combined could be modeled as a pickable set of linear ranges. The
> coarse voltage setting is modeled as the range selector, while each
> range has 11 selectors, starting from the range's base voltage, up to
> +100 mV, in 10mV increments.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


