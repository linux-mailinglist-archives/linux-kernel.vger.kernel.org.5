Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2E579C73D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjILGzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjILGzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:55:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6956E77
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:55:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ad810be221so65109766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694501734; x=1695106534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3UdEjw89xtRW8XyxN513r2SYC0QheMnj/7RDlqM7y9k=;
        b=mwjOOI1Qf3DtBYG8/oMWgdQfTU2PgD8sUuYAeMrdUF7bX+t3OZl4Q0kGqSbJLwMUGu
         jILVc6UVYOFkyRn8vS7xDQEwKnWs4vo2gZzWrDyk9zvET65PKP+OxfOYS2L9Ouw1UB/T
         aBlPgVrxTVViVjYhSdod17q5EuF5ilWp35AJEuXTW4tVJA+qwSLmwKeeg2CiPR0Sbg1X
         H0DcGy5qMQSmA7hmzmvZRzcukzxnJR+8Z5imAR0gJysfL/CVpp/9muOuW+xSZdNVQoVR
         wkqxSSHizLFHF/Sv70FbnFV3MZ/aoKfHOl6Mr+q+2YCYAc4VSd817lOMFGNglMq4eCv3
         fRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694501734; x=1695106534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3UdEjw89xtRW8XyxN513r2SYC0QheMnj/7RDlqM7y9k=;
        b=cYeVa2nIZ/yXGiNk16WEQQ5U0K20JpIaO6K4gAizPcgScM8Q30cxErQc6m22io4HV6
         2IAKbQmPj5yW+lh4ZU+rIBRcZiqQhbuJFdJ14uBSNaRSODL9C6a73cBN9BMVrow4H0wz
         GLiTLtdNgS0LieUve0dhGIIJmYGDBFAPR5tg/H528AxIduEWxUnFFv03TjI1yfqXot/z
         6nuts1kuAM946yC+HvjcplPPhJuMbpGNRTul/0YKTRSvKmqY1PnepzrM3T5kipL3rExR
         P0ilU4kOebRCZkDwXSldXKUY6EPHDIen2kA11d3IJo4PSBJVFUZBWao/mwkgaBM+wDhO
         T9Cw==
X-Gm-Message-State: AOJu0Yx9oYdFFKoZWQsKzxkapVCaFMywBmXQUjWecPyVkqVqD10DJWRV
        PYMYwyttK69awnqX7Y9VrD7SBw==
X-Google-Smtp-Source: AGHT+IFcuy18lLCYg37sLw9dN4gufAkL/iLkcLMRlzH6Im91UhNina1XwBw8LssvrESeml35trGiUg==
X-Received: by 2002:a17:906:8a54:b0:9a1:e8c0:7e2e with SMTP id gx20-20020a1709068a5400b009a1e8c07e2emr9747485ejc.14.1694501734263;
        Mon, 11 Sep 2023 23:55:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709064a5600b00992ca779f42sm6377184ejv.97.2023.09.11.23.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 23:55:33 -0700 (PDT)
Message-ID: <42d4878a-4574-377e-e307-0dbef2354aa9@linaro.org>
Date:   Tue, 12 Sep 2023 08:55:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 8/8] dt-bindings: display: panel: add Fascontek
 FS035VG158 panel
Content-Language: en-US
To:     John Watts <contact@jookia.org>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230911090206.3121440-1-contact@jookia.org>
 <20230911090206.3121440-9-contact@jookia.org>
 <e22e61e7-02b1-8127-888d-e470838f4a18@linaro.org> <ZP7il27e9cExVWaL@titan>
 <c4d89d97-f8d4-da2e-dea9-6c054cf07eb3@linaro.org> <ZP9Eoh06Sirl_97l@titan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZP9Eoh06Sirl_97l@titan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 18:47, John Watts wrote:
> On Mon, Sep 11, 2023 at 01:49:39PM +0200, Krzysztof Kozlowski wrote:
>> If the other panel has exactly the same case, then yes, you can do like
>> this. But it depends on the bindings - to which ones do you refer as
>> your tmeplate?
> 
> Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t.yaml

The file is indeed serving as poor example.

Best regards,
Krzysztof

