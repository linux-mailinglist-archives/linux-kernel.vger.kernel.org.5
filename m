Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FDC798C4C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbjIHSMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240962AbjIHSMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:12:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706491FE0;
        Fri,  8 Sep 2023 11:11:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5007abb15e9so3985358e87.0;
        Fri, 08 Sep 2023 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694196628; x=1694801428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnmEl4KyXVNXCoUs0zYmwBlncZkljIFewXcIIO3f3ak=;
        b=ffse5cymHWOpaBgL3r2bEMsg6iYQvn4dpjW244ZZagMuNFy5merX9Sz242Cc6rVWm3
         eb161CBeCDOqD0/dnk7IpmxM1dFSC/oC+d0kb+SmMmLyYJ6LskH7rCsO0Lw8jmpOT1A9
         tkQigSV39Zuy7y2M8rInHfeHyshWTlfkvHOOclZjOLZCqjGqeJ46mX6xtMt/YywGk2CB
         5L30Ej8D1313ZDUlYvcJHf48go8uxaGNORbOCKHOVlE18LGps5oWPm/22z0heeU8vjLh
         I1kiWRlJNDSU3qttaPIBji8AeTUtM9ZudqHxBq2wtwN92umZnT5FwqlI0AIjm8sVn83J
         gH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694196628; x=1694801428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnmEl4KyXVNXCoUs0zYmwBlncZkljIFewXcIIO3f3ak=;
        b=T+sGSw8XVYY0oG84vChFhaQMx7s57IUmbjJlWGZxv4oZuLxz5EyKLpYkie0iOOAuRi
         pMZOG4pFzey+/zt0kyoErX3ovL8pahp5oO1UkHzzmstDEnBow4WsAc1nf/G/l8aqiI79
         NwZbrSPcGr1gCpVxpdu9d20DVSS3gXjgPar6ieIGjgJnT4UAW6lezYlgoJ7sKfoBl6RB
         l1BGHgAPOPZWFdK77FqRPrVtIon4hKnnQgTt8cJmD0liuiXVWgiyQXKa2B12pVjzXiFk
         yp1Zy9BX7KCS5k7YIY6wjmc4l2mRvpzP17H8uTvU1YWN+qRUmffQmdnx8EqXGfpgLpjU
         /2iw==
X-Gm-Message-State: AOJu0YzOYRwzs4FClgkcUrUKi/ZnjYZAKIU0rBY5EoQXF8waF9NUPMbL
        VUmR0uLO3cddqie73/sdiE0kfNE+sj/5XT6oNw8=
X-Google-Smtp-Source: AGHT+IGsZfh4uCGCydsS8kCV/+zVd+gVAO+sK1Ar57wt+9JpX/FtXdyO89EnYDrCGiwjXPPoryLT9wWK4mFwQ4ak6YI=
X-Received: by 2002:a05:6512:1112:b0:500:78ee:4cd7 with SMTP id
 l18-20020a056512111200b0050078ee4cd7mr2963845lfg.23.1694196627279; Fri, 08
 Sep 2023 11:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
 <20230827072057.1591929-3-zhouchuyi@bytedance.com> <CAADnVQLKytNcAF_LkMgMJ1sq9Tv8QMNc3En7Psuxg+=FXP+B-A@mail.gmail.com>
 <e5e986a0-0bb9-6611-77f0-f8472346965e@bytedance.com> <CAADnVQL-ZGV6C7VWdQpX64f0+gokE5MLBO3F2J3WyMoq-_NCPg@mail.gmail.com>
 <c24a5de1-33c6-0469-9902-27292660654e@bytedance.com>
In-Reply-To: <c24a5de1-33c6-0469-9902-27292660654e@bytedance.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 8 Sep 2023 11:10:16 -0700
Message-ID: <CAADnVQKu+a6MKKfJy8NVmwtpEw1ae-_8opsGjdvvfoUjwE1sog@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/4] bpf: Introduce process open coded
 iterator kfuncs
To:     Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 7, 2023 at 5:02=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com>=
 wrote:
>
> Hello,
> =E5=9C=A8 2023/9/7 01:17, Alexei Starovoitov =E5=86=99=E9=81=93:
> [...cut...]
> >>> This iter can be used in all ctx-s which is nice, but let's
> >>> make the verifier enforce rcu_read_lock/unlock done by bpf prog
> >>> instead of doing in the ctor/dtor of iter, since
> >>> in sleepable progs the verifier won't recognize that body is RCU CS.
> >>> We'd need to teach the verifier to allow bpf_iter_process_new()
> >>> inside in_rcu_cs() and make sure there is no rcu_read_unlock
> >>> while BPF_ITER_STATE_ACTIVE.
> >>> bpf_iter_process_destroy() would become a nop.
> >>
> >> Thanks for your review!
> >>
> >> I think bpf_iter_process_{new, next, destroy} should be protected by
> >> bpf_rcu_read_lock/unlock explicitly whether the prog is sleepable or
> >> not, right?
> >
> > Correct. By explicit bpf_rcu_read_lock() in case of sleepable progs
> > or just by using them in normal bpf progs that have implicit rcu_read_l=
ock()
> > done before calling into them.
> Thanks for your explanation, I missed the latter.
> >
> >> I'm not very familiar with the BPF verifier, but I believe
> >> there is still a risk in directly calling these kfuns even if
> >> in_rcu_cs() is true.
> >>
> >> Maby what we actually need here is to enforce BPF verifier to check
> >> env->cur_state->active_rcu_lock is true when we want to call these kfu=
ncs.
> >
> > active_rcu_lock means explicit bpf_rcu_read_lock.
> > Currently we do allow bpf_rcu_read_lock in non-sleepable, but it's poin=
tless.
> >
> > Technically we can extend the check:
> >                  if (in_rbtree_lock_required_cb(env) && (rcu_lock ||
> > rcu_unlock)) {
> >                          verbose(env, "Calling
> > bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
> >                          return -EACCES;
> >                  }
> > to discourage their use in all non-sleepable, but it will break some pr=
ogs.
> >
> > I think it's ok to check in_rcu_cs() to allow bpf_iter_process_*().
> > If bpf prog adds explicit and unnecessary bpf_rcu_read_lock() around
> > the iter ops it won't do any harm.
> > Just need to make sure that rcu unlock logic:
> >                  } else if (rcu_unlock) {
> >                          bpf_for_each_reg_in_vstate(env->cur_state,
> > state, reg, ({
> >                                  if (reg->type & MEM_RCU) {
> >                                          reg->type &=3D ~(MEM_RCU |
> > PTR_MAYBE_NULL);
> >                                          reg->type |=3D PTR_UNTRUSTED;
> >                                  }
> >                          }));
> > clears iter state that depends on rcu.
> >
> > I thought about changing mark_stack_slots_iter() to do
> > st->type =3D PTR_TO_STACK | MEM_RCU;
> > so that the above clearing logic kicks in,
> > but it might be better to have something iter specific.
> > is_iter_reg_valid_init() should probably be changed to
> > make sure reg->type is not UNTRUSTED.
> >
> Maybe it's something looks like the following?
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bb78212fa5b2..9185c4a40a21 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1172,7 +1172,15 @@ static bool is_dynptr_type_expected(struct
> bpf_verifier_env *env, struct bpf_reg
>
>   static void __mark_reg_known_zero(struct bpf_reg_state *reg);
>
> +static bool in_rcu_cs(struct bpf_verifier_env *env);
> +
> +/* check whether we are using bpf_iter_process_*() or bpf_iter_css_*() *=
/
> +static bool is_iter_need_rcu(struct bpf_kfunc_call_arg_meta *meta)
> +{
> +
> +}
>   static int mark_stack_slots_iter(struct bpf_verifier_env *env,
> +                                struct bpf_kfunc_call_arg_meta *meta,
>                                   struct bpf_reg_state *reg, int insn_idx=
,
>                                   struct btf *btf, u32 btf_id, int nr_slo=
ts)
>   {
> @@ -1193,6 +1201,12 @@ static int mark_stack_slots_iter(struct
> bpf_verifier_env *env,
>
>                  __mark_reg_known_zero(st);
>                  st->type =3D PTR_TO_STACK; /* we don't have dedicated re=
g
> type */
> +               if (is_iter_need_rcu(meta)) {
> +                       if (in_rcu_cs(env))
> +                               st->type |=3D MEM_RCU;
> +                       else
> +                               st->type |=3D PTR_UNTRUSTED;
> +               }
>                  st->live |=3D REG_LIVE_WRITTEN;
>                  st->ref_obj_id =3D i =3D=3D 0 ? id : 0;
>                  st->iter.btf =3D btf;
> @@ -1281,6 +1295,8 @@ static bool is_iter_reg_valid_init(struct
> bpf_verifier_env *env, struct bpf_reg_
>                  struct bpf_stack_state *slot =3D &state->stack[spi - i];
>                  struct bpf_reg_state *st =3D &slot->spilled_ptr;
>
> +               if (st->type & PTR_UNTRUSTED)
> +                       return false;


Yep. All makes sense to me.
