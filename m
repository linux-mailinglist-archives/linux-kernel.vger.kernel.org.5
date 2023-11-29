Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29A77FD7A9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjK2NOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjK2NOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:14:54 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C688883
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:15:00 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b31232bf0so54124715e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701263699; x=1701868499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCb7mO0P65hH982TSTp6VehL+Jw2ctYJ381TqQAIXHw=;
        b=oqU/7FAgIcKgw5Gvky7LX0iZ9F2BKF+QEux4zlBNMfryZtMsusj6gcxeAvAhxXM3BN
         ao/knDPBAmE7nKgjorD2bhc0nKdlLebb+euJ222sqShtUvUyEmot7ZyyOIcP8cjcj7Iu
         GR+qHgR0sKy3qOEA2rHr/AWyrBnMhMkFm983/85PCD8L14UCoAbxvSaTOMeg2hQNzkyl
         1YlM/TK1wyqr8uOiy6wR+yWpdPzdk+cOQrc5Mnwx+NZp0rNRpYQ7+E78YJExEuBy21hK
         ky0vl9IBW8HlE+j9/0K7IZ9pkpgEpeQZq3vxCOznOOSJvPhVYo4KyqosrvDtvJ30N2tA
         5LPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263699; x=1701868499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCb7mO0P65hH982TSTp6VehL+Jw2ctYJ381TqQAIXHw=;
        b=OS2WHqS/ESI0EEncWAfTgzRtUCDpcuKAnFYs7w7rQzE7CB5aEahpEwB3ReiGauUfB4
         WOgh1KCoLj32uFYG6U3EqsP8xKDJEmNlwxIsqljnn+g1wNrxDlGrzlNSyPm91CltNQBu
         jg8N7KrxtKrDMMVBC8WcUaDC8vcTm/qsuuZSezKykkfDLbFR9+i4C8ktzTqtks5wnY2z
         otoKEnDt6iXChjDf7tgufAMUMWs+mXuHt2hGf3N9LuKdZm6XBHWgki1FY2Lvu7Qi4Rj/
         STuOFlpbFEX/+tAcAIdu2itaxbiDHBVudNz0ditvgp5LMCUB08Mn3lAbeyFKTDVQZz7l
         3m4w==
X-Gm-Message-State: AOJu0YyvO6G03HbzfaFUcxlFdRz3kO5aZgTJ8dIdQLcScEkbv3agi0In
        GGkdimY48nh8dhkvHbwn3D2irw==
X-Google-Smtp-Source: AGHT+IECLzmX8tnTjge8QgN9y71O8HaUe8WVuFH5FAYhx+jzE27lljnm0cOhKi+7XoSsIN0MkAcYNQ==
X-Received: by 2002:a05:6000:1a48:b0:333:130d:4319 with SMTP id t8-20020a0560001a4800b00333130d4319mr2468608wry.17.1701263699272;
        Wed, 29 Nov 2023 05:14:59 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332c0aace23sm17799621wrc.105.2023.11.29.05.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:14:58 -0800 (PST)
Date:   Wed, 29 Nov 2023 16:14:54 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Thomas Richard <thomas.richard@bootlin.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        s-vadapalli@ti.com, grygorii.strashko@ti.com,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        u-kumar1@ti.com
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: improve suspend/resume
 support for J7200
Message-ID: <1d1490a2-7d7f-42b8-862e-f0959544a520@suswa.mountain>
References: <20231128131936.600233-1-thomas.richard@bootlin.com>
 <e37e8d74-d741-44fb-9e28-2b9203331637@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e37e8d74-d741-44fb-9e28-2b9203331637@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 02:38:49PM +0200, Roger Quadros wrote:
> Hi,
> 
> On 28/11/2023 15:19, Thomas Richard wrote:
> > From: Gregory CLEMENT <gregory.clement@bootlin.com>
> 
> Subject is vague. Please be explicit about you are trying to do.
> 

I'm glad someone else said this.  I wrote a similar email but never sent
it.

It's not clear from reading the commit message what this looks like to
the user.  Is the network slow or does it stop working altogether or
what?  Is there an error message printed in dmesg or something?

I feel like if I were more of a domain expert I would understand the
impact better perhaps?

regards,
dan carpenter

