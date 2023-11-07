Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608D27E4618
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjKGQeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjKGQeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:34:05 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DC41BE9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:33:46 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so7848619a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 08:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699374825; x=1699979625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=okZTi3QPt1EZedqBEr+4XsBtcVuaiJVWhcPJEtm/9tE=;
        b=D+/nspwvYVLce/yvfNUaSmj02YAI063f3aDaU1fXidUMRAIwNzdihLLC+UOIoIN9K5
         Ton314Bw2i/Ffy5LUhr8TsvgbCn8lJ1vk2jp0JaRLTALxPApro3q5/VUpDuzNETwXL+S
         QIRGp5Qkm2Ci2z/bI9a5jrHG+SisqOnPTkfYWffTEMn4ebc+uBhLvHP5Qk0w3m9kc7oX
         TSmNTYG+PvnaekzpAmvlzAoaUcU0Kxkzf6XIbHP7XaP/6/xCwK3mWHcetK2/ZiisPDQW
         Hp+cadWpyJ6mvdbvDgsxeu5KCsjL17gRmYwxEom1McAnRqTKTl0yHY9kQw5T3d2wVDzE
         667w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699374825; x=1699979625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okZTi3QPt1EZedqBEr+4XsBtcVuaiJVWhcPJEtm/9tE=;
        b=wuVFU5mPePhhUYy7AY5e/UkvKW1OOrQudUftlVd+HQMA5OYS1EnaBSY8bpxZyvv0CG
         FOKOotuywNvHULIPIcB5x0L/CkX/PmnotLbHc5nkKo2KJUxxbrn20UgyznUbOc2qZvgo
         0jn+tY72FE5KSxz4aADuyPg7XXpJmyUbai8qpI7TMo/e6LA8eHTrh/6dXZAsZRrmHgNT
         UGJ5RIEQusMCpMtmBlXRIMrhM4FpSaxJvfLP92augHVh5SJyrxp5WhCLWGXhDX51fA+D
         HBtLVON9ahuRNOUnXEnSMLH1FpW7hgYJwbjxryveqaM/bOjYRO/Y4rC6ny5ej3nXY40f
         YZrw==
X-Gm-Message-State: AOJu0YwTq+rY812NAlOLxhMmBVRlEvB5M4SN77fvsahMYvnmK/Kfyrgy
        EtRSbgnXo8bpgT0N5EysX/+tYs6DctMfVL1OY0jM1A==
X-Google-Smtp-Source: AGHT+IHsOp3c+kFTp872VF69vaY/rHVB78j2KiHzCzyx8dollhdOdf1quKvoM1sxgT/x2ZpLaTQaJnEsvUpb412nmp8=
X-Received: by 2002:a17:906:4789:b0:9e2:8206:2ea9 with SMTP id
 cw9-20020a170906478900b009e282062ea9mr1800603ejc.60.1699374824826; Tue, 07
 Nov 2023 08:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20231104031303.592879-1-longman@redhat.com> <20231104031303.592879-3-longman@redhat.com>
 <CAJD7tkZirDce=Zq9bm_b_R=yXkj1OaqCe2ObRXzV-BtDc3X9VQ@mail.gmail.com>
 <2212f172-def9-3ec7-b3d7-732c2b2c365e@redhat.com> <CAJD7tkYmSAg_T289jRczARsXu2sCW0GrR9VPyL04fQRKzCK0hg@mail.gmail.com>
 <659cc4ae-ca1e-fd97-b6e5-211738f7b7b9@redhat.com>
In-Reply-To: <659cc4ae-ca1e-fd97-b6e5-211738f7b7b9@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 7 Nov 2023 08:33:05 -0800
Message-ID: <CAJD7tkaMCP__5qf2+hCogdperkYNgBFHtuKCUF1_Smu949e+hQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] cgroup/rstat: Optimize cgroup_rstat_updated_list()
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>>     *
> >>>>     * The only ordering guarantee is that, for a parent and a child pair
> >>>> - * covered by a given traversal, if a child is visited, its parent is
> >>>> - * guaranteed to be visited afterwards.
> >>>> + * covered by a given traversal, the child is before its parent in
> >>>> + * the list.
> >>>> + *
> >>>> + * Note that updated_children is self terminated while updated_next is
> >>>> + * parent cgroup terminated except the cgroup root which can be self
> >>>> + * terminated.
> >>> IIUC updated_children and updated_next is the same list.
> >>> updated_children is the head, and updated_next is how the list items
> >>> are linked. This comment makes it seem like they are two different
> >>> lists.
> >> Thanks for the comment. I will rework the comment to clarify that a bit
> >> more.
> >>> I am actually wondering if it's worth using the singly linked list
> >>> here. We are saving 8 bytes percpu, but the semantics are fairly
> >>> confusing. Wouldn't this be easier to reason about if you just use
> >>> list_head?
> >>>
> >>> updated_children would be replaced with LIST_HEAD (or similar), and
> >>> the list would be NULL terminated instead of terminated by self/parent
> >>> cgroup. IIUC the reason it's not NULL-terminated now is because we use
> >>> cgroup->updated_next to check quickly if a cgroup is on the list or
> >>> not. If we use list_heads, we can just use list_emtpy() IIUC.
> >>>
> >>> We can also simplify the semantics of unlinking @root from the updated
> >>> tree below, it would just be list_del() IIUC, which is actually more
> >>> performant as well. It seems like overall we would simplify a lot of
> >>> things. When forming the updated_list, we can just walk the tree and
> >>> splice the lists in the correct order.
> >>>
> >>> It seems to me that saving 8 bytes percpu is not worth the complexity
> >>> of the custom list semantics here. Am I missing something here?
> >> It will cost an additional 16 bytes of percpu memory if converted to
> >> list_heads. Like other lists, there will be sibling and children
> >> list_heads. There are also 2 pointers to update instead of one. Anyway,
> >> I don't have an objection to convert them to list_heads if agreed by Tejun.
> > Yes you are right. It's definitely not free, but it's also not super
> > costly. It's just that every time I look at the rstat code I need to
> > remind myself of how updated_next and updated_children work. I will
> > let Tejun decide.
>
> After further thought, changing it to list_head may not be possible with
> the current design since the actual linkage is like:
>
> update_next -> cgroup + cpu --> update_next --> ...
>
> So unless we change the design to link cgroup_rstat_cpu directly to each
> other for a given CPU, not via a cgroup intermediary, we will not be
> able to use list_head and the associated list_add() & list_del() macros.
> Direct linkage, however, requires a cgroup back pointer. So the real
> cost will be 24 bytes instead.

Yes you are right. Perhaps it's not worth it and it may not be as
simple as I thought. Please dismiss this suggestion, we'll have to
rely on comments for now to keep things clear.
