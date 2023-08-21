Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C917829F2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbjHUNGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjHUNGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:06:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED54D1;
        Mon, 21 Aug 2023 06:06:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bdbf10333bso25769025ad.1;
        Mon, 21 Aug 2023 06:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692623163; x=1693227963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wm3czYHGgkqpz3RmJdUIA+WpCMH7PJFnjwMwuvDzHjA=;
        b=nt0EQQ84VcMJBWCNbXHX2qE8+sRfg6Ivwejnxrn8lW9Cv5HfV/W00yEBFxqn3TNC22
         C0B7aUnL3Djbb0GNMah5fwkSvPDXGwQTM5sa6Ted9XEF9DxAaJr8WsqFNHt4Kg39hAY7
         LJbo76pyMM9lIeZX2ifriNiJjqPSbQhM2KR0EjU1hFSyfpc4LPNLLSqpTyDWXOiPrJCB
         8TYhyCpM3+FAypzT5c6iLMuy5/uwI+wtQopsVXlgm1bHL+v8q4WOZgtKX3coJzpwayN+
         +6kGABaZaLh2/roJidkNP5qTld6zF2roHqRwyQZ5/WG9hK6hHQ5itVVpOdWg+L2ZT0WI
         MP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692623163; x=1693227963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wm3czYHGgkqpz3RmJdUIA+WpCMH7PJFnjwMwuvDzHjA=;
        b=JTHaSIJvt7+3brsEZjIVlTNw0iXJq8a+8Ox7bM3qRAbpjCpy0BRkp0wdlNvqr6fJE9
         y4tjOKTy7uitS9csp0na+SbaKQDbqK+/xzYBlvbDIzSgVdjn84gC0gHtf5OWRkCsy9hr
         eUpHyJKoyfMDmD8hjlVADD8jiqPgR5WtLTsnIOK8ESsJf+W9FU2I7p8RcDzGbB02mcXE
         UGcm3sMWnQUh654BT75vBFQulOtinsfUwuE6LPoV3kMvOcByozA1D6Dghx4DCwl02C5Y
         O9wCbFTz2FLuyu6qgRyJ35l5A6jWylbNUfdy7QI4Zwi2AWRcO4ZSGKwmEuqNieMKLAWW
         KQcA==
X-Gm-Message-State: AOJu0Yx6M8R3j/I3hCs1FlS5K9t1zU8kYbGA+s1NrenXS662keTWwiMI
        7TU24LtJCUoa0iIdfOuPnN7GSdnls0c=
X-Google-Smtp-Source: AGHT+IEEGVYmArB1e4+BhMUqn6f9H5MQI6K4DuyqOscySXZ2Hnao1zAS0UVF89Dooc8oqIhbHYMRwA==
X-Received: by 2002:a17:902:e9c2:b0:1bb:a522:909a with SMTP id 2-20020a170902e9c200b001bba522909amr7124946plk.37.1692623162737;
        Mon, 21 Aug 2023 06:06:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902c38900b001b8b26fa6a9sm7022804plg.19.2023.08.21.06.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 06:06:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 21 Aug 2023 06:06:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Michael Carns <mike@carns.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hwmon: (asus-ec-sensosrs) fix mutex path for
 X670E Hero
Message-ID: <dadc5c5e-28f1-49c1-8872-645e46462d9d@roeck-us.net>
References: <20230821115418.25733-1-eugene.shalygin@gmail.com>
 <20230821115418.25733-2-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821115418.25733-2-eugene.shalygin@gmail.com>
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

On Mon, Aug 21, 2023 at 01:52:35PM +0200, Eugene Shalygin wrote:
> A user reported that they observe race condition warning [1] and after
> looking once again into the DSDT source it was found that wrong mutex
> was used.
> 
> [1] https://github.com/zeule/asus-ec-sensors/issues/43
> 
> Fixes: 790dec13c012 ("hwmon: (asus-ec-sensors) add ROG Crosshair X670E Hero.")
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Note that you don't have to (and should not) send an introduction
for a 1-patch "series". Add the change log after "---" instead.

Thanks,
Guenter

> ---
>  drivers/hwmon/asus-ec-sensors.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index f52a539eb33e..51f9c2db403e 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -340,7 +340,7 @@ static const struct ec_board_info board_info_crosshair_x670e_hero = {
>  	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
>  		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
>  		SENSOR_SET_TEMP_WATER,
> -	.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
> +	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
>  	.family = family_amd_600_series,
>  };
>  
