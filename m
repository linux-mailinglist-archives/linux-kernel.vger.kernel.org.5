Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0295877C252
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjHNVUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjHNVT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D7D1720
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692047937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vLYjJnIRIAUyriMJxKfff//gose6O9+YEAXEmSpK93M=;
        b=aN3YUnN6lMhYoV4FR56QDifA+Pf+Z3zCbBWi2leWvHxLuwSKnpKUiGEiYGSFEGUr5pjJQy
        yGleuEnzpFwvDFg/7T1MMtCJudtK/J07U0sK9BX1boAwdTZNP3jZGs4as/NBuxrys1GeYv
        Y1RYgUxe+BvZPvooz5iwBI3Zl1VPKHA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-ngWlcAcOOyqP3CXG4szX1A-1; Mon, 14 Aug 2023 17:18:50 -0400
X-MC-Unique: ngWlcAcOOyqP3CXG4szX1A-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-586a5ac5c29so63809607b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692047930; x=1692652730;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLYjJnIRIAUyriMJxKfff//gose6O9+YEAXEmSpK93M=;
        b=iFCZQtAcINEyyoQsk4+fD98q/+oj9Ya2To1kTU2xi4JslSvdb+zvFqsSus320dordt
         QZ7f23sGh/KQzFDQx0gh6JOsY6/yR4ey/Ca8r7p+MICRReWNLUpbteh/s60mmQ/tcSgw
         RErrJSq57Fh3IQ/EgHr3prsGsfxpxD3tM5UMcCNXfgqe4T/SGwzFHHubdnN/sTouB2vP
         LO/EdbLbVQwfAe/b6JtGARqRBKJ7wbpDesEBz/C1FM3c3m9JMrHvARgh9euypi01fl9k
         YluhT8jnFA8ji7PDQycx4tULLIbbFT1Fh9LPvL5XdXDFC3tPn9NV1o8uSbZNAHjJ33Zk
         gA/g==
X-Gm-Message-State: AOJu0YwwXX/0JSQgoOGltlA9NQa01k/rSJlGu+E3en3ey0YdjFr5ueLE
        AcCSvO1bkX/5KjXI8rVVoYp+QnsIt578XuwmuBcpeunUheGSRLphtYfghO0+vH0OzLPHwPL+zxc
        uWl7xxmrN6GLovLJtpix3UBvn
X-Received: by 2002:a81:c30a:0:b0:577:1a4e:51f with SMTP id r10-20020a81c30a000000b005771a4e051fmr10676439ywk.39.1692047930156;
        Mon, 14 Aug 2023 14:18:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO+bDMZUZsF60J7boyFJj8Dmlloyous2h7m+z4zdyZrHWM3pIEvs8ji7OnOXAo43dEgw56pw==
X-Received: by 2002:a81:c30a:0:b0:577:1a4e:51f with SMTP id r10-20020a81c30a000000b005771a4e051fmr10676428ywk.39.1692047929907;
        Mon, 14 Aug 2023 14:18:49 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id z20-20020a81a254000000b00583b5564c1dsm2990707ywg.135.2023.08.14.14.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 14:18:49 -0700 (PDT)
Date:   Mon, 14 Aug 2023 17:18:47 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hugo@hugovil.com, quic_nguyenb@quicinc.com
Subject: Re: [PATCH v3 1/2] scsi: ufs: core: convert to dev_err_probe() in
 hba_init
Message-ID: <ZNqaN5+Ft5PAE43x@brian-x1>
References: <20230814184352.200531-1-bmasney@redhat.com>
 <20230814184352.200531-2-bmasney@redhat.com>
 <f01040be-dfa5-fe60-fba5-410fccc1d50e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f01040be-dfa5-fe60-fba5-410fccc1d50e@acm.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 12:31:31PM -0700, Bart Van Assche wrote:
> On 8/14/23 11:43, Brian Masney wrote:
> > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> > index 129446775796..409d176542e1 100644
> > --- a/drivers/ufs/core/ufshcd.c
> > +++ b/drivers/ufs/core/ufshcd.c
> > @@ -9235,8 +9235,9 @@ static int ufshcd_variant_hba_init(struct ufs_hba *hba)
> >   	err = ufshcd_vops_init(hba);
> >   	if (err)
> > -		dev_err(hba->dev, "%s: variant %s init failed err %d\n",
> > -			__func__, ufshcd_get_var_name(hba), err);
> > +		dev_err_probe(hba->dev, err,
> > +			      "%s: variant %s init failed err %d\n",
> > +			      __func__, ufshcd_get_var_name(hba), err);
> >   out:
> >   	return err;
> >   }
> 
> This opportunity could have been used to improve the grammar of the reported
> error message. Anyway:

That's what I originally did in v1, however I was asked to split out the
cleanup into a different patch. Split out, I think the cleanup on it's
own isn't worth it's own patch, so that's why I dropped it.

https://lore.kernel.org/lkml/20230808142650.1713432-2-bmasney@redhat.com/

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks!

Brian

