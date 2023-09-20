Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB04A7A7614
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjITIlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjITIlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E078F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695199227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TBGan7puKQTZLNv3QP6UatLznvd0DiE0/xxoKZXKoRg=;
        b=CcmGhpDYpABwq5T/aCUynZn2cxJ8BeKC5rt6rIfymEMOGxCLLHMR1gLd6lH4NpJY0pOBrr
        zOlAYK+/stBLYHrvFck3YF09Q9Rbs7Q4TxoR+OhcoOBhetko1VR7W3fcszzy7hkJ8Adh4a
        bRLgu4dj4c7DI37miixShaL6CGM75FA=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-seufK9QoOFKsNiuiL7TY9w-1; Wed, 20 Sep 2023 04:40:25 -0400
X-MC-Unique: seufK9QoOFKsNiuiL7TY9w-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7983ed2a0f6so158221839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695199225; x=1695804025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBGan7puKQTZLNv3QP6UatLznvd0DiE0/xxoKZXKoRg=;
        b=mzfU/49zO07+JF7bQYo8PDj+SMI7tHAZGMubvLq9suhRdNuFtWICDT4u7nW795m3S0
         3rS5vuX5HP4F9qBz32ekuqm6eZ3Ve3u3ug2StpKQSQdb0P6wD8e1DYsC8+B/FFwTb6Ac
         eSz6U0PS99xYJoXdbuBsOLu+fG78RMuaUb8B9cbNmgrITnmBX9KeXPT/jybiSz31YWhX
         w3PsTsO5tLDYrVl6ZRlnJEQmKbwsohE1GAY7vH5iXeJoZmNM3fyQMZW6XPwh6lEja96K
         uwcBXv9bGa1y2Mgk9KslyyIrmhkkQRArSQBbI8GdBuHxmN3/VXdY37cIhDZSXsy5g0zW
         4D1w==
X-Gm-Message-State: AOJu0Yw7AxHzKGGFvQYDOtU19/88wthndSpzl2vO7GCsGum5cffDvVfz
        6/UUmyvwGJ+wUXQrJ0J2JPn/y663jBLOYpuifIKCSEO9lEGKYEIxTh62qntyx64rBYWt4rD+xqg
        OIoEO6T6+nDQW6xD76jKDgJbzYhb1y1WD6QerOuK6
X-Received: by 2002:a92:d647:0:b0:345:e438:7381 with SMTP id x7-20020a92d647000000b00345e4387381mr2119506ilp.2.1695199225029;
        Wed, 20 Sep 2023 01:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/nNlgdwWnUwZKtEwOL/WSZUqmM3GjHBG6pv7scdqieL1P4bXUAf2on7dPyGtRFzK6Kz3jzeu8+oYoL+Sj3fk=
X-Received: by 2002:a92:d647:0:b0:345:e438:7381 with SMTP id
 x7-20020a92d647000000b00345e4387381mr2119491ilp.2.1695199224757; Wed, 20 Sep
 2023 01:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230911052535.335770-1-kernel@jfarr.cc> <20230913160045.40d377f9@rotkaeppchen>
 <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com> <CALu+AoTAUWWtx8yChQMKF9J5X_Qd8+x0hz0jzVwoOvAvh5VmHA@mail.gmail.com>
In-Reply-To: <CALu+AoTAUWWtx8yChQMKF9J5X_Qd8+x0hz0jzVwoOvAvh5VmHA@mail.gmail.com>
From:   Dave Young <dyoung@redhat.com>
Date:   Wed, 20 Sep 2023 16:40:04 +0800
Message-ID: <CALu+AoRiok-bzM4OQbiix44O-PUgO2N6Yi+_qTOn4iWtk_u4cg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
To:     Jan Hendrik Farr <kernel@jfarr.cc>
Cc:     Philipp Rudo <prudo@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>,
        bhelgaas@google.com, Luca Boccassi <bluca@debian.org>,
        lennart@poettering.net, "Liu, Pingfan" <piliu@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sept 2023 at 15:43, Dave Young <dyoung@redhat.com> wrote:
>
> > > In the end the only benefit this series brings is to extend the
> > > signature checking on the whole UKI except of just the kernel image.
> > > Everything else can also be done in user space. Compared to the
> > > problems described above this is a very small gain for me.
> >
> > Correct. That is the benefit of pulling the UKI apart in the
> > kernel. However having to sign the kernel inside the UKI defeats
> > the whole point.
>
>
> Pingfan added the zboot load support in kexec-tools, I know that he is
> trying to sign the zboot image and the inside kernel twice. So
> probably there are some common areas which can be discussed.
> Added Ard and Pingfan in cc.
> http://lists.infradead.org/pipermail/kexec/2023-August/027674.html
>

Here is another thread of the initial try in kernel with a few more
options eg. some fake efi service helpers.
https://lore.kernel.org/linux-arm-kernel/ZBvKSis+dfnqa+Vz@piliu.users.ipa.redhat.com/T/#m42abb0ad3c10126b8b3bfae8a596deb707d6f76e

>
> Thanks
> Dave

