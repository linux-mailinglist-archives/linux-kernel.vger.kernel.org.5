Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559BF78EF07
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbjHaNya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHaNy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:54:29 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DD5CEB;
        Thu, 31 Aug 2023 06:54:26 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34cc8e8cbd4so3008345ab.0;
        Thu, 31 Aug 2023 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693490066; x=1694094866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOuGqkTcGQRx+iRAXqiXLaMEVlHPNpp4SZcX65o0z1M=;
        b=FD1HmsSGzAp1CUgK6vy8Lq8vO17MpqifwlWnYFg3jxlVU8yHPCXjDnzJn85OOVQs/i
         vp5CSdICqjNgjy+CGU9e1y/MqBH9o0SLv4vRrd6ESAbKBwf63kPF4LdGvHGFTz2msyX9
         NCmZTgAS6vVuf7m/Vt/xMoUc4GGGpujzpq8uSTrcGMQEt5O0kHQZee7Wvgy+nxc/UZG4
         8PzJwImFXeaDzyiuQWivvnW5q1OUL8Cxq82q1oatJqFbUaNxHbG/0kAJHThfzwjt7eNH
         8E4gM1rSSbndVox82ruik3Vy0W9ool5p7s+znKmkmH+YIWqrggt7ME8GgprdPtr1OI0J
         Ga9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693490066; x=1694094866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOuGqkTcGQRx+iRAXqiXLaMEVlHPNpp4SZcX65o0z1M=;
        b=L5keM/9CrJscWQbLOGGHIMsxE+9e+a4g8TBFqbOnZsI9Ke9l1ajP/OXCcLN9ev7Du0
         AG5j45SrPH2lXgXNdPO8MB+WTXY9vOprbJ9dqn267vr6vbV73xkozNUymd2kNaMATvmV
         KFenWmrsvrKNNASkeq6HvOR3S/rIogGxzutM8LROaxmWoC8mp1S4DZV3QfZioY9SYaHI
         DBQTxwfRKr+zxerJoYtKMc5FfRneSsNoKCKUUxcN6NyYFB6ve2YImNzFhR/stI7JrAbD
         i4t89YQ5m8TOs94Y3vOfpSn8br/bt0ioOI+ynDwS8dXJi1XPzXkuNVMV4qwSp+ZQyGMD
         xgpA==
X-Gm-Message-State: AOJu0YzYSYk6ntQ+zloUxfj3IhREjl460yzOtiN7SBiXckO5DNozShwx
        SDLxXMW05SlnhumMZvlPg98=
X-Google-Smtp-Source: AGHT+IGue5NC06PfG1MsWTONPo4UfzRset+l1+uMMwOHPf8RfejHUNkZRXAmOAc3Xcbd/j6fVXDfSA==
X-Received: by 2002:a05:6e02:12ee:b0:34d:ec00:2ce8 with SMTP id l14-20020a056e0212ee00b0034dec002ce8mr6046377iln.21.1693490065627;
        Thu, 31 Aug 2023 06:54:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id el17-20020a0566384d9100b0042b8566a982sm420395jab.41.2023.08.31.06.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:54:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 31 Aug 2023 06:54:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, vkoul@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/6] mfd: cs42l43: Add support for cs42l43 core driver
Message-ID: <12eb7505-19b0-4341-8ec2-be42d6f94c9b@roeck-us.net>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-4-ckeepax@opensource.cirrus.com>
 <b122a788-acee-4747-be6d-a7456ee110dc@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b122a788-acee-4747-be6d-a7456ee110dc@roeck-us.net>
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

On Tue, Aug 29, 2023 at 07:06:29AM -0700, Guenter Roeck wrote:
> On Fri, Aug 04, 2023 at 11:45:59AM +0100, Charles Keepax wrote:
> > The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> > (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> > for portable applications. It provides a high dynamic range, stereo
> > DAC for headphone output, two integrated Class D amplifiers for
> > loudspeakers, and two ADCs for wired headset microphone input or
> > stereo line input. PDM inputs are provided for digital microphones.
> > 
> > The MFD component registers and initialises the device and provides
> > PM/system power management.
> > 
> Unfortunately, on systems without pm support:
> 
> Building s390:allmodconfig ... failed
> --------------
> Error log:
> drivers/mfd/cs42l43.c:1138:12: error: 'cs42l43_runtime_resume' defined but not used [-Werror=unused-function]
>  1138 | static int cs42l43_runtime_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> drivers/mfd/cs42l43.c:1124:12: error: 'cs42l43_runtime_suspend' defined but not used [-Werror=unused-function]
>  1124 | static int cs42l43_runtime_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/mfd/cs42l43.c:1106:12: error: 'cs42l43_resume' defined but not used [-Werror=unused-function]
>  1106 | static int cs42l43_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~
> drivers/mfd/cs42l43.c:1076:12: error: 'cs42l43_suspend' defined but not used [-Werror=unused-function]
>  1076 | static int cs42l43_suspend(struct device *dev)
> 

This patch now made it into the mainline kernel (without fix)
and breaks various builds there.

Guenter
