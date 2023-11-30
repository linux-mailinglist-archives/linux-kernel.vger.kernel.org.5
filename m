Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC387FFD34
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376759AbjK3VC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjK3VC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:02:27 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D2810C2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:02:34 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cddc59e731so1296536b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701378153; x=1701982953; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NyeHJWiLdFo7I9JRqXuJBHQL2k3baSzOcxFT8tS/iws=;
        b=c4iP/X4yHnygKgxRG6y3Jq0EuNnH+e/MjnLJkY+x+XbFSZ4uinvEAgkP9QmN32wXVI
         kcW19abkTTdXK8RsFxkg/YZVWv3Y2f9gnyIAxFnhcGD3SwtfhOlbLK6HnqVsG+yCA+A6
         Rs4452K4JBcfAAaIarZCQHHxUTADGZDAlq2U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701378153; x=1701982953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyeHJWiLdFo7I9JRqXuJBHQL2k3baSzOcxFT8tS/iws=;
        b=xHwKc0GtyxGAjWQLA+KKNfPAvWCCQ7s/AuRzYOQwhbDG/YVWZimLBytVj+0wXi7D8E
         AMFvNzrODdeirJ1ACejDVt+a9kzRIAA20m+ZbbaVNrQS5Acj2TAy6oDxDM2YLhV57Vm0
         7sWF8ILiC+tk2wyNNdgcYa4havuHsJsmgMAhsJTxhxz+tEpwWG8fUuWxeeyxjgioBGVa
         4EgPyKi7s5stbedPIG9jgtaWiytfEEHEStXqaOARLLeqVQO6aXBF0SBDoTJFCb4dz6n7
         c7N8a3XzSIvSXlheVveHNaTdDxuslAhpm8vMfFHTAzwpb0DvnRJl7477+2Dbq/AzXSks
         JGLQ==
X-Gm-Message-State: AOJu0YxPf7U0POWSI7WhWDjjlvs+Ykr542ZMlGv0OcXCY97p+9piS8bb
        05+joHi5IAyDiAqoEjA9Uz+Lyg==
X-Google-Smtp-Source: AGHT+IFPqOtCQKaiIkfNERoPXQRP8a11ba8grcvFLj1169pKYiYb6nm2g+juLHikzSkTaUhFgcumtw==
X-Received: by 2002:a05:6a20:daa8:b0:18b:914a:a81 with SMTP id iy40-20020a056a20daa800b0018b914a0a81mr28046510pzb.52.1701378153297;
        Thu, 30 Nov 2023 13:02:33 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k187-20020a6324c4000000b005b7e803e672sm1726803pgk.5.2023.11.30.13.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:02:32 -0800 (PST)
Date:   Thu, 30 Nov 2023 13:02:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/3] kernfs: Convert kernfs_path_from_node_locked()
 from strlcpy() to strscpy()
Message-ID: <202311301300.6BAB981@keescook>
References: <20231130200937.it.424-kees@kernel.org>
 <20231130201222.3613535-3-keescook@chromium.org>
 <40b65db9-1b37-45b6-8afe-7be2df11cfa9@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40b65db9-1b37-45b6-8afe-7be2df11cfa9@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 09:38:11PM +0100, Christophe JAILLET wrote:
> Le 30/11/2023 à 21:12, Kees Cook a écrit :
> [...]
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 8c0e5442597e..183f353b3852 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> [...]
> > @@ -158,18 +159,22 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
> >   	buf[0] = '\0';
> > -	for (i = 0; i < depth_from; i++)
> > -		len += strlcpy(buf + len, parent_str,
> > -			       len < buflen ? buflen - len : 0);
> > +	for (i = 0; i < depth_from; i++) {
> > +		copied = strscpy(buf + len, parent_str, buflen - len);
> > +		if (copied < 0)
> > +			return copied;
> > +		len += copied;
> > +	}
> >   	/* Calculate how many bytes we need for the rest */
> >   	for (i = depth_to - 1; i >= 0; i--) {
> >   		for (kn = kn_to, j = 0; j < i; j++)
> >   			kn = kn->parent;
> > -		len += strlcpy(buf + len, "/",
> > -			       len < buflen ? buflen - len : 0);
> > -		len += strlcpy(buf + len, kn->name,
> > -			       len < buflen ? buflen - len : 0);
> > +
> > +		copied = scnprintf(buf + len, buflen - len, "/%s", kn->name);
> > +		if (copied < 0)
> 
> Can scnprintf() return <0 ?

Ah, yeah, it's can't at all[1]. I forgot! :) Honestly, that function
should return size_t, not int...

I will send a v3 with this adjusted, but I'll wait for more review...

Thanks!

-Kees

[1] https://docs.kernel.org/core-api/kernel-api.html#c.scnprintf

-- 
Kees Cook
