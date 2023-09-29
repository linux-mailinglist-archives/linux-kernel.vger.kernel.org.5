Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B1E7B3BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjI2VJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjI2VJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:09:30 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDF21AA;
        Fri, 29 Sep 2023 14:09:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so15659717a12.1;
        Fri, 29 Sep 2023 14:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696021767; x=1696626567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqoIBZyAN7TBEZJLQFayBoAOsZMAKH9U9FTGnZleqPE=;
        b=IIlBHq2K517AxVmLCLdFlEgha1pKhWkDvIuM++McKUTgkIlNRDIDc40zIWKkydfRKu
         jc8VxG7dj6++mbnS3+we8VUCrHDy4vdGuUWQz8k2ASRSulRRg/DbBkTKbYmMVHIa9chV
         blEO9q/iTuV4eUlXgP5pPvZbIjLKkcE9BP+GSutgSjqFIWRAtG9v1KGerjI1TqsLXJRS
         P2edSWYyf492FaJB0kRw8DZKxLe86QGEe9VMYZQp2E+ayy09KavLuYuLJkOGJK4LUiUD
         SxQTG7vJDqt+kBmfAZGscw6eK2lrnuVF+YwioKQcn5zibUcql5ZfEy+Ogtxe7i50ZOD8
         auHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696021767; x=1696626567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqoIBZyAN7TBEZJLQFayBoAOsZMAKH9U9FTGnZleqPE=;
        b=iEQ7YM/KqpgbC2MUKmIwbTGv6RYE583XwGCiocoqEAt4m9wCfxboNPGC4VN2aI1egw
         HtT7FbplIRvxxPJZGPA/ZBrbPSy/ulMLbAl2m9YTfADpwoXzfeISzuL7Bk+hApLrHTb/
         8AzrmKCvARZ7LwH8SCI7XH3kw+3tFjuETOpip1/J2RSd2+qaZPpOhlc2Muny3Vnavtkp
         l3LRAqSRnKikos8rG2PVJYrBWooKdyiPZt9CJRFe+iAUMGca7hucgJuIQJ45FzlCKATN
         fS0kl9eClg6waE5C1o4dP5TlFnZdIuHpf9FIkVsz1sT1owqNqz2du2BHcRcWT7wx0VwM
         oOZQ==
X-Gm-Message-State: AOJu0Yz/J9D0h/0wyjV8lvumJOxvUVKaHIyK04bFBmV5aSEgjiQkvZEO
        Yoa0UldxyxdxefzhejzVeRs=
X-Google-Smtp-Source: AGHT+IEcR7/xMijwPzbfrmUUl6AqChB8btSk7XLqcPKkLXsFplhdPxeQQWU58syINXOnhri2qmcnRg==
X-Received: by 2002:a17:906:518e:b0:9a9:e943:b601 with SMTP id y14-20020a170906518e00b009a9e943b601mr5186010ejk.46.1696021767072;
        Fri, 29 Sep 2023 14:09:27 -0700 (PDT)
Received: from gmail.com (84-236-113-123.pool.digikabel.hu. [84.236.113.123])
        by smtp.gmail.com with ESMTPSA id r26-20020a17090638da00b009ae3d711fd9sm12926960ejd.69.2023.09.29.14.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 14:09:26 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 29 Sep 2023 23:09:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] tick/nohz: Update comments some more
Message-ID: <ZRc9BN+Mv3HnN9GL@gmail.com>
References: <20230912104406.312185-3-frederic@kernel.org>
 <169582689118.27769.11953848930688373230.tip-bot2@tip-bot2>
 <ZRVCNeMcSQcXS36N@gmail.com>
 <ZRatsTz1mQRFJ0sW@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRatsTz1mQRFJ0sW@lothringen>
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederic Weisbecker <frederic@kernel.org> wrote:

> On Thu, Sep 28, 2023 at 11:07:01AM +0200, Ingo Molnar wrote:
> > > + * infrastructure actually relies on the tick itself as a backend in
> > > + * low-resolution mode (see hrtimer_run_queues()).
> > > + *
> > > + * This low-resolution handler still makes use of some hrtimer APIs meanwhile
> > > + * for commodity with expiration calculation and forwarding.
> > 
> > commodity?
> 
> I meant 'convenience', my usual frenglish issues...

'Convenience' it is. :-)

> Looks good, thanks!

Thanks, I've applied the patch to tip:timers/core, with your Acked-by added.

	Ingo
