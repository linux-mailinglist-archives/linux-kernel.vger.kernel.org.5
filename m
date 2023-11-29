Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C865D7FD13B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjK2Ioj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2Iof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:44:35 -0500
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D763DA;
        Wed, 29 Nov 2023 00:44:41 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id 91A8328EE6F;
        Wed, 29 Nov 2023 08:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1701247479;
        bh=8dG6wXZ7YD/GD8RPYXq9Rwlv5prQ9VGMtUd8zQki0VI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ltFKlGOMTS2z7yJpkWIalxYIAoonpPcij+FCZFtsabdKeeymjkqMejYPKGYgHnKjY
         PpcJjqxw3o4RAFxy1G0b6UrABEIc4D95+rpyVnbO0cEz8pOdPI939lSKiiipudbWW/
         Eaxw4nHqwbHMv3/ivqAnR1KRC4N/CF3MyT/1pOo0=
Date:   Wed, 29 Nov 2023 10:44:38 +0200
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <ZWb59iEftxX6mQdJ@sunspire>
References: <20231129070432.1437-1-petre.rodan@subdimension.ro>
 <adf1e932-a201-475e-a562-4e35954159ee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adf1e932-a201-475e-a562-4e35954159ee@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

On Wed, Nov 29, 2023 at 09:04:17AM +0100, Krzysztof Kozlowski wrote:
> On 29/11/2023 08:04, Petre Rodan wrote:
> > Adds binding for digital Honeywell TruStability HSC and SSC series
> > pressure and temperature sensors.
> > Communication is one way. The sensor only requires 4 bytes worth of
> > clock pulses on both i2c and spi in order to push the data out.
> > The i2c address is hardcoded and depends on the part number.
> > There is no additional GPIO control.
> 
> Your threading is broken (not existing) since v4, making it difficult to
> apply the patchset. Please fix it when sending v6.

I'm confused.

you mean the lack of 'In-Reply-To' and 'References' headers in the emails
`git send-email` is generating?
I've added them for v2, but was told that was a mistake [1]

[1] https://lore.kernel.org/lkml/20231125191915.7f1f2dc4@jic23-huawei/

I'm probably misunderstanding something.
also, I hope v5 is flawless enough.

best regards,
peter

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

-- 
petre rodan
