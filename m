Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7443376F7C5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjHDCUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjHDCUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:20:42 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EC144B5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:20:25 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76c97a137c8so126446285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691115624; x=1691720424;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2A36zt8dtnUsg87k3ceorvznxtuCwHOmRsl0P1K6nwY=;
        b=N0BWOx5xPWYxS9PxUFdtLS4cw5T3sFIsMtKd2GEATm8atWxZBq3P1+f4HUTX6mAyFG
         3eDMxZrMtqAb4ujfCn/BP1UMLiLl5FYYvOoQ5458QnOVckzDwZuCOiqPTltvt3KLjvfR
         i4MIhDWPmpCVmUe/jSJjljQ7n2ANHn/P2kK7IsVcSc43nnToFx4VM3mWcZYXjLOKfApS
         l99Fz/6pYmn3iJYoe3pirq2LMfcXSzVwN7tlfnPl+PMLSXbBfIdcNkAMjqY6NlXo07rF
         LFjPBH9/meWOHnQiIrpq+R7ImukUjyFFAwQYWzn8abGuhYU0Cmcv3vFd7HkVYABqps6m
         YYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115624; x=1691720424;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2A36zt8dtnUsg87k3ceorvznxtuCwHOmRsl0P1K6nwY=;
        b=KrAiUkC57WNXykOzKmI+QjjgRcTGB6Aqa4wK8O5Itpbact8HuZ1DxAqyRgd3XM3Z7x
         +wVXrP7UPRtsb64ovJ4B9sf/n3eelTsJ8P1HjV4Q5IriZHLrDNcHxlYnwJV9FeXKkFlr
         bjOg8ylx4z0n5gr/RfqlIb9k8N2Z9B9J2sBjoCcnZMEkHztNH6cAjsgRv3NV0lsOQTW0
         qxnxMgN6v8udEGYog3y3ll5wLhtmkJ1KQgZqfzUuq2eGT2cYfaYuVGmxNKwNCsby9t3l
         MuQ4tKr1e2RlOE0aBkENjQOx6dW0z8bIP1dDlXrxVxgfhjPpClyTGLX/TwMInZMwDwB+
         pqDg==
X-Gm-Message-State: AOJu0YwRUHrrPYsy2lre/UPxBMQdwmllm3vvdrBiVGrWnhNWelDtsRwV
        YkXpR5+354TbnK9V2pJPk6tW
X-Google-Smtp-Source: AGHT+IEoS88Nucw/4DRDM1C9crvDnwJ/fmssK0XqeIvUgd7B/L/Y8iNMK64eDiDoVp+iR9EB4n8dqQ==
X-Received: by 2002:a05:620a:290b:b0:76c:cd15:a8b5 with SMTP id m11-20020a05620a290b00b0076ccd15a8b5mr771476qkp.21.1691115624509;
        Thu, 03 Aug 2023 19:20:24 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9e90c000000b0076c60b95b87sm332562qkf.96.2023.08.03.19.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:20:24 -0700 (PDT)
Date:   Thu, 03 Aug 2023 22:20:23 -0400
Message-ID: <e109fc2da07fe92eecda62781201be05.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] selinux: avoid implicit conversion in nlmsgtab code
References: <20230728155501.39632-8-cgzones@googlemail.com>
In-Reply-To: <20230728155501.39632-8-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use an unsigned type as loop iterator.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/nlmsgtab.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
> index 2ee7b4ed43ef..2f8fab949633 100644
> --- a/security/selinux/nlmsgtab.c
> +++ b/security/selinux/nlmsgtab.c
> @@ -153,7 +153,8 @@ static const struct nlmsg_perm nlmsg_audit_perms[] = {
>  
>  static int nlmsg_perm(u16 nlmsg_type, u32 *perm, const struct nlmsg_perm *tab, size_t tabsize)
>  {
> -	int i, err = -EINVAL;
> +	u32 i;
> +	int err = -EINVAL;

I understand wanting to make 'i' unsigned, but I think unsigned int
is a better fit for an iterator and array index.

>  	for (i = 0; i < tabsize/sizeof(struct nlmsg_perm); i++)
>  		if (nlmsg_type == tab[i].nlmsg_type) {
> -- 
> 2.40.1

--
paul-moore.com
