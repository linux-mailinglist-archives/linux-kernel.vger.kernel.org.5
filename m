Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75997992F3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345341AbjIHX56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345340AbjIHX55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:57:57 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B3B18E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 16:57:50 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-26b10a6da80so3247197a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 16:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694217470; x=1694822270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7uIYG+nLope62BZraEl1dGlvLTb6/dt25z9HbvHirJU=;
        b=RH6Axu6Y1pjSyUp/Zw4+8evje5n4bam9iishYNEIOI4+OT7tQULSl3+Cq8nRNpF7jH
         JU5JZGAWcz/CsZtWmxcVVF3aRhUfOt+Nf+uAtLPRvN6M0dbQUEGUsTu3xyBFquS1zQMx
         SfXXhGAw69M9XvXxYrMz82s1i2aLM1xSgYT+9+GIN/fXF0JVDEagcNqUor3y3CWQ1Xbp
         xKnwrs0L9F82ou3qom5/EbMC7RHXdxQh+i3e3yTzLwWiaxWdY+jMQKgMVZszgeXPrHEq
         e14W84BBTABj0036OtXhkdQJPtre4qICgbM+a+qr80k0xp8yJrD2pqDciwZjRReJV0rV
         8KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694217470; x=1694822270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uIYG+nLope62BZraEl1dGlvLTb6/dt25z9HbvHirJU=;
        b=vJw9U8hvJuY17yPQIvOPvrBNrfWnxLpVjIQ7mwK/avWkeFcJjiJJ6W0zaY1zrGCfRS
         6MbflvpBQf8M+3FiGr7Ox4eFulQXjv0YJekDH/Y2TNjlvJasoQvzk6kQOIIJ0jAaQjkH
         /WLNphrZ8O0H9CQvaN2eOe+Kzh+lpkXBl+xOFDacZHFSPoMQCs8Y8XYpOvpDBmS9psbp
         ycYi9JghShoCy/M3Dc+GWMs5X0RIFoiUdQA/jJhWT9TzqoGMAfKN0sjBZ9SQLCDl/YpX
         4h5lQy2HY2Mes9iCPCm61uPzXFGtayuOJP8+SCzp/Zpu9IKk+CItLz4o9EzjgXDr0jdY
         QA+A==
X-Gm-Message-State: AOJu0YyavcHDpfyC1nUFVsnymwsXZ/nycXxyy7Gtu1KCQP1beZP2XuOi
        pFFD7KbAGctOAC75pZFiIzClreBIpp0=
X-Google-Smtp-Source: AGHT+IGOduCypdMHrewnjkwc2pJMM36JJvakmRjZ4E49rexv6nYdn4l7KvNQRhkbNt8CfLhwBJHI+gLk6Cs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:dc05:b0:26d:ae3:f6a4 with SMTP id
 i5-20020a17090adc0500b0026d0ae3f6a4mr981180pjv.5.1694217470364; Fri, 08 Sep
 2023 16:57:50 -0700 (PDT)
Date:   Fri, 8 Sep 2023 16:57:49 -0700
In-Reply-To: <20230829132727.ne5xzb7uv2wnrjif@amd.com>
Mime-Version: 1.0
References: <cover.1689893403.git.isaku.yamahata@intel.com>
 <21e488b6ced77c08d9e6718fcf57e100af409c64.1689893403.git.isaku.yamahata@intel.com>
 <ZLqVdvsF11Ddo7Dq@google.com> <20230722003449.664x3xcu6ydi2vrz@amd.com>
 <ZN/wY53TF2aOZtLu@google.com> <20230826005941.c7gtsootdaod7ek3@amd.com> <20230829132727.ne5xzb7uv2wnrjif@amd.com>
Message-ID: <ZPu0/fxg1E0Yi4Gt@google.com>
Subject: Re: [RFC PATCH v4 07/10] KVM: x86: Add gmem hook for initializing
 private memory
From:   Sean Christopherson <seanjc@google.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        linux-coco@lists.linux.dev,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Yuan Yao <yuan.yao@linux.intel.com>, David.Kaplan@amd.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023, Michael Roth wrote:
> So we need to be able to deal with that even for 'well-behaved' guests.
> With RMP-init-during-mapping-time approach I had some checks that avoided
> creating the 2MB RMP entry in this mixed case which is why I didn't need
> handling for this previously. But it's just one extra #NPF(RMP) and can
> be handled cleanly since it can be distinguished from spurious cases.

Just to make sure you're not waiting on me for something, the TL;DR is that my
suggestion is viable and not too horrific?
