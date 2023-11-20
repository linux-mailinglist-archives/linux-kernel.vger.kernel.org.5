Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DC37F1C00
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjKTSKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKTSJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:09:56 -0500
X-Greylist: delayed 16026 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Nov 2023 10:09:53 PST
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AA392;
        Mon, 20 Nov 2023 10:09:53 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id D1B3128EE6F;
        Mon, 20 Nov 2023 18:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1700503792;
        bh=LAFXLq3/2bPSJVSGrZJXAK3KfpKXjURErrX2KJDn7BQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ftbWuwQ/1BA0zapxaTXhWOtIhfDasAIA3YZy2Ar/iAlmFXXhrD2C1Te7dwvg4zsxl
         tNwwDpV6gnCszrwkLBA5jDyFwpLFuCWMjfnKkOFYPh9Nfj1Xl4ifyPDsIdnbmnyOS6
         DN3v8EHJITfQfDtRq4GburYlV99Kt0vbQefgXMPM=
Date:   Mon, 20 Nov 2023 20:09:50 +0200
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <ZVug7k9pJHksjOoz@sunspire>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117192305.17612-1-petre.rodan@subdimension.ro>
 <20231119134939.GA8784-robh@kernel.org>
 <ZVpswo3MSScT43Bo@sunspire>
 <20231120171903.GA2318732-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120171903.GA2318732-robh@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hello!

On Mon, Nov 20, 2023 at 10:19:03AM -0700, Rob Herring wrote:
> > first off, installed packages. the first 4 are not part of the 
> > official Gentoo repo, so I might have prepared them with missing 
> > options if any where not included by default.
> > I know nothing about python.
> > 
> > $ equery l dtschema pylibfdt ruamel-yaml yamllint jsonschema python 
[..]
> > [IP-] [  ] dev-python/jsonschema-4.19.1:0
> 
> 4.18 and later are not supported.
> 
> Apparently behavior we relied on in pre-4.18 was "wrong" usage... 4.18 
> also makes rust a hard dependency. That's a problem for any arch without 
> LLVM support.
> 
> Installing via pip will check this dependency.

I confirm that installing ver 4.17 of jsonschema fixed all the exceptions.

thanks.
peter

-- 
petre rodan
