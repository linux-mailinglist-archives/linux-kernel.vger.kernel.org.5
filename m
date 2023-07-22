Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510B175DE13
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 20:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGVSXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 14:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVSXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 14:23:34 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AB219B3;
        Sat, 22 Jul 2023 11:23:33 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-78bb7b89cabso2822039f.1;
        Sat, 22 Jul 2023 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690050213; x=1690655013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zm9FeD3Nl0wGNdE9LiahuM7kYgMDuY7s7jWrTtlNBuA=;
        b=CXIBCTAIzyaIqe69ryKf83Qh7CTm86gkMA8hB89x8rSgB51lczr3xyyGXrfJglTOMp
         e8tIKGOuHivBKb2HCSUUCIngdGawptwYqlcC+tr2FL40giV04iwQ1kwf9bZzAZjmN7bo
         YoDk4xstynGw8yJmxFCqUOkUsyWaX0Zy20cZ/JBN49901lSPjkbi0jTKfC8+xGT2RmR5
         EyIcKfOUTMrw8E6n3HVGYmzGdmkxRLbJt1npeTkDze+3ulAfHGsxusycbUpocTFB4Zqg
         Mowl2L7L2mHh6ErYzXI+djiYLW/JCutYVAE8KCOwLP3NN33PfyzFpMGNQpQ4nVDHU/Q1
         TbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690050213; x=1690655013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zm9FeD3Nl0wGNdE9LiahuM7kYgMDuY7s7jWrTtlNBuA=;
        b=GKY8e4kSMm/HPagL5OQUmhG/mspOX7rSIKcfStteRwSdV/scUtM0zA2z+27JHGZwEj
         5ERpz8Rt/GrWH4xy0W2Xvb4/L4IkyZRh/T7qhJ9wLvAdDDs1lKMCRAE0fUcsh4GQ9453
         YOlZKweqesmqoDnOZXTxvTVkuto3VOmX2OTkvxu2D4ZgaaHwTPGK/YatDpjX35APSGJa
         g1RZZavYPrpPJDXhFsSfhShizKWtDKVNvBvv/3ZJgPruyKSHVBorY4NRm3amJt3TvLTz
         Jh6eeeXC+CbP1FI/5vQuiRLYbzMGtNcGD0R8IuNrABYCCuQJdf4yy1XOd+D5S+mMF3Xm
         Bg6w==
X-Gm-Message-State: ABy/qLZFFF1CfqfG9mPTc4jSONjwARg51T4tehxEWdW+2blT0U67oLcx
        RTcS5FJ50+T1eV7O1D/wafM=
X-Google-Smtp-Source: APBJJlFIXt8xCwH+3DpZkYOufA14V4f2KTu8RGj1xEs3b0xv7mpKbu4IANKzLo4ner4XBPJCf+R0og==
X-Received: by 2002:a5d:8f8f:0:b0:786:f352:e3d4 with SMTP id l15-20020a5d8f8f000000b00786f352e3d4mr5238622iol.7.1690050213135;
        Sat, 22 Jul 2023 11:23:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i22-20020a02c616000000b0042b929d3d2fsm1840012jan.86.2023.07.22.11.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 11:23:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 22 Jul 2023 11:23:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Seo <james@equiv.tech>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: hp-wmi-sensors: Get WMI instance count from
 WMI driver core
Message-ID: <2c29ba3f-a180-42a1-a7fb-0b0ae7ed5774@roeck-us.net>
References: <20230722172513.9324-1-james@equiv.tech>
 <20230722172513.9324-2-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230722172513.9324-2-james@equiv.tech>
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

On Sat, Jul 22, 2023 at 10:25:13AM -0700, James Seo wrote:
> 2a2b13ae50cf ("platform/x86: wmi: Allow retrieving the number of WMI
> object instances") means we no longer need to find this ourselves.
> 
> Signed-off-by: James Seo <james@equiv.tech>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/hp-wmi-sensors.c | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
> index ebe2fb513480..3a99cc5f44b2 100644
> --- a/drivers/hwmon/hp-wmi-sensors.c
> +++ b/drivers/hwmon/hp-wmi-sensors.c
> @@ -435,25 +435,11 @@ static union acpi_object *hp_wmi_get_wobj(const char *guid, u8 instance)
>  /* hp_wmi_wobj_instance_count - find count of WMI object instances */
>  static u8 hp_wmi_wobj_instance_count(const char *guid)
>  {
> -	u8 hi = HP_WMI_MAX_INSTANCES;
> -	union acpi_object *wobj;
> -	u8 lo = 0;
> -	u8 mid;
> -
> -	while (lo < hi) {
> -		mid = (lo + hi) / 2;
> -
> -		wobj = hp_wmi_get_wobj(guid, mid);
> -		if (!wobj) {
> -			hi = mid;
> -			continue;
> -		}
> +	int count;
>  
> -		lo = mid + 1;
> -		kfree(wobj);
> -	}
> +	count = wmi_instance_count(guid);
>  
> -	return lo;
> +	return clamp(count, 0, (int)HP_WMI_MAX_INSTANCES);
>  }
>  
>  static int check_wobj(const union acpi_object *wobj,
> -- 
> 2.39.2
> 
