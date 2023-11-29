Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F297FD80B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjK2N2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjK2N2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:28:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F50A3;
        Wed, 29 Nov 2023 05:28:28 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 533C76602F2A;
        Wed, 29 Nov 2023 13:28:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701264507;
        bh=Rdu1NaKSj2kzBeybGne4kRQi1ROpMAaHqNT1VOxkkV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnvVyn4Lq9o5kVeK/OFctReEqNq9aOvb3z3dKUeB9dvDlSxL1sMAFEJA0QKwAMs4z
         dP82xlCUWSV0vkDwZwqLmr1tdhXpvcWi7Hh8ivz0O4dTn2gJhGMzSVAqkDPGDIv33Q
         zhytACMP9mlxNvUVGg04i8ADhiMXSIfmOvHRimc2SBA99ydxLJIvTmqVtofKpmblsf
         pCvpHWbsKc6yOhZoplKBVozGhestOMNDPD8csqTz6g5j56enmA4358ibDrYguj43P/
         +TNMSElGTp7r2yzlfp8PDbcqK3hTPt6jcVZ3B18z1+WXKitymG9Yuwc/OL+t/t/bcB
         4OAkUNu9o3BQA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linux-mediatek@lists.infradead.org,
        Eugen Hristev <eugen.hristev@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: mediatek: mt7622: fix memory node warning check
Date:   Wed, 29 Nov 2023 14:27:33 +0100
Message-ID: <170126437824.153055.16156664615192644481.b4-ty@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230814065042.4973-1-eugen.hristev@collabora.com>
References: <20230814065042.4973-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Aug 2023 09:50:42 +0300, Eugen Hristev wrote:
> dtbs_check throws a warning at the memory node:
> Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
> 
> fix by adding the address into the node name.
> 
> 

Applied, thanks!

[1/1] arm64: dts: mediatek: mt7622: fix memory node warning check
      commit: 022597b6e520b5c21894b9693bde215a5d788a17

Best regards,
-- 
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
