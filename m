Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E56F7F9FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjK0MtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjK0MtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:49:04 -0500
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CDC10F;
        Mon, 27 Nov 2023 04:49:05 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id C373528EE6F;
        Mon, 27 Nov 2023 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1701089344;
        bh=cwI3GU5QJoO4WZeJ9HERDelXuedCeP382ih3gbwwNT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RAh260Gsp/50YvzL6LtuRInMnm75fhSYkHl26MnnD4o7eOLYSREw85VC5FCkcTXri
         KoHC/yP2VnrzoN4vv7m4pk+sM9XpEmDJ/CMEM88NNIcA7KUCUfuAQeobLvBynnd4ge
         gspr9WBW27T5ii76QZDVVh6L4IU3NsZoBq4/8zG0=
Date:   Mon, 27 Nov 2023 14:49:02 +0200
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <ZWSQPrExmcT5kPit@sunspire>
References: <20231126101443.13880-1-petre.rodan@subdimension.ro>
 <8641e35a-d481-4c27-b450-9ee72ae769b5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8641e35a-d481-4c27-b450-9ee72ae769b5@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 09:06:54AM +0100, Krzysztof Kozlowski wrote:
> On 26/11/2023 11:14, Petre Rodan wrote:
> > +  honeywell,pmin-pascal:
> > +    description: |
> > +      Minimum pressure value the sensor can measure in pascal.
> > +      To be specified only if honeywell,pressure-triplet is set to "NA".
> > +    $ref: /schemas/types.yaml#/definitions/int32
> > +
> > +  honeywell,pmax-pascal:
> > +    description: |
> > +      Maximum pressure value the sensor can measure in pascal.
> > +      To be specified only if honeywell,pressure-triplet is set to "NA".
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Sent a pull request:
> https://github.com/devicetree-org/dt-schema/pull/118
> Once it get merged, both $ref could be dropped.

thank your for the PR.

in patternProperties, please also add the int32 type for pascal.
your patch seems to cover kilopascal only.

cheers,
peter


> 
> Best regards,
> Krzysztof
> 

-- 
petre rodan
