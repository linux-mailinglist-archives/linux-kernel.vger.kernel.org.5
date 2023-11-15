Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C2A7ED7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjKOWx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjKOWxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:53:24 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D3AB4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:53:20 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-359343e399fso806885ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700088800; x=1700693600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a3cY2tNS0EuD6xrF38Kd/4n7z/7U0EGExpfVo9Y2hIk=;
        b=n3BbqBmWKe1WPukvzgj28IxTfZ8SrYHzyhoV5IemXrP+JLDILOvSJy5M8Y0DbovzLR
         HcUZvxE2chftDbk50SK2N/u4zxt4n+tb+UBb0XiiqzsV85DknqrKWtSBjj8SCsz83Pli
         oodUeVlQoWi5s3tT9JPqhup4cONS/2qw6x3vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700088800; x=1700693600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3cY2tNS0EuD6xrF38Kd/4n7z/7U0EGExpfVo9Y2hIk=;
        b=Q2FwtFe1a0eP9cujiQB4dC4Y9xXDJ/5Cg2W8sH+FVVnyKOt5o1CvXUmWrRbhW+vWH6
         yh3jiuOk0kLHGo9hr+94Uj7Lae80mtyUsca2SlgAv22X+ugCdxxb8jKp/4LZeS8ww63d
         8Uy8ovxB67bqYknOuCSVg+kz0cf9rCvG+cwZ7tx6VU9kBkPwRhLbcJ/UHm1lBr0MyYLL
         nb6dzds8GjMWjpO+E47jd/+rKlQPaqHMxoQE6+Phnpcsy1H5OeyU9Kv2ZoRGRktgFdLV
         nbNYkXzA9wf9vRbwpt0M05WIUPRI8EXqDjNr/ayiukSV/YbNasfyIyYCaqpZuavKihId
         wpOg==
X-Gm-Message-State: AOJu0Yzc1hJ+H2IKxPKJWrGMiYQv6oEzvTWvRu5va9keE5XjSpqxBaV6
        7epo1U6u5EboAKktLuYDr7EaUQ==
X-Google-Smtp-Source: AGHT+IHa+L3O0s1sj7TkY3wIwz5KszbvhYt2NuThs976jvnb7E8qw9L8E0jM1KeA3+Ck357KNPQg/A==
X-Received: by 2002:a05:6e02:1ba3:b0:357:704a:8699 with SMTP id n3-20020a056e021ba300b00357704a8699mr20397824ili.8.1700088800154;
        Wed, 15 Nov 2023 14:53:20 -0800 (PST)
Received: from localhost (74.120.171.34.bc.googleusercontent.com. [34.171.120.74])
        by smtp.gmail.com with UTF8SMTPSA id 1-20020a920d01000000b00357c06be898sm1403243iln.81.2023.11.15.14.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 14:53:19 -0800 (PST)
Date:   Wed, 15 Nov 2023 22:53:19 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 2/2] usb: misc: onboard-hub: add support for Microchip
 USB5744
Message-ID: <ZVVL39UtYmeCIT8n@google.com>
References: <20231113145921.30104-1-francesco@dolcini.it>
 <20231113145921.30104-3-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231113145921.30104-3-francesco@dolcini.it>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 03:59:21PM +0100, Francesco Dolcini wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.
> 
> The Microchip USB5744 supports two power supplies, one for 1V2 and one
> for 3V3. According to the datasheet there is no need for a delay between
> power on and reset, so this value is set to 0.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Acked-by: Matthias Kaehlcke <mka@chromium.org>
