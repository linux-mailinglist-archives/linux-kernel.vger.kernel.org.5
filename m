Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974987D7471
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjJYTg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYTgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:36:55 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7937C13A;
        Wed, 25 Oct 2023 12:36:53 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so91491b3a.1;
        Wed, 25 Oct 2023 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698262613; x=1698867413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGbMnAcQD9MpNg1isUp8Xn3wZuZoLOEwvnOJV3Zib1c=;
        b=bztixrk69l+e/+jYISH76bAmPfZObiC7kZDH/4Ca0ghdA0sPIu2NLK74NWXSabG774
         eIi7N6H6CW3zUJZD+A0PThMI5RDrXkhd2m5i2cn5sslVklqovQuJGL/4Kesf4rzfg1Hl
         uDYvAifXSn6gQ99DypxNbMDc2nt3/yo7YtmnnWubxH7W3Y9kXR5T8zhysWdM45yvlm8X
         snO/8iFmaUf4dr56gp/YQBW40nIqt/PMUVcDM+HjDQg5+heubVA4kenJ4FKejJZnaRkU
         UeP7mIAU3i1lYmk5F+9amlzCeHKCowKdMhaSamvQiNl/BsSuJmLb7cGVBU1vFhDGRHHM
         NAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698262613; x=1698867413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGbMnAcQD9MpNg1isUp8Xn3wZuZoLOEwvnOJV3Zib1c=;
        b=V4BLka9nyp1cTG4/aE90R1SoKUxfxbe9c8q0/1DaFUGIo5upDH3DtM8Cx/36mdZDdG
         9K8LQHDgegAtpKLzZQiCoPibNuyGrxU0eBiROD9TQ5Hk87GtgRZstSWLwzvwY/iO54mo
         YnGUak+v+gbJGpzUqFWzEHmNEQf3JlUDda3c67YNOuErT304lQCvgoc2x1nP9VL+zQh8
         Zi4lBeGbEZ6dJDlgvB28Km+n2WYyamlmJmtTpzbWpdbdV7Gy3fo4YeNFQOOcrsbRamCX
         uJsl+y9JI3vNtfJfjZyXM/OSi+HO2sjXfKngS8mEiH/ZbRY/pBZxQ9TZ50d05eWB1WyG
         AZOw==
X-Gm-Message-State: AOJu0YztsFcZwQPJyqo9bbIwaFHak2s2HA5ch+LbCIAYMNQbVnN3OS6W
        UVotfw9IhLvWh2CDR+9tYIQ=
X-Google-Smtp-Source: AGHT+IFDdIs+VkhqOZmhmb39SGTaiCH9s23YjOt7r0Pg9uoy33BcIMUwPDCXdR+5BIBpQO0/ZEH7AQ==
X-Received: by 2002:a05:6a00:1a4f:b0:6bc:e7f8:821e with SMTP id h15-20020a056a001a4f00b006bce7f8821emr19565769pfv.10.1698262612844;
        Wed, 25 Oct 2023 12:36:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79f05000000b006be055ab117sm9980413pfr.92.2023.10.25.12.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:36:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 12:36:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Su Hui <suhui@nfschina.com>
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        jdelvare@suse.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, openbmc@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] hwmon: npcm750-pwm: add an error code check in
 npcm7xx_en_pwm_fan
Message-ID: <5036fed5-ff29-4d9b-a31a-1676a8e4f051@roeck-us.net>
References: <20231020085518.198477-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020085518.198477-1-suhui@nfschina.com>
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

On Fri, Oct 20, 2023 at 04:55:19PM +0800, Su Hui wrote:
> npcm7xx_pwm_config_set() can return '-ENODEV' for failed. So check
> the value of 'ret' after calling npcm7xx_pwm_config_set().
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>

Applied.

Thanks,
Guenter
