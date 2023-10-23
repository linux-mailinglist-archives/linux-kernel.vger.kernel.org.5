Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7643D7D2F60
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjJWKCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjJWJub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:50:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF769E4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:50:27 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D48FE660708F;
        Mon, 23 Oct 2023 10:50:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698054626;
        bh=GhK2Ud7iFADrChENpq0MFz1UWrwGPzQtCcCAlEyPGTM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BM5o3kiOsM4A/Yk6AEpLvWAIf3butKc5Th+izLQ8+ZCVV8ss7aCDC4aBuWoLC/udP
         oJuvlx9rBaMmEAZ4F5gkNtfo3ITaK41zukqJN6klysjQ5J+Ldyl68ZiWsJlnDJtawC
         eXKH2RQlRL2BdNYn5yi8AAFDMFPKzq7ltOxVzkHX7qSakxgXUYTQ0uhb1Zju81GDIs
         S2ngBqYl6LriSE4+shP54ZOgiwHBE+QX1jYXRDMOootprG5QoK7EhhDLzytBZ3Sfdo
         7uJ1+3dWcOhfqM4ouEyzURyfsmexeCqlbCu800Ibi4zlVXdBLdsIiCsla7fpihhvIt
         wNViGEQnhvheg==
Message-ID: <44b27975-1476-4da5-8427-8b0dab81b0d6@collabora.com>
Date:   Mon, 23 Oct 2023 11:50:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] soc: mailbox: Add cmdq_pkt_write_s_reg_value to
 support write value to reg
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
 <20231023043751.17114-5-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231023043751.17114-5-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/10/23 06:37, Jason-JH.Lin ha scritto:
> Add cmdq_pkt_write_s_reg_value to support write a value to a register.
> 
> It appends write_s command to the command buffer in a CMDQ packet,
> ask GCE to excute a write instruction to write a value to a register
> with low 16 bits physical address offset.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Please fix the commit title:

soc: mediatek: cmdq: xxxx

Regards,
Angelo

