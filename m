Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E84781CE9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 10:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjHTIRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 04:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjHTIRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 04:17:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EA55256
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 01:14:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so2990647a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 01:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692519262; x=1693124062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqhvlDCaT32nBwerKVVLb9gm6KKV/z2fg4KzrPjmR48=;
        b=nKgSqtI5Vd+yZlvv7DHVEwAfAfcEsiSvcALeNqCUKEvdHwfIetsyherVmWCrG6XgeQ
         PmRK3F3N1m36h4Q2eTmcU9b6qhxs2ClBdXIb/21QEzWBosK6W9Myus9L2way+dy2DgY/
         JzT6fK5NFEt58r6LjSuSRpMzY+rNJbM+7q26BEMYNKyDZcarZh9wtPYs+bhkPyOPtAKL
         Zu2G9laPnfRk71f/6VQnqsCAX/yJ3jDktXhwDHUyhBAyeyCb6vlYHtnijrmMrnujw+Pi
         IaBLsUgVGaktySrPWaeaFVbgtoRVyFr5WIHjdfdPWINaJqly4bvIpzdEIdNZ1AGNUVIO
         PqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692519262; x=1693124062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqhvlDCaT32nBwerKVVLb9gm6KKV/z2fg4KzrPjmR48=;
        b=fikmf8QY2pYSmDK9A3fqU4vgmNteTqi5JuXLE0EZQ0zwSImqrmcfvoyOO+OpCc6561
         csYI93bqUixH459eb0sUtTLhCBV0Rq/YyfZ+LZfK0JoQtZ+ms9UKde4EgSXYDAIyxyhu
         7aC1G6ahNaVWHqltXYrD5dE/dyolQ/GwsSnManYvxRqmgzSr31GqDeyj3GKFxElkorcA
         fFUQaDdjzxHCAu5kH9jcvjCmt9LtxiHn2BtPO1MDT7RuL7e7edFHD//NLiTWyKqKaENb
         kp4OnuBfvbdg5f0GEREjh+kGavXleveCaIz57uojeaDWAfyHOpCwsFuDApdCTeGJPsp5
         zX1A==
X-Gm-Message-State: AOJu0YxzrtzjPkTaUFaVWm56PrSOVpUT9UJnvuCxLszI+DRJASdvLjlp
        c/ur8500meFFjqInpQou32BIQQ==
X-Google-Smtp-Source: AGHT+IH3qX/o5kVuhEeAbBpTNfIfG6s8ru0yWyzfOK3EQkXBwlO3OlinFVs0XRSHipny6xGLNv4zzw==
X-Received: by 2002:aa7:d9cb:0:b0:526:9cf7:e0d5 with SMTP id v11-20020aa7d9cb000000b005269cf7e0d5mr2792551eds.12.1692519262213;
        Sun, 20 Aug 2023 01:14:22 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id q24-20020aa7cc18000000b0052567e6586bsm3901310edt.38.2023.08.20.01.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 01:14:21 -0700 (PDT)
Message-ID: <c9758ac5-489e-3fda-9ad2-020a9cc15a04@linaro.org>
Date:   Sun, 20 Aug 2023 10:14:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: trivial-devices: Remove the OV5642 entry
To:     Conor Dooley <conor@kernel.org>, Fabio Estevam <festevam@denx.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230801170015.40965-1-festevam@denx.de>
 <20230801-clobber-attempt-7033f92b3d08@spud>
 <8b0e048208220b2ae09eb1a3c52219b9@denx.de>
 <20230801-dividers-chooser-bd0df9b72d91@spud>
 <f9ab7525f048f3ce814d89f106947c34@denx.de>
 <20230801-selective-strife-b595804cdb27@spud>
 <deb6a4e60f37e9764d24e25b8a6d1d97@denx.de>
 <20230801-reconcile-preamble-8713b6b09ef5@spud>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230801-reconcile-preamble-8713b6b09ef5@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 23:57, Conor Dooley wrote:
> On Tue, Aug 01, 2023 at 06:43:58PM -0300, Fabio Estevam wrote:
>> Hi Conor,
>>
>> On 01/08/2023 18:28, Conor Dooley wrote:
>>
>>> I never said it was chief. Please re-read the quoted text.
>>
>> trivial-devices.yaml throws the following warning:
>>
>> imx6q-sabrelite.dtb: camera@42: 'clock-names', 'clocks', 'gp-gpios', 'port',
>> 'powerdown-gpios', 'reset-gpios' do not match any of the regexes:
>> 'pinctrl-[0-9]+'
>> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>>
>> Would it make sense to remove ovti,ov5642 from the trivial-devices bindings
>> as well as from the
>> following devicetrees?
> 
> I would rather that you documented it, rather than removed it, please.

Removal from DTS is rather discouraged, because DTS and these nodes
could be used in other systems. The best is to fully document the
device, regardless whether Linux supports it or not.

Dropping from trivial-devices could work, because it does not change
much for our schema - one warning goes to other warning...

Best regards,
Krzysztof

