Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3633F812C31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443524AbjLNJvF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 04:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443600AbjLNJut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:50:49 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDA81FDE;
        Thu, 14 Dec 2023 01:50:09 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5908b15f43eso716882eaf.1;
        Thu, 14 Dec 2023 01:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702547409; x=1703152209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7IcPRb+X4qnuTs0aHDHBpi/NcRx3U1FPPLkX97/vT0=;
        b=YbeMpdvl+8fpL4KZeR71OUAvsadM6ll1fnobE4c5xVpaPyVx9BsD5CmWjYjWkJcB6V
         O08FJRtm7JDLwwxSSc5dO2yF/jlyK7fn+b/CziPgiRRwMOAOuiCTWjUN5/vLt8aIchf2
         6y0E3f3jbjdnkN303TYIk0np5z4pU5X8YwJjo59rnSH6jH048OHI0aGiXmrBdOwG8FFR
         Tlsza9GJeow+046NbPZqRejENW9OMr+TdtuHQYDvnqahSGCSzxZJ/le2rqvFVXyRjpxh
         rO4Jyk2iYEt/jnL8p9eZ5JG7P6FfL3VmLxSwp9zdUfGdvaZV/mzDW3Fp/zXsxHR7Ieoc
         NrFw==
X-Gm-Message-State: AOJu0YxtYeyXb/ibQEhdwSikq128CVRX7G6FUOTWO4DWR+Wfi2EC5hZc
        /6cOquHRy8lGdp/8tCRqeiAITxhbAZ0NTVET61c=
X-Google-Smtp-Source: AGHT+IGjjfZZyhF8aBrc8arga5Q1x2NL23YNg0eLq9/u1h3fJzX/pm+FRQC/QVJZ6OdzoCYLjk4lm5pADQbrZgiKE0o=
X-Received: by 2002:a05:6871:2284:b0:1fb:648:5207 with SMTP id
 sd4-20020a056871228400b001fb06485207mr17719939oab.2.1702547408842; Thu, 14
 Dec 2023 01:50:08 -0800 (PST)
MIME-Version: 1.0
References: <20231213175818.2826876-1-daniel.lezcano@linaro.org>
In-Reply-To: <20231213175818.2826876-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Dec 2023 10:49:56 +0100
Message-ID: <CAJZ5v0gh0KSogBqtkq6GmK4pZ7iDc2FELr3=P55ifBish_NeSw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PM: QoS: Rename freq to range constraint
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, caleb.connolly@linaro.org, lina.iyer@linaro.org,
        lukasz.luba@arm.com, quic_manafm@quicinc.com,
        quic_priyjain@quicinc.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 6:58 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The frequency pm_qos relies on a couple of values, the min and max
> frequencies. However more pm_qos will be added with the same logic of
> a couple of min and max. Instead of writing new set of constraints as
> well as type, etc... let's rename freq_* to a more generic name
> range_*
>
> That way, new qos range based can be added easily.
>
> No functional changes intended.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

[cut]

> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -77,25 +77,26 @@ struct pm_qos_flags {
>  #define FREQ_QOS_MIN_DEFAULT_VALUE     0
>  #define FREQ_QOS_MAX_DEFAULT_VALUE     S32_MAX
>
> -enum freq_qos_req_type {
> -       FREQ_QOS_MIN = 1,
> +enum range_qos_req_type {
> +       RANGE_QOS_MIN = 1,
> +       RANGE_QOS_MAX,
> +       FREQ_QOS_MIN,
>         FREQ_QOS_MAX,
>  };

I'd rather do:

+enum range_qos_req_type {
+       RANGE_QOS_MIN = 1
+       RANGE_QOS_MAX,
};

+#define FREQ_QOS_MIN     RANGE_QOS_MIN
+#define FREQ_QOS_MAX     RANGE_QOS_MAX

and they would map exactly.
