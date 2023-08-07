Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421667734C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 01:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjHGXPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 19:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjHGXPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:15:11 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C45C6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 16:14:56 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-583b019f1cbso54855577b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 16:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691450096; x=1692054896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gC650LVe61HwPim1FSUuzXp4C/B2DwrSSnI6+3CNzQ8=;
        b=ct+ge2PGifRP3AlMIL/2uh0Qxnp5/FFhMPFh1pADmZFwbBUUztR9EjiH+7kkziM74s
         qZAjmrkpD1CdVps/VpDrKBYmtg03d/GoP3/+FfqBBBzrSn30IWE0+ixoqmDOrAH+O2qx
         ZK8X6B1b0Yy/2dyuIRVptN2hY9zk0fC2xMCvLJg0HIlu3iG5ejaOh48zKA9JDbI0t6QD
         rpxIeR/fckdT+rJDS3i78lzOjpgMigIQPcLmeo18ttjBsgQLeSzWhLJ1ZxGhfMnHptbj
         4O0xCy8K4HT5PqD1tsQ+/WUR0cRwPsdhCIiCp/x0sf3IcIR6lFhOzr5cfWtSNH10j0NE
         s9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691450096; x=1692054896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gC650LVe61HwPim1FSUuzXp4C/B2DwrSSnI6+3CNzQ8=;
        b=Lqk9MwENkKI3asi8sa9NssyCWlwcdlLfIbMTeFR2JBKph4HLBNdA3vmMLVY89h+TvG
         Y3b5bp6ldPrigVkTC9ULM0RBlHDhoXC4UAwmKky4Sg8e6CScOTm0uWxtWkvMKrxUHw2i
         uLTe+94XSvY6pEGIHmW/8TxBREFcaYj5C6BPnwHQl2AUXPRJD0a9C5fy/xmW55IeSFTl
         XEh2HXYhEs4r4DVFN6eMkMRPH85rpe8bWZedHEFfKyJweJUF7ogRPYaNZsWkLh6nJsxf
         V7SVuMPo6tl5uu89+0ey4jFYHOIbIUm0vb16ftyz8u40b784Ihz8qq/a9PFiXTkPX35f
         W+yw==
X-Gm-Message-State: AOJu0YyyTtqaQ+eIx7ry6lJTOqh4CiFNNb+COrQDMnIhkDojyvR0TuFa
        +c5jGCyjV8/ksWN4J4q8DZS4hkQJ3VZSSdNIuWPk
X-Google-Smtp-Source: AGHT+IG+zDyHe2W8hJPVzd30Y0QsMafbml2uX7nh9Nm5i+kMzX1fDTv2ox8qZUEuhWfN8JG6FwS88UOzudjmO8t4qPQ=
X-Received: by 2002:a81:6e86:0:b0:584:5e7e:40c1 with SMTP id
 j128-20020a816e86000000b005845e7e40c1mr10333423ywc.28.1691450095895; Mon, 07
 Aug 2023 16:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <ZNCZ4KL7TRDE9vIC@gmail.com>
In-Reply-To: <ZNCZ4KL7TRDE9vIC@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Aug 2023 19:14:45 -0400
Message-ID: <CAHC9VhSULN1B_EjVPA5st+NhDjiUbymOwt81C4gZ9Tn4_wWpuw@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: add comment block for security_sk_classify_flow()
 LSM hook
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        ztarkhani@microsoft.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 3:14=E2=80=AFAM Khadija Kamran <kamrankhadijadj@gmai=
l.com> wrote:
>
> security_sk_classify_flow() LSM hook has no comment block. Add a comment
> block with a brief description of LSM hook and its function parameters.
>
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
> Changed in v2:
>  - Add parenthesis with security_sk_calssify_flow to refer to it as a
>    function in commit message and commit log.
>  - Remove an extra space in the comment block.
>
> security/security.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Hi Khadija,

Thanks, but I already merged your original patch :)

https://lore.kernel.org/linux-security-module/abe91475c7f9e3483405c6096006b=
2a9.paul@paul-moore.com/

> diff --git a/security/security.c b/security/security.c
> index d5ff7ff45b77..b76fb27a1dc6 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4396,6 +4396,13 @@ void security_sk_clone(const struct sock *sk, stru=
ct sock *newsk)
>  }
>  EXPORT_SYMBOL(security_sk_clone);
>
> +/**
> + * security_sk_classify_flow() - Set a flow's secid based on socket
> + * @sk: original socket
> + * @flic: target flow
> + *
> + * Set the target flow's secid to socket's secid.
> + */
>  void security_sk_classify_flow(struct sock *sk, struct flowi_common *fli=
c)
>  {
>         call_void_hook(sk_getsecid, sk, &flic->flowic_secid);
> --
> 2.34.1

--=20
paul-moore.com
