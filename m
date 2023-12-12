Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1490180F797
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377225AbjLLULj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbjLLULh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:11:37 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B1CB9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:11:44 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d8029dae41so4650767a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702411903; x=1703016703; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSpKT6X5vMJAjLjsDkyxKCkmYJugXH+FCSpfLk33Dag=;
        b=w3+nC2sTKUpst0pdzpvnIoV5kGTc2uRE4Vuucg0vS69vjlRpsXz0aJGS24K3QieTcZ
         AX9R6d64JHIu8S1PcneYvxO6oFzpINvvOXRAhJ/+171kDih5Refpp1etlZjPuvzsJwff
         1rlXMJT+PwFDzGn7/pbnWluAuBNGCXHc9VDVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411903; x=1703016703;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSpKT6X5vMJAjLjsDkyxKCkmYJugXH+FCSpfLk33Dag=;
        b=c3Ht/U/mQ+JYvnkvahF+o2ZaaLHZM2aJ5PYltdxkocPRC3xOzNX/WfxfMsCOfnxA8G
         lOISfJBzgtfiVPvNVIWQzXiFX7C3OO3jThWqjEMlte2pQodf1HhxgQm7NYu87Mk80O0S
         gKZ9LlhcZawEUHPgtFFuCgplorYiZEBstFQOXWsigr2hORD9rENWC0o/RiFfQ49Cog53
         sD1q4mbkIIwlX5AVfM50oxrtKBOBjmj773f1pGpMHi8moD8ZA2m29ovymFYUmLBDZGUg
         VgpQ3gPmWubw14BG8FXJl7ns0T3pjaXdZ7nkot83O3KYb1PbWGbMKLJJHysEYTRtuuHC
         UHrg==
X-Gm-Message-State: AOJu0YxiEH4I4uiryv6Jx2sm9Led8kwqAuno26PjGlaObGAU6RefOOcQ
        PA4kWGDOvJzHH90UFcmJnjSVTw==
X-Google-Smtp-Source: AGHT+IE5S1fvGPn9EKUZ+1JtyTMNdFA2PaNO7RccXcSqXTbQmBN/G2PQajwXlMyvPoZxXyZvUGQNfw==
X-Received: by 2002:a9d:7384:0:b0:6d8:567d:ed18 with SMTP id j4-20020a9d7384000000b006d8567ded18mr6200200otk.7.1702411903442;
        Tue, 12 Dec 2023 12:11:43 -0800 (PST)
Received: from smtpclient.apple ([185.189.25.71])
        by smtp.gmail.com with ESMTPSA id da15-20020a0568306a8f00b006ce28044207sm118360otb.58.2023.12.12.12.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 12:11:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] srcu: Improve comments about acceleration leak
Date:   Tue, 12 Dec 2023 15:11:30 -0500
Message-Id: <48B36383-8849-4F52-8882-3B98AD0B9AF7@joelfernandes.org>
References: <20231211015717.1067822-1-joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>, rcu@vger.kernel.org
In-Reply-To: <20231211015717.1067822-1-joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 10, 2023, at 8:57 PM, Joel Fernandes (Google) <joel@joelfernandes.o=
rg> wrote:
>=20
> =EF=BB=BFThe comments added in commit 1ef990c4b36b ("srcu: No need to
> advance/accelerate if no callback enqueued") are a bit confusing to me.
> The comments are describing a scenario for code that was moved and is
> no longer the way it was (snapshot after advancing). Improve the code
> comments to reflect this and also document by acceleration can never
> fail.
>=20
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Do we want to quick review and put it in Neeraj PR?

Or next merge window ok with me. Just that then I have to keep track of it ;=
-)

Thanks,

- Joel=20



> ---
> v1->v2: Fix typo in change log.
>=20
> kernel/rcu/srcutree.c | 24 ++++++++++++++++++++----
> 1 file changed, 20 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 0351a4e83529..051e149490d1 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1234,11 +1234,20 @@ static unsigned long srcu_gp_start_if_needed(struc=
t srcu_struct *ssp,
>    if (rhp)
>        rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
>    /*
> -     * The snapshot for acceleration must be taken _before_ the read of t=
he
> -     * current gp sequence used for advancing, otherwise advancing may fa=
il
> -     * and acceleration may then fail too.
> +     * It's crucial to capture the snapshot 's' for acceleration before
> +     * reading the current gp_seq that is used for advancing. This is
> +     * essential because if the acceleration snapshot is taken after a
> +     * failed advancement attempt, there's a risk that a grace period may=

> +     * conclude and a new one may start in the interim. If the snapshot i=
s
> +     * captured after this sequence of events, the acceleration snapshot '=
s'
> +     * could be excessively advanced, leading to acceleration failure.
> +     * In such a scenario, an 'acceleration leak' can occur, where new
> +     * callbacks become indefinitely stuck in the RCU_NEXT_TAIL segment.
> +     * Also note that encountering advancing failures is a normal
> +     * occurrence when the grace period for RCU_WAIT_TAIL is in progress.=

>     *
> -     * This could happen if:
> +     * To see this, consider the following events which occur if
> +     * rcu_seq_snap() were to be called after advance:
>     *
>     *  1) The RCU_WAIT_TAIL segment has callbacks (gp_num =3D X + 4) and t=
he
>     *     RCU_NEXT_READY_TAIL also has callbacks (gp_num =3D X + 8).
> @@ -1264,6 +1273,13 @@ static unsigned long srcu_gp_start_if_needed(struct=
 srcu_struct *ssp,
>    if (rhp) {
>        rcu_segcblist_advance(&sdp->srcu_cblist,
>                      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
> +        /*
> +         * Acceleration can never fail because the state of gp_seq used
> +         * for advancing is <=3D the state of gp_seq used for
> +         * acceleration. This means that RCU_NEXT_TAIL segment will
> +         * always be able to be emptied by the acceleration into the
> +         * RCU_NEXT_READY_TAIL or RCU_WAIT_TAIL segments.
> +         */
>        WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s));
>    }
>    if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
> --=20
> 2.43.0.472.g3155946c3a-goog
>=20
