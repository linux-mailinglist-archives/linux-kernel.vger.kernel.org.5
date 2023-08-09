Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6287764E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjHIQSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHIQSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:18:47 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702BE1982
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:18:45 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1bf7eb259d5so721026fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691597925; x=1692202725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti5YpVJETeixuCpoZ0ZGTbW0aEvrY5dl5mp0PqcF+V8=;
        b=ceKIciqrukI/00ca1jssImFg3oAqLm/cE3tjjF6cgD8FiPZe3vRSDzcykHMEXCv37j
         D4pU6Fd8uLOHmgjNuMRxoth+sXIcx17ulWLub9i/XONASsRC57RU4im/ix3q5vAAH4ja
         xci0E1+fvRsJSMdWdkQcbh2MXViWsRRQsgHBhRnPsar0SFMvAsLCderlYdrOsvAgVO8F
         684V3rUcjJ2d69wQOpwYlM2xYWkpMPfc7tVK2dqyy+giH8506zFfI6d6j3gQnSBTkorS
         rox6PHwddACVmLn9qESep6JCgPDszCeTNjilFYmcSHAG7wXaMPhk5r3Cp5CsPeqBcq3I
         NUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691597925; x=1692202725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti5YpVJETeixuCpoZ0ZGTbW0aEvrY5dl5mp0PqcF+V8=;
        b=NovdpAeFIZ5mzdTCfdI52GORjBcoiFav1s+9U8Br7iIgPzo7GZWlcA8Mqr5SimdHaU
         TwG6MIbvMPdg6lqmGRlWM5ihiItord2dA9pTf1GRlGcVITeKn3MDd39OQvWWfvBpgAf1
         d4m9/FE3zYa56e1zjEFsCce0N00seqeRYtKNdHzcvvEtVgnOk+2Vzynct0gGSQyu/5kK
         jEp2RX+ni6juOUi1KQZBE+cE5WvfANCUXX7wQLvGHYRaXXJ27X4lFs5Klj2JwR7cE/Ol
         kyBwj+7srO07IxXlP96TtrIWDNcOhMaPg/oXyhagNtWQFfWArtKkuvWN0w+wzo/VnNMu
         1QeQ==
X-Gm-Message-State: AOJu0YxST5XGDopRt3oifbcT+UJPN7RsR0iUfCsggpFReHlbYNr4iaZk
        zx1fRrEjTZooQJ6CWpnJ1FN6F/dvri4=
X-Google-Smtp-Source: AGHT+IE3mYF8NBLvPfFZJAlmgPoKDX1p00mZmHw4Ov1A71c7/UXf/pDlVx94W+4hr52Gy3ipZTD/7g==
X-Received: by 2002:a05:6870:171b:b0:1b0:3821:f09b with SMTP id h27-20020a056870171b00b001b03821f09bmr2323177oae.13.1691597924625;
        Wed, 09 Aug 2023 09:18:44 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id cc4-20020a056871e18400b001a9eb707366sm7282513oac.15.2023.08.09.09.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:18:44 -0700 (PDT)
Date:   Wed, 9 Aug 2023 13:18:38 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     gregkh@linuxfoundation.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v3] staging: vme_user: fix alignment of open parenthesis
 and deleted trailing spaces
Message-ID: <ZNO8XmOpylyE0AWS@alolivei-thinkpadt480s.gru.csb>
References: <ZNJKTLZ62SZMM6D8@alolivei-thinkpadt480s.gru.csb>
 <ZNOizFnDXojT4s85@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNOizFnDXojT4s85@nam-dell>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 04:29:32PM +0200, Nam Cao wrote:
> On Tue, Aug 08, 2023 at 10:59:40AM -0300, Alexon Oliveira wrote:
> > Fixed all CHECK: Alignment should match open parenthesis
> > and deleted the trailing whitespaces as reported by
> > checkpatch to adhere to the Linux kernel coding-style
> > guidelines.
> > 
> > Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> > ---
> > 
> > Changes in v3:
> > - Rebased against staging.git and staging-next branch, noted by Greg KH
> > 
> > Changes in v2:
> > - Fixed changelog, noted by Greg KH
> > 
> >  drivers/staging/vme_user/vme.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> > index 977c81e2f3c7..741593d75a63 100644
> > --- a/drivers/staging/vme_user/vme.c
> > +++ b/drivers/staging/vme_user/vme.c
> > @@ -563,7 +563,7 @@ EXPORT_SYMBOL(vme_master_request);
> >   *         returned.
> >   */
> >  int vme_master_set(struct vme_resource *resource, int enabled,
> > -		   unsigned long long vme_base, unsigned long long size, 
> > +		   unsigned long long vme_base, unsigned long long size,
> >  		   u32 aspace, u32 cycle, u32 dwidth)
> 
> As Greg said, it doesn't look like this in staging tree, so your patch doesn't apply.
> 

Hi Nam,

I did all the steps to have my branch updated with the origin/main
branch, but I've found out that was something more.

> However I look it up and the last change to this line was 12 years ago, so I doubt
> that it is because you didn't rebase to Greg's tree. I think the more likely
> possibility is that you have a commit to this line yourself (by mistake perhaps?),
> and this patch is on top of that.
> 

Thank you for poiting that out. You're right. I found that was indeed an issue on my
side thanks to your input.

> Make sure you don't have any accident commit that modifies this line in your tree.
> 

There was indeed and accident commit modifying more than one line in my
tree, hence the "trailing whitespaces" messages in one of the commits.
So, to clean evertyhing up, I decided to drop these commits and start
all over again, from scratch. That way I'm sure I'm not messing up
anything else. I just sent a fresh patch in another thread.

> Best regards,
> Nam

Thank you.

Alexon Oliveira
