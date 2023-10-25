Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090E57D7549
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjJYUN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYUN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:13:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AD012A;
        Wed, 25 Oct 2023 13:13:52 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so124833b3a.1;
        Wed, 25 Oct 2023 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698264832; x=1698869632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9eul69pshen1s/x7/gzxYAUPoCheVot1DPXycaxP8A=;
        b=ja/PCQCGr21k+6K1bXO7BY6m+bb3MszRUKp1tU9+EWqte2nXDGjZdR750hisT6UmYb
         GezTAOIlHgRNKFcERyNbMIRYXhs8B4a4DJJ60XyPN2GSbzhblHwxZvIeC29lgzUMRF3e
         T9fGexwnydWijYn5NHSE7GwCAKnyPrHnZ8VL8oH/FG/SrwVQfX146fPzFN4WfUms/3Hf
         FSeA76oYlkOxBklnycr3Yn4E/VFrMR+ayAsCR2avMjzKtTYW94DVh7AhMtU/IdYbfx64
         1Z2q0GRyR2f4Wy5A+KCwYQ9p7ljNsH0pOvx++MmuKPS+II/WWV2qQKqxKCDOgbjGoGdy
         aNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698264832; x=1698869632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9eul69pshen1s/x7/gzxYAUPoCheVot1DPXycaxP8A=;
        b=UWZmOSa0U17JpgNNxqF6f97gz1mBStyJeQWZKYDVWy/3Y4jTcRPKEexqbaslIk5nWQ
         sBbNc57R3P42TYBE7uQqyHM/NWwXLBOcRA8dgf+9KVVoHp0zw8n5bQ/zWyHS4AOFe7NM
         g4lWY4JeGrNNWaZ/7E09i0/EEndR8boJ5U0vccwzQczPZINkFDsqbIDPzC8eYpBcM/LW
         yUUwzzh/EPR/jwbj4eMwfcdfa6bqDH1oPqjJtJYrtodQJoExxB4ywXJFgnVwuh4R+kpw
         +Gy20dInMSVnu569KcRj/oX97VGmY6AR59ZfKuwECEXsHjBtUu42B2J4wkhc/XEHzC8T
         0Q7Q==
X-Gm-Message-State: AOJu0YyBZMGwHW+LuBWeAu24fc7f/a251ii+Dxy82GFtQ61CzbbzrtFC
        /G+KE5dRt5YNzeKygDUSegA=
X-Google-Smtp-Source: AGHT+IG4DpjJTdvsHL9M32cnRu++G3ljis347I/hA1ABt7FieYScOoT525YJ+D/T8HluBh2CrKefQQ==
X-Received: by 2002:a05:6a20:4323:b0:15e:986:d92b with SMTP id h35-20020a056a20432300b0015e0986d92bmr7457083pzk.16.1698264832120;
        Wed, 25 Oct 2023 13:13:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bz20-20020a056a02061400b005703a63836esm7926147pgb.57.2023.10.25.13.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:13:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 13:13:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-hwmon@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Add Hal as one of the maintainers of
 SFCTEMP HWMON DRIVER
Message-ID: <c37f7810-12ea-4abc-bc2d-c68edfa6dadf@roeck-us.net>
References: <20230928075249.109459-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928075249.109459-1-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 03:52:49PM +0800, Hal Feng wrote:
> As he is the submitter of this driver, add his mail so he can
> maintain the driver and easily reply in the mailing list.
> 
> Acked-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Applied.

Thanks,
Guenter
