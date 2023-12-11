Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F4E80CDC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344365AbjLKOOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343978AbjLKONn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:13:43 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134B6D68;
        Mon, 11 Dec 2023 06:08:26 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d0897e99e0so25238275ad.3;
        Mon, 11 Dec 2023 06:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702303705; x=1702908505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SA/gWEJ70l496ZRPZ8Gq6NqqTI/TZ5zOjo1CG3aNWQk=;
        b=Q9xsisik4dyxNQJT3GzVZx1Hbb3csEMO8mB1bykDgG0D8cJ3rkGbuRs5xNYLKNMvDD
         OiAjWprq6qV7ipgFY8KdiKLQx7cfkZxNVtrlgikvXLAk0K4ReQIUMHGrBH3YqDpWkxAX
         4ChwWHxX3Uv5rgldwNyuyY7B/7I21hCNT5g6pIhRUMGpTMV1HGwDIW/OrsHjffCFedLP
         T1adQ+XYM2TOGh+Hkh6UzozpJTrjc9bvkPz4kuMkUnOBH6+5pkM49dp5q/kS95Kp8wr3
         r1A4VnpAkPxslkh0+UM+JlfYdwVBp3JR3zUs89Dr8Qa9McCkR1Sx6Ve98h93QwyiHZK7
         guGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702303705; x=1702908505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SA/gWEJ70l496ZRPZ8Gq6NqqTI/TZ5zOjo1CG3aNWQk=;
        b=No2ICBgwpkDHlm/t61APqxKrhbvZ0y9N60ysNRztolI3LyOXICXB35PmbAouWLMlhh
         ChObXdulQJodKjUg6WLANNDqgNL3vR1PYO5YJGytUrYpXMJmLvDOl1JF2hZ1fTi99iS1
         yTDUIdWCV43gymzhpIX0/+hxZ0QvZEzjHGmAKU5qFxPYyaRvWoddy+2h/CmySfZsWq2/
         JKm8APQj4UnhLvbV8PaKX9CbKbXI7wg/TXpAooRP1J4HDlL5A9KIkk8yBZDpNsUKH+Ub
         g3JUjvohj1zdiQPXHj9kzQCCSgpW9fHC1+L0b6NIeeiPP3VLOu6zLGSl/5+MvQLzA2e+
         QHTg==
X-Gm-Message-State: AOJu0YxRXSwaeV/skJoCgaXdm8bbsEokQyPG86M/hsTgRi3OdVJNkAqo
        aKhw0m4IZBJLzconeH0VgHs=
X-Google-Smtp-Source: AGHT+IGDcZb85iygTV3TyMJjWVksVAZna//2oldQ/wT2yJQBkQFQjIaE0S8zla33N9vUr227Mm9w0g==
X-Received: by 2002:a17:903:25c2:b0:1d0:9c97:6fed with SMTP id jc2-20020a17090325c200b001d09c976fedmr1714985plb.44.1702303705301;
        Mon, 11 Dec 2023 06:08:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902680800b001c736b0037fsm6835239plk.231.2023.12.11.06.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:08:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 11 Dec 2023 06:08:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marius Zachmann <mail@mariuszachmann.de>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] hwmon: corsair-cpro: use NULL instead of 0
Message-ID: <5872278a-32e5-426a-8c3c-f8e7cfc42901@roeck-us.net>
References: <20231210220357.77036-1-mail@mariuszachmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210220357.77036-1-mail@mariuszachmann.de>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 11:03:57PM +0100, Marius Zachmann wrote:
> Replaces the integer 0 with NULL.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312100455.k6m2eO4N-lkp@intel.com/
> Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/corsair-cpro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> index 463ab4296ede..a284a02839fb 100644
> --- a/drivers/hwmon/corsair-cpro.c
> +++ b/drivers/hwmon/corsair-cpro.c
> @@ -524,7 +524,7 @@ static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	if (ret)
>  		goto out_hw_close;
>  	ccp->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsaircpro",
> -							 ccp, &ccp_chip_info, 0);
> +							 ccp, &ccp_chip_info, NULL);
>  	if (IS_ERR(ccp->hwmon_dev)) {
>  		ret = PTR_ERR(ccp->hwmon_dev);
>  		goto out_hw_close;
