Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45CA77E363
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbjHPORJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343566AbjHPORB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:17:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73352708
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:17:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d68c0f22fc9so8015347276.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692195420; x=1692800220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mWxq8XPPN3K2/Hl7/jGuCvbco+UzQfaTP/jtlKOAWpo=;
        b=W5RkvSqWtUqZtUjB2ze0doBKoggpcspjyiMRkYklWTf2haqW9D9sSHYqoxAR18toeV
         2z9RYXIQjIj556tedMIJq3rAO+1Rw8GZcPOBmo6B3a1I3Wjzq+KMVwGbzsVpQvXh+AoO
         ad88pJQ9ht+/z//hgVJjtmN5SMFBtESxC3hF81opZvsKtl/wqYtcakAJBiluJrg2THKY
         pnEZZtVLlL3BuK2DyiCZxa+DekBOKl9UpUpX6OG2kGPSR90KorX78VExiMh4yhXRPDj3
         IEe1AbQhYVYcMHjyresqIt6W2/Bfj4WjrRe3mJLCzQKIxtXengvAm5xnmHMtao8ARbdd
         7Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692195420; x=1692800220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWxq8XPPN3K2/Hl7/jGuCvbco+UzQfaTP/jtlKOAWpo=;
        b=M7u7dhRX85Ptb19k5R7thLBr3MzqaylIwp+bUBWHaWPtElX+qODsyoEH1SjzvsaWvi
         0QHuUOkTz7D+Ut+b6mv/qBtFK36lkWxm436YNKSdUPW4WjO/P/Zy0wNBy56ouNamoUH0
         eutiIdQadO5EnC5J5lk3JD5hW117dp4avjJsD5kNzGdJn2enxELMjtmp9t6dXep6q9mo
         ziW6B5PXuilNOUzMWllIHw/Z9oTrFoX6ijchhOJnoNc5c2FAkc5fCwqcBdcfvu09MQmW
         J8c86yedmbrA5ixs/qFQcMszH5vTx1iW72AKv+i+EfoP4dx4BofzD+hPwIRidAw551h5
         da4Q==
X-Gm-Message-State: AOJu0Yz4ie+cSPz9v31lzOmNUmPVyAVX7446vlMLd7jKJ+bkGLw3wbfE
        K2k14KOIOySm7wl4xX/CKl+CC5ugaOU=
X-Google-Smtp-Source: AGHT+IGheELvBADZ/ZGgycp9hodD4csVOu7LpxIxavoM/BdHmL+oISGRpZgvo+gyeVlsTmNsJnvzHTff28k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1785:b0:d64:9e2c:5c0d with SMTP id
 ca5-20020a056902178500b00d649e2c5c0dmr77206ybb.5.1692195419994; Wed, 16 Aug
 2023 07:16:59 -0700 (PDT)
Date:   Wed, 16 Aug 2023 14:16:58 +0000
In-Reply-To: <ZNzVxMPkOvqOGACD@gallifrey>
Mime-Version: 1.0
References: <RyxwdfAZ2mHvlqqVVbFdCK5cQnWoOE_qz1LwSFfuXyoj0EvkDn1-TacV_C0GezxY901qUnRersvHSni9sewNZT7sGe8rKQ8OOCdAA5Bi940=@protonmail.com>
 <ZNzVxMPkOvqOGACD@gallifrey>
Message-ID: <ZNzX15Ao9LSW6KF/@google.com>
Subject: Re: 5.10.189 and 5.10.190 breaks nested virtualization
From:   Sean Christopherson <seanjc@google.com>
To:     "Dr. David Alan Gilbert" <dave@treblig.org>
Cc:     Blair Strater <strater@protonmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023, Dr. David Alan Gilbert wrote:
> * Blair Strater (strater@protonmail.com) wrote:
> > Per the request at https://lwn.net/Articles/940798/, I'm reaching out to
> > let you know that this patch breaks nested virtualization on AMD
> > processors.
> > 
> > I've tested 5.10.189 and 5.10.190 on the "outer" virtual host, and both
> > Debian 12 running libvirt, and Proxmox 7 as "inner" hosts. For Debian, the
> > nested VM fails to start at all, and consumes the entirety of one CPU core.
> > For Proxmox, 100-200MB/second of memory is allocated and never released,
> > and also the guest fails to start. The problems go away when taking the
> > outer host back to 5.10.188.
> > 
> > The processor in question is a Ryzen 7 2700. The kernel revision for
> > Proxmox is 5.15.108-1-pve, and the kernel revision for Debian 12 is
> > 6.1.0-11-amd64. I've run into another person who can confirm that this bug
> > also occurs in the 6.4 series, "somewhere between 6.4.3 and 6.4.9", 6.4.9
> > being the likely culprit.
> > 
> > Please let me know if you need any other information. 
> > 
> > I apologize for bothering an entire mailing list, Greg's email bot told me to.
> 
> cc'd in Vitaly (who I notice was working another regression bug in
> the recent stables), and Sean (who I notice has an L2 patch in the
> 5.10.189..190 set).

Does running with "spec_rstack_overflow=off" fix things for you?  If so, can you
then try testing the fix for the guest RFLAGS corruption[1]?  It's a bit of a long
shot, but I'm hoping we'll get lucky and all of these nested SVM errors[2] are
just weird symptoms of branches going awry.

[1] https://lore.kernel.org/all/20230811155255.250835-1-seanjc@google.com
[2] https://bugzilla.kernel.org/show_bug.cgi?id=217796
