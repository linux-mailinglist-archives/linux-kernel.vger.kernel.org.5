Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC9176A1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGaUHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjGaUHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:07:41 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA478F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 13:07:40 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-63cffc0f95eso24315476d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690834059; x=1691438859;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mr0jsvWUvhK60xhRYuC+cetlUrcr4WSBsNOHSmk9+vU=;
        b=gXAc1coIwIN3PBRpnTQWF+PlcWrr/GrP0Ju8QynMdyi64D4U70xjy2963/b/rm1yUi
         Ou8ZBrdBDdyfSyMiikY0XnraaBLp+o4VJZWi8aA2hB+E9ck6DWbL3AhPE3iD9m7m+Ua4
         XiTb5hbqCmNnm5bR21cjSewo2smZEWr0VZB++f5oLJM9M1xybb90XiqCOY4/qfxxE0kf
         e1gnaCU3AfjhwkZn0bNfemuRmGupe1AUMCrJ8nLZUk5NhoLB1ucSTPekozbswQWJo7xz
         EkJDGX9IA49yTflowLelifhC5Y0B8bQMyIh4G1OtNNbJLTYq/U7mynhiZJscbKIvmj8N
         Gr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690834059; x=1691438859;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mr0jsvWUvhK60xhRYuC+cetlUrcr4WSBsNOHSmk9+vU=;
        b=fyXnN8CIe0JhuNVTEOlWbX2YRjNXrNqpy8rnUW/yucMqUAUOrGy7Im46TuLBOEuXWv
         JbYyfPsyIhMWk5fR6pq00lNOKxufpmvbNyf4I2bj0zylHOvwntfD1fgv/0soD21dSk6z
         C7ToaJ36UlS59cN0NTFBnLgrapIwGywxDY39mRqY5AEZ9wzQQ9ORcWP8kc8TTJpQiN07
         WpNOwPmGqUreNuQZMzU0AjOCO6y4+C+knr03eSF3QjQ/X7JCdtbAsw2Hk7uHitwaJjIa
         Ijhl9YLrnBsX7UAeRSJiPdeHj6/5NFyNCGscOQvtfMMkORO5i3g7hcxGWJ3FEhkFipXD
         ORxQ==
X-Gm-Message-State: ABy/qLYKD9ilxaRVtb8q2JWGKeLBanUuoKHFJGJwOeck8KWDEI8Cjqok
        Uk5Z1f1onBZsSfiC/COt7CPA
X-Google-Smtp-Source: APBJJlE4HtjBLKJpDXwsj1fQh5ag53C2HETLUhyAStqDmHgBWzYNq+3BjOOu2a/hYQPHgkFHY7475A==
X-Received: by 2002:a05:6214:ab4:b0:63c:ec3a:ad71 with SMTP id ew20-20020a0562140ab400b0063cec3aad71mr1762770qvb.11.1690834059579;
        Mon, 31 Jul 2023 13:07:39 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id h13-20020a0cab0d000000b0063d1f967268sm4100870qvb.111.2023.07.31.13.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:07:39 -0700 (PDT)
Date:   Mon, 31 Jul 2023 16:07:38 -0400
Message-ID: <abe91475c7f9e3483405c6096006b2a9.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        ztarkhani@microsoft.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lsm: add comment block for security_sk_classify_flow LSM  hook
References: <ZMfG/w5FWqCGE4pn@gmail.com>
In-Reply-To: <ZMfG/w5FWqCGE4pn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 31, 2023 Khadija Kamran wrote:
> 
> security_sk_classify_flow LSM hook has no comment block. Add a comment
> block with a brief description of LSM hook and its function parameters.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  security/security.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks Khadija.  I did make a small change to your patch (see below)
when merging it into the lsm/next branch.

> diff --git a/security/security.c b/security/security.c
> index d5ff7ff45b77..ffc5519e49cd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4396,6 +4396,13 @@ void security_sk_clone(const struct sock *sk, struct sock *newsk)
>  }
>  EXPORT_SYMBOL(security_sk_clone);
>  
> +/**
> + * security_sk_classify_flow() - Set a flow's secid based on socket
> + * @sk:  original socket

As has been pointed out previously, there is a double-space between
"sk:" and "original socket".

> + * @flic: target flow
> + *
> + * Set the target flow's secid to socket's secid.
> + */
>  void security_sk_classify_flow(struct sock *sk, struct flowi_common *flic)
>  {
>  	call_void_hook(sk_getsecid, sk, &flic->flowic_secid);
> -- 
> 2.34.1

--
paul-moore.com
