Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFBB7BD7A9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbjJIJvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345925AbjJIJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:51:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7D4C6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:51:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40651a72807so42023765e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696845105; x=1697449905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAHGsTZCeUxfPqrrTshtCf2/Bq/A/OJTigVgFiLPkAI=;
        b=xpUGmGyhR9aAR23+0uCYeZvP3N4GQYqNNRkV+a0Z694rx5TZK8lxj2PPTzqIbqUcoZ
         2aMjUlyREHdOjKNpHOIEbNx2ObsExKvPIVOLGXI4T9xFFJscND2k/akc7VV6fw0phG/5
         t6qMhDRT2aTxQjT2EbVlQKMsFFTFMqdsUJNeMQC/jQDVawCaj6HXa/FqO4J0hHPgDxbX
         RhQSoag3oipq25a24jNsq7evxJ8ASWnRzA59T/oB+f3iTpCxMpprOMgn22/6JtyQq4Q3
         Coyz4tqrhtceZDu+e88J+GrVvQ8YPcgShaafa3+WrS4BmaQIs+K9NmWe/o0o39vnCo/D
         +/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696845105; x=1697449905;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NAHGsTZCeUxfPqrrTshtCf2/Bq/A/OJTigVgFiLPkAI=;
        b=ME6cGG4J8pCPf8iXyQLL46V5QxDWYyaIlwjCKESszNLt6fvQYmVRlFFeUzlo94S2N5
         C4cFDvi1saTR6KWK+m9fS2ClrdTL7JwGub3nzDMN+KmhnnWZMcWwlwKDav634f07/Q7Y
         0nC68xn53p98GhV6rS3kqwgD4Afbsly+yKz92GcFOXNnufZAa3S+jEb+HeIy3+ao0XF6
         p/k4nvWGmcPfRHf4PizXv7y4reNr2hA9Uu5/x3uuuXXTMX+DjciMO5dfVxkNjz9VZmu3
         Rhr+hw1bvlSsHuiQ3eHZZvtraFmJb2CN+npA2esEycxFd7vwaNY/zH+zIGnJ5bKiGT8A
         m8aA==
X-Gm-Message-State: AOJu0Yy2vpQnCid/3fC+nbe9oWE/HFEfCSxiS4MUmknDHS4TrNOEMiTo
        JTttzxD5XUK/+ujk4recm6wYpA==
X-Google-Smtp-Source: AGHT+IFmkRg7YbI2Ea7JVADPY1W3RJWHoMKWbT5uycw7piPqswo1SNCfaKYsHAeYee6tgLPbqHLkgQ==
X-Received: by 2002:a05:6000:1758:b0:329:6d09:61f7 with SMTP id m24-20020a056000175800b003296d0961f7mr6094220wrf.48.1696845105028;
        Mon, 09 Oct 2023 02:51:45 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0031ad2f9269dsm9117293wro.40.2023.10.09.02.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 02:51:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 47D0E1FFBB;
        Mon,  9 Oct 2023 10:51:44 +0100 (BST)
References: <cover.1693311370.git.viresh.kumar@linaro.org>
 <52b07a3861a34fb0deb6251bae8bd885815c6944.1693311370.git.viresh.kumar@linaro.org>
 <fb79fa9a-e91c-4bb7-8aee-c384b99df953@suse.com>
 <20231005063231.vqwhfnlc64phwmto@vireshk-i7>
User-agent: mu4e 1.11.22; emacs 29.1.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/2] xen: privcmd: Add support for ioeventfd
Date:   Mon, 09 Oct 2023 10:40:48 +0100
In-reply-to: <20231005063231.vqwhfnlc64phwmto@vireshk-i7>
Message-ID: <877cnwqg27.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 29-09-23, 07:46, Juergen Gross wrote:
>> On 29.08.23 14:29, Viresh Kumar wrote:
>> > +static irqreturn_t ioeventfd_interrupt(int irq, void *dev_id)
>> > +{
>> > +	struct ioreq_port *port =3D dev_id;
>> > +	struct privcmd_kernel_ioreq *kioreq =3D port->kioreq;
>> > +	struct ioreq *ioreq =3D &kioreq->ioreq[port->vcpu];
>> > +	struct privcmd_kernel_ioeventfd *kioeventfd;
>> > +	unsigned int state =3D STATE_IOREQ_READY;
>> > +
>> > +	if (ioreq->state !=3D STATE_IOREQ_READY ||
>> > +	    ioreq->type !=3D IOREQ_TYPE_COPY || ioreq->dir !=3D IOREQ_WRITE)
>> > +		return IRQ_NONE;
>> > +
>> > +	smp_mb();
>> > +	ioreq->state =3D STATE_IOREQ_INPROCESS;
>> > +
>> > +	mutex_lock(&kioreq->lock);
>> > +	list_for_each_entry(kioeventfd, &kioreq->ioeventfds, list) {
>> > +		if (ioreq->addr =3D=3D kioeventfd->addr + VIRTIO_MMIO_QUEUE_NOTIFY =
&&
>> > +		    ioreq->size =3D=3D kioeventfd->addr_len &&
>> > +		    (ioreq->data & QUEUE_NOTIFY_VQ_MASK) =3D=3D kioeventfd->vq) {
>> > +			eventfd_signal(kioeventfd->eventfd, 1);
>> > +			state =3D STATE_IORESP_READY;
>> > +			break;
>> > +		}
>> > +	}
>> > +	mutex_unlock(&kioreq->lock);
>> > +
>> > +	smp_mb();
>>=20
>> Is this really needed after calling mutex_unlock()? I think you are tryi=
ng to
>> avoid any accesses to go past ioreq->state modification. If so, add a co=
mment
>> (either why you need the barrier, or that you don't need it due to the u=
nlock).
>
> Right, want all writes to finish before updating state.

I thought generally sync points act as full barriers. Doing a bunch of
grepping I think ends at:

  static __always_inline bool __mutex_unlock_fast(struct mutex *lock)
  {
          unsigned long curr =3D (unsigned long)current;

          return atomic_long_try_cmpxchg_release(&lock->owner, &curr, 0UL);
  }

so you should already have completed your writes by that point.

>
>> In general, shouldn't the state be checked and modified in the locked ar=
ea?
>
> The handler runs separately for each vcpu and shouldn't run in parallel f=
or the
> same vcpu. And so only one thread should ever be accessing ioreq port str=
ucture.
>
> The lock is there to protect the ioeventfds list (as mentioned in struct
> declaration) against parallel access, as threads for different vcpus may =
end up
> accessing it simultaneously.


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
