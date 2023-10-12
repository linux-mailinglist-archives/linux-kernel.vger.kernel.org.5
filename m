Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D2A7C6E73
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378247AbjJLMtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343872AbjJLMtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:49:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF8B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:49:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9b7c234a7so8037165ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697114961; x=1697719761; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9R2WJP31ISTqDLxCcJ16Ck5qYaEM4fVytKo7WW22eI=;
        b=eobQCB5jk0WaCKYFCy1jZ4BxHnzyIDzuqblDXHrhya22GhQDgTOmm2WSCbBj2UsCrZ
         1gr/2ZXi/13eLTfs5rWmgh7NANbIy8A/Y708zMm+EZds7YesZkYyue66Sew0L3Tk/aqx
         c3WS0sorhhWemayS7MRPDBE+FwdRm4BEdpWkRYH6mkOF5ASeA9R+9xgwXljX8uXhRAL6
         ex3oqdHunirBZiLoCX+2bgyGJbWysX/cCskoo8WUYuk6RUy63XOe9seNx3SGnZqLQOAS
         sMdOHYxlbC1823Luj0FdYaveiq+CxSaDKCLUu+S2J36FXrZDF3nozAYwWZ0H/FSIV+2F
         TS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697114961; x=1697719761;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9R2WJP31ISTqDLxCcJ16Ck5qYaEM4fVytKo7WW22eI=;
        b=jE3lUrJuhvF4oOofuJc5t0PcGrOIf7adIhE2gJ9DAp2z0dZdhcB6F2O/2P0u+VFP2c
         /Dl1+8AWwBHQSHrYL+kg/mH8KSgLVtq/fZmdencP9J5aBeP8z0J/iMQBnDr/uVTXJHhs
         X4rjzY+SeUEweLvssmY7cOLJudG/zKXq7leWGdiJZnmw5G0GmTjNu+2Wz0AfpJgHRe1E
         f48T3VqPCfxe/Oh+SZUC2eALoMzNLSVpubP817TORWADHRFybXDwFw4uqQ/hanJeMQDr
         OcOMpjUESQwgzrV11QsHmREFh5MevMX4+/O6BssfcRWw+44foSMwUdZTnTkueQydHmiN
         uXQA==
X-Gm-Message-State: AOJu0Yxc6Gaiz3cC/gnnWhx3DSVCOgxBsSvAUcK0a7a5hRE5m+59DMPA
        DV0b8n6aw+4xb/lWLkTnw70qlMExIHxBfQ==
X-Google-Smtp-Source: AGHT+IFEm+hMKsOAOa2EjnTE6qHjENie8LhryEdIP9/VCzj9DNg0KR02ncxD8PJ2t1rHXSL3IuurVA==
X-Received: by 2002:a17:902:e54a:b0:1c6:2dbb:e5fa with SMTP id n10-20020a170902e54a00b001c62dbbe5famr30705556plf.44.1697114961599;
        Thu, 12 Oct 2023 05:49:21 -0700 (PDT)
Received: from Negi (2603-8000-b93d-20a0-2184-6fa4-0d39-1c6b.res6.spectrum.com. [2603:8000:b93d:20a0:2184:6fa4:d39:1c6b])
        by smtp.gmail.com with ESMTPSA id ij6-20020a170902ab4600b001c0c79b386esm1925771plb.95.2023.10.12.05.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 05:49:21 -0700 (PDT)
Date:   Thu, 12 Oct 2023 05:49:20 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Micky Ching <micky_ching@realsil.com.cn>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Parenthesize macro arguments
Message-ID: <20231012124920.GA7107@Negi>
References: <20231012050240.20378-1-soumya.negi97@gmail.com>
 <81d6e283-fd87-4fd6-964f-22cbf420cdaa@kadam.mountain>
 <20231012074837.GE16374@Negi>
 <a1556f74-83ef-d32-103d-6b0b0233473@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1556f74-83ef-d32-103d-6b0b0233473@inria.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

On Thu, Oct 12, 2023 at 09:51:27AM +0200, Julia Lawall wrote:
> 
> 
> On Thu, 12 Oct 2023, Soumya Negi wrote:
> 
> > Hi Dan,
> > > For these ones, the name is too generic.  probably the right thing is
> > > to just get rid of them completely and call spin_lock/unlock_irq()
> > > directly.
> >
> > I understand that there should be 2 different patches, one for the
> > macro-to-function rewrites & one for replacing the scsi lock/unlock macros with
> > direct spinlock calls. But, should these be in a patchset(they are vaguely
> > related since the patches together would get rid of the checkpatch warnings)?
> > I'm not sure.
> 
> Patch set, since they affect the same file.  Otherwise, Greg doesn't know
> in what order to apply them.

Thank you for explaining each point. I'm sending over the patch set for
review in a new email thread.

- Soumya

> julia
