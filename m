Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BBA7AF19A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjIZROw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjIZROu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97270E5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695748438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8iSKGZWWS3kPHTKmKQnCV3dnxajnStM2eAQDnCvJgoU=;
        b=LEVws7WPbkM31Lv49P/YuRV22/OlXbQglAx/fX+aQUCgT8TqVudmixOUbi0SxZB7baWi7A
        IYL1c/g1iMuWlzdGSrHK0ZnTUlZX7DNa09IbkC9Mse9QNYsEhDDxjvfpbkJ7d3yUSTlL/Y
        2KNXhtIvzP69CCgVKei14MIOBkFtKWE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-_zsoj7MBOaG1C9PrR4vL5A-1; Tue, 26 Sep 2023 13:13:57 -0400
X-MC-Unique: _zsoj7MBOaG1C9PrR4vL5A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9adc78b386cso748640066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695748436; x=1696353236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iSKGZWWS3kPHTKmKQnCV3dnxajnStM2eAQDnCvJgoU=;
        b=sqqjScsomKlacLuTdgLJR05gTQT0jbfR2yeQLWRfqCeVa5k6DbzzSD6xuNLu9hrra/
         HRY39LEIMA1luOW9qravk+SYelYK60e74BTeI3ngoyQnxPCwOqzt9+Mv1QnD1pbf0Zfq
         7d9obhCZHywNlCVOmojF1Is7FAaZfRQ8xvjeLGx7jzIPnbTw04OeOCzuLp2rBeXATrp0
         b0w6029E45CfmJsdwgUCIQ28UsfTNXIab+dzGVTXoFWWIYzRcf+ItyGwhXZ6oyrpJqbA
         BrxUtlU0Lqam+THVZuMI04+3bM2OnwcJs+NXJeHEdXngGuhR4zoG+iglZj69bHUfINri
         bc1A==
X-Gm-Message-State: AOJu0Yz5NYpLsbCAOFcEScGdWfkXIXBUgDYB8pwIdu8Tswc56seRl20r
        9QqNHpQsy6l7/yh5yOnteBEBjRwTQb+KkW8gI5nnYSB9rXymBsY74tnwuv5XL2JOdjcBnsiZE74
        95e0GNH24ul7SI54MWO076Atk
X-Received: by 2002:a17:906:1ce:b0:9ad:fcf8:e81b with SMTP id 14-20020a17090601ce00b009adfcf8e81bmr9202359ejj.51.1695748436233;
        Tue, 26 Sep 2023 10:13:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfk+7pxiRTHX+2QchxH8dV2phzuRQiv4H+N4VC9jMJ3K5sTKGvVgc9Wfj9N5+kDslbIIRD3Q==
X-Received: by 2002:a17:906:1ce:b0:9ad:fcf8:e81b with SMTP id 14-20020a17090601ce00b009adfcf8e81bmr9202340ejj.51.1695748435941;
        Tue, 26 Sep 2023 10:13:55 -0700 (PDT)
Received: from redhat.com ([2.52.31.177])
        by smtp.gmail.com with ESMTPSA id j8-20020a170906050800b009934855d8f1sm7978261eja.34.2023.09.26.10.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 10:13:55 -0700 (PDT)
Date:   Tue, 26 Sep 2023 13:13:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Message-ID: <20230926130521-mutt-send-email-mst@kernel.org>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
 <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 06:41:58PM +0200, Halil Pasic wrote:
> [..]
> > --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > @@ -61,8 +61,9 @@ static void virtio_crypto_akcipher_finalize_req(
> >  	vc_akcipher_req->src_buf = NULL;
> >  	vc_akcipher_req->dst_buf = NULL;
> >  	virtcrypto_clear_request(&vc_akcipher_req->base);
> > -
> > +	local_bh_disable();
> >  	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);
> > +	local_bh_enable();
> 
> Thanks Gonglei!
> 
> I did this a quick spin, and it does not seem to be sufficient on s390x.
> Which does not come as a surprise to me, because 
> 
> #define lockdep_assert_in_softirq()                                     \
> do {                                                                    \
>         WARN_ON_ONCE(__lockdep_enabled                  &&              \
>                      (!in_softirq() || in_irq() || in_nmi()));          \
> } while (0)
> 
> will still warn because  in_irq() still evaluates to true (your patch
> addresses the !in_softirq() part).
> 
> I don't have any results on x86 yet. My current understanding is that the
> virtio-pci transport code disables interrupts locally somewhere in the
> call chain (actually in vp_vring_interrupt() via spin_lock_irqsave())
> and then x86 would be fine. But I will get that verified.
> 
> On the other hand virtio_airq_handler() calls vring_interrupt() with
> interrupts enabled. (While vring_interrupt() is called in a (read)
> critical section in virtio_airq_handler() we use read_lock() and
> not read_lock_irqsave() to grab the lock. Whether that is correct in
> it self (i.e. disregarding the crypto problem) or not I'm not sure right
> now. Will think some more about it tomorrow.) If the way to go forward
> is disabling interrupts in virtio-ccw before vring_interrupt() is
> called, I would be glad to spin a patch for that.
> 
> Copying Conny, as she may have an opinion on this (if I'm not wrong she
> authored that code).
> 
> Regards,
> Halil

On a related note, config change callback is also handled incorrectly
in this driver, it takes a mutex from interrupt context.

