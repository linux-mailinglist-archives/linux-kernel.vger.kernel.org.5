Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72492811EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442067AbjLMTSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjLMTSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:18:13 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECADA3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:18:20 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d098b87eeeso65079655ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702495099; x=1703099899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P4zCTjl8Zj5OEvodPkRWE7USQTKPwsDssLjsj8FI8bA=;
        b=lZz9CcOGQ28jt/M2KoCb8vMde8vGPhufwRb8bQuaSl436TZ9tXXsG9DAgyUwShg/Bn
         DSaROe7fmupWCKjwUTHAIa18mivqYHDb0JmqCq6i7MOQoDLZW6UGsJi3Tmd+eZotmUJE
         qlYgX3eIPGAIXsTXSS4MSFAkakwlxjQlqLRPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702495099; x=1703099899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4zCTjl8Zj5OEvodPkRWE7USQTKPwsDssLjsj8FI8bA=;
        b=m2KXvAIyFlrCk3QFgvsrIbx7RBqhAtYEZlHMyfV6Sf5b5Msl5j2QWXtnaOvM5KVPIC
         RWOgKNJVS3N7cPcQ8OglLyo1Dyl4RlTmUuJFjkYdWDDF6WiZLhyYb/iWMkfNGwoO8CL8
         nXdOKQiXEJ48UiziwdWvWqQ1l2r5gkgTE7n83elD8Q1fMaqWp+0oP/nyRg7xugAr6iAm
         OILK4u+wXJRdi+NpclF1S+fWIv72OaDaSojPkhbQVxCXq7dj8DXKod5F+JKpLcbFjSz+
         g76W1JSinuq4vCDl2gcqqOqrfCElK0i5N2QotDTexxq7S4DsUacZfmnK1xMtqOea7xRm
         y41Q==
X-Gm-Message-State: AOJu0YwgWRqCJNPUqD+xqy+7geCC9mpsKyY8H6MYM+XmLe9FSORxC/Vy
        mdpMzllQRSXFY9mHJUBFi7agoQ==
X-Google-Smtp-Source: AGHT+IEydW4l2gH+402jkdTt5SLR7TQ0ZIFYTA0HY674vt3HsfTPJnNPjcvD142Vjxqu4HfEnqVnrQ==
X-Received: by 2002:a17:902:e74e:b0:1cf:9c44:62e with SMTP id p14-20020a170902e74e00b001cf9c44062emr9894221plf.34.1702495099627;
        Wed, 13 Dec 2023 11:18:19 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902b58800b001d05bb77b43sm10882454pls.19.2023.12.13.11.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:18:19 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:18:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Anders Larsen <al@alarsen.net>
Cc:     Ronald Monthero <debug.penguin32@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] qnx4: Avoid confusing compiler about buffer
 lengths
Message-ID: <202312131118.F350E56D@keescook>
References: <20231130205010.it.412-kees@kernel.org>
 <170241597608.164694.1762861756800879766.b4-ty@chromium.org>
 <12341921.O9o76ZdvQC@oscar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12341921.O9o76ZdvQC@oscar>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 05:43:08PM +0100, Anders Larsen wrote:
> Hi Kees,
> 
> On 2023-12-12 22:19 Kees Cook wrote:
> > On Thu, 30 Nov 2023 12:51:17 -0800, Kees Cook wrote:
> > > This attempts to fix the issue Ronald Monthero found[1]. Avoids using a
> > > too-short struct buffer when reading the string, by using the existing
> > > struct union.
> > > 
> > > -Kees
> > > 
> > > [1]
> > > https://lore.kernel.org/lkml/20231112095353.579855-1-debug.penguin32@gmai
> > > l.com/
> > > 
> > > [...]
> > 
> > I'll put these in -next since there's been no more discussion on it.
> > 
> > Applied to for-next/hardening, thanks!
> 
> thanks for taking care of this (and apologies for me being unresponsive)
> 
> If it's not too late, feel free to add
> Acked-by: Anders Larsen <al@alarsen.net>

Thanks! I'll update the tags. :)

-- 
Kees Cook
