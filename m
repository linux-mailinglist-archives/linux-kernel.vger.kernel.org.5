Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB587BBBD7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjJFPhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjJFPhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:37:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CA1A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:37:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32329d935d4so1985096f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696606622; x=1697211422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/urUhEVDb9b6U6nA5x5SbH6GwCmmMY65Q2l1I2ccds=;
        b=QOJ7NcYcFa0kNQgoR0RyonVx/ho0xtsyKOojeMspRc4xNhPP65tUpT9EItb/CCNeo4
         9l9U9R473s//cZKsj/GqGmcr00T91apif6cB9xiPzclZTnxcgZ6t/kmhK2X/N0y30bsS
         APj25lV6zpoQGx6wNBMt2c3n3K4HWYQoldM6BmTxMhtnMfIBSWTFJHxEfhFAsZfRrTwZ
         5Pbx12HNf9qV2YEIJgULV3q2RVX36tRzwKn9FFkpxsjXd9mILrue3RoRw9KJlavgHcKx
         zh0DwWrJMOj164ZONuRxUEv7JKC08gcnW7zcSoF8RSU3bKF4Js3do1zoRsmuh3iSlCzY
         v/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606622; x=1697211422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/urUhEVDb9b6U6nA5x5SbH6GwCmmMY65Q2l1I2ccds=;
        b=fiJQODj91HeW6g+4nhkkMs1W9Xl6S40V6HrjLfAkrXS3IpTeJCw3exis3uLlMoleNX
         HZx+PuugfHAZDwHgTgao0uPgWAmiav+mazE7GseMZlN8a+cO+xkVZtN5mXZaPdeqX0Ng
         isIsYnao+l2dYsk9ZBW4jmfo6NNCg4LWF/iV7Mf39EPgo2haBGrtWLX+ALTv0NfHlSmB
         p5OHVnZw+ZEjGVtTb9rn09UHAMHzXwhWfLLE2sv6yeMiWdbksNk0/WUe8OOUY/yd4pHi
         qU0d9htqImcHFpq1HKhfpKt6/FFHTaG1nucV0ux1q6FjVu2AJr7hp1TH38Be3lYycU2V
         VanA==
X-Gm-Message-State: AOJu0YxF2BxRK4i9OfuXkWAl8QxoEhiIkXBM+LJkqLehwP82uh2EfO8P
        Gc9kGgwORZjG9PCmWafrMdI1PA==
X-Google-Smtp-Source: AGHT+IFhUnnVEJUHmy1LCmhtDxaQkbgyka+3XLQF18Cyaq/blQPoPH0cdviXGeLDfUZ6BOOYmD2gUA==
X-Received: by 2002:a05:6000:12cd:b0:320:976:f942 with SMTP id l13-20020a05600012cd00b003200976f942mr7751664wrx.7.1696606621912;
        Fri, 06 Oct 2023 08:37:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c6-20020adfed86000000b003279518f51dsm1909859wro.2.2023.10.06.08.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 08:37:01 -0700 (PDT)
Date:   Fri, 6 Oct 2023 18:36:58 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ricardo Lopes <ricardoapl.dev@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, manishc@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, coiby.xu@gmail.com,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: Replace strncpy with strscpy
Message-ID: <9987d46a-ffbc-4a1c-bddf-084b17d14cf1@kadam.mountain>
References: <20231005191459.10698-1-ricardoapl.dev@gmail.com>
 <2023100657-purge-wasting-621c@gregkh>
 <ZSAoDYYqgoXXV4s_@babbage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSAoDYYqgoXXV4s_@babbage>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 04:30:21PM +0100, Ricardo Lopes wrote:
> On Fri, Oct 06, 2023 at 03:32:28PM +0200, Greg KH wrote:
> > On Thu, Oct 05, 2023 at 08:14:55PM +0100, Ricardo Lopes wrote:
> > > Avoid read overflows and other misbehavior due to missing termination.
> > 
> > As Dan said, this is not possible here.  Can you redo the changelog text
> > and resend it so that people aren't scared by the text?
> 
> Yes, I suppose removing that sentence and keeping the checkpatch.pl
> warning output would do?

Yes.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter

