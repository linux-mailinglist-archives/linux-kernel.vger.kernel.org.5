Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DB27732FC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjHGWfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHGWfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:35:10 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3E5B3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:35:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bba54f7eefso39717845ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691447709; x=1692052509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrSJOVIYm0J63L8lzd4vJtLyRiYvw7Jbfj/HVTN6X5o=;
        b=ogWaphqB3IT7y+3GNv3uht9XnVixrdnmCbEZ6+/iwCSz9DXF/SNr5jiKhwmT6ylz7i
         n4L5Lmi+DXiEMqTACWqwApFwMTeXyIGybIMJq36kGFTUAP5MElK3yykG1RXSpegu2u2e
         NEuC3cAzA1nsPg5Ysgr9P5fDHFauEFJaX0WFEE7dWba12uTaxYtuC3UP12TpozNDXiYX
         ffuSrb1koT2E9AFVL9nd7K84JfoGl7aeCbL5dq/FkQhFmUXRKAvIInE1NLpRKlZnMlUj
         DiUAfYpcTJOHa+uI1uMSMwk02T/Wd3ULev/qH9NdoKIPa+KCYqlJZyUDORFhsY9p8rE3
         u88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691447709; x=1692052509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrSJOVIYm0J63L8lzd4vJtLyRiYvw7Jbfj/HVTN6X5o=;
        b=Qe1FmAY2Ni5wEldCULqWAsSX8u0g3UZKX55u2Vt4Yze/+MmmIc41a6pE/tnCV0AGhm
         C0MyqBnaKQVb2UyPpR67Qmbzj6IXMgtfdfcLIqorEYb9sjjbuKHkfMvQwrsGMBwV1Sav
         lUZLRySoU3Pz24k9LRVN3CJ23E+D5o4cT7/YRniAjh9YYSB/+6C5rGdy3ShYwSpOqNDo
         FMH47oM/yYMofP+XzrOseW6b310PdwsIevWcFPk52ohOvLVKxlhoZGZIRv8CrPSc/7M9
         mGs7IjRXIJlhukzN7b9qAr+glv3ssnbrjaemUCRBZSJvlwond2fEUBPtADSDzhVviZqu
         FLDA==
X-Gm-Message-State: AOJu0YxqKhl1KOaj1LXKGmM/6kNkSxtpYN7+/AGDpnob+CP13O4a/IBV
        b1M21P9UzJkduZjhHHKMPQY=
X-Google-Smtp-Source: AGHT+IFoBiIXQXriBOFxPgBzF5CkKbaBoF8QAfHwzR8pZZDJS0MFvK5+FEafK8ZG1S8lys7sUU8ODA==
X-Received: by 2002:a17:902:c409:b0:1b5:5162:53bd with SMTP id k9-20020a170902c40900b001b5516253bdmr10571083plk.33.1691447708765;
        Mon, 07 Aug 2023 15:35:08 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id jw21-20020a170903279500b001ba066c589dsm7402465plb.137.2023.08.07.15.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 15:35:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 7 Aug 2023 12:35:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Aaron Tomlin <atomlin@atomlin.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH] workqueue: Rename rescuer kworker
Message-ID: <ZNFxmnGHxV0z5gKA@slm.duckdns.org>
References: <20230807220637.3203739-1-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807220637.3203739-1-atomlin@atomlin.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:06:37PM +0100, Aaron Tomlin wrote:
> Each CPU-specific and unbound kworker kthread conforms to a particular
> naming scheme. However, this does not extend to the rescuer kworker.
> At present, a rescuer kworker is simply named according to its
> workqueue's name. This can be cryptic.
> 
> From the context of user-mode, it can be useful to identify a rescuer
> kworker since their CPU affinity cannot be modified and their initial

I'm not necessarily against the rename but you can't, or at least shouldn't,
modify the cpu affinity of any workqueue worker. You don't know what that
worker is going to be executing even at the moment when the cpu affinity
change is committed, let alone in any future. Can you please drop that part
from the patch description? It doesn't make a lot of sense.

Thanks.

-- 
tejun
