Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA29B7FC16E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346310AbjK1OoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345841AbjK1OoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:44:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651078E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701182661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=djUZFKrYN0Kble9zgAfouo+reIDsZTVLhC/pLABbWaU=;
        b=QamduNEmAKPtQ0yywKGw+toXVtkB0XZm6Qtt09WqfeYxTQkKyBJbR25HykgZfau3q3VRFd
        F6DxHArac72wo0+RxriucsTEccb4GQ6vsJmvZQRlxGAiI3Kjqx070bN07zIgU1wcMlBg79
        /Cyc3uxR+VhjIQiv9SHZ92FiKtoNuwY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-Fw0XdgjbMvSI_C-FTEP9jA-1; Tue, 28 Nov 2023 09:44:20 -0500
X-MC-Unique: Fw0XdgjbMvSI_C-FTEP9jA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77893b0a2cdso702163085a.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701182660; x=1701787460;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djUZFKrYN0Kble9zgAfouo+reIDsZTVLhC/pLABbWaU=;
        b=Zb96KCkYfduibWIFO3FJHtGze/EB76o0g5gGWl3Cr15frvd6mFC6LWp7aJecPI/ETb
         feo2uIKm8WMUNdyBeL67cQWymhVcxQoDIH9IuPFODFUdcD4shTPwIPi0iGJgi00H/RKw
         BeNiyOFEGovBeNP+I/hOrXX5UiqQ2/qnoJJpeFrFdpA//U23pb1ClQz/GbYqARrW++//
         IGXhqLLqByJyIO52rf9Zi1qZNg63Jjf63gMSPIZ0sByozx6iCDMjXnfKY84GcZ5Xrbu0
         HtiKE0gmWlYdAzTqCZwYkziloKIUZdlLWDRLYeazaBuEQYpzkzS3bu9MCwUbMVrxHP3Q
         exmQ==
X-Gm-Message-State: AOJu0Yz0MmxUTrCBvmyYpXBwghwiPXgUPYp9pqB2gqNdi+3gUEPnxI4a
        XwyAoMKSfS/epubm6c5BRc9tjuW20VR0uVIGOm5JmXO6Ajmr2nqEmz2d+3xfN2Dlq8vboMciUPJ
        /az5HVM/a/CYlhpXB4ZYIlKjm
X-Received: by 2002:ad4:44ae:0:b0:67a:218c:efc5 with SMTP id n14-20020ad444ae000000b0067a218cefc5mr13807815qvt.35.1701182659962;
        Tue, 28 Nov 2023 06:44:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh9N2Y7H9VGX3UaXfwoE797A34tNrjgnz8/vHkQlSgzn5oGS/BgJhrVEADqEdgXqXsl+bnpg==
X-Received: by 2002:ad4:44ae:0:b0:67a:218c:efc5 with SMTP id n14-20020ad444ae000000b0067a218cefc5mr13807798qvt.35.1701182659738;
        Tue, 28 Nov 2023 06:44:19 -0800 (PST)
Received: from rh (p200300c93f306f0016d68197cd5f6027.dip0.t-ipconnect.de. [2003:c9:3f30:6f00:16d6:8197:cd5f:6027])
        by smtp.gmail.com with ESMTPSA id kf2-20020a056214524200b0067a1e5ef6b1sm3867496qvb.106.2023.11.28.06.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:44:19 -0800 (PST)
Date:   Tue, 28 Nov 2023 15:44:15 +0100 (CET)
From:   Sebastian Ott <sebott@redhat.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: usb hotplug broken on v6.5.12
In-Reply-To: <28799328-a70c-40ff-ae4a-cf1933c8dbc5@amd.com>
Message-ID: <6f9218da-3fd0-a765-6515-e75ed9dd6978@redhat.com>
References: <2c978ede-5e2f-b630-e126-4c19bd6278dc@redhat.com> <28799328-a70c-40ff-ae4a-cf1933c8dbc5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023, Mario Limonciello wrote:
> On 11/28/2023 07:12, Sebastian Ott wrote:
>>  usb hotplug doesn't work for me running stable kernel v6.5.12 on an AMD
>>  based Thinkpad t495s. Bisect pointed to 7b8ae3c24ef ("xhci: Loosen RPM as
>>  default policy to cover for AMD xHC 1.1") - which is 4baf1218150 upstream.
>>
>>  Reverting that from 6.5.12 fixes the issue for me.
>>  Current upstream rc kernel contains this patch but doesn't show the issue.
>> 
> I believe it's the same discussion as 
> https://lore.kernel.org/stable/5993222.lOV4Wx5bFT@natalenko.name/#t
>
> The outcome was that another missing patch is in the stable queue for various 
> kernels and will be part of the next stable release for various kernels.

Great, thank you!
I can confirm that v6.5.12 + a5d6264b ("xhci: Enable RPM on controllers that support low-power states")
fixes the issue for me.

Sebastian

