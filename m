Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7527C670E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378051AbjJLHso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347183AbjJLHsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:48:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690ECBA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:48:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-692d2e8c003so1424138b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697096920; x=1697701720; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Hqr9DYS4ACIYnQ3en5nq0rV5Tc/FbTrcS4p8q2+2Uk=;
        b=io16c0mLadBJCI1zIQrDNFSmRLeQZLlDwxSeQ2AnG6qgqXfW80CyE4acwcGU4j1xOS
         JUMp1iK5KFNvnOmUYWkiEMlX/4yrTgPkzkS0UEaYjIXCMD3496yeCHdrh3FrNOtzoJXS
         E8fQt3cZMXjgizN5LwLdoi4tBuKnxW++UEKgdZBBwrBZdVCAxJ1iDDomLVaWA6aJNcEK
         9XEZGuyHELDYzXEcvkUmiSVWNhnUnBnfaCVITX3cxLHj5FysbuTR/aD32WrT1xqgqG6f
         BTHzDFpk2cvchryuoPyD358wMTmDXz2jnYyuObtONEA24/EglOizMcrzMwvZRbI6TQEg
         NadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697096920; x=1697701720;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Hqr9DYS4ACIYnQ3en5nq0rV5Tc/FbTrcS4p8q2+2Uk=;
        b=CbWRQg38uLpVQVnPnO3pNeIgWa0Jen94geDcRYyzeTzldv8oWgu3jOryij6UHua535
         Ll9yfSOkQIoYkETdY/N7oyZYoOtMMylJD4M+S3l8nqYJwyzE9xQeZ9aK3wrMzcJhEH9u
         AjRz2Lwqffy0rFfY4LJsEQ0UPK60vWeIL2BG15jBaxm23h0KauBpaZIVxVhl69ydSGGE
         FQCrf6n87Ms6NwG9IrbtVSnMxTN+nMsZSlDxxI+SQSg6WkoPzLifcu8QaLJHPPzLN3Ux
         gHsNuTzSustBNnu45jXY4Dm7A1w8w/ZUI64VYygh5yDYT5OCmfz5qMUErGpSW+gXwNt9
         tqsA==
X-Gm-Message-State: AOJu0YyKmPHkLNcijuoG1+r0LIBT8w8/EjO5JA5eivomsI7jEqSRKi8c
        jXnH7J2DUrSLTpJaWjQN/spMQQs6uXmi9g==
X-Google-Smtp-Source: AGHT+IEiuF9qWvd2+RjNGi35ydOY4c2AD2UYc/uZ57nUdQJEN+nHg2/NMuqRfHEXRYg8wA6okTSWfw==
X-Received: by 2002:a05:6a20:12ca:b0:159:c07d:66f0 with SMTP id v10-20020a056a2012ca00b00159c07d66f0mr32043518pzg.6.1697096919636;
        Thu, 12 Oct 2023 00:48:39 -0700 (PDT)
Received: from Negi (2603-8000-b93d-20a0-2184-6fa4-0d39-1c6b.res6.spectrum.com. [2603:8000:b93d:20a0:2184:6fa4:d39:1c6b])
        by smtp.gmail.com with ESMTPSA id z16-20020a656650000000b0058953648c27sm919443pgv.88.2023.10.12.00.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 00:48:39 -0700 (PDT)
Date:   Thu, 12 Oct 2023 00:48:38 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Micky Ching <micky_ching@realsil.com.cn>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Parenthesize macro arguments
Message-ID: <20231012074837.GE16374@Negi>
References: <20231012050240.20378-1-soumya.negi97@gmail.com>
 <81d6e283-fd87-4fd6-964f-22cbf420cdaa@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81d6e283-fd87-4fd6-964f-22cbf420cdaa@kadam.mountain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thu, Oct 12, 2023 at 09:33:07AM +0300, Dan Carpenter wrote:
> On Wed, Oct 11, 2023 at 10:02:40PM -0700, Soumya Negi wrote:
> > Use parenthesis with macro arguments to avoid possible precedence
...
> >   */
> >  #define rtsx_writel(chip, reg, value) \
> > -	iowrite32(value, (chip)->rtsx->remap_addr + reg)
> > +	iowrite32(value, (chip)->rtsx->remap_addr + (reg))
> 
> These would be better as functions instead of defines.

There are actually more macros in the code. Should all of
them be redefined as functions? The original code looks like this:

/*
 * macros for easy use
 */
#define rtsx_writel(chip, reg, value) \
	iowrite32(value, (chip)->rtsx->remap_addr + reg)
#define rtsx_readl(chip, reg) \
	ioread32((chip)->rtsx->remap_addr + reg)
#define rtsx_writew(chip, reg, value) \
	iowrite16(value, (chip)->rtsx->remap_addr + reg)
#define rtsx_readw(chip, reg) \
	ioread16((chip)->rtsx->remap_addr + reg)
#define rtsx_writeb(chip, reg, value) \
	iowrite8(value, (chip)->rtsx->remap_addr + reg)
#define rtsx_readb(chip, reg) \
	ioread8((chip)->rtsx->remap_addr + reg)

#define rtsx_read_config_byte(chip, where, val) \
	pci_read_config_byte((chip)->rtsx->pci, where, val)

#define rtsx_write_config_byte(chip, where, val) \
	pci_write_config_byte((chip)->rtsx->pci, where, val)

#define wait_timeout_x(task_state, msecs)	\
do {						\
	set_current_state((task_state));	\
	schedule_timeout((msecs) * HZ / 1000);	\
} while (0)
#define wait_timeout(msecs)	wait_timeout_x(TASK_INTERRUPTIBLE, (msecs))

> >  	pci_read_config_byte((chip)->rtsx->pci, where, val)
> > @@ -131,8 +131,8 @@ static inline struct rtsx_dev *host_to_rtsx(struct Scsi_Host *host)
> >   * The scsi_lock() and scsi_unlock() macros protect the sm_state and the
> >   * single queue element srb for write access
> >   */
> > -#define scsi_unlock(host)	spin_unlock_irq(host->host_lock)
> > -#define scsi_lock(host)		spin_lock_irq(host->host_lock)
> > +#define scsi_unlock(host)	spin_unlock_irq((host)->host_lock)
> > +#define scsi_lock(host)		spin_lock_irq((host)->host_lock)
> 
> For these ones, the name is too generic.  probably the right thing is
> to just get rid of them completely and call spin_lock/unlock_irq()
> directly.

I understand that there should be 2 different patches, one for the
macro-to-function rewrites & one for replacing the scsi lock/unlock macros with
direct spinlock calls. But, should these be in a patchset(they are vaguely
related since the patches together would get rid of the checkpatch warnings)?
I'm not sure.

Thanks,
Soumya

> regards,
> dan carpenter
> 
