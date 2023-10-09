Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A877BEC37
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378199AbjJIVDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378151AbjJIVDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:03:08 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F50EB;
        Mon,  9 Oct 2023 14:03:04 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-584bfb14c59so3058625a12.0;
        Mon, 09 Oct 2023 14:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696885383; x=1697490183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=os7QhAKub4KIthm7Pb05vmG1pc3XAljYVBVgNXJPWvs=;
        b=bwH7MeQHRw1XFbkokWtrNqX3zzyQ1eHixqM66/wVMpaE+apb29VZdCCn38ITlKSxmr
         VPmRqXTHo3QTrrK67zJxtXQ5mopESqwzyKuYWSyiCcwUJkZNLs1neFQIJnNHS2gOndYr
         wilrgzcerO0pgthQi7DrOmXhSn7LEpcZzcngXy7hjAc/D2JK8eq82AnkY277kEkHAfau
         VnwdS3xHO+MukOlFPsUS2Mpv7XzOSsg9dbWkQZdtYsjnwQQWeVF/blvIiD/bPJ2yaa5s
         Z3lG351t4/YWaUnV4YwrgNOs5jytNnVktO0OijqLrvVr8A0+IVMeg/Ro9ROZwSLYIyX7
         SqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885383; x=1697490183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=os7QhAKub4KIthm7Pb05vmG1pc3XAljYVBVgNXJPWvs=;
        b=L2g5Et6IsYKNXHfdJELQXvj8/W66DxeV6VVg4KItb+m1qaY2528B8ypf9C1hwKqIvK
         Re5BYZGWaggZU393+JS6H/f0/yAyvKfo1zfeOMDLPQtZ1BzfBo1K5E0vzpSKfuRx0UEz
         avZL3mn5L5W1ZJW94bTIM2reVXtqmxubxJuDYL2zIzr46aX+mqY22Qz3jMzx6pYblt3A
         X4bdufVJnHZKqpvNkJOgDFYccb8rZ0H68wcjYn1ZsP1QzL1pkoFQ9Y7ItUkAOMGJZPV1
         FD7v8QsBVrmVCZRyQMySulv4NtLway8j+rM2SWmIXi30+TaK6lasfZvvQW9y49zQzp+x
         yoHQ==
X-Gm-Message-State: AOJu0YwfULdHclwXyuvmJx9eafGC+/oaXH70qEm71Y5bVRZQfZjcJFyh
        CJgA0Q7stTD0p9OhTdl3wLk=
X-Google-Smtp-Source: AGHT+IHF7rURm2cs2Pj6n58bXbvNQueqFggbxqwL5FDaqybnyUjNXbDI8sVnaoO91ppPmv3o7+BKcw==
X-Received: by 2002:a17:90b:4f46:b0:267:f9c4:c0a8 with SMTP id pj6-20020a17090b4f4600b00267f9c4c0a8mr13248485pjb.4.1696885383485;
        Mon, 09 Oct 2023 14:03:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e2-20020a17090a630200b00277337818afsm6484585pjj.0.2023.10.09.14.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 14:03:02 -0700 (PDT)
Message-ID: <c197f024-e504-470e-b4a9-ce6466a4a038@gmail.com>
Date:   Mon, 9 Oct 2023 14:02:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 01/16] net: Convert PHYs hwtstamp callback to
 use kernel_hwtstamp_config
Content-Language: en-US
To:     =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-2-kory.maincent@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009155138.86458-2-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 08:51, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> The PHYs hwtstamp callback are still getting the timestamp config from
> ifreq and using copy_from/to_user.
> Get rid of these functions by using timestamp configuration in parameter.
> This also allow to move on to kernel_hwtstamp_config and be similar to
> net devices using the new ndo_hwstamp_get/set.
> 
> This adds the possibility to manipulate the timestamp configuration
> from the kernel which was not possible with the copy_from/to_user.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

