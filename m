Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCC67BA09D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbjJEOhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbjJEOet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:34:49 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774E55FF4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:54:31 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-351367c1c24so83015ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696514071; x=1697118871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ew9CTKew+cNKDMIx1MC3uW3wssgAAZXIEhM/ZHhaWJ0=;
        b=ZU/yLukFeVmcKvKlY+iMHuAbTYDvxfieDlgQsMpJ/l59yvkp7yp3qnirhhTDkKvEKN
         tlwszgrbeFMamHOPP6NyY2EEpNYvwqB8+trVCm5BuKNLgKw7NoyG8JAfAOJj2Uz0UlJf
         0h7yCoGtKHMHPgTTDJ6gEEHcR0teJh0m0R0qjoRYWdLgOEAgUL4yIAENpGZkp8xSkFpB
         6bk+tb2qxjhK5iqQoyeYM819rAx9HjozH6hC9y1Ywjvqoksk6jng7YGX/gjTIvIiW+mS
         TTOnpZvU9Sn64KSiB22apUS0HnYlFPh+9X+qemU6Cgnf/w5XzVmF2Dwi5sk7/EhzEfxi
         gntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696514071; x=1697118871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ew9CTKew+cNKDMIx1MC3uW3wssgAAZXIEhM/ZHhaWJ0=;
        b=HzEo3XKghkFiaEpmXzcBCdLj7B6uoLRyl7+wXm8cieqrBFbRNf3x0kn77VMVyOv2Ej
         0ULP+15E7Zk2P67drm1XAoLawGWkRjS1DFUEWvvCSOMIkVMaaM89gq19kIi3/3SNCw2k
         NXaf7MWuAokD52qonnwmyPEFYY+S4TMmMoifx2t7R3POfFzW6JLwOP4vRNC3HEZCkWtH
         9/gXimZXh81gqk5Kh2ScU0pVUzLX4vL4ylf3IiK7SUhnVItn6IBMlMsziLmXRFuDrjw1
         svYisEhW2C39Imkj3adTWWMsKKBlTMqr4YIKe6p/8a+WWaPJmKmEpya7m3eNHXlwgJ3T
         wYUg==
X-Gm-Message-State: AOJu0YwvSoLldetZwAmGTt/PHonODkv3cuHvfNl+pWjMJvj4MAY83IFG
        uwQD95y+aC/Cm+yW5cOJtmNdUBMoIRroh0+7FDwlsQ==
X-Google-Smtp-Source: AGHT+IEEpGtcQmmMc7Y4hT3qxAHVbBwnHipMfrrp4VL2FyrhIgPoNA5lg0uZ8fMpf6SuuSR8a5DqyNPv+lFAdbbSKeg=
X-Received: by 2002:a05:6e02:1aa7:b0:34c:b016:ede5 with SMTP id
 l7-20020a056e021aa700b0034cb016ede5mr104452ilv.26.1696514070717; Thu, 05 Oct
 2023 06:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230928191350.205703-1-tony.luck@intel.com> <20231003213043.13565-1-tony.luck@intel.com>
 <20231003213043.13565-9-tony.luck@intel.com>
In-Reply-To: <20231003213043.13565-9-tony.luck@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 5 Oct 2023 15:54:19 +0200
Message-ID: <CALPaoCh0BJSiMG5GjCsFYQDbrUO1q31VCpo403+A4EX0KkJ-TA@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
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

On Tue, Oct 3, 2023 at 11:30=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
>
> With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
> per-NODE instead of per-L3 cache. Suffixes of directories with "L3" in
> their name refer to Sub-NUMA nodes instead of L3 cache ids.
>
> Users should be aware that SNC mode also affects the amount of L3 cache
> available for allocation within each SNC node.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
>
> ---
>
> Changes since v5:
>
> Added addtional details about challenges tracking tasks when SNC
> mode is enabled.
>
> ---
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/=
resctrl.rst
> index cb05d90111b4..222c507089a5 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -345,9 +345,9 @@ When control is enabled all CTRL_MON groups will also=
 contain:
>  When monitoring is enabled all MON groups will also contain:
>
>  "mon_data":
> -       This contains a set of files organized by L3 domain and by
> -       RDT event. E.g. on a system with two L3 domains there will
> -       be subdirectories "mon_L3_00" and "mon_L3_01".  Each of these
> +       This contains a set of files organized by L3 domain or by NUMA
> +       node (depending on whether Sub-NUMA Cluster (SNC) mode is disable=
d
> +       or enabled respectively) and by RDT event.  Each of these
>         directories have one file per event (e.g. "llc_occupancy",
>         "mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
>         files provide a read out of the current value of the event for
> @@ -452,6 +452,23 @@ and 0xA are not.  On a system with a 20-bit mask eac=
h bit represents 5%
>  of the capacity of the cache. You could partition the cache into four
>  equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
>
> +Notes on Sub-NUMA Cluster mode
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +When SNC mode is enabled Linux may load balance tasks between Sub-NUMA
> +nodes much more readily than between regular NUMA nodes since the CPUs
> +on Sub-NUMA nodes share the same L3 cache and the system may report
> +the NUMA distance between Sub-NUMA nodes with a lower value than used
> +for regular NUMA nodes.  Users who do not bind tasks to the CPUs of a
> +specific Sub-NUMA node must read the "llc_occupancy", "mbm_total_bytes",
> +and "mbm_local_bytes" for all Sub-NUMA nodes where the tasks may execute
> +to get the full view of traffic for which the tasks were the source.
> +
> +The cache allocation feature still provides the same number of
> +bits in a mask to control allocation into the L3 cache. But each
> +of those ways has its capacity reduced because the cache is divided
> +between the SNC nodes. The values reported in the resctrl
> +"size" files are adjusted accordingly.
> +
>  Memory bandwidth Allocation and monitoring
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>

Sounds better, thanks.

Reviewed-by: Peter Newman <peternewman@google.com>
