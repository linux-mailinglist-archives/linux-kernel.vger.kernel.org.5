Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678F379BD60
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346947AbjIKVYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244379AbjIKUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:15:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309D3185;
        Mon, 11 Sep 2023 13:15:49 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BE10566072FB;
        Mon, 11 Sep 2023 21:15:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694463346;
        bh=QvYpu+E4ir6H9xoX6RAFUKeRn6noR1kwabk8MMjaLtc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EwwodJ5FTz+p6UYEh057UhpgWQwoWjtl5y2YvIZyQfaFIQmcG9+9uHf4t24SRuZO5
         hPc8ON09f5gyM9RnP+FYqD2s7LzWITpD6LcDRmDiFIWgO/tiRTer0qEwzOLnID+mTB
         RggGg4AB1PtBH9DsyR7hoGq/V9xbCe/4vaxajZBIOyrnJ8/uF7VHXFi6VwhJUyt+yR
         L20eEOSWK66I+nAt4VFh0EXu0jyoaLa6UY6h3xmWXpO8FJ/MZRImeWJc91lYcQrUM1
         +uZKPCBlyKid6yI+hqybuXfgVpLXnKOnuCKSzp4A3ywhcJwi958kGX8uLI4+uZbCD2
         Z1dxlDPJnZfvA==
Received: by mercury (Postfix, from userid 1000)
        id 73FFB1060929; Mon, 11 Sep 2023 22:15:44 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
In-Reply-To: <20230906084815.2827930-1-harshit.m.mogalapalli@oracle.com>
References: <20230906084815.2827930-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] power: supply: mt6370: Fix missing error code in
 mt6370_chg_toggle_cfo()
Message-Id: <169446334445.405661.9324882432164519233.b4-ty@collabora.com>
Date:   Mon, 11 Sep 2023 22:15:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 06 Sep 2023 01:48:15 -0700, Harshit Mogalapalli wrote:
> When mt6370_chg_field_get() suceeds, ret is set to zero and returning
> zero when flash led is still in strobe mode looks incorrect.
> 
> 

Applied, thanks!

[1/1] power: supply: mt6370: Fix missing error code in mt6370_chg_toggle_cfo()
      commit: 779873ec81306d2c40c459fa7c91a5d40655510d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

