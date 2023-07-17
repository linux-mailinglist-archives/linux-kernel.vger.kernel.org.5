Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1711756046
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjGQKUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjGQKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:20:40 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CCEE52
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:20:38 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51e57874bfdso6206288a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689589237; x=1692181237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P73tL154gAMluD/YmTW9RVg+7kBMpe+6XbrldHzvWEw=;
        b=YzBXkYzF5pHHivQi4FJG13p0VeVBQuBeL+QeW3AawJSFMntgvftTAcrqGqsWEOcPbS
         ICoMj/SMIWFhqcvQbNKZ9jT8P2XQzn+LnqnUI56U8KteJ+KqctbUKST6CSWTUmBMFajw
         FxSKTTvWKiMr+MUnS9ZnKJYdNQb+FIp6+LDGNhtRNgKB4tvYhCUH4MkYIJhE+sqUi7LZ
         FoKNMEfTCje4cgKek7pNNKLKuqH4NiO26nZjiidEMCMvTEuqXIJ3KcOjYCb6iu+B7hn8
         SeByrFNCsLWuQDsP0dS4Q03PLVjpXMLtWanu+U63HJ3JOowCxl5BXlkwXydpGDvuFWJv
         ZGXA==
X-Gm-Message-State: ABy/qLZ9rUpvJPCjUuEY2Hdlnsq4DS+eJiuDjNHekVWJ85+c702wDCp+
        Jqp2QyhvFJKR33jzxJlMWck=
X-Google-Smtp-Source: APBJJlFJjX3udv57lND4BIKkLv9MLttr+hmzjU+LczKBZXncUTVigR+LoYDiVKew/kpiqeHpavDy2Q==
X-Received: by 2002:aa7:cd7b:0:b0:51e:166a:ac7f with SMTP id ca27-20020aa7cd7b000000b0051e166aac7fmr10531367edb.28.1689589237033;
        Mon, 17 Jul 2023 03:20:37 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id u8-20020a05640207c800b0051df67eaf62sm9775589edy.42.2023.07.17.03.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 03:20:36 -0700 (PDT)
Message-ID: <0debbf68-ef69-2d1b-42d1-376c05186cbe@kernel.org>
Date:   Mon, 17 Jul 2023 12:20:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ACPI: video: Add backlight=native DMI quirk for Lenovo
 Ideapad Z470
Content-Language: en-US
To:     rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230418064200.24303-1-jirislaby@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230418064200.24303-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this has been likely lost. Should I resend?

Thanks.

On 18. 04. 23, 8:42, Jiri Slaby (SUSE) wrote:
> The Lenovo Ideapad Z470 predates Windows 8, so it defaults to using
> acpi_video for backlight control. But this is not functional on this
> model.
> 
> Add a DMI quirk to use the native backlight interface which works.
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1208724
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Notes:
>      [v2] fix authorship
> 
>   drivers/acpi/video_detect.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 69ef2d9710c2..af5cea005f54 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -459,6 +459,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>   		DMI_MATCH(DMI_BOARD_NAME, "Lenovo IdeaPad S405"),
>   		},
>   	},
> +	{
> +	 /* https://bugzilla.suse.com/show_bug.cgi?id=1208724 */
> +	 .callback = video_detect_force_native,
> +	 /* Lenovo Ideapad Z470 */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Z470"),
> +		},
> +	},
>   	{
>   	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
>   	 .callback = video_detect_force_native,

-- 
js
suse labs

