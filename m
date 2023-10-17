Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AB47CCE41
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344415AbjJQUiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJQUh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:37:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F79F92;
        Tue, 17 Oct 2023 13:37:58 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so4611671b3a.2;
        Tue, 17 Oct 2023 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697575077; x=1698179877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZ2a6tNJgTU4AkoYKYfOIirQpXzOINntlEjkMndT800=;
        b=nWq6OG3WDFlFqxoiLXkdyUFtzuRjZdtqVEOvIg6FUqL2mZ+B+A66pwDOU+3FKe1Nac
         sh7JYOLxRgIVchqmcT8PPbY3d7eNuG1F2zvH8EuVyGkctKL/aAzvQrj15MmI6ByY5Xhd
         VoE2gvuS0MwsHSQWfOLiMgv+/Bok3we/CRiFfilV7m1+ZBpl4FhqzLcBPOqkehiGkdLN
         nlLgZ/X8c/OBb/ZYUvFkCEAkggyv5baV9IUUuk/yiIcfFCiq71hvzm+m52BAb3LLohJn
         9j08toAASc8dSAKNU+yM2ZlLY7QCvOPwxOXJe+jjbx2sU+WPypj6NeMCGcmAInaVJTtp
         CrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575077; x=1698179877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZ2a6tNJgTU4AkoYKYfOIirQpXzOINntlEjkMndT800=;
        b=rI/l1+Vz6mn8WgZ3+pZH97RICJXDSpG4H03zRb+3r/wFS8zGJEb719EKUlOIBWM1JC
         17Bi/OXF0zhKT9URQ6wLO55Uh1ZLRzR8tAizvta3IG7xvmEJf/1zcnB2xXauMR0L5ONG
         qW8fq+pKf58PpxqcPTHMIqM2dUJNdY6S03IQZnLZ/eOhRq7B62XbBs94DJsv8ktC93UI
         R65rapcpaf2EH62H5jEAkx/sHyy3Min4PVKPq4l5rQMBFwNbgurTYue1o+xQ2n87nhsg
         f026DanyUZ8auwbu+z6jqNg//Ao6E0OZ2v7W2TInD+oylFPyYb/qFo7byAZn/OXoGjCY
         Zt1A==
X-Gm-Message-State: AOJu0YyajBUCKauBE8QPm8c5isPuUBnDmH+dm7gNujtyOdTPPWQgIiOI
        b30lgpLz5ysmV+RoppHLompVJ3zIsOk=
X-Google-Smtp-Source: AGHT+IECp6vzBRngeu9PWxuVOIHtb1lzIfP8EQqwc89jzUl5VreKhGITFG1vv0HPFdOo8fQW3O/wIQ==
X-Received: by 2002:a05:6a20:7352:b0:131:a21:9f96 with SMTP id v18-20020a056a20735200b001310a219f96mr3622784pzc.6.1697575077321;
        Tue, 17 Oct 2023 13:37:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id pq5-20020a17090b3d8500b0027d015c365csm6935034pjb.31.2023.10.17.13.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 13:37:56 -0700 (PDT)
Message-ID: <2b6b347d-ff28-4c4d-9eae-d0d9a83d572a@gmail.com>
Date:   Tue, 17 Oct 2023 13:37:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: bcm7xxx: Add missing 16nm EPHY statistics
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernek.org, Justin Chen <justin.chen@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:BROADCOM ETHERNET PHY DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231016184428.311983-1-florian.fainelli@broadcom.com>
 <20231017194524.GA1940501@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231017194524.GA1940501@kernel.org>
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

On 10/17/23 12:45, Simon Horman wrote:
> On Mon, Oct 16, 2023 at 11:44:28AM -0700, Florian Fainelli wrote:
>> The .probe() function would allocate the necessary space and ensure that
>> the library call sizes the nunber of statistics but the callbacks
>> necessary to fetch the name and values were not wired up.
>>
>> Reported-by: Justin Chen <justin.chen@broadcom.com>
>> Fixes: 1b89b3dce34c ("net: phy: bcm7xxx: Add EPHY entry for 72165")
> 
> Should the fixes tag be as follows?
> 
> Fixes: f68d08c437f9 ("net: phy: bcm7xxx: Add EPHY entry for 72165")

Yes it should, it looks like 1b89b3dce34c was from our downstream tree. 
Let me re-submit with the correct Fixes tag then, thanks Simon!
-- 
Florian

