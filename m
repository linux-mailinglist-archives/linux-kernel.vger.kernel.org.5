Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C880ABCE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574494AbjLHSO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbjLHSOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:14:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458F82D6A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702059214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=thkLXVvi4ESeehaUbk7FHcY7MvVf7sRDiGhqTuUD1bw=;
        b=IJlS8vYpxtvx9lMjD17SnflauDwiG/V/XgrfwB8TSRHkfrpXqpdOnJzwx7AW4FsERM9xui
        hxJovqYCpLix/bDSozbcRKbSAHmMqLbYBuFZpJvmjJIEMktflMA+/YfR7bofnNaml6GMH3
        6/rSMmoPPL7Tzlj9dDURmBL6CXGG/Hw=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-QQCBFAVHOcaW4saMV54ukQ-1; Fri, 08 Dec 2023 13:13:32 -0500
X-MC-Unique: QQCBFAVHOcaW4saMV54ukQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1f9fdbb8521so3963127fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059212; x=1702664012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thkLXVvi4ESeehaUbk7FHcY7MvVf7sRDiGhqTuUD1bw=;
        b=rcBhJbW7AqXXdwnyTZx4fKAIq89104gCnlMOz/KpfCMkjHHt8i7GZZ2RLBGrobhaJg
         RgQkCIsbfJY97j9XdO6MgjOkWs1GqmYSWJFSS1KL+L0xU/VtgssatJbllarSJBb4onB9
         Z4+6rbVrtvLJ5J6VJmMBtROHjaFlrVYETNNaR/VrmaJkY9VXI5dk2z6LMgLsW+VNA88A
         qoyrhx+SrS+gI2YRPlEpKQ3KCF2QHweB13DQxwQYF93NRKfdWeovmFXmGE5SB9KmMlIk
         0Nt330YUHyvG41hnu4Oyynlyw6ODdE9oVXS85e6dlHDGizrzjfykBPMU4oC+0CFltBaW
         ZOOw==
X-Gm-Message-State: AOJu0YwYFh1iMDIfan+8c7KZSOQPXwmTHXL99b7lpfp34oNX36lGqrx0
        OsFLpf0LVU6r/l6jcBY3XtNBLdsjNrc/BQkBaHTDRkDJ+LBBJ8V/eeIpU5lwzO30j5DtG0Aub3I
        DRgEq88n1BlHwYxZAIm3VHSRDusxmmIynNKXDAfJH
X-Received: by 2002:a05:6870:9d0e:b0:1fb:75a:6d3a with SMTP id pp14-20020a0568709d0e00b001fb075a6d3amr514105oab.97.1702059211863;
        Fri, 08 Dec 2023 10:13:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFm4qEiQ8h/zEqW68UsgEFDDQ1CGBXnQu7hSfvylqpZk9GjGB2KlkuB5RxbvYYtZ8eZbfTt4oXKVMMdArXHtU0=
X-Received: by 2002:a05:6870:9d0e:b0:1fb:75a:6d3a with SMTP id
 pp14-20020a0568709d0e00b001fb075a6d3amr514096oab.97.1702059211668; Fri, 08
 Dec 2023 10:13:31 -0800 (PST)
MIME-Version: 1.0
References: <20231115125111.28217-1-imbrenda@linux.ibm.com>
In-Reply-To: <20231115125111.28217-1-imbrenda@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 8 Dec 2023 19:13:19 +0100
Message-ID: <CABgObfYt3VH-zPwT1whA0N7uE2ioq9GznTt-QhnES8B5tX76jQ@mail.gmail.com>
Subject: Re: [GIT PULL v1 0/2] KVM: s390: two small but important fixes
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 1:51=E2=80=AFPM Claudio Imbrenda <imbrenda@linux.ib=
m.com> wrote:
>
> Hi Paolo,
>
> two small but important fixes, please pull :)

Done, thanks.

Paolo

>
> Claudio
>
>
>
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa=
86:
>
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-master-6.7-1
>
> for you to fetch changes up to 27072b8e18a73ffeffb1c140939023915a35134b:
>
>   KVM: s390/mm: Properly reset no-dat (2023-11-14 18:56:46 +0100)
>
> ----------------------------------------------------------------
> Two small but important bugfixes.
>
> ----------------------------------------------------------------
> Claudio Imbrenda (2):
>       KVM: s390: vsie: fix wrong VIR 37 when MSO is used
>       KVM: s390/mm: Properly reset no-dat
>
>  arch/s390/kvm/vsie.c   | 4 ----
>  arch/s390/mm/pgtable.c | 2 +-
>  2 files changed, 1 insertion(+), 5 deletions(-)
>
> --
> 2.41.0
>

