Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB787FDB00
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjK2PTb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 10:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbjK2PTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:19:30 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B2184;
        Wed, 29 Nov 2023 07:19:37 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-58ddc32f43fso45357eaf.1;
        Wed, 29 Nov 2023 07:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701271176; x=1701875976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B32ouiV8wszxl16Z6gCKREM70b4o5qFAT461SnSNo7o=;
        b=TlxHxhAIwdNEuZYUWHvIZE2VZ00NMBWcoXu6+bV0nF/qF9UpyatLDo7NbbU/OsiQrS
         hnUlHkkKAaVBcB745QZXUXU28ffYOzoIkovcDkxFSmP3sjcSnE3DeLKnNXLd/oTwq+u2
         HgwiuDciP7G1tiQBX/aFt8IaiA3gkNrUG5uZ+17tQa1qalULuN14hlpWdKi0lSlgfVNE
         CyfLUT/qtDlj7SvrdBvVbreuamUGxFHSqVUA2Fx4Edf6t4JfEAOkKAR7S3JMgsyxcT8J
         gNJFpk0TXEaZoS/PRjqbiJBHPmfaGJGXtQz/sFKtAUisBO6KQAjocaa9BeuSSi6dqB6P
         mZIw==
X-Gm-Message-State: AOJu0Yz0iKDb0PS4A/KAZamSbq9qXJviewsiSM0pBb0IAN0/JtSAXfyV
        RcWUHeWytBpsPp3BSqKy5gEeMtSj1DcxfGJm67/hJScw
X-Google-Smtp-Source: AGHT+IFa8cTbrlNJ3lT+phgQUqELtwivOPydjg9FhDEZN5wTKs8RyH7qoecg8XkV6fJiNp3gFg71oWlIV0SmOvSa7RE=
X-Received: by 2002:a05:6820:34b:b0:58d:a761:5f88 with SMTP id
 m11-20020a056820034b00b0058da7615f88mr6729983ooe.0.1701271176098; Wed, 29 Nov
 2023 07:19:36 -0800 (PST)
MIME-Version: 1.0
References: <20231129143132.32155-1-jiangyihe042@gmail.com>
In-Reply-To: <20231129143132.32155-1-jiangyihe042@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Nov 2023 16:19:25 +0100
Message-ID: <CAJZ5v0jfEsNVu=fg+Xa118F=hCGGB33U5SbiqWeCMaVMqNpUEA@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: add Cometlake support
To:     Jiang Yihe <jiangyihe042@gmail.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rui and Artem

On Wed, Nov 29, 2023 at 3:32 PM Jiang Yihe <jiangyihe042@gmail.com> wrote:
>
> Since the Cometlake C-State is supported, support for Cometlake should
> be added to intel_idle. Just use Kabylake C-State table for Cometlake
> because they share the same table in intel_cstate.
>
> Signed-off-by: Jiang Yihe <jiangyihe042@gmail.com>
> ---
>  drivers/idle/intel_idle.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index dcda0afec..f83f78037 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1418,6 +1418,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,             &idle_cpu_skl),
>         X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,          &idle_cpu_skl),
>         X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,            &idle_cpu_skl),
> +       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,         &idle_cpu_skl),
> +       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,           &idle_cpu_skl),
>         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,           &idle_cpu_skx),
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           &idle_cpu_icx),
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,           &idle_cpu_icx),
> --
