Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663AB7D1D17
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 14:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjJUMOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 08:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjJUMOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 08:14:15 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F262D63;
        Sat, 21 Oct 2023 05:14:13 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso26950831fa.1;
        Sat, 21 Oct 2023 05:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697890451; x=1698495251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z1hgO9nuruEPiuqumF8sjkjB66g/Fe7TKQqbXRKwxJw=;
        b=dvL3NwNGYjKs/PKra5PB7r+puslo4QsFPYZIb73PxhTgROabM9oXLjbCF1rMbYWr6t
         v3DIABE9eiwG0MhL7GPBFxM0pZM6wFIzlNmTlDUh5aafZ5+Da3bg7YS1dqyf9giOQ1ns
         WF+l99EEKzGoY6uXoGY/UTWGpGfQC917pcHCcxRaCwMufkOb1ciDck+sudnEAbgjJLlS
         3YRrcqiIo6fOZTQKkigdwQWeb55x0vQnfSwDSeW9F77eCKM/4OvHygbF6+Deo+qrTId4
         R79gFeZRxtCGsWuX/LB8XRK6Gk5O/KzdOLAKVnJMpEcT92HNo6cL3VewYMkp4Mv8+9Ve
         z8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697890451; x=1698495251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1hgO9nuruEPiuqumF8sjkjB66g/Fe7TKQqbXRKwxJw=;
        b=gVPHuxrya/tRNDcyPtHmZ9coGDNkgHCU7+m8HQLDSiAXS4612zaRFzs913Ck73xcNU
         NtuSx8n8AA2im0OUQ0vPwxFEvEA3lo56xI4x3sZsekiBkGMyWku9DQ07SbTe0oSfl3jf
         THIYGehK65d8yzyOvnH1B36D1ANIgZnw5PogiKW4lUa7ETO4sOpfSGG4ATfNMjKZJPHD
         11WJceDEl+Fk9bMCOd9Moeb36myjKEWOXBDRB3GapzJfbITCa+VMfzKyj5wfg4vTEseG
         TwUcndTB0UQ+fakglAQ9l80BjpyJvjRwtStceEPtPARWpxhvin1flx7ZFYSs2c86ZOII
         ttuQ==
X-Gm-Message-State: AOJu0YwllvP+wR+HDdeDgzk7/m/h3FenvwKJeDUBUXtrkhUyTDWaMs7R
        Pqp0y5cTwcyF+GAsicKK+M0=
X-Google-Smtp-Source: AGHT+IHcaUBqaa9y/JY77Ly0qeRzu7cZNMMZA9tzpGfIS2zW6AE8M/fagm+xE+mBNmWtazC5eFoAsA==
X-Received: by 2002:a05:6512:2808:b0:507:aad2:96af with SMTP id cf8-20020a056512280800b00507aad296afmr3567348lfb.21.1697890451104;
        Sat, 21 Oct 2023 05:14:11 -0700 (PDT)
Received: from HP-ENVY-Notebook (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.gmail.com with ESMTPSA id s5-20020a197705000000b00504358a9423sm857780lfc.280.2023.10.21.05.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 05:14:10 -0700 (PDT)
Date:   Sat, 21 Oct 2023 14:14:08 +0200
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] staging: media: atomisp: Removed duplicate
 comment and fixed comment format
Message-ID: <ZTPAkFCIjgWNBY2u@HP-ENVY-Notebook>
References: <20231021110058.85013-1-bergh.jonathan@gmail.com>
 <acf1fade-7693-9332-03b1-626f4949f9ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acf1fade-7693-9332-03b1-626f4949f9ff@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 01:57:05PM +0200, Hans de Goede wrote:
> Hi Jonathan,
> 
> On 10/21/23 13:00, Jonathan Bergh wrote:
> > Fixed the following issues:
> >  * Removed a duplicate comment
> >  * Fixed up minor comment format issue
> > 
> > Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>

Hi Hans, thanks for the msg. 

> 
> Thank you for your patch, but please don't resend
> it every week.

Apologies. I dont remember when i sent the original but I was cleaning 
up today and thought i would resend it. (I dont recall resending prior to 
today (?) but if so, apologies). 
 
> I did see the original patch and it looks fine but
> I have not had any time to work in atomisp support
> recently and this does not seem like something
> which needs to get merged urgently.
> 
> I'll pick this up next time I have time to do
> a bunch of atomisp work.

Yes, for sure, it was just a small thing.
Thanks Hans
br
Jonathan
