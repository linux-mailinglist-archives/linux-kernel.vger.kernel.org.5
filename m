Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD0F767FAF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjG2Npm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjG2NpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:45:12 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFB44222;
        Sat, 29 Jul 2023 06:44:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686f090316dso2063854b3a.2;
        Sat, 29 Jul 2023 06:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638274; x=1691243074;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sev6PZB5p9j4diKzuo/6/Fhl8pFz5mbhHBi6Dw/7j98=;
        b=sQEJRbxbsdl14knNrD1vZKgQYKJQb55liyRsLwlgVmAJMyglVoHzPh3sUxonF7BpIF
         GbPJ6ZJ4ox5l8plv1IGQ/DpOKUvduEK3oeBs9LFGhH/77ix4b+p7agJkN8DS6GNtgF3O
         QWMkGSEgr+RZGYyztEDVIY94xMbbWH0k+GQtS+hBgKLS07DE+n4lFMKkyUtRwlPdHldg
         QhmYpPGj5tauu44PMyrkNn8/GZ5FvyOpdtpW8RooSG2J5fTqh6V+gasQM2k+csf+d79f
         nXhPMeifCsoHnya5QBLXyi6XgCGTZjzNlexiGejgPTceBTL/y3YUckpd4Yz/QIETet5W
         qdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638274; x=1691243074;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sev6PZB5p9j4diKzuo/6/Fhl8pFz5mbhHBi6Dw/7j98=;
        b=ALT/Y2XMfer8qIXpU9yMXH8fHUuaZ3+scgsS2lpYRpzmAkjCm0W16mO/Vro6sGkjXv
         wIxPSIbBUojVrbkX9Imti0wb6qpsTmIef/bMcxslV2eMy6QCB+gYj5dQ1LM4NdBHlHxc
         d5z6RpqJCBxz0Fv0mIglSrXkOM91NeRkNNfrVFl0lzfjKHCrLv1wYPUauXdU4NdhPeyB
         29On//Y60asMsDmKZIZg1C3rbgC1d/WlvTq6dOsCLvuivIDnnnXhjovHPvUqUqaU2gDm
         nQ8tNbv/2rHVAsImCOmOxAiyhha9IKI1ot6ynaYGN1683mxSrmKz4csUwRRJxoOChTIO
         HOeQ==
X-Gm-Message-State: ABy/qLY3r5peFBATPypeDI6reYOq39tl5V5Cqis1nqUpWiXXe2gYIuBb
        jrd6ztNNVzAS4QtixyVVfGf+vmlUn58=
X-Google-Smtp-Source: APBJJlGg/FvtwXBo9Qu1/M9v56UrqhfesW8KOSMc3Qne7V7oZVh5CFlW+WOzSqaYEh7+1WDgg6LTAA==
X-Received: by 2002:a05:6a21:3e0c:b0:133:e3e3:dc07 with SMTP id bk12-20020a056a213e0c00b00133e3e3dc07mr4439349pzc.49.1690638273816;
        Sat, 29 Jul 2023 06:44:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f9-20020a639c09000000b005572d796b9esm5204396pge.88.2023.07.29.06.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 06:44:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5b988c94-0de3-95fd-de39-66b52a59cdd6@roeck-us.net>
Date:   Sat, 29 Jul 2023 06:44:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     stable@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
References: <20230729112732.5516-1-savicaleksa83@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add selective 200ms delay
 after sending ctrl report
In-Reply-To: <20230729112732.5516-1-savicaleksa83@gmail.com>
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

On 7/29/23 04:27, Aleksa Savic wrote:
> Add a 200ms delay after sending a ctrl report to Quadro,
> Octo, D5 Next and Aquaero to give them enough time to
> process the request and save the data to memory. Otherwise,
> under heavier userspace loads where multiple sysfs entries
> are usually set in quick succession, a new ctrl report could
> be requested from the device while it's still processing the
> previous one and fail with -EPIPE.
> 
> Reported by a user on Github [1] and tested by both of us.
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/82
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
>   drivers/hwmon/aquacomputer_d5next.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index a997dbcb563f..9cb55d51185a 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -652,6 +652,31 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
>   	ret = hid_hw_raw_request(priv->hdev, priv->secondary_ctrl_report_id,
>   				 priv->secondary_ctrl_report, priv->secondary_ctrl_report_size,
>   				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Wait 200ms before returning to make sure that the device actually processed both reports
> +	 * and saved ctrl data to memory. Otherwise, an aqc_get_ctrl_data() call made shortly after
> +	 * may fail with -EPIPE because the device is still busy and can't provide data. This can
> +	 * happen when userspace tools, such as fancontrol or liquidctl, write to sysfs entries in
> +	 * quick succession.
> +	 *
> +	 * 200ms was found to be the sweet spot between fixing the issue and not significantly
> +	 * prolonging the call. Quadro, Octo, D5 Next and Aquaero are currently known to be
> +	 * affected.
> +	 */
> +	switch (priv->kind) {
> +	case quadro:
> +	case octo:
> +	case d5next:
> +	case aquaero:
> +		msleep(200);
> +		break;
> +	default:
> +		break;
> +	}
> +
>   	return ret;
>   }
>   

This would force writes to sleep even if there is no subsequent operation.
Please make this conditional by saving the most recent access time and wait
on the subsequent operation. I would also suggest to store the wait time
in struct aqc_data to avoid the switch statement in the data path. An example
for a driver doing something similar is drivers/hwmon/pmbus/zl6100.c.

Thanks,
Guenter

