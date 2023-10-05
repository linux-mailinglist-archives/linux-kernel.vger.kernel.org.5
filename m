Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447537BA757
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjJERJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjJERIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:08:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E6E47BA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:53:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b59e1ac70so17631937b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696524816; x=1697129616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WgW7kVDuz2dwRfbyuaJkQrKoMU08UEVmYCgpM2nqKLU=;
        b=2NLuRkaNvG+LG3R0vE3dkIbJsBZZ0g2ahux+W5dhb9EVNAtJ6napyF+d9C4d7N3Fva
         PhEg4mLjxz65SJ+H5IK9JkNlMwVjyVZrrRu2Dj0LBcNQAL3Mv/AgnlIe0ir8eP6nXYW/
         DPWfEscxTMLcYnFQW2+urjtm+PilbgdVkH48rjOev34DWXg1RZjd2owM2rzrjVKTjJI2
         Ei3PMBQGW3HiR8cbAdTd3Q0VElWiB7iA3HJx9GoGVnxfeMx6bB21OWaW+4sip62qcvC9
         i1+LV3KZ6pLjoVgmokUpaPj3g514vkSpaFJfGCI+gQWoB8Q8AH1QSS8G4LBOWCCqUpjX
         PdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696524816; x=1697129616;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgW7kVDuz2dwRfbyuaJkQrKoMU08UEVmYCgpM2nqKLU=;
        b=M7FTcULfpK8icgEKTOL7w/ndSDRQQ7tyRbhFNGSowYaptwwr63AB/iAYtPaFzIdk/E
         FVhcoCExGVPIDQnEIV8KkfWMCFHHNyD7wclw2BjLPGLsuDhQRfIaKXLYKSzJmxhUPFRB
         q1+JgN6mEsh5uB7+gT4cvs/wZ5m+ohp1d/yS8lL7uTkBLq1CO5GdMlbrFTGo57hBQNy2
         UcPF4sfcZSSCmj6QfGW65MjNovcZa/uNm7gY8d8S8Mh6MzgT3faj0I1qgDemT9Ibg6Se
         wReHDs5w+f3Lb42bWZLifD+cHU5/vSmJedcKQ22JprlZ9DdJNB0K9U6EH6lzztMFGASq
         41yg==
X-Gm-Message-State: AOJu0Yw6nofw34gYBKeet/wlsKLb6veBWBSlNXPtB/oqaispaDbc7zFx
        IPaahaVsbevGUsKLXNOl6WWOLxE=
X-Google-Smtp-Source: AGHT+IHztXCCIAMUhHtWjKjtB1IfIfbYVA+Qw3NnRFPC8dPmFb8jyAPyiWc851i2XRuEVTAMqONHNKw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:bd4e:0:b0:576:af04:3495 with SMTP id
 n14-20020a81bd4e000000b00576af043495mr98619ywk.9.1696524816321; Thu, 05 Oct
 2023 09:53:36 -0700 (PDT)
Date:   Thu, 5 Oct 2023 09:53:34 -0700
In-Reply-To: <20231005072137.29870-1-akihiko.odaki@daynix.com>
Mime-Version: 1.0
References: <20231005072137.29870-1-akihiko.odaki@daynix.com>
Message-ID: <ZR7qDgEZ9pyFDZ3K@google.com>
Subject: Re: [PATCH] bpf: Fix the comment for bpf_restore_data_end()
From:   Stanislav Fomichev <sdf@google.com>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05, Akihiko Odaki wrote:
> The comment used to say:
> > Restore data saved by bpf_compute_data_pointers().
> 
> But bpf_compute_data_pointers() does not save the data;
> bpf_compute_and_save_data_end() does.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Please use [PATCH bpf-next] (or bpf, depending on the tree) for bpf
patches in the future.

Acked-by: Stanislav Fomichev <sdf@google.com>
