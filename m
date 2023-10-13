Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47FA7C8B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjJMQYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjJMQYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:24:45 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D474AD;
        Fri, 13 Oct 2023 09:24:44 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1e10ba12fd3so1282755fac.1;
        Fri, 13 Oct 2023 09:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697214283; x=1697819083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NZs5dBVvL8WiMBXWyFhU0nbTUlLlApXVMkA85zryGNY=;
        b=Ho/xQ+kgGBY9yeCPbzCClAClbMqAfLLdCDKhCwRwnxQWJEUFxyOjOySV8YVKoQJ5Nc
         0nDe1uZbxcMQ27P6tPms6cn7z15pCJ9F/w10oPNoAoWPdYrIVraRP+QqeYqTdzG4FQso
         7FxxgpCwz13DJN5d7xNj9tXlXTx8wWTLtzcJJTgbL05u56F/Ujve1SmSX7EkVTAfmLQ4
         VUK5XtDHnnMo857v3kZ2fHHBQ2MSruPyICpZXOsw8ENkckqJsFXFOxFmoEPsJiPft51M
         CFPEAN1fSvJYocEGy7Sj+H3bgF2cD97eiaXJ8ifPBtRow6GeDgFbd3lTVd7YIVsLZJ0D
         EpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697214283; x=1697819083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZs5dBVvL8WiMBXWyFhU0nbTUlLlApXVMkA85zryGNY=;
        b=tk2NdX7xXPY3SHAf9knYiNaHMaNwL1LawqjybN4jXI8COHQXRLoBv/jIdLqs2PK617
         YhAPlVPWM+35dbt9v8oiZl22hD2a7J00HKWWmAHqzi30my0zFyXjMH8yu0+o8RrRb0If
         7JgJRXRQ4j0MOfSobbJpZxlkwa/2YWDewGKNVD8rhW5uufW5dzWdWRK0Q15Tmnygiek4
         +hRNsvKMaatnS9yd4zFII7hpyPX8UWMLc40RuACdMN/Sj8hRT0MgvT3DP/ruhsz4zL8B
         I+GJfpAzUchukFIfhTm8f17Qm3jITtescMzUx34hbKcdr27S1X+nKUAAvWTBDT+nuOwc
         cjkw==
X-Gm-Message-State: AOJu0YyFJ8eq2K7K876KpgLkg8qy4MvDpis6Dxh1gbl6vJ4C25gt1d+K
        EN7lJ9ucMGnn3z5p5UBYxi0=
X-Google-Smtp-Source: AGHT+IFGYCd/N+rPNVxVUr5XyZgvZlE2KWP/I3hCNw8Dr+H1r9wACkBJTRNdNs5V8axQznfFCLtaQA==
X-Received: by 2002:a05:6871:5319:b0:1e9:9469:a858 with SMTP id hx25-20020a056871531900b001e99469a858mr8477450oac.39.1697214283317;
        Fri, 13 Oct 2023 09:24:43 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id m3-20020a056870a10300b001e98fa5c9edsm818649oae.40.2023.10.13.09.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 09:24:42 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <56fe16bf-3fc9-49f9-9646-c236b885afa5@lwfinger.net>
Date:   Fri, 13 Oct 2023 11:24:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Jakub Kicinski <kuba@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
References: <20231010155444.858483-1-arnd@kernel.org>
 <e93e4008-65c5-4f1d-812a-64b48f0513a2@gmail.com>
 <c8f43e1b-aed1-4b45-ba7c-d896ff66dfa7@app.fastmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <c8f43e1b-aed1-4b45-ba7c-d896ff66dfa7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 10:36, Arnd Bergmann wrote:
> At the moment, I'd suggest focusing on the drivers that still use wext (git grep 
> -w iw_handler_def drivers), if we can show that rtl8192e, rtl8712 or ks7010 have 
> been broken for a while, removing those would help with removing wext altogether.

I do not know about the the others, but rtl8712 is still in use according to the 
flow of questions I see on a GitHub repo that I maintain.

There has been some recent effort to convert rtl8192e to use cfg/nl/mac80211. 
That one is problematic as it has the same PCI_ID as RTL8192SE, but the drivers 
differ. Note the special code in the probe routine of 
drivers/net/wireless/realtek/rtlwifi/rtl8192se to detect if the wrong one has 
triggered the routine. That code should also be in the probe routine for 
RTL8192E with the test negated. I have both devices, but it has been a long time 
since I actually used either of them. I also have an rtl8712 device, thus I 
should be available for testing.

Larry

