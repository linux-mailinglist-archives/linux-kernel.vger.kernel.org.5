Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3B7E2C9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjKFTG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjKFTG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:06:56 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB21BB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:06:54 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1dd71c0a41fso3018242fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncf.edu; s=google; t=1699297613; x=1699902413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vYgbVooXzG9bXvnAO9hh0cIK7Z3AtpRVQORTv9KMDa0=;
        b=GhQMWMCj5tCwqthSVNwzIaTq48B+q/dZWKKnlyAo/Mqs0lpBigQJSs3SCVoULGuwCW
         Z2oVsxSApPrT+A5rbrgv4KDocDVhbK8wz1nZpeam61JB56ymQ74Jcu2vDg9NovC4b701
         Mg1aaCnj5ePR2zvYBFSuCWZuYroVZ0lZu9Z4Zjxu2bm11G5clSXJjQ3KLfQh0kcEN4jO
         iiV0ZkPPrgqFDCQOjemjClfnefiq75kxhdJeHwB1KYM894pleyphQYsd6FmAhW5pBhJ2
         AObnZ8QVEspwEsvcCb+Mwe1vQE011ROPM77yYh1ZIR8muP2EEKQMts61hSGxeq1//FJj
         sZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699297613; x=1699902413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYgbVooXzG9bXvnAO9hh0cIK7Z3AtpRVQORTv9KMDa0=;
        b=IklEIW3VQFy1KhcViFc21010zaDkZ+b/dX/DnQVKQiFjs159cGxNddOQ8zNN71Y3ft
         3Zv2k25tZVKNmH3oFGmshAfBBNhvceEiSDaoFu0SsFuObxVoDDKKObbegU9QhKR1asye
         xU92FCyzo05Q+cjsYW0f2JO6Y8Ft7B/d0zR3sfJeDs6PAg89qOSsmck3BEESiYgh7l91
         s9nZhjZmWnJuDyG3oDO/VLkS1/hX6snnGyiUOguCG3Bhxa0dCVTIq7HYRQqYGfdRGdhv
         aac+//RPXrp/Xxc4vmgulUkb2QEQ/apnOq8RLFhf0Jbs/rhrbPq0rdt1jkTGuO1oMn0W
         w1JA==
X-Gm-Message-State: AOJu0YxHdQS2EDl/4XaxFm+llCybqo82Upr281UytdR4I13vABlZOgAF
        M+NqTEyJ90WZCmRdRyO6l6tmMQ==
X-Google-Smtp-Source: AGHT+IH9OffbmsvZj+QnoxsyZtHU5JoQN6Vh73gHIVV9NgsvSQfbLQDqJBZsTJlf5jNN45d5OrYJSw==
X-Received: by 2002:a05:6870:11ca:b0:1ea:29a:8628 with SMTP id 10-20020a05687011ca00b001ea029a8628mr549121oav.15.1699297613453;
        Mon, 06 Nov 2023 11:06:53 -0800 (PST)
Received: from localhost.localdomain ([2601:580:8201:d0::d089])
        by smtp.gmail.com with ESMTPSA id ft8-20020a05690c360800b005a7b8d12f52sm4617500ywb.40.2023.11.06.11.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:06:53 -0800 (PST)
Date:   Mon, 6 Nov 2023 14:06:51 -0500
From:   Hunter Chasens <hunter.chasens18@ncf.edu>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        alexander.deucher@amd.com, evan.quan@amd.com,
        christian.koenig@amd.com
Subject: Re: [PATCH v1] drm: amd: Resolve Sphinx unexpected indentation
 warning
Message-ID: <irp2myv4jp6o7vut5m7ax4hya5764xzustf2klxfpys42qmevk@yxxus464hito>
References: <20231105210044.70371-1-hunter.chasens18@ncf.edu>
 <ZUh2fuCjmgle3vd9@debian.me>
 <665794d7-38e0-4e74-9af7-eca986792e44@infradead.org>
 <ZUigbshGGc451V5L@debian.me>
 <875y2f193t.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y2f193t.fsf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, apologies to Jani Nikula. I accedently top posted on the other thread.
My email client is giving me a hard time. The following works and, if 
everyone agrees, I'll send out a v2.

 * E.g.::
 *
 *  S: 19Mhz *
 *  0: 615Mhz
 *  1: 800Mhz
 *  2: 888Mhz
 *  3: 1000Mhz
