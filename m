Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261FA784A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjHVTak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjHVTai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:30:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7743F10D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:30:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99cce6f7de2so661203166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692732635; x=1693337435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PiTP/RI45e8EfwrIe7RLSXEmq0rHur4HBZ7nN4+v1xg=;
        b=wZXMbA3VCSIlp2ExjJhWXkxhybOC2Jr5EiO3B9BIUuNMsTlnPTBEH1wJHmBHDLnWsY
         LdZhdmojjosNGKBWCHMEOO+8OuiTJjsA7kTFImNog2ZbH6AO2lai1WutJlraP4nfQnUb
         Z1ni5xIXI3yovMjhlzNSfnGRkufwraSLhB6VMrlt9NgGq8wfbZwNdsHqRtmWeBJauTLO
         GvypdQwJKg22HVxjnrc57/oXt4eLfGCis2HfV2g56dXRfDx7Buzf32Ukk+5dFmKarqcE
         sD++faPaO8DDr5qQ1u678wHSkGkWDhVVXZPyfsYNOLz9feoqn/jfo/hrqeCsbHB91GLE
         KRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732635; x=1693337435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiTP/RI45e8EfwrIe7RLSXEmq0rHur4HBZ7nN4+v1xg=;
        b=TpezRHP1LPWIDRgHMnZHbU4emDJF/wSFglu6P/9AzRxSn2yQLmWGqwxr6lIBFRhA89
         STr2Ewz0RGo9F/CoXRG1zoCCzuFGIIEMGgMw3+TwyOfROjBY6zSv/i/R6ZOTQgL2UPjS
         h8ZbCWcn80o07m8069DcajejTPTKyn8ntTLGnm/k/8xo95g0V8jfsNwqRW9KVRc2IIeK
         A/2IyCS+ptWSKkCZjiXs4RPK5+qkCytmI30Upm0nD1YvU88lvQwf8L15w0hK94GJIWpC
         FTgrR6bUulW8WsQROZc8Oy2isOFBHdK3s00Cgfg78xPSUBxc5sN1JSoiJCUMrgH5Kn6e
         qF3w==
X-Gm-Message-State: AOJu0Yz7So+4AjpCMWAIGhcNTD+RcWLjrEM90sgENtk5D4kMTsdpnhXA
        yAML48tMoCCmhUrw1BuyrpsC3A==
X-Google-Smtp-Source: AGHT+IHQnILBTb+i3Z2VnWNYiVEYRv6UUWWJMV9wl3Fp1TSArLq989ixRcaCrMjL0ry+Q8cXL5X3Lg==
X-Received: by 2002:a17:907:763b:b0:99c:ca27:c44c with SMTP id jy27-20020a170907763b00b0099cca27c44cmr7868302ejc.45.1692732634835;
        Tue, 22 Aug 2023 12:30:34 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id sa17-20020a170906edb100b00997d76981e0sm8626693ejb.208.2023.08.22.12.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 12:30:34 -0700 (PDT)
Message-ID: <fff772d3-a5c7-77c1-c372-22b2313ee622@linaro.org>
Date:   Tue, 22 Aug 2023 21:30:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2_1/3=5d_dt-bindings=3a_can=3a_xilinx=5fc?=
 =?UTF-8?B?YW46IEFkZCBFQ0MgcHJvcGVydHkg4oCYeGxueCxoYXMtZWNj4oCZ?=
To:     Srinivas Goud <srinivas.goud@amd.com>, wg@grandegger.com,
        mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de
Cc:     git@amd.com, michal.simek@amd.com, linux-can@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gcnu.goud@gmail.com
References: <1692701136-1422086-1-git-send-email-srinivas.goud@amd.com>
 <1692701136-1422086-2-git-send-email-srinivas.goud@amd.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1692701136-1422086-2-git-send-email-srinivas.goud@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 12:45, Srinivas Goud wrote:
> ECC feature added to Tx and Rx FIFO’s for Xilinx CAN Controller.
> Part of this feature configuration and counter registers added in
> IP for 1bit/2bit ECC errors.
> 
> xlnx,has-ecc is optional property and added to Xilinx CAN Controller
> node if ECC block enabled in the HW
> 

Second time the same mistake... and I spoke about this mistake twice:

1.
https://lore.kernel.org/all/78b104cd-15a2-63d8-bbce-0a5593e6a151@kernel.org/

2.
https://lore.kernel.org/all/aed1592f-927f-13ab-b692-7a0745ac5733@kernel.org/

I don't understand why this is so difficult... automation solves all the
problems, there is no manual work here. :/

Anyway, standard text:

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time, thus I will skip this patch entirely till you follow
the process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

Best regards,
Krzysztof

