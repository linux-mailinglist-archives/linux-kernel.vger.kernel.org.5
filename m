Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74A2758BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjGSDHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjGSDG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:06:58 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D9A1BFC;
        Tue, 18 Jul 2023 20:06:44 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a1d9b64837so4727326b6e.0;
        Tue, 18 Jul 2023 20:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689736003; x=1692328003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zs2jiLd+rCjtxlqNbdpcaREYCsXzaDDdr1rUXdltDm8=;
        b=fWpvFvyq2mpfEHRrR/4YvfPrdKOFZguQwE2XyAjFhhYCPkbMSr6cQwGzATz4+m7rLe
         +iY2upNmNLTkrpBVOKof2h/QZgt0UjjHhWrWWdl6iRQQqbNCH7shzZUN7KBR+Nl2T+eU
         YbHfVEDs4AhJ/jSwbEuwpXMmj5VF/yR5jo07vjyketoalp8GBytorIEprVDFraJtIc4w
         0s/ZEHo0Sa1UiefaV47fS7OPEZM/dnpQC1jP19r+ABSAdASDrwqszDmM/WaTwGDAqvTQ
         +HpM5UjKJ8wyaZ3RGNEi2cm1SVLRKFUciSNvXFnxKLnsJpL/FaWGIH0cp3Pj6DL5xaQF
         gUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689736003; x=1692328003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zs2jiLd+rCjtxlqNbdpcaREYCsXzaDDdr1rUXdltDm8=;
        b=DJPzVIIPUuW/8M1zUKAHv/NBjpTD6yzHXLlX/tRfi4wlBBbG3E6VtCWo+VhfEVPSOd
         s1InsVXQnKwjaSh3xEwvxQXrKISPo8vCyRdloDvRMjYFF2MjaOy0CsqTXltuYCMHziPA
         dBKF9SrNq0Mx3XU9sf+DewE+boiTaNgtS8uxtVSNPEltOxZaUnG5gnNjOoN1IKF5r6G1
         y1QY/eraS8bbIKTq58OXYhv6TwUGVYzZtfKEyRI655YsTRdlSdO3k5yaKwXc9lzih+aq
         FySqvO5z0sg74phEP19df/esaCX34Shlcm3+UTsJwK0/Q4eoeiYTxQGIK3tnW+rSkwgl
         oeYg==
X-Gm-Message-State: ABy/qLaYh0KDSQLVxcTLnfAbFcpKJvbSsVV6aYaZMloVeZYwyWaQvSSl
        23v8AVmlhQlgviebzsgTmXEJqTnsb44=
X-Google-Smtp-Source: APBJJlGLIrx3XGA1yLwJYKQQgdoXl1bIHpwBSQa1v+qcNDeMVJbOSnCdUlUIG5OgTTctJpFbcvvX0w==
X-Received: by 2002:a05:6808:13d2:b0:39e:7af4:7eea with SMTP id d18-20020a05680813d200b0039e7af47eeamr5947676oiw.55.1689736003428;
        Tue, 18 Jul 2023 20:06:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a0f1700b00256b67208b1sm253515pjy.56.2023.07.18.20.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 20:06:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jul 2023 20:06:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v2 6/8] hwmon: (pmbus/mp2975) Add support for MP2971 and
 MP2973
Message-ID: <0817fd19-0b69-401e-a25c-6d3e2679b9ab@roeck-us.net>
References: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
 <20230714135124.2645339-6-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714135124.2645339-6-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 03:51:14PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add support for MP2971 and MP2973, the successor of MP2975.
> 
> The major differences are:
>  - On MP2973 and MP2971 the Vref cannot be read and thus most of
>    the OVP/current calculations won't work.
>  - MP2973 and MP2971 also support LINEAR format for VOUT
>  - MP2973 and MP2971 do not support OVP2
>  - On MP2973 and MP2971 most registers are in LINEAR format
>  - The IMVP9_EN bit has a different position
>  - Per phase current sense haven't been implemented.
> 
> As on MP2975 most of the FAULT_LIMIT and WARN_LIMIT registers
> have been redefined and doesn't provide the functionality as
> defined in PMBUS spec.
> 
> Tested on MP2973 and MP2971.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied.

Thanks,
Guenter
