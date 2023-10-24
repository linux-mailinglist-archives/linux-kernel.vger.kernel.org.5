Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E56A7D44E3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjJXBXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjJXBXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:23:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6FED7E;
        Mon, 23 Oct 2023 18:23:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso3107221b3a.3;
        Mon, 23 Oct 2023 18:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698110621; x=1698715421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vxT89Onvy9DgpB3EuvxkaurRVz8Aot2j7wpkVZCSt1E=;
        b=Z7z1j180M1vciAOJzt1MjDG87GJJUUQlGoiW9ewGYRj5yTdxTIMvtqVlR35477xvfU
         J+KuwuDV7EkgHz7WPjTTHT2yVZzw0B4Zc1HTOpMsrU+/r/yPshvJILK0kVrlD5mpaSsq
         DdkVglnabh+tIKRjJltwRswyASBk0/nbNu6BiSvNM5MpM3DX94k1bhsLiU+hPolPyfcc
         CkVoFS1SiX7c3eJ6aNdzjBlnyONg5L8L7PbQ+fVaTOne5dmvWdsXVh8TjnvYXaSD1Icd
         qG6qu5xIidkU7jOUa3V1n/p8PGsw0q1+MjkbKkvqFxMyLQjkAoZwegZWM99OsQCCS3/B
         mEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698110621; x=1698715421;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vxT89Onvy9DgpB3EuvxkaurRVz8Aot2j7wpkVZCSt1E=;
        b=bRQ+nDF2ozQBcU9clrqdQ7A+5YfxP97jm9UsLouUtRW+tnrNXQowdeJcxP0NlEB1Bq
         Jzxj473SKkKywBmKmbuUt+cMT7dLij1i9yZwlPZF0Yk6ODj7gLAyEkfHoVrXmRFX6eO2
         Zf5gGPapHjwYnExrtieon8DDhFmKKCFAxAX8JW8snd1kQoztfJFeQjjylj9P4T8gCOPP
         5PcT0KHP3Y2BDAU8/pyLzBlRZERy/CALOFcLb0G8Cxukz8MqX2q0wTi+IdB32U+FeTs0
         U3EiS19S8+KBQymt7EqfY3FsPHx6bxfK8X/7o6yykGh+/sK4LEwLecnlPKFi9yLbxMCE
         KEUA==
X-Gm-Message-State: AOJu0YxPusFy1aoAAddeYUie2QUkFFVXH12zGoOdzJsw0yfpoU1R1YQV
        6F9ZelqYTnrL4+luMplxpE0=
X-Google-Smtp-Source: AGHT+IFyJTrr1k8dZgbHJbUjxTyylZZqBW+c/o9YmZ+W14ir0mKK4KPFD4NZmMqtEEzuV1417gw7Ww==
X-Received: by 2002:a05:6a00:114f:b0:693:3cac:7897 with SMTP id b15-20020a056a00114f00b006933cac7897mr7872482pfm.9.1698110620939;
        Mon, 23 Oct 2023 18:23:40 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79d03000000b006bc3e8f58besm6757110pfp.56.2023.10.23.18.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 18:23:40 -0700 (PDT)
Message-ID: <2f12beb1-ff94-4806-8ed7-e78eb8474a7d@gmail.com>
Date:   Mon, 23 Oct 2023 18:23:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] r8152: Increase USB control msg timeout to 5000ms
 as per spec
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20231020210751.3415723-1-dianders@chromium.org>
 <20231020140655.v5.1.I6e4fb5ae61b4c6ab32058cb12228fd5bd32da676@changeid>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231020140655.v5.1.I6e4fb5ae61b4c6ab32058cb12228fd5bd32da676@changeid>
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



On 10/20/2023 2:06 PM, Douglas Anderson wrote:
> According to the comment next to USB_CTRL_GET_TIMEOUT and
> USB_CTRL_SET_TIMEOUT, although sending/receiving control messages is
> usually quite fast, the spec allows them to take up to 5 seconds.
> Let's increase the timeout in the Realtek driver from 500ms to 5000ms
> (using the #defines) to account for this.
> 
> This is not just a theoretical change. The need for the longer timeout
> was seen in testing. Specifically, if you drop a sc7180-trogdor based
> Chromebook into the kdb debugger and then "go" again after sitting in
> the debugger for a while, the next USB control message takes a long
> time. Out of ~40 tests the slowest USB control message was 4.5
> seconds.
> 
> While dropping into kdb is not exactly an end-user scenario, the above
> is similar to what could happen due to an temporary interrupt storm,
> what could happen if there was a host controller (HW or SW) issue, or
> what could happen if the Realtek device got into a confused state and
> needed time to recover.
> 
> This change is fairly critical since the r8152 driver in Linux doesn't
> expect register reads/writes (which are backed by USB control
> messages) to fail.
> 
> Fixes: ac718b69301c ("net/usb: new driver for RTL8152")
> Suggested-by: Hayes Wang <hayeswang@realtek.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
