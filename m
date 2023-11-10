Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5419B7E827D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346106AbjKJTUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346169AbjKJTUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:20:18 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCF925080
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:44:50 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9e61e969b1aso74576166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1699609489; x=1700214289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uNNVKkYwl/rOA9GX9/SH18oSRKfcJIfb4LTGsk7JdWQ=;
        b=jII52okwjfFGPIjLsibgww2+k7nV0tKlx4s8SQQwWNsZ4NJ9p09O+9mw489INMJe4m
         dvxZpSJQzHjDrIEtIRhS3ffkZfcKwSUaKO0CEwOT5dDlIxRV04Ri433CjVFbyFesiDTD
         jZwuyULGMnJg6D8BzQ/oZsJKTkVNaXt91gn8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699609489; x=1700214289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNNVKkYwl/rOA9GX9/SH18oSRKfcJIfb4LTGsk7JdWQ=;
        b=ECSvzpkRQiurjK5heLlFytbS9cYQg2nxC+KukSZxoRwf4ID2oaG7bhpOI5xDmLNC/1
         jC8z6Y0foFqZ/TU7BBTXeqWJx8GKpBAH6cyD492yVbfBSLEMyPGu1fmxmUkDoLdCp4wn
         ozzJkppjqGKpCiFAJDTOTgoSjd9p3HcXsvuOqt053QUhj3zWI8fTe04KocBWPW4z/QnE
         EYadofoUNC6HOgm1DtQ3V4MDQ2ZbScOBlUeoIy9Tqu64Qq2cRqHmcOAeoxM4I+dGFTew
         zMdskAcGo46/cyZsYV2YU55emRP0JLVeHCqqEua2IuI4EyApRUzvrKuKwyfnQX/3kAYx
         UouQ==
X-Gm-Message-State: AOJu0Yznl2wb1XJEzPaLymkbGIM76rN4u6MQd22PyoNbZR6ZD4a3X52S
        sQZPVRbQ3IGhqfZBqVlJVr7m+ehX33fd3YOtt95FBw==
X-Google-Smtp-Source: AGHT+IHEDrhaS3SWGbZqZuG8sNPuZIIpHaBGL3VI6Da90hnwL9tRuf2Y3uqzB5/P6YHOqBSOAeAfq99hTGSbttzq3wg=
X-Received: by 2002:a17:906:8910:b0:9e4:121c:c292 with SMTP id
 fr16-20020a170906891000b009e4121cc292mr3096666ejc.77.1699609488646; Fri, 10
 Nov 2023 01:44:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699564053.git.kjlx@templeofstupid.com>
In-Reply-To: <cover.1699564053.git.kjlx@templeofstupid.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 10 Nov 2023 10:44:37 +0100
Message-ID: <CAJfpegtOKLDy-j=oi8BsT+xjFnO+Mk7=8VxSDuyi-bxhRSGMKQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fuse submount_lookup needs to be initialized
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
        "Saarinen, Jani" <jani.saarinen@intel.com>,
        lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        regressions@lists.linux.dev, intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2023 at 23:37, Krister Johansen <kjlx@templeofstupid.com> wrote:

> Either should do, but I wasn't sure which approach was preferable.

An incremental is better in this situation.   Applied and pushed.

> Thanks, and my apologies for the inconvenience.

Really no need to apologize, this happens and the best possible
outcome is that it get fixed before being released.

Thanks,
Miklos
