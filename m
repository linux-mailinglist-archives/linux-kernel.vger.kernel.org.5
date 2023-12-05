Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1124E805E4E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345412AbjLETFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLETFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:05:10 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019D6B0;
        Tue,  5 Dec 2023 11:05:17 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-28648be0811so4404568a91.0;
        Tue, 05 Dec 2023 11:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701803116; x=1702407916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/YpRo6JOF2d6j3rPa12X0C68slW+v5pjWgqMK6QLn2s=;
        b=WuhUwi7Cpru+ci+F9IfpM6qU8noYAplWFUnvgkWIAQZ5sGvkW6EN3h/FihiNRCRfct
         jwv8KvfnGUugfiXR7q/qZ07OpBiLuUHNpLqkCllUY6kFP79DPfE36wm++/drxxJDIj9S
         OakPd//ScV6xh+oAPJuqFeLMLF/nDBlBuarm/IUDPsomw6g9X+ckA01eRV0OFtkE9iMt
         nGOBOqsGG6NwumbeBvBZvnbcNegl+iBph0Q96k6SeoiqRJouEoyQm/nI0UO5qwIY8LD+
         tjBVFLvwPx5gQSZZEM+60U38qmPgouuAnNaMfCdtaTB1NC/+6dGecLFyqLLYmRFQrg9Q
         lTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701803116; x=1702407916;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YpRo6JOF2d6j3rPa12X0C68slW+v5pjWgqMK6QLn2s=;
        b=GBZQrNwAoGmeQj10Cksohglt5NA59cB81MC3739UCq/3KQezh9bvdj//XNm8VhCoxl
         I73fGRg4upQg0WZDgZW6SNsPAnMnBJ0rDFNI/WrzTysycSInY5QbJsku2fqjVWyPh9Gr
         ZJ9SVaCLzRDc0HASeJHH54IDKfF7XYp+Tf5sADXB5FaBWpjRpWW3Ol/liTigzFRb+5mh
         PrtynzfEGHikuDFZJuQLtMsnvbh8Ya1JT3zK7kOohSRNGIojhZVKE9WF5L2PkEuGsv9W
         XjA14n+H5DKYgomWLKAGQLIKSQVMRYFxBr/IyYLQzK+WnYQ1YJ+Bhl9Ik9lLIuXQaeu1
         zhYw==
X-Gm-Message-State: AOJu0Ywlhuu7nMR5doHYRC139hQZZIxxngyhLP6yfQkZxCes0QfjYA/n
        kU8qsH9WM4UL/JEi8SFIugCRaJeljCQ=
X-Google-Smtp-Source: AGHT+IF3mB1DJWrQGKXFFEpF3BoVcs2vfq0HnTFIh6mMi6cg+C7zNqoF/5zHpRyx20VScDk5ws1uJg==
X-Received: by 2002:a17:90a:f28b:b0:286:295a:b33a with SMTP id fs11-20020a17090af28b00b00286295ab33amr1446687pjb.8.1701803115469;
        Tue, 05 Dec 2023 11:05:15 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gb2-20020a17090b060200b00286c1a13ed9sm3110511pjb.56.2023.12.05.11.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 11:05:14 -0800 (PST)
Message-ID: <fee61230-58f9-45d5-b435-e3f76f4993e4@gmail.com>
Date:   Tue, 5 Dec 2023 11:05:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] memory: brcmstb_dpfe: introduce version-specific
 compatible strings
Content-Language: en-US
To:     Markus Mayer <mmayer@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231205184741.3092376-1-mmayer@broadcom.com>
 <20231205184741.3092376-3-mmayer@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231205184741.3092376-3-mmayer@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 10:47, Markus Mayer wrote:
> Introduce compatible strings brcm,dpfe-cpu-v1 through brcm,dpfe-cpu-v3
> to the Broadcom DPFE driver.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

