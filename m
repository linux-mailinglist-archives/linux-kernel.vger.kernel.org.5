Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0296180E38B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjLLFJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLLFJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:09:12 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1ABBF;
        Mon, 11 Dec 2023 21:09:19 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7b6f2dd5633so323860939f.2;
        Mon, 11 Dec 2023 21:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702357758; x=1702962558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9G38MnYxloPLTIZ+OetQ1mORKFpiowG0dMHn9jL5d7Y=;
        b=BVVI70EocFk/Nto5gC2zA+NTuZKnFJ83M6JfguJfFq5O6BzAeSCpFYiOZe7nTrjf3h
         77BpBJdupAS253qGBVfRZ1Wxz/yiPRrnlsymKQWe6JnnKbts4zngikGv2lc3usYRwrXw
         3vWhUXuVwzDAOLfQxsBd2Lzovdq7mXm1LXoxShxYRC8BLKVIefxj+vscNnC5Kjlqc60Z
         zwgx3wUFG1AHNhzf7gSlnGAzKW+hC72/VQex26oVvJmyalutAiDkuZvW6q8fGxs+FqZE
         7wtjytGiZTFXWQwbg1+aRtAZ0rqySu8ln7BV0x3wpoICGT1eCRmu2KKxFHO63nizI4sG
         acYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702357758; x=1702962558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9G38MnYxloPLTIZ+OetQ1mORKFpiowG0dMHn9jL5d7Y=;
        b=LeBB5THjIgbalh+xJydiy+0Jj0iwMLDEjenFSrRYfR2+Q6echegF6rDNL2J3BRvH4y
         tPXCtcZE4g+6VCefn2JjX31ccm9TuP9d+/CKtHnIxqx9ssOUrCXhkRGVZD3eR+CHhEXN
         LhrlhmI4sNdSZEfJFSV/IMdBS2MldveUDcNbxjdJ8R70dZi5fS9NqHfIlvhZKYiM7snF
         Q1ScT2fmtalCUibuqAnpqt1Ym4bJjbqB18lYpROgkqTG9YorulYdGJoyZvf20oUGNiTw
         vyv31JipG3yRGohW/4ZoEGnsOcA13qqBWNnsyKf4jCRJ6HwmxQ+E71hyrF/27ok/0Iw/
         qYAg==
X-Gm-Message-State: AOJu0Ywo8H5UnOSVx9MfrNqiniqGlbpVC4857WTsRf015Sy/nWuOJnfI
        vsN4dEKbQ7vR9b/oAY9je+4=
X-Google-Smtp-Source: AGHT+IEXLTMAR8yoR+tMUOcvaWMCmDMJWvbVwLEPR1/YKZgRhFI0CkInsXMHnxwuruCFVjtNQf1D4A==
X-Received: by 2002:a05:6e02:2142:b0:35d:7b57:2294 with SMTP id d2-20020a056e02214200b0035d7b572294mr9341168ilv.32.1702357758245;
        Mon, 11 Dec 2023 21:09:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001b9e9edbf43sm7582929plk.171.2023.12.11.21.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 21:09:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 11 Dec 2023 21:09:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (k10temp) Add support for AMD Family 19h Model
 8h
Message-ID: <274237cb-ac4d-430f-8d41-98b2bdb2eb1b@roeck-us.net>
References: <20231211210206.11060-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211210206.11060-1-W_Armin@gmx.de>
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

On Mon, Dec 11, 2023 at 10:02:06PM +0100, Armin Wolf wrote:
> From: Jami Kurki <bindkeys@gmail.com>
> 
> Add support for AMD Family 19h Model 8h CPUs, which appear to
> be the Zen 3 based AMD Threadripper 5000WX series (Chagall).
> 
> The patch was tested with an AMD Threadripper 5955WX.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218244
> Tested-by: Jami Kurki <bindkeys@gmail.com>
> Signed-off-by: Jami Kurki <bindkeys@gmail.com>
> Co-developed-by: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Thanks,
Guenter

> ---
> Changes since v1:
> - reword patch description
> - reduce changes to existing code
> ---
>  drivers/hwmon/k10temp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> --
> 2.39.2
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index bae0becfa24b..8092312c0a87 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -455,6 +455,7 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 
>  		switch (boot_cpu_data.x86_model) {
>  		case 0x0 ... 0x1:	/* Zen3 SP3/TR */
> +		case 0x8:		/* Zen3 TR Chagall */
>  		case 0x21:		/* Zen3 Ryzen Desktop */
>  		case 0x50 ... 0x5f:	/* Green Sardine */
>  			data->ccd_offset = 0x154;
