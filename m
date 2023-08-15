Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27B677CFCB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbjHOP7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238469AbjHOP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:59:40 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1B6DF;
        Tue, 15 Aug 2023 08:59:38 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-43-115-51.web.vodafone.de [109.43.115.51])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 6B6F53D5;
        Tue, 15 Aug 2023 17:59:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1692115176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74PPELyfTdRJMzG/844z25bsJa3XCvyEnvQBQNAdiaY=;
        b=2LurkNY/UP++tp7HyhcQAep+uOzh7mSWOIHO4I7wCdCKHTrppFFdvhjvrgs+ZrKui2E9xm
        JzvuT20uC9Zqh/+HN758R4LUWl8W3jqtbPyGvi2lWQol8JiWqVxuAeiF37/yk4M2ea73e7
        aST0SfYvNKisMulDXoy3rP7N4/V3meWHvzjvZ3KjmToa/WEbAs98POlxnc48ddolyzklhD
        2tn1oQ9akdoCL7IySSv+FNIigyHN+mvVecJ4hOCrPYm02RjxXEMaiIwd7m0LHhLhMMYnLI
        rBdaW6KeyIoU13hl8/44rNf7/hK9gozl9G2KXX/uAdh5QDeetvIsl5ILnk2m/g==
Date:   Tue, 15 Aug 2023 17:59:34 +0200
From:   Michael Walle <michael@walle.cc>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Pratyush Yadav <pratyush@kernel.org>,
        "Miquel Raynal )" <miquel.raynal@bootlin.com>,
        "Richard Weinberger )" <richard@nod.at>,
        "Vignesh Raghavendra )" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 0/4] Add a property to override the quad mode
User-Agent: K-9 Mail for Android
In-Reply-To: <20230815154412.713846-1-hsinyi@chromium.org>
References: <20230815154412.713846-1-hsinyi@chromium.org>
Message-ID: <202A0C36-D1F6-4BB4-BDEC-F36A76B757A2@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20

>On gigadevice gd25lq64c, the quad mode is enabled after BFPT is parsed=2E
>According to datasheet[1], Quad enable (QE) bit needs to be set to 0 to
>use write protection (WP) pin=2E It also recommends setting default value=
 of
>QE to 0 to avoid a potential short issue=2E

So you are using either dual or single io mode=2E Why can't you use the de=
vice tree property spi-{tx,rx}-bus-width?=20

>Add a disable-quad-mode property in devicetree that platform can use it t=
o
>override the quad mode status parsed from BFPT to use write protection=2E
>
>[1]
>https://www=2Eelm-tech=2Ecom/ja/products/spi-flash-memory/gd25lq64/gd25lq=
64=2Epdf

should be a link on the vendor Homepage if possible=2E=20

-michael

