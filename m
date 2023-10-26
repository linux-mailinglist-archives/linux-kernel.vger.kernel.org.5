Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09637D85CE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345413AbjJZPSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjJZPSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2494D7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698333444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fgM36SpZwrGqrgTUTrL8+qbWVWryBY61X1wo6VnsJ+g=;
        b=RhIfrT3+Ssj7aU0BQFKvAbVC+pxj299g9XfwlvFuKCsPgkEnelrcx8kgyDcArqwiA+asWM
        OE2D+Mmu6nrLWAYgsMcn4A3IhpFB5Im4vOYshSYSdr0xkSDnSyub0Z5/C28zb+/ZnX/Y87
        i3AJEMDE1XQIFQ8PbV+nMOTOY8lEbSY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-yjZ39dIjMbOfvDQibIEnqA-1; Thu, 26 Oct 2023 11:17:23 -0400
X-MC-Unique: yjZ39dIjMbOfvDQibIEnqA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-53df95eaebfso758515a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698333442; x=1698938242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgM36SpZwrGqrgTUTrL8+qbWVWryBY61X1wo6VnsJ+g=;
        b=hwmbasl5YNeE3wue8j8aiCvd4s2aRCeaKPTQ5v0ZSi+KPLvU/w8mUr6RnEdjySy9tP
         OYDVTefsEIeImz3Yv89MBy4vpxYi4ZF54YU6/DOErC7vn6sloOYPsYOXJZ9rb4Br3eMh
         Yey4qUdIJcAyi/5q/InvmufatQEVEo1xixk4uI4EF+Xy5vnRhNA6LPqW6d6bEGLBWXeL
         LEB7Lfkm8D5jJgSn1CUsIaLQefFtRHOpucsWGePV4LyCBjhBQWYl6RocJZH5aXBWQ3wV
         uAQm/xg8ZCH7YDAdGXvFEQKcWdXr9K5L02WPPi5pa6wtPYmuJCDenP+mpB+sI8EG/e7z
         056Q==
X-Gm-Message-State: AOJu0YySFSdWA35B9qBYFr4os7dd4xp9LlF0XtQ6u9ACnjZFQ93DV1bj
        DAWYNLUNgU6bhtzj8MqxDH5OFYek99RqHH8njSlzIH+iEl97dGHHys65Sb8WdDch8V2r73ioJky
        Zm8Oy2TT96A9UUc8eXuh1dYfg
X-Received: by 2002:a05:6402:a54:b0:53d:d799:641 with SMTP id bt20-20020a0564020a5400b0053dd7990641mr42927edb.26.1698333442294;
        Thu, 26 Oct 2023 08:17:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqCfzj7EKvJtyLSrooN8GJkqXWkwTAxwCVKw/7OBanp3iLeG6msWIgxR6CSOpTrj2/moQaKg==
X-Received: by 2002:a05:6402:a54:b0:53d:d799:641 with SMTP id bt20-20020a0564020a5400b0053dd7990641mr42908edb.26.1698333441671;
        Thu, 26 Oct 2023 08:17:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:37eb:8e1f:4b3b:22c7:7722])
        by smtp.gmail.com with ESMTPSA id w12-20020aa7cb4c000000b0053e7809615esm11362265edt.80.2023.10.26.08.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:17:21 -0700 (PDT)
Date:   Thu, 26 Oct 2023 11:17:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Abhinav Singh <singhabhinav9051571833@gmail.com>,
        akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, shakeelb@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2] Fixing directly deferencing a __rcu pointer warning
Message-ID: <20231026110925-mutt-send-email-mst@kernel.org>
References: <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
 <20231026121621.358388-1-singhabhinav9051571833@gmail.com>
 <20231026091222-mutt-send-email-mst@kernel.org>
 <CAGudoHFXH_FDgKRaJvVgQ3W8wD2TC=8yhiNm1NECApnQ-CNAZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFXH_FDgKRaJvVgQ3W8wD2TC=8yhiNm1NECApnQ-CNAZQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 04:06:24PM +0200, Mateusz Guzik wrote:
> On 10/26/23, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Thu, Oct 26, 2023 at 05:46:21PM +0530, Abhinav Singh wrote:
> >> This patch fixes the warning about directly dereferencing a pointer
> >> tagged with __rcu annotation.
> >>
> >> Dereferencing the pointers tagged with __rcu directly should
> >> always be avoided according to the docs. There is a rcu helper
> >> functions rcu_dereference(...) to use when dereferencing a __rcu
> >> pointer. This functions returns the non __rcu tagged pointer which
> >> can be dereferenced just like a normal pointers.
> >>
> >> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> >
> > Well yes but these need to be called under rcu_read_lock.
> > Who does it here?
> > If no one then maybe you found an actual bug and we need to
> > fix it not paper over it.
> >
> 
> There is no bug here.
> 
> p is the newly created thread, ->real_cred was initialized just prior
> to this code and there is nobody to whack the creds from under it.
> 
> Second bit in the patch changes one real_parent deref, but leaves 2
> others just above it. Once more no bug since the entire thing happens
> under tasklist_lock, but the patch should either sort all these cases
> or none.
> 
> I think it would help if the submitter had shown warnings they see.

Yes, and this must be tested under lockdep, which I think would
spit out warnings for this patch.

What should be used here I'm not sure. IIUC rcu_dereference_protected(p, 1)
is discouraged now?

-- 
MST

