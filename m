Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585C1792791
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbjIEQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353736AbjIEHqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:46:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEA7CC;
        Tue,  5 Sep 2023 00:46:40 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 983E16607033;
        Tue,  5 Sep 2023 08:46:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693899999;
        bh=N17nKRenuWrXQvbPYayfAXzToq+gFoZOFDOSSc7L+fM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Sb1KR0+Fo6COyGKeYr/5gd1FqmGuMYbX7f8E8C6XeU0YD74tUBePlMUpy2Bl1IY8Y
         49JUTMhcePcdIoLYWSDFduSN4CB0PjoIfI4TT0ynjsyKtutaajlyEm4pCRIlFq0fJA
         2edAoybmDatc71WsEzltFHixwenLSAoeepEcSzrqvsGxQde+ds8wwFJIvKzfBpF87z
         G61nHbWrxb/ixSYusLu604r8Og3Wq647miKIoW6aVjz2zzuYzpFRA8q8kYcNwvBFOW
         J6Q2SushZ8RJyTmNRtcFlYzFQNqVpvd92RGeiMv9MYA71Yp0z+hJnFwRipKXxHagH8
         5TCJ2KVFrxK8w==
Message-ID: <43b990d9-7bf8-ed06-ccfd-69b2a6cb85e5@collabora.com>
Date:   Tue, 5 Sep 2023 09:46:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v17 06/14] remoteproc: mediatek: Revise SCP rproc
 initialization flow for multi-core SCP
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230901080935.14571-1-tinghan.shen@mediatek.com>
 <20230901080935.14571-7-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230901080935.14571-7-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/09/23 10:09, Tinghan Shen ha scritto:
> This is the 2nd preliminary step for probing multi-core SCP.
> Initialization of configuration and L1TCM registers is extracted
> to only performed once on multi-core SCP. The rest of remoteproc
> initialization procedure is similar for both single and multi-core
> SCP and is applied to each core.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

