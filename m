Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C8A7D46FB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 07:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjJXFkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 01:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjJXFkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 01:40:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73BE12B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 22:40:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40906fc54fdso9827205e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 22:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698126013; x=1698730813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8S1Ffd5MfC34d7i9U6ZkEMWBIBXhcbh4VSbMEWH6zt0=;
        b=YGjT/eJpUuJ6WzGSIqkVI/xe+u53gbpKkz4k0T3y5bfbFT+QWEBSgu/6lZ7QcrogK9
         enAc4DKLtCkMP7miwVpiSFS/4qfSk+Lai/sq7YBHLS+jQuQfMI6m6EIvdqAp74FeNZx4
         73RsvQaGNsdaYeKolCCNDxBNPvV7EiQ2KlbvhC4FwjGxWpnzPWI6ekBrexuypM610Efc
         uRqjb6Ty5qPLu9cNMVqxTvokbb4U0VXLtEc2edzy/MEZ0bH/zLwC4RYv/t3XRneymEvK
         9oqmuHSiRNntetPsTpQZMAvuBwflPJelCiARUdqBFAclbO9dDdTA3/iqqz8ZSJ2W0SKJ
         x4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698126013; x=1698730813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8S1Ffd5MfC34d7i9U6ZkEMWBIBXhcbh4VSbMEWH6zt0=;
        b=bqwAHGaPKBNWH56Pt7GPxPOJL7hORq++5hmIeSCLX3+liUPfBifLe9LNCtSrKKd5zY
         l+mamJabCDbGZ9LywJBXJ80+K/e7UGM6W+dzFvfjkGdAasBjQW+hSR9vBWD58s/yAgkK
         jZv9rdmBKBSKFWVKqw4bkfkH7lPSKEsH15vN1f/M6hV1bRZ+evwOZqpdrGQe90byb04q
         LL3YUPJ+mkOsQJk9oXwDWyrXXOrdekSpTwXTZi8j9FXQ0kpMMCgxKo7jZwdiC1FjDS1a
         xvWrCrymnefCUdqVn5qi53vUKbBCiupKCh+sU8xBF17BH1AfTDQrU4VezLjOEs4IIZbL
         0fOg==
X-Gm-Message-State: AOJu0YykvN7f158JapvP78W/7vcEIddp2Q7GVMkEFAWRfrrBzjVZd/rb
        CNceXYWxm34wxg4/1P49Vu8gDW+owiszQIlw/ZQ=
X-Google-Smtp-Source: AGHT+IHA5z2yygwPWwubIy2EilUpoOxRuMgdblCJ+l4dDMrjVLH40V93ZeffBsu1a9aDfRAGV4+rFQ==
X-Received: by 2002:a05:600c:4444:b0:408:4120:bab7 with SMTP id v4-20020a05600c444400b004084120bab7mr8378115wmn.15.1698126013032;
        Mon, 23 Oct 2023 22:40:13 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c418c00b0040773c69fc0sm15515633wmh.11.2023.10.23.22.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 22:40:12 -0700 (PDT)
Date:   Tue, 24 Oct 2023 08:40:09 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     keescook@chromium.org, Robert Richter <rric@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/thunderx: Fix some potential buffer overflow in
 thunderx_ocx_com_threaded_isr()
Message-ID: <ea7ff4e8-c21c-4847-8fcd-7a038782872c@kadam.mountain>
References: <91ec35cd8e2e86fa3d24c2e8ea6970e0437cdfd2.1697908406.git.christophe.jaillet@wanadoo.fr>
 <70bd7480-508a-451d-bc0a-f78e652cf511@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70bd7480-508a-451d-bc0a-f78e652cf511@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 08:35:33AM +0300, Dan Carpenter wrote:
> On Sat, Oct 21, 2023 at 07:13:51PM +0200, Christophe JAILLET wrote:
> > @@ -1127,27 +1128,26 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
> >  				ARRAY_SIZE(ocx->com_err_ctx));
> >  		ctx = &ocx->com_err_ctx[tail];
> >  
> > -		snprintf(msg, OCX_MESSAGE_SIZE, "%s: OCX_COM_INT: %016llx",
> > -			ocx->edac_dev->ctl_name, ctx->reg_com_int);
> > -
> >  		decode_register(other, OCX_OTHER_SIZE,
> >  				ocx_com_errors, ctx->reg_com_int);
> >  
> > -		strncat(msg, other, OCX_MESSAGE_SIZE);
> > +		remaining = OCX_MESSAGE_SIZE;
> > +		remaining -= scnprintf(msg, remaining, "%s: OCX_COM_INT: %016llx%s",
> > +				       ocx->edac_dev->ctl_name, ctx->reg_com_int,
> > +				       other);
> >  
> >  		for (lane = 0; lane < OCX_RX_LANES; lane++)
> >  			if (ctx->reg_com_int & BIT(lane)) {
> > -				snprintf(other, OCX_OTHER_SIZE,
> > -					 "\n\tOCX_LNE_INT[%02d]: %016llx OCX_LNE_STAT11[%02d]: %016llx",
> > -					 lane, ctx->reg_lane_int[lane],
> > -					 lane, ctx->reg_lane_stat11[lane]);
> > -
> > -				strncat(msg, other, OCX_MESSAGE_SIZE);
> > -
> >  				decode_register(other, OCX_OTHER_SIZE,
> >  						ocx_lane_errors,
> >  						ctx->reg_lane_int[lane]);
> > -				strncat(msg, other, OCX_MESSAGE_SIZE);
> > +
> > +				remaining -= scnprintf(msg + (OCX_MESSAGE_SIZE - remaining),
> > +						       remaining,
> 
> Instead of doing "remaining -=" the canonincal way is "off +=".  Then
> the snprintf() becomes:
> 
> 	off += scnprintf(msg + off, OCX_MESSAGE_SIZE - off, ""\n\tOCX_...
> 
> Your way works but it makes my head hurt.

Sorry, I shouldn't have sent this email.  You're allowed to write it
however you want if you're fixing the bug.

regards,
dan carpenter

