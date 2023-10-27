Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E05B7D94F7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345670AbjJ0KQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJ0KQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:16:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7995310E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:16:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso2898107a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698401766; x=1699006566; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=VD8qxUSefDVjPXgNPb04+1sZrR4xz+3Ht2LV1rsGWpY=;
        b=GstTqqL8vOLnWHhTIqdJb1UgXeAxB4bAKifbnv3dKNzdNwp6YkEsdrHjORxFMrIQ8e
         VZT5Tv8t0lSgEHJCAZ5Wt1J686sq4Ay8NtIT/qKLO2oNgav+IVMsbLNusiW57JjHHuB/
         feMYOlonuS7+Z7hLxYnMSbUb1NN8R0nKrai5u8rEEFpxGO0sBuOQLyNgROFpb7exe724
         K7DAK8+ypS55gG1EnJdq10KFfkCweX/BM9R/Mdpz8LcYBIfBZjU+wW6tp4FuuU9t2a7p
         2HnHZXhy6mABu2H9fYCrz3+vMxypyTmQuCp+Yls1HDXKOYsN3RCn4xwaUFcF10SNymP8
         PyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698401766; x=1699006566;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD8qxUSefDVjPXgNPb04+1sZrR4xz+3Ht2LV1rsGWpY=;
        b=KCzueHyuh7MpVsw/CqLXhZsNK9KnUxmMfwbPDoOTxg6tAfWYwGalcQGRlzyP6P7+Go
         pkUbA4LubnII3MfRhUfnXVupu7LgyB9H22jAz1DZm2mfHDQhWoIzMJe8xphRYBghNqgX
         0evNWbBzezyjIBIWMlmG+xmjhbl64ILkpgSkUzrk4S+jjaQD9TRE7HU3L4eR+gej8UfM
         DXRzH2lca43Sg7rF/UdnfU4LHDuSk27Jwy5VZvSfMyL/FEpg9D13J5gyVxKL4eAJOSMR
         Nj7HDe72CjZ7+tFWHhfJm+KPX8nIWjwAuB7FMDSOJb1A9gia+OjTn1pgIdPXGwzUkK3y
         nzYw==
X-Gm-Message-State: AOJu0YyvE7/W43VJV4lbr9NS510lcOFnC0GfzLtiYDPJMWQ/eOrWPAzm
        V/8u2ahjTlTUp9hAK0J7OOasmA==
X-Google-Smtp-Source: AGHT+IFfkizWmVU9WhARM2yRlhPHHxfYCuFmgAqgyUq5hVDUDfcXjYqHhdjR8kiXeJWlGUksz1K1wQ==
X-Received: by 2002:aa7:d653:0:b0:541:2bb8:7a9f with SMTP id v19-20020aa7d653000000b005412bb87a9fmr1972835edr.38.1698401765948;
        Fri, 27 Oct 2023 03:16:05 -0700 (PDT)
Received: from cloudflare.com (79.184.154.62.ipv4.supernova.orange.pl. [79.184.154.62])
        by smtp.gmail.com with ESMTPSA id y8-20020a50bb08000000b005400dc94f43sm1011571ede.45.2023.10.27.03.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:16:05 -0700 (PDT)
References: <20231025145319.380775-1-jakub@cloudflare.com>
 <87wmv91h3p.fsf@cloudflare.com>
 <20231026131830-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.6.10; emacs 28.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v2] virtio_pci: Switch away from deprecated
 irq_set_affinity_hint
Date:   Fri, 27 Oct 2023 12:03:17 +0200
In-reply-to: <20231026131830-mutt-send-email-mst@kernel.org>
Message-ID: <87sf5w1ica.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 01:20 PM -04, Michael S. Tsirkin wrote:
> On Thu, Oct 26, 2023 at 06:25:08PM +0200, Jakub Sitnicki wrote:
>> On Wed, Oct 25, 2023 at 04:53 PM +02, Jakub Sitnicki wrote:
>> > Since commit 65c7cdedeb30 ("genirq: Provide new interfaces for affinity
>> > hints") irq_set_affinity_hint is being phased out.
>> >
>> > Switch to new interfaces for setting and applying irq affinity hints.
>> >
>> > Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> > ---
>> > v2:
>> >  - Leave cpumask_copy as is. We can't pass pointer to stack memory as hint.
>> >    Proposed a change to IRQ affinity interface to address this limitation:
>> >    https://lore.kernel.org/r/20231025141517.375378-1-jakub@cloudflare.com
>> 
>> Just a note to the ^ - if we wanted to get rid of msix_affinity_masks,
>> we could call irq_set_affinity directly, instead of calling it through
>> irq_set_affinity[_and]_hint.
>> 
>> The hint wouldn't be available any more in /proc/irq/N/affinity_hint,
>> but the same information can be gathered from /proc/irq/N/smp_affinity.
>> 
>> [...]
>
>
> So we are potentially breaking some userspace - what's the value we
> gain?  Is there some way we can make disable_irq/enable_irq work?
> That would have a lot of value.
> There is an actual need for that in virtio for coco but we can't use
> these APIs with affinity managed IRQs.

Sorry, that is beyond my ken today.

I saw the comment in vp_modern_disable_vq_and_reset:

	/* For the case where vq has an exclusive irq, call synchronize_irq() to
	 * wait for completion.
	 *
	 * note: We can't use disable_irq() since it conflicts with the affinity
	 * managed IRQ that is used by some drivers.
	 */

... but I fail to follow how the two conflict.

Perhaps Xuah could shed some light here.
