Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C10078E013
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbjH3UHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239967AbjH3UHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:07:08 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B8146A2;
        Wed, 30 Aug 2023 12:52:29 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a85c5854deso12196b6e.0;
        Wed, 30 Aug 2023 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693425050; x=1694029850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4T8O+VlfsM+hVm2pznIl9OvKQ1kpkSJcWs5FBGFGZB4=;
        b=sKPhbltb5zQIT1W2PvY6km5konJ+3VEGZrrSGq8r/roxe5iXBqeAxSAXjQAo1Kjqwa
         aokgZcVNNew/1FYitpHSpg+YG3BHa6SiFIZPOm6Iacw/fOeeKH/X3yLFoNtnNbWNa4lU
         +9gBjIRuEyXUNX1r00vfYNMumg7DvSS2H7Fn+Fvy8bD1aLZdJiwmzQKM5J/q+dqn3BHy
         5/uysCauFjig29xx8KNrEzyzBcShI3cW2IBuAlKq177g9KsdKlCw8d2in+OEc8viqzJU
         DNBlV6lqVUQr7i87j6Mz4AGowcdK7GzGJ7EZu/2oPFii0D3sNhoLo2NXvr7yIRcjEJJV
         knYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693425050; x=1694029850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4T8O+VlfsM+hVm2pznIl9OvKQ1kpkSJcWs5FBGFGZB4=;
        b=UZ4FU+GLs65RnSfghLq2g6W+fCF6ngIk3TfkmRwQSZv8wQxQyxHtAjGHQKtvLCJx1c
         rxmh53csT346SiGFJug5JNgFYw84iHeDe1bNz/jb9ASpnv7IhflmUiIM41S4jhZmV0W2
         tuSLwgZuWFrgAjBp2gnawb1x2ey5HuuQyPue15DflqPjVkmn6sNcef4erZim5SoGdtkM
         X3W30vCEKTQBjqGCBARJTd8SKPJleCTXmBqKbNjFspA3rMOzg0fUeL8U3/LRAjEnIUoj
         brXVEeEOP5OhDO/CzGzKQIMmD0XLecQ4MQ5mlV+RNjsFjmODLy2Zn4Ukw3OPY2JnxAgP
         8MWg==
X-Gm-Message-State: AOJu0YyHvqn2bBa3i2TwSLv6EjacpCLWVeybISN19kbVg3nEDURIpMJ9
        hBUaurd3/qgoeUNO/dUJNlhEpwmKV+o=
X-Google-Smtp-Source: AGHT+IHVy9aVXn9idKvlMC+75eVbcX1zaKxEAM75wecEFcCanXpSawxw+kRS0G4h54I3551aRXyVzg==
X-Received: by 2002:aca:1016:0:b0:39c:93ba:cb92 with SMTP id 22-20020aca1016000000b0039c93bacb92mr3240568oiq.8.1693425050333;
        Wed, 30 Aug 2023 12:50:50 -0700 (PDT)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id y9-20020a544d89000000b003a05ba0ccb2sm6427980oix.39.2023.08.30.12.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 12:50:49 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4c6d01bf-1a0f-27de-54e1-4afdcf4bc8d5@lwfinger.net>
Date:   Wed, 30 Aug 2023 14:50:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] ssb-main: Fix division by zero in ssb_calc_clock_rate()
Content-Language: en-US
To:     Rand Deeb <deeb.rand@confident.ru>, Michael Buesch <m@bues.ch>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lvc-project@linuxtesting.org, voskresenski.stanislav@confident.ru
References: <20230830082759.23336-1-deeb.rand@confident.ru>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230830082759.23336-1-deeb.rand@confident.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/23 03:27, Rand Deeb wrote:
> In ssb_calc_clock_rate(), the value of m1 may be zero because it is
> initialized using clkfactor_f6_resolv(). This function could return
> zero, so there is a possibility of dividing by zero, we fixed it by
> checking the values before dividing.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Rand Deeb <deeb.rand@confident.ru>
> ---
>   drivers/ssb/main.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
> index 0a26984acb2c..e0776a16d04d 100644
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -903,13 +903,21 @@ u32 ssb_calc_clock_rate(u32 plltype, u32 n, u32 m)
>   		case SSB_CHIPCO_CLK_MC_BYPASS:
>   			return clock;
>   		case SSB_CHIPCO_CLK_MC_M1:
> -			return (clock / m1);
> +			if 
> +				return (clock / m1);
> +			break;
>   		case SSB_CHIPCO_CLK_MC_M1M2:
> -			return (clock / (m1 * m2));
> +			if ((m1 * m2) !=3D 0)
> +				return (clock / (m1 * m2));
> +			break;
>   		case SSB_CHIPCO_CLK_MC_M1M2M3:
> -			return (clock / (m1 * m2 * m3));
> +			if ((m1 * m2 * m3) !=3D 0)
> +				return (clock / (m1 * m2 * m3));
> +			break;
>   		case SSB_CHIPCO_CLK_MC_M1M3:
> -			return (clock / (m1 * m3));
> +			if ((m1 * m3) !=3D 0)
> +				return (clock / (m1 * m3));
> +			break;
>   		}
>   		return 0;
>   	case SSB_PLLTYPE_2:
> --=20
> 2.34.1

Rand,

I agree that clkfactor_f6_resolv() could return 0, but we have not been overrun 
with reports of divide by zero errors, which suggests that the branch is never 
taken. This patch will make your tool happy and is much simpler:

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index ab080cf26c9f..b9934b9c2d70 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -837,7 +837,7 @@ static u32 clkfactor_f6_resolve(u32 v)
         case SSB_CHIPCO_CLK_F6_7:
                 return 7;
         }
-       return 0;
+       return 1;
  }

  /* Calculate the speed the backplane would run at a given set of clockcontrol 
values */

Your patch has some technical problems as well. The subject should be "ssb: Fix 
division ..." In addition, note that all your if statements have an extraneous 
"3D" as in "(m1 !=3D 0)". To me, that indicates that your mailer is not sending 
plain text.

Larry

