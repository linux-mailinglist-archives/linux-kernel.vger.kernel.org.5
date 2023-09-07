Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09516797AD2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245519AbjIGRuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239531AbjIGRuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:50:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3661FF9;
        Thu,  7 Sep 2023 10:49:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5007f3d3235so2047198e87.2;
        Thu, 07 Sep 2023 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694108957; x=1694713757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukwWb4lAr/3M8hE9KXN4tPWduEYh1NIPGybMurdhdDs=;
        b=qsRWpcCS5N8Rz+HEwqZslRyOAj5prWejgUrBOtImOu4TKYFJxv3dkbQHu7+9MEVGSe
         uqOcPSnE2iaRzXvhdUF+uINntol4+D8FixkAO9MyETDDkODcTep8YQb4eSk3ONO4vt3p
         XuHEfSMnzctnTahj9AxbhNhBYV8OP4kljDa1xPcce5o6mgYEdsa+HOs59XMt+WfEON9G
         w7k6gPA1yha5Gi24K5072mVcZzgShFyxVnOINXzzSmSoZvCogS+n187MPQPwhtAXWIOW
         dOA28ba0uLLIInQk0gqwsNAee9J0zlILhucMF0E0rxRMUqqTAyeQ5aC98h7861uWg6zL
         1HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694108957; x=1694713757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukwWb4lAr/3M8hE9KXN4tPWduEYh1NIPGybMurdhdDs=;
        b=iIgrEaRSNEZAu/Gb+HyUSBG8ZENfCGpQ/g/Ilj17qmv3zOUuZQDGajAr7N60vCyst8
         slJfm8tQskC56g98lI6JekmgdSbC74js2FVSKhOLyeV26Qq+au2ngvKgo9iS/2ttd0T8
         uCkRZ6ZdIgV3wmA1VHDwgrMiLulawVpMXVMcfK8cyuDt09AsVLQPsDd+OXKC6oEvIk+b
         8/a5uEgHeXJQH5JeEls1mOqnnAWE6A1YEo33NWCrm0NKKHbYQ5Hjc820vjndWanTms86
         BmeHluYaoJyjU4/vZHQPB0sJojRLKxXJ+aIWe9/OMv40dEhl3yoKO8ElqT0yhh2w4lXJ
         ++oQ==
X-Gm-Message-State: AOJu0Yxv7QhD76FutZ1qrj43KfpcJCPZvc8ebTGKegHohxmtKFivXgvt
        WiZ96n5B+g5QJ19hLFI4fzJa5TUwtExCiQ==
X-Google-Smtp-Source: AGHT+IHzD3+7U/HMiG0HNnmS8wQfLyYxkOxPsIA17E+zzuw8hfcSZKf9zcGA32rVbqmD7IIsU/pYUQ==
X-Received: by 2002:a17:907:2cec:b0:9a2:292d:ea60 with SMTP id hz12-20020a1709072cec00b009a2292dea60mr4229274ejc.40.1694069805206;
        Wed, 06 Sep 2023 23:56:45 -0700 (PDT)
Received: from [192.168.10.127] (net-188-216-175-96.cust.vodafonedsl.it. [188.216.175.96])
        by smtp.gmail.com with ESMTPSA id qw14-20020a170906fcae00b0099b7276235esm10092169ejb.93.2023.09.06.23.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 23:56:44 -0700 (PDT)
Message-ID: <51c98bc8-b9df-4cd8-adf8-55c1f2790b08@gmail.com>
Date:   Thu, 7 Sep 2023 08:56:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression with AX88179A: can't manually set MAC address anymore
Content-Language: en-US, it-IT
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, netdev@vger.kernel.org,
        Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Oliver Neukum <oliver@neukum.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <54cb50af-b8e7-397b-ff7e-f6933b01a4b9@gmail.com>
 <ZPcfsd_QcJwQq0dK@debian.me> <6315027e-d1ab-4dec-acf2-0a77bb948807@gmail.com>
 <ZPfZQsLKG9LKGR1G@debian.me> <075308b2-7768-40b2-9c00-a5a14df62678@gmail.com>
 <d6777bc1-46ad-4ad9-a7e3-655dbe4f6317@lunn.ch>
From:   Sergio Callegari <sergio.callegari@gmail.com>
In-Reply-To: <d6777bc1-46ad-4ad9-a7e3-655dbe4f6317@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the time being having AX88179A error out on attempts to set an 
hardware address would possibly be useful, though.

Sergio

On 06/09/2023 14:31, Andrew Lunn wrote:
>> So if the in-tree driver could be fixed to correctly support the manual
>> configuration of the hardware (MAC) address as it used to be that would be
>> the best. I hope that Andrew Lunn's hypothesis is correct, and that cdc_ncm
>> can be extended to work with AX88179A even when a manual MAC addr is
>> configured.
> I think it can, but it looks like it needs a different
> implementation. The CDC NCM standard is publicly available. It
> documents an optional call to set the MAC address, and there appears
> to be a capability bit to indicate if its implemented in a specific
> device. Ideally if the bit is not set -EOPNOTSUPP should be returned
> when trying to set the MAC address, otherwise make the call to let the
> hardware know of the new MAC address.
>
> Sorry, i don't have the time or the hardware to actually implement
> this. But i can review patches and help with processes.
>
>        Andrew
>
> 	
