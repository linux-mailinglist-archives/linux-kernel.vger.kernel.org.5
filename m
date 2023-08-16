Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B76577EBB1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346482AbjHPVYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346528AbjHPVYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:24:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF061BE8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:24:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so4471a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692221044; x=1692825844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrksPXxxVccpYhmqxs/ARoxxpjrPkTuyFxc/g90sybA=;
        b=qAOngEMtao9z5SqEYvuvXl7MLkC/6byCdPHHV9QFr67CmXSn4wTPrRFjsxKGt3Hh5C
         y1xm4i9a1Sd05ylIxA6zUUf+wbJd3lhaEFfdE10TnFPNbQ+qsTsJFc1+HNawIVTeIHTX
         OoTRgKf5x+2hpSEsnLGOw0tso+/DRtcrURRQJ6Rj6JNWot9X/WfcS1L4pY2GANbLLL6x
         F1HaJqUelJQMA+b2HI/tPE7NCmU9+v5hsQ+L6tPDtBqrXEwWdtK+/UqPOaSO2DFYSKjj
         fM/RCs7lulq5Vu4wXs9UKsZUZu9lLllwzgiv732U4lrPGXa34dzThGR2i21v/QAhQ62G
         DJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692221044; x=1692825844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrksPXxxVccpYhmqxs/ARoxxpjrPkTuyFxc/g90sybA=;
        b=JdlirDvL/7F9s5iouRcoYpa0GfQbzflwakXXb4oxNniVKEHkNMJajhWeG71DfHMVHY
         jNEy5tRZLTc6e7wgKwOGzk3/N7rERRO6+bG81gJmJZHXYDgT2F7C0SzzlFU9ODTjUR7C
         zhcIfYzRW0eC8oJ2MsRTTaohwuzNs6I30rWwZ4IwhCfqeHlE7dsqfJddS327cKehY92t
         eE9Ufw8oR4dwkftPooxVRb3ELHB2s0Hpr/NuLNXP/Db7mWmkSuMajvxpkXvJDOYHElX6
         A0SJvDB9RwRiHkFP/pdPiuTyIV4/ovROYvO2fK1jiEg9oj0qgbQZlM3bEuZXT4IZooEq
         JVfA==
X-Gm-Message-State: AOJu0Yy3BsRuKD2MQjLboND13KnuohxpH12rUZX+mNyLrp7QJ3sJI8+e
        xkxkBOQCya5PX/HHL+KOwZozMFQop/R+TUHtcitOLk9jWlOsQI6+0J83Yg==
X-Google-Smtp-Source: AGHT+IH637pKau+sIWos2Ut7fFx9UJcGN+E77ZOWXtcebK3HSDW27vDv3lfjylRKaqkIu6sx8kBVSYjCiErq1hFz5jA=
X-Received: by 2002:a50:d781:0:b0:51e:16c5:2004 with SMTP id
 w1-20020a50d781000000b0051e16c52004mr34190edi.6.1692221044277; Wed, 16 Aug
 2023 14:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <12a12721-239b-457e-1ff7-f98c02cb7abe@intel.com>
 <20230816201700.589822-1-jmattson@google.com> <20230816211821.GUZN09HTGo+yQ2+jd7@fat_crate.local>
In-Reply-To: <20230816211821.GUZN09HTGo+yQ2+jd7@fat_crate.local>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 16 Aug 2023 14:23:52 -0700
Message-ID: <CALMp9eR1Ub78MZwdZn178d4OXPu3Au=faBgVGe6ty6ARV+nK8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/microcode/AMD: Load late on both threads too
To:     Borislav Petkov <bp@alien8.de>
Cc:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 2:18=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Wed, Aug 16, 2023 at 01:17:00PM -0700, Jim Mattson wrote:
> > Is there any way to tell that a microcode patch has been loaded on
> > only one thread?
>
> Only the example you see in the bugzilla link above.
>
> > And what does this mean for SEV-SNP attestation?
>
> More specifically? The CPUID page or microcode revision?

Specifically, "Security Version Numbers (SVNs) of the currently
executing platform firmware and microcode."

> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
