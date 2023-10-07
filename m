Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7477D7BC5F5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 10:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjJGIJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 04:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjJGIJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:09:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEA3DB;
        Sat,  7 Oct 2023 01:09:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60862C433C8;
        Sat,  7 Oct 2023 08:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696666190;
        bh=sFMB5SgWf3EqgbKlwxbdjmSh8EIjVCyP9hzXo8O3DTM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jk9wc+Cdi6UcxCc/oZbGNf37ZsszgQ7hNZ4ovJ7oGR7qRb9J8KyeWi8uFWGoaGD8A
         2dyi6PBv/ceT46bop2/8DWYhhr1x//ewK+AYrdB1nDlDrxWk+EDQ4CMjBko5YS+idS
         51rA9HLIhBquWI+Umh47ArR9me0PAdCfTYyusRK6jLkTKN0FGbVC0/CuH4cxlR0TCH
         f0IlqDl76bhNY9tNMrJDzyYlOaxklD/Geok+cVZsJIECiNxIBQbNOTVmyqRZ8a4Q6d
         5kr3HFsjYIBzU9DPymzKAQxD+Cfe5UPrrw63UO2pnks/aKLiMevPNoE6CFLgcxOygG
         FJL+wQGzEXIfQ==
Date:   Sat, 7 Oct 2023 10:09:46 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/2] Add support for inlined documentation for kunit and
 kselftests
Message-ID: <20231007100946.396187d4@sal.lan>
In-Reply-To: <87pm1vd4kb.fsf@meer.lwn.net>
References: <cover.1693550658.git.mchehab@kernel.org>
        <87pm1vd4kb.fsf@meer.lwn.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 03 Oct 2023 11:00:20 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab@kernel.org> writes:
> 
> > This is a follow-up of the discussions taken here:
> >
> >    https://lore.kernel.org/linux-doc/20230704132812.02ba97ba@maurocar-mobl2/T/#t
> >
> > I sent a previous version as RFC. This is basically what we had there, with some
> > improvements at test_list.py.
> >
> > It adds a new extension that allows documenting tests using the same tool we're
> > using for DRM unit tests at IGT GPU tools: https://gitlab.freedesktop.org/drm/igt-gpu-tools.
> >
> > While kernel-doc has provided documentation for in-lined functions/struct comments,
> > it was not meant to document tests.
> >
> > Tests need to be grouped by the test functions. It should also be possible to produce
> > other outputs from the documentation, to integrate it with test suites. For instance, 
> > Internally at Intel, we use the comments to generate DOT files hierarchically grouped
> > per feature categories.
> >
> > This is meant to be an initial series to start documenting kunit.  
> 
> I've played with this a bit...a couple of quick impressions:
> 
> - That's quite a chunk of Python code to be adding.  I've not yet had
>   the chance to read it through properly, will hopefully be able to do
>   so soon.  A bit more commenting would not have gone amiss here...

I'll try to add more comments when respin this series.

I guess I should also add a documentation similar to the one I wrote
for IGT [1]:
	https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/docs/test_documentation.md?ref_type=heads#documenting-tests-via-testplan

[1] this document is specific for the way IGT uses it; I'll write
    something similar to it considering the names we've agreed for
    KUnit.

> 
> - I kind of think that this should go under dev-tools rather than being
>   a new top-level directory.  Is there a reason not to put it there?

No particular reason. I'll change it to be under dev-tools/tests at
the next submission.

Should I wait for you to take a look at patch 1/2 before sending
a new version?

Regards,
Mauro
