Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6662C7F2E37
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjKUNZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjKUNZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:25:26 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C351BB;
        Tue, 21 Nov 2023 05:25:21 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548f0b7ab9eso1538886a12.3;
        Tue, 21 Nov 2023 05:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700573120; x=1701177920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m92K+MDAt/mcnsYqpnD286mgL18e1jbSNxgzizE2vc0=;
        b=W7mHQi8aZJ2Nznt/WNs2ca+gIJIpgdRsuk1a4k8DDHissX1pw1e0UITDIaxR7uBHBE
         Zu4XVCaBtyGefLzZcwtC2DTEXJNVuAC+4oSsHNLte6FLzP8ti2zIhW5f9/yci1l9l/Ua
         BJgrJnOdePfgiezEhXlzkZ1e4GME8dMucjFcu12zKjSsnNVCR4wP0iECbmqVTCRsXoYG
         19czRi2Kmu/h4mV9Lxu4KIni2Y//d3EnQZyPDbECWhmp2ucvySmta5ymT+MrQp/jcsl7
         f3+FSF8YONGOmx/8lA43Ju152/dr2+EJ8qhM2FkblIuwIHIqvawaNBq3JeHM7ZX3TrpP
         dZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700573120; x=1701177920;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m92K+MDAt/mcnsYqpnD286mgL18e1jbSNxgzizE2vc0=;
        b=jV+F4J0aEI+AjAv8uCi9vCHPiHmumkl8gLp6W06gnaPw0MGFkUYVZW62hFUeuZEeDP
         DRxOuko5763ABSMROmGaE+nHtULTc7u9vPJWrX82YRksuRQ3W80Wl8XGvqc25D3cboUe
         g6fi392llOhm64rk608H/0L6mrMnpJhecWjyw7P06aYydfD9qcLEPSEfdUghzmcQ9nZU
         TVt+gvzmTly+vVy5Jt3BqQKjW28Cf2lmojtlJ0QFvQVIJmBkF90XbvIHlExaTzz8URMN
         IsxqJv37jd1fi8hBXLjqf2WjLGp69nGVk6dEiWzrkisk6lFMWDkPCycbgCLJ3JlhhviR
         2NLg==
X-Gm-Message-State: AOJu0YyhOU8sqWG5UKPFyUdGuQ1ZPIlEpmTkKYK1fpb0xgwIGUBuyURH
        WcuaOZHRPPJAOz7CzA/7qyg=
X-Google-Smtp-Source: AGHT+IFeVg0d+ORZfLoV2hl/dUB5IqhT2S/nhE3hYYfAZSZypJJtkrq2Fw+2ndptvfPv114T0zoi/Q==
X-Received: by 2002:aa7:d8cc:0:b0:540:97b5:3719 with SMTP id k12-20020aa7d8cc000000b0054097b53719mr1597855eds.25.1700573119970;
        Tue, 21 Nov 2023 05:25:19 -0800 (PST)
Received: from ?IPV6:2a01:c23:c095:ed00:bc3d:5c69:4067:a24b? (dynamic-2a01-0c23-c095-ed00-bc3d-5c69-4067-a24b.c23.pool.telefonica.de. [2a01:c23:c095:ed00:bc3d:5c69:4067:a24b])
        by smtp.googlemail.com with ESMTPSA id j19-20020aa7ca53000000b005488ae52752sm3212156edt.18.2023.11.21.05.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 05:25:19 -0800 (PST)
Message-ID: <c636a24f-0390-49a2-9012-9abf9794abc3@gmail.com>
Date:   Tue, 21 Nov 2023 13:25:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-gfx] [PATCH v4 00/20] remove I2C_CLASS_DDC support
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, intel-gfx@lists.freedesktop.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        linux-sunxi@lists.linux.dev, Jonas Karlman <jonas@kwiboo.se>,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jocelyn Falempe <jfalempe@redhat.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        John Stultz <jstultz@google.com>,
        freedreno@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
References: <20231120214624.9378-1-hkallweit1@gmail.com>
 <87h6lfo53n.fsf@intel.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <87h6lfo53n.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
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

On 21.11.2023 09:58, Jani Nikula wrote:
> On Mon, 20 Nov 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> v4:
>> - more ack and review tags
> 
> Please do not send new versions just to record the acks and
> reviews. They should be added while applying the patches.
> 
Right, typically also patchwork interprets and shows A-b and R-b when
sent as a reply to a patch of the series. I sent a new version because
an A-b covered multiple patches and was sent as reply to the cover letter.

> Thanks,
> Jani.
> 
Heiner
