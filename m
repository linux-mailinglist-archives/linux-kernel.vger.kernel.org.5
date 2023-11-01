Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859F57DDABC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377305AbjKABse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377288AbjKABsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:48:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368F9F4;
        Tue, 31 Oct 2023 18:48:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so6365153b3a.2;
        Tue, 31 Oct 2023 18:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698803308; x=1699408108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=F2BaTa6G2HWw9DgMuR1O5iLUXYXlCPDt7//P1EX5GrM=;
        b=jbAKFXMwl47tJA2EeQxqwzX9zgg4wmQCgd+ZsWR1eF327Tm7oZj9W1yVQoSMZWBxtu
         jzkALMJggtC3ahoduXdZ6l0sEsns88vQWkter36ZNrI6Ez4q9WpVKUCAQGmbqJQ/6rpT
         +sxahbL2zKb5dqO7RIkexwmtWphrYv7b9rNwZK+p5UbEm93F00p7CHiP15eQiabcnYEN
         ejnbg00OtYg78oDOm8zsc63rl6hOWOK3BW28iClLsSQdlXVvdynD+KYnd0QLyB0Q0MLD
         PxHFINQfdALI1ZPdSXm5vBpiEET+8mzWuTBvpbwcfufhOSci3Prcy8oLeOCZSDgmhnxS
         CsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698803308; x=1699408108;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2BaTa6G2HWw9DgMuR1O5iLUXYXlCPDt7//P1EX5GrM=;
        b=EsRkyGAMNEPSrvnH0o5EKgzzYrekIlgwZPSxh1wpMiOxC7phJ68DgukWmFzRjvh1GA
         C7UxOCdoDOM2GTZ/KO2HVI5EVpfEqm17AzviMQg4NmYFWEyq+IDSgytdxOVYJ+F/9UE1
         SB8bulZo5E+NpctnqdRLBxNQiLqww+jYdfOQrvVfyxaYAcZXZeeyEX8HtiAsASgjlvzJ
         d/8KAN+Ep24U6+eWPyNaslj7bytw3Az50MJLGi7NY4JIyE4SXnZcFBh7jm7h+VD9/zsE
         z9xcrIJ7foQO9wUAdPBjwxsKJWmDDC/KEeEg6mOSruQ+vAAyb1OwmJYGXO+/3gdP9yqI
         kP5g==
X-Gm-Message-State: AOJu0YxuuPOJu//VnvHKllY6ypIg4XlyuHpkLB2YjOOnl1mfRGeXEBj4
        RkGAoPdm82oHepPCpvI5q/5xU5bZxtc=
X-Google-Smtp-Source: AGHT+IF79z/Pz4pTmLfsoJ3VxWrULK5C/eTSmgGYC6l5NroooZgsEqHrx4e6FT7YFA7d/6791SdA8A==
X-Received: by 2002:a05:6a20:938c:b0:17b:40:ccd6 with SMTP id x12-20020a056a20938c00b0017b0040ccd6mr19669737pzh.2.1698803308466;
        Tue, 31 Oct 2023 18:48:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mj3-20020a17090b368300b002800b26dbc1sm1659875pjb.32.2023.10.31.18.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 18:48:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <feb4297d-eaa4-40b0-824d-af2c6bdb97e3@roeck-us.net>
Date:   Tue, 31 Oct 2023 18:48:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: typec: tcpm: Fix sink caps op current check
Content-Language: en-US
To:     Badhri Jagan Sridharan <badhri@google.com>,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com
Cc:     kyletso@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231101012845.2701348-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231101012845.2701348-1-badhri@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/31/23 18:28, Badhri Jagan Sridharan wrote:
> TCPM checks for sink caps operational current even when PD is disabled.
> This incorrectly sets tcpm_set_charge() when PD is disabled.
> Check for sink caps only when PD is enabled.
> 
> [   97.572342] Start toggling
> [   97.578949] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
> [   99.571648] CC1: 0 -> 0, CC2: 0 -> 4 [state TOGGLING, polarity 0, connected]
> [   99.571658] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> [   99.571673] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
> [   99.741778] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170 ms]
> [   99.789283] CC1: 0 -> 0, CC2: 4 -> 5 [state SNK_DEBOUNCED, polarity 0, connected]
> [   99.789306] state change SNK_DEBOUNCED -> SNK_DEBOUNCED [rev3 NONE_AMS]
> [   99.903584] VBUS on
> [   99.903591] state change SNK_DEBOUNCED -> SNK_ATTACHED [rev3 NONE_AMS]
> [   99.903600] polarity 1
> [   99.910155] enable vbus discharge ret:0
> [   99.910160] Requesting mux state 1, usb-role 2, orientation 2
> [   99.946791] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS]
> [   99.946798] state change SNK_STARTUP -> SNK_DISCOVERY [rev3 NONE_AMS]
> [   99.946800] Setting voltage/current limit 5000 mV 500 mA
> [   99.946803] vbus=0 charge:=1
> [  100.027139] state change SNK_DISCOVERY -> SNK_READY [rev3 NONE_AMS]
> [  100.027145] Setting voltage/current limit 5000 mV 3000 mA
> [  100.466830] VBUS on
> 
> Cc: stable@vger.kernel.org
> Fixes: 803b1c8a0cea ("usb: typec: tcpm: not sink vbus if operational current is 0mA")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v2:
> * Fix the "Fixes" tag
> * Refactor code based on Guenter Roeck's suggestion.
> 
> Changes since v1:
> * Fix commit title and description to address comments from Guenter Roeck
> ---
>   drivers/usb/typec/tcpm/tcpm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 058d5b853b57..afc791ab6d4f 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4273,7 +4273,8 @@ static void run_state_machine(struct tcpm_port *port)
>   				current_lim = PD_P_SNK_STDBY_MW / 5;
>   			tcpm_set_current_limit(port, current_lim, 5000);
>   			/* Not sink vbus if operational current is 0mA */
> -			tcpm_set_charge(port, !!pdo_max_current(port->snk_pdo[0]));
> +			tcpm_set_charge(port, !port->pd_supported ||
> +					pdo_max_current(port->snk_pdo[0]));
>   
>   			if (!port->pd_supported)
>   				tcpm_set_state(port, SNK_READY, 0);
> 
> base-commit: c70793fb7632a153862ee9060e6d48131469a29c

