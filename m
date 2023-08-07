Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D56771A59
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjHGG2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjHGG1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:27:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D21198C;
        Sun,  6 Aug 2023 23:27:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so34747205e9.0;
        Sun, 06 Aug 2023 23:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691389661; x=1691994461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2G7ZZDLvprT0WNAleu7FGdTqW3zfs7xA+cMHXaVBTU=;
        b=rKcfkJonfzc3GBXs7ZWhx13ebxbAotG+H4lEtW89dSCcs3fxdOGZbdzf3F3tuBE0df
         RvMx2SKfb9Ozz6b8u42rHs9rxCtIrieT1UW7x6mSj70X6fxEvHbigoeEsRBY8tbI7kR3
         EAaKxjrH4V0Nr0OcCuVPVKMRUVOEOT9sfJyAqsE/0Tb3NihAETxbV0icScQNuBcYktV+
         FGhFpG4oSd1PmUCoQ/Q+vPBmO8S8rhic+JQZ+KVdZsIz3A4bBSScNiTdwbttqrACz1EI
         uolgMY9j9qQuQTURMyTwwpjRdSGOqwwtfPPYkDTjwPswxqQmu6+P+rfeylInG5I2YujR
         sraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691389661; x=1691994461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2G7ZZDLvprT0WNAleu7FGdTqW3zfs7xA+cMHXaVBTU=;
        b=G2JV1z1G40Nr1pAHFQ1SikqM3ypxuRlCQrunu1oL+CXIkuF+6H/1e0nzMoykAgTEFL
         lU02DGEYSHBgvFocDwahlifZ7CpB7rMD96sT9Vw2fYXWHaqqcOTkaRpbfph2JEE+jx7r
         1gGOVEFAzgoMbGbCkDqjYbyjwnwUuO5seCgMV/DN6cMWNGqSADUbiLX0TQCr+L00wX3S
         JUpYfJm5iFIYvZBjAdBeE6u9lXXON/Sk+67PLGgsIuJcPgwFnpIrZx7qheFZfmYwXtlY
         JuacCUtDW0gq8cdJu4g1WI/8IKQqUjEfMT8+11w3qJrCueHz/xmmzH+ZeepS3Q6Kzilb
         vv6Q==
X-Gm-Message-State: AOJu0YwSNW5esDeZH7siGk2IyVcfLvr3DC/xGSl125JX8Kgd96VNCJOI
        RWJ5DNm+DicZK5B+ABcG5/hLSSXt1xqEkA==
X-Google-Smtp-Source: AGHT+IE61fkb3i7JmGzzqDAPXw/JHC7k3oRilm0+8xDj5IYI/szcRBVycRe74gaziBPKXWjYrs3ffg==
X-Received: by 2002:a05:600c:364f:b0:3fe:4900:db95 with SMTP id y15-20020a05600c364f00b003fe4900db95mr5253046wmq.37.1691389661276;
        Sun, 06 Aug 2023 23:27:41 -0700 (PDT)
Received: from khadija-virtual-machine ([124.29.208.67])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b003fe17901fcdsm14056012wmh.32.2023.08.06.23.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 23:27:40 -0700 (PDT)
Date:   Mon, 7 Aug 2023 11:27:34 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     ztarkhani@microsoft.com, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lsm: add comment block for security_sk_classify_flow LSM
 hook
Message-ID: <ZNCO1hOTKfBwD1zm@gmail.com>
References: <ZMfG/w5FWqCGE4pn@gmail.com>
 <ZMfnpPe3WCHgSDFQ@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMfnpPe3WCHgSDFQ@aschofie-mobl2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 09:56:04AM -0700, Alison Schofield wrote:
> On Mon, Jul 31, 2023 at 07:36:47PM +0500, Khadija Kamran wrote:
> > security_sk_classify_flow LSM hook has no comment block. Add a comment
> > block with a brief description of LSM hook and its function parameters.
> 
> When referring to functions, in the one line commit message, or here
> in the commit log, it is customary to add the parenthesis to be clear
> it is a function name.
> 
> ie. security_sk_classify_flow()
> 
> > 
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> >  security/security.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/security/security.c b/security/security.c
> > index d5ff7ff45b77..ffc5519e49cd 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -4396,6 +4396,13 @@ void security_sk_clone(const struct sock *sk, struct sock *newsk)
> >  }
> >  EXPORT_SYMBOL(security_sk_clone);
> >  
> > +/**
> > + * security_sk_classify_flow() - Set a flow's secid based on socket
> > + * @sk:  original socket
>            ^errant space
>

Hey Alison,
Noted. Thank you.

> > + * @flic: target flow
> > + *
> > + * Set the target flow's secid to socket's secid.
> > + */
> >  void security_sk_classify_flow(struct sock *sk, struct flowi_common *flic)
> >  {
> >  	call_void_hook(sk_getsecid, sk, &flic->flowic_secid);
> > -- 
> > 2.34.1
> > 
