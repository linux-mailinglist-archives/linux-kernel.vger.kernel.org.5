Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD3E80B657
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjLIUux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLIUuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:50:51 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD68C10E;
        Sat,  9 Dec 2023 12:50:57 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c2308faedso34858275e9.1;
        Sat, 09 Dec 2023 12:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702155056; x=1702759856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMJPi3iIzMIlCjs861+CyhhSUrX7bsn8d7c7Kriq3JY=;
        b=XWHaz69EJ4RlcPfmlKhwbAH2RtOoNXIy37Pb77HAycSS5Dti/TdQBCBN7mbiw1iYXC
         tfDbhG5PhgS/VYdj6by1qdPK0cRiLcgcAvy516db5075zh88DBg5hzS34zMeuCLrKG9S
         u8jZvFNMDaHZkXovf1UVNEBWHb1AfYFtaW4rFwsNzmRzjqjscaku82ED656iTOob9i83
         RlYgostLjLVkRqgqr5gasMk+XjCx0keOhRJFSfWWttDYe5bj01tqePj4XfTyiCuQbvu5
         xPG+AszawNVyO6TiBKR+tTXVFGNmHLr9/yHUZKkGULdlmT4rIBupwpRHY6sESSOwzjot
         2nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702155056; x=1702759856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMJPi3iIzMIlCjs861+CyhhSUrX7bsn8d7c7Kriq3JY=;
        b=E+yuQgASaM2wKui5saCuDiQb8OHCC/GG2dVmBg5iFGvthiqwhKZf34+r+ttEcDQ9wc
         nNGep3HkbLWBSjjMmgZW9UIsHny7cMQgqqHjDyYpihgg6KfkGtcskv82n/6JPT8eP5w6
         VtQp7zltuZ0LRq/cQ74LOD/MsW4HPCVuBMtpTIo//yMeCmzVY+uMx7n0cv5b/i69SRvg
         VNo9UEDHcEWcvbFMrKu/tLhGVQ/urMVgVDjAp+w9FivUD+2+qHu9XxUuYJbR3DZ6xQ0H
         7+MMQwvbDFavnVcpnSet2ulE5YxyHoc3ebNYiAlRAvUAhgZrSNLh4EjL5/hJDiqGV4ct
         78bQ==
X-Gm-Message-State: AOJu0YxMf4/Hvq1e40isMPpGUvXHNocaWgOKKQQ8XC2+0oxTaUAiNgsX
        Qo7WmksNBHUOEEtZSEbvIfA=
X-Google-Smtp-Source: AGHT+IE3XEEBii+B9JkJKs6o8ET+jTzHybvoiVXKO2G9EClU8u3uG0zRe1zismiE6cerLl60ogNGrA==
X-Received: by 2002:a05:600c:3107:b0:40c:32fa:4f41 with SMTP id g7-20020a05600c310700b0040c32fa4f41mr1048497wmo.142.1702155055686;
        Sat, 09 Dec 2023 12:50:55 -0800 (PST)
Received: from [192.168.1.7] ([95.133.122.84])
        by smtp.gmail.com with ESMTPSA id fa7-20020a05600c518700b0040648217f4fsm9686079wmb.39.2023.12.09.12.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 12:50:55 -0800 (PST)
Message-ID: <da6d2828-41db-4c29-a1aa-024b1fbcc43a@gmail.com>
Date:   Sat, 9 Dec 2023 22:50:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] input/touchscreen: imagis: add support for
 IST3032C
To:     Karel Balej <karelb@gimli.ms.mff.cuni.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>
References: <20231202125948.10345-1-karelb@gimli.ms.mff.cuni.cz>
 <20231202125948.10345-6-karelb@gimli.ms.mff.cuni.cz>
 <89f7e7de-c574-49ab-885d-c6d4427fe64f@gmail.com>
 <CXJAG826ZTNA.2F8WOGVNYADKP@gimli.ms.mff.cuni.cz>
Content-Language: en-US
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <CXJAG826ZTNA.2F8WOGVNYADKP@gimli.ms.mff.cuni.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karel,

On 12/8/23 23:59, Karel Balej wrote:
> Markuss,
>
> thank you for the review.
>
>>> diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
>>> index 84a02672ac47..41f28e6e9cb1 100644
>>> --- a/drivers/input/touchscreen/imagis.c
>>> +++ b/drivers/input/touchscreen/imagis.c
>>> @@ -35,6 +35,8 @@
>>>    #define IST3038B_REG_CHIPID		0x30
>>>    #define IST3038B_WHOAMI			0x30380b
>>>    
>>> +#define IST3032C_WHOAMI			0x32c
>>> +
>> Perhaps it should be ordered in alphabetic/alphanumeric order,
>> alternatively, the chip ID values could be grouped.
> Here I followed suit and just started a new section for the new chip,
> except there is only one entry. I do agree that it would be better to
> sort the chips alphanumerically and I am actually surprised that I
> didn't do that - but now I see that the chips that you added are not
> sorted either, so it might be because of that.
>
> I propose to definitely swap the order of the sections, putting 32C
> first, then 38B and 38C at the end (from top to bottom). The chip ID
> values could then still be grouped in a new section, but I think I would
> actually prefer to keep them as parts of the respective sections as it
> is now, although it is in no way a strong preference.
We could do that, yeah. It is not a problem right now since there's only 
3 models supported, but it would maker sense and set some order for when 
we'd have more supported devices.
>
> Please let me know whether you agree with this or have a different
> preference. And if the former, please confirm that I can add your
> Reviewed-by trailer to the patch modified in such a way.
Yeah, it's fine.
>
> Best regards,
> K. B.

- Markuss

