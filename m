Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C167BF947
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjJJLJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjJJLJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:09:36 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4F394;
        Tue, 10 Oct 2023 04:09:34 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-45456121514so2426286137.0;
        Tue, 10 Oct 2023 04:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696936173; x=1697540973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ssZe5t9j2bWoYIJEBCq+KIIOsSZbILqTRL/htZUvZoI=;
        b=d9Gai0IxgVkb0j8g6mI8ShJo3FlTVBHwbu2wEADKOVlisGMF60G+ERsPx2PA4fKzGG
         XrkV4lF7sxSHtLR21YsE1Te7mbE6NZEGpKK0QECcfrlqwnhW4Vtp6nPIaxji3tCa/aCA
         EWrAB8OIyYg5fdlM7FzrrNui/miip8tuXguFXvZN9ska+pAg4yDag/yNk8zlmUtUh0ba
         LygZvwZIyXwb/a2/YRyYgnrXlx/HfHAQudz9LhwERtSdrm1gwvEXafYRSXqrSIglVO+r
         2FdVA1isXKPCeS4V2bHU+oelvuqh8nExSlanPtn7VkOZPXAXi0gzusdw8fKvQaRbAaBt
         UL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936173; x=1697540973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssZe5t9j2bWoYIJEBCq+KIIOsSZbILqTRL/htZUvZoI=;
        b=Lveq/ftgSGaZDIEX52fHsOo9/afoOMtawa4LIHR6CaNTYRqFQJoBkMRaFw1eh+fcTc
         G65bSR4P4Fsbd72BzlDyHCqTgxQXnfAI28EeJiXSo+dJaywZzk8IFKvDGvKc0e5Du7Q4
         Xs4vaVKhHJlgEWYagC+2D6Z5wbGOSWPgsf4MlphYvyat9F4PHxLoPrcy3nIph70J8pTF
         ZKbesjCJHSSsR30Umcq0DvIcVWxYfn6lcNUjWtw/DDt/PH6ZkyM1E14geTHyuKouRpvG
         OCh9iQshWFPHenyKtZEiSJqb6/3cytOOY1yL0HBqX/TVRrxaAgHEw9rVED1AoJ80qkvq
         LNjQ==
X-Gm-Message-State: AOJu0Yw0YHadI8ItKVvTR4KEm1F2SrxETuB8CEzEJ9DyQPj4RCqBjvUL
        ynuIsuLJ66xjMxVFNqj/gBg=
X-Google-Smtp-Source: AGHT+IEcdigPG8BF2XmlMSNn5BBpbombgW1UUubfg9XcJS8ZarLraVlrwp/bUrBqTHBSyR1B4My++w==
X-Received: by 2002:a67:e20c:0:b0:452:6320:60da with SMTP id g12-20020a67e20c000000b00452632060damr15436524vsa.22.1696936173638;
        Tue, 10 Oct 2023 04:09:33 -0700 (PDT)
Received: from primary ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id i15-20020a05620a074f00b0076c96e571f3sm4257613qki.26.2023.10.10.04.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:09:33 -0700 (PDT)
Date:   Tue, 10 Oct 2023 07:09:22 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v10 00/14] Add TPS25750 USB type-C PD controller support
Message-ID: <ZSUw4kDgzAIR/F3m@primary>
References: <20231003155842.57313-1-alkuor@gmail.com>
 <2023101017-custard-scale-470f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101017-custard-scale-470f@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:02:55AM +0200, Greg KH wrote:
> On Tue, Oct 03, 2023 at 11:58:33AM -0400, Abdel Alkuor wrote:
> > From: Abdel Alkuor <abdelalkuor@geotab.com>
>
Hi Greg,
> Note, your subject line says 00/14 yet your patches had 00/09.  I hope
> you didn't dropp patches somewhere?
>
Sorry, it is just a copy/paste error from v9 as v9 has 14 patches.
> I applied what is here now, but are some missing?
>
No, they are 9 patches in v10 as many patches from v9 got merged into
one patch. Should I upload another cover letter to fix the subject line?
> thanks,
> 
> greg k-h

Thanks,
Abdel
