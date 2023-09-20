Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5447A71BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjITFA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITFAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:00:53 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6A395
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:00:48 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-565e54cb93aso3778402a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695186047; x=1695790847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R1RaaAojR4q7FCgZtVcWHvcAV0ec+aUWfHX+ZrBpzu8=;
        b=MRjRKss4imNtiI5laH5iUWEC7J34fMcVCrQ97tLVs1HlxCEuPp02dA8bYSFuQgqQDl
         BmFh/3ZoTchZ3isOixbbNkoIdnlrEJsP+v11Yl5xlRwf+yz6hGaxb9oHOr2uDPYx53C6
         AREP8luqt1zSJ4wa+M8f4MJr+3XYphW28w0FQKxPmUGASnUPfDPDRdoTX1qS2DqV0MuX
         BOwBS/WFpB7ZGYYOenvH0SDv/cI40HxJ9WsT+EkXqRjs+BU0EMogSsnQT2P9YSJNNJ7z
         GJSMDJSXplTDkVKGvftGPoF0LVThbNdOd7A18rgc+3ZvBf0D6IoO1s7LEEom/r0zcrnQ
         CHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695186047; x=1695790847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1RaaAojR4q7FCgZtVcWHvcAV0ec+aUWfHX+ZrBpzu8=;
        b=xCWseEzbMfJwYaEDNlSYo5CwDVfJ79E+3cPFyI5TnFHb/K1cEQHH1CasOPsHoRmft2
         9faKz9QbavFUwsM3LSsIcb+HJx7/qXz4WyA5tdUTzThXmGy8S+iB1Z09xKP6Pjibfll3
         pLCp9/Jnh3SyAVPOzQvVJF7HC1nPWywaLMmRheRDihk1Pbm8D2FmOwj1EjivE20ZhqbZ
         ptJv02al4V+RolY5AkDGkWpwSWXfeQmxERT1A7gKl4cyQEy++Cpjqj+T7GS7vBKaGUmV
         5JEJnB39QSaXX6nnortmYNUjh4SECjQgLbnTb3L511ZiEnk86hf8xKQrk4ckBnQX4pMJ
         /j3g==
X-Gm-Message-State: AOJu0YzXvwWRsLizNBIDJ7UTfWAqQUIerv8wvwM4KUbDkVa4xyVJ+yuO
        z4VqIqXtW0Zus1nYc8oqZybTncrCi9SoziXnrxE=
X-Google-Smtp-Source: AGHT+IGY27ppvSFjm8SPutNys0rT8KblVX6qGjRDOYicgz7TxrRMAo1Fa5l/p9FZUXB1KYNG8OCvWozmL6yLj2kUShk=
X-Received: by 2002:a17:90b:3847:b0:276:7683:70f6 with SMTP id
 nl7-20020a17090b384700b00276768370f6mr1545464pjb.33.1695186047388; Tue, 19
 Sep 2023 22:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230919081958.7071-1-qiang.zhang1211@gmail.com>
 <ZQndj34e9lOpA8Fm@slm.duckdns.org> <ZQnd9CVWecNqHo5V@slm.duckdns.org>
In-Reply-To: <ZQnd9CVWecNqHo5V@slm.duckdns.org>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Wed, 20 Sep 2023 13:00:35 +0800
Message-ID: <CALm+0cWVTk9fJpvurej-k71mS640GorwkWfwgVdRpeikd9VUDw@mail.gmail.com>
Subject: Re: [PATCH v2] workqueue: Fix UAF report by KASAN in pwq_release_workfn()
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Tue, Sep 19, 2023 at 07:42:39AM -1000, Tejun Heo wrote:
> > Hello,
> >
> > The patch looks fine but
> >
> > On Tue, Sep 19, 2023 at 04:19:58PM +0800, Zqiang wrote:
> > > @@ -4743,6 +4743,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
> > >     wq_free_lockdep(wq);
> > >  err_free_wq:
> > >     free_workqueue_attrs(wq->unbound_attrs);
> >
> > Can you please add a comment here explaining why the flushing is necessary?
> >
> > > +   if (wq->flags & WQ_UNBOUND)
> > > +           kthread_flush_worker(pwq_release_worker);
>
> Hmm... also, wouldn't it be clearer to flush from alloc_and_link_pwqs()
> right after apply_workqueue_attrs() failed? That's the only case that
> requires flushing, right?
>

Yes, thanks,  I will resend :)

Thanks
Zqiang

>
> Thanks.
>
> --
> tejun
