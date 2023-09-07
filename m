Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175B87976AD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjIGQOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbjIGQOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:14:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB50B4691
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:48:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75840C433D9;
        Thu,  7 Sep 2023 06:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694069521;
        bh=DbVPF3fDuw+/fHxkvTKzad9h+IArdS9JFe7ZDMm1wRs=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=I3CaSgdX+UXuLoTXrYqF74CfiYpT3dwsti35q8kBkQRaXW9ykJtq8eDKFYRguPgsD
         O+FuJc6uRm+FEgpRbwt/cdx4mgd2vMerRWmhSJP4+7EqiRJ5YWsa5bc8RCA5nFdPrq
         /4jcmzcSy5xLdfTXLykPw3nAW3n5sXJ/wM8dnLcPqr+ujrSHc5JVuvvLq0RB22wzOz
         tjK2W8UdB4yXSspV1zN3YSf/h3bUucnw88Vte8V9LXEohvRd+jFss8dmCvp7SQ9Dxp
         nYt3WkuAIvmWNu4kMf/d4YdtKQOtHaxCSlD9OOzlTnx0uH7obJiQO2KfOEmvn7pCmN
         86ncDuPDk6ojA==
Message-ID: <040b316aae533abac3d3fa9c1eaff3d1.mripard@kernel.org>
Date:   Thu, 07 Sep 2023 06:51:59 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Jim Cromie" <jim.cromie@gmail.com>
Subject: Re: [PATCH v3 4/5] drm/vc4: add trailing newlines to drm_dbg msgs
In-Reply-To: <20230906190224.583577-5-jim.cromie@gmail.com>
References: <20230906190224.583577-5-jim.cromie@gmail.com>
Cc:     amd-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, jani.nikula@intel.com,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, ville.syrjala@linux.intel.com,
        "David Airlie" <airlied@gmail.com>,
        "Emma Anholt" <emma@anholt.net>,
        "Maxime Ripard" <mripard@kernel.org>
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

On Wed, 6 Sep 2023 13:02:22 -0600, Jim Cromie wrote:
> By at least strong convention, a print-buffer's trailing newline says
> "message complete, send it".  The exception (no TNL, followed by a call
> to pr_cont) proves the general rule.
> 
> Most DRM.debug calls already comport with this: 207 DRM_DEV_DEBUG,
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
