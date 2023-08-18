Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB73D780A45
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376322AbjHRKfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376536AbjHRKeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:34:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D024C3A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:33:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5236c9ff275so958553a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692354822; x=1692959622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6EQXmWlbAP8xGzA5SqpcYw1xup/7LEAqhVr+3MCg0w=;
        b=GB07Z6G/G0+fjW+eJK9+aXtCaNKh1tmDFClnHoQGt90vR72x+qxWrZ+8LYKyIbiBlJ
         /FC/3aFNqETNRfIQqA/VEKo2HZyp8fh5QXSgehRZIrOiQy8dqJGjNPVDV3loRkPWc8WD
         yCVDlKK4anE56FymK6EesEs4UQ7cGpPbCOIfvS4UBmXCHrSA+DrHvNGOltGk/gxAQ44u
         mv8c3d5Io2cuNQV8Jht7D5q8lSALmsqzUykwckx7lsLnw3N0ICJQ3gqtkUezytwqaCka
         +c43beXWL3ZxH9ahcT2WflY6AIVBvpEEGrHgksDFRpeH1xOpNy7Mx8ewllDL3OSGo7/Q
         qB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692354822; x=1692959622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6EQXmWlbAP8xGzA5SqpcYw1xup/7LEAqhVr+3MCg0w=;
        b=YlPkCWOPx72ZvaZ8pR2nzMPXQUasL0LiiP0uQ18V/u2rTFp5cldJfJ32YDomFs9AKB
         he3ODzhGKqhdrXYJTve/ZctIVr67n4zNKs8Kixo85hOba3FhL+FQRiwfeZYTmhXhLQfw
         APP3AoMXUaUvdo5rH8uck0Z54ULfC4Z8cx/zZhUDkfXDEtH85VryZQoT4oXOXzhgB4Y0
         YjeIFntyh9BjU/uqs3qtYH7dyeHbqPjHujbOriPlFaqxewjM3W9CiWgNDj/PqfjMHdf+
         oT/Y8KXtcS6lUGPZMxMEjGRedFx10H7vb0IcFsZx527c/jgwpolcYlQkcHZmWltsmeY3
         kB6A==
X-Gm-Message-State: AOJu0Yw7wqMbi3sFZBqsx5SGi8RS7PzVJWOmDa1ojn/ZVxhyrUkZo1El
        NnyleXRSZwxgK62I5bTQnkWm0Q==
X-Google-Smtp-Source: AGHT+IG63pVTdWE6Rqr+M8TcAltplCPu5q2+b9QCNW4PgQwhl1RSBnJMIcWD2yodknH0su3SWujtRw==
X-Received: by 2002:a17:907:60c7:b0:99c:440b:a46a with SMTP id hv7-20020a17090760c700b0099c440ba46amr1386439ejc.1.1692354821787;
        Fri, 18 Aug 2023 03:33:41 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id g17-20020a1709061c9100b0099b5a71b0bfsm1028327ejh.94.2023.08.18.03.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 03:33:41 -0700 (PDT)
Message-ID: <a3b74f31-905d-8b57-5e38-7f1efe37f554@linaro.org>
Date:   Fri, 18 Aug 2023 12:33:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 02/17] dt-bindings: gpu: Add Imagination Technologies
 PowerVR GPU
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sarah Walker <sarah.walker@imgtec.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, matthew.brost@intel.com,
        luben.tuikov@amd.com, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, mripard@kernel.org, afd@ti.com,
        boris.brezillon@collabora.com, dakr@redhat.com,
        donald.robson@imgtec.com, hns@goldelico.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
References: <20230816082531.164695-1-sarah.walker@imgtec.com>
 <20230816082531.164695-3-sarah.walker@imgtec.com>
 <CACRpkda-XnS-DQE-5WXnTFdycwVnJwffhhR=V27gp8vnxkHTrA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACRpkda-XnS-DQE-5WXnTFdycwVnJwffhhR=V27gp8vnxkHTrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 11:36, Linus Walleij wrote:
> Hi Sarah,
> 
> thanks for your patch!
> 
> Patches adding device tree bindings need to be CC:ed to
> devicetree@vger.kernel.org
> and the DT binding maintainers, I have added it for now.
> 

This won't help, I think. Patch will not be tested.

I was already asking for using get_maintainers in the past... sigh...

Best regards,
Krzysztof

