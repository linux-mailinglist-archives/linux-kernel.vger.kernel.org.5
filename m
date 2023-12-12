Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750EB80E84F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjLLJ4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346095AbjLLJ4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:56:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A571A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702374968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l0x7ummZKoQ2iIdFhvwfnQrolsKlXVwo33HTSumY6yA=;
        b=EeV7Q2ylUw57f2Az29+n70rkPb+Xw8XsZqXmeMY8gESU6neTZihyM9ank9FvLeSe3ATWT2
        so10W7Tj42IP6EPzxO2kCTBR4+9pD3iaKmCnjaQvrVqD0JA/jgQWk/SPTyzSXQgqVed1oD
        p1tZFaa34xiGEOqC4RkGwleo5ZLdHbY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-3hb6mdX0NG-FfROuNqQppw-1; Tue, 12 Dec 2023 04:56:07 -0500
X-MC-Unique: 3hb6mdX0NG-FfROuNqQppw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-42577ba9d93so73931611cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374967; x=1702979767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0x7ummZKoQ2iIdFhvwfnQrolsKlXVwo33HTSumY6yA=;
        b=ZLC1oXAgdT55jyhhMTljH43vtebFlD8t+R5lANvuNQhVpshq8enRy6lNU3eOCK/Q8C
         MchOmzguZ8GGMIkLVm/x2NcHa5rFKXFRdvZ9QK7uJCHBNPUAJP8tZ3VhDe65nsMpko5i
         UHhI9uQZLyd6+VdpFI5117Li9vNb70R+04b6sNchOTMN+WFPaahC24ngfTYJifkzXSgb
         ALfjL9zJnDNHdRLTBUOK436Dedw2QFgs8iTcMZE/4x9gqBZyF/J4G7JOKJyNFRyFN3k9
         sCUKiSiW4XNBHlsqghSXH6blFGYdTorTEp/sc7IwHhfgT6plXEN0Ow4dtU1jqDmr1O3e
         d9sA==
X-Gm-Message-State: AOJu0YzBSLGHRh1uAnbk7/NFKNjcywKx6+sdiesLpUCoGQKkRoH+QcYx
        XIfDQL1UZ3YLi3kfgd7p31Tv2/ywf1ZosL1bgwmyWikgUo/c1Hd1Ic9GZVVv7iAHn1BpNN5S1eT
        wGDYiSo8iuvPRjVGyCJJTXeoj
X-Received: by 2002:a05:622a:1792:b0:425:4043:1d8c with SMTP id s18-20020a05622a179200b0042540431d8cmr7840992qtk.95.1702374966936;
        Tue, 12 Dec 2023 01:56:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHha4U+TUeRnVcUfwlX3+DBO3YZV/RGrAVqoATyOz3UBLmSq+rHoc9ssrcEfRecjS0ZyXbzOQ==
X-Received: by 2002:a05:622a:1792:b0:425:4043:1d8c with SMTP id s18-20020a05622a179200b0042540431d8cmr7840990qtk.95.1702374966679;
        Tue, 12 Dec 2023 01:56:06 -0800 (PST)
Received: from localhost.localdomain ([151.29.78.8])
        by smtp.gmail.com with ESMTPSA id l18-20020ac84592000000b00419732075b4sm3927478qtn.84.2023.12.12.01.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:56:06 -0800 (PST)
Date:   Tue, 12 Dec 2023 10:56:02 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <ZXguMgcKLCLn16T4@localhost.localdomain>
References: <20230729135334.566138-1-atomlin@atomlin.com>
 <um77hym4t6zyypfbhwbaeqxpfdzc657oa7vgowdfah7cuctjak@pexots3mfb24>
 <ZXdXdBzvbkI4Y4fL@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXdXdBzvbkI4Y4fL@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for the quick reply!

On 11/12/23 08:39, Tejun Heo wrote:
> Hello,
> 
> On Mon, Dec 11, 2023 at 03:51:57PM +0100, Juri Lelli wrote:
> > Guess this is a requirement because, if workqueue processing is stuck
> > for some reason, getting rescuers to run on the same set of cpus
> > workqueues have been restricted to already doesn't really have good
> > chances of making any progress?
> 
> The only problem rescuers try to solve is deadlocks caused by lack of
> memory, so on the cpu side, it just follows whatever worker pool it's trying
> to help.
> 
> > Wonder if we still might need some sort of fail hard/warn mode in case
> > strict isolation is in place? Or maybe we have that already?
> 
> For both percpu and unbound workqueues, the rescuers just follow whatever
> pool it's trying to help at the moment, so it shouldn't cause any surprises
> in terms of isolation. It just temporarily joins the already active but
> stuck pool.

Hummm, OK, but in terms of which CPU the rescuer is possibly woken up,
how are we making sure that the wake up is always happening on
housekeeping CPUs (assuming unbound workqueues have been restricted to
those)?

AFAICS, we have

send_mayday ->
  wake_up_process(wq->rescuer->task)

which is not affined to the workqueue cpumask it's called to rescue, so
in theory can be woken up anywhere?

Thanks,
Juri

