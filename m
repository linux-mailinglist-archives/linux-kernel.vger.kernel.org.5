Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C574D760E19
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjGYJOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjGYJOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:14:02 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974D210B;
        Tue, 25 Jul 2023 02:14:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9a828c920so3071971fa.1;
        Tue, 25 Jul 2023 02:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690276439; x=1690881239;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k50PjHHC8jB6W4vBgG4q0OLqc5vNLtaWxOer+CJOr5I=;
        b=oOh8AmxPzllXfYyvHDz3uP9ElePy17FloEZ09jHJow15++Fw3Y+DmaNbgHY8vI9bgW
         7MvDZPTLPXcK426YhfP/rBd4vz58m3xrVCLWmLgh9x2hoLwbOMFCVjmYL3lhYv9EwMzY
         4YyX7lsvNoz/L/LFBpCAE6k0hULgcasxIL5oh1E6Itun3+SF6xzkK2rw9XrL808/pcaF
         gIrgOoCPGlNNlLmGljxAyjC1B/AQZxy7b79fqinEF/rHNfnOMxjjbsdyBY5xvnZoCa07
         PCsMJAy+gKE39yhrFA2Css1HgW5yUbfG26N/dc+oFP5L1rgSSZGJjmo6WIV29WeXmT32
         unWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690276439; x=1690881239;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k50PjHHC8jB6W4vBgG4q0OLqc5vNLtaWxOer+CJOr5I=;
        b=LEbmJCXjHgoGijhnFSdIoqv/mcQGyjS60BWafAFLBHMSflqR7YvwDA19IhVrsYMq1F
         hOOYYNqbE8I9TnPjMXC8e0MgggNYNQP9zTFhvkavSVUD6gjIZeiN/5G9U3yJmzhRlmFH
         lSuuIPrWVAefCg3Bmh3YlcgjpsSRm0qQsLRlXENyfpGeN5fHelIBM6FbEALbokN/phCs
         Hq+uDLV24uAb2/ePg20nlcfaWNwhT9E0o3K0Gzo787HKt2mAjSsLvpJXVVSTGUpq6m+G
         TyI/S4QvLCDAvn1UWzux+Dac63iv96ekoPZCCgyXDXtaPR3uyLgCpVKYLI+SHGpH0mHU
         ifrQ==
X-Gm-Message-State: ABy/qLboXHOj1c4nxfhirtth6qAMUXKYR1IPE2pTA/byQsmP6/SWwPrg
        D+tRZ4/L5Nm5ZLuJnnb8Hipm2Vwm74o=
X-Google-Smtp-Source: APBJJlFRhBgogkjQ5EjdDV2PagIbDi+voSoqo+9NzsIEDBI3GatqOk4a4NG6RM2KaQFgMCeJijGvtQ==
X-Received: by 2002:a2e:94c2:0:b0:2b6:a618:9f3b with SMTP id r2-20020a2e94c2000000b002b6a6189f3bmr7185757ljh.24.1690276439309;
        Tue, 25 Jul 2023 02:13:59 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.80.27])
        by smtp.gmail.com with ESMTPSA id g15-20020a2e9ccf000000b002b6e77e87fcsm3278667ljj.68.2023.07.25.02.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 02:13:58 -0700 (PDT)
Subject: Re: [PATCH net-next 1/2] r8152: adjust generic_ocp_write function
To:     Hayes Wang <hayeswang@realtek.com>, kuba@kernel.org,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, nic_swsd@realtek.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230725073051.5150-414-nic_swsd@realtek.com>
 <20230725073051.5150-415-nic_swsd@realtek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <7e0fc83c-1f22-e77f-7f2e-0fc031ec22ea@gmail.com>
Date:   Tue, 25 Jul 2023 12:13:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230725073051.5150-415-nic_swsd@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 10:30 AM, Hayes Wang wrote:

> Reduce the control transfer if all bytes of first or the last DWORD are
> writed.

   Written.

> The original method is to split the control transfer into three parts
> (the first DWORD, middle continuous data, and the last DWORD). However,
> they could be combined if whole bytes of the first DWORD or last DWORD
> are writed. That is, the first DWORD or the last DWORD could be combined

   Also here.

> with the middle continuous data, if the byte_en is 0xff.
> 
> Signed-off-by: Hayes Wang <hayeswang@realtek.com>
[...]

MBR, Sergey
