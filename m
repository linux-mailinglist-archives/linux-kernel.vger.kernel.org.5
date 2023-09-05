Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779D9792FA1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbjIEUL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjIEUL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:11:56 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1458DCFB;
        Tue,  5 Sep 2023 13:11:30 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so1939195e87.1;
        Tue, 05 Sep 2023 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693944688; x=1694549488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w2c0X/15jRHBgEVSCCaDEJe6vWwc+ez2XuJO2zWQ3kY=;
        b=JwB8FgeZPMzk5dAK7hSFEEcstBOD/DzXqohh7xbfnYHAIrJG2dw1yPY5Z/M0SPK1+X
         M8B60V1xshjkj4c9g0+HWU0usxuUNpoZNgtfxZT9a97S2WeFAoUsjz6BFh+tolI27AT/
         lVce3f9Y1MpF6YjOYhTZS6MhkEgBEOLOMFeiTdNUO6YdP4g0sXC7Apvg52/gog/OCvdH
         Lp2Bon0xBNfwg9HB3SHU6kR711OSKbz11rDY2aAcJJ3WTPvfgyEvZkvgmOdsAr5oLOJf
         TlNxgn3qNydlxEn0yHxwE+6A7mvB5hUxcd4yD1XFqZG6Oz4jT1W2hFpZ208WbDbuOhZx
         Ed0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693944688; x=1694549488;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2c0X/15jRHBgEVSCCaDEJe6vWwc+ez2XuJO2zWQ3kY=;
        b=UrJwmCqQiG9xYa5sEZnKKKAfQbKvFdpLxkfAgYd0I3lyEQWV00cMU1yVqdsRC6k/l/
         BIeEHEZjPi6MZxQsLvx3K2/V2tfbZxgfS6UjlgcY2NOs/N5IhZPD/ol33G1+RGph/87N
         6asBSfyWVFQYLCPlA85A8D4hlGvAss6lyad0KVswZvfiTMrWx9fCtAUyuIYrgj6YN4uP
         h1gB9aNAU3AuGQV/dwV3D3ohDwSTojBznJFl2b4HVI320mb53kNDut1EIbBgsXo93Ke4
         8/9uTxnjnOnW2zQXg0dgui9P8d0E+0m6Ig/Wyp07ytFr/KWXOXFHxjDs3sF3RF4vF1qt
         3pQA==
X-Gm-Message-State: AOJu0YzvvgvW/HOZ3BPebY23znjPibJbpBKS/yu1RZOPWrI43KR1OQML
        y+s5jRIa3tAq7pw1pIii9cRvWLGyJY96WA==
X-Google-Smtp-Source: AGHT+IHFowLDY6tJlLBXTNIpcha+Msm1E/UAmVgsnSTFGVA9BG8YgXxGRbHrBqfPB59mY2lJT0YERg==
X-Received: by 2002:a05:6512:313b:b0:500:8f65:c624 with SMTP id p27-20020a056512313b00b005008f65c624mr557196lfd.53.1693944687570;
        Tue, 05 Sep 2023 13:11:27 -0700 (PDT)
Received: from [192.168.10.127] (net-188-216-175-96.cust.vodafonedsl.it. [188.216.175.96])
        by smtp.gmail.com with ESMTPSA id j11-20020a17090686cb00b0098e422d6758sm7964172ejy.219.2023.09.05.13.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:11:26 -0700 (PDT)
Message-ID: <fdd2ff37-8944-4186-844f-9698e8b2f31c@gmail.com>
Date:   Tue, 5 Sep 2023 22:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Regression with AX88179A: can't manually set MAC address anymore
To:     netdev@vger.kernel.org
Cc:     Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <54cb50af-b8e7-397b-ff7e-f6933b01a4b9@gmail.com>
 <ZPcfsd_QcJwQq0dK@debian.me>
Content-Language: en-US, it-IT
In-Reply-To: <ZPcfsd_QcJwQq0dK@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 14:31, Bagas Sanjaya wrote:
> On Tue, Sep 05, 2023 at 01:02:22PM +0200, Sergio Callegari wrote:
>> Hi, reporting here as the issue I am seeing is cross distro and relevant to
>> recent kernels. Hope this is appropriate.
>>
>> I have a USB hub with AX88179A ethernet. I was able to use it regularly,
>> until something changed in recent kernels to have this interface supported
>> by the cdc_ncm driver. After this change it is not possible anymore to work
>> with a manually set MAC address.
> Exactly on what version range?

Hard to say without extensive testing since distros move from kernel to 
kernel with big version jumps. The adapter was surely usable in ubuntu 
22.04 with kernel 5.15, breaking this Summer as kernel 6.2 arrived as an 
HWE kernel.

>> More details:
>>
>> - before the kernel changes, the interface was supported by a dedicated
>> kernel driver. The driver had glitches but was more or less working. The
>> main issue was that after some usage the driver stopped working. Could fix
>> these glitches with the driver at
>> https://github.com/nothingstopsme/AX88179_178A_Linux_Driver
> Did you mean that you use out-of-tree module?

I mean that with kernel 5.15 I could use the in-tree module with some 
glitches (interface occasionally stopping on teleconferencing) as well 
as the indicated out of tree module with no glitches.

With current kernels (certainly from 6.2 on) manually setting a MAC 
address breaks the interface. Furthermore, even if it compiles and loads 
fine, it is impossible to use the out of tree module because it does not 
create the eth device anymore (the eth device now appears with the 
cdc_ncn module). Being this an out of tree module, this is not very 
important, though.

>> - after the kernel changes, loading the ax88179_178a.ko does not create a
>> network device anymore. The interface can be used with the cdc_ncm driver,
>> however it is not possible anymore to use a manually set MAC address.
>>
>> When you manually set a MAC this appears to be accepted (e.g. ip link
>> reports it correctly), but the card does not receive data anymore. For
>> instance, trying to connect to a DHCP server, you see that the server
>> receives the request, makes an offer, but the offer is never received by the
>> network card.
>>
> How is the reproducer?

1. Turn down the interface with the `ip` command.

2. Use the `ip` command to set an hardware address (xx:xx:xx:xx:xx:xx) 
different from the original one (yy:yy:yy:yy:yy:yy) from the adapter.

3. Try to get an IP address from a DHCP server configured to respond to 
xx:xx:xx:xx:xx:xx

4. Observe that the system is unable to get an IP address from DHCP 
(keeps asking)

5. Look at the DHCP server logs and observe that the DHCP server 
receives the request from mac xx:xx:xx:xx:xx:xx and makes an offer, but 
this is never accepted (possibly never received).

Skipping 2. and setting the DHCP server to respond to yy:yy:yy:yy:yy:yy, 
everything works as expected. So it is the manual setting of an hardware 
address that triggers the issue. The DHCP server is OK: steps 1-5 work 
fine with other NICs and used to work fine with the AX88179A USB NIC 
with kernel 5.15.

Would like to triage better, but it is not easy for me since I do not 
own the USB Hubs containing the AX88179A based ethernet port. I get 
these where I work and I am not expected to detach them from the office 
equipment. I'll see what I can do.

>> This may be the same issue reported here:https://discussion.fedoraproject.org/t/ax88179-178a-network-fails-to-start-usb-to-eth/77687
>> where the user says he cannot use the adapter when Network Manager is
>> configured to employ a randomized MAC address.
>>
> Confused...

The discussion on the fedora forum that I linked is what provided me 
with a hint about the issue with the manual MAC address. In that 
discussion a user reports an issue about an AX88179A unusable in fedora 
(that uses fairly recent kernels). The user solved the issue disabling 
randomization of the MAC address (which implies changing the MAC). 
Namely he says "The wired connection had a “virtual mac address” 
randomly generated set in Network Manager GUI (I can’t remember why I 
had set that before) [...] disabling this configuration the wired 
connection started ok". However, the details are modest, so that user 
might as well had encountered an unrelated problem, pointing me to the 
manual MAC setting just by coincidence.

Thanks for your reply that testifies attention for the issue.

Sergio Callegari

