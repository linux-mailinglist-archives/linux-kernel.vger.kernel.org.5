Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E307D7840
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjJYWs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJYWsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:48:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F72DC;
        Wed, 25 Oct 2023 15:48:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52f1ece3a76so75650a12.0;
        Wed, 25 Oct 2023 15:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698274101; x=1698878901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1Wtmp4jaolI15oZgo//tqFOl12QGRnI6l3LLvFOdIo=;
        b=U83LbeJsPMbNS/WRwMi+2qBbGCZ4iQ5H96JZbz4sKNsitHkFQwPHuo96qM+NTzkxg/
         2AZaFMm0RUXWpbPpRKN2rI7WA5kdlRPdb9Yq402gnLRSuBFlVm6z4QmFKSZhew4G/Cqn
         RKbFGRFDiU0s5KPgi4+3UeQENDpfn3o7HBlOZvb0fiJcV3w/FURa3qS5ai/q4i2ELQnt
         kRd9WdKfL/90CndpwIpoXfEoJlKOJYva3WQ6fWpcdyNOEEVRx80orwJao7AHUhJ7E2ux
         1TBWjtD52HNeClUq8ZrvIEWjDJDmPsC4Po32f9m4EOkyNUK+z/rIgojLsZ18zWRPKqD6
         7Zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698274101; x=1698878901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1Wtmp4jaolI15oZgo//tqFOl12QGRnI6l3LLvFOdIo=;
        b=cEgmk4OJTW2qWUbt+mC4KsItOppCltNxJXav55yvWTsypj5IUW0GqVuELTNneOptWo
         5RTndxjAHcDRrrdJ/N/tL7XgL6VdECVgDImw5iSuu2P0atZsvU3LF+6+P32KKjXYN+TB
         8m337+5pZHFzN8WSTDIiwrFy3GsxHEVR47JlleEBlAJZXU32F4h/GzzMxgqRbICADtt9
         HZUk8Ki4y4fO4mqMSPxxNc91iFSeEoz8IeCfSb1s7DgMnxjbqH/VZ3bDW0bHwFFCX+O5
         zYs/dBRxCLgmj9YkdZaE+IZVhLssVVZ36BWCLPN6c3+O7Nt+6LXx+yy3bJYkrfJl/6Sj
         SG2w==
X-Gm-Message-State: AOJu0Yxh6v8s0wjWQNl3UJikJQDRiIXOV8qhKBPAnD5SZd2s9h2GNmAW
        rgyBI/8GUgmuRbRDrejKi+M=
X-Google-Smtp-Source: AGHT+IGZysA7t84XKVRzSA8XE25oFrQWSh3/UAeHsseDmefuOjgMHv8S1Go5CrpHtdDA4m4jNf1AlA==
X-Received: by 2002:a17:906:21b:b0:9ce:c4f4:5f97 with SMTP id 27-20020a170906021b00b009cec4f45f97mr243735ejd.1.1698274100762;
        Wed, 25 Oct 2023 15:48:20 -0700 (PDT)
Received: from [192.168.0.103] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906011a00b009ae69c303aasm10545728eje.137.2023.10.25.15.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 15:48:20 -0700 (PDT)
Message-ID: <c608f328-387e-431b-b3c2-4b8fa0c4f11f@gmail.com>
Date:   Thu, 26 Oct 2023 00:48:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] [RFC] wifi: remove ipw2100/ipw2200 drivers
Content-Language: en-US
To:     Witold Baryluk <witold.baryluk@gmail.com>, arnd@kernel.org
Cc:     Larry.Finger@lwfinger.net, alexandre.belloni@bootlin.com,
        arnd@arndb.de, claudiu.beznea@tuxon.dev, davem@davemloft.net,
        geert@linux-m68k.org, geoff@infradead.org,
        gregkh@linuxfoundation.org, gregory.greenman@intel.com,
        ilw@linux.intel.com, johannes@sipsolutions.net, kuba@kernel.org,
        kvalo@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        nicolas.ferre@microchip.com, pavel@ucw.cz,
        quic_jjohnson@quicinc.com, stas.yakovlev@gmail.com, stf_xl@wp.pl
References: <CAEGMnwo6RFqADPO5FRkRUNL=GfV6DY8UuwgsypEYOD3LTnXdJg@mail.gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <CAEGMnwo6RFqADPO5FRkRUNL=GfV6DY8UuwgsypEYOD3LTnXdJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 00:27, Witold Baryluk wrote:
> I might be interested in modernizing the driver, but I have no idea how 
> much effort it would be (in terms of changed fraction of code). 20k LOC 
> is neither small or big, and not obvious (a lot of it would be 
> unchanged), if it is a week of work, or months of work.

Hi Witold,

I am trying to do this with rtl8192e.
One possibility is to take the following patch series as a starting point:
https://yhbt.net/lore/all/1414604649-9105-1-git-send-email-tvboxspy@gmail.com/

For me as a beginner and hobbyist this is a huge task. I am happy when I 
can finish it until next summer.

In case of questions feel free to ask.

Bye Philipp

