Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9877628BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjGZC15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjGZC1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:27:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0A4268E;
        Tue, 25 Jul 2023 19:27:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bb775625e2so3387535ad.1;
        Tue, 25 Jul 2023 19:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690338473; x=1690943273;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwDd3FlNAcnu8OFFd4jReM06wRpoPnJZwl+5W5GMCH8=;
        b=ck2GKHTewdEYt75S/Q3bPinu+2zxdRzwh3/beFXNA0/X83Ez57jCP9dYvkW/+zhGio
         as8OdTMgop4uWh2onq8chERlN9SC6Cq/7ft3rC03pWHOcCuPloabYZk1kqx5np9Oj/Oe
         4E+YZeaRxlPYMJLQu7FhLfjji4DXSR0h4vgvsL+TFc0fMqvMX8ebRahTzoKaCEzYeGdh
         fv4FePoEPBuoytPEcs2iRQeBi76j3Ue1UK7Jg63CqNc1I7TiCQ3AbB+viC9VFOmudtVh
         DRbtCsYiZXMS53DMhUjPIVZBWXWMp0UQPyCy5QjmPMt6XluOva+HIHMbHs1O/COyO7ez
         TV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690338473; x=1690943273;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwDd3FlNAcnu8OFFd4jReM06wRpoPnJZwl+5W5GMCH8=;
        b=eqNNY9BYol1WtUVhgq8KS0ZFwhAVqV8U4eEGj9u7xVMvEuYrsqd+2hjLZD00/PI0Og
         PXHNqBIgQOorQMN5GHNY7YUjylhg48pLEircM3jEboykLm1j8rz1sGmA6mvFeiXZEjgQ
         GQmHPKrjUv5TQ11PKsESoYq97RqVtBJLc3Vg0TdUY8SCKvbezGoJb7ldR98JHoHr0K+R
         VQ5uy5ppIRAP1rsswpPrtHAbsdOzP4FMK8oaGWqBdBD+J8qfNNbIP06/dy9cmd76MKx/
         GMF85HzVAs2spDOAGkHFc1fZZDoSmPblauzu1iw/JbOLvLaLDvdqRFfSuRDy19Ihb/P8
         EELQ==
X-Gm-Message-State: ABy/qLYO2/Ds7Z0MVRVRqC36w22NGopcyQbakk0F+Gqw4g15LPceCMzB
        TqBx4Y1EoXu+/kCx3B7sQ0rwbnOsU9Q=
X-Google-Smtp-Source: APBJJlFrLybNmFITvVjFHWux/7QmVErofzURl8PlBaki744McktGFjv/4vfFGyZoRFLy9JLC2hrqAQ==
X-Received: by 2002:a17:902:d4c9:b0:1b9:e23b:bb6a with SMTP id o9-20020a170902d4c900b001b9e23bbb6amr968439plg.11.1690338472601;
        Tue, 25 Jul 2023 19:27:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m24-20020a170902bb9800b001bb9b5e86b7sm5787630pls.91.2023.07.25.19.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 19:27:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <13b9a16f-0f26-23a4-1e2e-5b1cf9cb4070@roeck-us.net>
Date:   Tue, 25 Jul 2023 19:27:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     RD Babiera <rdbabiera@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230726020946.1409565-1-rdbabiera@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] usb: typec: bus: verify partner exists in
 typec_altmode_attention
In-Reply-To: <20230726020946.1409565-1-rdbabiera@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 19:09, RD Babiera wrote:
> Some usb hubs will negotiate DisplayPort Alt mode with the device
> but will then negotiate a data role swap after entering the alt
> mode. The data role swap causes the device to unregister all alt
> modes, however the usb hub will still send Attention messages
> even after failing to reregister the Alt Mode. type_altmode_attention
> currently does not verify whether or not a device's altmode partner
> exists, which results in a NULL pointer error when dereferencing
> the typec_altmode and typec_altmode_ops belonging to the altmode
> partner.
> 

Is this theory or actually observed ?

> This patch verifies the presence of a device's altmode partner
> before sending the Attention message to the Alt Mode driver. It
> also changes the return type from void to int so errors can be
> logged at the tcpm level.
> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---
>   drivers/usb/typec/bus.c           | 12 ++++++++++--
>   drivers/usb/typec/tcpm/tcpm.c     |  5 ++++-
>   include/linux/usb/typec_altmode.h |  2 +-
>   3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> index fe5b9a2e61f5..2f1823e16b3b 100644
> --- a/drivers/usb/typec/bus.c
> +++ b/drivers/usb/typec/bus.c
> @@ -183,12 +183,20 @@ EXPORT_SYMBOL_GPL(typec_altmode_exit);
>    *
>    * Notifies the partner of @adev about Attention command.
>    */
> -void typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
> +int typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
>   {
> -	struct typec_altmode *pdev = &to_altmode(adev)->partner->adev;
> +	struct altmode *partner = to_altmode(adev)->partner;
> +	struct typec_altmode *pdev = &partner->adev;

This dereferences partner

> +
> +	if (!partner || !pdev)

... and then checks if partner is NULL.

On top of that, pdev is not NULL even if partner is NULL because
adev is not the first element of struct altmode.

In summary, this code and the check as implemented does not make
sense. Maybe partner can be NULL, but pdev will never be NULL.

> +		return -ENODEV;
>   
>   	if (pdev->ops && pdev->ops->attention)
>   		pdev->ops->attention(pdev, vdo);
> +	else
> +		return -EOPNOTSUPP;
> +

So far this was explicitly permitted. Now it will log an error each time it is
observed. I do not see the point of this log message; obviously it was
not intended to be considered an error, and I do not understand why it should
suddenly be one that is worth clogging the log.

Guenter

> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(typec_altmode_attention);
>   
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 829d75ebab42..be37a662e54d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1791,6 +1791,7 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>   	u32 p[PD_MAX_PAYLOAD];
>   	u32 response[8] = { };
>   	int i, rlen = 0;
> +	int ret;
>   
>   	for (i = 0; i < cnt; i++)
>   		p[i] = le32_to_cpu(payload[i]);
> @@ -1877,7 +1878,9 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>   			}
>   			break;
>   		case ADEV_ATTENTION:
> -			typec_altmode_attention(adev, p[1]);
> +			ret = typec_altmode_attention(adev, p[1]);
> +			if (ret)
> +				tcpm_log(port, "altmode_attention failed ret:%d", ret);
>   			break;
>   		}
>   	}
> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> index 350d49012659..28aeef8f9e7b 100644
> --- a/include/linux/usb/typec_altmode.h
> +++ b/include/linux/usb/typec_altmode.h
> @@ -67,7 +67,7 @@ struct typec_altmode_ops {
>   
>   int typec_altmode_enter(struct typec_altmode *altmode, u32 *vdo);
>   int typec_altmode_exit(struct typec_altmode *altmode);
> -void typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
> +int typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
>   int typec_altmode_vdm(struct typec_altmode *altmode,
>   		      const u32 header, const u32 *vdo, int count);
>   int typec_altmode_notify(struct typec_altmode *altmode, unsigned long conf,
> 
> base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c

