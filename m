Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0507C70AB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347050AbjJLOse convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 10:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjJLOsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:48:32 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3B0BB;
        Thu, 12 Oct 2023 07:48:30 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id DD3C7160680;
        Thu, 12 Oct 2023 14:48:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 29DF017;
        Thu, 12 Oct 2023 14:48:25 +0000 (UTC)
Message-ID: <e212997cf8b05608718fb6ac1766c390255664ac.camel@perches.com>
Subject: Re: [PATCH v3] Documentation/process/coding-style.rst: space around
 const
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <ojeda@kernel.org>, dan.j.williams@intel.com
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, max.kellermann@ionos.com,
        workflows@vger.kernel.org
Date:   Thu, 12 Oct 2023 07:48:25 -0700
In-Reply-To: <20231012115039.1680561-1-ojeda@kernel.org>
References: <65271731e25f4_7258329472@dwillia2-xfh.jf.intel.com.notmuch>
         <20231012115039.1680561-1-ojeda@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 29DF017
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: o4bafx189b39fosaj9tugy1ng4t4hk6t
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18cEtRlNQpeQGZ7fw6pYLI6AhZUUOJ6xzw=
X-HE-Tag: 1697122105-37381
X-HE-Meta: U2FsdGVkX18LWY7kGsCiHQheQS4LqScy5dMW4qcBmdEHxO9ovUtXsMDNt3FkAATB6QEVj6OE5VKr4UAFNsAIwCqNYT78sS4IRUUdbpxEdwKbbQiuvZYmLA0q2w62E505D9p82THAebCe0EGd52BqQclvNnrB5jm3bYx30j0SfbAxRC90tUbNKQy0c3xbr70M0yWot2aDEWRaqUOjn3XUH8cUDtBfDujq+ldDZInBI6tHkpR6v5xxZk3rcr+RtUDYYT1F8yAEHIkHPJ0TLX5zI3adAfzmscsrlj8yQVrLZBgZUW4dEFQMHoHH+Hx0aj/d
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-12 at 13:50 +0200, Miguel Ojeda wrote:
> On Wed, 11 Oct 2023 14:44:17 -0700, Dan Williams wrote:
> > 
> > I notice that clang-format reflows that example to:
> > 
> >     const void *a;
> >     void *const b;
> >     void **const c;
> >     void *const *const d;
> >     int strcmp(const char *a, const char *b);
> > 
> > ...but someone more clang-format savvy than me would need to propose the
> > changes to the kernel's .clang-format template to match the style
> > suggestion.
> 
> I think we could use:
> 
>     diff --git a/.clang-format b/.clang-format
>     index 0bbb1991defe..9eeb511c0814 100644
>     --- a/.clang-format
>     +++ b/.clang-format
>     @@ -671,6 +671,7 @@ SortIncludes: false
>      SortUsingDeclarations: false
>      SpaceAfterCStyleCast: false
>      SpaceAfterTemplateKeyword: true
>     +SpaceAroundPointerQualifiers: Both
>      SpaceBeforeAssignmentOperators: true
>      SpaceBeforeCtorInitializerColon: true
>      SpaceBeforeInheritanceColon: true
> 
> At least that makes it match the documentation example -- I got this:
> 
>     const void *a;
>     void * const b;
>     void ** const c;
>     void * const * const d;
>     int strcmp(const char *a, const char *b);
> 
> But it is only supported in version >= 12, so we need to wait for the
> minimum LLVM version bump.

Do older versions of clang-format ignore entries
they don't understand?

