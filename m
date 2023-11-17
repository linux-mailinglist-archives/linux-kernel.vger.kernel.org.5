Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E037EF6C6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346123AbjKQRMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjKQRMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:12:36 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032A1D68;
        Fri, 17 Nov 2023 09:12:32 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1f4a9dd83d6so1173112fac.0;
        Fri, 17 Nov 2023 09:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700241151; x=1700845951;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OHpWF40Psue4iYs7GDYLAb9ynetukRiq2wSf871YtEA=;
        b=a5nfUQNqdjWF+dQF3aI3J07tpqynVC7lcScd1NASWIE7u6ObaTb+wfCBpiefDNH8hA
         AhnA/b/CvfvabbPDMIIIBhF54WV91Mo3VKlpLjJsxrCXI+5PsIjB7QcdqzZWz2fy4QMG
         saAPBLnYWzcD13jUogw0tBTmz3cF0PySgkh4imEiogvvqWIAZNvkI14eXyfQFxu2bF8Y
         v5sygqSCBiCXcI1p6SuXGdjgY+Mj5kABTcZ+P4P3iHyHxigabJvHu91G/O6H7qTGlASp
         hNloh4PitzX8otCPmVlbwAK9pg4KdshaHLRINZryol1/sVyuSI/HiMqswQJFYTKDwyn4
         2oXw==
X-Gm-Message-State: AOJu0Yx/s2Gdfd0SZYgqD5287CmwSqSXt5O2BBb4ch2GkeghrGFr6YPB
        On7cb9fIL8SOH/f8uXzm1g==
X-Google-Smtp-Source: AGHT+IH/jdv4qSls6Kn12V0R5hrDl3D2yOUemeSlHsRbA2tNpgaFL/KXLQJ0LwQCyex0rsjc6sEJhw==
X-Received: by 2002:a05:6870:5cc6:b0:1f5:acc6:ae75 with SMTP id et6-20020a0568705cc600b001f5acc6ae75mr2548489oab.28.1700241151062;
        Fri, 17 Nov 2023 09:12:31 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p21-20020a056830339500b006ce2bb62ffasm296154ott.63.2023.11.17.09.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 09:12:30 -0800 (PST)
Received: (nullmailer pid 1847521 invoked by uid 1000);
        Fri, 17 Nov 2023 17:12:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20231117164232.8474-1-petre.rodan@subdimension.ro>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
Message-Id: <170024114927.1847041.4761687599216072885.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Date:   Fri, 17 Nov 2023 11:12:29 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Nov 2023 18:42:05 +0200, Petre Rodan wrote:
> Adds binding for digital Honeywell TruStability HSC and SSC series
> pressure and temperature sensors.
> 
> Datasheet:
>  [HSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
>  [SSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
>  .../iio/pressure/honeywell,hsc030pa.yaml     | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,hsc0030pa.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:60:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:60:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:60:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:60:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:60:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:60:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:60:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:61:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:61:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:61:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:61:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:61:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:61:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:61:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:62:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:62:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:62:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:62:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:62:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:62:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:62:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:63:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:63:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:63:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:63:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:63:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:63:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:63:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:64:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:64:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:64:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:64:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:64:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:64:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:64:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:65:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:65:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:65:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:65:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:65:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:65:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:65:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:66:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:66:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:66:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:66:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:66:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:66:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:66:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:67:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:67:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:67:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:67:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:67:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:67:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:67:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:68:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:68:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:68:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:68:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:68:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:68:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:68:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:69:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:69:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:69:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:69:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:69:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:69:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:69:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:70:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:70:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:70:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:70:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:70:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:70:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:70:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:71:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:71:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:71:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:71:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:71:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:71:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:71:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:72:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:72:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:72:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:72:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:72:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:72:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:72:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:73:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:73:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:73:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:73:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:73:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:73:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:73:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:74:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:74:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:74:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:74:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:74:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:74:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:74:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:75:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:75:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:75:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:75:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:75:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:75:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:75:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:76:13: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:76:22: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:76:31: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:76:40: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:76:49: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:76:58: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:76:67: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:130:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.example.dts'
Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:130:1: found a tab character where an indentation space is expected
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml:130:1: found a tab character where an indentation space is expected
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231117164232.8474-1-petre.rodan@subdimension.ro

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

