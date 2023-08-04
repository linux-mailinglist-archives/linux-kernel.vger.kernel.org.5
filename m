Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E16276F7C4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjHDCUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjHDCU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:20:28 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054CC3C16
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:20:25 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-765a7768f1dso133980785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 19:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691115624; x=1691720424;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3CiDLiIYuKt4IHdnArrSJWZx+SaU1Z4GPh2PvCAAp1E=;
        b=fKS0rYEk9NlvW47yAvHt1dG5cAoxtqxukDoF8osImugxbpqjo9pYx/WzpKTUMQLbvF
         5dKXeheRXgbWE+DvzxRHKDY0ElI2ZIryb8wVwUa/rt1SnueKIwE5ZlplQatRnNcPs6DQ
         eKPMvD6IW45J8Hu/UcVIDZry/a8VBAgQ+cRb5LbEu9Nkdk+zXBOq2aWC7klEZ8VYT1ps
         gnUdIp+RxfmBEtO1ckxfSgRiREu5Z78vD6AlIEn0PVp51TOJWPbfvAdq9tc0DPnKkm4D
         VCYVJuGdwG/IuhofDSMhcra5kj5YC/FE6f2a/MfSWvP3L7jiEL//Esy5X40dxiseylow
         4VMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115624; x=1691720424;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CiDLiIYuKt4IHdnArrSJWZx+SaU1Z4GPh2PvCAAp1E=;
        b=KYR3FU+8wBYyBijYJz3/hBfirOrGVS3D79jL3DlK6oX+/pt1+bMy+6tNnoeU0gQh4M
         64dn/1eEObd3XbON+daccKoESWeFQ2HaDx9So74fzIiTYvvxiD65M8skReBBE+nv26gS
         8IluULfLFeBAJWvQMJ/vTCamXDePqWU42TfU+fH7xsEujbGnzgLU9IKPLRw4qXGHBgTE
         2S+Hu3nCf8eVJk8hMdjt8icXG6dDveKDiHP41G7YEzqBu4+Rkc0ZGr/Qq5zdU9j0oLQu
         SgenG6tBBfLvI9rBxGcGLXttUSap3xRf9krdWg/NAmCgCab9OJY1DRI2hVjRuJBqgwaU
         NMhg==
X-Gm-Message-State: AOJu0Ywjo/HkELbOkifvwRthaiaekrG93HTI6z9dS/iEGR+T63bxN3zg
        tTDmvksvoIO3Zre/XIveA2iyR1GZVkNnQXRYzNex
X-Google-Smtp-Source: AGHT+IH3C4lzzOyECtalre8Sq6W6eGR2fDv+NqXaNYQoNdt2U+rKeYyXRtjEnHAicTTFtrwmyzJlYw==
X-Received: by 2002:a05:620a:4493:b0:765:6e86:c7a9 with SMTP id x19-20020a05620a449300b007656e86c7a9mr849378qkp.34.1691115623719;
        Thu, 03 Aug 2023 19:20:23 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id w10-20020a0cb54a000000b0063d47a29e6fsm335191qvd.55.2023.08.03.19.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:20:23 -0700 (PDT)
Date:   Thu, 03 Aug 2023 22:20:22 -0400
Message-ID: <d3b3791b6d71b7ee6f0a020ee9280e2d.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] selinux: policydb: implicit conversions
References: <20230728155501.39632-7-cgzones@googlemail.com>
In-Reply-To: <20230728155501.39632-7-cgzones@googlemail.com>
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
> Use the identical type for local variables, e.g. loop counters.
> 
> Declare members of struct policydb_compat_info unsigned to consistently
> use unsigned iterators.  They hold read-only non-negative numbers in the
> global variable policydb_compat.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2:
>   - avoid declarations in init-clauses of for loops
>   - declare members of struct policydb_compat_info unsigned
> ---
>  security/selinux/ss/policydb.c | 93 +++++++++++++++++++++-------------
>  1 file changed, 58 insertions(+), 35 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index dc66868ff62c..aa2371a422af 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -55,9 +55,9 @@ static const char *const symtab_name[SYM_NUM] = {
>  #endif
>  
>  struct policydb_compat_info {
> -	int version;
> -	int sym_num;
> -	int ocon_num;
> +	unsigned int version;
> +	unsigned int sym_num;
> +	unsigned int ocon_num;
>  };
>  
>  /* These need to be updated if SYM_NUM or OCON_NUM changes */
> @@ -159,9 +159,9 @@ static const struct policydb_compat_info policydb_compat[] = {
>  	},
>  };
>  
> -static const struct policydb_compat_info *policydb_lookup_compat(int version)
> +static const struct policydb_compat_info *policydb_lookup_compat(unsigned int version)
>  {
> -	int i;
> +	u32 i;

Another question of 'why u32'?  I can understand making the iterator
unsigned, but why explicitly make it 32-bits?  Why not just an
unsigned int?

>  	for (i = 0; i < ARRAY_SIZE(policydb_compat); i++) {
>  		if (policydb_compat[i].version == version)
> @@ -359,7 +359,7 @@ static int role_tr_destroy(void *key, void *datum, void *p)
>  	return 0;
>  }
>  
> -static void ocontext_destroy(struct ocontext *c, int i)
> +static void ocontext_destroy(struct ocontext *c, u32 i)

Yes, this should be unsigned, but why not an unsigned it?

>  {
>  	if (!c)
>  		return;
> @@ -781,7 +781,7 @@ void policydb_destroy(struct policydb *p)
>  {
>  	struct ocontext *c, *ctmp;
>  	struct genfs *g, *gtmp;
> -	int i;
> +	u32 i;

Same.

>  	struct role_allow *ra, *lra = NULL;
>  
>  	for (i = 0; i < SYM_NUM; i++) {
> @@ -2237,8 +2240,9 @@ static int genfs_read(struct policydb *p, void *fp)
>  static int ocontext_read(struct policydb *p, const struct policydb_compat_info *info,
>  			 void *fp)
>  {
> -	int i, j, rc;
> -	u32 nel, len;
> +	int rc;
> +	unsigned int i;
> +	u32 j, nel, len, val;
>  	__be64 prefixbuf[1];
>  	__le32 buf[3];
>  	struct ocontext *l, *c;
> @@ -2299,9 +2303,27 @@ static int ocontext_read(struct policydb *p, const struct policydb_compat_info *
>  				rc = next_entry(buf, fp, sizeof(u32)*3);
>  				if (rc)
>  					goto out;
> -				c->u.port.protocol = le32_to_cpu(buf[0]);
> -				c->u.port.low_port = le32_to_cpu(buf[1]);
> -				c->u.port.high_port = le32_to_cpu(buf[2]);
> +
> +				rc = -EINVAL;
> +
> +				val = le32_to_cpu(buf[0]);
> +				if (val > U8_MAX)
> +					goto out;
> +				c->u.port.protocol = val;
> +
> +				val = le32_to_cpu(buf[1]);
> +				if (val > U16_MAX)
> +					goto out;
> +				c->u.port.low_port = val;
> +
> +				val = le32_to_cpu(buf[2]);
> +				if (val > U16_MAX)
> +					goto out;
> +				c->u.port.high_port = val;
> +
> +				if (c->u.port.low_port > c->u.port.high_port)
> +					goto out;
> +
>  				rc = context_read_and_validate(&c->context[0], p, fp);
>  				if (rc)
>  					goto out;

This entire block of bounds checking for protocols and ports should
be pulled out into its own patch, especially since it isn't mentioned
in the commit description.

--
paul-moore.com
