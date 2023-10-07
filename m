Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ADB7BC68D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 11:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343769AbjJGJvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 05:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbjJGJvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 05:51:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F65BC;
        Sat,  7 Oct 2023 02:50:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82C5C433C8;
        Sat,  7 Oct 2023 09:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696672259;
        bh=BpvrhegrCV1J4cKymgkwU4t6EVNh8m5OfKQGXvcEXDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSPya9UeLlHx9QhsfamPOjcW275Ghv9CzwmpfigLJO/kJTZ04QUbhXBdIco+fn28K
         YQOYlLMtkKvjUUc960lanETvTjUxcpgg3yJOVLzYPQEzJ9lVsFjJbl7gCQriVKI10y
         L/6gqL1UGXZX3Ck+qLAQvPKBdonmGWnsUIuOx8iM=
Date:   Sat, 7 Oct 2023 11:50:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bryan Jennings <bryjen423@gmail.com>
Cc:     Lang.Yu@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        olvaffe@gmail.com, sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 13/22] drm/amdgpu: install stub fence into
 potential unused fence pointers
Message-ID: <2023100750-unraveled-propeller-3697@gregkh>
References: <2023083119-phoney-ascend-d4ec@gregkh>
 <d32d6919-47cf-4ddc-955a-0759088220ae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d32d6919-47cf-4ddc-955a-0759088220ae@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 03:43:01PM -0500, Bryan Jennings wrote:
> This is also causing log spam on 5.15.  It was included in 5.15.128 as
> commit 4921792e04f2125b5eadef9dbe9417a8354c7eff.  I encountered this and
> found https://gitlab.freedesktop.org/drm/amd/-/issues/2820 while researching
> the problem.

Confused, what should we do here?
