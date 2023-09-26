Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A755E7AEB43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjIZLSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjIZLSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:18:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A35E5;
        Tue, 26 Sep 2023 04:18:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso7551412b3a.1;
        Tue, 26 Sep 2023 04:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695727080; x=1696331880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWBGxa76m7aeagTgko1i4QtCRID1/zltTLr5CfyYfo0=;
        b=RUyfcL9+hYc06OG+MapNaaORN9Qgdzy8AE5hODr/UBAbGdHSRXMKwJtp+sdYR+xnhZ
         Fl23Jsx2MY1/+FZqYSBpZL+FKrD8j4PQLaZ3QYXcnu1Tuay0lZtdm1kw3rGWezeVBNM4
         Ae1uK79LrLUn2+wDdkGiMiWBk06bJFCrtLVZ5uUEsGdRxfXFcHJ2dANld+AtR47ASCDA
         YfOxXfAKCNb9xAzzbpp7SH7w7Ww+vO8HAS7KxUsrRk/zwuDNQ22pj2+UiTGRwxM+eaKj
         7DlvgQvr5tSrBQp9+lbw1pl0fsY7cBjSJWdnEPTLF353eqC7SI7KGV6Zz09tfK+s0WCc
         R4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695727080; x=1696331880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWBGxa76m7aeagTgko1i4QtCRID1/zltTLr5CfyYfo0=;
        b=mrSq7EJ9SefN1tO6bnRV9VzKFfcypqttxc+O/MixObdFmQQZvw1cL0j+CYX6nXsD0Z
         xhYnArsVlefz9HJcc9Oc4Us6yF0UPXFtmXA4WbYfj/d9P1yZ/IhbPfU7H2mIH4NzY3/U
         JV8Sww8oO5IWQMDRavbVsvvUjUQX6128GxSGF9QYLEb7D1vXjA3/nvZlAzvyMbdu9dxM
         TPM3CS7zvXnrizc4yq1zrsv3RNFrqxXfF73xCGYpFhSXLxEdTnzHN/li6311Ur5xbtMZ
         A/UQNHFNsL5RKvNpgagufN9vyvMkXgTk+ieDtDTNYY19g3F9w/yvISHqZ8IENQJncFdS
         K3EA==
X-Gm-Message-State: AOJu0Yw52AjVYku1IQTuUtKN3c+QJ7QosQgT54tSmV7OlqN+Sqo3pO2b
        DotDVHfxRMIImczIiu24Qfg=
X-Google-Smtp-Source: AGHT+IGlxqmWKwg1Nds/ON39ID63GQjhIr13e4Wxhk4DX4WRVDLkvJrfHCMgPjn59wIuLIw8meGpmQ==
X-Received: by 2002:aa7:8893:0:b0:690:2ecd:a597 with SMTP id z19-20020aa78893000000b006902ecda597mr9672823pfe.21.1695727080615;
        Tue, 26 Sep 2023 04:18:00 -0700 (PDT)
Received: from sol (60-242-83-31.tpgi.com.au. [60.242.83.31])
        by smtp.gmail.com with ESMTPSA id l22-20020a62be16000000b0068fe9c7b199sm5814518pff.105.2023.09.26.04.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 04:18:00 -0700 (PDT)
Date:   Tue, 26 Sep 2023 19:17:52 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 4/5] gpio: xilinx: Replace bitmap_bitremap() calls
Message-ID: <ZRK94EzQ6atqGvLG@sol>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-5-andriy.shevchenko@linux.intel.com>
 <ZRK1PA2vZBdfAozG@sol>
 <ZRK8Uq699oeSOOg6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRK8Uq699oeSOOg6@smile.fi.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 02:11:14PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 26, 2023 at 06:41:00PM +0800, Kent Gibson wrote:
> > On Tue, Sep 26, 2023 at 08:20:06AM +0300, Andy Shevchenko wrote:
> > > We have sparse and dence masks of the line mappings based on
> > 
> > dense
> > 
> > > the view point (Linux numbering or hardware numbering). Since
> > > the Linux side uses sequential bits for the mask, we can simply
> > > convert a Linux number to the hardware one and vise versa by
> > 
> > vice
> > 
> > > counting set bits in the respective mask. Hence replace
> > > bitmap_bitremap() calls by simpler equivalents.
> > > 
> > > With this done the dence mask is not needed and thus dropped.
> > 
> > And dense again.
> 
> Thank you, Kent, I really appreciate your help with my poor English,
> nevertheless it would be nice if you can look at the last patch and
> maybe even test it, so we have a bit of confidence that it works
> as expected.
> 

Well that is the plan, but I haven't been in the GPIO space for a while so
I need to pull my test setup out of mothballs first - so don't hold your
breath.

> (The spelling will be fixed in the next version.)
> 

Those I can spot without needing to compile anything ;-).

Cheers,
Kent.

