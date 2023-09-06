Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556ED794147
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbjIFQQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjIFQQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEA2198B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 09:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694016940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySBQ8UU2v3ruiAA4bTZ1K97iZuDORkFQAMOFS4JWWBs=;
        b=b7TJ87aQBNI+WTsIwLyd+D1VuFx0oF5wmqrfjPA7Vj4WZBQ39Rugz/F4LKYcRxOg8BfO7U
        LinuWfuQVlQznb2EeDAr0wLDTlp+K8lFPwBTkY7UEy+oR1xvOd4t7e9VWlydXpsbtbic0q
        opEh4UDD15jMvC/0vKQwv48FGgphl2A=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-UGuRLipKOqCxQLX6pyEEFA-1; Wed, 06 Sep 2023 12:15:39 -0400
X-MC-Unique: UGuRLipKOqCxQLX6pyEEFA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4121c086963so429171cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 09:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694016938; x=1694621738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySBQ8UU2v3ruiAA4bTZ1K97iZuDORkFQAMOFS4JWWBs=;
        b=KLrGCgr+HbbHSWwh9jDD5VQDUfGICd+ejPcVjtU6VeXRiPCe+UbsXXNbGnZzdNusmb
         PPlpOFaFchzk1QW5ViX+1aQxmxGY0CgL49YUlCXS1T5q2qZ1lseSqmFvhZwFFbMhmvtQ
         sv8me6csJtoLiekcAr66l/ZgpXGEqefv0p0nkxHVcZk7oSs1QNhuLNNuYzHO9dfDD0aA
         G5aJnvQZfkutTrF0CUzmcek6lmcEULrqGHLMHas6DdwOB3cGDWfHxb2FnkXPNeq4qGfq
         kRd409ls+yPLnN2xzNY0nYnoy1QdDu5KC2F1jTdXym1/OslvElEypAhOdaysqwJQhFb1
         1NlA==
X-Gm-Message-State: AOJu0YxggBiSiqI5IybyC3LI5+x44WMDe2aW2XZ8MA7wIYv9XvDE9JNx
        l+xaRYUovnIyOFnSBkf/8Ge5SPiy3eJmY1yCuonMoOrDarcg4sGjgUBmmluBRJI63SwDnhi4W2B
        OqxbOSstkq4OPbq0migw2tk+vIe9lT+SEmTiz9pqb
X-Received: by 2002:ac8:7ef0:0:b0:414:ed76:bea1 with SMTP id r16-20020ac87ef0000000b00414ed76bea1mr1132363qtc.67.1694016938577;
        Wed, 06 Sep 2023 09:15:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG008JiqeqVkvqHQZFk51x1f9Ml14ocAwGpDZbzp2uKfdk4jeAuXVQtoHjOvPCQ5l9xRL/5vzpaFT68eIIdCAA=
X-Received: by 2002:ac8:7ef0:0:b0:414:ed76:bea1 with SMTP id
 r16-20020ac87ef0000000b00414ed76bea1mr1132349qtc.67.1694016938191; Wed, 06
 Sep 2023 09:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230831063129.335425-1-leobras@redhat.com> <20230906140947.GA33104@noisy.programming.kicks-ass.net>
In-Reply-To: <20230906140947.GA33104@noisy.programming.kicks-ass.net>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 6 Sep 2023 13:15:27 -0300
Message-ID: <CAJ6HWG7H1EtWRcNLc=Ka-PGnJ9MRQ0Ft8PHBRnwadRNRSUxjEA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] smp: Change function signatures to use call_single_data_t
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 11:10=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Aug 31, 2023 at 03:31:28AM -0300, Leonardo Bras wrote:
> > call_single_data_t is a size-aligned typedef of struct __call_single_da=
ta.
> >
> > This alignment is desirable in order to have smp_call_function*() avoid
> > bouncing an extra cacheline in case of an unaligned csd, given this
> > would hurt performance.
> >
> > Since the removal of struct request->csd in commit 660e802c76c8
> > ("blk-mq: use percpu csd to remote complete instead of per-rq csd") the=
re
> > are no current users of smp_call_function*() with unaligned csd.
> >
> > Change every 'struct __call_single_data' function parameter to
> > 'call_single_data_t', so we have warnings if any new code tries to
> > introduce an smp_call_function*() call with unaligned csd.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
>
> Fair enough, I'll go queue it somewhere.
>

Thanks Peter!

