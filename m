Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB737FC1FE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjK1QfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK1QfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:35:09 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AC1AB;
        Tue, 28 Nov 2023 08:35:16 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-67a4645fdc3so13411406d6.0;
        Tue, 28 Nov 2023 08:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701189315; x=1701794115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNmZZAJm2YxwR7DMqdumV8vSovbtuf3uRewFcn2TeXM=;
        b=hoSiTT/DSnJoT/QykMPBGox3rZnZEoOXip56RmL8QBqDCNGlQZLJIo0eiBC7V96pNu
         kjgxELSA68fa7/wuCvKyEWI5UqNc4X3cA144AvOTvK6F/ibXK+kOD0F5Ng0MXD+yB717
         3P9yzka4BYW694odxfDo3cvt8B5aky6Hro0s4B0t6v2UwQa7N5N9WL9xXhRmOEysgR6w
         ZOzKs6V2aVppj3q5ERXxi5USjL1UBavpbTzkhTyiVuZmsGZTiHKxfkDeT+eBiHUeR0a0
         RSG2hTrcRc2RTvrc3bFsQdxxdVKYt2rPZy51AZeLnIaAbVTvyupD2fzWJtGxBH/rMMG2
         yQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701189315; x=1701794115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNmZZAJm2YxwR7DMqdumV8vSovbtuf3uRewFcn2TeXM=;
        b=Ua+Lb5SqSohuu8r3xSybF+TwnbmY5EW7UkVbXjclPNlSwDN6fCL9qxW/U7pzokuGA1
         Ab5LGahoWJNNqQzDwJtKA74tP9ezbOwYL9zCW875Sb2K7sq9HjJa28N2qx6kaR5j2erw
         BdALsJeRPPP4wNIv2jJIosjUFUww1A4oBV8GvCOT7JOP5j7DtfEHVG8FpMLomdi40zH7
         2LLIEXancIgOFXqrGLilHVHmSjU5LNXrso8cX1ZohRha+EHxFudHokuX/DrVBHYKgmoG
         C/RtRakJbLHTSqIkPJTHORVxEOOkUVZ2Q/mvUiZKfMdoDxQhtSxCF2BjULqy5Cy0bLoK
         8OLA==
X-Gm-Message-State: AOJu0Yza9JxTktTw+YNU+jW2/fffIWPa45NDdJPTzu6oLil3c/WJLCCy
        t8qMqxW/tMsvF/Qh4NtJfGyLVxKxkyG+VfwSP+0=
X-Google-Smtp-Source: AGHT+IF4u8tnCbc5ns4vATp/l2oSaX8XAhbxKbRsjtsRxvdX88kLcQYNs4C5F3VMiy5REfQ93WvV4m2Dl7gAHWdwtFE=
X-Received: by 2002:ad4:5ca2:0:b0:67a:2ae3:a973 with SMTP id
 q2-20020ad45ca2000000b0067a2ae3a973mr13976373qvh.4.1701189315061; Tue, 28 Nov
 2023 08:35:15 -0800 (PST)
MIME-Version: 1.0
References: <736e584f-7d5f-41aa-a382-2f4881ba747f@rowland.harvard.edu>
 <20231127160759.GA1668@lst.de> <637d6dff-de56-4815-a15a-1afccde073f0@rowland.harvard.edu>
 <20231128133702.GA9917@lst.de> <cb7dc5da-37cb-45ba-9846-5a085f55692e@rowland.harvard.edu>
 <a91938e3-a7cb-4f74-aeaa-7cb56c0b43a4@arm.com>
In-Reply-To: <a91938e3-a7cb-4f74-aeaa-7cb56c0b43a4@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Nov 2023 18:34:39 +0200
Message-ID: <CAHp75VeQoOFQ7V7gbVfR3-ANNMRT=-UniOCbnUtszo-1F3NMDA@mail.gmail.com>
Subject: Re: Bug in add_dma_entry()'s debugging code
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Christoph Hellwig <hch@lst.de>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew <travneff@gmail.com>,
        Ferry Toth <ferry.toth@elsinga.info>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        iommu@lists.linux.dev,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 6:31=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
> On 28/11/2023 3:18 pm, Alan Stern wrote:
> > On Tue, Nov 28, 2023 at 02:37:02PM +0100, Christoph Hellwig wrote:

...

> >> The logical confcusion from that would be that IFF dma-debug is enable=
d on
> >> any platform we need to set ARCH_DMA_MINALIGN to the cache line size.
> >
> > (IF, not IFF.)  And tell distributions that CONFIG_DMA_API_DEBUG is not
> > meant for production systems but rather for kernel testing, right?
>
> Yikes, I'd hope that distros are heeding the warning that the Kconfig
> calls out already. It's perhaps somewhat understated, as I'd describe
> the performance impact to large modern systems with high-bandwidth I/O
> as somewhere between "severe" and "crippling".

Independently on the distros configurations the (false positive)
message(s) will make difficult to debug the actual things, shouldn't
we have our code robust in any case?

--=20
With Best Regards,
Andy Shevchenko
