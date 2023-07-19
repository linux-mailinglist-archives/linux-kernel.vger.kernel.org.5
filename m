Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4C8758BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGSDKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGSDK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:10:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709341BE9;
        Tue, 18 Jul 2023 20:10:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-66f5faba829so4747133b3a.3;
        Tue, 18 Jul 2023 20:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689736223; x=1692328223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3gmjeIbhs1mQLBHy8EP14jHfjhXUpW2y/Th6p56g5w=;
        b=gr6mr/dukfvtaK8c2pqid4465XKPyWkwyDp9r88vLROonuAIhD1C5i6ZwW8pjeEa8y
         LD+kdsqig7Ky1dL1XfZtVEXDdg364za5NY/8gMO1vo0D9+lA2J8BtkdxCgCcGDhrFvXh
         MK51DYbHE+Ewoq1fCXFqx5UW9/DphD1UWTPLFDLvwNz648AsxfrZ67nDzK+ASkzCqNgc
         DojxT+8/gXxc+1TrosmvcPcZZmRuQAUihRJgcwH54XnpQVlOBt3TeGNDB0EXLGmlZ18T
         n774EU98tTHVFAYPiW76511AM1FykHsi6N9SFwFAb0cFGxKUOWMzcug81URF43eL4Dr1
         XYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689736223; x=1692328223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3gmjeIbhs1mQLBHy8EP14jHfjhXUpW2y/Th6p56g5w=;
        b=E1QoYKhBVIoOJVvjCYruBQ3FU2XepBCftw9MIh7jzx119jpHnPc4VtwmqdCTM9Qws+
         E8CcylU8j0kp+BJvNXPj6QqTetr9wVxuhfNTdjAUkwtnU2FjHIkVJJOzfy/6aRpVF+ku
         PF+derCHJ+dSFOGzaBNG7PF9UZZfQ1QYbG2f+be0la8lMyfORtR9sErmiJD22mV7GL91
         5v4/0skgdpclhsCekJDJgH/RooVxLsAv9ghqhOPffU0lssKI3JML8VU65n9bkkaY3/Lp
         E+BKEdQk9OXQ354hTbRXygsvQLBUxCrsy5XfLBaumpinjIANgoqSVPEFmYQuteEY2SUh
         ul3g==
X-Gm-Message-State: ABy/qLbR/uLUCpWvWrH+IrHVZ2q57SDG0HrVkh+aEfX6ogTWQU67sdFG
        +FPosV75TS6Wuxo94ea2aMI=
X-Google-Smtp-Source: APBJJlEedlbpT9pfoF8gh+ojDzk3ZAOPVHbuRsxHlwzjd/nrsKCqdLV0HJyVo0WaliG90GxH/2HezQ==
X-Received: by 2002:a17:903:32c6:b0:1bb:3a7:6af7 with SMTP id i6-20020a17090332c600b001bb03a76af7mr4854877plr.23.1689736223149;
        Tue, 18 Jul 2023 20:10:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902eb4a00b001b895a17429sm2568300pli.280.2023.07.18.20.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 20:10:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jul 2023 20:10:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v2 8/8] hwmon: (pmbus/mp2975) Add OCP limit
Message-ID: <67e909a8-0b19-4aee-bf90-4ca047f362cd@roeck-us.net>
References: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
 <20230714135124.2645339-8-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714135124.2645339-8-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 03:51:16PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add support for PMBUS_IOUT_OC_FAULT_LIMIT.
> Add a helper function to convert the limit to LINEAR11 format
> and read data->info.phases[0] on MP2971 and MP2973 as well.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied.

Thanks,
Guenter
