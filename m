Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BF679E337
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbjIMJL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239254AbjIMJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:11:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F2D19BF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:11:32 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A7DA3660732C;
        Wed, 13 Sep 2023 10:11:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694596291;
        bh=N+JMYyvOVjtyU/ve8vYukFa5nTM6GUSEY4UtANdc3GI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gsouZHJPmErhDGeooV6CUn77O0tNB7ffMMRcit2UgaH5EfZXZaK+d8NGU/otajs8r
         lofJaiwuLgZvs17fQyKNN8Y9mQAiPVu6ABZcHh/uHwiaihCbwxLFmzxIJ0HjEmFyDP
         zJ2VSAytFImJyueMVy9aQHGH1h7rP1g/SPb+XKdjpK+bn3U6OIeaIVcQ4LJfpzGmRd
         cEFhEhtLQtVhc2XFaS9aMhbcyrHyIq8xTKF1SkJWrAYEZYDA6QAXGXHj8XLX/PXoQJ
         sA4opvR6C7Y7wMi/stbc7PDb4R1kYua3HKIDUPWFFz9FhO2rT49zovZqwne9ir2cbQ
         WKrpDgXYK5frw==
Message-ID: <5d3053d8-0252-f8fe-fa9e-526f0f4d52bb@collabora.com>
Date:   Wed, 13 Sep 2023 11:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/5] spmi: mtk-pmif: Reorder driver remove sequence
Content-Language: en-US
To:     Fei Shao <fshao@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230824104101.4083400-1-fshao@chromium.org>
 <20230824104101.4083400-4-fshao@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230824104101.4083400-4-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/08/23 12:40, Fei Shao ha scritto:
> This driver enables clocks and then adds SPMI controller in probing, so
> we expect the reversed sequence in removal.
> Fix the order in the remove callback.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


