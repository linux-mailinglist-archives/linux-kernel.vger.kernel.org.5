Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0567A52A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjIRTGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjIRTF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:05:58 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BDFE53;
        Mon, 18 Sep 2023 12:05:21 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34fe2814b0dso4397685ab.3;
        Mon, 18 Sep 2023 12:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695063921; x=1695668721; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SuWOrKWv1YL5VqPgED7pmVlnT9qu8LJQ8qB4HzCdQEw=;
        b=QfaACfddfy/6AK+yNtlvVU4w4dma330WjxkkKqJjEQem1tHqG8JsOBI8GmUocNg6ny
         yoDzmwndFLOGFf9rw4UHFV3XtvsB6uAcptlPNcbARG+GdqwGrk0Oyy1GZ17kVrcFFJBv
         DynemurW1yhpxTYXSSt/u9CylCSCrJT9ILUzxcReYwQ183UZxAeIvM0VmP91pKKAneHY
         OEFnAL4Hgd4b25PdoH2v6mppk1FWsjSRPbfNEdl4MG8MGbEDwdGRMcVARh5NcSBq6acW
         J0dc4wwMVHoAbVnS2VMhZLTZmbLIVi34XK2ZLjlctLkKNw4FcB/73v9b3trmzTbmQxNw
         VhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063921; x=1695668721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuWOrKWv1YL5VqPgED7pmVlnT9qu8LJQ8qB4HzCdQEw=;
        b=rD5Z3ryBCdo4l6SGnk0kPkRL/OsPstPpKXXso8ynk/yzKd0CKajfeVkod8sA4vmMqr
         0h0BcMttv2XA+ZL8qQkGOCRDYRhDHaywh4uJvildoEEAl16FsSWJISjYXq8Pf/BZwus8
         aJj7NccStZuE/w88NKFdmm3lRQCTOACvA/3lA/4GVi72NqBPG2ax++127YQVVSMfFaVA
         exG5VoqtvvvP9M41U5qXTSX7G1+O3KZdMozBLp5s4BQmaMgtSxMt1X5h+CpxjlV0mcHA
         jg1k5kmra9saob4oLtBaM2J2sLRIMVl/BneNy6cFuWNIf6ySoO+UQN/tg/tYMSFtjELm
         8E6g==
X-Gm-Message-State: AOJu0Yw88PRl5RPQIup3zMDz09CnIO0Du9eSblmuWtg5AWAx/a2/QOvt
        q+9qhqD050R1jN5rPwmsl7o=
X-Google-Smtp-Source: AGHT+IGgosw/QviSQ0E80rTL0dy/fWmRfLISZjv7mQyDZ5zo1XtXlXIWQu2mA027ZOXpOdUdxKaHJw==
X-Received: by 2002:a05:6e02:20ca:b0:34d:f390:4882 with SMTP id 10-20020a056e0220ca00b0034df3904882mr14720083ilq.29.1695063920881;
        Mon, 18 Sep 2023 12:05:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f24-20020a02b798000000b00433f32f6e3dsm3006705jam.29.2023.09.18.12.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 12:05:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 18 Sep 2023 12:05:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [PATCH] hwmon: powerz: add support for ChargerLAB KM002C
Message-ID: <6e5eff10-949c-4f17-a3f3-347b85b89e11@roeck-us.net>
References: <20230911-powerz-km002c-v1-1-898bd79b9bae@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911-powerz-km002c-v1-1-898bd79b9bae@weissschuh.net>
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

On Mon, Sep 11, 2023 at 07:44:42AM +0200, Thomas Weiﬂschuh wrote:
> The KM002C is similar to the KM003C and seems to use the same
> protocol and firmware.
> 
> Reported-by: Douglas Gilbert <dgilbert@interlog.com>
> Closes: https://lore.kernel.org/lkml/290ebce4-54f0-8ac1-2a13-cbc806d80d64@interlog.com/
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> 
> This patch is based on hwmon-next,
> commit 80369d9e1f2f ("hwmon: (sch5627) Document behaviour of limit registers").
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Applied, but please be more careful with your comments and Signed-off-by:
tags. There should only be one '---', and one signature. 

Thanks,
Guenter

> ---
>  drivers/hwmon/powerz.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> 
> ---
> base-commit: 80369d9e1f2f16993ae6d148553c37bf65a209e4
> change-id: 20230911-powerz-km002c-94afb4d3d645
> 
> Best regards,
> 
> diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c
> index 2b9693aee6f6..cfb635f94d66 100644
> --- a/drivers/hwmon/powerz.c
> +++ b/drivers/hwmon/powerz.c
> @@ -254,6 +254,7 @@ static void powerz_disconnect(struct usb_interface *intf)
>  }
>  
>  static const struct usb_device_id powerz_id_table[] = {
> +	{ USB_DEVICE_INTERFACE_NUMBER(0x5FC9, 0x0061, 0x00) },	/* ChargerLAB POWER-Z KM002C */
>  	{ USB_DEVICE_INTERFACE_NUMBER(0x5FC9, 0x0063, 0x00) },	/* ChargerLAB POWER-Z KM003C */
>  	{ }
>  };
