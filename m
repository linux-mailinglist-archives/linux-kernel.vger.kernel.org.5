Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DD2758BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGSDEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGSDEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:04:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4361FC1;
        Tue, 18 Jul 2023 20:04:47 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6689430d803so4354263b3a.0;
        Tue, 18 Jul 2023 20:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689735887; x=1692327887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZNPhP+wj/HoMzVm6Rc/U05zyeoKOMtrG5lYVQc+XuE=;
        b=oDF/pR/t3FvGjNFGbdz88pnVM1eIdIZA79+ljFSLHup57bVnTjXYZcs6Yx/agE0S7h
         7pu+X17xdhW8UBu90lvLuHOXLOWXqeS7ACdGozEmVR4ZGsur1qBZKzfDrX7APULPhM/X
         aEVDuL8N1FQeX8ZhgF2U4hDabQBilUzLhhkJV4TfTpDiwLFCr5Vqe6a+7pKM03GOFl4L
         nZcF5Kk3Q7/Avvc70wnAdQfzID3dkUwJ5XxXtrQ5velSOcZvlT0S4g42g1kjoMQK2IaK
         Kr+kOknggc+mBrEcIWuL0YHv1BfmmRdNdQLUUQ4S+y30JYGYJT9cAECgoJIk6+a3VULi
         o4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689735887; x=1692327887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZNPhP+wj/HoMzVm6Rc/U05zyeoKOMtrG5lYVQc+XuE=;
        b=dBUgPAjbCxJvbssiRMBqet3ySF8PJ8p0P0KitpJ3Zx9M2thUQcOi+cZ0bK5+mC7nX0
         gwi3NbYZIZy4Yfmk2Jvfjc9/EbnksADJg16GHAqwDSWyAjwdwPToQPzMnRDz7HceCJGU
         CjCgxlVJ7WssOSgZWk8afcDtM3UJRVKtyHfLoylILZmLEoEH2DLE+bfxp+yDLsndm3oR
         tHfa1h2SrCm9t9r5D/8NDpTjNPrq1gpQmuY2dEFljz+wAO6Y7rNqvGufX6HmJkVw8kXy
         6d8Pc6Qc8BYRMTYhUHj88oj7X2JkN7HWMaNSzikmQcTkHr08x04uaVXpN9o69xVWjk2E
         lAiQ==
X-Gm-Message-State: ABy/qLbT7RH+6koEI57EvZlHjZStwqtLC7Y97XbsUa0VlW8BKT9QahqX
        p1OUV59vZO6PMkTAKZZ+y0Zg3ax1ehQ=
X-Google-Smtp-Source: APBJJlHNl8eQuROj3ZjQ6ZmwkEkqpxZjqZrDJK1Kyw3QbgQV7/9cUPPxozGFlvjETG5JUboVJLtM5A==
X-Received: by 2002:a05:6a20:734d:b0:134:15df:b148 with SMTP id v13-20020a056a20734d00b0013415dfb148mr1086679pzc.29.1689735887066;
        Tue, 18 Jul 2023 20:04:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c11-20020aa78c0b000000b0063a04905379sm2191171pfd.137.2023.07.18.20.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 20:04:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jul 2023 20:04:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v2 4/8] hwmon: (pmbus/mp2975) Simplify VOUT code
Message-ID: <40f4b633-8f71-4760-9dff-9484f7fb74de@roeck-us.net>
References: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
 <20230714135124.2645339-4-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714135124.2645339-4-Naresh.Solanki@9elements.com>
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

On Fri, Jul 14, 2023 at 03:51:12PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> In order to upstream MP2973/MP2971 simplify the code by removing support
> for various VOUT formats. The MP2973 and MP2971 supports all PMBUS
> supported formats for VOUT, while the MP2975 only support DIRECT and
> VID for VOUT.
> 
> In DIRECT mode all chips report the voltage in 1mV/LSB.
> 
> Configure the chip to use DIRECT format for VOUT and drop the code
> conversion code for other formats. The to be added chips MP2973/MP2971
> will be configured to also report VOUT in DIRECT format.
> 
> The maximum voltage that can be reported in DIRECT format is 32768mV.
> This is sufficient as the maximum output voltage for VR12/VR13 is
> 3040 mV.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied.

Thanks,
Guenter
