Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4461A7CC828
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344221AbjJQPyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344254AbjJQPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:54:32 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CB9F0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:54:31 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a2874d2820so73235739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697558070; x=1698162870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4G1qT6aCa9jONcb1w7B7j7yaP96Lr1tt891SPK3dpg=;
        b=chRCl3o1+2k5CG6tVkPUCropXXw3FE9EvyMSGwePxTxY5YZTblKzHa0xj1YCboHX3S
         xiT18ybQzG/QF2QH1CSFBwJyvy8KU+w/kkh1Pag74QhbvvdUIpnLtx+J8Af74WWqlbHq
         s4RPimf+nAAZAWXWwZQvcBruax0pgs1g1oMb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558070; x=1698162870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4G1qT6aCa9jONcb1w7B7j7yaP96Lr1tt891SPK3dpg=;
        b=mfVXRlCzWoB2R3KvN/KGtqWFMyjEsCG+6lA4JR5uaar8cRFbMdg6iV9im5tual8g3W
         Fc9LbEgChSuF5KDzJj0NphUR0ZdoBxWpAGhhev64YeJB8b+iAOTAu64leIIZDenmkxkD
         XNZ1tRniQgvg4RH2fYwkn4unVHYXzWXLzSkNMPQ5IvfYlR1+2cU5/Fhp6zwDxBOM6xMA
         WaUC935AA8zkoHWW7Clg6ESoS+an/6rtUfX4u4gh9rl78PKsWVNCF4m9nDWmfYkqlm83
         wCzq/EUvHUNmieL3diFZlIOnywheNRTQOHN2SK+w0fI31fruOTjYGTT3dZUKc90VyEgH
         +hRQ==
X-Gm-Message-State: AOJu0YwIQeNQuauNW1qT3ejHldJpRNnI2KQSjKKj8EOU8IlSihZbIun6
        GVEgdblb7/3HoXmkk4P6JQ9BmA==
X-Google-Smtp-Source: AGHT+IE1gm5UPb4UgknT2djO05i1WKcZkMahvgNJZx0obMBFURyRnux/GWy/wHUc51MJlLYA/ThrrQ==
X-Received: by 2002:a05:6602:1513:b0:79f:a8c2:290d with SMTP id g19-20020a056602151300b0079fa8c2290dmr3370902iow.0.1697558070367;
        Tue, 17 Oct 2023 08:54:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id fj1-20020a056638634100b0042b4f9ddecasm597648jab.85.2023.10.17.08.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:54:30 -0700 (PDT)
Message-ID: <f1857ee6-1569-4a85-ba51-94c3d841cb61@linuxfoundation.org>
Date:   Tue, 17 Oct 2023 09:54:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:modify the incorrect print format
Content-Language: en-US
To:     zhujun2 <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20231017020856.7003-1-zhujun2@cmss.chinamobile.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231017020856.7003-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 20:08, zhujun2 wrote:
> when the argument type is 'unsigned int',printf '%u'
> in format string
> 

Please add how you found the problem to the commit log.

> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>

thanks,
-- Shuah

