Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C815B788F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjHYS7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHYS7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:59:00 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391212126
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:58:56 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RXTkk46QwzMq2xq;
        Fri, 25 Aug 2023 18:58:54 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RXTkh6ZYLzMppKV;
        Fri, 25 Aug 2023 20:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692989934;
        bh=9t9z0AWfKvu8cmYtluHWW8vh3FOqoGb0HQ1F5uA1RdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kIsvixOWC6Vjz3deh4q1Kn0GMFc8uDMkLy6yZsDQGuW7OOgFvH3HwnlTwYkJVcgU2
         /GnsSFIcAZeV8IJehrZEQusi3lM05J+kNEJVeNuA3Vby+RD2WOLdkcpkc54WZHuJgf
         uj9xDxg2HNHq0eDiWSp+Vjjf+gSKR0b2jikhZjhc=
Date:   Fri, 25 Aug 2023 20:58:49 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v13 11/11] LSM: selftests for Linux Security Module
 syscalls
Message-ID: <20230825.Oun6quaengoM@digikod.net>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-12-casey@schaufler-ca.com>
 <20230825.OokahF6aezae@digikod.net>
 <9537cf00-575c-b57e-29ca-0b49be6617b9@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9537cf00-575c-b57e-29ca-0b49be6617b9@schaufler-ca.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 11:14:15AM -0700, Casey Schaufler wrote:
> On 8/25/2023 8:01 AM, Mickaël Salaün wrote:
> > These tests look good!
> >
> > I suggested other tests to add in my previous emails.
> 
> Some of the tests you've suggested will be very difficult to implement
> in the face of varying LSM configurations. I need to defer them until a
> later date.

Sure, some might be difficult, but some bound checks (e.g. extra flags)
should be doable.

> 
> > I'd suggest to re-run clang-format -i on them though.
> 
> I assume you're recommending a set of options to clang-format
> beyond just "-i". The result of clang-format -i by itself is
> horrific. 

I just ran clang -i (with the default kernel configuration, which is
taken into account by default). This just add four changes: the PROCATTR
define and three ASSERT*() calls, which are not too uggly IMO.
