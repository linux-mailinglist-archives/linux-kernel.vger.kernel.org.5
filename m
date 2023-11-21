Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238F57F3947
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjKUWh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUWhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:37:55 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C51AC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:37:49 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5caa401f151so25116427b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700606269; x=1701211069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PhJ58DzGJEIVblaXAuceHul3/IImKCshOtqF3D3RDY=;
        b=G3pUW2bX8byqs35VWE2lNPVsBNcPlbaF5SlaScwyUrgiZSZs00xuRH+KAE+IEGFSEO
         iaMKubjto92VurzGn40vzoGHqbMnAyi1IEwwVT+TliIjIy9E+xnQhspWx1eYKR/PeMAX
         TDxIZpd6DUjkgW9Qgw/6ArBgbb7TlH7qK1AJoCjPXtW8BPEC4kXgSdVYK9KNSkJ/pPcQ
         4qixQneYFUV3fi5ukpH67Z0q/RN//VSyXW3MEgEz1xm8cgclFNDGHfccsjodCS8N9prM
         HWggSM4a45AxHT1/SM71jHFD2ku1cx41ruYKSRey7XXkvqxADsYeb7lOtMCs+VK9dQDy
         AfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700606269; x=1701211069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PhJ58DzGJEIVblaXAuceHul3/IImKCshOtqF3D3RDY=;
        b=FevycA4US1noCZnI+ri9+/9fM97zsD35YhK3o35L0bl5jwBcMjXB8FlEFDabGP7zjR
         TP6G4ur2DVyMU9bm8UKsPg0YoH/dsChYidV2piy47axdWcuYaT/HwHaLHPvDWA/9ANa0
         Bgo4j1Ay4NxJsY1XtCia4BjsatNdH4SVySa9kWw1VVPg+mBcRlWjCL34iaUFieiFboU5
         D/uVgR7i7epomBoCiaOig921S2O8NTPkwFVUoi2hcv4h4yqYavPWcNB4ugVqsRgIDYXz
         g6U3Y5WYbrIOLM37jvnDrIFQTb5NxlYuFahklQ2MMyRiA3Chcus2AYD2Wnvv1NpZSz01
         dC/w==
X-Gm-Message-State: AOJu0YwRYWRm8llNgDs3dw34ZbDCuedBnCcTgVRK+sEMEIj+LGUWRwVr
        frfmgouqEJfLJWkInw4WHQhQttgMGnK6gZOV/dFnHQ==
X-Google-Smtp-Source: AGHT+IFagDuyax0DNgWQWewr4Jl8bk+ehoQOtcabRwSIbmpcVEP0szwxg8PkrH2pRvlyeDOVm1B6JRdrl1GS+tzgroM=
X-Received: by 2002:a81:5b06:0:b0:5bf:f907:e07c with SMTP id
 p6-20020a815b06000000b005bff907e07cmr437425ywb.33.1700606269085; Tue, 21 Nov
 2023 14:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20231121175640.9981-1-mkoutny@suse.com>
In-Reply-To: <20231121175640.9981-1-mkoutny@suse.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Tue, 21 Nov 2023 17:37:37 -0500
Message-ID: <CAM0EoM=id7xo1=F5SY2f+hy8a8pkXQ5a0xNJ+JKd9e6o=--RQg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: cls: Load net classifier modules via alias
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>,
        Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 12:56=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
>
> The classifier modules may be loaded lazily without user's awareness and
> control. Add respective aliases to modules and request them under these
> aliases so that modprobe's blacklisting mechanism works also for
> classifier modules. (The same pattern exists e.g. for filesystem
> modules.)
>

Hi Michal,
Dumb question: What's speacial about the "tcf- '' that makes it work
better for filtering than existing "cls_" prefix? What about actions
(prefix "act_") etc?

cheers,
jamal

> Original module names remain unchanged.
>
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> ---
>  include/net/pkt_cls.h    | 1 +
>  net/sched/cls_api.c      | 2 +-
>  net/sched/cls_basic.c    | 1 +
>  net/sched/cls_bpf.c      | 1 +
>  net/sched/cls_cgroup.c   | 1 +
>  net/sched/cls_flow.c     | 1 +
>  net/sched/cls_flower.c   | 1 +
>  net/sched/cls_fw.c       | 1 +
>  net/sched/cls_matchall.c | 1 +
>  net/sched/cls_route.c    | 1 +
>  net/sched/cls_u32.c      | 1 +
>  11 files changed, 11 insertions(+), 1 deletion(-)
>
> This is primarily for TC subsystem maintainers where the
> request_module() resides but Cc list is large because of touches in
> various classifier modules.
>
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index a76c9171db0e..424b4f889feb 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -24,6 +24,7 @@ struct tcf_walker {
>
>  int register_tcf_proto_ops(struct tcf_proto_ops *ops);
>  void unregister_tcf_proto_ops(struct tcf_proto_ops *ops);
> +#define MODULE_ALIAS_TCF(kind) MODULE_ALIAS("tcf-" __stringify(kind))
>
>  struct tcf_block_ext_info {
>         enum flow_block_binder_type binder_type;
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 1976bd163986..02fdcceee083 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -257,7 +257,7 @@ tcf_proto_lookup_ops(const char *kind, bool rtnl_held=
,
>  #ifdef CONFIG_MODULES
>         if (rtnl_held)
>                 rtnl_unlock();
> -       request_module("cls_%s", kind);
> +       request_module("tcf-%s", kind);
>         if (rtnl_held)
>                 rtnl_lock();
>         ops =3D __tcf_proto_lookup_ops(kind);
> diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
> index a1f56931330c..a3500ac7fc1a 100644
> --- a/net/sched/cls_basic.c
> +++ b/net/sched/cls_basic.c
> @@ -328,6 +328,7 @@ static struct tcf_proto_ops cls_basic_ops __read_most=
ly =3D {
>         .bind_class     =3D       basic_bind_class,
>         .owner          =3D       THIS_MODULE,
>  };
> +MODULE_ALIAS_TCF("basic");
>
>  static int __init init_basic(void)
>  {
> diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> index 382c7a71f81f..8d57ac155c0c 100644
> --- a/net/sched/cls_bpf.c
> +++ b/net/sched/cls_bpf.c
> @@ -693,6 +693,7 @@ static struct tcf_proto_ops cls_bpf_ops __read_mostly=
 =3D {
>         .dump           =3D       cls_bpf_dump,
>         .bind_class     =3D       cls_bpf_bind_class,
>  };
> +MODULE_ALIAS_TCF("bpf");
>
>  static int __init cls_bpf_init_mod(void)
>  {
> diff --git a/net/sched/cls_cgroup.c b/net/sched/cls_cgroup.c
> index 7ee8dbf49ed0..0ded7d79894c 100644
> --- a/net/sched/cls_cgroup.c
> +++ b/net/sched/cls_cgroup.c
> @@ -209,6 +209,7 @@ static struct tcf_proto_ops cls_cgroup_ops __read_mos=
tly =3D {
>         .dump           =3D       cls_cgroup_dump,
>         .owner          =3D       THIS_MODULE,
>  };
> +MODULE_ALIAS_TCF("cgroup");
>
>  static int __init init_cgroup_cls(void)
>  {
> diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
> index 6ab317b48d6c..2806aa1254e1 100644
> --- a/net/sched/cls_flow.c
> +++ b/net/sched/cls_flow.c
> @@ -702,6 +702,7 @@ static struct tcf_proto_ops cls_flow_ops __read_mostl=
y =3D {
>         .walk           =3D flow_walk,
>         .owner          =3D THIS_MODULE,
>  };
> +MODULE_ALIAS_TCF("flow");
>
>  static int __init cls_flow_init(void)
>  {
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index e5314a31f75a..739e09e0fa57 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -3633,6 +3633,7 @@ static struct tcf_proto_ops cls_fl_ops __read_mostl=
y =3D {
>         .owner          =3D THIS_MODULE,
>         .flags          =3D TCF_PROTO_OPS_DOIT_UNLOCKED,
>  };
> +MODULE_ALIAS_TCF("flower");
>
>  static int __init cls_fl_init(void)
>  {
> diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
> index afc534ee0a18..86c833885a2d 100644
> --- a/net/sched/cls_fw.c
> +++ b/net/sched/cls_fw.c
> @@ -433,6 +433,7 @@ static struct tcf_proto_ops cls_fw_ops __read_mostly =
=3D {
>         .bind_class     =3D       fw_bind_class,
>         .owner          =3D       THIS_MODULE,
>  };
> +MODULE_ALIAS_TCF("fw");
>
>  static int __init init_fw(void)
>  {
> diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
> index c4ed11df6254..21ba73978c6a 100644
> --- a/net/sched/cls_matchall.c
> +++ b/net/sched/cls_matchall.c
> @@ -398,6 +398,7 @@ static struct tcf_proto_ops cls_mall_ops __read_mostl=
y =3D {
>         .bind_class     =3D mall_bind_class,
>         .owner          =3D THIS_MODULE,
>  };
> +MODULE_ALIAS_TCF("matchall");
>
>  static int __init cls_mall_init(void)
>  {
> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> index 12a505db4183..a4701c0752df 100644
> --- a/net/sched/cls_route.c
> +++ b/net/sched/cls_route.c
> @@ -671,6 +671,7 @@ static struct tcf_proto_ops cls_route4_ops __read_mos=
tly =3D {
>         .bind_class     =3D       route4_bind_class,
>         .owner          =3D       THIS_MODULE,
>  };
> +MODULE_ALIAS_TCF("route");
>
>  static int __init init_route4(void)
>  {
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index d5bdfd4a7655..a969adbd7423 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -1453,6 +1453,7 @@ static struct tcf_proto_ops cls_u32_ops __read_most=
ly =3D {
>         .bind_class     =3D       u32_bind_class,
>         .owner          =3D       THIS_MODULE,
>  };
> +MODULE_ALIAS_TCF("u32");
>
>  static int __init init_u32(void)
>  {
> --
> 2.42.1
>
