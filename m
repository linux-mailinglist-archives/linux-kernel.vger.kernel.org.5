Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964AE7B5492
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbjJBN62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbjJBN6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72892C6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696255057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8WYdzef3dhUYZw3DH0bBi+1f62S5ySyKU54RTq989w=;
        b=G2efkXPKjKSd1Onwy6aCXMcID5WUY/TkE0+VWtwYJJKLmIPF9bGvyAKeROor7N9N/6bthb
        d+X5UMwm7wEx55ldIXuKhPQzOkrJwpKEVh1rCiXJp1hhM8cCUaj3ItIqP96ndTdbvwhsd3
        e0B/djNv4kboApMiW4QdFEhJUkP4G/o=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-5fiUcE4UOEGpdcgS_ey3xA-1; Mon, 02 Oct 2023 09:57:36 -0400
X-MC-Unique: 5fiUcE4UOEGpdcgS_ey3xA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-418116b13a7so197226421cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 06:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696255056; x=1696859856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8WYdzef3dhUYZw3DH0bBi+1f62S5ySyKU54RTq989w=;
        b=mdvBJWJNbAEzJ7bIn2Ba6m4q/6a45dPq+/blTnzIC0Xf4VSWze516mpRtM65WUaxdz
         Ug29/oy4yU9rUL8vyhfCRrHqLd0y/OnkhU+Oe39OE0CCSSLAmz4vifKw+4P5RhNJKBxs
         lOgRElesRwxp5YmbjR0+03HoaJapkOs67DXEU4jUC2vLRRXgmD20O+VXtPa1TN6i0ewM
         CKh4TzB3m6cP2pzrihFCLOlBgx1vCBpluRvaZ1JYePmp6V8oe6Zi8Oo9J+I+ElqQww2F
         ugTcsO6tiC35dIsGq2AXu0JPqstVI6BTd9wOqeUdxEnWJsOJaPHNf1IfI2J8kxbj5rwT
         Zllw==
X-Gm-Message-State: AOJu0YwqM8n77e3Z1xrxxFWT3ORAtpirFOhTrKqfwgNljF46ZUc8XxLQ
        YyIcZ6CDk8F6xEveGnCCKesP98Jd7Jl5xJfzEpE9VULNpXxAab31FIOYvBC/I2PACekzovrIGvp
        IkolWWAmdrVuwG0VmpJJi6qFp
X-Received: by 2002:ac8:58c5:0:b0:418:4e7:b82c with SMTP id u5-20020ac858c5000000b0041804e7b82cmr15356415qta.57.1696255055998;
        Mon, 02 Oct 2023 06:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFqqH2hLZLdUz2hZHgPn/1hd6wxw8eYP65VHIjQN4f059HcEmEoL26OMfQzDI+qIGKcMwU0g==
X-Received: by 2002:ac8:58c5:0:b0:418:4e7:b82c with SMTP id u5-20020ac858c5000000b0041804e7b82cmr15356401qta.57.1696255055721;
        Mon, 02 Oct 2023 06:57:35 -0700 (PDT)
Received: from thinkpad2021 ([64.99.149.73])
        by smtp.gmail.com with ESMTPSA id i6-20020ac813c6000000b0041817637873sm5831638qtj.9.2023.10.02.06.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 06:57:35 -0700 (PDT)
Date:   Mon, 2 Oct 2023 09:57:33 -0400
From:   "John B. Wyatt IV" <jwyatt@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-rts-sst <kernel-rts-sst@redhat.com>, jlelli@redhat.com
Subject: Re: Crash with 6.6.0-rc1-rt1 and several i915 locking call traces
 with v6.5.2-rt8 and gnome-shell on Alder Lake laptop
Message-ID: <ZRrMTfZsM9bv4GiF@thinkpad2021>
References: <ZQttJ8W9UFP46E1b@thinkpad2021>
 <20230922110720.AZ03l3A9@linutronix.de>
 <ZRaONA0LSFumpyja@thinkpad2021>
 <F4pA9qG-zsUd2s-KZZ8oHrbd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F4pA9qG-zsUd2s-KZZ8oHrbd@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 11:45:45AM +0200, Sebastian Andrzej Siewior wrote:
> I looked at the traces in this email and they originate from a
> might_sleep() in guc_context_set_prio(). The reason is that they check
> at the atomic/interrupt state to figure out if they can sleep or not.
> Both checks don't work on RT as intended and the former has a not to not
> be used in drivers…
> 
> The snippet below should cure this. Could you test, please.
> 
> Sebastian
>

I tested this at both boot and suspend/resume. No call traces reported.

Thank you Sebastian.

