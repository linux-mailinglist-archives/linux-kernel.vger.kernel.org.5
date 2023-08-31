Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2FE78F0F8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345259AbjHaQMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbjHaQMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:12:46 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BE1E4F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:12:43 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c0888c175fso10116295ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693498363; x=1694103163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5KNC1KlEcWUnBzTg5ZI977kAGjAeaRhmbGUmis27nHI=;
        b=YfGz+kzrX2xEGlEsQFC4m5/o4tKhnlKP2ZGv2HaWxKE1wD4IUxzRP+/nyOJE6gFaY5
         qL3AJgpKSqGzkuYZ1SmVV975lFU2FjA1Z12ndgQijW5a+hgdUr7YwPI8cQQJOKBVDWFC
         KUo5JcsifUs//WlzB/JBoJMYDYm6Ve5HJAcgHYZz0r9rLLIElrKIlVWDIDpOQsGumvzR
         NMFOQmhv3aTyVYkI+m+GD1u+tqZ1LQl0SVJqa44kce/gkMGPPhsd2lAEA1cLJ6QVCC3y
         hGTKUxD0NlQDGhs2R5/oif7D2zHL/hx02ARoJQCM+ts3JFolGvKeBynzwJxXmUEQhQI0
         65sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693498363; x=1694103163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KNC1KlEcWUnBzTg5ZI977kAGjAeaRhmbGUmis27nHI=;
        b=iNAGvuUbwopIb0fPOoxQTEZwn55sPuRhYQPEA5XGb9YJde2xJc4dfa6/IBB2YCm8gU
         Ka3UhfqFyrXXlPlyoziQzPxOwo5rML3IvIXDC5FR1oX6A1j1mGEjr1sMnguAcZC9HB2Z
         bmFzhlJHu4BBSkhudPn0IW4UvVWARph8hXIm+bX1kXP5ulQZ/Q+8NKEu8sP2fgbtdVHf
         5+xItIr/0MHAiv2LNy6HmgS6ofqI7kS0Ji/NtqBB4v+Arb+ctDyXdi0SBM7jH49wzvIy
         6BDA1osyVjlyh8SuSLfa+x7rsyHXk7WMzanAmWODp1ZpF6ArUgwXWMhirq++1z5ucnin
         Dirw==
X-Gm-Message-State: AOJu0Yw2vI+Aky20f9HNKTZdKMIxZX7yBak/NRzS47N8yZb3jMUUErnp
        mRSsDTiFARCQDUaqhejweRrCveaTbPA=
X-Google-Smtp-Source: AGHT+IFXGato4kVxkuHZRpn5w8PUuo6XDphV4hiJzVPs3sq9aa48yGnbGR+p44ts4E4VAMAfi4N80Wj/Oc4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ec8e:b0:1bc:a3b:e902 with SMTP id
 x14-20020a170902ec8e00b001bc0a3be902mr26612plg.3.1693498362949; Thu, 31 Aug
 2023 09:12:42 -0700 (PDT)
Date:   Thu, 31 Aug 2023 09:12:41 -0700
In-Reply-To: <5a24113a-ddc6-678b-0606-47070004bab4@maciej.szmigiero.name>
Mime-Version: 1.0
References: <20230822231740.2448696-1-seanjc@google.com> <5a24113a-ddc6-678b-0606-47070004bab4@maciej.szmigiero.name>
Message-ID: <ZPC7+X+Bi+2Sn4Ko@google.com>
Subject: Re: PUCK Agenda - 2023.08.30
From:   Sean Christopherson <seanjc@google.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023, Maciej S. Szmigiero wrote:
> On 23.08.2023 01:17, Sean Christopherson wrote:
> > Canceling this week.  I need to write-up the refreshed guest_memfd() todo list
> > that I promised to give in last week's impromptu discussion.
> > 
> > Future Schedule:
> > August 30th    - Available
> 
> Was there a PUCK meeting today?
> 
> I don't see any "CANCELED" message on the mailing list,
> but was waiting like 10 minutes in the meeting waiting room
> until I got kicked out from it automatically, so I guess no?

No, I screwed up my days and thought Wednesday was Tuesday.  I'll add another
reminder on my calendar to try and prevent this from happnening again.

Sorry for wasting your time. :-/
