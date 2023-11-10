Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362EF7E76D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbjKJBvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKJBvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:51:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7823144BA;
        Thu,  9 Nov 2023 17:51:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D84AC433C8;
        Fri, 10 Nov 2023 01:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699581104;
        bh=lxHFf+cJVyuGyX81+L2NmmRwViLV5SlJHHQH9byJyfg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W5NK1hJgRBAVp5r2VqL12zxpJ8rvnR5T+pYrM8pR+cz343NvxRUsURFNl1RJdu4Ms
         +jIItb/Kb0CiAfLpjCyjC59peLSsmErjgsurwkNzmxSnQLR8TbSiUTVYv9ILJfRS/w
         HiD/fJvaSgA6zFNJP+HT+qcJ9MImLla9ZAmHdYQA=
Date:   Thu, 9 Nov 2023 17:51:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Pratyush Brahma <quic_pbrahma@quicinc.com>,
        Tomas Mudrunka <tomas.mudrunka@gmail.com>,
        Sean Anderson <sean.anderson@seco.com>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH 0/8] generic command line v6
Message-Id: <20231109175142.49428d5f51325680764663bf@linux-foundation.org>
In-Reply-To: <20231110013817.2378507-1-danielwa@cisco.com>
References: <20231110013817.2378507-1-danielwa@cisco.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Nov 2023 17:38:04 -0800 Daniel Walker <danielwa@cisco.com> wrote:

> This release is an up-rev of the v5 patches. No additional features have
> been added. Some changes were mode to function names and some changes to
> Kconfig dependencies. Also updated the config conversion for mips.
> 
> There are a number of people who have expressed interest in these
> patches either by asking for them to be merge or testing them. If
> people are so inclined please continue to request them to be merge
> or to ask the status of the next release. It's helpful to motivate me to
> release them again and for the maintainers to see the interest
> generated.
> 
> These patches have been used by Cisco Systems, Inc. on millions of
> released products to great effect. Hopefully they can be used by the
> entire Linux eco system.
> 

fyi, none of the above is suitable for a [0/N] changelog - it's all
transitory stuff which tells readers nothing much about what the
patchset does.

And that info is sorely missed.  I can see that it's a code cleanup,
but I'm sure Cisco wouldn't expend resources to maintain such a thing. 
There's something else here.

In [1/8] I see "Even with mips and powerpc enhancement the needs of
Cisco are not met on these platforms" and "This unified implementation
offers the same functionality needed by Cisco on all platform which we
enable it on".

Well OK, what are these needs?   What functionality changes does this
patchset offer which Cisco finds useful?  IOW, what were the
requirements?  What's wrong with the old code and how does this
patchset fix/enhance that?


I see the patchset updates nothing under Documentation/.  Should it do
so?  Could it do so?


I don't know what is the expected merge patch for this work.  I can
grab them if no other maintainer is in the firing line.
