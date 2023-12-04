Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36208036C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345751AbjLDObc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbjLDObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:31:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB281BCF;
        Mon,  4 Dec 2023 06:30:11 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C1AC966017A0;
        Mon,  4 Dec 2023 14:30:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701700210;
        bh=7jQDv+XsVYeliRgZOmOs/y/FeB21IThRZTlKgn3mYkU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cC+jH2DF63vx0pce1B9b19079v3nc+IP2wSnxHXG/H/PifBHyBV5rr0CdkyG1Gm4O
         QycvYR0LVzRKFjGHQo4DKQ7Ik9khuvaPkc5bsVND72ETX57GWeAvk1CMnafh72hnJx
         WQpzcruJiLX2bfxSpviwxDbz92fBQhDB+kZuAlozceXVHcwIDnC5uWCU3U9n+p9JoA
         ZIaVoWBwZnMHXQq1CyeoZZMyB0fqbxbD9DE4hndgnS3Lf3nvH4chXjy9DP+GLRI+Os
         gZWCHWYSSUgv1aeIF4c1keIHm0/4iY4YQEGct491v8K6txjfzy+EgLWAWftysFHdse
         zJJhUEvuXPGWA==
Message-ID: <1d4432c3-c929-4521-991d-22c92fc74a53@collabora.com>
Date:   Mon, 4 Dec 2023 15:30:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: fix address warning for
 ADSP mailboxes
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@collabora.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com
References: <20231204135533.21327-1-eugen.hristev@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231204135533.21327-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/12/23 14:55, Eugen Hristev ha scritto:
> Fix warnings reported by dtbs_check :
> 
> arch/arm64/boot/dts/mediatek/mt8186.dtsi:1163.35-1168.5: Warning (simple_bus_reg):
>   /soc/mailbox@10686000: simple-bus unit address format error, expected "10686100"
> arch/arm64/boot/dts/mediatek/mt8186.dtsi:1170.35-1175.5: Warning (simple_bus_reg):
>   /soc/mailbox@10687000: simple-bus unit address format error, expected "10687100"
> 
> by having the right bus address as node name.
> 
> Fixes: 379cf0e639ae ("arm64: dts: mediatek: mt8186: Add ADSP mailbox nodes")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


