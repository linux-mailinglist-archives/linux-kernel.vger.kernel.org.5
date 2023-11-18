Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93837F01AC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 18:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjKRRqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 12:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjKRRpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 12:45:50 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C805B10C9;
        Sat, 18 Nov 2023 09:45:04 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6ce37d0f1a9so1666178a34.0;
        Sat, 18 Nov 2023 09:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700329504; x=1700934304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qb1Z5fZ5kEcb/PEat1gO6JLOrll/tbZ6AWENLgKkm2A=;
        b=Yh1NxnNYzEcSi2R0NDCdJDBC0/YPNNg5ONrh1pE/EIuBr7XpT/voiKo3UBw/X4RimC
         A3i51x9M9xN6Qp0UeBrDHreIRT0chYkasGNygKB1KOZfFTaYrc4J8L+3ukdZxfW004Ey
         9g7xywDfrOrDTF/YaTnKWuU/ns72B22E05/cJevKOURSYlaE31Xp8w5bs4WSYmwN1MT7
         /87kvxbIjJsWxTQm6Yic0yjXDM4RdeXbq2LVDdu582V6PdBusx8GCKlcXeC4yltGRcSB
         X+/qDsDCsuiOojxnOKmfPPukHQN4g6YznHUeFQv0X59uZDP3I1T4HDl1fuLYnm/XJjhl
         PXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700329504; x=1700934304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qb1Z5fZ5kEcb/PEat1gO6JLOrll/tbZ6AWENLgKkm2A=;
        b=RW2phIyBZPEA7Y8NDz1fycAP0mNud0vGxonlXYNV24wqy9m1xGfRGvnFineI6Qa1UT
         CLBcisasbnRzhwRf5bOiCVGrZVWwVpfOQgzWGcu2sv8Y1HyjCRTUH8e0xz0ns1wiELhh
         O2FXIoIVvWmhNzEMmp2dr6DoiHBJzz08fRI8HeqvvOFTpAMb3kfmGkbHNJwCvo3P5UPn
         joPC+8KS2KwXJ8GBxiTL9hzw6pZJK2FWyDTRcC4igk4zyC0gnQyWmkIw8VPDF01qTrrn
         c8rilh/jYiZxUtdUeckt8+LLO9l/RDKaxz7RIulX/EcwvKqSn9iUrmfkDZaPLPJpSa3r
         i/Lw==
X-Gm-Message-State: AOJu0YxU/OAYbtf2QUZjKUVDRnIEoTDKUFS64IoqleoJFli2wJb36jv5
        zqaqh+Hd2+YA8C6FxwIHkbeulEMDaEg=
X-Google-Smtp-Source: AGHT+IEiR/9sgFTTlRNkRw6NamwXS7va62a6Ub4e4Iw5bBfNaQDBna9qOunCFv5pgQu8yH73/xbR9g==
X-Received: by 2002:a9d:77cf:0:b0:6b7:5687:8a9e with SMTP id w15-20020a9d77cf000000b006b756878a9emr3227871otl.15.1700329504082;
        Sat, 18 Nov 2023 09:45:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m12-20020a9d6acc000000b006b871010cb1sm657731otq.46.2023.11.18.09.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 09:45:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 18 Nov 2023 09:45:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ABI: sysfs-class-hwmon: rearrange humidity
 attributes alphabetically
Message-ID: <b0176205-adc7-44ba-a55a-c405a8ab1b19@roeck-us.net>
References: <20231116-hwmon_abi-v1-0-8bfb7f51145a@gmail.com>
 <20231116-hwmon_abi-v1-1-8bfb7f51145a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-hwmon_abi-v1-1-8bfb7f51145a@gmail.com>
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

On Fri, Nov 17, 2023 at 07:40:34AM +0100, Javier Carrasco wrote:
> Preliminary step to add the missing humidity attributes in the ABI
> documentation.
> 
> Adding new elements alphabetically is a common practice that has been
> loosely followed in the sysfs-class-hwmon documentation. Since most of
> the humidity attributes must be added to the file, a single attribute
> needs to be rearranged to reinforce alphabetical order.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  Documentation/ABI/testing/sysfs-class-hwmon | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
> index 638f4c6d4ec7..b998a42add95 100644
> --- a/Documentation/ABI/testing/sysfs-class-hwmon
> +++ b/Documentation/ABI/testing/sysfs-class-hwmon
> @@ -887,15 +887,6 @@ Description:
>  
>  		RW
>  
> -What:		/sys/class/hwmon/hwmonX/humidityY_input
> -Description:
> -		Humidity
> -
> -		Unit: milli-percent (per cent mille, pcm)
> -
> -		RO
> -
> -
>  What:		/sys/class/hwmon/hwmonX/humidityY_enable
>  Description:
>  		Enable or disable the sensors
> @@ -908,6 +899,14 @@ Description:
>  
>  		RW
>  
> +What:		/sys/class/hwmon/hwmonX/humidityY_input
> +Description:
> +		Humidity
> +
> +		Unit: milli-percent (per cent mille, pcm)
> +
> +		RO
> +
>  What:		/sys/class/hwmon/hwmonX/humidityY_rated_min
>  Description:
>  		Minimum rated humidity.
