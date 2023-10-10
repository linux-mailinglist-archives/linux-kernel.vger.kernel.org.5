Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D127C041F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343754AbjJJTKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343741AbjJJTKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:10:01 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43672A7;
        Tue, 10 Oct 2023 12:09:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DE7252B2;
        Tue, 10 Oct 2023 19:09:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DE7252B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696964999; bh=Z7weYXtz4ulfLKsxotgyt4mEYaMtmzAERr12ZieBYR4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=R5U9zo0QlRK2g+wYOyMr9ejbVZkVXjvdZsOD/60baNTay9dMXsoqe37tb2hpIr/XS
         GFFU3xRiXwjpXPe/Oxf2yVBPGL7bxE3URdxHSx3l4UcwHI+pn+WntIZa0YKGFFA4fe
         kAwYSunKBjfM/NGsCwQPr80ueqHmt4LLpw8xMcmFvZy0DNz2u1yYaCYYkHIPXpZJ+x
         ii3fG8fLf1OtOUSrghG1Lo1PXoUG5h8OuofsPvluvDNR83zM7zSFFKcfCJ5BScwlrr
         eZgVsxCxPtcKUzpNe9axTRxD3OGjuECO0ICPjQd8Ka0toU5PGuzq0au7Q0A0QctLhL
         BzD9NxxywVJ/Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vratislav Bendel <vbendel@redhat.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jozef Bacik <jobacik@redhat.com>
Subject: Re: [PATCH] docs: mm: fix vm overcommit documentation for
 OVERCOMMIT_GUESS
In-Reply-To: <CAHrQN1yOTTMz=RR0rJxr9aFVmTPgYyrabPzNH00Z-fToorrPjQ@mail.gmail.com>
References: <20220829124638.63748-1-vbendel@redhat.com>
 <YwzC01N62rtDvzQV@kernel.org>
 <CAHrQN1yOTTMz=RR0rJxr9aFVmTPgYyrabPzNH00Z-fToorrPjQ@mail.gmail.com>
Date:   Tue, 10 Oct 2023 13:09:58 -0600
Message-ID: <875y3e70qh.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vratislav Bendel <vbendel@redhat.com> writes:

> On Mon, Aug 29, 2022 at 3:45=E2=80=AFPM Mike Rapoport <rppt@kernel.org> w=
rote:
>
>  On Mon, Aug 29, 2022 at 02:46:38PM +0200, vbendel@redhat.com wrote:
>  > From: Vratislav Bendel <vbendel@redhat.com>
>  >=20
>  > Commit 8c7829b04c52 "mm: fix false-positive OVERCOMMIT_GUESS failures"
>  > changed the behavior of the default OVERCOMMIT_GUESS setting.
>  > Reflect the change also in the Documentation, namely files:
>  >     Documentation/admin-guide/sysctl/vm.rst
>  >     Documentation/mm/overcommit-accounting.rst
>  >=20
>  > Reported-by: Jozef Bacik <jobacik@redhat.com>
>  > Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
>
>  Acked-by: Mike Rapoport <rppt@linux.ibm.com>
>
> Hello,
>
> Poking this one as it's been Acked here without merging for over a
> year.  My humble opinion is that Docs should be up to date, reflecting
> the real behavior.

My humble opinion is that I must have screwed up somewhere; not sure how
this fell through the cracks.  I've applied it now, thanks and sorry for
the delay.

jon
