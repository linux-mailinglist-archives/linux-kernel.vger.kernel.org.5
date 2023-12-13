Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D460810AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378656AbjLMG5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjLMG5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:57:39 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A507AC;
        Tue, 12 Dec 2023 22:57:46 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b9fcb3223dso3470587b6e.3;
        Tue, 12 Dec 2023 22:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702450665; x=1703055465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rlqkEABFGnEx4mQf1+94PdsZHbFITiKp+Rbi57V0c3s=;
        b=ntq7rfRW+y31WlpMI8cJ5qpf/9yDzsVGFgwAtJsqTq22EMDWBvTcePsK1gPD+vsgo9
         cLmRT+NN/P+lRoj4LbgiX1grIRbr7wqPHuv6/SOLXWgjOuEYp3bzsZKztEvUQ9eVANi1
         m83MSxDLNnaL6cJIj4SVi3kVaOgc2lN9q5pjhyUKm4+mJhyb0iu/PHnRHnPpralpKwQT
         YVfdrHSsRDiN36MD7FTkLxCEbtGGnVb9RFX82UAF2az8dBQHwLXXjrzEZMc05wWcYvJO
         kZBPYho3Eykk4s0CkqmBHQYAvO/ugmzbVYzO0zB9TKNttGd+VvCe5SXSyBMqH+7CIFlR
         ZOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702450665; x=1703055465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlqkEABFGnEx4mQf1+94PdsZHbFITiKp+Rbi57V0c3s=;
        b=p14ESy8Pq8t4FzTPDFdvBYPdGJUCQnk7oFVHN7vG3xf2qQgXU6V/AmeuKB5uZliwZF
         IQPczHOl2nSgvUyL9eZ4np8i/al26ZmRN4ATDVJ2jjDdNB0REtl/40flCTEbecc5QdVn
         QTj/31M1ijNrUyRlO16b1Quiog9+nx9/uCfvpjZErreC/JSRzV4yMYGWOfyhFtCA+Zhs
         5GOlbDijqfZWkXjjmHvfLoSi/am0bYlpERxNY5bYDixIXbygn1uMmkS1HNOtStygE9Re
         AX8QqjEh8Ms8w8aUuT+59vPnIk5KgFX8XUMi/JgWcRTuxV8eqndRK3IA2svv09c0y1CA
         9e/A==
X-Gm-Message-State: AOJu0Yyv3bEdx49sjPsyEI2ScjU+YHBbUakbHmdEV08v7EOWek7Hcji2
        jKtwBnGZfaBIA+YjOi2cmrs=
X-Google-Smtp-Source: AGHT+IFUnuCIf6lRLHiJgHr+wSOs/A+NwcLuoaCMUs381S+KgiCBHQ7KeraK0NaGm0O3R4Ad8/uq7Q==
X-Received: by 2002:a05:6808:210d:b0:3b8:b063:adf2 with SMTP id r13-20020a056808210d00b003b8b063adf2mr10186577oiw.79.1702450665464;
        Tue, 12 Dec 2023 22:57:45 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:96c1:256f:67e0:c0db])
        by smtp.gmail.com with ESMTPSA id 19-20020a631753000000b005bd980cca56sm9138178pgx.29.2023.12.12.22.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:57:45 -0800 (PST)
Date:   Tue, 12 Dec 2023 22:57:42 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ye.xingchen@zte.com.cn
Cc:     jiangjian@cdjrlc.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, jeff@labundy.com
Subject: Re: [PATCH v2] Input: mouse: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <ZXlV5miOaHR6Giaz@google.com>
References: <202212021453578171100@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212021453578171100@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 02:53:57PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with sysfs_emit() to simplify the code.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied, thank you.

-- 
Dmitry
