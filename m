Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB3A7F32D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjKUPzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjKUPzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:55:35 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903C218C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:55:31 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5488bf9e193so4140467a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582130; x=1701186930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Dhh+jYPrKA9bHQpIhkyY8luyQfeiRtmNUIIuX4AcKs=;
        b=uMINHEBUTq/fwo4VkUmNdxg0/H3FieqoVm6BtN2gwx/6QVNTYe9+wDUPcvnZYLtXUW
         vWxEtbdbq20wAl+Xnx8EMTW/ofv/Go+JnqGJ8lkunIrzfyF8vgJlP0EKVBNVY8sNTq7W
         rz5ByJt7u7Glgg3GwbDvmCPrKDF1UtjGTRv6LXGnGVxAmcQZTkeusu6XlXzrv2TOk+mt
         D1VbnAMvvowsFmFGGxrpUq+xBBozsgia3/BHKIn0dbUVMOB1d3r/n1k4wDRxcn1aqoUH
         BgP42vlT7qY0ivfY31RGpyz5YAQlbGn9dVr/EIJcM7quGr+LHeCUj6KkNlcxJsMJe1gG
         t0Ag==
X-Gm-Message-State: AOJu0YyU7ClJJpbj5WHi4/JMMDqj3LTjlDgSv3ESkGI/7pzUOAV2d6Qt
        v+K16BiC2OSY1iqc6sfatfo=
X-Google-Smtp-Source: AGHT+IEGOjc9gVRMKuvMdXUVKpJvYT78Axx1hFaQ5Qe0Ixi0llhgONlsORxP2Hj7xjb7TX7KSbrldg==
X-Received: by 2002:a17:906:221c:b0:9c7:5a14:ecf2 with SMTP id s28-20020a170906221c00b009c75a14ecf2mr8928160ejs.56.1700582129853;
        Tue, 21 Nov 2023 07:55:29 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-014.fbsv.net. [2a03:2880:31ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id cm28-20020a170906f59c00b009fcb5fcfbe6sm3215439ejd.220.2023.11.21.07.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 07:55:29 -0800 (PST)
Date:   Tue, 21 Nov 2023 07:55:25 -0800
From:   Breno Leitao <leitao@debian.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 12/12] x86/bugs: Add a separate config for missing
 mitigation
Message-ID: <ZVzS7W8qNs5TKqfn@gmail.com>
References: <20231019181158.1982205-1-leitao@debian.org>
 <20231019181158.1982205-13-leitao@debian.org>
 <20231025162906.abnyb7xum7cpjwxy@treble>
 <ZTqdPc59HWBdP269@gmail.com>
 <20231109224356.diks3jws5ezfldzy@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109224356.diks3jws5ezfldzy@treble>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 02:43:56PM -0800, Josh Poimboeuf wrote:
> On Thu, Oct 26, 2023 at 10:09:17AM -0700, Breno Leitao wrote:
> > > I'm thinking CONFIG_MITIGATION_SPECTRE_V2 should also affect whether the spectre v2 user
> > > mitigation gets enabled.
> > 
> > Makes sense, would something like this be enough?
> 
> Looks good to me.
> 
> While you're at it, for consistency can you add a cpu_mitigations_off()
> check to spectre_v2_parse_user_cmdline()?

Good catch. I think we might want to do it in
`spectre_v2_user_select_mitigation()`, but let me test better and send it.

Since this is not dependent on this patch series, I will send this as an
idividual patch, to avoiding growing this patchset much (currently at 13
patches).

Thanks
