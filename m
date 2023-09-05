Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A95E792B15
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjIEQra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354104AbjIEJjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:39:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB6F1A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:39:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50091b91a83so3793441e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 02:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693906740; x=1694511540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i199O6KiKKQM7slulMeIIsZKZZFjKrLdAh5+q0Dt1H4=;
        b=N/DWZxW6NVKhyspA7d8cM+gRsGCcrel/b7uf5r0ilh9UpYovkh5QcIUvhsjN50yeI+
         5CrxzG8T++XzdORdl+L7l409hV+qYAKEJnZZnU5xIE4ObE/65U7/vHXlhuzjhHmjnJI/
         5PNSIMo/vPqn1plP7QoEXHrzRhZ5/5GxHNydsz3I0OLO/XSCIlNyMpTQ/qXwWvCnJdkJ
         +GZ4BRZ9JjxVxWvL4Q+vB5GtQdqmdZaAhiliS0N4F1CNsJHjNvR1tJ96eH8fHTJLCL11
         Ni3h2sdbEIazd4NxsAMJ9CdhuAazOiM8TcK+Tln0+ZL6QXKhmH/qRxtiu0trHN2Jffgp
         fyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693906740; x=1694511540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i199O6KiKKQM7slulMeIIsZKZZFjKrLdAh5+q0Dt1H4=;
        b=ZM0iFQRZuu77xVErtLgmu3yL6p4ms/zXBeOgwhYl9JMgtD1JBgNghAwhqGGkkJkQPJ
         637QooCxWqAKEWxICViIajIVMI8iMAnOeO/DIrq/DJOE7gJh9ugQDeRT8TdykJ8SJpUg
         u4q8uHCpiNpaekY3761lF3VyUHEFNIxPdNTTOrU9YKUCMfvrJHUvl90RLYJnJmdaQmhD
         YS2f6BIv7znKXxbn89axQPrGEj8NOtbn+ZGz4byX1KtmyQ/aRz13HTw0A2oH+8AhmGPF
         qowjCUbVhZo5xzvm+rsL80IKfWQWNzDegcxSAA6WfDuBhPuNV/TFkI8BJVIHgvfZq04u
         bUOw==
X-Gm-Message-State: AOJu0YxBzxyHbzZw+17XAq0n7M7UV7QsHIedlQgJkRY7HSCsZId9yB8i
        IcXkGxOjy4AHNSxFvNfwyF4KDg==
X-Google-Smtp-Source: AGHT+IHHn25rlu/t0c0vstO4j/XpuwapT2mw2oB/ChLqaG0B8v4X+GFfCmsaepyxblW51Jp99wh0hg==
X-Received: by 2002:a19:384a:0:b0:4f8:49a8:a0e2 with SMTP id d10-20020a19384a000000b004f849a8a0e2mr7254434lfj.16.1693906740044;
        Tue, 05 Sep 2023 02:39:00 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm16707010wro.43.2023.09.05.02.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 02:38:59 -0700 (PDT)
Date:   Tue, 5 Sep 2023 12:38:56 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Oliver Crumrine <ozlinux@hotmail.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 0/6] staging: octeon: clean up the octeon ethernet
 driver
Message-ID: <88fdf861-91fa-4ab7-8f43-53d844e9bca5@kadam.mountain>
References: <PH7PR11MB76434E13489C9713CB562A74BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB76434E13489C9713CB562A74BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 07:58:16PM -0400, Oliver Crumrine wrote:
> Make the octeon ethernet driver better adhere to the
> kernel coding standards
> 
> Oliver Crumrine (6):
>   staging: octeon: clean up the octeon ethernet driver
>   staging: octeon: clean up the octeon ethernet driver
>   staging: octeon: clean up the octeon ethernet driver
>   staging: octeon: clean up the octeon ethernet driver
>   staging: octeon: clean up the octeon ethernet driver
>   staging: octeon: clean up the octeon ethernet driver

You can't send more than one patch with the same subject.  These all
have the same subject.

Also you're resending v2 v3 v4 too quickly.  You should wait for a day.
Do some testing.  See if people have additional comments.  There is no
rush.

regards,
dan carpenter

