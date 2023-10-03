Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E147B6D01
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjJCPYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjJCPYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:24:22 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC1183;
        Tue,  3 Oct 2023 08:24:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-692d2e8c003so3086286b3a.1;
        Tue, 03 Oct 2023 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696346658; x=1696951458; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uN4fiyo3t0P+IiKJbQXswNHiyNFkc1tt/gCSvM8P6jA=;
        b=Lzxk+i7wIljhq1rSjFBBwkjIh9gACQ6qpNHqD3sCmKclL3eyuev3McsRAHdmj9ajvL
         tkLem7f80m26cX86oDkeKJEzQbpBjSJg7h+T/QRo/eJPOz0czQsBdWKJLkXAvfIIwFuj
         h2NvPCXuO+oERcLHnqSudvMz9nJHTh7Fzqz7pJ0rcO0Flefu7YuzVlnFkKu3FNhXi4ij
         eGJOsQ6TL94cWeM9FaBUWd+3yN+Imo4g1yC/wY2eNjpDKFGRrM8SQOY+dBJWbKjomuka
         1xeZ7i+87sip7qDmygvGjVmCFJp6ZJklKgMSzQjSf+0cYTIYTMQtxxG254IzD8rBur4t
         LH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346658; x=1696951458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uN4fiyo3t0P+IiKJbQXswNHiyNFkc1tt/gCSvM8P6jA=;
        b=iVRib486LTvhRPY2oWNWk3Gjz/++O9LnOzfIXQ7e0zaKgi9E4IyO831tn2LpgW9vwc
         oesRuypgBQIQigDhZvu5xHxq3jNXEb7FQJ9meiL1KALCwU18tByBlZdCXjJtWyf+PaAG
         ffJ6SvVf4LuL4BlIy/wBJtPI97ZHobFgR4Z2O+YgfbfUD4qVzGIpOITTO16OBC81CoBA
         VYGFU9duJz/RComS9l6PUr1ec/zhMzzk4asQWzyQMraz9HEuyN5cZytayynIMjd7Q9K0
         q3FbLJZXsOI//wvkc84/Y1lvNYB+roAMuOwvNI4Szc4u0A5NHGbNBI5WfkhWSyRbIlT1
         uvXg==
X-Gm-Message-State: AOJu0YwBTD9mF8g+BKBpJJGEBSN0PY4zF+eYOnRlNLxt5pLJczIDRPfz
        t+dq/v1U2wcJU6H8j1SsPr8=
X-Google-Smtp-Source: AGHT+IGXQD/GPnh1irr9WDGGG+UGqY7kKJJWTCGu6BSmB1kb38+0VwV93MBJcgmj9V8mKiwbr15GhQ==
X-Received: by 2002:a05:6a20:431d:b0:15e:b253:269f with SMTP id h29-20020a056a20431d00b0015eb253269fmr4239751pzk.28.1696346658185;
        Tue, 03 Oct 2023 08:24:18 -0700 (PDT)
Received: from sol (14-200-166-90.static.tpgi.com.au. [14.200.166.90])
        by smtp.gmail.com with ESMTPSA id x21-20020aa79195000000b00690c0cf97c9sm1485264pfa.73.2023.10.03.08.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 08:24:17 -0700 (PDT)
Date:   Tue, 3 Oct 2023 23:24:11 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 04/36] gpio: cdev: use pinctrl_gpio_can_use_line_new()
Message-ID: <ZRwyG80u6nIf7PGU@sol>
References: <20231003145114.21637-1-brgl@bgdev.pl>
 <20231003145114.21637-5-brgl@bgdev.pl>
 <ZRwtEG1DamMLZC/3@sol>
 <CAHp75VdSDart2b+_d6_9E204JYa2zyFKdh_Pey6Wb4MZ-Z-L0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdSDart2b+_d6_9E204JYa2zyFKdh_Pey6Wb4MZ-Z-L0Q@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 06:17:27PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 3, 2023 at 6:02 PM Kent Gibson <warthog618@gmail.com> wrote:
> > On Tue, Oct 03, 2023 at 04:50:42PM +0200, Bartosz Golaszewski wrote:
> 
> ...
> 
> > I agree with the change in principle, just not comfortable with the naming.
> 
> +1 here. I proposed some names, have you seen my comment(s)?
> 

I have now - any of those work for me.
Whichever is consistent with what we are using for gpiochip functions in
gpiolib would make most sense to me.

Cheers,
Kent.
