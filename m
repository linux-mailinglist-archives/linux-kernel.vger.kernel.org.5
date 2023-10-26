Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D0D7D882D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjJZSUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjJZSUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:20:52 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8811B9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:20:50 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b2f4a5ccebso742561b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1698344449; x=1698949249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zD9c3qk1zR7XohQX5ahXN11vQdLFMJ+dj+AbgUO48eE=;
        b=MkwQingpnUfpWQ882rMdNyp7ER7EpAotba/gzkXUCa4J1oCl4TCs46N+Hm4G16vYWD
         oZk10J8ZtbCdk0Ik53iCqD5n25hz7FZ4/ZFk+ov2tX1h/kY8XxgyVg/n2m1p4omnCfik
         fqv0T2BFCQQ1nNp1EOVlBFcpqJW4lj1t/oJfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698344449; x=1698949249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zD9c3qk1zR7XohQX5ahXN11vQdLFMJ+dj+AbgUO48eE=;
        b=vFSp6Vl7ukse8nIFqbDASFikAX0gFrGr8DLn4PeVoBvO792c5XiOO1y3gJqLrNI32S
         5bIywhVDFYbCZBjHWtOQpfloFUzy8RWMDuiRxdvWivforByEz2MdQEZvT6Wch7beatUQ
         gLHdb+C/ykWrMRIrjCw+ExJYdFjQYpjgXKiGzSOzeUKyHrkTDqZ71hsAvLj/e1Wlxj8U
         P0M8c/h3xEdyYLWhjb6OwkwMEa/xlwvgpH4tva8ztb2IKa9OhteKCNoSm2fNnqDlSeKe
         KZ1jTF+NrFXi5KYhm+3GEHQB+L6aPANM0XLOhm4amKOie5p0GwRx21LeC5KzWlj/Fhvn
         GEBw==
X-Gm-Message-State: AOJu0YzSGuEKVJLQm8TcrOAxmzd+XqRMPzTa4QkaA4gnhPDhzkweS8eH
        Sfe3kI3FaqwcBqSe9LBFQNGpwA==
X-Google-Smtp-Source: AGHT+IF81kqYKRpUAdo55BhO6rS7qI2l7xrzwZ9WNDOVB0ff4TIsIPfZ0l6kDz3LLIAX4RzIAJN5ig==
X-Received: by 2002:a05:6808:f8e:b0:3af:9fc4:26c6 with SMTP id o14-20020a0568080f8e00b003af9fc426c6mr171353oiw.20.1698344449334;
        Thu, 26 Oct 2023 11:20:49 -0700 (PDT)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id u15-20020a056808150f00b003ae5cb55513sm2889138oiw.38.2023.10.26.11.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 11:20:48 -0700 (PDT)
Message-ID: <5d457162-d20a-43a5-989e-ef263fbd91b2@ieee.org>
Date:   Thu, 26 Oct 2023 13:20:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] staging: greybus: bootrom: fixed prefer using
 ftrace warning
Content-Language: en-US
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumaran.4353@gmail.com
References: <cover.1697976302.git.nandhakumar.singaram@gmail.com>
 <39be7bb04ce1362b00aa31a638ebe2e88dd81fec.1697976302.git.nandhakumar.singaram@gmail.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <39be7bb04ce1362b00aa31a638ebe2e88dd81fec.1697976302.git.nandhakumar.singaram@gmail.com>
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

On 10/22/23 7:22 AM, Nandha Kumar Singaram wrote:
> Adhere to linux coding style. Reported by checkpatch.pl:
> WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> 
> Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>

This change looks reasonable to me, though I don't think
ftrace provides device information.

Acked-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/staging/greybus/bootrom.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
> index a8efb86de140..79581457c4af 100644
> --- a/drivers/staging/greybus/bootrom.c
> +++ b/drivers/staging/greybus/bootrom.c
> @@ -491,8 +491,6 @@ static void gb_bootrom_disconnect(struct gb_bundle *bundle)
>   {
>   	struct gb_bootrom *bootrom = greybus_get_drvdata(bundle);
>   
> -	dev_dbg(&bundle->dev, "%s\n", __func__);
> -
>   	gb_connection_disable(bootrom->connection);
>   
>   	/* Disable timeouts */

