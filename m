Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF11F77A453
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 02:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjHMAQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 20:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHMAQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 20:16:53 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E852C13E;
        Sat, 12 Aug 2023 17:16:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc73a2b0easo21748485ad.0;
        Sat, 12 Aug 2023 17:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691885814; x=1692490614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8I4OWTxF9djrfSWgvtqI3wQlVbrXSiCGpIyYob9OMug=;
        b=FSJnlSv+Emh8JyQD3MzlVm45YMOc53yeOB3frNIRvORChBU3kHJn/wJ+L8jGJI0U9d
         AtGF/n2QgI0AhTuDzXHLt5G5AtJn5GO2FejV1evLhOLtApX+Z9Qxd9aNoY3Hg1KlyEFn
         qVwVAinsYyc8UGLYSpcKzt8vYK6p05LPDT1vHV6KvrG5tr+Xmi2+Gj+ObXaVSaXHfhPt
         tFzhpHwEpVTPqPgM1DRA7CsTDVlu9gtU9gD91WnVyzK7wne52rQzyuh1mvjWEDcqkk+K
         MXAwOP+9gFGE8HZRdrDhupctMFziIwIbmJ8GFp/rs87H64I0mJmfUsN4UBo2vCcna+9l
         9bNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691885814; x=1692490614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8I4OWTxF9djrfSWgvtqI3wQlVbrXSiCGpIyYob9OMug=;
        b=I3epSWUMbsmcNVu8pgFW4WUJwyTU2OGww/XTHH84xSj+zs4DQMQGqo5/Ro0IV1E5Tu
         xxG9/kfJQyXxJlI8ftv2TFwGQHsWH6OD86txqgKn89AxblCG59IE7p41VHTBfBE/MW+Y
         89y8FqKBenvfvLDCV1OF7smGR+BNlJgM876C75oCF+CgUT/7Z+anr4TVOJYRK6+bzTVx
         dOfbFb89MQeGD2ZoFdhGWSlSYiZ7UETDyx6GnDIQ/GcaB1R0p7l37y5kqVjqZMb56DJF
         mvgYZt9k4hA7M3li11rpFzVqoJkDbNWVq9O80DhlR922OoJCZWYpqZprPshGTB/azO70
         tmcw==
X-Gm-Message-State: AOJu0YwlxkebXv6jl9lHdDQN2a6o451AthqxGRaqwJUkXQ6t4WgHK9Cm
        0teDb0AfnXm80k+RHnZBGFk=
X-Google-Smtp-Source: AGHT+IEHsa86s69bUw0dtUX7y0vw4gWoiVNWvVAHHwUHVi1BBh1/7QBIkIw5BtrdXnQdCxIHqSuFlQ==
X-Received: by 2002:a17:903:2285:b0:1b8:7625:3042 with SMTP id b5-20020a170903228500b001b876253042mr5905468plh.10.1691885814285;
        Sat, 12 Aug 2023 17:16:54 -0700 (PDT)
Received: from [192.168.1.101] (1-160-139-178.dynamic-ip.hinet.net. [1.160.139.178])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001bdc6e13665sm2437623plb.275.2023.08.12.17.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 17:16:53 -0700 (PDT)
Message-ID: <6621a721-06fa-2bf8-5279-cc7c464ad615@gmail.com>
Date:   Sun, 13 Aug 2023 08:16:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH v2 0/3] Add support for Nuvoton ma35d1 rtc
 controller
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230809011542.429945-1-ychuang570808@gmail.com>
 <43e42ee5-7a56-49ba-8e06-5046ef85c98f@app.fastmail.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <43e42ee5-7a56-49ba-8e06-5046ef85c98f@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/8/12 下午 04:53, Arnd Bergmann wrote:
> On Wed, Aug 9, 2023, at 03:15, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> This patch series adds the rtc driver for the nuvoton ma35d1 ARMv8 SoC.
>> It includes DT binding documentation, the ma35d1 rtc driver, and device
>> tree updates.
>>
>> The ma35d1 rtc controller provides real-time and calendar messaging
>> capabilities. It supports programmable time tick and alarm match
>> interrupts. The time and calendar messages are expressed in BCD format.
>>
>> This rtc driver has been tested on the ma35d1 som board with Linux 6.5-rc2.
> Hi Jacky,
>
> I see you added soc@kernel.org to Cc for all three patches, which
> has put them into the patchwork tracker.
>
> Now that the platoform support is merged, I do not pick up patches
> for other subsystems through the soc tree, so please drop the Cc
> here.
>
> You can post the the dts change along with the driver, but the
> correct process is that the subsystem maintainer(s) pick up the
> DT binding and the driver once the review is complete, and then
> you send the dts changes to soc@kernel.org. Depending on the
> platform, there may be a lot of conflicting dts changes, so this
> way you can aggregate any patches for these files before sending
> them to the soc tree for inclusion, while I then merge them
> with all the dts changes for other platforms and any global
> cleanup.
>
>      Arnd


Dear Arnd,


Thank you for the detailed explanation. I now understand how to proceed.

I will remove Cc: soc@kernel.org from here. I apologize for any 
inconvenience

this patch series may have caused you and appreciate your assistance.


Best Regards,

Jacky Huang


