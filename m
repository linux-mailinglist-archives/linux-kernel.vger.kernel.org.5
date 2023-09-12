Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2E079CBF7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjILJgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjILJgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:36:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4C612A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:36:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4018af103bcso34224655e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694511397; x=1695116197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I2E1gO44gErvLCsLkrEiV4IXvDnQB78+GoWRxTmFEOc=;
        b=CCwAPZ9j+KS8qsxwr3/KiFhre/dOcV9GbRErTdYdrP5HxazJnO2+WXaSbi6gqfQNfZ
         XAJS/BndpMZIJYXTyAjOAqdzXL9NMeDVQ9z13o4GpS/h64vpL4+S6hWwINCVcWOHZEQA
         u17lmS6ADplFa6S8/SEaecZ5LRgnDrXuHpe6xbjQyJh94kC5q2KMuSz8jWGgDGCQlLuC
         EQyVyNcdmqjZDuvz2oRnx5xY08gFSQFf/2/plnpZ5Eevn5v0v9YM8lk2jjBbjQzNl/dc
         nrusjDM3fwiS5ZkM1X+CYfUtv2i4eGgQLP83a2XLO8CuFr3xkrNtDAPvA1/tK2t2yc4l
         yxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694511397; x=1695116197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2E1gO44gErvLCsLkrEiV4IXvDnQB78+GoWRxTmFEOc=;
        b=EaW7nzinRO/uuBSjMZG6/e5JMKHhPHRQNYcmq35duz8N6f/wY7u7+yITcdbdZ64CSN
         FQNqo1AIjbRuT5oaXfOpSGuk9JGKc11l9QoB0xd05Ccw/ipJzhYjMKYioNnjMvIygnqt
         hOAi/uGOpzbyiEF4xupZxg7N3o9OuBJ4nnMKlhZ0362nnAU4czJaF8pfhG2y01/5qwXv
         PuI++Vi7TNlGBqGseGK+g8Wqcn6JaMzeFdmsPwLj4x+O+udLwF1dpAenwOnAFbcrNEFZ
         JxAzqTFXINHGb8EaXqKPBW/nmtpTzIbYjKrz1++luwAAa5NFnypbQy22rs4bydiFSFqC
         p5VA==
X-Gm-Message-State: AOJu0Yzx2dX8P3+LjtSRjzW6RceRqmjwhpWVO+K/INpGHoRPV3xcskn3
        wY8+qTAyFYOwkRVcaaKpshyHs08XFX4bF9MTubY=
X-Google-Smtp-Source: AGHT+IGjBJQH7mzQfXAu5lgRUFXAuZoXiTMnNJmrtnG9tLxPqOp7DMt1gBEzDZ1OIOn09IbXJS1ing==
X-Received: by 2002:a05:600c:4e50:b0:401:b393:da18 with SMTP id e16-20020a05600c4e5000b00401b393da18mr1425536wmq.6.1694511397094;
        Tue, 12 Sep 2023 02:36:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id o8-20020a1c7508000000b003fed7fa6c00sm15780383wmc.7.2023.09.12.02.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 02:36:36 -0700 (PDT)
Message-ID: <af1959ce-d817-2a9e-9c28-fed8c608a3df@linaro.org>
Date:   Tue, 12 Sep 2023 11:36:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: add reserve-memory nodes for DSP
Content-Language: en-US
To:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
References: <20230911224452.15739-1-iuliana.prodan@oss.nxp.com>
 <20230911224452.15739-3-iuliana.prodan@oss.nxp.com>
 <67de5706-d966-dd71-85c3-c95bc1b72733@linaro.org>
 <c0b32f41-46b4-81ad-9718-5f0856e42cb1@nxp.com>
 <32287c0a-e3c1-e474-3c90-913fe2c79879@linaro.org>
 <fe47a94e-6788-a5ee-e8ee-ca58e4fa62d6@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fe47a94e-6788-a5ee-e8ee-ca58e4fa62d6@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 10:49, Iuliana Prodan wrote:
>>> Should I test this on other tree(s)?
>> You test the patch on the tree you send it. What is the point to test it
>> on some old code, cherry-pick with bugs and then send?
>>
>> If you have cross-tree dependencies between subsystem, isn't linux-next
>> for this?
> 
> TBH, I don't know, that's why I asked.
> 
> For sure one patch is for remoteproc.
> For the other, I don't know who will pick it, but I'll tested on 
> linux-next, as you suggested.

MAINTAINERS file (and get_maintainers.pl) will tell you. Specifically,
this does not look really related to remoteproc patch, so it should not
be together in one patchset.

Best regards,
Krzysztof

