Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3021A7A5196
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjIRSGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIRSG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:06:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A612B102
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:06:23 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2764b04dc5cso671365a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695060383; x=1695665183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kh8r+G9HDwPFrsGLZh4L+phZy5FZ1r48b60Noorm0yg=;
        b=Y2CWCpcCDChSlnLmVmkAjyahrqM80EkS1QsK0ePor5I7PmiDh0NjCeQJM/D5nj9s9z
         R6Hwnsra7sG5hHFyTAPBWMYDdZID8EZVXPdXK2KRzVDKK1PnzGjsMtg8v+B1svASo0Iy
         NHRRwW5WsLT7KChYYZSKflSpR1rsYH5eBjyv/SMqT+WVTQbXx2/Ek0KC1oPjUR2LcpwK
         Q96Ql4B9LXtB/Kn2C0y0r4u13S8h3Ebqy/P2AIPmLyMgFooc10F3jMeph8SWGNZ6F61k
         4H7TrcxNg2JiemelzuPj/OmhbSR4qTPDksgohhQqPYfQvswSrkOB8jysZzwz86NFbs5v
         ZYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060383; x=1695665183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kh8r+G9HDwPFrsGLZh4L+phZy5FZ1r48b60Noorm0yg=;
        b=QyRu28aL8Ebs1Au9pBJvBh4CPI6/sU1kL+DFzJeqvUww5H8X6ajZ1qYH1wFOmTpkwi
         h62myyvs+mNEQc3NpSD4OkHyg1eY9vksbbgWkWwDfo+DsWb9dGpIual2AKaatWcHSkE2
         Gt3TDk0fEqs999BD0ZdiZU3J96RessAMkGME3pkN6GwduN2r9LffjXA47Aj52QzlTa7A
         1cbp+WTsG3OKoTDezbnmehK8V0GsUmwn6OAhlVGbrDpdscQg9bb5dOachD4YyuRsrUcI
         2wNA4NZ5psJTtRhP73n98xEwq6Eqpn+Zi4+xfEUO5QhAgJ3r5iGSrywR733SsaaWqxcv
         1qUQ==
X-Gm-Message-State: AOJu0YwcbCaSsfDhiKEoEaMQ+vFF6689HMgWeV21Ssm4E6Q85Wm72gYG
        91zwKr7JnWdyls4zuOIfN+2ZFNxabh3Xgw==
X-Google-Smtp-Source: AGHT+IEoGvN10Bawma6jEwf7DYBsm16mrQqdevFUHrOentl6AVue3vvX1zgllRETeIj3kJb16YtUwg==
X-Received: by 2002:a17:90b:1887:b0:274:566a:3477 with SMTP id mn7-20020a17090b188700b00274566a3477mr7051984pjb.39.1695060382758;
        Mon, 18 Sep 2023 11:06:22 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id ie18-20020a17090b401200b0026971450601sm7422233pjb.7.2023.09.18.11.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:06:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 18 Sep 2023 08:06:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Fix UAF report by KASAN in
 pwq_release_workfn()
Message-ID: <ZQiRncEYCK3RYXA7@slm.duckdns.org>
References: <20230902115026.13460-1-qiang.zhang1211@gmail.com>
 <ZPd4yKqbvBNGV7cL@slm.duckdns.org>
 <CALm+0cVf+E_Y41AdEwLjm2gZAjzeKaZev1Tu1hUS-VpYH0eEHQ@mail.gmail.com>
 <ZPiwaaZaDPVexezn@slm.duckdns.org>
 <CALm+0cUytR3-0mcW3t24gcyP27UW3rpP5_+vpLVC3w70+0n6oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cUytR3-0mcW3t24gcyP27UW3rpP5_+vpLVC3w70+0n6oQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 10:13:23AM +0800, Z qiang wrote:
> >
> > On Wed, Sep 06, 2023 at 10:12:34AM +0800, Z qiang wrote:
> > > Flush the pwq_release_worker is insufficient, the call_rcu() is
> > > invoked to release wq
> > > in pwq_release_workfn(), this is also asynchronous.
> >
> > But rcu_free_pwq() doesn't access wq or anything. The last access is from
> > the work function.
> 
> The rcu_free_wq() will access wq->cpu_pwq or unbound_attrs,
> but  at this time, the kfree(wq) may have been called in alloc_workqueue().

I'm not following. The only way alloc_and_link fails is if
apply_wqattrs_prepare() fails and if prepare fails, none of the pwq's are
installed and pwq_unbound_release_workfn() won't try to free the wq as the
pwq's don't have any reference on it. So, if you flush the pwq release work
items, there can be no rcu_free_wq() in flight. Can you please try to see
whether the problem is reproducible with flushing?

Thanks.

-- 
tejun
