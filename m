Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796B07976CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjIGQQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238457AbjIGQQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:16:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F76AD3A;
        Thu,  7 Sep 2023 09:15:20 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C3BE066072FC;
        Thu,  7 Sep 2023 11:49:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694083754;
        bh=OFLJjkH0n3nuvjKy5n4yw1ihmDQMqgkN8jJdfrUz49c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PZUAyQIL3eLgRZ1dsWDYci/fuecgDE+LjOI4plnfUOCi9rOXqGJz/zsk/vlrgKsuf
         XvQ4AnOIR7T+VtEsgTIgTj0q2WWtUQ0nL3QGkg0EMZGLhviDz3OFgn6vVDjY5N5yg5
         sGvFnai2PknMLqVPU94uQKS5NGU71U4qw0YyKYs0sEOIF+7taVf5jo+ALoybRJYElc
         CKkvzDnbLWu8ZTOgbrvgzRBql0KM9+TpQ2V+2ubdK2+X4wD8o1MkX8aQFMDUSi67te
         l1LLbHMwz6o63UciiQZ9qMwEVgqEI8kloAqSc2xjxKeA7A5d6qAqWukik1R0zNCRQx
         asT6oy6p10otw==
Message-ID: <ebf80e22-77c4-8f8d-6e98-e8b33949e6e1@collabora.com>
Date:   Thu, 7 Sep 2023 12:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v17 05/14] remoteproc: mediatek: Extract SCP common
 registers
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
 <20230901080935.14571-6-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230901080935.14571-6-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/09/23 10:09, Tinghan Shen ha scritto:
> This is the 1st preliminary steps for probing multi-core SCP.
> The registers of config and l1tcm are common on single-core SCP
> and multi-core SCP. Extract these registers out to reduce duplicated
> fields in mtk_scp when multiple SCP instances are created.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


