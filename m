Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019657D05B5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 02:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346748AbjJTAPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 20:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346716AbjJTAPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 20:15:45 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679E5CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:15:42 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-35748b32d73so998845ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1697760939; x=1698365739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mavY78H1YWmzBveT0yeZCxcrcnmsQliTa1UnMt+0QL8=;
        b=N9UKgxS+/MBt5v12j6QEB70xkCMZ8g5LTAHxVEW+BebZTJvXbpYkzo/4NZDSGLsJIT
         5ii5G0nScB65Bpo1MwhkLCpG0V48PKfttbVmkrlejssNnXQvWEJMcgRFJuBBLuTYEhGa
         gGFHGDQRwWfCw1ZZ565aMmP2WeBkvxlSHbd9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697760939; x=1698365739;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mavY78H1YWmzBveT0yeZCxcrcnmsQliTa1UnMt+0QL8=;
        b=XrDAx5fMzRDrcWaDZQkPv6Zskc/mt4n+pvgNumf0ybmqtIi8O3OaXXWQ0ZFSA6ghp1
         DEvO1F5Obpj0k+cOQsC/CuMwhAdrSA6Ocp5nCpc7BMjT+I2Z4d8DbfOm78ogervFTck3
         z5iz8oBySt4ZwCvjhPYRq2bWfmKPnHIJnX+wDrDdGpL/4dZKjsjQIeoWwko1Bk1wrWWH
         iYpexJVzmUXJBTx9IbCsLZbsiAgA6dHExRw4OFJdGTk2dFYJo5nXCRDtuNyL58qWWfdS
         ZtxBV6/U5GJADfp47cl1BW7qn7cmtAivROSIAzFb8d0XCOOEFp5irhX9CPwclA8uakj7
         YAMQ==
X-Gm-Message-State: AOJu0YzA+eKUldLvAa8VQaFYlxtLGxs7/kMgNe2+hXRFoO3oRx/pde8e
        7gvqwEAHKAHBOkGBhskluQ4dNVOoor+IbvLuNvFj1467
X-Google-Smtp-Source: AGHT+IFTT8bntjPNn9KbYkuJLNM8Jou66TfYltHPkHiegMie47QbNKhG+fplwP3pmZrXUi1Ab1wcZw==
X-Received: by 2002:a92:c262:0:b0:351:19a4:8e67 with SMTP id h2-20020a92c262000000b0035119a48e67mr608835ild.28.1697760939322;
        Thu, 19 Oct 2023 17:15:39 -0700 (PDT)
Received: from [10.211.55.3] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id 2-20020a056e0220c200b003512c3e8809sm226274ilq.71.2023.10.19.17.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 17:15:38 -0700 (PDT)
Message-ID: <e24e41be-b2c4-4bda-8a34-a628c55c4061@ieee.org>
Date:   Thu, 19 Oct 2023 19:15:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: greybus: Alignment should match open parenthesis
Content-Language: en-US
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231019213949.GA2922@ubuntu>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20231019213949.GA2922@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/23 4:39 PM, Nandha Kumar Singaram wrote:
> Adhere to linux coding style. Reported by checkpatch.pl:
> CHECK: Alignment should match open parenthesis

Sometimes checkpatch.pl warns about things that are not
really that important.  One class of this type of issue
is white space errors.

Yes, consistency is good, but the kernel simply doesn't
have universally consistent conventions, and I doubt
it ever will.  There might be times where a source file
consistently follows a white space convention that
differs from what checkpatch wants.  Suggesting a
wholesale change to that file to "fix" that typically
wouldn't be welcome.

Unfortunately without some experience it's hard to know
which checkpatch warnings can be safely ignored.  I would
place white space warnings at a lower priority for fixing
than some others.  For example, this is also a pretty
trivial warning:
   CHECK: Macro argument 'gcam' may be better as '(gcam)' to avoid 
precedence issues
And it is most likely not a problem in this case, but fixing
this type of warning is probably more constructive than
just adjusting white space.

I have no objection to your patch, and it's a fine way to
get some experience with the patch process, but I don't
think this particular change is necessary.

					-Alex

> Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> ---
>   drivers/staging/greybus/camera.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> index cdbb42cd413b..405c8e78aa72 100644
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
> @@ -267,8 +267,7 @@ static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
>    * Validate the stream configuration response verifying padding is correctly
>    * set and the returned number of streams is supported
>    */
> -static const int gb_camera_configure_streams_validate_response(
> -		struct gb_camera *gcam,
> +static const int gb_camera_configure_streams_validate_response(struct gb_camera *gcam,
>   		struct gb_camera_configure_streams_response *resp,
>   		unsigned int nstreams)
>   {
> @@ -378,8 +377,8 @@ struct ap_csi_config_request {
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
> @@ -783,8 +782,9 @@ static ssize_t gb_camera_op_capabilities(void *priv, char *data, size_t len)
>   }
>   
>   static int gb_camera_op_configure_streams(void *priv, unsigned int *nstreams,
> -		unsigned int *flags, struct gb_camera_stream *streams,
> -		struct gb_camera_csi_params *csi_params)
> +					  unsigned int *flags,
> +					  struct gb_camera_stream *streams,
> +					  struct gb_camera_csi_params *csi_params)
>   {
>   	struct gb_camera *gcam = priv;
>   	struct gb_camera_stream_config *gb_streams;

