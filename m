Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8391F805F79
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjLEUc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEUc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:32:57 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AA0181
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 12:33:04 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d048c171d6so42687655ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 12:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701808384; x=1702413184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1umsCfy/akzFPftCbPrbjo0m+EjeRCmtccRMiAQbUc=;
        b=EYg//kYirRrInFPcFkq/UkGtF/J6r6RyEe4Y+Q82XtOvGMzSKfM9CrjpXvjVEG/iY4
         Gb/i+jbqD0WNrRCVNgHjvmIopTe1tt38Y+uHCGmhzJHtirSnXvH3sNhDfWrw8vDe2m63
         +0HVRTLqK2H6pQ/BiXrLmUpDUDkw25Z8j8n4s3c/QtfFESLgAYpqecx1tIv4pQIeTY6B
         ZuRYr7ol2pFCPjjRVM/x/6u5EhQ/rpSKVWZc5iQNPL1yOpTYBkbkOsR7aM5gp2tzBRgk
         JbeJOI0O3XitE989Ufnf/dhqa27Mmut+5tR8Y6T909/GTzDxq5SDcnnYJ62qNSHWLsYz
         Yc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701808384; x=1702413184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1umsCfy/akzFPftCbPrbjo0m+EjeRCmtccRMiAQbUc=;
        b=pU57d1B+ZVz1LDevLdATIatZSxK6I+SV3+Sq9FuGn3W2A2zKZZK0FCR5ulBQoQ6ome
         EBQ60zJUIp77NdvUt1e80PEpFmpfhLvFDx+M0+i8C1i60F5QFlaWgcOezlU7JpPS5R4k
         yHF9Kw9Ju4zI4wB0KG5R6EnYwBF+zYOSMxVOMfiy9ILwPjD17BGPTA3URpLs8MZGbZwk
         fssvAzyBdK8rm6YyhbMNjRDg5DyXIh1IttC8mzMHUNXPr3vBuUL+P1kEV7qeHn3qZELv
         IusBIjmQMNitY/P/nkTD81gBjQ0xDtbNg9arffdUrTgkHgv1rzGxBHtr3Wm5z9rBwi3i
         bO9g==
X-Gm-Message-State: AOJu0YyJet/YgzgWp6keyAAM2pYWidj6L318Acrm5k0Qbl2DWabOUCHh
        DS8nz6ac7wcaVXesuwebKLA=
X-Google-Smtp-Source: AGHT+IFB1DcSVhkAgK4W14IJexGK19Q+ji8QfzeCUIKn0kJbfA8Hgns3wH9psDgw1bI+18FCDDRnJQ==
X-Received: by 2002:a17:902:d2c7:b0:1d0:c445:8014 with SMTP id n7-20020a170902d2c700b001d0c4458014mr2088785plc.76.1701808383705;
        Tue, 05 Dec 2023 12:33:03 -0800 (PST)
Received: from ?IPV6:2401:4900:1f3e:53bf:50c7:2988:e019:4b97? ([2401:4900:1f3e:53bf:50c7:2988:e019:4b97])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b001cca8a01e68sm10607813plo.278.2023.12.05.12.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 12:33:03 -0800 (PST)
Message-ID: <3cd7fc7d-075f-4945-b84d-7326e3c99553@gmail.com>
Date:   Wed, 6 Dec 2023 02:02:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] greybus: gb-beagleplay: Ensure le for values in
 transport
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org,
        elder@kernel.org, linux-kernel@vger.kernel.org,
        jkridner@beagleboard.org, kernel test robot <yujie.liu@intel.com>
References: <20231204131008.384583-1-ayushdevel1325@gmail.com>
 <ZW3ePt-c4Mu43DOV@hovoldconsulting.com>
 <7ead544b-9234-483f-aacb-55ed05b01fa3@gmail.com>
 <2023120515-mongrel-undertook-6e5a@gregkh>
 <4cafbb5a-8ecd-407e-81a0-76d6505d013b@gmail.com>
 <2023120616-rely-naturist-01db@gregkh>
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <2023120616-rely-naturist-01db@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/23 01:15, Greg KH wrote:

> I'm confused, what exactly is needed here to be sent that isn't in the
> existing message definition.
>
> And as to your original statement, the protocol definition was not
> designed for any specific use case that would make IoT "special" here
> that I can see.  It was designed to provide a discoverable way to
> describe and control hardware on an unknown transport layer for devices
> that are not discoverable by definition (serial, i2c, etc.)
>
> The fact that we implemented this on both USB and unipro successfully
> provided that the transport layer for the data should be working and
> agnositic.
>
> thanks,
>
> greg k-h

So, the missing information is the AP cport which is sending the 
message/for which the message is intended. Each AP cport will be 
connected to a cport in some greybus node. For a simple case like USB, 
where AP can directly talk to the node, and we do not really need the 
cport information outside of kernel driver.

I think under normal circumstances, the kernel driver is supposed to 
directly communicate with the node. However, in beagle play, the subghz 
transport is only present in CC1352 coprocessor. This means CC1352 needs 
to act as the middle man between AP and node (aka perform the APBridge 
tasks). So it needs to maintain a way to keep track of all active 
greybus connections, and route the messages between AP and Node cports.

I am not quite sure where SVC is supposed to be in Linux kernel greybus 
setup. Since SVC needs to be able to detect module insertion/removal, it 
needs to be able to access the same transport as APBridge. Thus, CC1352 
(and gbridge in old setup) are responsible for both SVC and APBridge roles.

Simply put, if the kernel driver cannot directly connect to the node, 
the processor / network entity handling APBridge tasks will need to 
cport information. And it probably is good to make it possible to 
separate APBridge from AP in complex networks.

Feel free to ask questions if I was unclear regarding something. Also 
feel free to correct me if I got something wrong since I only started 
working on greybus this summer.

Ayush Singh

