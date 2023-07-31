Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDFD769BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjGaQDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjGaQCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:02:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1871732
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690819323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fle66BdI0bujJwN3hEl5LFW6syixCYXJ4Ddx7BkUR20=;
        b=FjFPNpwRpeoDQHDYVCo2wxwZ/i1i45o3vcMdOq4Lq6rDqoKS9LMiJ5DYiDIToL47cOLYDZ
        OIUOMAzVw7313cYiLqoK+cPsnnm9FfiqSP7USST2/Xv0vVXkMU8Cb2ULd4a9G0L+IuwXhY
        UcQroxULKyTMubScLi7XbO471iYGnDo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-tZY0IxesOn-49Y2PRagJjw-1; Mon, 31 Jul 2023 12:02:01 -0400
X-MC-Unique: tZY0IxesOn-49Y2PRagJjw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40fa24ab5c8so2362941cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690819321; x=1691424121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fle66BdI0bujJwN3hEl5LFW6syixCYXJ4Ddx7BkUR20=;
        b=LjZux2evX50n9FxSTNpAOG+xOwxodpRLtn7MhcNy2nWbPQIiM8YUWoJo1iKzkpOeoh
         xvcNSppy5rqmZ5anyr1Kk6ivEN2UQypNISCZRCMa2IuhF76xELzYhy0eSLLfs4AFQIdk
         Wl61enK4lLXouCzgXtZEq9VrpwG3x+V0NVNcv7zXHpgsROrsSXwV+nJ38h/xdyb7frR3
         9hLQDbAv4Po+H2J4WW6FvioMnsn6kZrjJCun4WGmf/jIaDTyBAbvNOv15MQEI8gB01zu
         fumAt44m946nomRgULW2fT2m5FiCdanKDoaSqSFmYLc8+ArXgtV7fxpVVEBOzSLbQ2Os
         kDNQ==
X-Gm-Message-State: ABy/qLacj1bqwu5qx6xb9LqMXd1DFu5ahqoszJyAjuTyoieXiqAkYJGK
        fgilGwwYSOUBRqpUFHVxB0joQCJoYKu7xjFbvy6fRH15ad+mZPgFqctqvUR3mqvNi3s0wkcc+jd
        xALsvqm9afWgPn8we1tkCo8lGRQNBenXA
X-Received: by 2002:a05:620a:bd5:b0:76a:f689:dff2 with SMTP id s21-20020a05620a0bd500b0076af689dff2mr8009924qki.7.1690819321164;
        Mon, 31 Jul 2023 09:02:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHmDU3Q7e8CyjbeT0B4NsylAZwm9By0RZ0H8bJsJ1dfXWvcoMjORe9NZsY46jRpEjqXmqkdAw==
X-Received: by 2002:a05:620a:bd5:b0:76a:f689:dff2 with SMTP id s21-20020a05620a0bd500b0076af689dff2mr8009895qki.7.1690819320764;
        Mon, 31 Jul 2023 09:02:00 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id j27-20020a05620a001b00b00767d05117fesm3391474qki.36.2023.07.31.09.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 09:02:00 -0700 (PDT)
Date:   Mon, 31 Jul 2023 12:01:58 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Message-ID: <ZMfa9qc8m/a6IT8J@x1n>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <ZMQZfn/hUURmfqWN@x1n>
 <CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com>
 <e74b735e-56c8-8e62-976f-f448f7d4370c@redhat.com>
 <CAHk-=wgG1kfPR6vtA2W8DMFOSSVMOhKz1_w5bwUn4_QxyYHnTA@mail.gmail.com>
 <69a5f457-63b6-2d4f-e5c0-4b3de1e6c9f1@redhat.com>
 <ZMQxNzDcYTQRjWNh@x1n>
 <22262495-c92c-20fa-dddf-eee4ce635b12@redhat.com>
 <ZMQ9wuSa3Sp3sVvE@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMQ9wuSa3Sp3sVvE@ziepe.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 07:14:26PM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 28, 2023 at 11:31:49PM +0200, David Hildenbrand wrote:
> > * vfio triggers FOLL_PIN|FOLL_LONGTERM from a random QEMU thread.
> >   Where should we migrate that page to? Would it actually be counter-
> >   productive to migrate it to the NUMA node of the setup thread? The
> >   longterm pin will turn the page unmovable, yes, but where to migrate
> >   it to?
> 
> For VFIO & KVM you actively don't get any kind of numa balancing or
> awareness. In this case qemu should probably strive to put the memory
> on the numa node of the majorty of CPUs early on because it doesn't
> get another shot at it.
> 
> In other cases it depends quite alot. Eg DPDK might want its VFIO
> buffers to NUMA'd to the node that is close to the device, not the
> CPU. Or vice versa. There is alot of micro sensitivity here at high
> data rates. I think people today manually tune this by deliberately
> allocating the memory to specific numas and then GUP should just leave
> it alone.

Right.

For the other O_DIRECT example - it seems to be a more generic issue to
"whether we should rely on the follow up accessor to decide the target node
of numa balancing".  To me at least for KVM's use case I'd still expect the
major paths to trigger that is still when guest accessing a page from vcpu
threads, that's still the GUP paths.

Thanks,

-- 
Peter Xu

