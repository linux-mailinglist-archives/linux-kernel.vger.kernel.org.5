Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5B67BBBBE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjJFP30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjJFP3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:29:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49E39E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:29:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so395288666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696606161; x=1697210961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cD6gqE9wLzIObdl4Oq4iAMcgyVfcohG8ZeVFpOmlfzk=;
        b=XRZr7C+OwA1Vm8TtuWrTAXT6Wowo7Vd1CvJmk+C+m/LflKi/6qNJTmgwHpj35ZjA17
         y0nprBUXm0WD757ZiNSz8MaZdprvFUYsWMjQQ4y7/BVkZ3yvjR224Sh470KeKuJezxBL
         u8WvrAd5pWcNF7gA3H9A9T81UIwih2Qd5ssP/NDDGZn7HkFG8t6i3RmdjPzpOjbNlNDZ
         RoAsVDeuGJCF7MbOc7ZWDguZVUY1Pd+l94XNLGz3WxUbV/Tt5Ep/JuZ5hD1bs97oFL23
         ZBPAG2jGcnRF8AjlurmFEdomC1+y2qMXFTs0RLkOA7DhvVwjUtyXZiTi9MPwstkOyO3Y
         gPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606161; x=1697210961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cD6gqE9wLzIObdl4Oq4iAMcgyVfcohG8ZeVFpOmlfzk=;
        b=DmPmVOddwdV93lHWXhvGQF1iQQ7vQ2G9Rcbu1fguRTyq3GBF0Nh3WNy6iFMXfP0H/k
         37OkMvt9Fw+1Euvm2l1VFUgpWG/RN3oB5vqkx6fOA4NmyX4Ud7uAEdPqc/v6AXSvxClG
         TbmNsE3/LkE5tnvWMiLjp5yMTnHAVqUygP2ykzL4gTLcjQFeqD+GiIJe/YSGY4zP0Q3Z
         NF0+sZ1PotcRkfjmlWTZLEo/RPR8K2tO49rQ84IUDfTXLhg4h6/ue7l6boE4fx2BJRKL
         2ZBXcmy4li0uqmjxM+uRnym8LM4VwL6gH2XBEh/I5fVUUnPwOZDzTrZaa4XVV8EDG4V8
         DaKw==
X-Gm-Message-State: AOJu0YwyBZGgS74SAZLBhIpW0HYVWHLat6Fdz5QZLF1KP7fHA8FeJBzs
        g9Yh8A7BRP+MrEoeJBssyYjRb01dxCqh4EO8fo3K8Q==
X-Google-Smtp-Source: AGHT+IF6dWBphU3snU5NSV++L5WlWEuTsexP1k7xRF5HXc/3O4Uqoy1SgeZ+U1no13E8Sr7vkJ2sLc5Nk+9sfxwbXFA=
X-Received: by 2002:a17:906:da:b0:9ae:5253:175b with SMTP id
 26-20020a17090600da00b009ae5253175bmr7400722eji.34.1696606161212; Fri, 06 Oct
 2023 08:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231006011255.4163884-1-vannapurve@google.com> <0f97dc87e18fccbca6663225f11f47bc1a927ad4.camel@intel.com>
In-Reply-To: <0f97dc87e18fccbca6663225f11f47bc1a927ad4.camel@intel.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Fri, 6 Oct 2023 08:29:09 -0700
Message-ID: <CAGtprH9ugb+MvHP59pvwbppTRCBvX4G6Yb0MgM7rr8uzNXEBGg@mail.gmail.com>
Subject: Re: [PATCH] x86/tdx: Override the tsc calibration for TDX VMs
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "Shahar, Sagi" <sagis@google.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 3:43=E2=80=AFAM Huang, Kai <kai.huang@intel.com> wro=
te:
>
>
> >
> > +/**
> > + * Determine TSC frequency via CPUID, else return 0.
> > + */
>
> Nit: looks you don't need the k-doc style comment here?
>

Ack, will remove/update this comment in the next version.
