Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4D57587FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjGRWBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjGRWB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:27 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E970D19A9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:21 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7653bd3ff2fso682061285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717681; x=1692309681;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Jy5bic5jodoqmbRGQBCPtseqk5B/IX+1PNMGDEVdgk=;
        b=bxDKoEjAsfDYs8OyejWBAycPM62wdEsI9sM9VRwnh8gkeW1tA+srstqLqDRcDmM8M2
         oV/XjwxgXKxZUaxqrxI7PiPebl1L7tr3iiDIiCCKUJwv5uP6g5cGDeMZRQUifnBuAKSy
         Ek9clW+FoK+7sWQFDFi37i/gFh9yjGC1shzsFIHKu7v17HeOWGN0Hwze065oP/bDIZpy
         MFGwN3fVZCXH1eGAtjUTp9L9vmpPGHiWNFHRHqWrbQnmNWPdL25a4tYY7HtA8AiZDU/L
         ZfeEe1gqoqzVascCgZCnWVseKShIYqNk8nsqDytHpfO7qBgyLLhjdeQw0NAzOhDF2zBf
         jAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717681; x=1692309681;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Jy5bic5jodoqmbRGQBCPtseqk5B/IX+1PNMGDEVdgk=;
        b=aDaKZ9siAPjQGyK9tLe5eK3WViF6iCHCavoO4oZdrV+IlOlhcqVVr2V+b2bBuavdgr
         BIUht+mMlWJrP9pBWpfrAeNtwh8+nputOtBYux2xE9sQea2DOL5UF6EbrUVcIJFY/3B5
         pseq/f7DgtU6SCFmAOvRHHg4AV2sI4QIRx4FkSAD8X0AEOoKMYGBgyN171aIK5Kr8y9X
         dJRRBwNxqs8p6zDrrmQkFU+o/9JtfiKPSBH49DXnQrM+wF6kVyx2GBOOdNp5QPea8mzK
         sVo04WrdGtPnr7Hlj6GpP+Wq0I7ljA9cOynoAFD4GeD6BkO9Alo2aWmu2PYoJzI63HYi
         msAQ==
X-Gm-Message-State: ABy/qLb9AhdlpY+jJQFAVoS5C+lF4GSoIHObUk+MNrdUr/XujDn+1o1D
        EAjoxStpcJvIi5Qj5DEXZuFY
X-Google-Smtp-Source: APBJJlFbzPeSSZ71QpN34288UMOaN3bCXHdNNY8QkXt2uAQgO6QzRUA1GX58y9jQ7idvrH2s4/Fdrw==
X-Received: by 2002:a05:620a:c0f:b0:75b:23a1:3606 with SMTP id l15-20020a05620a0c0f00b0075b23a13606mr17925433qki.23.1689717680837;
        Tue, 18 Jul 2023 15:01:20 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id p9-20020a05620a15e900b00767721aebc0sm889239qkm.32.2023.07.18.15.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:20 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:20 -0400
Message-ID: <95bf84fd76c7eac5e9e53ad658d26f2c.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 9/20] selinux: status: consistently use u32 as sequence  number type
References: <20230706132337.15924-9-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-9-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Align the type with the one used in selinux_notify_policy_change() and
> the sequence member of struct selinux_kernel_status.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/security.h | 2 +-
>  security/selinux/status.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I was going to suggest you also update avc_latest_notif_update(), but
it looks like you tackle that later in the patchset.

Merged into selinux/next, thanks.

> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 0f93fd019bb4..a16c52d553e1 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -376,7 +376,7 @@ struct selinux_kernel_status {
>  } __packed;
>  
>  extern void selinux_status_update_setenforce(int enforcing);
> -extern void selinux_status_update_policyload(int seqno);
> +extern void selinux_status_update_policyload(u32 seqno);
>  extern void selinux_complete_init(void);
>  extern struct path selinux_null;
>  extern void selnl_notify_setenforce(int val);
> diff --git a/security/selinux/status.c b/security/selinux/status.c
> index 19ef929a075c..e436e4975adc 100644
> --- a/security/selinux/status.c
> +++ b/security/selinux/status.c
> @@ -101,7 +101,7 @@ void selinux_status_update_setenforce(int enforcing)
>   * It updates status of the times of policy reloaded, and current
>   * setting of deny_unknown.
>   */
> -void selinux_status_update_policyload(int seqno)
> +void selinux_status_update_policyload(u32 seqno)
>  {
>  	struct selinux_kernel_status   *status;
>  
> -- 
> 2.40.1

--
paul-moore.com
