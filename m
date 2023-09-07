Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DD5797A85
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbjIGRnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245439AbjIGRmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:42:54 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AACE1FE2;
        Thu,  7 Sep 2023 10:42:32 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bb07d274feso841148a34.0;
        Thu, 07 Sep 2023 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694108538; x=1694713338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yI6bGEdU/7x6FXH5RWf2k+HtyEHZh0STqI6FnUAdGU8=;
        b=GGLwGV6ChzRJsT5wSoIpraPeOS5ophPAHpEe4RVmRmqzuQpHREhRErSWUV6LKwNjsn
         w+TsPIneDrslpVSN3SzD7RZntBaIW9wrolAxcaTrcy5NKi+YoHbfDlWWTCaJMAWVLjXb
         35L8s6aI4DMr61ecwHSkwkD6mBYqm8qzz7tGu2CrYJ97Wp4q6GvdilAqbLJUs7MBvTju
         z11fIGZ3C7UEIjb9sqYx5cSIqiLS9BPOCOIVPLKONpsMcORWUledZjhDMfto+ELXmOTR
         3ooJB2EpCEXWX22Qm0jShg8dax4z5pciA+UDK9cMsDpauqr/6JF726BO0wo4KmUs6+ST
         1fzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694108538; x=1694713338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yI6bGEdU/7x6FXH5RWf2k+HtyEHZh0STqI6FnUAdGU8=;
        b=f8JM0XPiaxM5kbZZRW9PlFKj++o2Qnh9pqDH/Agewq1UB2M/LknqCli2Fdb+FfE0nV
         WlRK01OhwsbEUo6DrRDYQDEBfJOPRcP+Tgd1meD7IOBplKxXyuFGBtgFlYi1uuWH3XoV
         sqi/f+Xj1o1O/F5/Hj7LSEvoMxSV3KDoAwZC0QjdAVXLuST2FhzcKHSHwGbdRspp+J/T
         h0AIFWISlL1ZBBpv3LuFuILfY4bOLpDlFFp307LkPVxWpJppuXr7DjDxeiUgIGaOoBYl
         A1md0H9NlWLyJT9w+15GAqAeyUQpaxMso5tuElYdvB7hgIwBAA3DwzGPCy/L4QeolLw8
         g5/g==
X-Gm-Message-State: AOJu0Yy8Q8BpixIs4gKi/ulGq09uKLEBjY3A1kMOlkbq3GTWGsBMc0WH
        aRbjsxKF8kadDdz67LCzxBNnohEAkNwB33K6G7M=
X-Google-Smtp-Source: AGHT+IE6IGtum/AwRPjnxZ2uffFk4G9yGs+eQHjwqZ2TxmDAqu3G9WM8k/hltt7G8S9/19+IVst4E9VfwhQNhhd1WPY=
X-Received: by 2002:a05:6830:32aa:b0:6b8:90cd:47b5 with SMTP id
 m42-20020a05683032aa00b006b890cd47b5mr58200ott.7.1694108537998; Thu, 07 Sep
 2023 10:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230818151220.166215-1-cgzones@googlemail.com>
In-Reply-To: <20230818151220.166215-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 7 Sep 2023 13:42:07 -0400
Message-ID: <CAEjxPJ7_CMFvRHFp1HVV+ppZEXPkWG6oH1MMEbjFESH44wZukg@mail.gmail.com>
Subject: Re: [PATCH 2/6] selinux: dump statistics for more hash tables
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
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

On Fri, Aug 18, 2023 at 11:12=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Dump in the SELinux debug configuration the statistics for the
> conditional rules avtab, the role transition, and class and common
> permission hash tables.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 84f02d4f8093..932e383bcad6 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1158,6 +1158,8 @@ static int common_read(struct policydb *p, struct s=
ymtab *s, void *fp)
>                         goto bad;
>         }
>
> +       hash_eval(&comdatum->permissions.table, "common_permissions");
> +
>         rc =3D symtab_insert(s, key, comdatum);
>         if (rc)
>                 goto bad;
> @@ -1339,6 +1341,8 @@ static int class_read(struct policydb *p, struct sy=
mtab *s, void *fp)
>                         goto bad;
>         }
>
> +       hash_eval(&cladatum->permissions.table, "class_permissions");
> +
>         rc =3D read_cons_helper(p, &cladatum->constraints, ncons, 0, fp);
>         if (rc)
>                 goto bad;

Do we want to embed the actual common and class keys in the output to
distinguish among the multiple common and class permissions tables?
