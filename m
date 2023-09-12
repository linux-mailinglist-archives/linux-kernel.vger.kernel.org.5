Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD01779CFFC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjILLcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbjILLbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:31:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C62D10DE;
        Tue, 12 Sep 2023 04:31:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D419AC433C7;
        Tue, 12 Sep 2023 11:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694518289;
        bh=g/mqhZ5VRqpjqHUFTtCPOZQA0fipLYIPInbPUYFDKgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMIzOaXL6n4FSgZS+c5S+Kcf5BL28RO1B0TyizWUzsAXxhv0BjHY/x0zCq7NTLmsD
         9cdqN9CXeLSvs/chCDtOrrzSklsZ7tyK8vMvjuHdyC/jwdvASI6hY0+Acl497Wfcxl
         KaM1fAFteUmomC7/4Hak+p+yQCOfXU9K8s0w/8IA=
Date:   Tue, 12 Sep 2023 13:31:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bryan Jennings <bryjen423@gmail.com>
Cc:     Lang.Yu@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        olvaffe@gmail.com, sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 13/22] drm/amdgpu: install stub fence into
 potential unused fence pointers
Message-ID: <2023091221-reminder-joylessly-8181@gregkh>
References: <2023083119-phoney-ascend-d4ec@gregkh>
 <d32d6919-47cf-4ddc-955a-0759088220ae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d32d6919-47cf-4ddc-955a-0759088220ae@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 03:43:01PM -0500, Bryan Jennings wrote:
> This is also causing log spam on 5.15.  It was included in 5.15.128 as
> commit 4921792e04f2125b5eadef9dbe9417a8354c7eff.  I encountered this and
> found https://gitlab.freedesktop.org/drm/amd/-/issues/2820 while researching
> the problem.

Now reverted, thanks.

greg k-h
