Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F93A80ABD4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbjLHSPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbjLHSO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:14:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24E5212A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702059266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KlSM/zpPbN5WwWA6OTGpQyhIkatTXb5IjuU41HMpNgA=;
        b=doYbvatKTUIUX7u1FuHCBgmgJfYpi7ls6Y71WjnaMXqjNJkty4AKVQZmAKWeVJC/wqQAxy
        SgilN53k//t4cpCsjhL+VwjOBXXAQXCL8nsr82u8xsUHEIRSFOVirJqmdEHVX08by9w5WW
        Y8/R2mcnuRRkiw7GYVfCwmQndR0Btbk=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-EwF9rh8fMVKA3vqIYaYV_g-1; Fri, 08 Dec 2023 13:14:24 -0500
X-MC-Unique: EwF9rh8fMVKA3vqIYaYV_g-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6d9dc6718f4so2564767a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059263; x=1702664063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlSM/zpPbN5WwWA6OTGpQyhIkatTXb5IjuU41HMpNgA=;
        b=Ut7nfNlADVqzowpRpH0qfTwm/fDhG+qgSSkhUwmM+9MykHh+Ke+3UmYnEGl7Af+lZb
         T/81L3qh2AkqivXCfzBk+bWweUH1BWMudEaHtlc4ELfDskXKafBEV8SYDOWAUmMlbx+m
         ZVsOTd4H7Adz4+xzXdVYqsEmcXWomRVumLbp+HtPTKqG8nmKDat79p7wGjN++GVmQQsu
         Iah77Q4iPyTiAJz+/Xcez465iCIwwuJ24WYzy0W3sChICGzbMM0l+ouyrFTu+jFpgrRx
         2T0hZ3CJkxzNhw1Ot2RlDfyqueb/wiDk1E7BqHI4flzjjeNkKCmoy8ipilHmJ//qIeZe
         +0kw==
X-Gm-Message-State: AOJu0YxH3d9L0ks+qcZdn4HiruiPdfXuLqAUB0qC7xm/73f2CZHE4lxG
        xtHIW8lcWrUzOr4JaIKNTbHXfJg2edQQ/VqE3/x0pIi0CYK7xsIFPX5L2oQURGOwuXZHa+Q5LZ4
        dqchi4HU1W++KXkUmnogoU5RFQlY2tx+sRA68ciKo
X-Received: by 2002:a05:6870:44d3:b0:1fb:19b5:407d with SMTP id t19-20020a05687044d300b001fb19b5407dmr532225oai.61.1702059263608;
        Fri, 08 Dec 2023 10:14:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7AOACg3Lf1P9LtBQJnAsa//zi6y83Gtz28lS3HGdoEbMv7ZG8U5H36GSXA/O8Y6UBe2eDB9XKjKRDH8PflPw=
X-Received: by 2002:a05:6870:44d3:b0:1fb:19b5:407d with SMTP id
 t19-20020a05687044d300b001fb19b5407dmr532218oai.61.1702059263360; Fri, 08 Dec
 2023 10:14:23 -0800 (PST)
MIME-Version: 1.0
References: <20231208020734.1705867-1-seanjc@google.com>
In-Reply-To: <20231208020734.1705867-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 8 Dec 2023 19:14:11 +0100
Message-ID: <CABgObfYbWUy5Bvpnr3a+atE5Pyk72jnY8ynkdw7_cJ8_7A1raQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Fixes for 6.7-rcN
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 3:07=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Please pull a handful of fixes for 6.7-rcN (hopefully N=3D5).  These have=
 all
> been in -next for a week or so.
>
> The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbeb=
fa:
>
>   Linux 6.6 (2023-10-29 16:31:08 -1000)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.7-rcN
>
> for you to fetch changes up to ef8d89033c3f1f6a64757f066b2c17e76d1189f8:
>
>   KVM: x86: Remove 'return void' expression for 'void function' (2023-12-=
01 08:14:27 -0800)

Pulled, thanks.

Paolo

