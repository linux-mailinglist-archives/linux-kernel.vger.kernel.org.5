Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687BE7D881E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjJZSSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjJZSSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:18:10 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9507192
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:18:07 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6ce353df504so741347a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1698344287; x=1698949087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Zrdmi0PlCbzd03QyeNEy+ZQ9+9RTjcBkZ1MibcLC6s=;
        b=HYI3nYswUXNb22BFIY6oyu/qIXByeI6frNQ2mwv5CBkSEVH03ByPJfCFbGkCHg7r7W
         LfWRHdunr9XGEj1psEu0/gaUNjZRlCelcwVwCC2joaStgvbhKlzqC+WKV8hsUU4avCLd
         mXjvZHvr715VPTQLbMs5TSGKx4yPNS4X+iFkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698344287; x=1698949087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Zrdmi0PlCbzd03QyeNEy+ZQ9+9RTjcBkZ1MibcLC6s=;
        b=gNCt+XE653A3f6h8KkzDqW2A1t1uiMv7aelg5YWkUqstKSpALSrQbS/58GVmQam8VR
         T/joMw4HtJ/lbGtgqW/WpfHSmohiFc5Dc5CbNy4XC4jZs1H24KmIqylgc/4QfQWDJMgU
         WQFw20UMXd/wyWIVnNkYph0ULqoPuQZ9xCFY4P3+pRLzc93WP+pWhM++dJ9r3MxwxGGb
         UtaNFhuvX31T8YeT9z5sFdqSlctd0lJpXjW6vUvWowtWARGDmKKq/KQ85+xdJVhOTRx+
         6iqw+bMnDIWngJGCYEcjEwwGVKm3rxfmr/hWJ3uYUBysgjSpVdXHKzlttbkVFa2rPMgW
         5UFQ==
X-Gm-Message-State: AOJu0YzCZejE0ugfXDbV2oPUfT2WqfBJ/o2pr9yf8aMgl87CRP4N94XV
        og8VzHh1x62IxesdqFu/nEZXoQ==
X-Google-Smtp-Source: AGHT+IEhH9iVCLpzD7q41stWzYUMoDwk7Inn9AfGlPa4LLttvZiBlDsYRkt/rVnmVZRzHuZbvXTnNg==
X-Received: by 2002:a05:6830:3d0e:b0:6c0:7bab:3457 with SMTP id eu14-20020a0568303d0e00b006c07bab3457mr173489otb.20.1698344287106;
        Thu, 26 Oct 2023 11:18:07 -0700 (PDT)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id x144-20020a4a4196000000b00581f11e81c7sm607913ooa.7.2023.10.26.11.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 11:18:06 -0700 (PDT)
Message-ID: <7703f20b-60e1-4140-8380-5a5157bc49b0@ieee.org>
Date:   Thu, 26 Oct 2023 13:18:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] staging: greybus: camera: Alignment should match
 open parenthesis
Content-Language: en-US
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumaran.4353@gmail.com
References: <cover.1697976302.git.nandhakumar.singaram@gmail.com>
 <d2630a16ff9eca40b03dcade63c197fdd5e5b78f.1697976302.git.nandhakumar.singaram@gmail.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <d2630a16ff9eca40b03dcade63c197fdd5e5b78f.1697976302.git.nandhakumar.singaram@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/23 7:15 AM, Nandha Kumar Singaram wrote:
> Adhere to linux coding style. Reported by checkpatch.pl:
> CHECK: Alignment should match open parenthesis

Generally, the result of this patch in isolation looks OK.
But when you compare it with your next patch, what you're
doing here becomes inconsistent with the indentation used
for the function arguments there.

There is value in consistency as advocated by checkpatch,
but there's also value in consistency within a single
source file.

I'd stay away from these white space changes.

					-Alex

> Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> ---
>   drivers/staging/greybus/camera.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> index ae49e37a87e9..6516e7efaab9 100644
> --- a/drivers/staging/greybus/camera.c
> +++ b/drivers/staging/greybus/camera.c
> @@ -220,7 +220,7 @@ static int gb_camera_operation_sync_flags(struct gb_connection *connection,
>   }
>   
>   static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
> -		struct gb_camera_configure_streams_response *resp)
> +				      struct gb_camera_configure_streams_response *resp)
>   {
>   	unsigned int max_pkt_size = 0;
>   	unsigned int i;
> @@ -378,8 +378,8 @@ struct ap_csi_config_request {
>   #define GB_CAMERA_CSI_CLK_FREQ_MARGIN		150000000U
>   
>   static int gb_camera_setup_data_connection(struct gb_camera *gcam,
> -		struct gb_camera_configure_streams_response *resp,
> -		struct gb_camera_csi_params *csi_params)
> +					   struct gb_camera_configure_streams_response *resp,
> +					   struct gb_camera_csi_params *csi_params)
>   {
>   	struct ap_csi_config_request csi_cfg;
>   	struct gb_connection *conn;
> @@ -783,8 +783,8 @@ static ssize_t gb_camera_op_capabilities(void *priv, char *data, size_t len)
>   }
>   
>   static int gb_camera_op_configure_streams(void *priv, unsigned int *nstreams,
> -		unsigned int *flags, struct gb_camera_stream *streams,
> -		struct gb_camera_csi_params *csi_params)
> +					  unsigned int *flags, struct gb_camera_stream *streams,
> +					  struct gb_camera_csi_params *csi_params)
>   {
>   	struct gb_camera *gcam = priv;
>   	struct gb_camera_stream_config *gb_streams;

