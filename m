Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C3D792826
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346753AbjIEQVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353738AbjIEHqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:46:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3EFCC;
        Tue,  5 Sep 2023 00:46:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ED57A6607186;
        Tue,  5 Sep 2023 08:46:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693900000;
        bh=LFndA3pFJkQjsY6+cZ6q8HLFNc/UGIg5dTqHJTKN0iQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Pew4fawfy9voOOmE19XJUCsMQ72+myxp521f+lJ63NOtBo2sDHhpw1WiD5ScDG/zs
         RAlBhLcc5u/n0z1qWxtO0VoIcOqn7qbGF8U9xyoitgRHwyVjjzHkWOiONElzrcYsKH
         r1ozDXtuQat1zTsISxfeQdHPMOtbQgB54w2iE3PJWSXrioA4TlAonrN3jWoVPw2Npd
         786Bt+/rd6ixLLF0SI1VMyTKVDzLFaCUKwu0QcysplvyIfPZ0Ru/Gl8H1mt3dm8w+b
         DuJGIS1wxbXv11+2/iI74HguOcmAWoM6lTlu/NTzulIIKuB3/vzlfKaoflVPz93Qnx
         Mru9XrTYYePrQ==
Message-ID: <cb1fc499-3649-0f3b-f9c0-f5305b2310d7@collabora.com>
Date:   Tue, 5 Sep 2023 09:46:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v17 12/14] remoteproc: mediatek: Report watchdog crash to
 all cores
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
 <20230901080935.14571-13-tinghan.shen@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230901080935.14571-13-tinghan.shen@mediatek.com>
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
> To ensure consistent behavior, the watchdog timeout handling of the
> multi-core SCP should reset the whole SCP sub-system when watchdog
> timeout. Triggering the rproc recovery flow on all instances will
> ensure proper recovery of the SCP sub-system.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


