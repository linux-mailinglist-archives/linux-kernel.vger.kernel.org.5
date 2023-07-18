Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350E57587FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjGRWBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGRWBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:22 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B410019B9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:19 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4035dd6b349so47681031cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717679; x=1692309679;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5n8Bh8d66inhHJw21BuddS5DHM8rIYty9eo51n5me8c=;
        b=SmEJ/PYXRCfDwB/QBMY8+BmuMyIgZB9ZFGqhWWC73Lqmv5OyUaW6te3ef8eW8eaGUA
         CIR1qjgqNlI2izKOCp5q+1Qiu/pyza6W102BK7eyK+O2QxdIz+7tFJwluq+w7iCtHrzn
         M4q0Hpt0WPpB/ovjuaxrWG298LJ7e5Oe+8uk7RmRMyQylwlaoFvf2yvpbqu1nF5ATNBa
         XtLOtAEwLkAOMr9TkiZ+wk3+o/SvLufTMVMjgTiscKxw1+CsbpeOsVOMJUots4yXD6Nj
         Ddon3CY8R6K6kxFAn5pw4L5i2+w7rO/9G3UHE2F0TMOQC3Puvcw2jvgthID0S181uBgl
         DFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717679; x=1692309679;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5n8Bh8d66inhHJw21BuddS5DHM8rIYty9eo51n5me8c=;
        b=ku2wjEknsjcSVvUzvDs41n7fCognHNn97hlQGR03CfPzEHwjkaWGKYs5FTF47n/cuv
         j0i/znz3TqacZPmZ7g56Xpu5J32Gawguf2Um8PKa2eKB20T3CHHfbWCxjgioCjwYquVz
         evCpq1luezCRVnnkW5ZgYE9HIyIW3LlP70bEdy8GzcXeeXY9Yzn4CeT/u32ZuyYOohVB
         c/D0H5Qfto/5UIQA5E7TB7q85NYvcjhjb/KnVcitUW/GdSpZRzMEdqWEG31N0M9XX7ea
         cBfs9XofQ43CoPM5SqhNC18mxEayxGlVnD+HNl+VmHTYsGMxVgYEdw8FnZNJaoHDLH4Y
         QHHw==
X-Gm-Message-State: ABy/qLajvsm4IXN43TKFsYyejI2EuXkD0IEbHDJM1XfUO6+3iwzc6zH5
        /YHQtiOgRHi5P+LCbtIvJGzO
X-Google-Smtp-Source: APBJJlF5JOrCTg3q4UiAHi9JMoDlk1oRvaAdE925uSkHMaJC3+uT0s8qsIU/Yvq18MaXgjY2sZjhSw==
X-Received: by 2002:a05:622a:144e:b0:403:c687:bfb6 with SMTP id v14-20020a05622a144e00b00403c687bfb6mr23713673qtx.1.1689717678774;
        Tue, 18 Jul 2023 15:01:18 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id bs19-20020ac86f13000000b00403fc303060sm549663qtb.97.2023.07.18.15.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:18 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:18 -0400
Message-ID: <703e95374a9a0d25186e7ac472f143d7.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Gong Ruiqi <gongruiqi1@huawei.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>
Subject: Re: [PATCH RFC 7/20] selinux: services: update type for umber of class  permissions
References: <20230706132337.15924-7-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-7-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  6, 2023 Gong Ruiqi <gongruiqi1@huawei.com> wrote:
> 
> Security classes have only up to 32 permissions, hence using an u16 is
> sufficient (while improving padding).

Can you explain the improved padding comment?  It looks like you are
only changing the iterator's type so the struct should remain
unchanged, and FWIW, it looks like security_class_wrapping allocates
space for 33 permission strings.

> Also use a fixed sized cast in a bit shift to work correctly on
> architectures where sizeof(unsigned int) != sizeof(u32).
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/services.c | 6 +++---
>  security/selinux/ss/services.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 78946b71c1c1..3275cfe2c8f7 100644
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
>  		avd->auditdeny = result;
>  	}
>  }
> diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
> index 8a9b85f44b66..b6f99353301e 100644
> --- a/security/selinux/ss/services.h
> +++ b/security/selinux/ss/services.h
> @@ -12,7 +12,7 @@
>  /* Mapping for a single class */
>  struct selinux_mapping {
>  	u16 value; /* policy value for class */
> -	unsigned int num_perms; /* number of permissions in class */
> +	u16 num_perms; /* number of permissions in class */
>  	u32 perms[sizeof(u32) * 8]; /* policy values for permissions */
>  };
>  
> -- 
> 2.40.1

--
paul-moore.com
