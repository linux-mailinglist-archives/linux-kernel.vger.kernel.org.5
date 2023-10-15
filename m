Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE9C7C98FC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 14:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjJOMas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 08:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjJOMar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 08:30:47 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64B6DD;
        Sun, 15 Oct 2023 05:30:45 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-49d14708479so1463750e0c.2;
        Sun, 15 Oct 2023 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697373045; x=1697977845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbFTv3OOpDw6H5iALxYSMBuhgwsVJnIHG+znH1EVHlU=;
        b=h4/ggU/aXIMcgbBXVd8AiFxEribU5G7kk0uhTsl2HUGD2HfzXeFOWfXuSCBWsjAS8R
         Wds6v4Xx/R42hHTWGITM3aEp9zmwwZKp18a7X9fmMOv4CibuDHIiDli32pvkEHLPSI8f
         OhbPP9eiRQaLTr0FMcxmN5Q2Wa4ngUPH0c3ZvvLBNL4nKGKWRKGoM4tKF5op0vGS+m9W
         yKKQ3F3KvWdVl46ssm2p0lOZCNOC+e7Mgk+eTX76VA6gWxO0xN3YbC7eTLXHJURzFiOh
         ngLMTVlwFKS2TV9fOsNGiZ9wAWwVME2Ax0Ic4V5WSWN99ajfhhPgwbpc4SqytkfBsTri
         mkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697373045; x=1697977845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbFTv3OOpDw6H5iALxYSMBuhgwsVJnIHG+znH1EVHlU=;
        b=etIv6l5RsEqw40Bz7jyllPO+TFn7rrPJfi+gr7FuO6T3Ib0qYp3t+EK4t87TvKFNwr
         sesjSnKSiws6SthNYQzLfNQ4uYOKmsbLDfqAgfHrUyrtANirTVw5C0KOg56SVi0T8pKR
         UwaqoFjECE5Q8RK0XL84B0UlZhjuiti+UgboSGZYlf0E8Fd05gaxVx4ZiITg224wt6y3
         yjinD2lCkVmxDCnJpLBhAEZIbWJeQB2XXaiFitaqECYl+X8JJKRMW4fZZ5PaP4h1SobX
         6r0k5RH6rqPQJ4QtznDidqSsiedb1E+/UuM9O95g6njoBwU7pXPzTAF72wMvIGoWTJ9Y
         MIRQ==
X-Gm-Message-State: AOJu0YxkePk8pF+aV0R8iM4AqcFXRXyDTmbY00A92ht4pAy6lddtnjFf
        EcoNa0C/5UxNLSBqk/bL1WE=
X-Google-Smtp-Source: AGHT+IH8t2R+qJ0y8yYJwMmDp/GJrQRXBp/7HMAvDWmpjaoqbLHlQMN7APvw1UzFTSs5xesCIgIucw==
X-Received: by 2002:a1f:e3c4:0:b0:49d:10ce:9a8b with SMTP id a187-20020a1fe3c4000000b0049d10ce9a8bmr21835823vkh.15.1697373044853;
        Sun, 15 Oct 2023 05:30:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p124-20020a1fa682000000b0049ac4abc41csm581578vke.27.2023.10.15.05.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 05:30:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 15 Oct 2023 05:30:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        kyletso@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdbabiera@google.com,
        amitsd@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm: Fix sink caps op current check
Message-ID: <11495372-5497-4d27-bd54-23f3304403c2@roeck-us.net>
References: <20231015035838.2207567-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015035838.2207567-1-badhri@google.com>
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

On Sun, Oct 15, 2023 at 03:58:38AM +0000, Badhri Jagan Sridharan wrote:
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
> Fixes: 34fde9ec08a3 ("FROMGIT: usb: typec: tcpm: not sink vbus if operational current is 0mA")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v1:
> * Fix commit title and description to address comments from Guenter Roeck
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 6e843c511b85..994493481c24 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4268,7 +4268,8 @@ static void run_state_machine(struct tcpm_port *port)
>  				current_lim = PD_P_SNK_STDBY_MW / 5;
>  			tcpm_set_current_limit(port, current_lim, 5000);
>  			/* Not sink vbus if operational current is 0mA */
> -			tcpm_set_charge(port, !!pdo_max_current(port->snk_pdo[0]));
> +			tcpm_set_charge(port, port->pd_supported ?
> +					!!pdo_max_current(port->snk_pdo[0]) : true);

Nit:
						!port->pd_supported || pdo_max_current(port->snk_pdo[0]

seems simpler. Otherwise

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>  
>  			if (!port->pd_supported)
>  				tcpm_set_state(port, SNK_READY, 0);
> 
> base-commit: 1034cc423f1b4a7a9a56d310ca980fcd2753e11d
> -- 
> 2.42.0.655.g421f12c284-goog
> 
