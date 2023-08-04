Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12BB76F7BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjHDCUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjHDCUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:20:23 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176594488
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:20:22 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76ce59842c1so75794385a.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 19:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691115621; x=1691720421;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mLhcnpWepw9OAnda2zrru4K4o2e/86s6ZEoWa43L/qs=;
        b=CGyn8fIS4jOy5+ad8V0yYO87EgUKlkNFQfFLpHEKBiaD1O8UNCdbbZRjX62hkpDSAn
         HNOlD/WLcftYSU+trV9TuJgYWC0KFw5az7e5cexyALgnttgb+5ZiH077pXc+FMCnsYwZ
         C7iFlKIfBmkmt2J43TuWDd2exYaFmSOivUqyik7o+Cb190EhBd5cTkOVdoQmgtE1hYPI
         XFEGl84mNPXz7Ro6+DfHokKBT42W+MAy5lA1LZskIuU3WSYvuDhs60IlbgdMAlHxq0CP
         lJr+lxISrB8wAEU7l+Jw3ikMJoZVxa6Eef+MC9jHM0Avi+hwkBH+jDCEDpHaVGavyIt8
         j+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115621; x=1691720421;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLhcnpWepw9OAnda2zrru4K4o2e/86s6ZEoWa43L/qs=;
        b=Lpi53FV444R4Ky0AOAOp+XNaN4bWk1LDLQ2lQKTazE82ZQ0Lag0dAbnn7L3+OiMDoY
         1nMrV6ktXu/rLQ1apugPAKYCHUWqoBO4LCbkK4+srSTy9jdda4VqWOinmXN8pL1z1TTk
         t9UYtp94Kb+A9j3zwSW5MPl+TW++RejPXXS6C3VPJCYloJTB4L8cUXjxZad5ksNuwGP6
         5hIEdcAhxqKo69baKkat41HYaLppQLadxx6K7kgUMvlb8m8h0STaoYe+F9Ooq5Uy+kYk
         usy8kxGuiAEG7Ch1c/qg0MRv8eS5jlJDmdtyhVXw1O2OtJEDkWSDn5PNjKQWp5SSN0PL
         AYsw==
X-Gm-Message-State: AOJu0YxCF11fLix6eXz1otIpThkEhv1An6c7UZp+ZbWbwsczpK3z4TfC
        iTTM6mWc2AsgzGjHjFul1IkN
X-Google-Smtp-Source: AGHT+IGj0cg6UU78jOWBtDAetMovZ5h1/t+YS5f79pasE5MOVl1ncw3q+PQrFsaQBrAKeC0DAgqpxQ==
X-Received: by 2002:a05:620a:44d4:b0:76c:c388:7cfa with SMTP id y20-20020a05620a44d400b0076cc3887cfamr547680qkp.67.1691115621073;
        Thu, 03 Aug 2023 19:20:21 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id z27-20020a05620a101b00b0076c8fd39407sm333538qkj.113.2023.08.03.19.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:20:20 -0700 (PDT)
Date:   Thu, 03 Aug 2023 22:20:20 -0400
Message-ID: <059e2bd127d8a6d59290d606a707a999.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] selinux: services: update type for number of class  permissions
References: <20230728155501.39632-4-cgzones@googlemail.com>
In-Reply-To: <20230728155501.39632-4-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Security classes have only up to 32 permissions, hence using an u16 is
> sufficient (while improving padding in struct selinux_mapping).
> 
> Also use a fixed sized cast in a bit shift to avoid (well defined)
> overflows on architectures where sizeof(unsigned int) != sizeof(u32)
> resulting in no bits set.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2:
>    update commit description:
>      - mention struct selinux_mapping  in the padding argument
>        (currently between the first and second member there are 2 bytes
>         padding)
>      - mention overflow in the cast argument and the result of setting
>        no bits due to it
> ---
>  security/selinux/ss/services.c | 6 +++---
>  security/selinux/ss/services.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

This looks good, I would just like to request one small change
(see below).

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 2c5be06fbada..cf4b87ec4a0e 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -97,7 +97,6 @@ static int selinux_set_mapping(struct policydb *pol,
>  			       struct selinux_map *out_map)
>  {
>  	u16 i, j;
> -	unsigned k;
>  	bool print_unknown_handle = false;
>  
>  	/* Find number of classes in the input mapping */
> @@ -117,6 +116,7 @@ static int selinux_set_mapping(struct policydb *pol,
>  	while (map[j].name) {
>  		const struct security_class_mapping *p_in = map + (j++);
>  		struct selinux_mapping *p_out = out_map->mapping + j;
> +		u16 k;
>  
>  		/* An empty class string skips ahead */
>  		if (!strcmp(p_in->name, "")) {
> @@ -202,7 +202,7 @@ static void map_decision(struct selinux_map *map,
>  {
>  	if (tclass < map->size) {
>  		struct selinux_mapping *mapping = &map->mapping[tclass];
> -		unsigned int i, n = mapping->num_perms;
> +		u16 i, n = mapping->num_perms;
>  		u32 result;
>  
>  		for (i = 0, result = 0; i < n; i++) {
> @@ -230,7 +230,7 @@ static void map_decision(struct selinux_map *map,
>  		 * should audit that denial
>  		 */
>  		for (; i < (sizeof(u32)*8); i++)
> -			result |= 1<<i;
> +			result |= 1<<((u32)i);

Given that the for-loop bounds the value of 'i' to a maximum of 32
(31 within the valid portion of the loop), this cast seems
unnecessary and potentially problematic in the future.  Please drop
this casting.

>  		avd->auditdeny = result;
>  	}
>  }

--
paul-moore.com
