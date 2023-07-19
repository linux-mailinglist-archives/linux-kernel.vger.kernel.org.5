Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DFC75973C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjGSNl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjGSNl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:41:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1962E5;
        Wed, 19 Jul 2023 06:41:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6687466137bso4591267b3a.0;
        Wed, 19 Jul 2023 06:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689774114; x=1692366114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwgHr8CTLPsVJE9zJh+kMK112+A4IUVakHWwbTwXwA0=;
        b=nrI8gcr7ZJ1NjDNN9lFT6PfdNehcetqW2SpNed6vSYtHbNU34e0V2A6kSFmvzczRRF
         HYw7i+ZdqNmqIfoVx1F2b3pmrscZf56Rlaf0GmpdbCIYpCNJYseZWlqPeg1OaoW0FGg7
         uMW70xgI0BX7ARW0P1pRJWBR2PsFxv9p905LjKWv4r6i8TcOwGLW0jLyRwwV8BrnX2ts
         AQNFIDNKc9g/94i9JTYGS4CgS6TB4YBCivfMz0iaq4p6m+DGkqkj5hhfBvw2ho6nrGwo
         3OiPQsRHdAa9rkv5de6Ra1GkU9qvCVxB3AQU5ICNCl6FyYcaRr5qC9J5Eaoy0YeuDWvu
         LIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689774114; x=1692366114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwgHr8CTLPsVJE9zJh+kMK112+A4IUVakHWwbTwXwA0=;
        b=DSMVshYRRmYzXC6YgREZkdZi5aF4VZ+jm3uDGJtAa63vqI41crh+wx5/nomYzn/XH+
         K6bJ/6dN+3kGZyA9rkgKGERvrGrtDzIyPJ6CubBJDQWiONPWyNAl/kBxbk/gsQ21hNAh
         4ArVywDu7tAno6IySa63lkbMRPmRcsvEMWHGYAOzjRhwja4gAOOiY2wb4eh8npS+lZDf
         6Xh0/Gc4WDOQRDT33I9PmSXjUcAnkGbMIgyERxbpOEzlI3fDYht1qTgsqkuCMCK7QxTt
         OViaz8fEKzrowuwzFAudvOOO2Zs5AfnnfKZ9fwUn+HQHKGttW+vIB0lIZh33Ho9UtQwD
         1RBQ==
X-Gm-Message-State: ABy/qLZ/nVsPy5Hhc39Q5iTOXdM52xljAzdn7awEw+PDuLwrsc3zQWpY
        B8ztN1+aSYIbCXXBig9+VXs=
X-Google-Smtp-Source: APBJJlGsAfXvyG4VXl4wd0iW+cciqCxLCZi2xTvSe2aHbnCjyxhMK3VjQibmii6oOgB1/Qq+I4jRxw==
X-Received: by 2002:a05:6a20:4c9:b0:134:198b:84e9 with SMTP id 9-20020a056a2004c900b00134198b84e9mr2087814pzd.61.1689774114122;
        Wed, 19 Jul 2023 06:41:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s1-20020a63af41000000b00528db73ed70sm3558061pgo.3.2023.07.19.06.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 06:41:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 19 Jul 2023 06:41:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] hwmon: (sht3x) convert some of sysfs interface to
 hwmon
Message-ID: <30afc318-c7d8-4349-a3c4-2916ac9b8c47@roeck-us.net>
References: <DB4PR10MB626157BC697F2CD6100431359229A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB4PR10MB626157BC697F2CD6100431359229A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
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

On Mon, Jul 03, 2023 at 10:08:16PM +0800, JuenKit Yip wrote:
> update_interval, temperature/humidity max/min and hyst
> were moved to new hwmon interface, and only heater and
> repeatability were reserved as non-stardard sysfs interface.
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>

Applied.

Thanks,
Guenter
