Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AFE7CF6AD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345341AbjJSL0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjJSL0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:26:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D863AB;
        Thu, 19 Oct 2023 04:26:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4084095722aso11173035e9.1;
        Thu, 19 Oct 2023 04:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697714769; x=1698319569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tE6Dmhyrf6sQCO/pjOIcR9deUN5mIuUSHx3zKYZfWXY=;
        b=AjUBkLGoxZoIjhEGMen8YSecWKYjZKChiHWT3vr7dFAFkZi+jfo7thCEFcrdkzhJt1
         yXCMLXHw8yroL1m2glKp1HkY8EFlBC1cSVBJhMuekcHtHHm1cSMqBJ9fXfcVFm9vGPNU
         fHH43AXvXzPid2h3zS9kh4MRJSMNUz5uwJet7QfQvbEf5H9EeNYDHTyiTJ7wr5I9RWcD
         p3lu4Lw3jLOllZWI0v35PYE/R8B3hVz0tj7KmHTqzs/Q2OUEoWASQ46zAYuCwn2II64W
         jeHTfPAwyjxO6CJBNh+/M/EOWG7u2M1xacUOS5bOI4UesuGdpD4M8OatJbwUNfDWjucr
         0wFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714769; x=1698319569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tE6Dmhyrf6sQCO/pjOIcR9deUN5mIuUSHx3zKYZfWXY=;
        b=PAHTNqUlwURcLMDqKzKCGX2A15a10PKiUncO5U+ZXhJ1gXo8vjnZONjEeN0+A+0vJx
         aw/pWQjSd3T1zX7O1EM5alow7x62o1NSDlPa7PhRCmVz8S76LEld9XasjBJBtEI6qe69
         Ri911ZHGJKAK7jxyhURsu8+xMqQEnqamUirW7Z1xI31E0Xx0ddH5ua/HKeC4BlqFU891
         pxoxwo+/GdMPxUVCpa49zFJaCU4ACalOKNehtRtAIKh4LaP9wRJvbi1Bn8G7IrNTFJzl
         UNbEfg024JOR8sBOv4MIxs9DIfqRq7BGGTgfUkahhCWyfpVEo68N3Xwi0TbcYQEBqE0A
         wqBg==
X-Gm-Message-State: AOJu0YykgGPgVC1yFl6Amy6oe16guq6GsQPfBWFyzHj1YZEp5NEUw4mJ
        uiA7zbsMF7GOihuH8aJo6VcaR88YyeY=
X-Google-Smtp-Source: AGHT+IG/V8UxW6mhMCg4MRvVHZ/0Wwvxbl7oOhnXl/s8tuwG0eOZpvx1ikqu6dPKgrOaRgAm53qLFw==
X-Received: by 2002:a5d:6ac5:0:b0:32d:8c6d:cda4 with SMTP id u5-20020a5d6ac5000000b0032d8c6dcda4mr1500924wrw.43.1697714769144;
        Thu, 19 Oct 2023 04:26:09 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.161.188])
        by smtp.gmail.com with ESMTPSA id r16-20020a056000015000b0031aef72a021sm4228776wrx.86.2023.10.19.04.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 04:26:07 -0700 (PDT)
Message-ID: <ff0ed25f-80ef-9906-2a30-6fe5be043f9e@gmail.com>
Date:   Thu, 19 Oct 2023 13:26:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc tree
Content-Language: en-US, ca-ES, es-ES
To:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20231017085346.22917afd@canb.auug.org.au>
 <8e279bd2-8766-4216-8dcb-9fff5b7e1280@app.fastmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <8e279bd2-8766-4216-8dcb-9fff5b7e1280@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 17/10/2023 11:29, Arnd Bergmann wrote:
> On Mon, Oct 16, 2023, at 23:53, Stephen Rothwell wrote:
>>
>>    976868a021ee ("arm64: dts: mediatek: cherry: Configure eDP and
>> internal display")
>>    6b6d5f5665af ("arm64: dts: mediatek: mt6795-xperia-m5: Add DSI
>> Display and its vregs")
>>    db584927b355 ("arm64: dts: mediatek: mt6795-xperia-m5: Add display
>> backlight support")
> ...
>>    142a80a9b568 ("arm64: dts: mediatek: mt8183-kukui: Add PMIC regulator
>> supplies")
>>
>> are missing a Signed-off-by from their committers.
> 
> I've dropped this branch from for-next now, it looks like
> the rebase that I asked for caused the problem since the
> patches were originally applied by Angelo but rebased by
> Matthias.
> 
> Angelo, Matthias: Can you rebase and resend that pull request
> another time? When you do, please make sure to send it
> as a new thread rather than a reply to the original pull
> request, otherwise patchwork gets a bit confused.
> 

I'll send a rebased branch right now and added my SoB, which should fix the 
problem. It also includes a stable branch for the power domain bindings, which 
let to a compilation error. Maybe you didn't noticed as you already pulled the 
stable tree in from another source, but anyway, should be fixed now in our tree 
as well.

Sorry for the mess. We will do better in the future.
I'll send the pull request now in a separate email as you asked me to.

Regards,
Matthias
