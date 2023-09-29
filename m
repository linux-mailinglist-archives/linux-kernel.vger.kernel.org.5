Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157F87B3319
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjI2NKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjI2NKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:10:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C741AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:10:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c6052422acso135825ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695993029; x=1696597829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqsUDvMrMOqqFL7m1YQGMK07qbU6YXfwUB/IfzIJHSc=;
        b=uALQWr75WlH8dBHzgjwAckyzMtvJs48jR/Ul6XNWr7bOqTN8TjKSYNweboyF7FCYL9
         X76SVWPAtSH9pNBR4/AXYJ7M+AH2CCh8+BfjSt8b2JyiJaQvqrqXnvmjztbnc8x3p0qw
         otc772fXV/x9haeTZrkFjpcfHnVrptE+MfRSWpPKReG2yaCJAArrCXm3tHHLeLtTOSa0
         L/HBRpxAPwGu4s98FeZhcLFHwJdvHPNL2xGb9IsE779bGqgPR+PvN49w6RV8U4wQS2QT
         oUvmZfwCy4U4lWpOlqkH3KA2kc9Y7NcPbWTpXuLy1rVBPYKxHI6LjDpanJoWKWrrq3D8
         xIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695993029; x=1696597829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqsUDvMrMOqqFL7m1YQGMK07qbU6YXfwUB/IfzIJHSc=;
        b=daCmD4yXOEBla2/THHqlojccvr9h3tTPao2JGFeh1D7Ct5shGfFzMYoCMRYNxMISaF
         qQXWfiDd3gCFEOhesGkRzdsMjDjnmf1iZjJBiVFmd7UM/CS5j0celgM24hVw4FqkAmOp
         BK68C75sbAH2Mn6HOrNSq1PiSpiTiwsWYriC2558xrw0RqnBIUfUVtFZnzojAeippMXj
         q69qpDfw3a+TzwxXm5/OFe10fHoQEkSNeKUHGGKDzQ+uqsNiHlZNTX8zFQleXzz9fMwJ
         UPV2dtxFXYeGfGcJemlPc/MPlaFzP6nuODBkbxY9Rz4odeBxmTIzh7gjDk6lyrjbIW9y
         pgrQ==
X-Gm-Message-State: AOJu0Yzh6H070FiloL+kwsti1UDEI4GeDRbwN6KK1UgJQ4Wfcr191h/l
        034TXOettlsqs7ovnsWKyO43n2HSmuZ1eZ6c45bOqg==
X-Google-Smtp-Source: AGHT+IGa8YbOF0A0sMykEjT9fwajbe4gFnID97FG5oUvq2FBzNkVBTg2g/J63Q35Ro7fybey1Btr2vmzoE31FXbTm+k=
X-Received: by 2002:a17:903:32d0:b0:1bc:29c3:5895 with SMTP id
 i16-20020a17090332d000b001bc29c35895mr978436plr.0.1695993029313; Fri, 29 Sep
 2023 06:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230829234426.64421-1-tony.luck@intel.com> <20230928191350.205703-1-tony.luck@intel.com>
 <20230928191350.205703-4-tony.luck@intel.com>
In-Reply-To: <20230928191350.205703-4-tony.luck@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 29 Sep 2023 15:10:18 +0200
Message-ID: <CALPaoCgb35dGiC87e_cqTOXKKZ-nQcokWou+u=mC7m2gR36G8w@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] x86/resctrl: Prepare for different scope for
 control/monitor operations
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

Hi Tony,

On Thu, Sep 28, 2023 at 9:14=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
>
> @@ -352,7 +355,7 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struc=
t rdt_resource *r)
>  {
>         struct rdt_domain *d;
>
> -       list_for_each_entry(d, &r->domains, hdr.list) {
> +       list_for_each_entry(d, &r->ctrl_domains, hdr.list) {

If someone were to call get_domain_from_cpu() looking for a
mon_domain, I don't think they'd be happy with the result.

This problem seems adequately addressed by the next patch where a type
mismatch on the return value would result.

In any case, perhaps the name could be updated to set expectations better.


> @@ -549,44 +552,101 @@ static void domain_add_cpu(int cpu, struct rdt_res=
ource *r)
>
>         rdt_domain_reconfigure_cdp(r);
>
> -       if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> +       if (domain_setup_ctrlval(r, d)) {
>                 domain_free(hw_dom);
>                 return;
>         }
>
> -       if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom))=
 {
> +       list_add_tail(&d->hdr.list, add_pos);
> +
> +       err =3D resctrl_online_ctrl_domain(r, d);
> +       if (err) {
> +               list_del(&d->hdr.list);
>                 domain_free(hw_dom);
> +       }
> +}
> +
> +static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
> +{
> +       int id =3D get_domain_id_from_scope(cpu, r->mon_scope);
> +       struct list_head *add_pos =3D NULL;
> +       struct rdt_hw_domain *hw_mondom;

It's still hw_dom in domain_add_cpu_ctrl(), so why hw_mondom here?


> @@ -3711,16 +3711,16 @@ static void domain_destroy_mon_state(struct rdt_d=
omain *d)
>         kfree(d->mbm_local);
>  }
>
> -void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d=
)
> +void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_doma=
in *d)
>  {
>         lockdep_assert_held(&rdtgroup_mutex);
>
>         if (supports_mba_mbps() && r->rid =3D=3D RDT_RESOURCE_MBA)
>                 mba_sc_domain_destroy(r, d);
> +}
>
> -       if (!r->mon_capable)
> -               return;
> -
> +void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domai=
n *d)
> +{
>         /*
>          * If resctrl is mounted, remove all the
>          * per domain monitor data directories.

We did a lockdep_assert_held(&rdtgroup_mutex) for both types before.
Should we continue to do so here?


> --
> 2.41.0
>

In the resctrl2 prototype I complained that resctrl_resource was
awkwardly disjoint in its support for control and monitoring
groups[1]. In this patch, you seem to have already done most of the
hard work in separating the control and monitoring functionality, so
taking the next step and using a different structure to represent
control and monitoring resources would further improve the code by
statically typing monitoring and control resources, which would be
less error-prone than run-time checks on the alloc_capable and
mon_capable fields, which seem easy to forget.

I don't think this is necessary to complete SNC support, but it would
give me confidence that there isn't a misplaced {alloc,mon}_capable
check resulting in the wrong domain list being traversed. I will
probably do this myself later if you don't.

Thanks!
-Peter

[1] https://lore.kernel.org/all/CALPaoCj_oa=3DnATvOO_uysYvu+PdTQtd0pvssvm9_=
M1+fP-Z8JA@mail.gmail.com/
