Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDEB7AA00C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjIUUa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjIUUaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:30:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DA3914E7;
        Thu, 21 Sep 2023 10:47:39 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-577a98f78b2so836220a12.3;
        Thu, 21 Sep 2023 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318459; x=1695923259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZDt//U5q7EunYH01zrIXPRDmp4Gue1Cz0eDg+G3evQ=;
        b=K5/yl1dkXIIy1u5IZmZFHSYI2ppEaLh9FK6bAx9GCk1qvCoeRv00WnPKHV9LCtfnTY
         46jL6XKx//gu7w82BblyR239kKpRv7286BdzOU8rn9xJ5QE8sstytxQaCxYciTGylQwm
         Ve7C9dT6T/9nmEWSCcGaIouw2cjkDykpdWOSk1bk5FNyqfnWmv0y8JJdDaTOFACNv9kz
         uC+kexdnloC611HP3MMFC93vnyCOkW/mfIbBch/kb9P4vMmm21X0R/XdH5ZOtQQktNgq
         iZiAknKw+zoe+fKyLEQAUo1MWjaL98sSoh+Xy7fC1nscJ6KD1Q/EBEedaR6nBR/69JzY
         oDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318459; x=1695923259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZDt//U5q7EunYH01zrIXPRDmp4Gue1Cz0eDg+G3evQ=;
        b=C6w4j4lwLpcPKoTIqH8ZZUcVThz8ZN8M03q6r4az8wu5GjbAzKf8RLVqcu4/rnMZSx
         2AMEwfwmTvJX8tQReq+TfvK5jQu7MLHlp815n5wG9SeSHRHOjpdasKpyGnotnit9a6yX
         U4g3rN+MuZMSj9eaZm6rLtaE2iHkFS1VToWa0CTkhnMhg0UcW11Midy3U4BsFIxqPs42
         +GRcHWNp/j/8L3+bNwMmHxrAJgkIHo5g6W6w0ZPMymf1aeh+XuRk0dA78tIhQ9B+EZ/S
         o6JG5R10vvAjC0DTqiQ2CRkhpjcNLk0jqlennDTYiHIkKFYUdEuUidl1zDSf9AihKxNi
         1h3A==
X-Gm-Message-State: AOJu0YxRXiBuWBuzblLkqXDfYJAALiPHvdfetzGfRC9nSP836Qw0PgvO
        Y4lBXMWGKPiixncHxC2vAKM=
X-Google-Smtp-Source: AGHT+IGpvsTzceD4+eMTpJs59OlOsS8/rmYFsLk8dMqA6Eb9D8Oz6CpW/gwPkWW0xXJkJZocGRHOyQ==
X-Received: by 2002:a17:90b:17c7:b0:274:735c:e2d3 with SMTP id me7-20020a17090b17c700b00274735ce2d3mr6244390pjb.8.1695318458747;
        Thu, 21 Sep 2023 10:47:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ev9-20020a17090aeac900b00274aa305adesm2944188pjb.0.2023.09.21.10.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 10:47:37 -0700 (PDT)
Message-ID: <6fe64e91-399a-fa7e-492f-db34d063e0e6@gmail.com>
Date:   Thu, 21 Sep 2023 10:47:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 net-next 1/5] net: dsa: propagate extack to
 ds->ops->port_hsr_join()
Content-Language: en-US
To:     Lukasz Majewski <lukma@denx.de>, Tristram.Ha@microchip.com,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20230920114343.1979843-1-lukma@denx.de>
 <20230920114343.1979843-2-lukma@denx.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920114343.1979843-2-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 04:43, Lukasz Majewski wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Drivers can provide meaningful error messages which state a reason why
> they can't perform an offload, and dsa_slave_changeupper() already has
> the infrastructure to propagate these over netlink rather than printing
> to the kernel log. So pass the extack argument and modify the xrs700x
> driver's port_hsr_join() prototype.
> 
> Also take the opportunity and use the extack for the 2 -EOPNOTSUPP cases
> from xrs700x_hsr_join().
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

