Return-Path: <linux-kernel+bounces-7445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC52781A7FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968FB284D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEEE48CE5;
	Wed, 20 Dec 2023 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CX2BX05B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4D48CEB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ba53596119so30874b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703107336; x=1703712136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7M+EVoJ16DU89VQpMb0LKO7rKszgnq4XMj9fYHecv0=;
        b=CX2BX05BWQcvuy6WkR719kdA19E0dWeUMJzX9+sxFIIgAK0TQN5M1QdPgVDnsm8Dms
         fLvELjm5obCd9Pje93pH3pAn58GouOEEnDXkHgcQIrYTX+Gf2VcJTPEhwMqNfLc1sT1c
         PrqVPjF9AMceTRspH0lp49TtAX5s2P98eVailaJUiCpm3fffkU/THNl/c16IJHcPpxfr
         RvD9eASkiBji6O6Imze/fpJDWK+kp/3oCf6AGO5nxJEq4Ax9ACdHahyf22htM3cFOcUS
         mJSKVq4MmMka//jDCtMyQlzfXGXGd5DP3Th5RcVvTCuguQklYSjU0e7UTx5XiLRPl68r
         s7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703107336; x=1703712136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7M+EVoJ16DU89VQpMb0LKO7rKszgnq4XMj9fYHecv0=;
        b=EoYJerBUIbcA5ECeGsnPSrQ7EZcHEK632PSzHz/RZJFp8GuBKBH4sEo1F6vI3dhHwo
         20H7b1Pwf+XolcUUs3MAeJGHRYv7FMAZ/l25OnUx/t2VTQ/wQztr8Gg0hGIV3Yu5mfoH
         5O+zueodquUlTPNUQyzPA052G6VmTdneVx3sMz89gIiNdWXME17qKMzIPQVkKSgEq07j
         0ZFzFpjtSgwlIZbYvRWoYGEN2j0CR3ayNAtEVHMEJF9gAlFzJR87q60M5Rkj2NchoTgJ
         oH175Y9ZN2PdCeIGhiIHfPxZyXaMI+hfYdbFxwHjwLjWdwdGvuaxkLIz+pk1i1XI3+xT
         Ky1w==
X-Gm-Message-State: AOJu0YzzjWqeGjrZaVElGRXvKXiwSOKXJz5xTu/3ZMQSQQMyICO9x2ti
	Y3C9H+c1HDkJzlnisS6s3rTCvj83g6KuOVgPrCvg
X-Google-Smtp-Source: AGHT+IEDXfq8yst7r+KrDxKeu6SC67rmstiKRMWt5hPNeL9YffdhDYaUxn3BqR+/qd//01jUo0dD1cOrLrDDct/h60E=
X-Received: by 2002:a05:6808:3027:b0:3b8:4406:c63 with SMTP id
 ay39-20020a056808302700b003b844060c63mr15261178oib.41.1703107335935; Wed, 20
 Dec 2023 13:22:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921061641.273654-1-mic@digikod.net> <20230921061641.273654-2-mic@digikod.net>
In-Reply-To: <20230921061641.273654-2-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 20 Dec 2023 16:22:05 -0500
Message-ID: <CAHC9VhQ3BNtG6y9gyKJiWrPCn81LpKG0Deep40GxAmUYCbem8w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/7] lsm: Add audit_log_lsm_data() helper
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Shervin Oloumi <enlightened@google.com>, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 2:16=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Extract code from common_dump_audit_data() into the audit_log_lsm_data()

Did you mean dump_common_audit_data()?  Assuming you correct the
function name above this looks fine to me.

Acked-by: Paul Moore <paul@paul-moore.com>

> helper. This helps reuse common LSM audit data while not abusing
> AUDIT_AVC records because of the common_lsm_audit() helper.
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  include/linux/lsm_audit.h |  2 ++
>  security/lsm_audit.c      | 26 +++++++++++++++++---------
>  2 files changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> index 97a8b21eb033..5f9a7ed0e7a5 100644
> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@ -122,6 +122,8 @@ int ipv4_skb_to_auditdata(struct sk_buff *skb,
>  int ipv6_skb_to_auditdata(struct sk_buff *skb,
>                 struct common_audit_data *ad, u8 *proto);
>
> +void audit_log_lsm_data(struct audit_buffer *ab, struct common_audit_dat=
a *a);
> +
>  void common_lsm_audit(struct common_audit_data *a,
>         void (*pre_audit)(struct audit_buffer *, void *),
>         void (*post_audit)(struct audit_buffer *, void *));
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 849e832719e2..58f9b8bde22a 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -189,16 +189,12 @@ static inline void print_ipv4_addr(struct audit_buf=
fer *ab, __be32 addr,
>  }
>
>  /**
> - * dump_common_audit_data - helper to dump common audit data
> + * audit_log_lsm_data - helper to log common LSM audit data
>   * @ab : the audit buffer
>   * @a : common audit data
> - *
>   */
> -static void dump_common_audit_data(struct audit_buffer *ab,
> -                                  struct common_audit_data *a)
> +void audit_log_lsm_data(struct audit_buffer *ab, struct common_audit_dat=
a *a)
>  {
> -       char comm[sizeof(current->comm)];
> -
>         /*
>          * To keep stack sizes in check force programmers to notice if th=
ey
>          * start making this union too large!  See struct lsm_network_aud=
it
> @@ -206,9 +202,6 @@ static void dump_common_audit_data(struct audit_buffe=
r *ab,
>          */
>         BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
>
> -       audit_log_format(ab, " pid=3D%d comm=3D", task_tgid_nr(current));
> -       audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(=
comm)));
> -
>         switch (a->type) {
>         case LSM_AUDIT_DATA_NONE:
>                 return;
> @@ -428,6 +421,21 @@ static void dump_common_audit_data(struct audit_buff=
er *ab,
>         } /* switch (a->type) */
>  }
>
> +/**
> + * dump_common_audit_data - helper to dump common audit data
> + * @ab : the audit buffer
> + * @a : common audit data
> + */
> +static void dump_common_audit_data(struct audit_buffer *ab,
> +                                  struct common_audit_data *a)
> +{
> +       char comm[sizeof(current->comm)];
> +
> +       audit_log_format(ab, " pid=3D%d comm=3D", task_tgid_nr(current));
> +       audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(=
comm)));
> +       audit_log_lsm_data(ab, a);
> +}
> +
>  /**
>   * common_lsm_audit - generic LSM auditing function
>   * @a:  auxiliary audit data
> --
> 2.42.0

--
paul-moore.com

