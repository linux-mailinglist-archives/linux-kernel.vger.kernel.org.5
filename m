Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60F67CADB0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjJPPiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjJPPh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:37:58 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC91AC;
        Mon, 16 Oct 2023 08:37:54 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1765412276.1;
        Mon, 16 Oct 2023 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697470674; x=1698075474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZmLhijQjL/Xl626qWGcAXeacv5HX3ru3JVkU68P6Ks=;
        b=dtq9Y6gWPaWyZhVxRxQcEF/J6g4SlaRCP++Eu4wiJHbtkqK9KJhPuyqcNupquWrqge
         +DRrmPhLBt4Tba1vd2Dsy4mDWZfUwtzc8djtmlrg7GtankY7Sj3O6biAV3RMTEr4QtfV
         9FYy+n46uEWl648TqgEpddNliuGx6uAIRKhkCf7lroW0cao+1EuFZ3fHkWvavE2KkrRf
         h56Q8rfX1eMydZWrhoe164H8S6JtCKsipCzOHzfFhiKFcWfMVxi65X9pDgIFafsODCSr
         lOSNZ4+FyPScQyd4fLBKJb7FJrvdxNKJu3GZkRoFowyHuwerEHY05rJtaJ/JiSmgX0Vt
         PxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697470674; x=1698075474;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZmLhijQjL/Xl626qWGcAXeacv5HX3ru3JVkU68P6Ks=;
        b=lwzyxq0CGGtBjfHm5KQSQ6f1UOT4VGeydtvU4Rh/wlgY8fA7MS6Rhk/B5xM3TwcymC
         wEYYpS3ghkTcE7y+C/LNarJZ4Im1KJ862/CtZBA4OO83r7hXKrXMQUcEj1mbi38d9rWG
         JG3Kjk4Mm9CHQ58XBG8qxdmcph7G1gJ1OghJMALLKJCOeV6OH0l5npQtHmCTo4Hw831h
         jMkEzElBAWjQEuI0zH7c7TIUoz+IfuWt8E0Dt2aebvExXL3aPU3zcC7fXmHRz6PQf0o4
         YHJXzOsRBlMEVJ6/cl7rAbWWSOypzxb0EFUKdz6q9e9jK7eVgLpnump13+hObrCufVDb
         oLRA==
X-Gm-Message-State: AOJu0YzlLIzfGTzYXAC7ki6JeN50tlgJElrjc5F7cE+gTgWDs0ZKVID+
        1uiN/YPpIDzE0Xc410e8TB4=
X-Google-Smtp-Source: AGHT+IHy6mf9prYlz0GRkgZRzgS21b1LhDsidbqwM/lb9PFH322tSlIj12p/qGeW1Fi0npbRYURV4g==
X-Received: by 2002:a25:ac03:0:b0:d9b:3ef1:9b43 with SMTP id w3-20020a25ac03000000b00d9b3ef19b43mr8289896ybi.40.1697470673966;
        Mon, 16 Oct 2023 08:37:53 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id x21-20020a05620a14b500b00773f008da40sm3061221qkj.125.2023.10.16.08.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 08:37:53 -0700 (PDT)
Message-ID: <97df39dc-daae-4334-bb80-d690851e5269@gmail.com>
Date:   Mon, 16 Oct 2023 08:37:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 4/9] net: dsa: microchip: ksz9477: add Wake on
 LAN support
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
References: <20231016141256.2011861-1-o.rempel@pengutronix.de>
 <20231016141256.2011861-5-o.rempel@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231016141256.2011861-5-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2023 7:12 AM, Oleksij Rempel wrote:
> Add WoL support for KSZ9477 family of switches. This code was tested on
> KSZ8563 chip.
> 
> KSZ9477 family of switches supports multiple PHY events:
> - wake on Link Up
> - wake on Energy Detect.
> Since current UAPI can't differentiate between this PHY events, map all of them
> to WAKE_PHY.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
[snip]
> +void ksz9477_get_wol(struct ksz_device *dev, int port,
> +		     struct ethtool_wolinfo *wol)
> +{
> +	u8 pme_ctrl, pme_conf;
> +	int ret;
> +
> +	ret = ksz_read8(dev, REG_SW_PME_CTRL, &pme_conf);
> +	if (ret)
> +		return;
> +
> +	if (!(pme_conf & PME_ENABLE))
> +		return;

I suppose this works beause you have separate enable bits for 
WOL_LINKUP, WOL_ENERGY and WOL_MAGICPKT, you could have also left the 
setting of the PME_ENABLE bit to the set_wol() routine provided that 
wol->wolopts is non-zero.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
