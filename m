Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FA278BC33
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjH2Alv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbjH2Alc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:41:32 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0517DDF;
        Mon, 28 Aug 2023 17:41:30 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a76d882052so2864503b6e.0;
        Mon, 28 Aug 2023 17:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693269689; x=1693874489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtI1LdTAybzZ/uo9onlubBTjxvk+IM2JPvdxldqhzbg=;
        b=bc6DXkM2zT082Fk3p3XJHAHueyoSJLxf95rPf/p83JLPTLpuegYLpusJX8fKNpRlew
         XRbaEY9Tifab/P/zzLGQr3aQExwgaaM7kYBVv/2FRmC9LThTStKXqlubiNMn/TcJ0a3V
         Coq59/kA+ANfiW6UNU9oKI0hJnbpJ1dVJBu/YkkNHN1xSqndKkBYMMJjY8dEHNofletp
         YQZmYno1D5kTeIrvnFkJVcaI1xSHfNbiVsQ6egUSecJuILMr/ptgM6cyhM/Gk0Zedcw/
         1oSVEPk55d6sUpg7v/lvmPV4tNzxKOOGWLWgDcvREieDZntmg8Zt89CLmNQhFT+aG1W4
         3ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693269689; x=1693874489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtI1LdTAybzZ/uo9onlubBTjxvk+IM2JPvdxldqhzbg=;
        b=dHfcK62dm7wSQITxkJbCSNQupdkcMkuw8mpNXoxSmS/00ios6R/9ufPyWfWcOHsMqX
         GNZ/7fumLQSMCCXbuTY6qmPRnyF51M4c5BeZBu22orFWDi3KAHyk7feiRqy/lo3Io+Rz
         1teBm1G3LhjZz39fOx3QYfvBwUJehRIyskqMGwTcDTu4Da49gMNypQdny46QgwyAGyb7
         +/hUHwqXhKPqaSHS1/AHbMoGaODQiUB/JWG1INZWk+fY5jK2m2Yceptmnx1bX0qVo8ZE
         epBQR3sBt5RaYi7nCTLfLWme+Ah09YM8Ed9Bl/J5SPNAEOBFXfxBvWkscfFvl92/zG9E
         CT6A==
X-Gm-Message-State: AOJu0YwSTyVnW5tBKLzvAK8aj6latPY+GccfCEV4G7rDQVEIKLr0TrCc
        vmYQDE7eJ1f7OY8J9ww0nFQ=
X-Google-Smtp-Source: AGHT+IHD7iYbxRqIAWOGdpfCiM+QDyDYZes8tYdwr7wIMZYIEtqpD3X/PCct4CgUr3wIaIWp+L3o4A==
X-Received: by 2002:a54:4188:0:b0:3a4:644:b482 with SMTP id 8-20020a544188000000b003a40644b482mr10548812oiy.52.1693269689237;
        Mon, 28 Aug 2023 17:41:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p3-20020aa78603000000b00684b64da08bsm7206086pfn.132.2023.08.28.17.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 17:41:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 28 Aug 2023 17:41:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Henry Shi <henryshi2018@gmail.com>
Cc:     hbshi69@hotmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, hdegoede@redhat.com, markgross@kernel.org,
        jdelvare@suse.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        hb_shi2003@yahoo.com, henrys@silicom-usa.com, wenw@silicom-usa.com
Subject: Re: [PATCH v5] Add Silicom Platform Driver
Message-ID: <15039461-6099-40a1-952f-fc31d65a0d3f@roeck-us.net>
References: <20230828212622.32485-1-henryshi2018@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828212622.32485-1-henryshi2018@gmail.com>
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

On Mon, Aug 28, 2023 at 05:26:22PM -0400, Henry Shi wrote:
> The Silicom platform (silicom-platform) Linux driver for Swisscom
> Business Box (Swisscom BB) as well as Cordoba family products is a 
> software solution designed to facilitate the efficient management
> and control of devices through the integration of various Linux
> frameworks. This platform driver provides seamless support for
> device management via the Linux LED framework, GPIO framework,
> Hardware Monitoring (HWMON), and device attributes. The Silicom
> platform driver's compatibility with these Linux frameworks allows
> applications to access and control Cordoba family devices using
> existing software that is compatible with these frameworks. This
> compatibility simplifies the development process, reduces
> dependencies on proprietary solutions, and promotes
> interoperability with other Linux-based systems and software.
> 
> Signed-off-by: Henry Shi <henryshi2018@gmail.com>

Again, my feedback is only for hwmon code.

[ ... ]

> +
> +static int silicom_fan_control_read(struct device *dev,
> +									enum hwmon_sensor_types type,
> +									u32 attr, int channel,
> +									long *val)

Excessively long continuation lines.
That seeme to be the case for almost all continuation lines,
except where it is too short. I'd suggest to run the patch
through checkpatch --strict and fix what it reports.

total: 0 errors, 9 warnings, 18 checks, 1077 lines checked

is really a bit much.

[ ... ]

> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&device->dev, name, NULL,
> +				&silicom_chip_info, NULL);

Did you try to compile this with CONFIG_HWMON=n or with
CONFIG_HWMON=m and SILICOM_PLATFORM=y ?

Guenter
