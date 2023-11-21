Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BE27F385B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjKUVdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKUVdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:33:52 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA88FF4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:33:48 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-359d559766cso21902745ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700602428; x=1701207228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPztFbk4Qh4+TpFn00idAb8rtvrdHgK3UzVmP62xEfo=;
        b=e9kQc4bWz1eueHnQlEmAdcbVKNbmsum3vaUhqsDCHum7lipuIBzKN/i+H5TvQW/cI8
         oP7jJYIf3m4Qj4P50+XscS+SZrvVIk4ip8pxT3V8Yo7OAK5wZl+ZhFqU3fi0GKsB8JuM
         Pfcxi2k1OSpDsnd9j9jsSRuOQliTDD+HuFhd41enJqE/kQJ4ExWczscGlKhM5lLksgf6
         FcvS3M/pyU6ajayXYK05zImDssImJWbgB3RdhNqCATAN/qNtIVIfL5dk/vD/UPj4Rs6Z
         IAlISYeb0Dq3BIS2YlQni7E4TSoc17fqy1FOY5PiZfdd5bDSv4AXZZ3/6LE86tu4qN21
         Jhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700602428; x=1701207228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPztFbk4Qh4+TpFn00idAb8rtvrdHgK3UzVmP62xEfo=;
        b=FxDs2xJ9JoQN1XzpR95yU1NZcoGdAFBNPleQMO8qjCJrQJ/3+Uds+XX2FVMNg09frP
         Eboubkl8orqi7HmJMICGo2kDiwsREOujZfy3b96oyZm4wlIT01KTxVUbSVtDv5W0PGnJ
         787sK7DcIWthhLHrQm9J7UfqdbF+yhz+SIEZoov0lWyN4qFKKT5kdVwPDe9sFPyi5br5
         ybNItRLfvTWV2w9VDEokXGaB7gNy04503R4LwrFyuXPAdxRN1QQ4QNGCmZ3+vY5S1DUv
         mFrMsRsVRSLyACxZ5xatXl0yGzpe9Rg4Vlq699Eevwt65IWbMi2bqhBQeWltUwpSeG3J
         m/Gw==
X-Gm-Message-State: AOJu0Yw/Y2lhDmwh+G5drUdqMv0abCKa7voyHIp+26oBhae4hmirTlM1
        Gr5ZjCRQ/kfkxHdpXe//R68Xug==
X-Google-Smtp-Source: AGHT+IHKzUB89PXmzmxg0SBTE7Y7V3/XjTJPY5gtt8nLPa5ZqRByXXPMB3TdlqkpHQoScoPBVhoi2A==
X-Received: by 2002:a05:6e02:1d13:b0:359:c24b:9ee1 with SMTP id i19-20020a056e021d1300b00359c24b9ee1mr242798ila.14.1700602428216;
        Tue, 21 Nov 2023 13:33:48 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:9465:402f:4b0a:1116? ([2605:a601:adae:4500:9465:402f:4b0a:1116])
        by smtp.gmail.com with ESMTPSA id cn16-20020a056e02389000b00359c464b632sm3413438ilb.52.2023.11.21.13.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 13:33:47 -0800 (PST)
Message-ID: <c5c11a56-7aec-48ae-b3cb-ae72f2352c28@sifive.com>
Date:   Tue, 21 Nov 2023 15:33:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Correct type casting in module loading
Content-Language: en-US
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20231117-module_fixup-v1-0-62bb777f6825@rivosinc.com>
 <20231117-module_fixup-v1-2-62bb777f6825@rivosinc.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231117-module_fixup-v1-2-62bb777f6825@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-17 1:56 PM, Charlie Jenkins wrote:
> Make static variables static and use __le16.
> 
> Fixes: 8fd6c5142395 ("riscv: Add remaining module relocations")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/kernel/module.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>

