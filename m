Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045527A5213
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjIRSdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIRSdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:33:42 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E970E10D;
        Mon, 18 Sep 2023 11:33:34 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34fe5d0f0ffso4828065ab.1;
        Mon, 18 Sep 2023 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695062014; x=1695666814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JTA1VVN3J1MjDZguKA7jeRxj5alEQOs99WsJuGyCrjY=;
        b=mDvtjFXufbYDzjwsspzT9YtgDG5kuY1CQF9cm5IT0XA2/g412vZcXuIcM3T39BQfrW
         V/TWkKnUUULs1t/ZxZ78YJKpVc79aB8/ZnmH0YKOMTE1yT+c42CzjMbZ6m2hT/mjxBAC
         SVT9ISlyQQ0oRdOGQ0weCyXw6wZyF0/GkZi8IBD2lqL1UFWVWWp3Vj6FoxTk5xaDN7eQ
         WCmkVlvYDj7akOAE9qw5aEXi+bodfLEslJf+o0j8mjNDIoB1la5/3rOk+i9En+Xc3IZU
         QPN+zUWY/ASg2/OLm5ArcqI8D71wkQ5KTMt68UOBJJeUx0IEVlOJQmG/x10WTdgOkJWY
         tG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062014; x=1695666814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTA1VVN3J1MjDZguKA7jeRxj5alEQOs99WsJuGyCrjY=;
        b=Gp8Bw7pdhD1MPaAX5WEVfq/fMItIZHfpq49Wx3a6pQQSQbDhHJov6NJWaEBzAhxBmL
         HsgXB7DL0JsoMVOMJjQ2iGgKg9j/44EdmfwbV6DJUr8+8mpZzsEhpE94/rjXql8/iwsU
         RkZDuFcdWhQTPCK9px7FdzVB9O8qc+mmcP6v7jSvgVkl5JMdLhjp6Kj1YgIHSHm5tCsP
         9+eFkx5aP8pwCZ4tDFsBRDPbeE0Q81RI04ASeCPiAuyru+b+mYiznTq3qgaugPOXw+TC
         ztaFr1H2giHUl2ufdwq+P7AbWy2prprEHfxZq2iPJsCUD0yaT82v8YJAjCP0W2rbnp2U
         D0ZA==
X-Gm-Message-State: AOJu0YwU879rsWvt6mxJvRejq/4jDUjpN/byHULD8bAc6Ya0aQiFf3aj
        zXNqVNyl4wElFNU9eLrFXb8=
X-Google-Smtp-Source: AGHT+IG+I26s4WOtf06vG+cUHmLc7QxIV17q4Uw/P9uvCip5VKX/U1XMB4ehHMXJaS4+IFeGa50bwA==
X-Received: by 2002:a05:6e02:1d8c:b0:34f:75cb:7f0 with SMTP id h12-20020a056e021d8c00b0034f75cb07f0mr14265147ila.12.1695062014195;
        Mon, 18 Sep 2023 11:33:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x59-20020a0294c1000000b0042bae96eba7sm267655jah.7.2023.09.18.11.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:33:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 18 Sep 2023 11:33:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 000/406] 5.10.195-rc1 review
Message-ID: <562e05d9-8559-430d-95d6-8873bed61223@roeck-us.net>
References: <20230917191101.035638219@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 09:07:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.195 release.
> There are 406 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 495 pass: 495 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
