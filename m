Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64707DD905
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbjJaXBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345979AbjJaXBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:01:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D731C119;
        Tue, 31 Oct 2023 16:01:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so5188411b3a.1;
        Tue, 31 Oct 2023 16:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698793272; x=1699398072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rowuL+n57gglP2df1ajEH9jpmftZToqAo1dT9+AkU6A=;
        b=Fgws9Q+rOzQ4meMIg8Uk2Y7UiP4X5cLrKMkv1nXbuh3/eWqjMpJXO04JrSs9WPI9xW
         WkzzyVtluvBmcyrUg2oQGnbPEhjuXGQfBRP+hLnmmuF0yT0+5A33i1AXkZIcs0K1p8sr
         tVqrh8BD6MepUmRxkxB0A3cPxYX0bVVGM/DdZ/S2g/BOac3mius03zBQAcW0f5o9Uj4D
         QyLr3/2v/UsdGpQEpUZTZAC+fLAwUh+Gwz6lwfuUfLD2WGd338yjaYb0OrW9S+d/i1ee
         +6wYdNvkJQ1WOMieabmB6Gm+CCck32zjsCXSyKrlzhQodUTg+zDhc4KMWeL4ezYxDEqq
         09eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698793272; x=1699398072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rowuL+n57gglP2df1ajEH9jpmftZToqAo1dT9+AkU6A=;
        b=Q+2nxddGHVO6MwUXid9RQ9NkMkKz0gBT8/M7zxMWVu/oVHmvndFY2Tq3FGpW2wjUf9
         BK0vTQ10T1Z7tEk9m1ezgvg4GsDCD105iU211GHawda9+s/xJDgNUy4QKAiLaZDq1XVX
         ESbxXkNqUn64hq74wcNMXHucG7lrnn4OkYDQxXG7WG2ycsOXnYySj9qQEEYuJSDqgTZu
         bwoA4fWb318xfKuIsTG9jEEPBBTzNC3wUfUSfR2KQHlOlqrDj2G5D855VLc+FokdgJrv
         3tvPOU6vGadJus0GPMLLJ5nZOYP0i8oSUDUGe2EegrarT/oMzI8l6MbXrEj1QFmTyJ4H
         XOaQ==
X-Gm-Message-State: AOJu0Yyq3kEAabXTxI8B7bVfSvers4LnHL/7O+TJ+RRY63+ceoATEjQ4
        sSfYd7/LzaKvafBRFCcksTQ=
X-Google-Smtp-Source: AGHT+IFEkVyPZeGUGDvmO3EyGeLXa77sRoEZch/AkeWtcWh6E+f/sT8os5vqayWXDTdbwl/3DzFF2A==
X-Received: by 2002:a05:6a20:1f9b:b0:158:1387:6a95 with SMTP id dm27-20020a056a201f9b00b0015813876a95mr9272541pzb.19.1698793272126;
        Tue, 31 Oct 2023 16:01:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q16-20020a62ae10000000b006bd8f4e398csm128897pff.135.2023.10.31.16.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 16:01:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Oct 2023 16:01:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc:     patrick@stwcx.xyz, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hwmon: emc1403: Add support for EMC1442
Message-ID: <7d92d8ae-c247-4a71-a84d-4f9639a43fb8@roeck-us.net>
References: <20231031085807.618827-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031085807.618827-1-Delphine_CC_Chiu@wiwynn.com>
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

On Tue, Oct 31, 2023 at 04:58:06PM +0800, Delphine CC Chiu wrote:
> Add support for EMC1442 which is compatible with EMC1403.
> 

Unfortunately, almost no information is available about this chip
except that it ships in an 8-pin package. Are you sure the chip
supports two external temperature sensors like EMC1403 ?
The chip numbering and the number of pins would suggest that
it only supports a single external temperature sensor,
which would make it compatible to emc1402/emc1422.

Guenter

> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  drivers/hwmon/emc1403.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
> index bb7c859e799d..c0d2e96c5077 100644
> --- a/drivers/hwmon/emc1403.c
> +++ b/drivers/hwmon/emc1403.c
> @@ -346,6 +346,9 @@ static int emc1403_detect(struct i2c_client *client,
>  	case 0x27:
>  		strscpy(info->type, "emc1424", I2C_NAME_SIZE);
>  		break;
> +	case 0x60:
> +		strscpy(info->type, "emc1442", I2C_NAME_SIZE);
> +		break;
>  	default:
>  		return -ENODEV;
>  	}
> @@ -430,7 +433,7 @@ static int emc1403_probe(struct i2c_client *client)
>  }
>  
>  static const unsigned short emc1403_address_list[] = {
> -	0x18, 0x1c, 0x29, 0x4c, 0x4d, 0x5c, I2C_CLIENT_END
> +	0x18, 0x1c, 0x29, 0x3c, 0x4c, 0x4d, 0x5c, I2C_CLIENT_END
>  };
>  
>  /* Last digit of chip name indicates number of channels */
> @@ -444,6 +447,7 @@ static const struct i2c_device_id emc1403_idtable[] = {
>  	{ "emc1422", emc1402 },
>  	{ "emc1423", emc1403 },
>  	{ "emc1424", emc1404 },
> +	{ "emc1442", emc1403 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, emc1403_idtable);
