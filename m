Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5F480BD63
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjLJVjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 16:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJVjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 16:39:11 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728DCCF;
        Sun, 10 Dec 2023 13:39:18 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-35d3b220b64so15857025ab.2;
        Sun, 10 Dec 2023 13:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702244358; x=1702849158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lW0H7+bFSP6Z58s2PRDDO9oFTOkEf9fiSxOV+rclK5U=;
        b=I0OGpeCoPSC5AjbZxAG7Wd+ZxY3BneLE9DuC6YfkU9GU9Q0OHiJzrlhSqvBHwJBMYU
         WW12d+yq3Zd0dQjajt8EpIrzWw+83w9PXTXEDq8oLcOqfX8gh3fNEEmqfT62nlazm2gf
         4SElrgFIO2aa/buqnNiWpoOWnfNc2Xhtl6C3i6y+I99tto5PauEBw1Y24hJS5xhcDdKy
         TwdU7izSqfWArmssltMCtfGsrqUZT3llXO+T0u1wv/Y/7nbyyv3ejqftgealPrARnTuK
         QRhF9K8LNTKMZGOH3eRee0VWSbCaWB2wauLdiMp4pSXP0++4gZ1j7gX7Af4+iV8UW8rr
         3VFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702244358; x=1702849158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lW0H7+bFSP6Z58s2PRDDO9oFTOkEf9fiSxOV+rclK5U=;
        b=rkQ4Mvs2v9c6EJH6PVWugW74mpTy9ewe4JIioIcvTUgJCfdqkZXbeT6ngRTVY6th47
         AYrD2ox39vL6LDvigke27gil889Kmbb3eA5nPUu+icF6iywzLv8n+1erDRiYnw9YN6pt
         ZWn+Jvc3RkUX/giNG3Zs583twR/msNs78PpipTIP16wriqwYR285eYn1RraiTydu1O8h
         m0QNox7HpmT2Sidb+C3Vg0lLn6FvBxzLdLdUHqAXhUO1/1PUOFVggu6idKftKPlJmknJ
         QcoWyjNRMBt207Kzx/Lt0s/IDHdNx6Zc2z1s31TQnq7rUEMq+QhgZ6g1zKtW6BQszEdm
         VM8A==
X-Gm-Message-State: AOJu0YyHBW8r0uTVNpvhywr3mR8gEmr/WZhz5PKoOmhDINXZcJcceUbc
        4Azzv0sY5HXy+noDDVLsHzQ=
X-Google-Smtp-Source: AGHT+IEfR1CNt2C5uHaB99LgUusnZSMmCOupCUHNisNFJVmcedHgQbJz+pXfphrNnpzQi+C0ePj5LA==
X-Received: by 2002:a92:ce06:0:b0:35d:7f56:17f3 with SMTP id b6-20020a92ce06000000b0035d7f5617f3mr2934138ilo.65.1702244357619;
        Sun, 10 Dec 2023 13:39:17 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:37c1:804a:cea4:fc4e? ([2001:470:42c4:101:37c1:804a:cea4:fc4e])
        by smtp.gmail.com with ESMTPSA id p16-20020a92d290000000b0035d6c524cc8sm1905559ilp.76.2023.12.10.13.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 13:39:17 -0800 (PST)
Message-ID: <7984df40-e365-f190-2af5-41073b72403b@gmail.com>
Date:   Sun, 10 Dec 2023 14:39:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] xhci: Introduce "disable-usb3" DT property/quirk
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231208210458.912776-1-CFSworks@gmail.com>
 <20231208210458.912776-2-CFSworks@gmail.com>
 <d9ebe207-1f20-4254-9523-f2231bf9a0a4@kernel.org>
 <9915035d-88ce-f961-00c0-fad24aa07764@gmail.com>
 <bceffb44-037a-487f-87d2-15f1b3a4f9ed@kernel.org>
From:   Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <bceffb44-037a-487f-87d2-15f1b3a4f9ed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/23 04:10, Krzysztof Kozlowski wrote:
> It does not really explain why you did not Cc some of the maintainers.
> If this is a RFC, even though not marked as such in subject prefix, then
> I guess all maintainers should be involved for comments.

Hi Krzysztof,

More simply put: I don't want to waste anyone's time by seeking 
review/commentary from linux-devicetree on a property enabling a feature 
that someone here on linux-usb might soon deem (summarily) untenable.

I agree fully that I need (and want) the DT reviewers' sign-off on this 
new property, and I'll get more serious about that (and other things) in 
v2. I just need to know if there's going to be a v2 first.

Warm regards,
Sam
