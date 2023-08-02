Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD776D102
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbjHBPGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjHBPGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:06:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0282830DD;
        Wed,  2 Aug 2023 08:05:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686f38692b3so6676977b3a.2;
        Wed, 02 Aug 2023 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690988732; x=1691593532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PzadGlULFzQVJWWvB++6o5+mmWXFSdKSmJT1jbq3YkI=;
        b=WCLO2YcbMrKo6eePoovLntMmgFULUdd75VQFA+0Z2jOf9QY/X/IPpsGXnJr4oQ1GfP
         Y7nU9EduI17HM5bFX0apyYWTi+u+9/GU+ObnksoEncBYmocBD0ObZMewInze9B5AupRH
         bQAj+7sD9rm076tbktrAPN8uHCT0rTf58N0IxYrKqlZzBmQvr1EzuqSsqFpEWzamfwZJ
         RwLhtSQWnJKBfjEaz0X1V3XXHhzvSZsWmmXUR58DW1xCAeT2Zbrq5+XTG2AlHMqIP9hx
         8EnL0WejvkFh5mfrH/T73RTAf+KZOW3oyD+kafbBlb6Ay4un22uKnGwweWfw9gxcr162
         Z2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690988732; x=1691593532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzadGlULFzQVJWWvB++6o5+mmWXFSdKSmJT1jbq3YkI=;
        b=RY9iSzHFqgPJWcoJpiZmXZZmt/zPOMhrNb2ULjWvdhu5rlRXl4VCX+HwayGcHkRsEa
         GryZFRJZsmktKTyfwKgY9pzVEha712k4f2+InMBBdBTJH85ePykDbd4163qMyjfgoCCT
         /1dQ3qZZsyVxuI8sNUANTDsLdcesYJs1hp3Nwbd+0OMh7hHUQLY5fbsi127VMW2/al9p
         nm0K8F7D8GENFZJ8xnu3vP7Ytqq03nYNS+UgbI1+J2T12l1N4OWmHn3JSgl9vGmQaZEw
         HyOe6AkcKzI/Ejyx1LIhufaXhBCy+wh1AoWN60iAF0IGrJ+qM57ogyiGp5mqwCv51rDW
         KbUg==
X-Gm-Message-State: ABy/qLbtmOe/Ov790DSVW6dxePCQdXM1kCg93MoeuFKp4dvZ4IWb3nRG
        zXHuqOglEsW3jPzyg1iU/vzUrvdSGTk=
X-Google-Smtp-Source: APBJJlHWONgGtJ2QBarYYs0V+4FZ6OsrwdK1jnK6sLA+2GFUIKaQ6XJBOtdyMcs+jkk/NvmrDhQ91w==
X-Received: by 2002:aa7:88d6:0:b0:687:5dfe:a9c9 with SMTP id k22-20020aa788d6000000b006875dfea9c9mr4683469pff.2.1690988732296;
        Wed, 02 Aug 2023 08:05:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x18-20020aa793b2000000b0064928cb5f03sm11162172pff.69.2023.08.02.08.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:05:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Aug 2023 08:05:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Carsten =?iso-8859-1?Q?Spie=DF?= <mail@carsten-spiess.de>
Cc:     Conor Dooley <conor@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: hwmon: add renesas,isl28022
Message-ID: <fc0b3cf7-3bd5-43a3-a1fb-5706180774b7@roeck-us.net>
References: <20230801163546.3170-1-mail@carsten-spiess.de>
 <20230801163546.3170-3-mail@carsten-spiess.de>
 <20230801-implicate-mullets-bd160bbda4b2@spud>
 <20230802093023.1a926c9f.mail@carsten-spiess.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230802093023.1a926c9f.mail@carsten-spiess.de>
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

On Wed, Aug 02, 2023 at 09:30:23AM +0200, Carsten Spieß wrote:
> 
> On 8/1/23 22:52, Conor Dooley wrote:
> > On Tue, Aug 01, 2023 at 06:35:46PM +0200, Carsten Spieß wrote:
> > > Add dt-bindings for Renesas ISL28022 power monitor.
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - renesas,isl28022  
> > 
> > You've only got one compatible, why the enum? Will there be more similar
> > devices that have an incompatible programming model?
> Yes, there are isl28023 and isl28025 with different register addresses,
> might be supported in future releases.

This is misleading. ISL28023 and ISL28025 are PMBus compatible chips
and would be added as PMBus driver(s) (if needed). Support for those chips
will never be part of the isl28022 driver, and any devicetree properties
of those chips would not be described in this file.

Guenter

> 
> > > +  renesas,shunt-range-microvolt:
> > > +    description: |  
> > 
> > You don't need these |s if you have no formatting to preserve in the
> > text.
> Will fix in v4.
> 
> > Otherwise, this does look good to me.
> Thanks, regards
> Carsten


