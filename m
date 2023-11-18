Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284B57F01B2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 18:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjKRRsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 12:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjKRRsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 12:48:00 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F5AE1;
        Sat, 18 Nov 2023 09:47:56 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6cd09663b1cso1981988a34.3;
        Sat, 18 Nov 2023 09:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700329676; x=1700934476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XsSqYSIJ5c5j/NxuMtae8Hd+oDuANctNoZleK9CaD8=;
        b=kFy2ldJlyGscgYbrF6eor4Eca9gEzwm9UOskitkw88mAk5YRP+XyKqo/oPtsLdd1Gm
         uWxBFFZpMVisFZgl9qN2xIeuuxLVcqyiO48ktBNWF3hahLt6ruiiHwdD6V5wLHcnuyU0
         5ax64UK9/ieC03/25crwoXIO8KB++w477wlhi7zMYRd4ud4QZqWcJ2/MSoWeq2g0LNYl
         s0lHae+IUiQE6oOTUpHIHhS7LhrgStu42suPNaOhR94Pow7BO4shx+4bDIXrT8LOt/Ag
         nyDLqD//WRqPG2fq1kpPiFLJHERHNuDhffBncbxqJwRYsDyuWuYkFaend+nEl9f7TYCn
         XB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700329676; x=1700934476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XsSqYSIJ5c5j/NxuMtae8Hd+oDuANctNoZleK9CaD8=;
        b=RvLnzdqm3jZ2uS31Gl9ig5owP1rgWjAe/HPg9C2LKLMNe/zrprtse9mXRTTfOZXszl
         mtjT+xqFC7JmNjtqIDNs9VhSQAiurYda5IQw239HvTnrZvR1YwtmHgo+oItoHUbcivnf
         wzB4p3Jg6GkVJjRfrJtaeuFDrB/LXjUNsUI5J1B/wfqW0dBmqjvzQc6SSFt/Z0Qzjuwl
         r2HbLv5DtiDEDmT+TA8nRK+PFezCzDSvUm/BLQc7o++xkQK6wXDnLyvDVnnLTKafHfDg
         E2jpnTw+7XXn/Q4DsHy+JMdQJkXRoutc27Q5XO95lC25SL9mBfgfzS7INrWRtLjsWrEW
         UOlg==
X-Gm-Message-State: AOJu0YwUFg0vxFf26x5tzSTHrr8Q/4cqmQb9wwGybeLUipaHyyv5X9DP
        +zjA0NHZcRRqRGNopa3kzDxHxxb1Xjc=
X-Google-Smtp-Source: AGHT+IHm/aC/qK0Jdh3n3Ye8CdDzYwQVaqNOPuKyvCiVlEDsg8z8JxptpoCfaAgLvaGx6+kttZDmww==
X-Received: by 2002:a9d:6194:0:b0:6d3:28c1:bd46 with SMTP id g20-20020a9d6194000000b006d328c1bd46mr3249670otk.10.1700329676059;
        Sat, 18 Nov 2023 09:47:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2-20020a9d76c2000000b006d30ebfc7dasm646670otl.7.2023.11.18.09.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 09:47:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 18 Nov 2023 09:47:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ABI: sysfs-class-hwmon: document emergency/max/min
 temperature alarms
Message-ID: <7c3dab24-308e-4da5-881f-5727c0afdf09@roeck-us.net>
References: <20231116-hwmon_abi-v1-0-8bfb7f51145a@gmail.com>
 <20231116-hwmon_abi-v1-4-8bfb7f51145a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-hwmon_abi-v1-4-8bfb7f51145a@gmail.com>
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

On Fri, Nov 17, 2023 at 07:40:37AM +0100, Javier Carrasco wrote:
> These attributes are widely used in the hwmon subsystem, but they still
> must be documented.
> 
> Add tempY_emergency_alarm, tempY_max_alarm and tempY_min_alarm to the
> ABI documentation according to their current usage and access rights in
> the hwmon subsystem.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter
