Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C977A69D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjISRpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjISRpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:45:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4C91992
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:44:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so53399665ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695145462; x=1695750262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39nxaARrJPKXc7c+HVzwmiFbsNI+9PCepSFQctx9iVk=;
        b=fDRUogaMPNG/xyRc4PE3ESxFUqTKSB24F8iDQUk1KSc7ypf+KKRM4z7riH1EcrX4LF
         viMsL58hvSm9ohE9x92amPRfGl2FLamNzqTFBQZUflr0n5C/mZUNnuNR/7ys2FqlPMEB
         3JePIQHqtkhpbW+qJ261Hf2COoJTsIitnZkSFb7grhizijdPzsxaBGRpjhfAfdPlkDs8
         wDtnVAiVriyX11ss+KBnBQJfaMw4AvYXVNIySS28jzhT8tmT0+FWZw/tlxC7PVjNCCSA
         AHDBxWtA7J5Pn/mmmnCMEA18MUqDsrCNIu+FVYqDiTjV0FhOpFhipOItbVaYr0UnhpKr
         AR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695145462; x=1695750262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39nxaARrJPKXc7c+HVzwmiFbsNI+9PCepSFQctx9iVk=;
        b=VxoA16VCsYfKMTPW224IueSXHqpmcbo0H7lFxprctwYu3bfMLX+uXJP7haYQZvwIwy
         NSG0pRIf34/37xU1F66v2ssCSEiS6FtnjKQ3DuuEFMgJsHCOzaLVlTau2LvaUf4H9iDK
         aNNihb81lR2egebjYuTAD/ZasEqU8Hh/sCpy/5RO0vTJR6GgtorXk/N2ikBuX8DCueMQ
         t0OBZ0Im+TripYsX/mZnYiazdorQnWr3LQaQO2qeRBOLrQ+U4lS1sj9dPsUvFPH4vNtN
         2gZQtjQGbjo/zOEp4y8djSk6TnbQKxoouDoIqd8th3adfnHlyRvqvxOtiZt6kqkY6k5b
         g8Ng==
X-Gm-Message-State: AOJu0Yw/v00n7uKFqFpxSm/jGIwo0RUFaY/Q2apt8jug1X7/o3WISkUI
        U6HUJ49/WsHyTUUXb5HCpgWOjDe7982Dmg==
X-Google-Smtp-Source: AGHT+IEcuqkwqp12ee9tz6d9VYm0+9Zh4Q5t8acHgjkmMiVfN9ZeT/Qk+/9mdSXY/GXEg+uFWHlL2A==
X-Received: by 2002:a17:902:c950:b0:1c5:64e1:ddd8 with SMTP id i16-20020a170902c95000b001c564e1ddd8mr149627pla.48.1695145461596;
        Tue, 19 Sep 2023 10:44:21 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001ab2b4105ddsm10238998plg.60.2023.09.19.10.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:44:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Sep 2023 07:44:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     jiangshanlai@gmail.com, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: Fix UAF report by KASAN in
 pwq_release_workfn()
Message-ID: <ZQnd9CVWecNqHo5V@slm.duckdns.org>
References: <20230919081958.7071-1-qiang.zhang1211@gmail.com>
 <ZQndj34e9lOpA8Fm@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQndj34e9lOpA8Fm@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 07:42:39AM -1000, Tejun Heo wrote:
> Hello,
> 
> The patch looks fine but
> 
> On Tue, Sep 19, 2023 at 04:19:58PM +0800, Zqiang wrote:
> > @@ -4743,6 +4743,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
> >  	wq_free_lockdep(wq);
> >  err_free_wq:
> >  	free_workqueue_attrs(wq->unbound_attrs);
> 
> Can you please add a comment here explaining why the flushing is necessary?
> 
> > +	if (wq->flags & WQ_UNBOUND)
> > +		kthread_flush_worker(pwq_release_worker);

Hmm... also, wouldn't it be clearer to flush from alloc_and_link_pwqs()
right after apply_workqueue_attrs() failed? That's the only case that
requires flushing, right?

Thanks.

-- 
tejun
