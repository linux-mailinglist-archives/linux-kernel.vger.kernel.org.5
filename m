Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7137BA043
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjJEOfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjJEOeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:34:06 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E006A66
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 23:32:35 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso517271b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 23:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696487555; x=1697092355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/5eX5GBp7k2hHn5lrQWKK4MymvEqMThCeZQ6rRZTrco=;
        b=kr9uOOQcGpQ0xzBa70RibzY73/gZvA6iW9u64p8wrSJIj5MinGXNGF5yqP7aJKtdFH
         mGPHr/rXoqgh1kPtox2icqLO9DHjhL9mYS6LWv7WRge+ZpOYhenPq3UjUHRs+45sVClJ
         /inNbfeT4+/ZLx9+0J9yXdizRnWZ6OJHmKtNNNvGIzAitGezoES1V0EqvdWoLVxP02he
         kWlZBZrFzDAwTyHhwt+3w8e9hysmcJ0fCEHJaOM502gg6rwjQrPS6LaSsfwbh5O+q5+1
         pKU5fcgd3ZLtxK6fYYG0MdrNOg2Tb7M3aVAMO06lJFX5/GdwN3Z3I/novpRajOClujAI
         vaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696487555; x=1697092355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5eX5GBp7k2hHn5lrQWKK4MymvEqMThCeZQ6rRZTrco=;
        b=I7TwqMcsmSdcTb7rVD7viczQqS3XXOASVsCQ7FduEMSUJ1vLhr8sHISEJgl6eURGdY
         qO57yovs5x4/LtC5uiN5D0ZO0vlBXoMU02s5hD9E95ZNbPqoa9LtmkFtCMpsc0De3LyT
         A92s6W590vCgsWi3KjgAIKJHvX1C52v4JIRGkT3yY+WJAc0XwPO/26Cf0tR1rMMDQQRN
         3M/WFdj69bJi5bXuq0XDgwbHqnuc4b0ZYYy0LQJwlN3XUrXUSXHoi7bzy32QreHCkiaz
         dhr64YuxXrzxsrlIfTFRWGmeYpyH1tE/T3XCd9GYE/wJltn7ydsDi+nR0yGDwlUwX+ZW
         jf+Q==
X-Gm-Message-State: AOJu0YxPI68kSeRFSJ4tKx01Yd846MsJxHbgMIW8vtvpOqFHAEql/Rc8
        cQw6nDmIvivjGWkEMFXRZHZ7vg==
X-Google-Smtp-Source: AGHT+IGb+mCHo4FRpXitGXCKr5LQdAZTu+neO70o7JLurE2biwBEnclAQiw0CsTWJXIF841T9qLiXw==
X-Received: by 2002:a05:6a00:3a18:b0:691:27b:15b4 with SMTP id fj24-20020a056a003a1800b00691027b15b4mr820494pfb.5.1696487554588;
        Wed, 04 Oct 2023 23:32:34 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id e18-20020aa78c52000000b0068fb8080939sm592379pfd.65.2023.10.04.23.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 23:32:33 -0700 (PDT)
Date:   Thu, 5 Oct 2023 12:02:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/2] xen: privcmd: Add support for ioeventfd
Message-ID: <20231005063231.vqwhfnlc64phwmto@vireshk-i7>
References: <cover.1693311370.git.viresh.kumar@linaro.org>
 <52b07a3861a34fb0deb6251bae8bd885815c6944.1693311370.git.viresh.kumar@linaro.org>
 <fb79fa9a-e91c-4bb7-8aee-c384b99df953@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb79fa9a-e91c-4bb7-8aee-c384b99df953@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-09-23, 07:46, Juergen Gross wrote:
> On 29.08.23 14:29, Viresh Kumar wrote:
> > +static irqreturn_t ioeventfd_interrupt(int irq, void *dev_id)
> > +{
> > +	struct ioreq_port *port = dev_id;
> > +	struct privcmd_kernel_ioreq *kioreq = port->kioreq;
> > +	struct ioreq *ioreq = &kioreq->ioreq[port->vcpu];
> > +	struct privcmd_kernel_ioeventfd *kioeventfd;
> > +	unsigned int state = STATE_IOREQ_READY;
> > +
> > +	if (ioreq->state != STATE_IOREQ_READY ||
> > +	    ioreq->type != IOREQ_TYPE_COPY || ioreq->dir != IOREQ_WRITE)
> > +		return IRQ_NONE;
> > +
> > +	smp_mb();
> > +	ioreq->state = STATE_IOREQ_INPROCESS;
> > +
> > +	mutex_lock(&kioreq->lock);
> > +	list_for_each_entry(kioeventfd, &kioreq->ioeventfds, list) {
> > +		if (ioreq->addr == kioeventfd->addr + VIRTIO_MMIO_QUEUE_NOTIFY &&
> > +		    ioreq->size == kioeventfd->addr_len &&
> > +		    (ioreq->data & QUEUE_NOTIFY_VQ_MASK) == kioeventfd->vq) {
> > +			eventfd_signal(kioeventfd->eventfd, 1);
> > +			state = STATE_IORESP_READY;
> > +			break;
> > +		}
> > +	}
> > +	mutex_unlock(&kioreq->lock);
> > +
> > +	smp_mb();
> 
> Is this really needed after calling mutex_unlock()? I think you are trying to
> avoid any accesses to go past ioreq->state modification. If so, add a comment
> (either why you need the barrier, or that you don't need it due to the unlock).

Right, want all writes to finish before updating state.

> In general, shouldn't the state be checked and modified in the locked area?

The handler runs separately for each vcpu and shouldn't run in parallel for the
same vcpu. And so only one thread should ever be accessing ioreq port structure.

The lock is there to protect the ioeventfds list (as mentioned in struct
declaration) against parallel access, as threads for different vcpus may end up
accessing it simultaneously.

-- 
viresh
