Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06D37AE8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjIZJLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjIZJLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:11:33 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48C2DE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:11:26 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so991780166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695719485; x=1696324285;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiS0epNzaZyEIaYM5dtVpV8Ae3Fvc63uU9qlBPvKWq0=;
        b=Ph2NQBLV/zrUO6LDCMtraaLkKc7qTBy5+F7eDlXHs6uYwzB4jZq31GPlzXXX7mE/Vk
         vFyx7wU3BHGtynwgaSuawdiO14a04UaLG2BRMVRQfKfvtLViDtrdRMIXCO0FSDdKCSgV
         klXnuZyoKpqCyZQmdBEudM+b0eurjLv/X0rRC/4B7OhkdvZxxqRuUop0G8d5qYVUOdQO
         F4Dva8Kij3OhBEGLkp1/UQQ+DE8Qno21I7OuT9Muq5/7hbDXYVae4AXOYm3KuHjDyKem
         GUfHHjfchsVdPzyV3MkSMB4GWAVtzZux3pATuTwiTgt2gXxqiGf6L6l5LFSXIw5gEsYB
         e6NQ==
X-Gm-Message-State: AOJu0Yy0R4Pah+Fx0axq66xJOtT38GmExxP9wJT69N1GqZU8J4xjU+Af
        V+kyc3k0WqW4samqADDkehNUG3kT3Tw=
X-Google-Smtp-Source: AGHT+IGcoZ/+pMwbqD3pgMsNPqPH4QkkrwfZfVAXMBqY7Bvm9L2FmQ0a4qQtQRLRjA7WZOo52QhkPA==
X-Received: by 2002:a17:907:78cc:b0:9b2:8c37:820 with SMTP id kv12-20020a17090778cc00b009b28c370820mr3578240ejc.65.1695719484980;
        Tue, 26 Sep 2023 02:11:24 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id va1-20020a17090711c100b00992ea405a79sm7479291ejb.166.2023.09.26.02.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 02:11:24 -0700 (PDT)
Message-ID: <f3d8c72b-cd30-490c-833f-5807bd74511f@kernel.org>
Date:   Tue, 26 Sep 2023 11:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] firewire updates for 6.5-rc1
Content-Language: en-US
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20230704121847.GA26576@workstation.local>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <20230704121847.GA26576@workstation.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04. 07. 23, 14:18, Takashi Sakamoto wrote:
> Please pull firewire updates for v6.5-rc1.
> 
> The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:
> 
>    Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

Likely some of the below commits causes an instant reboot during boot as 
was reported in:
   https://bugzilla.suse.com/show_bug.cgi?id=1215436

6.4.* was fine, 6.5.4 or 6.6-rc1 fails.

module_blacklist=firewire_ohci fixes the issue on 6.5.4.

Any ideas what can cause this? I fail to see an issue in the commits...

FWIW I see "obsolete usage of GFP_ATOMIC" was reverted in 6.5.5 and 
6.6-rc2, I asked the reporter to test those.

> Takashi Sakamoto (24):
>        firewire: add KUnit test to check layout of UAPI structures
>        firewire: cdev: add new version of ABI to notify time stamp at request/response subaction of transaction
>        firewire: cdev: add new event to notify request subaction with time stamp
>        firewire: cdev: implement new event to notify request subaction with time stamp
>        firewire: core: use union for callback of transaction completion
>        firewire: core: implement variations to send request and wait for response with time stamp
>        firewire: cdev: code refactoring to operate event of response
>        firewire: cdev: add new event to notify response subaction with time stamp
>        firewire: cdev: implement new event to notify response subaction with time stamp
>        firewire: cdev: code refactoring to dispatch event for phy packet
>        firewire: cdev: add new event to notify phy packet with time stamp
>        firewire: cdev: implement new event relevant to phy packet with time stamp
>        firewire: fix build failure due to missing module license
>        firewire: fix warnings to generate UAPI documentation
>        firewire: ohci: use devres for memory object of ohci structure
>        firewire: ohci: use devres for PCI-related resources
>        firewire: ohci: use devres for MMIO region mapping
>        firewire: ohci: use devres for misc DMA buffer
>        firewire: ohci: use devres for requested IRQ
>        firewire: ohci: use devres for list of isochronous contexts
>        firewire: ohci: use devres for IT, IR, AT/receive, and AT/request contexts
>        firewire: ohci: use devres for content of configuration ROM
>        firewire: ohci: release buffer for AR req/resp contexts when managed resource is released
>        firewire: core: obsolete usage of GFP_ATOMIC at building node tree
> 
> Zhang Shurong (1):
>        firewire: net: fix use after free in fwnet_finish_incoming_packet()

thanks,
-- 
js
suse labs

