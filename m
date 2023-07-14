Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C18753BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbjGNNf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjGNNfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:35:47 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42F030FF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:35:43 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77acb04309dso77296439f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689341743; x=1691933743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrrlpET1J++D0rWn+MEFzbX9FlSrTXFzI92fTxQjI5s=;
        b=mwlleTSR8yEy1PaS939rfY4GuBWcXyWA0t8fIi9rgz1Pxwi/AZM6vk8gypg4p5WTzN
         3l7l9N0d2tmi5avur0AIPBn2UGUs0QwvXlI0WKiDqpNWGNJ/AuIXhmjcfFnulgwYWBAA
         X+49Py+hY3mt+d74cTdPjb5XxMIDZJ0xJyxvcIPsfmzc3pIpDwiuVUjUPq/9aBdv2sNL
         QoI+5pQVpxo8l97IjqVAlNtXgafrbO+bUDvXxazPH9RnXtHMpi/JyiZD99DxSTx/OM2q
         aPAjXC4cLsATkJFzSo6W+NX6Z7Gy4rEUMpn2BfcMY5Vc6ahqzi+2o9ykaVuui1QUJkr6
         nvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689341743; x=1691933743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OrrlpET1J++D0rWn+MEFzbX9FlSrTXFzI92fTxQjI5s=;
        b=MMLUu4FvXFQNfjE/pchKlpV486uazpWvhFjFXwcsCEQQ7uDjAYL4lKQpDRq4rtwd1w
         MxvCoFVd6Dck2JexgvMpiuG9P9LnhjXF+w68Vv0d8A277+80MzdN+9zmpGIoHac5Pu+j
         tEk4LSBIFn+SfD3BCuT6gj/MshTphNMwZocFYc/ICSzDd4p2pLiat/Mrf6Z37XuRp+Bi
         P/4NACkCGifdg9OzhQQqtRcj0/s0RNIike/6D7ohJIHiPSA4XfhVv8AffLd5t/75v5Iy
         AmKQsyicbaOEtiwNL7+yzJ4zoGYNQf4efCb9Mdnq/GqIgPhZ1sVi78yDL/MUCKMRdr/n
         RryQ==
X-Gm-Message-State: ABy/qLbisElFLgkna07lsEZoB5/kVqzXKDta6gru3lf3eExSAhtO94AE
        8DsOYfnc9nxHbKVLfifbAkizBA==
X-Google-Smtp-Source: APBJJlEoST73Soh2t45u8KhAHwB+dZMgEFJ5zGII3htqmtNMTdG4c4gXQU4m3cr5Uaw+nkupDpxMlA==
X-Received: by 2002:a6b:3c0c:0:b0:785:ff35:f340 with SMTP id k12-20020a6b3c0c000000b00785ff35f340mr4830684iob.14.1689341743082;
        Fri, 14 Jul 2023 06:35:43 -0700 (PDT)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id v6-20020a6b5b06000000b007870289f4fdsm2623774ioh.51.2023.07.14.06.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 06:35:42 -0700 (PDT)
Message-ID: <c3a8bb16-7016-c3d6-1cf9-0e56535e51e2@linaro.org>
Date:   Fri, 14 Jul 2023 08:35:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 01/25] docs: gunyah: Introduce Gunyah Hypervisor
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-2-quic_eberman@quicinc.com>
 <cb1d4b05-26f3-22f5-ce8e-813d255cda8a@linaro.org>
 <5dc7438c-e161-915c-c037-19c5099a274f@quicinc.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <5dc7438c-e161-915c-c037-19c5099a274f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 5:41 PM, Elliot Berman wrote:
>> If it's signaled after every message is sent, does it
>> indicate that the message has been *received* by VM_B
>> (versus just received and copied by Gunyah)?
>>
> 
> To connect some dots: the Tx vIRQ is fired when the reader reads a 
> message and the number of messages still in the queue decrements to the 
> "not full" threshold.
> 
> https://github.com/quic/gunyah-hypervisor/blob/3d4014404993939f898018cfb1935c2d9bfc2830/hyp/ipc/msgqueue/src/msgqueue_common.c#L142-L148

So the Tx vIRQ on the sender is only fired when the state of the
receiver's Rx queue goes from "full" to "not full".

Normally there is no signal sent, and a sender sends messages
until it gets a "queue full" flag back from a gh_msgq_send()
call.  At that point it should stop sending, until the Tx vIRQ
fires to indicate the receiver queue has "room" (fewer than
the "full threshold" messages are consumed).

There is no way (at this layer of the protocol) to tell whether
a given message has been *received*, only that it has been *sent*
(meaning the hypervisor has accepted it).  And Gunyah provides
reliable delivery (each message received in send order, exactly
once).

Now that I re-read what you said it makes sense and I guess I
just misunderstood.  There *might* be a way to reword slightly
to prevent any misinterpretation.

Thanks.

					-Alex
