Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922EE7D3D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjJWRLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjJWRLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:11:00 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69BEBD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:10:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a98517f3so4918315e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698081056; x=1698685856; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=nLXx7mlPs/OQb0ZwhhQH6B6jy+zC/eGvf9D/oXTg+Mk=;
        b=JrKmnozo/52hNk08rKMPeEynvBLbWDxi32R9aE3HNYfAMZ/m6KqdAWmCezdczLVxeP
         yD27wQOVg1ouUb1aj8L+pM+C1rUdQJSJe2f6+FG3HCa3XXoT+cm0VMMIChIGZMCwRLkt
         QD2NNTqE7cM2SQwEtNaaR69lP4wRadY32lPN9oGw1psPQHvi6YeV46S8pQE4drCh8cHy
         WEBC7ReS4NgshV/ULriEove3B0w16wj3u3flPUX+DS0xa7RTDlaXwZp+QwYrpQxImndZ
         tsjF5tLMyNo8e87rXbkXmcXsiUZq0/pAaPtqzPwoH1rHRCxZ7vpcVygKF3h95EtkQq9e
         eCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698081056; x=1698685856;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLXx7mlPs/OQb0ZwhhQH6B6jy+zC/eGvf9D/oXTg+Mk=;
        b=vxoIY9q1ZahMF66gA7amIAUlXjaN6uuTo3uITLH4tYsx9AGl7i2HEfYqNFB2Ol/rTV
         Z5e7tq4fnL2xrHSl6ytPTep9777lhhFwO7v656dmZm9jhOz7cCXusZJ4gAhZUDWLdPOE
         F1W6T/XQJ4u0eGcKz4yV6rnuIuvsyvmL6n2i3a6XKQupLkSZj6LEuD+9fJw7BGyFm14P
         DqJOG+AOhDhUXZZB18HwH8KQGSHHkYTqrh2b7Hp6OBfKXb5Km2xXS+FCvrxcDSr/5vmQ
         hmVV2PVN+gNFcqUYRU2E0FFJ8EyhH8rMelcF8HKWXZO6+6zLObgc37GPuxfCoDR7wXQ9
         8+xA==
X-Gm-Message-State: AOJu0Yyy10Roo/tzEAULpSOj3L29LpmwxyBMADy/pm7BHPcB2qdftSJ3
        AyJptOn4hfE6/KSrxBCdA2uhBQ==
X-Google-Smtp-Source: AGHT+IEvOkxYrug1krm+yJscF/JHitwboKBGBCis1eGb3W39NQ2kT1N2cdAdPFhubOMydlAxfQVd2A==
X-Received: by 2002:a19:7609:0:b0:507:9a13:27bd with SMTP id c9-20020a197609000000b005079a1327bdmr6324284lff.7.1698081055862;
        Mon, 23 Oct 2023 10:10:55 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1ce])
        by smtp.gmail.com with ESMTPSA id v21-20020a170906489500b00997d76981e0sm6862736ejq.208.2023.10.23.10.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:10:55 -0700 (PDT)
References: <20231019101625.412936-1-jakub@cloudflare.com>
 <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
User-agent: mu4e 1.6.10; emacs 28.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Caleb Raitto <caraitto@google.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu
 affinity mask
Date:   Mon, 23 Oct 2023 18:52:45 +0200
In-reply-to: <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
Message-ID: <87il6x2rj6.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:55 PM +08, Xuan Zhuo wrote:
> On Thu, 19 Oct 2023 12:16:24 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
>> mask.") it is actually not needed to have a local copy of the cpu mask.
>
>
> Could you give more info to prove this?
>
> If you are right, I think you should delete all code about msix_affinity_masks?

Sorry for the late reply. I've been away.

It looks that msix_affinity_masks became unused - intentionally - in
2015, after commit 210d150e1f5d ("virtio_pci: Clear stale cpumask when
setting irq affinity") [1].

Originally introduced in 2012 in commit 75a0a52be3c2 ("virtio: introduce
an API to set affinity for a virtqueue") [2]. As I understand, it was
meant to make it possible to set VQ affinity to more than once CPU.

Now that we can pass a CPU mask, listing all CPUs, to set_vq_affinity,
msix_affinity_masks seems to no longer have a purpose.

So, IMO, you're right. We can remove it.

Happy to do that in a follow up series.

That is - if you're okay with these two patches in the current form.

Thanks for reviewing.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=210d150e1f5da506875e376422ba31ead2d49621
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75a0a52be3c27b58654fbed2c8f2ff401482b9a4
